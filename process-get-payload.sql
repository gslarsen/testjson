-----------MAIN PROCEDURE PROCESSING JSON FROM GET CALL-----------------

create or replace PROCEDURE process_json_response (xml_ CLOB, app_msg_id_ VARCHAR2) 
IS
-- variables to process payload
x_CLOB  CLOB;
bo_doc  CLOB;

-- variables to process estimate
x_info_         VARCHAR2(250);
x_objid_        ROWID;
x_objversion_   VARCHAR2(250);
x_attr          VARCHAR2(250);
x_action_       VARCHAR2(250);
x_activity_seq  NUMBER;
counter         NUMBER;

BEGIN
-- populate temp table with payload
x_CLOB := xml_;
bo_doc := xml_;

    -- populate json_payload table
    INSERT INTO json_payload
        VALUES (
            app_msg_id_,
            SYSTIMESTAMP,
            bo_doc
        );
  
/*   PROCESS ESTIMATE   */
    
 -- populate temp table pws_eval_estimate
INSERT INTO pws_eval_estimate(ACTIVITY_SEQ, PROJECT_COST_ELEMENT, ESTIMATED)
select ACTIVITY_SEQ, PROJECT_COST_ELEMENT, ESTIMATED from (with t as (  
    select HOURS, LABOR, MATERIAL, t2.activity_seq from (SELECT jt1.*
    FROM json_payload,
    JSON_TABLE(bo_doc, '$[*]'
    COLUMNS  (
             short_name VARCHAR2(50) PATH '$.shortName',
             hours NUMBER PATH '$.hours',
             labor NUMBER PATH '$.labor',
             material NUMBER PATH '$.material'))
    AS jt1) t1
    join (select activity_seq, short_name from activity_tab) t2
    on t1.short_name = t2.short_name
)
select * from t
unpivot include nulls (
  estimated
    for project_cost_element in ("HOURS", "LABOR", "MATERIAL" )
));
        
--DBMS_SESSION.RESET_PACKAGE; --REMOVE 
     x_action_ := 'DO';
     counter := 1; --REMOVE
     
     -- remove old estimate
     
        FOR rec IN (select * from pws_eval_estimate)
            LOOP
                BEGIN
                    x_activity_seq := rec.activity_seq;
                    select OBJID into x_objid_ from ACTIVITY_ESTIMATE_MAIN where ACTIVITY_SEQ = x_activity_seq and project_cost_element = rec.project_cost_element;
                    select OBJVERSION into x_objversion_ from ACTIVITY_ESTIMATE_MAIN where ACTIVITY_SEQ = x_activity_seq and project_cost_element = rec.project_cost_element;
                    
                    ACTIVITY_ESTIMATE_API.Remove__(x_info_, x_objid_, x_objversion_, x_action_);
                    EXCEPTION
                        WHEN NO_DATA_FOUND THEN
                        -- Nothing to Remove, add new estimate
                        DBMS_OUTPUT.PUT_LINE('Nothing Remaining to Remove');
                        
                        WHEN OTHERS THEN
                        DBMS_OUTPUT.PUT_LINE(SQLCODE||': '|| SQLERRM);
                END;
            END LOOP;
     
     -- ADD ESTIMATE           
     FOR rec IN (select * from pws_eval_estimate)
        LOOP
            BEGIN
                dbms_output.put_line(counter || ': ' || rec.activity_seq || ' ' || rec.project_cost_element || ' ' || rec.estimated); --REMOVE
                counter := counter + 1; --REMOVE
                
                -- add new estimate
                x_objid_ := null;
                x_objversion_ := null;
                x_activity_seq := rec.activity_seq;
               
                IF 
                    (rec.project_cost_element = 'HOURS')
                THEN
                    Client_SYS.Clear_Attr(x_attr);
                    Client_SYS.Add_To_Attr('ACTIVITY_SEQ', x_activity_seq, x_attr);
                    Client_SYS.Add_To_Attr('PROJECT_COST_ELEMENT', 'LABOR', x_attr);
                    Client_SYS.Add_To_Attr('ESTIMATED_HOURS', rec.estimated, x_attr);
                    
                    ACTIVITY_ESTIMATE_API.NEW__(x_info_, x_objid_, x_objversion_, x_attr, x_action_ );
                ELSIF
                    (rec.project_cost_element = 'LABOR')
                    THEN
                    select OBJID into x_objid_ from ACTIVITY_ESTIMATE_MAIN where ACTIVITY_SEQ = x_activity_seq;
                    select OBJVERSION into x_objversion_ from ACTIVITY_ESTIMATE_MAIN where ACTIVITY_SEQ = x_activity_seq;
                    
                    Client_SYS.Clear_Attr(x_attr);
                    Client_SYS.Add_To_Attr('ESTIMATED', rec.estimated, x_attr);
                    
                    ACTIVITY_ESTIMATE_API.MODIFY__(x_info_, x_objid_, x_objversion_, x_attr, x_action_ );
                ELSE
                    Client_SYS.Clear_Attr(x_attr);
                    Client_SYS.Add_To_Attr('ACTIVITY_SEQ', x_activity_seq, x_attr);
                    Client_SYS.Add_To_Attr('PROJECT_COST_ELEMENT', rec.project_cost_element, x_attr);
                    Client_SYS.Add_To_Attr('ESTIMATED', rec.estimated, x_attr);
                    
                    ACTIVITY_ESTIMATE_API.NEW__(x_info_, x_objid_, x_objversion_, x_attr, x_action_ );
                END IF;
                
                EXCEPTION
        
                    WHEN OTHERS THEN 
                    DBMS_OUTPUT.PUT_LINE(SQLCODE||': '|| SQLERRM);
                
            END;
                
        END LOOP;
     COMMIT;
END process_json_response;

-------------------------------------------------
-------------------------------------------------
-------------------------------------------------
-- CODE FOR CUSTOM MENU ITEM --
DECLARE

x_project_id  VARCHAR2(250);
x_business_oppy_no  VARCHAR2(250);
x_subject VARCHAR2(250);
x_url  PLSQLAP_DOCUMENT_API.Document;
query_params  Plsqlap_Document_API.Document;
headers VARCHAR(150);
b_xml CLOB;

BEGIN
x_project_id := &project_id;
b_xml :=   '<Content>' ||
                  '<project_id>' || x_project_id ||'</project_id>' ||
            '</Content>';
       
headers := 'Content-Type: application/xml, Accept: application/json' || 'ProjectId: ' || x_project_id;

x_business_oppy_no := Project_Cfp.Get_Cf$_Opportunity_No(&project_id);
x_subject := 'Opp # ' ||  x_business_oppy_no || ' Proj # ' || x_project_id;

x_url := PLSQLAP_DOCUMENT_API.New_Document('url_params');
PLSQLAP_DOCUMENT_API.Add_Attribute(x_url, 'parameter1', 'activities');

--query_params := PLSQLAP_DOCUMENT_API.New_Document('QUERY_PARAMETERS');
--PLSQLAP_DOCUMENT_API.Add_Attribute(query_params,'value1', 'abc');
--PLSQLAP_DOCUMENT_API.Add_Attribute(query_params,'value2', 'xyz');


plsql_rest_sender_API.Call_Rest_EndPoint2(rest_service_ => 'eVal',
                                         xml_ => b_xml,
                                         url_params_ => x_url,
                                         callback_func_ => 'process_json_response',
                                         http_method_ => 'GET',
                                         http_req_headers_ => headers,
                                         subject_ => x_subject);

END;

--------------------------------------------------------------
-- GLOBAL TEMP TABLES ----

-- create temp table to hold JSON
CREATE GLOBAL TEMPORARY TABLE json_payload
    (
        id varchar(100) NOT NULL,
        date_loaded TIMESTAMP(6) WITH TIME ZONE,
        bo_document CLOB CONSTRAINT test_json CHECK (bo_document IS JSON)
    ) ON COMMIT DELETE ROWS;

-- create temp table to hold estimate for processing
CREATE GLOBAL TEMPORARY TABLE pws_eval_estimate
    (
        activity_seq NUMBER NOT NULL,
        project_cost_element VARCHAR2(100 CHAR) NOT NULL,
        estimated NUMBER
    ) ON COMMIT DELETE ROWS;

---------------------------------------------------------------------
-- WORKING QUERIES, ETC. --

-- regex match the first part of the message text until the first 'X' - NEEDED BECAUSE HEADERS WERE INCLUDED IN INITIAL TEST JSON SITE
begin
dbms_output.put_line(chr(10) || '************************FINAL************************' || chr(10) || REGEXP_SUBSTR('200#83#{"PONumber"             : 1600,
      "Reference"            : "ABULL-20140421",
      "Requestor"            : "Alexis Bull",
      "User"                 : "ABULL",
      "CostCenter"           : "A50",
      "ShippingInstructions" : {"name"   : "Alexis Bull",
                                "Address": {"street"  : "200 Sporting Green",
                                            "city"    : "South San Francisco",
                                            "state"   : "CA",
                                            "zipCode" : 99236,
                                            "country" : "United States of America"},
                                "Phone" : [{"type" : "Office", "number" : "909-555-7307"},
                                           {"type" : "Mobile", "number" : "415-555-1234"}]},
      "Special Instructions" : null,
      "AllowPartialShipment" : true,
      "LineItems"            : [{"ItemNumber" : 1,
                                 "Part"       : {"Description" : "One Magic Christmas",
                                                 "UnitPrice"   : 19.95,
                                                 "UPCCode"     : 13131092899},
                                 "Quantity"   : 9.0},
                                {"ItemNumber" : 2,
                                 "Part"       : {"Description" : "Lethal Weapon",
                                                 "UnitPrice"   : 19.95,
                                                 "UPCCode"     : 85391628927},
                                 "Quantity"   : 5.0}]}
                                 X-Ratelimit-Remaining:999
X-Content-Type-Options:nosniff
Connection:keep-alive
Pragma:no-cache
Date:Wed, 06 Jan 2021 19:43:27 GMT
Via:1.1 vegur
X-Ratelimit-Reset:1608387908
Accept-Ranges:bytes
X-Ratelimit-Limit:1000
CF-Cache-Status:HIT
Cache-Control:max-age=43200
Etag:W/"53-hfEnumeNh6YirfjyjaujcOPPT+s"
NEL:{"report_to":"cf-nel","max_age":604800}
Access-Control-Allow-Credentials:true
Report-To:{"endpoints":[{"url":"https:\/\/a.nel.cloudflare.com\/report?s=T6ZP%2Fxrqn4tyL3qNEcD0Fmi4MiqYMTW19FBNsKuCfNTILL%2Fet2%2FEUAUeUscHjghgFSPyNd20V57%2BbYQqRrZjoR29RN1CdH0QsfmJo4xl1S57U1wvPmY%2B%2Bo5wcQAC"}],"group":"cf-nel","max_age":604800}
Set-Cookie:__cfduid=db46497927faf16f585cf7efcf676ecbe1609962207; expires=Fri, 05-Feb-21 19:43:27 GMT; path=/; domain=.typicode.com; HttpOnly; SameSite=Lax
Vary:Origin, Accept-Encoding
Expires:-1
Content-Length:83
Age:27207
Content-Type:application/json; charset=utf-8
X-Powered-By:Express
cf-request-id:077ad2d02a000015d33a839000000001
Expect-CT:max-age=604800, report-uri="https://report-uri.cloudflare.com/cdn-cgi/beacon/expect-ct', '{([^X]*)}'));
end;

-- Get project_id from business_opportunity_line
select 
opportunity_no, revision_no, line_no, description, date_entered, wanted_delivery_date, sale_unit_price, 
con_object_type reference_type, con_object_ref1 project_id
from BUSINESS_OPPORTUNITY_LINE 
where con_object_type = 'Project' and opportunity_no = 2317
order by con_object_ref1 desc;

-- Get project
select * 
from project 
where project_id = '102077';

--Activity
select * 
from activity_tab
where project_id = '101983' -- '101983' '102077'
order by sub_project_id, activity_no desc;

--Activity Estimate
select * 
from activity_estimate_tab
where activity_seq = '100098890'; -- replace '100098890' '100094482'


--Activity Element
select *
from activity_element_tab
where activity_seq = '100098890'; -- replace '100098890' '100094482'

select *
from project_connection_temp_tab -- USED TO UNION WITH ACTIVITY_ELEMENT_TAB FOR ACTIVITY_ELEMENT_SUM VIEW
where activity_seq = '100098890'; -- replace '100098890' '100094482'

SELECT * 
FROM ACTIVITY_ELEMENT_SUM -- UI VIEW FOR COST TAB ON ACTIVITY
WHERE ACTIVITY_SEQ = '100098890';

SELECT * 
FROM ACTIVITY_ELEMENT -- VIEW THAT CORRESPONDS WITH _TAB ABOVE
WHERE ACTIVITY_SEQ = '100098890';

SELECT * 
FROM ACTIVITY_ELEMENT_HISTORY -- VIEW THAT CORRESPONDS WITH _TAB
WHERE ACTIVITY_SEQ = '100098890';







-- regex match the first part of the message text until the first 'X'
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


-- set up temp table with text file message CLOB
create table testing2 (
text varchar2(3000));

insert into testing2 values ( '200#83#{"PONumber"             : 1600,
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
Expect-CT:max-age=604800, report-uri="https://report-uri.cloudflare.com/cdn-cgi/beacon/expect-ct' );


-- NEW TEST
declare 

text clob;

begin

select text into text from testing3;
DBMS_OUTPUT.PUT_LINE(chr(10) || '************************FINAL************************' || chr(10) || REGEXP_SUBSTR(regexp_replace(text, '(X-Ratelimit-Remaining:999)', '~'), '{([^~]*)}' ));
end;

----------------------------------------------------------------------------------
-- WITH ACTUAL FILE --
set serveroutput on;

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

-- create test table to modify
CREATE TABLE test_table
    (
        message_id varchar2(100),
        user_id varchar2(20),
        id  varchar2(20),
        title varchar2(100),
        completed varchar2(10)
    );

-- insert some temp data into test_table
INSERT INTO test_table
    VALUES (
        SYSTIMESTAMP,
        1,
        1,
        NULL,
        NULL
    );


/*

    BEGIN SCRIPT

*/
create or replace PROCEDURE process_json_response (xml_ CLOB, app_msg_id_ VARCHAR2) 
IS

x_CLOB  CLOB;
bo_doc  CLOB;

BEGIN
x_CLOB := xml_;

-- grab JSON payload (no response headers)
    bo_doc := REGEXP_SUBSTR(regexp_replace(x_CLOB, '(X-Ratelimit-Remaining:999)', '~'), '{([^~]*)}');

    -- populate json_payload table
    INSERT INTO json_payload
        VALUES (
            app_msg_id_,
            SYSTIMESTAMP,
            bo_doc
        );

    -- insert new record into test_table
    INSERT INTO test_table
    VALUES(
         app_msg_id_,
         null,
         null,
         null,
         null
    );

    UPDATE test_table
    SET title = (SELECT  jt.title
        FROM JSON_PAYLOAD,
        JSON_TABLE(bo_document, '$'
        COLUMNS (
                title VARCHAR2(100) PATH '$.title',
                completed VARCHAR2(100) PATH '$.completed'
                ))
        AS jt
        WHERE json_payload.id = app_msg_id_
    )
where message_id = app_msg_id_;
commit;    
END process_json_response;



-- to see the contents of BLOB
select utl_raw.cast_to_varchar2(dbms_lob.substr(MESSAGE_VALUE)) from fndcn_message_body_tab where application_message_id = '1044230'




/**************************************************************************/


-- To insert new activity - DAN GARDNER said in 1/20/21 call that this was already set up (i.e. project_id.subproject_id.activity_no)
    INSERT INTO activity_tab
    VALUES(
        ACTIVITY_SEQ.nextval,
        '102077',
        'TEST',
        'TEST',
        '^TEST^TEST^',
        null,
        'test activity desc',
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        sysdate,
        sysdate,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        '102077.TEST.TEST',
        null,
        null,
        null,
        'CONSUMPTION_BASED',
        'ESTIMATED_COST',
        null,
        null,
        null,
        sysdate,
        null,
        null,
        null,
        null,
        'TRUE',
        null,
        null,
        null,
        null,
        null,
        null,
        'FALSE',
        null,
        null,
        null,
        null,
        'INCLUDE',
        'FALSE',
        'FALSE',
        null,
        sysdate,
        null,
        'Planned',
        null,
        null,
        null,
        null,
        'FALSE'
    );

-- insert new estimate on an activity
INSERT INTO activity_estimate_tab
    VALUES(
        '100098890', -- need to get this from calling event
        'LABOR', -- cost el.
        10000,
        null,
        'POWE1APP',
        sysdate,
        null,
        null,
        null,
        null,
        sysdate,
        null   
    );

-- insert cost element for cost tab
INSERT INTO activity_element_tab
    VALUES (
           '100098890',
           'LABOR', -- cost el.
           'USD',
           '102077',
           null,
           null,
           null,
           null,
           null, 
           '10001',
           '10001',
           null,
           null,
           null,
           null, 
           null,
           '10001',
           '10001',
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null, 
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null, 
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null, 
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           sysdate,
           null
)


--DELETE ROWS FROM ESTIMATE AND ELEMENT
delete 
from activity_estimate_tab
where activity_seq = '100098890'; -- replace

delete 
from activity_element_tab
where activity_seq = '100098890'; -- replace


-- UI procedure when adding a new estimate and cost element to activity
DECLARE
x_info_       VARCHAR2(250);
x_objid_      VARCHAR2(250);
x_objversion_ VARCHAR2(250);
x_attr VARCHAR2(250);
x_method VARCHAR2(250);

BEGIN 
-- This following showed on the 'Cost' tab
Client_SYS.Clear_Attr(x_attr);
Client_SYS.Add_To_Attr('ACTIVITY_SEQ', '100098890', x_attr);
Client_SYS.Add_To_Attr('PROJECT_COST_ELEMENT', 'LABOR', x_attr);
Client_SYS.Add_To_Attr('ESTIMATED', 10001, x_attr);
x_method := 'DO';

ACTIVITY_ESTIMATE_API.NEW__(x_info_, x_objid_, x_objversion_, x_attr, x_method ); 

-- unclear on if/why req'd - investigate
Client_SYS.Clear_Attr(x_attr);
Client_SYS.Add_To_Attr('ACTIVITY_SEQ', '100098890', x_attr);
Client_SYS.Add_To_Attr('CONTROL_CATEGORY', 'LABOR', x_attr);

ACTIVITY_ELEMENT_API.NEW__(x_info_, x_objid_, x_objversion_, x_attr, x_method ); 
commit;

EXCEPTION 
WHEN Error_SYS.Err_Security_Checkpoint THEN 
raise; 
WHEN OTHERS THEN 
rollback; 
raise; 

END;


"SELECT activity_seq                             activity_seq,
       project_cost_element                     project_cost_element,
       -- Other attributes
       project_id                               project_id,
       -- Manual Progress
       DECODE(SUM(manual_progress_cost)         ,0 ,TO_NUMBER(NULL) ,SUM(manual_progress_cost))                manual_progress_cost,
       DECODE(SUM(manual_progress_hours)        ,0 ,TO_NUMBER(NULL) ,SUM(manual_progress_hours))               manual_progress_hours,
       DECODE(SUM(manual_progress_total)        ,0 ,TO_NUMBER(NULL) ,SUM(manual_progress_total))               manual_progress_total,
       -- Baseline
       DECODE(SUM(baseline)                     ,0 ,TO_NUMBER(NULL) ,SUM(baseline))                            baseline,
       DECODE(SUM(baseline_hours)               ,0 ,TO_NUMBER(NULL) ,SUM(baseline_hours))                      baseline_hours,
       -- Cost Base Currency
       DECODE(SUM(estimated_cost_base)          ,0 ,TO_NUMBER(NULL) ,SUM(estimated_cost_base))                 estimated,
       DECODE(SUM(planned_cost_base)            ,0 ,TO_NUMBER(NULL) ,SUM(planned_cost_base))                   planned,
       DECODE(SUM(planned_committed_base)       ,0 ,TO_NUMBER(NULL) ,SUM(planned_committed_base))              planned_committed,
       DECODE(SUM(committed_cost_base)          ,0 ,TO_NUMBER(NULL) ,SUM(committed_cost_base))                 committed,
       DECODE(SUM(used_cost_base)               ,0 ,TO_NUMBER(NULL) ,SUM(used_cost_base))                      used,
       DECODE(SUM(actual_cost_base)             ,0 ,TO_NUMBER(NULL) ,SUM(actual_cost_base))                    actual,
       -- Cost Transaction Currency
       DECODE(SUM(estimated_cost_trans)         ,0 ,TO_NUMBER(NULL) ,SUM(estimated_cost_trans))                estimated_cost_trans,
       DECODE(SUM(planned_cost_trans)           ,0 ,TO_NUMBER(NULL) ,SUM(planned_cost_trans))                  planned_cost_trans,
       DECODE(SUM(planned_committed_trans)      ,0 ,TO_NUMBER(NULL) ,SUM(planned_committed_trans))             planned_committed_trans,
       DECODE(SUM(committed_cost_trans)         ,0 ,TO_NUMBER(NULL) ,SUM(committed_cost_trans))                committed_cost_trans,
       DECODE(SUM(used_cost_trans)              ,0 ,TO_NUMBER(NULL) ,SUM(used_cost_trans))                     used_cost_trans,
       DECODE(SUM(actual_cost_trans)            ,0 ,TO_NUMBER(NULL) ,SUM(actual_cost_trans))                   actual_cost_trans,
       -- Cost Project Currency
       DECODE(SUM(estimated_cost_project)       ,0 ,TO_NUMBER(NULL) ,SUM(estimated_cost_project))              estimated_cost_project,
       DECODE(SUM(planned_cost_project)         ,0 ,TO_NUMBER(NULL) ,SUM(planned_cost_project))                planned_cost_project,
       DECODE(SUM(planned_committed_project)    ,0 ,TO_NUMBER(NULL) ,SUM(planned_committed_project))           planned_committed_project,
       DECODE(SUM(committed_cost_project)       ,0 ,TO_NUMBER(NULL) ,SUM(committed_cost_project))              committed_cost_project,
       DECODE(SUM(used_cost_project)            ,0 ,TO_NUMBER(NULL) ,SUM(used_cost_project))                   used_cost_project,
       DECODE(SUM(actual_cost_project)          ,0 ,TO_NUMBER(NULL) ,SUM(actual_cost_project))                 actual_cost_project,
       -- Cost Budget Currency
       DECODE(SUM(estimated_cost_budget)        ,0 ,TO_NUMBER(NULL) ,SUM(estimated_cost_budget))               estimated_cost_budget,
       DECODE(SUM(planned_cost_budget)          ,0 ,TO_NUMBER(NULL) ,SUM(planned_cost_budget))                 planned_cost_budget,
       DECODE(SUM(planned_committed_budget)     ,0 ,TO_NUMBER(NULL) ,SUM(planned_committed_budget))            planned_committed_budget,
       DECODE(SUM(committed_cost_budget)        ,0 ,TO_NUMBER(NULL) ,SUM(committed_cost_budget))               committed_cost_budget,
       DECODE(SUM(used_cost_budget)             ,0 ,TO_NUMBER(NULL) ,SUM(used_cost_budget))                    used_cost_budget,
       DECODE(SUM(actual_cost_budget)           ,0 ,TO_NUMBER(NULL) ,SUM(actual_cost_budget))                  actual_cost_budget,
       -- Hours
       DECODE(SUM(estimated_hours)              ,0 ,TO_NUMBER(NULL) ,SUM(estimated_hours))                     estimated_hours,
       DECODE(SUM(planned_hours)                ,0 ,TO_NUMBER(NULL) ,SUM(planned_hours))                       planned_hours,
       DECODE(SUM(planned_committed_hours)      ,0 ,TO_NUMBER(NULL) ,SUM(planned_committed_hours))             planned_committed_hours,
       DECODE(SUM(committed_hours)              ,0 ,TO_NUMBER(NULL) ,SUM(committed_hours))                     committed_hours,
       DECODE(SUM(actual_hours)                 ,0 ,TO_NUMBER(NULL) ,SUM(actual_hours))                        actual_hours,
       -- Revenue Base Currency
       DECODE(SUM(estimated_revenue_base)       ,0 ,TO_NUMBER(NULL) ,SUM(estimated_revenue_base))              estimated_revenue,
       DECODE(SUM(planned_revenue_base)         ,0 ,TO_NUMBER(NULL) ,SUM(planned_revenue_base))                planned_revenue,
       DECODE(SUM(preliminary_revenue_base)     ,0 ,TO_NUMBER(NULL) ,SUM(preliminary_revenue_base))            preliminary_revenue,
       DECODE(SUM(posted_revenue_base)          ,0 ,TO_NUMBER(NULL) ,SUM(posted_revenue_base))                 posted_revenue,
       DECODE(SUM(actual_revenue_base)          ,0 ,TO_NUMBER(NULL) ,SUM(actual_revenue_base))                 actual_revenue,
       -- Revenue Transaction Currency
       DECODE(SUM(estimated_revenue_trans)      ,0 ,TO_NUMBER(NULL) ,SUM(estimated_revenue_trans))             estimated_revenue_trans,
       DECODE(SUM(planned_revenue_trans)        ,0 ,TO_NUMBER(NULL) ,SUM(planned_revenue_trans))               planned_revenue_trans,
       DECODE(SUM(preliminary_revenue_trans)    ,0 ,TO_NUMBER(NULL) ,SUM(preliminary_revenue_trans))           preliminary_revenue_trans,
       DECODE(SUM(posted_revenue_trans)         ,0 ,TO_NUMBER(NULL) ,SUM(posted_revenue_trans))                posted_revenue_trans,
       DECODE(SUM(actual_revenue_trans)         ,0 ,TO_NUMBER(NULL) ,SUM(actual_revenue_trans))                actual_revenue_trans,
       -- Revenue Project Currency
       DECODE(SUM(estimated_revenue_project)    ,0 ,TO_NUMBER(NULL) ,SUM(estimated_revenue_project))           estimated_revenue_project,
       DECODE(SUM(planned_revenue_project)      ,0 ,TO_NUMBER(NULL) ,SUM(planned_revenue_project))             planned_revenue_project,
       DECODE(SUM(preliminary_revenue_project)  ,0 ,TO_NUMBER(NULL) ,SUM(preliminary_revenue_project))         preliminary_rev_project,
       DECODE(SUM(posted_revenue_project)       ,0 ,TO_NUMBER(NULL) ,SUM(posted_revenue_project))              posted_revenue_project,
       DECODE(SUM(actual_revenue_project)       ,0 ,TO_NUMBER(NULL) ,SUM(actual_revenue_project))              actual_revenue_project,
       -- Revenue Budget Currency
       DECODE(SUM(estimated_revenue_budget)     ,0 ,TO_NUMBER(NULL) ,SUM(estimated_revenue_budget))            estimated_revenue_budget,
       DECODE(SUM(planned_revenue_budget)       ,0 ,TO_NUMBER(NULL) ,SUM(planned_revenue_budget))              planned_revenue_budget,
       DECODE(SUM(preliminary_revenue_budget)   ,0 ,TO_NUMBER(NULL) ,SUM(preliminary_revenue_budget))          preliminary_rev_budget,
       DECODE(SUM(posted_revenue_budget)        ,0 ,TO_NUMBER(NULL) ,SUM(posted_revenue_budget))               posted_revenue_budget,
       DECODE(SUM(actual_revenue_budget)        ,0 ,TO_NUMBER(NULL) ,SUM(actual_revenue_budget))               actual_revenue_budget,
       -- Earned Value
       DECODE(SUM(ev_cost_calculated)           ,0 ,TO_NUMBER(NULL) ,SUM(ev_cost_calculated))                  ev_cost_calculated,
       DECODE(SUM(ev_cost_direct)               ,0 ,TO_NUMBER(NULL) ,SUM(ev_cost_direct))                      ev_cost_direct,
       DECODE(SUM(ev_hours_calculated)          ,0 ,TO_NUMBER(NULL) ,SUM(ev_hours_calculated))                 ev_hours_calculated,
       DECODE(SUM(ev_hours_direct)              ,0 ,TO_NUMBER(NULL) ,SUM(ev_hours_direct))                     ev_hours_direct,
       -- F1 columns
       NVL(MAX(a_objid),      MAX(p_objid))                                                                    objid,
       NVL(MAX(a_objversion), MAX(p_objversion))                                                               objversion,
       NVL(MAX(a_objkey),     MAX(p_objkey))                                                                   objkey
FROM   (SELECT activity_seq                       activity_seq,
          project_cost_element               project_cost_element,
          -- Other attributes
          project_id                         project_id,
          NULL                               manual_progress_cost,
          NULL                               manual_progress_hours,
          NULL                               manual_progress_total,
          NULL                               baseline,
          NULL                               baseline_hours,
          -- Cost Base Currency Change
          SUM(estimated_cost_base_chg)       estimated_cost_base,  -- used when manually populating activity estimate tab
          SUM(planned_cost_base_chg)         planned_cost_base,  -- used when manually populating activity estimate tab
          SUM(planned_commit_base_chg)       planned_committed_base,  
          SUM(committed_cost_base_chg)       committed_cost_base,
          SUM(used_cost_base_chg)            used_cost_base,
          SUM(actual_cost_base_chg)          actual_cost_base,
          -- Cost Transaction Currency Change
          SUM(estimated_cost_trans_chg)      estimated_cost_trans,  -- used when manually populating activity estimate tab
          SUM(planned_cost_trans_chg)        planned_cost_trans,  -- used when manually populating activity estimate tab
          SUM(planned_commit_trans_chg)      planned_committed_trans,
          SUM(committed_cost_trans_chg)      committed_cost_trans,
          SUM(used_cost_trans_chg)           used_cost_trans,
          SUM(actual_cost_trans_chg)         actual_cost_trans,
          -- Cost Project Currency Change
          SUM(estimated_cost_project_chg)    estimated_cost_project,
          SUM(planned_cost_project_chg)      planned_cost_project,
          SUM(planned_commit_project_chg)    planned_committed_project,
          SUM(committed_cost_project_chg)    committed_cost_project,
          SUM(used_cost_project_chg)         used_cost_project,
          SUM(actual_cost_project_chg)       actual_cost_project,
          -- Cost Budget Currency Change
          SUM(estimated_cost_budget_chg)     estimated_cost_budget,
          SUM(planned_cost_budget_chg)       planned_cost_budget,
          SUM(planned_commit_budget_chg)     planned_committed_budget,
          SUM(committed_cost_budget_chg)     committed_cost_budget,
          SUM(used_cost_budget_chg)          used_cost_budget,
          SUM(actual_cost_budget_chg)        actual_cost_budget,
          -- Hours Change
          SUM(estimated_hours_chg)           estimated_hours,
          SUM(planned_hours_chg)             planned_hours,
          SUM(planned_commit_hours_chg)      planned_committed_hours,
          SUM(committed_hours_chg)           committed_hours,
          SUM(actual_hours_chg)              actual_hours,
          -- Revenue Base Currency Change
          SUM(estimated_rev_base_chg)        estimated_revenue_base,
          SUM(planned_rev_base_chg)          planned_revenue_base,
          SUM(preliminary_rev_base_chg)      preliminary_revenue_base,
          SUM(posted_rev_base_chg)           posted_revenue_base,
          SUM(actual_rev_base_chg)           actual_revenue_base,
          -- Revenue Transaction Currency Change
          SUM(estimated_rev_trans_chg)       estimated_revenue_trans,
          SUM(planned_rev_trans_chg)         planned_revenue_trans,
          SUM(preliminary_rev_trans_chg)     preliminary_revenue_trans,
          SUM(posted_rev_trans_chg)          posted_revenue_trans,
          SUM(actual_rev_trans_chg)          actual_revenue_trans,
          -- Revenue Project Currency Change
          SUM(estimated_rev_project_chg)     estimated_revenue_project,
          SUM(planned_rev_project_chg)       planned_revenue_project,
          SUM(prel_rev_project_chg)          preliminary_revenue_project,
          SUM(posted_rev_project_chg)        posted_revenue_project,
          SUM(actual_rev_project_chg)        actual_revenue_project,
          -- Revenue Budget Currency Change
          SUM(estimated_rev_budget_chg)      estimated_revenue_budget,
          SUM(planned_rev_budget_chg)        planned_revenue_budget,
          SUM(prel_rev_budget_chg)           preliminary_revenue_budget,
          SUM(posted_rev_budget_chg)         posted_revenue_budget,
          SUM(actual_rev_budget_chg)         actual_revenue_budget,
          -- Earned Value
          SUM(ev_cost_calculated_chg)        ev_cost_calculated,
          SUM(ev_cost_direct_chg)            ev_cost_direct,
          SUM(ev_hours_calculated_chg)       ev_hours_calculated,
          SUM(ev_hours_direct_chg)           ev_hours_direct,
          -- F1 columns
          MAX(rowid)                         p_objid,
          to_char(MAX(rowversion), 'YYYYMMDDHH24MISS') p_objversion,
          MAX(rowkey)                        p_objkey,
          null                               a_objid,
          null                               a_objversion,
          null                               a_objkey
   FROM project_connection_temp_tab
   GROUP BY activity_seq, project_cost_element, project_id
   UNION ALL
   SELECT  activity_seq                   activity_seq,
           project_cost_element           project_cost_element,
           project_id                     project_id,
           manual_progress_cost           manual_progress_cost,
           manual_progress_hours          manual_progress_hours,
           manual_progress_total          manual_progress_total,
           baseline                       baseline,
           baseline_hours                 baseline_hours,
           estimated_cost_base            estimated_cost_base, -- USE
           planned_cost_base              planned_cost_base,  -- USE
           planned_committed_base         planned_committed_base,
           committed_cost_base            committed_cost_base,
           used_cost_base                 used_cost_base,
           actual_cost_base               actual_cost_base,
           estimated_cost_project         estimated_cost_project,  -- USE
           planned_cost_project           planned_cost_project,  -- USE
           planned_committed_project      planned_committed_project,
           committed_cost_project         committed_cost_project,
           used_cost_project              used_cost_project,
           actual_cost_project            actual_cost_project,
           estimated_cost_trans           estimated_cost_trans,
           planned_cost_trans             planned_cost_trans,
           planned_committed_trans        planned_committed_trans,
           committed_cost_trans           committed_cost_trans,
           used_cost_trans                used_cost_trans,
           actual_cost_trans              actual_cost_trans,
           estimated_cost_budget          estimated_cost_budget,
           planned_cost_budget            planned_cost_budget,
           planned_committed_budget       planned_committed_budget,
           committed_cost_budget          committed_cost_budget,
           used_cost_budget               used_cost_budget,
           actual_cost_budget             actual_cost_budget,
           estimated_hours                estimated_hours,
           planned_hours                  planned_hours,
           planned_committed_hours        planned_committed_hours,
           committed_hours                committed_hours,
           actual_hours                   actual_hours,
           estimated_revenue_base         estimated_revenue_base,
           planned_revenue_base           planned_revenue_base,
           preliminary_revenue_base       preliminary_revenue_base,
           posted_revenue_base            posted_revenue_base,
           actual_revenue_base            actual_revenue_base,
           estimated_revenue_trans        estimated_revenue_trans,
           planned_revenue_trans          planned_revenue_trans,
           preliminary_revenue_trans      preliminary_revenue_trans,
           posted_revenue_trans           posted_revenue_trans,
           actual_revenue_trans           actual_revenue_trans,
           estimated_revenue_project      estimated_revenue_project,
           planned_revenue_project        planned_revenue_project,
           preliminary_rev_project        preliminary_rev_project,
           posted_revenue_project         posted_revenue_project,
           actual_revenue_project         actual_revenue_project,
           estimated_revenue_budget       estimated_revenue_budget,
           planned_revenue_budget         planned_revenue_budget,
           preliminary_rev_budget         preliminary_rev_budget,
           posted_revenue_budget          posted_revenue_budget,
           actual_revenue_budget          actual_revenue_budget,
           ev_cost_calculated             ev_cost_calculated,
           ev_cost_direct                 ev_cost_direct,
           ev_hours_calculated            ev_hours_calculated,
           ev_hours_direct                ev_hours_direct,
           null                           p_objid,
           null                           p_objversion,
           null                           p_objkey,
           rowid                          a_objid,
           to_char(rowversion,'YYYYMMDDHH24MISS') a_objversion,
           rowkey                         a_objkey
   FROM   activity_element_tab)
GROUP BY activity_seq, project_cost_element, project_id
WITH   READ ONLY
"

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


-- UI Activity Cost tab
select OBJID, OBJVERSION, ACTIVITY_SEQ, CONTROL_CATEGORY, COST_ELEMENT_DESCRIPTION, ESTIMATED, PLANNED, BASELINE, EARNED_VALUE, SCHEDULED_WORK, PLANNED_COMMITTED, COMMITTED, USED, ACTUAL, PROGRESS_COST, MANUAL_PROGRESS_TOTAL, MANUAL_PROGRESS_COST 
from ACTIVITY_ELEMENT_SUMMARY_COST 
where ACTIVITY_SEQ = '100094482' and (ESTIMATED >= 0 OR PLANNED != 0 OR BASELINE != 0 OR EARNED_VALUE !=0 OR SCHEDULED_WORK !=0 OR PLANNED_COMMITTED !=0 OR COMMITTED !=0 OR USED !=0 OR ACTUAL != 0 OR MANUAL_PROGRESS_COST !=0 OR MANUAL_PROGRESS_TOTAL !=0) order by CONTROL_CATEGORY


--Activity Cost - DON'T TOUCH - ONLY SHOWS COMPANY, REPORT_COST_CODE (E.G. DI-ADMIN), ACTIVITY_SEQ, VALID_FROM, VALID_TO, INVOICABILITY, ROWVERSION, ROWKEY
select *
from activity_cost_tab
where activity_seq = '100094482'; -- replace '100098890' '100094482'


--DELETE ROW
delete 
from activity_tab
where activity_seq = '100098889'; -- replace

-- to get objid and objversion related to activity_seq for Remove method on activity_estimate_api
select OBJID, OBJVERSION, ACTIVITY_SEQ from ACTIVITY_ESTIMATE_MAIN where ACTIVITY_SEQ = '100098890' 

/************************************

    FETCH FROM eVAL TOOL

***********************************/

-- procedure PROCESS_JSON_RESPONSE
create or replace PROCEDURE process_json_response (xml_ CLOB, app_msg_id_ VARCHAR2) 
IS

x_CLOB  CLOB;
bo_doc  CLOB;

BEGIN
x_CLOB := xml_;

-- grab JSON payload (no response headers)
    bo_doc := REGEXP_SUBSTR(regexp_replace(x_CLOB, '(X-Ratelimit-Remaining:999)', '~'), '{([^~]*)}');

    -- populate json_payload table
    INSERT INTO json_payload
        VALUES (
            app_msg_id_,
            SYSTIMESTAMP,
            bo_doc
        );

    -- insert new record into test_table
    INSERT INTO test_table
    VALUES(
         app_msg_id_,
         null,
         null,
         null,
         null
    );

    UPDATE test_table
    SET title = (SELECT  jt.title
        FROM JSON_PAYLOAD,
        JSON_TABLE(bo_document, '$'
        COLUMNS (
                title VARCHAR2(100) PATH '$.title',
                completed VARCHAR2(100) PATH '$.completed'
                ))
        AS jt
        WHERE json_payload.id = app_msg_id_),
        
        id = (SELECT  jt.id
        FROM JSON_PAYLOAD,
        JSON_TABLE(bo_document, '$'
        COLUMNS (
                title VARCHAR2(100) PATH '$.title',
                id VARCHAR2(100) PATH '$.id'
                ))
        AS jt
        WHERE json_payload.id = app_msg_id_),
        
        user_id = (SELECT  jt.userID
        FROM JSON_PAYLOAD,
        JSON_TABLE(bo_document, '$'
        COLUMNS (
                title VARCHAR2(100) PATH '$.title',
                userId VARCHAR2(100) PATH '$.userId'
                ))
        AS jt
        WHERE json_payload.id = app_msg_id_),
        
        completed = (SELECT  jt.completed
        FROM JSON_PAYLOAD,
        JSON_TABLE(bo_document, '$'
        COLUMNS (
                title VARCHAR2(100) PATH '$.title',
                completed VARCHAR2(100) PATH '$.completed'
                ))
        AS jt
        WHERE json_payload.id = app_msg_id_)
where message_id = app_msg_id_;
commit;    
END process_json_response;

-- remove any old estimate and add new one
DECLARE
x_info_       VARCHAR2(250);
x_objid_      ROWID;
x_objversion_ VARCHAR2(250);
x_attr        VARCHAR2(250);
x_action_     VARCHAR2(250);

BEGIN
    -- remove old estimate
    x_action_ := 'DO';
    select OBJID into x_objid_ from ACTIVITY_ESTIMATE_MAIN where ACTIVITY_SEQ = '100098890';
    select OBJVERSION into x_objversion_ from ACTIVITY_ESTIMATE_MAIN where ACTIVITY_SEQ = '100098890';
    ACTIVITY_ESTIMATE_API.Remove__(x_info_, x_objid_, x_objversion_, x_action_);
    
    -- add new estimate
    x_objid_ := null;
    x_objversion_ := null;
    
    Client_SYS.Clear_Attr(x_attr);
    Client_SYS.Add_To_Attr('ACTIVITY_SEQ', '100098890', x_attr);
    Client_SYS.Add_To_Attr('PROJECT_COST_ELEMENT', 'LABOR', x_attr);
    Client_SYS.Add_To_Attr('ESTIMATED', 1111, x_attr);
    
    ACTIVITY_ESTIMATE_API.NEW__(x_info_, x_objid_, x_objversion_, x_attr, x_action_ );
commit;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
    
    -- add new estimate
    x_objid_ := null;
    x_objversion_ := null;
    
    Client_SYS.Clear_Attr(x_attr);
    Client_SYS.Add_To_Attr('ACTIVITY_SEQ', '100098890', x_attr);
    Client_SYS.Add_To_Attr('PROJECT_COST_ELEMENT', 'LABOR', x_attr);
    Client_SYS.Add_To_Attr('ESTIMATED', 2222, x_attr);
    
    ACTIVITY_ESTIMATE_API.NEW__(x_info_, x_objid_, x_objversion_, x_attr, x_action_ );
    
    -- IS THIS REQ'D?

    --Client_SYS.Clear_Attr(x_attr);
    --Client_SYS.Add_To_Attr('ACTIVITY_SEQ', '100098890', x_attr);
    --Client_SYS.Add_To_Attr('CONTROL_CATEGORY', 'LABOR', x_attr);
    --
    --ACTIVITY_ELEMENT_API.NEW__(x_info_, x_objid_, x_objversion_, x_attr, x_method ); 
    commit;
    
    WHEN OTHERS THEN 
    rollback; 
    raise; 
    
END;


-------------------------------------
-- Project Navigator custom menu item
DECLARE

x_project_id  VARCHAR2(250);
x_business_oppy_no  VARCHAR2(250);
x_subject VARCHAR2(250);
x_url  PLSQLAP_DOCUMENT_API.Document;
query_params  Plsqlap_Document_API.Document;

BEGIN
x_project_id := &project_id;
x_business_oppy_no := '&CF$_OPPORTUNITY_NO';
x_subject := 'Opp # ' ||  x_business_oppy_no || ' Proj # ' || x_project_id;

x_url := PLSQLAP_DOCUMENT_API.New_Document('url_params');
PLSQLAP_DOCUMENT_API.Add_Attribute(x_url, 'parameter1', 'activities');

--query_params := PLSQLAP_DOCUMENT_API.New_Document('QUERY_PARAMETERS');
--PLSQLAP_DOCUMENT_API.Add_Attribute(query_params,'value1', 'abc');
--PLSQLAP_DOCUMENT_API.Add_Attribute(query_params,'value2', 'xyz');


plsql_rest_sender_API.Call_Rest_EndPoint_Empty_Body2(rest_service_ => 'eVal',
                                         url_params_ => x_url,
                                         callback_func_ => 'process_json_response',
                                         http_method_ => 'GET',
                                         http_req_headers_ =>'Content-Type:application/json',
                                         subject_ => x_subject);

END;

-- populate global temp table pws_eval_estimate
INSERT INTO pws_eval_estimate(ACTIVITY_SEQ, PROJECT_COST_ELEMENT, ESTIMATED)
select ACTIVITY_SEQ, PROJECT_COST_ELEMENT, ESTIMATED from (with t as (  
    select HOURS, LABOR, MATERIAL, t2.activity_seq from (SELECT jt1.*
    FROM testing2,
    JSON_TABLE(text, '$[*]'
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




/*   PROCESS ESTIMATE   */
set SERVEROUTPUT ON;
DECLARE
    counter NUMBER;
    -- variables for actual estimate
    x_info_         VARCHAR2(250);
    x_objid_        ROWID;
    x_objversion_   VARCHAR2(250);
    x_attr          VARCHAR2(250);
    x_action_       VARCHAR2(250);
    x_activity_seq  NUMBER;

BEGIN
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
END;

-------------------------------------------------------------------------
----------------------------MAIN PROCEDURE-------------------------------
-------------------------------------------------------------------------
-- PROCESS_JSON_RESPONSE
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
    
 -- populate global temp table pws_eval_estimate
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


-- CODE FOR CUSTOM MENU ITEM
DECLARE

x_project_id  VARCHAR2(250);
x_business_oppy_no  VARCHAR2(250);
x_subject VARCHAR2(250);
x_url  PLSQLAP_DOCUMENT_API.Document;
query_params  Plsqlap_Document_API.Document;

BEGIN
x_project_id := &project_id;
x_business_oppy_no := Project_Cfp.Get_Cf$_Opportunity_No(&project_id);
x_subject := 'Opp # ' ||  x_business_oppy_no || ' Proj # ' || x_project_id;

x_url := PLSQLAP_DOCUMENT_API.New_Document('url_params');
PLSQLAP_DOCUMENT_API.Add_Attribute(x_url, 'parameter1', 'activities');

--query_params := PLSQLAP_DOCUMENT_API.New_Document('QUERY_PARAMETERS');
--PLSQLAP_DOCUMENT_API.Add_Attribute(query_params,'value1', 'abc');
--PLSQLAP_DOCUMENT_API.Add_Attribute(query_params,'value2', 'xyz');


plsql_rest_sender_API.Call_Rest_EndPoint_Empty_Body2(rest_service_ => 'eVal',
                                         url_params_ => x_url,
                                         callback_func_ => 'process_json_response',
                                         http_method_ => 'GET',
                                         http_req_headers_ =>'Content-Type:application/json',
                                         subject_ => x_subject);

END;
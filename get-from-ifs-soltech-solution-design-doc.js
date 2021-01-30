const axios = require("axios");

const opportunityNo = "2317"; // Input #

// replace with ropc/sso info
const instance = axios.create({
  method: "get",
  baseURL:
    "https://powersecure-dev.ifs.cloud:48080/main/ifsapplications/projection/v1/",
  headers: {
    Cookie:
      "IFSSESSIONID48080=lV5KXInss2Lp7fN7CqAYl5wd-694vms-iROz8sosD6FbwQzXuUd_!875361112",
  },
});

// fetch data
instance({
  // permission sets/roles
  url:
    "PermissionSetHandling.svc/Reference_AllGrantedUsers?$filter=(Role eq 'PS_DEV_ENGINEERING_MGR') and SourcePermissionSet eq 'This'",
})
  .then(function (response) {
    let roles = response.data,
      customerId,
      customer,
      opportunity,
      opportunityLines;

    // opportunity & customer data
    const opportunityConfig = {
      url: `BusinessOpportunityHandling.svc/BusinessOpportunities(OpportunityNo='${opportunityNo}')?$select=OpportunityNo,Description,CustomerId,MainRepresentativeId,Status,DateEntered,WantedDeliveryDate,MarketCode`,
    };

    instance(opportunityConfig)
      .then(function (response) {
        opportunity = response.data;
        customerId = opportunity.CustomerId;
        instance({
          // customer address
          url: `BusinessOpportunityHandling.svc/Reference_CustomerInfoAddress(CustomerId='${customerId}',AddressId='MAIN')?$select=Name,City,State`,
        })
          .then(function (response) {
            customer = response.data;
            instance({
              // opportunity line items
              url: `BusinessOpportunityHandling.svc/BusinessOpportunityLines?$filter=OpportunityNo eq '${opportunityNo}'&$select=OpportunityNo,CustomerName,CustomerId,OpportunityDescription,DateEntered,Cf_Bol_Main_Rep,Status,WantedDeliveryDate,LineNo,Description,ConObjectType,ConObjectRef1`,
            })
              .then(function (response) {
                opportunityLines = response.data;
                console.log(
                  "RESULT:\n",
                  JSON.stringify(
                    combineAll(roles, customer, opportunity, opportunityLines) // combine data into one obj and process as req'd
                  )
                );
              })
              .catch(function (error) {
                console.log(error);
              });
          })
          .catch(function (error) {
            console.log(error);
          });
      })
      .catch(function (error) {
        console.log(error);
      });
  })

  .catch(function (error) {
    console.log(error);
  })
  .then(function () {
    // further processing - always executed
  });

/*  COMBINE SOURCES */
const combineAll = (roles, customer, opportunity, opportunityLines) => {
  // if customer name in customer is null, replace with customer name in opportunityLines
  if (!customer.Name) customer.Name = opportunityLines.value[0].CustomerName;

  const authorizedUsers = [];

  // simplify roles array
  for (let i = 0; i < roles.value.length; ++i) {
    authorizedUsers.push(roles.value[i].Identity);
  }

  // collect opportunity lines
  const oppLines = [];

  for (let i = 0; i < opportunityLines.value.length; ++i) {
    oppLines.push({
      referenceType: opportunityLines.value[i].ConObjectType,
      projectId: opportunityLines.value[i].ConObjectRef1,
      revisionNo: opportunityLines.value[i].RevisionNo,
      lineNo: opportunityLines.value[i].LineNo,
      description: opportunityLines.value[i].Description,
      dateEntered: opportunityLines.value[i].DateEntered,
      wantedDeliveryDate: opportunityLines.value[i].WantedDeliveryDate,
      status: opportunityLines.value[i].Status,
      customerName: opportunityLines.value[i].CustomerName,
      customerId: opportunityLines.value[i].CustomerId,
      mainRep: opportunityLines.value[i].Cf_Bol_Main_Rep,
    });
  }

  // combine into one object
  const combined = {
    businessOpportunityNumber: opportunity.OpportunityNo
      ? opportunity.OpportunityNo
      : null,
    businessName: customer.Name,
    businessOpportunityName: opportunity.Description
      ? opportunity.Description
      : null,
    businessOpportunityCity: customer.City,
    businessOpportunityState: customer.State,
    businessOpportunityCreatedDate: opportunity.DateEntered
      ? opportunity.DateEntered
      : null,
    businessOpportunityCreatedBy: opportunity.MainRepresentativeId
      ? opportunity.MainRepresentativeId
      : null,
    businessOpportunityStatus: opportunity.Status,
    businessOpportunityEstimateDueDate: opportunity.WantedDeliveryDate,
    verticalMarket: opportunity.MarketCode,
    businessOpportunityLineItems: oppLines,
    authorizedUsers,
  };

  return combined;
};

/* Example output
const result = {
  businessOpportunityNumber: "2317",
  businessName: "PUBLIX SUPER MARKETS INC",
  businessOpportunityName: "59927 Test",
  businessOpportunityCity: "LAKELAND",
  businessOpportunityState: "FL",
  businessOpportunityCreatedDate: "2020-11-19",
  businessOpportunityCreatedBy: "KHURD",
  businessOpportunityStatus: "Confirmed",
  businessOpportunityEstimateDueDate: null,
  verticalMarket: "RET-GROC",
  businessOpportunityLineItems: [
    {
      revisionNo: "0",
      lineNo: "1",
      description: "Gen Only",
      dateEntered: "2020-11-19",
      wantedDeliveryDate: null,
      status: "Won",
      customerName: "PUBLIX SUPER MARKETS INC",
      customerId: "1803",
      mainRep: "KHURD",
    },
    {
      revisionNo: "0",
      lineNo: "2",
      description: "Microgrid",
      dateEntered: "2020-11-19",
      wantedDeliveryDate: null,
      status: "Won",
      customerName: "PUBLIX SUPER MARKETS INC",
      customerId: "1803",
      mainRep: "KHURD",
    },
  ],
  authorizedUsers: [
    "ACAPPS",
    "TVICTOR",
    "BAEDWARDS",
    "BFERRICK",
    "CESGUERRA",
    "DBELK",
    "JSPECHT",
    "JTMOORE",
    "MATT.TAYLOR",
    "MLEIBOLD",
    "MRSTACKHOUSE",
    "NWILBOURNE",
    "SMTHOMAS",
    "SVICK",
    "ADANIEL",
  ],
};
*/

/* DATA PULL EXAMPLES */
// // https://powersecure-dev.ifs.cloud:48080/main/ifsapplications/projection/v1/PermissionSetHandling.svc/Reference_AllGrantedUsers?$filter=(Role eq 'PS_DEV_ENGINEERING_MGR') and SourcePermissionSet eq 'This'
// const roles = {
//     "@odata.context": "https://powersecure-dev.ifs.cloud:48080/main/ifsapplications/projection/v1/PermissionSetHandling.svc/$metadata#Reference_AllGrantedUsers",
//     "value": [
//         {
//             "luname": "AllGrantedUsers",
//             "keyref": "IDENTITY=ACAPPS^ROLE=PS_DEV_ENGINEERING_MGR^ROOT=PS_DEV_ENGINEERING_MGRTop^",
//             "Role": "PS_DEV_ENGINEERING_MGR",
//             "Root": "PS_DEV_ENGINEERING_MGRTop",
//             "Identity": "ACAPPS",
//             "SourcePermissionSet": "This",
//             "RowCount": 1
//         },
//         {
//             "luname": "AllGrantedUsers",
//             "keyref": "IDENTITY=TVICTOR^ROLE=PS_DEV_ENGINEERING_MGR^ROOT=PS_DEV_ENGINEERING_MGRTop^",
//             "Role": "PS_DEV_ENGINEERING_MGR",
//             "Root": "PS_DEV_ENGINEERING_MGRTop",
//             "Identity": "TVICTOR",
//             "SourcePermissionSet": "This",
//             "RowCount": 1
//         },
//         {
//             "luname": "AllGrantedUsers",
//             "keyref": "IDENTITY=BAEDWARDS^ROLE=PS_DEV_ENGINEERING_MGR^ROOT=PS_DEV_ENGINEERING_MGRTop^",
//             "Role": "PS_DEV_ENGINEERING_MGR",
//             "Root": "PS_DEV_ENGINEERING_MGRTop",
//             "Identity": "BAEDWARDS",
//             "SourcePermissionSet": "This",
//             "RowCount": 1
//         },
//         {
//             "luname": "AllGrantedUsers",
//             "keyref": "IDENTITY=BFERRICK^ROLE=PS_DEV_ENGINEERING_MGR^ROOT=PS_DEV_ENGINEERING_MGRTop^",
//             "Role": "PS_DEV_ENGINEERING_MGR",
//             "Root": "PS_DEV_ENGINEERING_MGRTop",
//             "Identity": "BFERRICK",
//             "SourcePermissionSet": "This",
//             "RowCount": 1
//         },
//         {
//             "luname": "AllGrantedUsers",
//             "keyref": "IDENTITY=CESGUERRA^ROLE=PS_DEV_ENGINEERING_MGR^ROOT=PS_DEV_ENGINEERING_MGRTop^",
//             "Role": "PS_DEV_ENGINEERING_MGR",
//             "Root": "PS_DEV_ENGINEERING_MGRTop",
//             "Identity": "CESGUERRA",
//             "SourcePermissionSet": "This",
//             "RowCount": 1
//         },
//         {
//             "luname": "AllGrantedUsers",
//             "keyref": "IDENTITY=DBELK^ROLE=PS_DEV_ENGINEERING_MGR^ROOT=PS_DEV_ENGINEERING_MGRTop^",
//             "Role": "PS_DEV_ENGINEERING_MGR",
//             "Root": "PS_DEV_ENGINEERING_MGRTop",
//             "Identity": "DBELK",
//             "SourcePermissionSet": "This",
//             "RowCount": 1
//         },
//         {
//             "luname": "AllGrantedUsers",
//             "keyref": "IDENTITY=JSPECHT^ROLE=PS_DEV_ENGINEERING_MGR^ROOT=PS_DEV_ENGINEERING_MGRTop^",
//             "Role": "PS_DEV_ENGINEERING_MGR",
//             "Root": "PS_DEV_ENGINEERING_MGRTop",
//             "Identity": "JSPECHT",
//             "SourcePermissionSet": "This",
//             "RowCount": 1
//         },
//         {
//             "luname": "AllGrantedUsers",
//             "keyref": "IDENTITY=JTMOORE^ROLE=PS_DEV_ENGINEERING_MGR^ROOT=PS_DEV_ENGINEERING_MGRTop^",
//             "Role": "PS_DEV_ENGINEERING_MGR",
//             "Root": "PS_DEV_ENGINEERING_MGRTop",
//             "Identity": "JTMOORE",
//             "SourcePermissionSet": "This",
//             "RowCount": 1
//         },
//         {
//             "luname": "AllGrantedUsers",
//             "keyref": "IDENTITY=MATT.TAYLOR^ROLE=PS_DEV_ENGINEERING_MGR^ROOT=PS_DEV_ENGINEERING_MGRTop^",
//             "Role": "PS_DEV_ENGINEERING_MGR",
//             "Root": "PS_DEV_ENGINEERING_MGRTop",
//             "Identity": "MATT.TAYLOR",
//             "SourcePermissionSet": "This",
//             "RowCount": 1
//         },
//         {
//             "luname": "AllGrantedUsers",
//             "keyref": "IDENTITY=MLEIBOLD^ROLE=PS_DEV_ENGINEERING_MGR^ROOT=PS_DEV_ENGINEERING_MGRTop^",
//             "Role": "PS_DEV_ENGINEERING_MGR",
//             "Root": "PS_DEV_ENGINEERING_MGRTop",
//             "Identity": "MLEIBOLD",
//             "SourcePermissionSet": "This",
//             "RowCount": 1
//         },
//         {
//             "luname": "AllGrantedUsers",
//             "keyref": "IDENTITY=MRSTACKHOUSE^ROLE=PS_DEV_ENGINEERING_MGR^ROOT=PS_DEV_ENGINEERING_MGRTop^",
//             "Role": "PS_DEV_ENGINEERING_MGR",
//             "Root": "PS_DEV_ENGINEERING_MGRTop",
//             "Identity": "MRSTACKHOUSE",
//             "SourcePermissionSet": "This",
//             "RowCount": 1
//         },
//         {
//             "luname": "AllGrantedUsers",
//             "keyref": "IDENTITY=NWILBOURNE^ROLE=PS_DEV_ENGINEERING_MGR^ROOT=PS_DEV_ENGINEERING_MGRTop^",
//             "Role": "PS_DEV_ENGINEERING_MGR",
//             "Root": "PS_DEV_ENGINEERING_MGRTop",
//             "Identity": "NWILBOURNE",
//             "SourcePermissionSet": "This",
//             "RowCount": 1
//         },
//         {
//             "luname": "AllGrantedUsers",
//             "keyref": "IDENTITY=SMTHOMAS^ROLE=PS_DEV_ENGINEERING_MGR^ROOT=PS_DEV_ENGINEERING_MGRTop^",
//             "Role": "PS_DEV_ENGINEERING_MGR",
//             "Root": "PS_DEV_ENGINEERING_MGRTop",
//             "Identity": "SMTHOMAS",
//             "SourcePermissionSet": "This",
//             "RowCount": 1
//         },
//         {
//             "luname": "AllGrantedUsers",
//             "keyref": "IDENTITY=SVICK^ROLE=PS_DEV_ENGINEERING_MGR^ROOT=PS_DEV_ENGINEERING_MGRTop^",
//             "Role": "PS_DEV_ENGINEERING_MGR",
//             "Root": "PS_DEV_ENGINEERING_MGRTop",
//             "Identity": "SVICK",
//             "SourcePermissionSet": "This",
//             "RowCount": 1
//         },
//         {
//             "luname": "AllGrantedUsers",
//             "keyref": "IDENTITY=ADANIEL^ROLE=PS_DEV_ENGINEERING_MGR^ROOT=PS_DEV_ENGINEERING_MGRTop^",
//             "Role": "PS_DEV_ENGINEERING_MGR",
//             "Root": "PS_DEV_ENGINEERING_MGRTop",
//             "Identity": "ADANIEL",
//             "SourcePermissionSet": "This",
//             "RowCount": 1
//         }
//     ]
// }

// // https://powersecure-dev.ifs.cloud:48080/main/ifsapplications/projection/v1/BusinessOpportunityHandling.svc/Reference_CustomerInfoAddress(CustomerId='1803',AddressId='MAIN')?$select=Name,City,State
// const customer = {
//     "@odata.context": "https://powersecure-dev.ifs.cloud:48080/main/ifsapplications/projection/v1/BusinessOpportunityHandling.svc/$metadata#IfsApp.BusinessOpportunityHandling.CustomerInfoAddress",
//     "@odata.etag": "W/\"Vy8iQUFBVEg1QUFHQUFCcmliQUFlOjIwMTgwMzE5MTgyNzM1Ig==\"",
//     "@odata.id": "https://powersecure-dev.ifs.cloud:48080/main/ifsapplications/projection/v1/BusinessOpportunityHandling.svc/Reference_CustomerInfoAddress(CustomerId='1803',AddressId='MAIN')",
//     "CustomerId": "1803",
//     "AddressId": "MAIN",
//     "Name": null,
//     "City": "LAKELAND",
//     "State": "FL"
// }

// // https://powersecure-dev.ifs.cloud:48080/main/ifsapplications/projection/v1/BusinessOpportunityHandling.svc/BusinessOpportunities(OpportunityNo='2317')?$select=OpportunityNo,Description,CustomerId,MainRepresentativeId,Status,DateEntered,WantedDeliveryDate,MarketCode
// const opportunity = {
//     "@odata.context": "https://powersecure-dev.ifs.cloud:48080/main/ifsapplications/projection/v1/BusinessOpportunityHandling.svc/$metadata#BusinessOpportunities/$entity",
//     "@odata.etag": "W/\"Vy8iQUFBU3RMQUFaQUFCS3lXQUFLOjIwMjAxMTE5MTIxNzQzIg==\"",
//     "OpportunityNo": "2317",
//     "Description": "59927 Test",
//     "CustomerId": "1803",
//     "MainRepresentativeId": "KHURD",
//     "MarketCode": "RET-GROC",
//     "WantedDeliveryDate": null,
//     "Status": "Confirmed",
//     "DateEntered": "2020-11-19"
// }

// // https://powersecure-dev.ifs.cloud:48080/main/ifsapplications/projection/v1/BusinessOpportunityHandling.svc/BusinessOpportunityLines?$filter=OpportunityNo eq '2317'&$select=OpportunityNo,CustomerName,CustomerId,OpportunityDescription,DateEntered,Cf_Bol_Main_Rep,Status,WantedDeliveryDate,LineNo,Description,ConObjectType,ConObjectRef1
// const opportunityLines = {
//     "@odata.context": "https://powersecure-dev.ifs.cloud:48080/main/ifsapplications/projection/v1/BusinessOpportunityHandling.svc/$metadata#BusinessOpportunityLines(OpportunityNo,RevisionNo,LineNo,Description,DateEntered,WantedDeliveryDate,ConObjectType,ConObjectRef1,Status,CustomerName,CustomerId,OpportunityDescription,Cf_Bol_Main_Rep)",
//     "value": [
//         {
//             "@odata.etag": "W/\"Vy8iQUFBUjVQQUFYQUFCMFpLQUFVOjIwMjAxMTE5MTIzNDI1Ig==\"",
//             "@odata.id": "https://powersecure-dev.ifs.cloud:48080/main/ifsapplications/projection/v1/BusinessOpportunityHandling.svc/BusinessOpportunityLines(OpportunityNo='2317',RevisionNo='0',LineNo='1')",
//             "OpportunityNo": "2317",
//             "RevisionNo": "0",
//             "LineNo": "1",
//             "Description": "Gen Only",
//             "DateEntered": "2020-11-19",
//             "WantedDeliveryDate": null,
//             "ConObjectType": "Project",
//             "ConObjectRef1": "102077",
//             "Status": "Won",
//             "CustomerName": "PUBLIX SUPER MARKETS INC",
//             "CustomerId": "1803",
//             "OpportunityDescription": "59927 Test",
//             "Cf_Bol_Main_Rep": "KHURD"
//         },
//         {
//             "@odata.etag": "W/\"Vy8iQUFBUjVQQUFYQUFCMFpLQUFWOjIwMjAxMTE5MTIzMzMyIg==\"",
//             "@odata.id": "https://powersecure-dev.ifs.cloud:48080/main/ifsapplications/projection/v1/BusinessOpportunityHandling.svc/BusinessOpportunityLines(OpportunityNo='2317',RevisionNo='0',LineNo='2')",
//             "OpportunityNo": "2317",
//             "RevisionNo": "0",
//             "LineNo": "2",
//             "Description": "Microgrid",
//             "DateEntered": "2020-11-19",
//             "WantedDeliveryDate": null,
//             "ConObjectType": "Project",
//             "ConObjectRef1": "102076",
//             "Status": "Won",
//             "CustomerName": "PUBLIX SUPER MARKETS INC",
//             "CustomerId": "1803",
//             "OpportunityDescription": "59927 Test",
//             "Cf_Bol_Main_Rep": "KHURD"
//         }
//     ]
// }

const res = {
  businessOpportunityNumber: "2317",
  businessName: "PUBLIX SUPER MARKETS INC",
  businessOpportunityName: "59927 Test",
  businessOpportunityCity: "LAKELAND",
  businessOpportunityState: "FL",
  businessOpportunityCreatedDate: "2020-11-19",
  businessOpportunityCreatedBy: "KHURD",
  businessOpportunityStatus: "Confirmed",
  businessOpportunityEstimateDueDate: null,
  verticalMarket: "RET-GROC",
  businessOpportunityLineItems: [
    {
      referenceType: "Project",
      projectId: "102077",
      revisionNo: "0",
      lineNo: "1",
      description: "Gen Only",
      dateEntered: "2020-11-19",
      wantedDeliveryDate: null,
      status: "Won",
      customerName: "PUBLIX SUPER MARKETS INC",
      customerId: "1803",
      mainRep: "KHURD",
    },
    {
      referenceType: "Project",
      projectId: "102076",
      revisionNo: "0",
      lineNo: "2",
      description: "Microgrid",
      dateEntered: "2020-11-19",
      wantedDeliveryDate: null,
      status: "Won",
      customerName: "PUBLIX SUPER MARKETS INC",
      customerId: "1803",
      mainRep: "KHURD",
    },
  ],
  authorizedUsers: [
    "ACAPPS",
    "TVICTOR",
    "BAEDWARDS",
    "BFERRICK",
    "CESGUERRA",
    "DBELK",
    "JSPECHT",
    "JTMOORE",
    "MATT.TAYLOR",
    "MLEIBOLD",
    "MRSTACKHOUSE",
    "NWILBOURNE",
    "SMTHOMAS",
    "SVICK",
    "ADANIEL",
  ],
};

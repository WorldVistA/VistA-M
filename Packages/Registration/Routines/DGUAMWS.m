DGUAMWS ;ALB/MCF,JAM - UAM Address Validation Web Service ;30 June 2020 10:00 AM
 ;;5.3;Registration;**1014,1065,1084**;Aug 13, 1993;Build 4
    ;
    ; Supported ICR's:
    ; #5421 - XOBWLIB - Public APIs for HWSC
    ; #6682 - DECODE^XLFJSON - Decode JSON
    ;       - ENCODE^XLFJSON - Encode JSON
    ; #7191 - Read access to file 18.12
    ; #7190 - Read access to file 18.02  
    ; #2263 - Permits the use of $$GET^XPAR to retrieve a parameter value.
    ; #1621 - APPERROR^%ZTER - sets $ZE and call the error trap 
    ;
    ; NOTE: EN^DGUAMWS contains vendor specific code that is restricted and will be reported by XINDEX. 
    ;       Exemption (20200806-01) was granted by the Standards and Conventions (SAC) committee on 8/6/20 
    ;       allowing the vendor specific code.
    ;
EN(DGADDRESS,DGFLDS,DGFORGN) ; Main entry to for UAM Address Validation Web Service
    ; Input : DGADDRESS (Required, pass by reference) - Array containing the address to be validated
    ;         DGFLDS (Required)  - List of fileman field values. See "Address fields" below.
    ;         DGFORGN (Required) - Foreign flag indicator. Determines use of Candidate or Validate web service
    ;                              0-Domestic (Candidate), 1-Foreign (Validate), 2-Foreign Exception (Candidate)
    ; Return: DGADDRESS - original address returned with the response addresses from the web service in the same format.
    ;         DGADDRESS(DGCNT,"confidenceScore") - Contains the confidence score for this address.
    ;         DGADDRESS(DGCNT,"deliveryPoint") - Contains the delivery point validation message for this address.
    ; (Only pertains to USA addresses)
    ; 0 - Error in web service call or no addresses above 80% confidence. 1- Successful request/response.
    ;     Note: A "1" returned does NOT imply a "good" address is returned.
    ;           Confidence Score, Delivery Point, and Message Codes give more detail if provided by the web service.
    N DGX,DGEXC,DGFRGNEXCPTS,DGADDRLN1,DGADDRLN2,DGADDRLN3,DGCITY,DGSTATE,DGZIP,DGPROV,DGPOSTCODE,DGCOUNTRY
    N DGSERVICE,DGERR,DGHTTPREQ,DGJSON,DGHEADER,DGRESPONSE,DGRESPERR,DGHTTPRESP,DGDATA,DGARRAY,DGRESPMSG,DGSTAT,DGKEY
    D INIT
    ; The Candidate web service may accept some foreign countries like Canada. That list is set up in Init.
    I DGFORGN=1 D
    . F DGX=1:1 S DGEXC=$P(DGFRGNEXCPTS,"^",DGX) Q:DGEXC=""  D
    . . I DGADDRESS(1,DGCOUNTRY)=DGEXC S DGFORGN=2 ; Foreign country on exceptions list
    ; Quit if server or services not installed
    I '$$FIND1^DIC(18.12,,"B","DG UAM AV SERVER")!('$$FIND1^DIC(18.02,,"B","DG UAM AV CANDIDATE"))!('$$FIND1^DIC(18.02,,"B","DG UAM AV VALIDATE")) Q "0^Web services are not set up"
    ; Call web server and web service. API key is set in Context Root of the web service in HWSC.
    S DGSERVICE=$S(DGFORGN=1:"DG UAM AV VALIDATE",1:"DG UAM AV CANDIDATE")
    S DGHTTPREQ=$$GETREST^XOBWLIB(DGSERVICE,"DG UAM AV SERVER")
    S DGHTTPREQ.SSLCheckServerIdentity = 0 ; Older versions of xobw.WebServer.cls don't set this value. Setting here to prevent Error #6156 during the POST below.
    ;
    ; JSON specific setup
    S DGJSON=$$JSONREQUEST(.DGADDRESS,DGFLDS)
    D DGHTTPREQ.EntityBody.Write(DGJSON) ; places the entire json string into EntityBody
    F DGHEADER="Accept","ContentType" D DGHTTPREQ.SetHeader(DGHEADER,"application/json")
    ;
    ; DG*5.3*1065 - Get API Key from PARAMETER file (#8989.5), parameter instance DG UAM API KEY and set it into the header
    S DGKEY=$$GET^XPAR("PKG","DG UAM API KEY",1)
    D DGHTTPREQ.SetHeader("apiKey",DGKEY)
    ;
    ; REST API Post Call and Response (response is in DGHTTPREQ.HttpResponse)
    S DGRESPONSE=$$POST^XOBWLIB(DGHTTPREQ,"",.DGRESPERR,0)
    I ('DGRESPONSE) Q "0^"_$$ERRRSPMSG(DGRESPERR)
    S DGHTTPRESP=DGHTTPREQ.HttpResponse
    S DGDATA=DGHTTPRESP.Data.ReadLine() ; reads json string response from the data stream.
    ;
    ; convert json string to an array, parse results and return in DGADDRESS array.
    D DECODE^XLFJSON("DGDATA","DGARRAY")
    I DGFORGN=1 D VALRESULTS(.DGADDRESS,.DGARRAY)
    I DGFORGN'=1 D CANDRESULTS(.DGADDRESS,.DGARRAY)
    ;
    S DGSTAT=$S($Order(DGADDRESS(1)):1,1:0)  ; if there are no results to return set status to "0"
    Q DGSTAT_"^"_$$RSPMSG(DGHTTPRESP.StatusCode,.DGRESPMSG)
    ;
ERRRSPMSG(DGRESPERR) ; 
    ; Input : DGRESPERR (Required) - response error from Post call
    ; Return: response code/txt (ex: DGERR(400) from Init)_response code/msg (ex: ADDRVAL###)
    N DGERRARR
    ;D ZTER^XOBWLIB(DGRESPERR), DG*5.3*1084 adds the APPERROR^%ZTER API for proper error handling
    D ERR2ARR^XOBWLIB(DGRESPERR,.DGERRARR)
    N DGERRCODE S DGERRCODE=DGRESPERR.code
    D APPERROR^%ZTER(DGERRCODE_" HTTP/Webservice error")
    I '$D(DGERR(DGERRCODE)) Q DGERRCODE_" An error occurred and has been logged. The service is currently not available."
 E  Q DGERR(DGERRCODE)
    ;
RSPMSG(DGSTCODE,DGRESPMSG) ;
    ; Input : DGSTCODE (Required)  - response statuscode from DGHTTPRESP
    ;       : DGRESPMSG  - response message from DGDATA
    ; Return: response code/txt (ex: DGERR(400) from Init)_response code/msg (ex: ADDRVAL###)
    Q DGERR(DGSTCODE)
    ;
JSONREQUEST(DGADDRESS,DGFLDS) ; places the address elements in the json string
    ; Input : DGADDRESS (Required, pass by reference) - Array containing the address to be validated
    ;         DGFLDS (Required) - List of fileman field values. See "Address fields" in Init
    ; Return: DGJSON(1) - a json string
    ;
    ; Format of DGADDRESS array
    ; DGADDRESS(field#)=VALUE
    ;
    ; if a foreign address, get value from Province if it was entered
    N DGSTATEPROV,DGJSON,DGSTCODE
    S DGSTATEPROV=$G(DGADDRESS(1,DGSTATE))
    ; Address is the full name, which UAM may not always recognize, so get the abbreviation
    S DGSTCODE=$P(DGSTATEPROV,"^",2)
    I DGSTCODE'="" S $P(DGSTATEPROV,"^",1)=$$GET1^DIQ(5,DGSTCODE,1)
    I (DGFORGN=1)&($G(DGADDRESS(1,DGPROV))'="") S DGSTATEPROV=DGADDRESS(1,DGPROV)
    ; DGSTATEPROV and DGADDRESS(1,DGCOUNTRY) will be stripped of the "^CODE" coming from VistA
    S DGJSON("requestAddress","addressLine1")=$G(DGADDRESS(1,DGADDRLN1))
    S DGJSON("requestAddress","addressLine2")=$G(DGADDRESS(1,DGADDRLN2))
    S DGJSON("requestAddress","addressLine3")=$G(DGADDRESS(1,DGADDRLN3))
    S DGJSON("requestAddress","addressPOU")="CORRESPONDENCE"
    S DGJSON("requestAddress","city")=$G(DGADDRESS(1,DGCITY))
    S DGJSON("requestAddress","internationalPostalCode")=$G(DGADDRESS(1,DGPOSTCODE))
    S DGJSON("requestAddress","requestCountry","countryCode")=""
    S DGJSON("requestAddress","requestCountry","countryName")=$P($G(DGADDRESS(1,DGCOUNTRY)),"^",1)
    S DGJSON("requestAddress","stateProvince","name")=$P(DGSTATEPROV,"^",1)
    S DGJSON("requestAddress","stateProvince","code")=""
    S DGJSON("requestAddress","zipCode4")=""
    S DGJSON("requestAddress","zipCode5")=$G(DGADDRESS(1,DGZIP))
    D ENCODE^XLFJSON("DGJSON","DGJSON")
    ;
    ; The resultant DGJSON string above is formatted as follows
    ; {
    ; "requestAddress": {
    ;    "addressLine1": ($G(DGADDRESS(1,DGADDRLN1))),
    ;    "addressLine2": ($G(DGADDRESS(1,DGADDRLN2))),
    ;    "addressLine3": ($G(DGADDRESS(1,DGADDRLN3))),
    ;    "addressPOU": "CORRESPONDENCE", 
    ;    "city": ($G(DGADDRESS(1,DGCITY))), 
    ;    "internationalPostalCode": ($G(DGADDRESS(1,DGPOSTCODE))), 
    ;    "requestCountry": {
    ;           "countryCode": "", 
    ;           "countryName": ($P($G(DGADDRESS(1,DGCOUNTRY)),"^",1))}, 
    ;    "stateProvince": {
    ;               "code": "", 
    ;               "name": ($P(DGSTATEPROV,"^",1))}, 
    ;    "zipCode4": "", 
    ;    "zipCode5": ($G(DGADDRESS(1,DGZIP)))}
    ; }
    Q DGJSON(1)
    ;
CANDRESULTS(DGADDRESS,DGARRAY) ; handles domestic address response from the Candidate web service. Multiple addresses possible.
    ; Input : DGADDRESS (Required, pass by reference) - Array containing the address to be updated and returned
    ;         DGARRAY - Array representation of JSON response.
    ; Return: DGADDRESS
    N DGADDR,DGTEMP,DGCNT,DGADDCNT
    S DGADDCNT=1,DGCNT=""
    F  S DGCNT=$O(DGARRAY("candidateAddresses",DGCNT)) Q:DGCNT=""  D
    . MERGE DGADDR=DGARRAY("candidateAddresses",DGCNT,"address")
    . MERGE DGADDR=DGARRAY("candidateAddresses",DGCNT,"addressMetaData")
    . I $$SETRRESULTS D
    . . S DGADDCNT=DGADDCNT+1
    . . MERGE DGADDRESS(DGADDCNT)=DGTEMP ; DGADDRESS contains original address in 1
    Q
    ;
VALRESULTS(DGADDRESS,DGARRAY) ; handles the foreign address response from the Validate web service. Only one address is returned.
    ; Input : DGADDRESS (Required, pass by reference) - Array containing the address to be updated and returned
    ;         DGARRAY - Array representation of JSON response.
    ; Return: DGADDRESS
    N DGADDR,DGTEMP
    MERGE DGADDR=DGARRAY("addressMetaData")
    MERGE DGADDR=DGARRAY("address")
    I $$SETRRESULTS MERGE DGADDRESS(2)=DGTEMP ; DGADDRESS contains original address in 1
    Q
    ;
SETRRESULTS() ; checks if Confidence Score is greater than 80 and sets values.
    ; Assumptions: DGADDR contains one address from DGADDRESS
    ; Return: 1 - Confidence Score is at or above 80. 0 - Confidence Score is below 80.
    ;         DGTEMP contains data from address.
    N DGVAL
    S DGTEMP("confidenceScore")=$G(DGADDR("confidenceScore"))
    S DGTEMP("deliveryPoint")=$G(DGADDR("deliveryPointValidation"))
    I DGTEMP("confidenceScore")<80 Q 0
    S DGTEMP(DGADDRLN1)=$G(DGADDR("addressLine1"))
    S DGTEMP(DGADDRLN2)=$G(DGADDR("addressLine2"))
    S DGTEMP(DGADDRLN3)=$G(DGADDR("addressLine3"))
    S DGTEMP(DGCITY)=$G(DGADDR("city"))
    S DGTEMP(DGCOUNTRY)=$G(DGADDR("country","name"))
    I DGFORGN=0 D
    . S DGTEMP(DGSTATE)=$G(DGADDR("stateProvince","name"))
    . ; Some addresses such as APO and FPO return state code only, not the name
    . I DGTEMP(DGSTATE)="" S DGTEMP(DGSTATE)=$G(DGADDR("stateProvince","code"))
    I DGFORGN S DGTEMP(DGPROV)=$G(DGADDR("stateProvince","name"))
    S DGTEMP(DGZIP)=$G(DGADDR("zipCode5"))_$G(DGADDR("zipCode4"))
    S DGTEMP(DGPOSTCODE)=$G(DGADDR("internationalPostalCode"))
    ; traverse through DGTEMP array and convert all values to UPPERCASE.
    S DGVAL="DGTEMP" F  S DGVAL=$QUERY(@DGVAL) Q:DGVAL=""  S @DGVAL=$$UPPER^DGUTL(@DGVAL)
    Q 1
INIT ; Initialized variables
    ; Get foreign country exceptions
    S DGFRGNEXCPTS="CAN^CANADA"
    ;
    ;                1            2            3        4     5     6       7       8         9         10
    ; Mapping: "AddressLine1,AddressLine2,AddressLine3,City,State,County,ZipCode,Province,PostalCode,Country"
    ; DGFLDS will contain one of the following list of subscripts that are used by DGADDRESS 
    ; Permanent Address fields   : ".111,.112,.113,.114,.115,.117,.1112,.1171,.1172,.1173"
    ; Residential Address fields : ".1151,.1152,.1153,.1154,.1155,.1157,.1156,.11571,.11572,.11573"
    ; Confidential Address fields: ".1411,.1412,.1413,.1414,.1415,.14111,.1416,.14114,.14115,.14116"
    S DGADDRLN1=$P(DGFLDS,",",1)
    S DGADDRLN2=$P(DGFLDS,",",2)
    S DGADDRLN3=$P(DGFLDS,",",3)
    S DGCITY=$P(DGFLDS,",",4)
    S DGSTATE=$P(DGFLDS,",",5)
    S DGZIP=$P(DGFLDS,",",7)
    S DGPROV=$P(DGFLDS,",",8)
    S DGPOSTCODE=$P(DGFLDS,",",9)
    S DGCOUNTRY=$P(DGFLDS,",",10)
    ; Response Codes/Text
    S DGERR(200)="200 Successful Request/Response from server. " ; may append messages
    S DGERR(400)="400 Error. " ; will append messages
    S DGERR(403)="403 Not authorized. Please verify credentials used in the request. "
    S DGERR(404)="404 The record you requested to retrieve or update could not be found. "
    S DGERR(429)="429 You have exhausted the approved request quota for this API. This request should be retried after the quota window expires (default 60sec). "
    S DGERR(500)="500 Error. " ; will append messages
    Q

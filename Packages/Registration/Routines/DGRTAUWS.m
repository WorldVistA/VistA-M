DGRTAUWS ;ALB/JAM - Real-time Address Update Web Service ;20 May 2025 10:00 AM
 ;;5.3;Registration;**1143**;Aug 13, 1993;Build 36
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
 ; NOTE: EN^DGRTAUWS contains vendor specific code that is restricted and will be reported by XINDEX.
 ;       Exemption 202509051055-06 was granted by the Standards and Conventions (SAC) committee on 9/5/25
 ;       allowing the vendor specific code.
 ;
 Q
EN(DGCONTACTINFODTO,DGADDRESSDTO,DGPHONEDTO,DGEMAILDTO,DGCONFCATDTO,DGERRS) ; Main entry for Real-time Address Update Web Service
 ; Input : DGCONTACTINFODTO (Required, pass by reference) - Array containing the fields for contactInfoDTO
 ;         DGADDRESSDTO (optional, pass by reference) - array containing all the addressDTO objects
 ;         DGPHONEDTO (optional, pass by reference) - array containing all the phoneDTO objects
 ;         DGEMAILDTO (optional, pass by reference) - array containing the emailDTO
 ;         DGCONFCATDTO (optional, pass by reference) - array containing the Confidential Address Categories
 ;
 ; Output: DGERRS (pass by reference) - Return array containing 1 or more lines of error messages on failure
 ; Return: 
 ;  1 - SUCCESS - Always return 1 except for data validation issues that the user must correct
 ;  0 - FAILURE - For data validation error(s) only
 ;
 ; Called by ^DGRTAUPD
 ; The 1st subscript of the DTO arrays is the type of address or phone or email
 ; The 2nd subscript is the DTO field name for each field in the object
 ; DGADDRESSDTO("RES"
 ; DGADDRESSDTO("MAIL"
 ; DGADDRESSDTO("TEMP"
 ; DGADDRESSDTO("CONF"
 ;
 ; DGPHONEDTO("HOMEPH"
 ; DGPHONEDTO("OFFICEPH"
 ; DGPHONEDTO("TEMPPH"
 ; DGPHONEDTO("CONFPH"
 ; DGPHONEDTO("CELLPH"
 ;
 ; DGEMAILDTO("EMAIL"
 ;
 S $ZTRAP="ERR"
 ; Server or services not installed - return 1 with information message for debugging if needed
 I '$$FIND1^DIC(18.12,,"B","DG RTAU SERVER")!('$$FIND1^DIC(18.02,,"B","DG RTAU CONTACTINFO")) Q "1^Web services are not set up"
 ;
 ; DGCONTACTINFODTO is required
 I '$D(DGCONTACTINFODTO) Q "0^Missing contact information."
 ;
 N DGERR,DGJSON,DGCNT,DGTYPE
 D INIT
 ; Merge the incoming array(s) into the DGCONTACTINFODTO array
 ; For each address type, move it into the DGCONTACTINFODTO
 I $D(DGADDRESSDTO) D
 . S DGTYPE="",DGCNT=0
 . F  S DGTYPE=$O(DGADDRESSDTO(DGTYPE)) Q:DGTYPE=""  D
 . . S DGCNT=DGCNT+1
 . . M DGCONTACTINFODTO("addresses",DGCNT)=DGADDRESSDTO(DGTYPE)
 ;
 ; For each phone type, move it into the DGCONTACTINFODTO
 I $D(DGPHONEDTO) D
 . S DGTYPE="",DGCNT=0
 . F  S DGTYPE=$O(DGPHONEDTO(DGTYPE)) Q:DGTYPE=""  D
 . . S DGCNT=DGCNT+1
 . . M DGCONTACTINFODTO("phones",DGCNT)=DGPHONEDTO(DGTYPE)
 ;
 ; if we have Confidential Address Categories, move it into DGCONTACTINFODTO
 I $D(DGCONFCATDTO) M DGCONTACTINFODTO("confidentialAddressCategories")=DGCONFCATDTO
 ;
 ; If we have DGEMAILDTO, move it into DGCONTACTINFODTO
 I $D(DGEMAILDTO) M DGCONTACTINFODTO("emails",1)=DGEMAILDTO("EMAIL")
 ;
 ; Create the JSON array for DGCONTACTINFODTO
 M DGJSON=DGCONTACTINFODTO
 ; Create JSON string for the request
 D ENCODE^XLFJSON("DGJSON","DGJSON")
 ;
 Q $$SENDREQ(DGJSON(1))
 ;
INIT ; Initialized variables
 ; Response Codes/Text
 S DGERR(200)="200 Successful Request/Response from server. "
 S DGERR(400)="400 Error. " ; messages will be in return array DGERRS
 S DGERR(403)="403 Error. The request could not be processed."
 S DGERR(404)="HTTP/1.1 404 Not Found. "
 S DGERR(500)="500 Error. " ; messages will be in return array DGERRS
 S DGERR(502)="502 The proxy server received an invalid response from an upstream server."
 S DGERR(503)="503 The Service Unavailable."
 S DGERR(6059)="6059 Timeout. Unable to open TCP/IP socket to server."
 Q
 ;
SENDREQ(DGJSON) ; Invoke the webservice
 N DGHEADER,DGKEY,DGHTTPREQ,DGRESPONSE,DGRESPERR,DGHTTPRESP,DGERRCODE,DGDATA,DGARRAY,DGUID,DGWSCNT
 ; Set up the request object
 S DGHTTPREQ=$$GETREST^XOBWLIB("DG RTAU CONTACTINFO","DG RTAU SERVER")
 S DGHTTPREQ.SSLCheckServerIdentity = 0 ; Older versions of xobw.WebServer.cls don't set this value. Setting here to prevent Error #6156 during the POST below.
 D DGHTTPREQ.EntityBody.Write(DGJSON) ; places the entire json string into EntityBody
 F DGHEADER="Accept","ContentType" D DGHTTPREQ.SetHeader(DGHEADER,"application/json")
 ;
 ; Get API Key from PARAMETER file (#8989.5), parameter instance DG UAM API KEY and set it into the header
 S DGKEY=$$GET^XPAR("PKG","DG RTAU API KEY",1)
 D DGHTTPREQ.SetHeader("apiKey",DGKEY)
 ; Set the UUID into the header
 S DGUID=$SYSTEM.Util.CreateGUID()
 D DGHTTPREQ.SetHeader("transactionUUID",DGUID)
 D DGHTTPREQ.SetHeader("acting-user","VAMC-"_DGCONTACTINFODTO("originatingFacilityId"))
 ; Count for how many times we invoke the service (maximum of 2)
 S DGWSCNT=0
RETRY ; Tag for retry of the service
 S DGWSCNT=DGWSCNT+1
 ; REST API Post Call and Response (response is in DGHTTPREQ.HttpResponse)
 S DGRESPONSE=$$POST^XOBWLIB(DGHTTPREQ,"",.DGRESPERR,0)
 ; Return a success response
 I DGRESPONSE S DGHTTPRESP=DGHTTPREQ.HttpResponse Q "1^"_$G(DGERR(DGHTTPRESP.StatusCode))
 ;
 ; For certain error codes, retry the webservice a 2nd time.
 ; After 2 tries, quit 1 with the error code
 S DGERRCODE=DGRESPERR.code
 I DGERRCODE=404!(DGERRCODE=502)!(DGERRCODE=503)!(DGERRCODE=6059) G:DGWSCNT=1 RETRY Q "1^"_DGERRCODE
 ;
 ; Process the other errors - filling in the DGERRS message array for data validation issues
 N DGERRARR,DGMESS,DGCNT
 ; Pull out the response text into an array
 D ERR2ARR^XOBWLIB(DGRESPERR,.DGERRARR)
 ; For errors 400 or 500, place message text into the return array and quit 0
 I DGERRCODE=400!(DGERRCODE=500) D  Q 0_"^"_DGERR(DGERRCODE)
 . ; Get all lines of the response text and put them in a single string - which will be a JSON string
 . S DGMESS="" FOR DGCNT=1:1:DGERRARR("text") S DGMESS=DGMESS_DGERRARR("text",DGCNT)
 . ; Decode the JSON string into an array structure
 . D DECODE^XLFJSON("DGMESS","DGMESS")
 . ; Step through the array and put each "description" line into the return error array
 . S DGCNT="" F  S DGCNT=$O(DGMESS("messages",DGCNT)) Q:DGCNT=""  S DGERRS(DGCNT)=DGMESS("messages",DGCNT,"description")
 ;
 ; For all other errors, return success with error message for debugging purposes if needed
 S DGRESPONSE=1
 D APPERROR^%ZTER(DGERRCODE_" HTTP/Webservice error")
 I '$D(DGERR(DGERRCODE)) Q 1_"^"_DGERRCODE_" An error occurred and has been logged."
 E  Q 1_"^"_DGERR(DGERRCODE)
 Q
ERR ; error trapping code
 S $ZTRAP="QUIT" ; if there's an error in the error handler just quit.
 D ^%ZTER ; if code reaches here there is some other network error.
 Q "1^Unknown error."

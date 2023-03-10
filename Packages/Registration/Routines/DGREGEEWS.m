DGREGEEWS ;ALB/MCF - E&E Web Service ;9 September 2020 9:00 AM
 ;;5.3;Registration;**1027**;Aug 13, 1993;Build 70
 ;
 ; Subscribed ICR: 
 ; Reference to routine XOBWLIB in ICR #5421 - Public APIs for HWSC
 ; Reference to UNWIND^%ZTER in ICR #1621 - Standard Error Trapping
 ; Reference to Web Service File XOBW(18.02 in ICR #7190
 ; Reference to Web Server File XOBW(18.12 in ICR #7191
 ;
 ; SAC EXEMPTION 20210107-01 : Use of vendor specific code
 ;
 Q
EN(DGKEY,DGREQNAM,DGENSTAT,DGWSHTOE) ; Main entry point function call
 ; Input : DGKEY (Required) - patient full ICN with checksum -> ICN_"V"_CHECKSUM
 ;         DGREQNAM (Required)  - Requester name. Ex: "VistAData"
 ; Output: DGENSTAT (Pass by reference) - Contains the enrollment status. NULL = ICN is unknown to ES
 ;         DGWSHTOE (Pass by reference) - Contains the "Do You Wish To Enroll?" value.
 ; Return: DGRESP - the response in the format "N^Descriptive text".
 ;                  1 - An enrollment status exists. Descriptive text=Enrollment Status
 ;                  0 - No enrollment status exists OR Invalid ICN OR Network error.
 ;
 N DGEEOBJ,DGSUMMARY,DGSTCODE,DGRESP
 N $ETRAP,$ESTACK
 ; set error trap
 S $ETRAP="DO ERR^DGREGEEWS"
 S (DGENSTAT,DGWSHTOE,DGSTCODE)=""
 S DGRESP="0^Unknown error"
 D GETSUMM(.DGSUMMARY)
 I '$GET(DGSUMMARY) Q DGRESP
 D RESULTS(.DGSUMMARY)
 Q DGRESP
 ;
GETSUMM(DGSUMMARY) ; Set up web service object through HWSC.
 ; Output: DGSUMMARY object
 I '$$FIND1^DIC(18.12,,"B","DG EE SUMMARY SERVER")!'$$FIND1^DIC(18.02,,"B","DG EE SUMMARY SERVICE") S DGRESP="0^Web services are not set up" Q
 S DGEEOBJ=$$GETPROXY^XOBWLIB("DG EE SUMMARY SERVICE","DG EE SUMMARY SERVER")
 S DGEEOBJ.Password=DGEEOBJ.HttpPassword ; set passwords to force creation of security headers
 S DGEEOBJ.HttpPassword=""
 S DGEEOBJ.Username=DGEEOBJ.HttpUsername
 S DGEEOBJ.HttpUsername=""
 ; If ICN is valid a DGSUMMARY object will be returned
 ; If ICN is invalid a 500 error msg will be returned with a <ZSOAP> error & gracefully exit via ERR tag.
 D DGEEOBJ.getEESummary(DGKEY,"",DGREQNAM,"",.DGSUMMARY) ; get summary data
 Q
RESULTS(DGSUMMARY) ; get enrollment status and "do you wish to enroll value?"
 ; Input: DGSUMMARY object
 D STATCODE
 I $ISO(DGSUMMARY.enrollmentDeterminationInfo) D  Q
 . S DGRESP="1^"_DGSTCODE_" Valid ICN and known to ES"
 . S DGENSTAT=DGSUMMARY.enrollmentDeterminationInfo.enrollmentStatus
 . S DGWSHTOE=DGSUMMARY.enrollmentDeterminationInfo.registrationInfo.doYouWishToEnroll
 E  D
 . S DGRESP="0^"_DGSTCODE_" Valid ICN but UNKNOWN to ES"
 Q
STATCODE ; http response status code
 S DGSTCODE=DGEEOBJ.HttpResponse.StatusCode
 Q
ERR ; error trapping code
 N $ETRAP,$ESTACK,DGERR,DGTEXT
 ; if there's an error in the error handler just quit.
 S $ETRAP="DO QUIT^DGREGEEWS"
 S DGERR=$$EOFAC^XOBWLIB()
 D STATCODE
 S DGTEXT="Error has been logged in error log"
 S DGTEXT=$S($ISO(DGEEOBJ.SoapFault):DGEEOBJ.SoapFault.faultstring,1:DGTEXT)
 S DGRESP="0^"_DGSTCODE_" "_DGTEXT
 ; if code is not 6248 PERSON_NOT_FOUND it is some other error. Log it.
 I DGERR.code'=6248 D ZTER^XOBWLIB(DGERR)
 S $ECODE=""
 D UNWIND^%ZTER
 Q
QUIT ;
 D ZTER^XOBWLIB(DGERR)
 Q

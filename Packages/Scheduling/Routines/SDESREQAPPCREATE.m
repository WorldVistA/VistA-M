SDESREQAPPCREATE ;ALB/RRM,MGD - VISTA SCHEDULING CREATE APPT REQ AND SCHEDULE APPT RPC ;Mar 27, 2023@10:29
 ;;5.3;Scheduling;**823,826,843**;Aug 13, 1993;Build 9
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 ;
 Q  ;No Direct Call
 ;
 ; The parameter list for this RPC must be kept in sync.
 ; If you need to add or remove a parameter, ensure that the Remote Procedure File #8994 definition is also updated.
CREATEREQANDAPPT(RETURNJSON,REQUEST) ;EP for SDES CREATE VET REQ SCHED APPT
 ; Input:
 ;  REQUEST [Required] - This is the array that contains all necessary data for the creation of the appointment request,
 ;                       scheduling the appointment, and then dispositioning the appointment.
 ;  REQUEST("APPOINTMENT END TIME")          = (Required) APPT END TIME - ISO FORMAT
 ;  REQUEST("APPOINTMENT LENGTH")            = (Required) APPT LENGTH IN MINUTES (5-120)
 ;  REQUEST("APPOINTMENT START TIME")        = (Required) APPT START TIME - ISO FORMAT
 ;  REQUEST("CLINIC IEN")                    = (Required) CLINIC IEN
 ;  REQUEST("CREATE DATE")                   = (Required) DATE/TIME ENTERED (#409.85,9.5) in ISO8601 date/time format to include offset (e.g. CCYY-MM-DDTHH:MM-NNNN)
 ;  REQUEST("PATIENT INDICATED DATE")        = (Required) CID/PID DATE - ISO FORMAT
 ;  REQUEST("DFN")                           = (Required) PATIENT IEN
 ;  REQUEST("APPOINTMENT REASON")            = (Optional) FREE TEXT (1-150)
 ;  REQUEST("COLLATERAL VISIT")              = (Optional) COLLATERAL - 1 FOR YES
 ;  REQUEST("APPOINTMENT TYPE IEN")          = (Optional) POINTER TO APPOINTMENT TYPE FILE (#409.1)
 ;  REQUEST("APPOINTMENT TYPE NAME")         = (Optional) NAME from APPOINTMENT TYPE FILE (#409.1)
 ;   Either APPOINTMENT TYPE IEN or APPOINTMENT TYPE NAME is Required
 ;  REQUEST("EAS")                           = (Optional) Enterprise APPT Scheduling Tracking Number associated to an appt.
 ;  REQUEST("FOLLOWUP")                      = (Optional) FOLLOWUP VISIT - 1 FOR YES 0 FOR NO
 ;  REQUEST("INSTITUTION NAME")              = (Optional) Institution name from the INSTITUTION file
 ;  REQUEST("MODALITY")                      = (Optional) Valid Values: FACE2FACE, TELEPHONE, VIDEO
 ;  REQUEST("NOTE")                          = (Optional) NOTE - FREE TEXT 1-150
 ;  REQUEST("OVERBOOK")                      = (Optional) OVERBOOK (0 for no, 1 for yes)
 ;  REQUEST("PATIENT COMMENT")               = (Optional) Patient-entered comments when using VAOS or other web-service (stored at 409.85,60 a word processing field)
 ;  REQUEST("PATIENT ELIGIBILITY IEN")       = (Optional) ELIGIBILITY IEN
 ;  REQUEST("PATIENT PREFERRED END DATE",1)  = (Optional) PATIENT PREFERRED END DATE 1 - ISO FORMAT
 ;  REQUEST("PATIENT PREFERRED END DATE",2)  = (Optional) PATIENT PREFERRED END DATE 2 - ISO FORMAT
 ;  REQUEST("PATIENT PREFERRED END DATE",3)  = (Optional) PATIENT PREFERRED END DATE 3 - ISO FORMAT
 ;  REQUEST("PATIENT PREFERRED START DATE",1)= (Optional) PATIENT PREFERRED START DATE 1 - ISO FORMAT
 ;  REQUEST("PATIENT PREFERRED START DATE",2)= (Optional) PATIENT PREFERRED START DATE 2 - ISO FORMAT
 ;  REQUEST("PATIENT PREFERRED START DATE",3)= (Optional) PATIENT PREFERRED START DATE 3 - ISO FORMAT
 ;  REQUEST("PATIENT STATUS")                = (Optional) PATIENT STATUS - "NEW" OR "ESTABLISHED
 ;  REQUEST("PRIORITY")                      = (Optional) PRIORITY - "ASAP" or FUTURE
 ;  REQUEST("PRIORITY GROUP")                = (Optional) ENROLLMENT PRIORITY - GROUP 1 - GROUP 7
 ;  REQUEST("REQUEST COMMENT")               = (Optional) REQUEST COMMENT
 ;  REQUEST("SECONDARY STOP CODE")           = (Optional) Secondary Stop Code Number pointer to CLINIC STOP file #40.7 used to populate the REQ SECONDARY STOP CODE field in 409.85
 ;  REQUEST("SERVICE CONNECTED")             = (Optional) Valid Values: YES, NO
 ;  REQUEST("SERVICE CONNECTED PERCENTAGE")  = (Optional) SC % = 0-100
 ;  REQUEST("STATION NUMBER")                = (Optional) STATION NUMBER (#99),INSTITUTION (#4)
 ;  REQUEST("STOP CODE")                     = (Optional) CLINIC STOP pointer to CLINIC STOP file 40.7 used to populate the REQ SERVICE/SPECIALTY field in 409.85
 ;  REQUEST("VAOS GUID")                     = (Optional) VAOS GUID
 ;
 ; Output:
 ;  Successful Return:
 ;    RETURNJSON = Returns the Request and Appointment IEN in JSON formatted string.
 ;    Otherwise, JSON Errors will be returned for any invalid/missing parameters.
 ;
 N APPTARRAY,SDCIDPREFDATE,DIK,DA,REQUESTIEN,EAS,PCMT,SDBEGDATE,INSTITUTIONIEN
 N DISPOSITION,DISPBY,DISPDATE,ARY84,ARY44,ARY2,ISAPPTOVERLAP,SDREQBY
 N ERRORS,RETURNERROR   ;temp data storage for input validation error
 N TMPJSONRETURN        ;temp data storage for the create appointment json return
 N REQRESULT,APPTRESULT ;holder of the decoded JSON format into an array format. the array contains the appointment request data result
 N APPOINTMENT          ;contains the RETURNJSON array
 ;
 K RETURNJSON ;always kill the return json array
 ;check if the REQUEST array have data on it before going further.
 I $O(REQUEST(""))="" D  Q
 . S ERRORS("Error",1)="The REQUEST array that would be used to create the appointment contains no data. There is nothing to process."
 . D SETERRORRETURN(.ERRORS,.RETURNERROR,.RETURNJSON)
 ;
 S SDCIDPREFDATE=$G(REQUEST("PATIENT INDICATED DATE"))
 S REQUEST("REQUESTED BY")="PATIENT"  ;always REQUESTED BY PATIENT.
 S REQUEST("REQUEST SUB TYPE")="APPT" ;always APPT for APPOINTMENT.
 ;
 D VALIDATE^SDESCREATEAPPREQ(.REQUEST,.INSTITUTIONIEN,.ERRORS)
 S REQUEST("PATIENT INDICATED DATE")=SDCIDPREFDATE ;put back the ISO format
 D BUILDAPPTARRAY(.REQUEST,.REQRESULT,.APPTARRAY)
 D POPULATEARRAYS^SDESCRTAPPTWRAP(.APPTARRAY,.ARY84,.ARY44,.ARY2)
 D VALIDATE^SDESCREATEAPPT(.ERRORS,.ARY84)
 D VALIDATE^SDESCREATEAPPT2(.ERRORS,.ARY2)
 D RETURNERR(.ERRORS)
 D VALIDATE^SDESCREATEAPPT44(.ERRORS,.ARY44)
 I $O(ERRORS("Error",""))'="" D SETERRORRETURN(.ERRORS,.RETURNERROR,.RETURNJSON),CLEANUP Q
 ;
 ;check if the requested appointment is overlapping
 I $G(REQUEST("DFN"))'="",$G(REQUEST("APPOINTMENT START TIME"))'="",$G(REQUEST("APPOINTMENT LENGTH"))'="" D  Q:$G(TMPJSONRETURN("Overlap"))=1
 . S SDBEGDATE=$$ISOTFM^SDAMUTDT(REQUEST("APPOINTMENT START TIME"))
 . S ISAPPTOVERLAP=$$CHKOVERL^SDESCHKAPPTOVP(.TMPJSONRETURN,$G(REQUEST("DFN")),SDBEGDATE,$G(REQUEST("APPOINTMENT LENGTH")))
 . I $G(TMPJSONRETURN("Overlap"))=1 S ERRORS=1,ERRORS("Error",1)="Overlapping Appointment" D SETERRORRETURN(.ERRORS,.RETURNERROR,.RETURNJSON),CLEANUP Q
 ;
 ;create the appointment request in File #409.85
 S REQUEST("PATIENT INDICATED DATE")=$$ISOTFM^SDAMUTDT($G(SDCIDPREFDATE))
 S REQUESTIEN=$$BUILDER^SDESCREATEAPPREQ(.REQUEST,.INSTITUTIONIEN)
 S REQRESULT("Request","IEN")=$G(REQUESTIEN)
 ;
 ;create/schedule the appointment in File #409.84, File #44, and File #2
 S APPTARRAY(8)="A|"_$G(REQUESTIEN)
 K TMPJSONRETURN D CREATEAPPTS^SDESCRTAPPTWRAP(.TMPJSONRETURN,.APPTARRAY)
 D DECODE^XLFJSON("TMPJSONRETURN","APPTRESULT","ERROR")
 ;if in the event an error occurred during the creation and scheduling of the appointment, delete the appointment request
 I $O(APPTRESULT("Error",""))'="" D  Q
 . S DIK="^SDEC(409.85,",DA=$G(REQRESULT("Request","IEN")) D ^DIK
 . M RETURNERROR=APPTRESULT
 . D SETEMPTYOBJECT(.RETURNERROR) ;set the return object into null if an error occur
 . D BUILDJSON^SDESBUILDJSON(.RETURNJSON,.RETURNERROR)
 ;
 ;If everything is successful, disposition the appointment request and create the JSON RETURN back to the calling application
 K TMPJSONRETURN
 S REQUESTIEN=$G(REQRESULT("Request","IEN"))
 S EAS=$G(REQUEST("EAS"))
 S PCMT=$G(REQUEST("PATIENT COMMENT"))
 S DISPOSITION="REMOVED/SCHEDULED-ASSIGNED"
 S DISPBY=$G(DUZ)
 S DISPDATE=$TR($$FMTE^XLFDT($$NOW^XLFDT,"7DZ"),"/","-")
 D DISPOSITION^SDESARCLOSE(.TMPJSONRETURN,$G(REQUESTIEN),$G(DISPOSITION),$G(DISPBY),$G(DISPDATE),$G(EAS),$G(PCMT))
 M APPOINTMENT=REQRESULT
 M APPOINTMENT=APPTRESULT
 D BUILDJSON^SDESBUILDJSON(.RETURNJSON,.APPOINTMENT)
 D CLEANUP
 Q
 ;
BUILDAPPTARRAY(REQUEST,REQRESULT,APPTARRAY) ;build the appointment array based from the REQUEST array
 N CLINICRES
 S CLINICRES=$S($G(REQUEST("CLINIC IEN"))="":"",1:$$GETRES^SDESINPUTVALUTL($G(REQUEST("CLINIC IEN")),1))
 S APPTARRAY(1)=$G(REQUEST("APPOINTMENT START TIME"))
 S APPTARRAY(2)=REQUEST("APPOINTMENT END TIME")
 S APPTARRAY(3)=$G(REQUEST("DFN"))
 S APPTARRAY(4)=CLINICRES                               ;CLINIC RESOURCE
 S APPTARRAY(5)=""                                      ;defaulted to Null = not a walk-in appointment
 S APPTARRAY(6)=$G(REQUEST("PATIENT INDICATED DATE"))   ;this is the CID/PID Date Preferred
 S APPTARRAY(7)=""                                      ;this is the EXTERNAL ID - (FREE TEXT 1-50), defaulted to NULL since this not needed
 S APPTARRAY(8)="A|"_$G(REQRESULT("Request","IEN"))
 S APPTARRAY(9)=""                                      ;Not Needed since this request is always be by PATIENT
 S APPTARRAY(10)=$G(REQUEST("CLINIC IEN"))
 S APPTARRAY(11)=$G(REQUEST("NOTE"))
 S APPTARRAY(12)=$$GET1^DIQ(409.1,$G(REQUEST("APPOINTMENT TYPE IEN")),.01,"E")
 S APPTARRAY(12.5)=$G(REQUEST("APPOINTMENT TYPE NAME"))
 S APPTARRAY(13)=$G(REQUEST("PATIENT STATUS"))
 S APPTARRAY(14)=$G(REQUEST("APPOINTMENT LENGTH"))
 S APPTARRAY(15)=$G(REQUEST("SERVICE CONNECTED"))
 S APPTARRAY(16)=$G(REQUEST("SERVICE CONNECTED PERCENTAGE"))
 S APPTARRAY(17)="FALSE"                                 ;MRTC is set to FALSE since all appointment coming from VAOS are ALL SINGLE APPOINTMENT
 S APPTARRAY(18)=""                                      ;PARENT REQUEST (APPT REQUEST IEN) is set to NULL, all appointment coming from VAOS are ALL SINGLE APPOINTMENT
 S APPTARRAY(19)=$G(REQUEST("EAS"))
 S APPTARRAY(20)=$G(REQUEST("APPOINTMENT REASON"))       ;This is the APPOINTMENT REASON - defaulting to NULL
 S APPTARRAY(21)=$G(REQUEST("PATIENT ELIGIBILITY IEN"))  ;This is PATIENT ELIGIBILITY IEN pointer to DIC(8
 S APPTARRAY(22)=$G(REQUEST("OVERBOOK"))                 ;OVERBOOK (0 for no, 1 for yes)
 S APPTARRAY(23)=""                                      ;LAB DATE/TIME - ISO FORMAT
 S APPTARRAY(24)=""                                      ;XRAY DATE/TIME - ISO FORMAT
 S APPTARRAY(25)=""                                      ;EKG DATE/TIME - ISO FORMAT
 S APPTARRAY(26)=3                                       ;Always set to '3' FOR SCHEDULED VISIT -this is per Judy Mercado
 S APPTARRAY(27)=$G(REQUEST("COLLATERAL VISIT"))         ;COLLATERAL - 1 FOR YES
 S APPTARRAY(28)="P"                                     ;Always set to 'P' FOR OTHER THAN 'NEXT AVA.' (PATIENT REQ.)-this is per Judy Mercado
 S APPTARRAY(29)=0                                       ;Always set to '0' FOR NOT INDICATED TO BE A 'NEXT AVA.' APPT -this is per Judy Mercado
 S APPTARRAY(30)=$G(REQUEST("FOLLOWUP"))
 Q
 ;
SETERRORRETURN(ERRORS,RETURNERROR,RETURNJSON) ;
 M RETURNERROR=ERRORS
 D SETEMPTYOBJECT(.RETURNERROR) ;set the return object into null if an error occur
 D BUILDJSON^SDESBUILDJSON(.RETURNJSON,.RETURNERROR)
 Q
 ;
SETEMPTYOBJECT(RETURNERROR) ;set the return object into null if an error occur
 S RETURNERROR("Request","IEN")=""
 S RETURNERROR("Appointment","IEN")=""
 Q
 ;
CLEANUP ;
 K ERRORS,RETURNERROR,ISDFNVALID,ISDATETIMEVALID,ISEASVALID,INSTITUTIONIEN,ISCLINSTOPVALID,ISREQUESTBYVALID,ISPROVIDERVALID,ISMODALITYVALID,ISMODALINVALID
 K ISPIDVALID,ISPRIGROUPVALID,ISREQTYPEVALID,ISPRIORITYVALID,ISSERVCONNVALID,ISAPPTTYPEVALID,ISPATSTATVALID,ISDATEPREFVALID,ISMTRCDATAVALID,ISCPRSDATAVALID
 Q
 ;
RETURNERR(ERRORS) ;
 N LASTSUB,CNTR
 ;this error will always be generated since the appointment request IEN do not yet exist yet
 ;when the appointment array is validated
 S LASTSUB=$O(ERRORS("Error",""),-1),CNTR=0
 F CNTR=1:1:LASTSUB I $G(ERRORS("Error",CNTR))["Appointment Request Type" K ERRORS("Error",CNTR)
 Q

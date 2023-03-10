SDESORDCLEAN ;ALB/LAB - Clean-up of Pending and partialdd RTC orders ;Dec 06,2022@08:00
 ;;5.3;Scheduling;**831**;Aug 13, 1993;Build 4
 ;;Per VHA Directive 2004-038, this routine should not be modified
 ;
 ;  Close RTC orders in CPRS if the corresponding order in Appointment Request file (#409.85) was closed (appointment made) or otherwise dispositioned.
 ;  Based on routine from Ty Phelps.
 ;
 Q
 ;
 ; Documented API's and Integration Agreements
 ; -------------------------------------------
 ; Reference to ^ORD(100.01 in ICR #2638
 ; Reference to ^OR(100 in ICR #7156
 ; Reference to ^VA(200 in ICR #10060
 ; Reference to DEM^VADPT in ICR #10061
 ; Reference to ^OR(100 in ICR 5771
 Q
 ;
CLEANDATA ;
 N ORDERIENS,ORDERIEN,ERROR,POP,REQIEN,DISPOSITION,PATIENT,STATUS
 S POP=0
 S ORDERIEN=""
 D START
 D ORDPROMPT(.ORDERIENS,.POP) Q:POP
 D DEVICEPROMPT
 F  S ORDERIEN=$O(ORDERIENS(ORDERIEN)) Q:ORDERIEN=""  D
 . N STATUS,REQIEN,ORDSTAT,DISPSOTION,PATIENT
 . S POP=0
 . D CHECKORDERSTAT(ORDERIEN,.STATUS,.POP)
 . D:'POP GETREQUESTIEN(ORDERIEN,.REQIEN,.POP)
 . D:'POP GETDISPOSITION(REQIEN,.ORDSTAT,.POP,.DISPOSITION)
 . D:'POP MATCHORDTOREQ(ORDERIEN,REQIEN,.POP,.PATIENT)
 . D:'POP CLEANUPSTEPS(ORDERIEN,STATUS,DISPOSITION,PATIENT,REQIEN,POP)
 D FIN
 Q
 ;
DEVICEPROMPT ;prompt for device
 D ^%ZIS Q:POP
 U IO
 Q
 ;
FIN ;Show final results
 ;
 D ^%ZISC
 Q
 ;
GETDISPOSITION(REQIEN,ORDSTAT,POP,DISPOSITION) ;
 I $$GET1^DIQ(409.85,REQIEN_",",23,"E")="OPEN" D
 . S POP=1
 . W !,"Request for Order is still open, no status update"
 Q:POP
 S DISPOSITION=$$GET1^DIQ(409.85,REQIEN_",",21)
 Q
ORDPROMPT(ORDERIENS,POP) ;enter order number
 NEW DIC,Y,X,LEAVE
 S LEAVE=0
 F  Q:(LEAVE)!(POP)  D
 . S DIC("A")="Enter the Order Number: "
 . S DIC=100,DIC(0)="AEQN" D ^DIC
 . S:(X="") LEAVE=1
 . S:(X="^") POP=1
 . Q:LEAVE!POP
 . S X=$TR(X,"`")
 . S ORDERIENS(X)=""
 Q
CHECKORDERSTAT(ORDERIEN,STATUS,POP) ;is order status in range
 S POP=0
 S STATUS=$$GET1^DIQ(100,ORDERIEN_",",5,"E")
 S POP=$S(STATUS="PENDING":0,STATUS="PARTIAL RESULTS":0,1:1)
 I POP W !,"Current status for ORDER ",ORDERIEN," is ",STATUS,".  No status change."
 Q
GETREQUESTIEN(ORDERIEN,REQIEN,POP) ;get request IEN
 N PARENTREQ
 S REQIEN=$$GET1^DIQ(100,ORDERIEN_",",33,"I")
 S PARENTREQ=$$GET1^DIQ(409.85,REQIEN_",",43.8,"I")
 S:PARENTREQ'="" REQIEN=PARENTREQ
 I (REQIEN="")!($$GET1^DIQ(409.85,REQIEN_",",.01)="") D
 . W !,"Could not find request on ORDER.  Please submit a YourIT ticket for the Scheduling Team."
 . S POP=1
 Q
MATCHORDTOREQ(ORDERIEN,REQIEN,POP,OBJOFORDER) ; Match order with request quit if they do not match
 NEW REQORDER,REQORIGUSR,REQPATIENT,WHOORDERED
 S OBJOFORDER=$P($$GET1^DIQ(100,ORDERIEN_",",.02,"I"),";",1)
 Q:$$GET1^DIQ(409.85,REQIEN_",",46,"I")=ORDERIEN
 S OBJOFORDER=$P($$GET1^DIQ(100,ORDERIEN_",",.02,"I"),";",1)
 S REQPATIENT=$$GET1^DIQ(409.85,REQIEN_",",.01,"I")
 S REQORIGUSR=$$GET1^DIQ(409.85,REQIEN_",",9,"I")
 S WHOORDERED=$$GET1^DIQ(100,ORDERIEN_",",3,"I")
 ;
 I (OBJOFORDER'=REQPATIENT)!(REQORIGUSR'=WHOORDERED) D
 . S POP=1
 . W !,"Order did not match request. Please submit a YourIT ticket for the Scheduling Team."
 Q:POP
 D UPDATEREQ(REQIEN,ORDERIEN)
 Q
UPDATEREQ(REQIEN,ORDERIEN) ;update order field in request with order if missing
 N FDA,FDAERR
 S FDA(409.85,REQIEN,46)=ORDERIEN
 D FILE^DIE(,"FDA","FDAERR") K FDA
 Q
 ;
CLEANUPSTEPS(ORIEN,ORSTATUS,DISPOSITION,SDPATIENT,SDIEN,POP) ;
 N DFN,SDDISPBY,SDDISPDT
 S SDDISPBY=$$GET1^DIQ(409.85,REQIEN_",",20,"I")
 I +SDDISPBY=0 D
 . W !,"Disposition By field is missing from request.  Status has not been udpated."
 . S POP=1
 S SDDISPDT=$$GET1^DIQ(409.85,REQIEN_",",19,"I")
 I +SDDISPDT=0 D
 . W !,"Disposition Date field is missing from request.  Status has not been updated."
 . S POP=1
 Q:POP
 S ORDIS=$S(DISPOSITION="REMOVED/SCHEDULED-ASSIGNED":0,DISPOSITION="MRTC PARENT CLOSED":0,1:1)
 K VADM S DFN=SDPATIENT D DEM^VADPT ; ICR #10061
 ;  Send HL7 message to update CPRS order file entry.
 ;
 D SDHL7BLD(SDIEN,ORIEN,SDDISPBY,DFN,VADM(1),ORDIS) ;
 ;
 W !,"ORDER "_ORIEN_" was successfully updated."
 Q
 ;
START ;Show introductory text
 ;
 W !!,"This OPTION will verify if the entered ORDER is stuck in the incorrect status. "
 W " The status will be updated based on the Request status."
 Q
 ;
SDHL7BLD(SDIEN,ORIEN,SDDISPBY,SDPATIENT,PATNAME,ORDIS) ;
 N NUMBAPPTS
 ;
 ;  Build HL7 message to send to CPRS to update order file.
 ;
 N INPUTS,CLINIC ;
 ;
 S INPUTS("REQ FILE IEN")=SDIEN ;  Appointment request
 ;
 S INPUTS("CLINIC")=$$GET1^DIQ(409.85,SDIEN,8,"I")_U_$$GET1^DIQ(409.85,SDIEN,8,"E") ;clinic
 ;
 S INPUTS("COMMENT")="RTC dispositioned by clean up process." ;
 ;
 S INPUTS("DISPOSITION BY")=SDDISPBY_U_$$GET1^DIQ(200,SDDISPBY,.01,"E") ;  Dispositioned by
 ;
 S INPUTS("DISCONTINUE")=ORDIS ;  Disposition
 ;
 S NUMBAPPTS=$$GET1^DIQ(409.85,SDIEN,43,"I")
 S INPUTS("NUMBER APPT")=$S(NUMBAPPTS>1:NUMBAPPTS,1:1)
 ;
 S INPUTS("ORDER IEN")=ORIEN ;  Order file (#100) pointer
 ;
 S INPUTS("PATIENT")=SDPATIENT_U_PATNAME ;  Patient pointer and name
 ;
 S INPUTS("RTC DATE")=$P(^SDEC(409.85,SDIEN,0),U,16) ;  CID
 ;
 D EN^SDHL7BLD(.INPUTS) ;
 Q  ;

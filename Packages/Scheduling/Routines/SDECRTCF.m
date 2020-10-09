SDECRTCF ;ALB/WTC - Clean-up of Pending RTC orders with closed SDEC Appt Requests ;May 07, 2020@11:10
 ;;5.3;Scheduling;**745**;Aug 13, 1993;Build 40
 ;;Per VHA Directive 2004-038, this routine should not be modified
 ;
 ;  Close RTC orders in CPRS if the corresponding order in Appointment Request file (#409.85) was closed (appointment made) or otherwise dispositioned.
 ;  Based on routine from Ty Phelps.
 ;
 ;  ICR
 ;  ---
 ;   2638 - file #100.01
 ;   7156 - file #100
 ;  10060 - file #200
 ;  10061 - DEM^VADPT
 Q
 ;
BYDATE ;
 ;
 ;  Entry Point for clean-up with user specified dates
 ;
 N CDT,CNT,DIR,DIROUT,DIRUT,DTOUT,DUOUT,SDEDT,SDSDT,X,Y ;
 ;
 S CNT=0 ;
 D START ;
 W !! ;
 S CDT=$$FMTE^XLFDT(+DT,5) ;
 ;
STRTDT ;
 ;
 S DIR(0)="DAO^3170101:"_+DT_":EX",DIR("A")="SDEC APPOINTMENT REQUEST START DATE: ",DIR("B")=$$FMTE^XLFDT($$FMADD^XLFDT(+DT,-30),5) ;
 S DIR("?",1)="Enter the date to start the SDEC APPT REQUEST search.",DIR("?")="The date must be between 1/1/2017 and "_CDT ;
 D ^DIR Q:+Y<1  ;
 I +Y>0 S SDSDT=Y ;
 ;
ENDDT ;
 ;
 K DIROUT,DIRUT,DTOUT,DUOUT ;
 S (X,Y)="" ;
 S DIR(0)="DAO^"_SDSDT_":"_+DT_":EX",DIR("A")="SDEC APPOINTMENT REQUEST END DATE: ",DIR("B")=$$FMTE^XLFDT(+DT,5) ;
 S DIR("?",1)="Enter the date to stop the SDEC APPT REQUEST search.",DIR("?")="The date must be between "_$$FMTE^XLFDT(SDSDT,5)_" and "_CDT ;
 D ^DIR ;
 G STRTDT:+$G(DTOUT) ;
 Q:+Y<1  ;
 I +Y>0 S SDEDT=Y ;
 D LOOP(SDSDT,SDEDT),FIN(CNT) ;
 Q
 ;
FULL ;
 ;
 ;  Perform a full clean-up starting from 1/1/2017
 ;
 N CNT,SDSDT,SDEDT ;
 D START ;
 S SDSDT=3170101,SDEDT=999999999,CNT=0 ;
 D LOOP(SDSDT,SDEDT),FIN(CNT) ;
 Q
 ;
LOOP(SDSDT,SDEDT) ;
 ;
 ;  Loop through closed SDEC APPT REQUESTS to complete corresponding RTC Orders
 ;
 N %H,CMT,CMTE,DTPURG,END,INPUT,ORDIS,ORIEN,ORPENDING,ORSTATUS,SDCDT,SDDISP,SDDISPBY,SDDISPDT,SDEC0,SDECDIS,SDIEN,SDPAR,SDPATIENT,SDRQTYPE,STOP,DFN,VADM ;
 ;
 W !!,"Starting search and clean-up...." ;
 ;
 S SDCDT=$$FMADD^XLFDT(SDSDT,-1),DTPURG=$$FMADD^XLFDT(+DT,7),END=0 ;
 S ORPENDING=+$O(^ORD(100.01,"B","PENDING",0)) ; ICR #2638
 S CMT="Orders changed to Completed based on SDEC APPT REQUEST being in status of Closed"
 S CMTE="Errors during Orders being changed to Completed based on SDEC APPT REQUEST being in status of Closed"
 ;
 S ^XTMP("OR PENDING RTC CLEAN-UP-"_$$FMTE^XLFDT(DT),0)=DTPURG_U_+DT_U_CMT ;
 ;
 ;  Loop thru closed SDEC APPT REQUESTS
 ;
 F  S SDCDT=$O(^SDEC(409.85,"E","C",SDCDT)) Q:SDCDT=""  D  Q:END  ;
 . I SDCDT>SDEDT S END=1 Q  ;
 . S SDIEN="" F  S SDIEN=$O(^SDEC(409.85,"E","C",SDCDT,SDIEN)) Q:SDIEN=""  D  ;
 .. K INPUT ;
 .. S SDEC0=$G(^SDEC(409.85,SDIEN,0)),SDRQTYPE=$P(SDEC0,U,5) Q:SDRQTYPE'="RTC"  ;  Skip if not RTC order.
 .. ;
 .. S ORIEN=+$P($G(^SDEC(409.85,SDIEN,7)),U,1) Q:ORIEN=0  ;  Skip if not sourced from CPRS (bad data)
 .. S ORSTATUS=$$GET1^DIQ(100,ORIEN,5,"I") ; ICR #7156
 .. Q:ORSTATUS'=ORPENDING  ;  Skip if order is not pending
 .. ;
 .. S SDECDIS=$G(^SDEC(409.85,SDIEN,"DIS")),SDPATIENT=+$P(SDEC0,U,1) Q:SDPATIENT=0  ;  Skip if patient pointer missing (bad data)
 .. ;
 .. S SDDISPBY=+$P(SDECDIS,U,2) Q:SDDISPBY=0  ;  Skip if dispositioned by field is missing
 .. S SDDISPDT=$P(SDECDIS,U,1) Q:SDDISPDT=""  ;  Skip if disposition date is missing
 .. S SDDISP=$P(SDECDIS,U,3) Q:SDDISP=""      ;  Skip if disposition is missing
 .. ;
 .. I +$P($G(^SDEC(409.85,SDIEN,3)),U,5) Q    ;  Skip if child request
 .. ;
 .. S ORDIS=$S(SDDISP="SA":0,SDDISP="MC":0,1:1) ;
 .. ;
 .. K VADM S DFN=SDPATIENT D DEM^VADPT ; ICR #10061
 .. ;
 .. ;  For child request, skip if parent closed.  I don't think this code will ever apply since child requests are ignored.
 .. ;
 .. S STOP=0
 .. S SDPAR=+$P(^SDEC(409.85,SDIEN,3),U,5) I SDPAR D
 .. . I $P($G(^SDEC(409.85,SDPAR,0)),U,17)="C" S STOP=1 Q
 .. . ;S INPUT("PARTIAL")=1
 .. I STOP=1 Q  ;Don't process partials if Parent closed
 .. ;
 .. ;  Send HL7 message to update CPRS order file entry.
 .. ;
 .. W "." D SDHL7BLD(SDIEN,ORIEN,SDDISPBY,DFN,VADM(1),ORDIS) ;
 .. ;
 .. ;  Store record of entry closed.
 .. ;
 .. S CNT=CNT+1,^XTMP("OR PENDING RTC CLEAN-UP-"_$$FMTE^XLFDT(DT),$J,ORIEN,0)=SDIEN_U_SDPATIENT_U_SDDISPDT_U_SDDISPBY_U_SDDISP_U_ORSTATUS ;
 ;
 Q
 ;
START ;Show introductory text
 ;
 W !!,"This routine will search through existing Closed Return to Clinic",!,"SDEC Appointment Requests with a corresponding Order that is in a",!,"Pending status and update as needed." ;
 Q
 ;
FIN(CNT) ;Show final results
 ;
 W !!!!,"Search and clean-up is complete!!!!",!,CNT," Orders were updated!" ;
 ;
 I CNT>0 W !!,"Orders that are updated will be saved for 7 days in the",!,"^XTMP(""OR PENDING RTC CLEAN-UP-"""_$$FMTE^XLFDT(DT)_",$J) global." ;
 Q
 ;
SDHL7BLD(SDIEN,ORIEN,SDDISPBY,SDPATIENT,PATNAME,ORDIS) ;
 ;
 ;  Build HL7 message to send to CPRS to update order file.
 ;
 N INPUTS,CLINIC ;
 ;
 S INPUTS("REQ FILE IEN")=SDIEN ;  Appointment request
 ;
 S CLINIC=$P(^SDEC(409.85,SDIEN,0),U,16),INPUTS("CLINIC")=CLINIC_U_$$GET1^DIQ(44,CLINIC,.01,"E") ;  Clinic
 ;
 S INPUTS("COMMENT")="RTC dispositioned by clean up process." ;
 ;
 S INPUTS("DISPOSITION BY")=SDDISPBY_U_$$GET1^DIQ(200,SDDISPBY,.01,"E") ;  Dispositioned by
 ;
 S INPUTS("DISCONTINUE")=ORDIS ;  Disposition
 ;
 S INPUTS("NUMBER APPT")=1 ;
 ;
 S INPUTS("ORDER IEN")=ORIEN ;  Order file (#100) pointer
 ;
 S INPUTS("PATIENT")=SDPATIENT_U_PATNAME ;  Patient pointer and name
 ;
 S INPUTS("RTC DATE")=$P(^SDEC(409.85,SDIEN,0),U,16) ;  CID
 ;
 D EN^SDHL7BLD(.INPUTS) ;
 Q  ;

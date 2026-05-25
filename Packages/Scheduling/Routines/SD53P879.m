SD53P879 ;TMP/GN - SD*5.3*879 Post Init Routine ;June 12, 2023
 ;;5.3;Scheduling;**879**;Aug 13, 1993;Build 31
 ;
 ; Cleanup the SDEC APPT REQUEST file (#409.85).  
 ; TMP had stored in the an IEN in the PARENT REQUEST field (#43.8) and this field is reserved for MRTC appts made by VSE.
 ; This utility will follow the logic below to find and erase this field, so VSE can once again Cancel those appointments normally.
 ;   also, these records were usually normal RTC/APPT records that this bad parent ien triggered CPRS so show Order stgatus "partial results" instead of "completed".
 ;   make HL7 api call to send the correct status to the records as they are fixed by erasing that parent field value.
 ; *** post install can be rerun with no harm ***
 ;
 Q
EN ; entry point
 N DFN,PARENT,CHILD,MRTC,FIX,TOT,QQ,RR
 S (FIX,TOT)=0
 D MES^XPDUTL("")
 D MES^XPDUTL("Updating of the SDEC APPT REQUEST file...")
 D MES^XPDUTL("")
 D MES^XPDUTL("   An email with the results of this cleanup will be sent to the installer ")
 D MES^XPDUTL("   Please forward this email to the Schedulers for their use.")
 D MES^XPDUTL("") H 4
 ;
 S QQ=$$FMADD^XLFDT(DT,-1096)  ;start look back 3 years
 F  S QQ=$O(^SDEC(409.85,"AC",QQ)) Q:'QQ  D
 . F RR=0:0 S RR=$O(^SDEC(409.85,"AC",QQ,RR)) Q:'RR  D
 .. F CHILD=0:0 S CHILD=$O(^SDEC(409.85,"AC",QQ,RR,CHILD)) Q:'CHILD  D
 ... S TOT=TOT+1
 ... S MRTC=$P($G(^SDEC(409.85,CHILD,3)),U)       ;mrtc ind
 ... S PARENT=$P($G(^SDEC(409.85,CHILD,3)),U,5)   ;parent ptr
 ... I 'MRTC,PARENT D                             ;child mrtc ind is 0 and child had parent ptr ?Rec in error?
 .... S DFN=$$GET1^DIQ(409.85,CHILD,.01,"I")
 .... I '$D(^SDEC(409.85,PARENT)) D ERASE                                         ;child points to non-existent parent erase parent ptr from child rec
 .... I $D(^SDEC(409.85,PARENT)),'$D(^SDEC(409.85,PARENT,2,"B",CHILD))  D ERASE   ;if parent exists and if parent does not reference this child rec, then erase parent ptr from child rec
 S ^TMP("SDTMP",$J)=FIX
 D SNDMAIL
 D MES^XPDUTL("")
 D MES^XPDUTL("Update completed. Records examined: "_TOT)
 D MES^XPDUTL("                     Records fixed: "_FIX)
 D MES^XPDUTL("") H 1
 Q
 ;
ERASE ;
 N APPDT,CIDDT,FDA,LSTNAM1,REQTYP,SSN4,STATUS
 S FIX=FIX+1
 S FDA(409.85,CHILD_",",43.8)="@" D UPDATE^DIE("","FDA","ERR")  ;erase parent field data
 ;build text line for mailman msg
 S LSTNAM1=$E($$GET1^DIQ(2,DFN,"NAME"),1,1)
 S SSN4=$E($$GET1^DIQ(2,DFN,"SSN"),6,9)
 S APPDT=$$GET1^DIQ(409.85,CHILD,"SCHEDULED DATE OF APPT","I")
 S CIDDT=$$GET1^DIQ(409.85,CHILD,"CID/PREFERRED DATE OF APPT","I")
 S STATUS=$$GET1^DIQ(409.85,CHILD,"CURRENT STATUS","I")
 S REQTYP=$$GET1^DIQ(409.85,CHILD,"REQUEST TYPE","I")
 I REQTYP="RTC",STATUS="C" D ARDISP^SDECHL7(CHILD,"")  ;if REQ rec is "RTC" & "CLOSED" then re-update CPRS by HL7 call, so CPRS displays a status of "complete" vs "partial results"
 S ^TMP("SDTMP",$J,FIX+4)="Patient: "_LSTNAM1_SSN4_$S('APPDT:" Req CID: "_$$FMTE^XLFDT(CIDDT),1:" Appt: "_$$FMTE^XLFDT(APPDT))_" was corrected.  Req ien:"_CHILD
 Q
 ;
SNDMAIL ;send mailman to installer
 N XMSUB,XMY,XMTEXT,XMDUZ
 S ^TMP("SDTMP",$J,1)="Patient appointment date/times that were fixed, can now be accessed by VSE."
 S ^TMP("SDTMP",$J,2)="  Appt Request CID records fixed below and also CPRS Order tab status"
 S ^TMP("SDTMP",$J,3)="  changed RTC orders from status 'partial results' to 'complete'."
 S ^TMP("SDTMP",$J,4)=""
 I ^TMP("SDTMP",$J)=0 S ^TMP("SDTMP",$J,4)="** No Appointment Request Records found that needed repair."
 S XMSUB="SD TMP cleanup of MRTC parent field in SDEC APPT REQUEST file #409.85"
 S XMDUZ=.5
 S XMTEXT="^TMP(""SDTMP"",$J,"
 S XMY(DUZ)=""
 N DIFROM D ^XMD K ^TMP("SDTMP",$J)
 Q

SD5396PT ;ALB/JRP - CORRECT REJECTED ENCOUNTERS WITH BAD DATE/TIME;06-MAR-1997
 ;;5.3;Scheduling;**96**;Aug 13, 1993
 ;
TASK ;Entry point to schedule correction for NOW
 ;
 ;Declare variables
 N ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTSK,TXT
 ;Set up call to TaskMan
 S ZTRTN="EN^SD5396PT"
 S ZTDESC="ACRP correction of rejected encounters with bad date/time"
 S ZTDTH=$$NOW^XLFDT()
 S ZTIO=""
 ;Schedule task
 S TXT="Correction of rejected encounters with bad date/time"
 D MES^XPDUTL(TXT)
 S TXT="will be scheduled to run on "_$$FMTE^XLFDT(ZTDTH)
 D MES^XPDUTL(TXT)
 D ^%ZTLOAD
 S:(+$G(ZTSK)) TXT="Scheduled as task number "_ZTSK
 S:('$G(ZTSK)) TXT="** Unable to schedule correction **"
 D BMES^XPDUTL(TXT)
 ;Done
 Q
 ;
EN ;Main entry point
 ;
 ;Declare variables
 N CODE420,CODE421,ERRPTR,ERRNODE,XMITPTR,TMP,TIMESTRT,FIXED
 N MSGTEXT,XMTEXT,XMSUB,XMY,XMCHAN,XMZ,XMDUZ
 ;Get pointer to error codes 420 & 421
 S CODE420=+$O(^SD(409.76,"B",420,0))
 Q:('CODE420)
 S CODE421=+$O(^SD(409.76,"B",421,0))
 Q:('CODE421)
 ;Remember starting time
 S TIMESTRT=$$FMTE^XLFDT($$NOW^XLFDT(),1)
 ;Loop through rejected encounters
 S FIXED=0
 S ERRPTR=0
 F  S ERRPTR=+$O(^SD(409.75,ERRPTR)) Q:('ERRPTR)  D  Q:(+$G(ZTSTOP))
 .I ($$S^%ZTLOAD) S ZTSTOP=1 Q
 .;Get zero node
 .S ERRNODE=$G(^SD(409.75,ERRPTR,0))
 .;Check error code
 .S TMP=+$P(ERRNODE,"^",2)
 .Q:((TMP'=CODE420)&(TMP'=CODE421))
 .;Get pointer to Transmitted Outpatient Encounter file (#409.73)
 .S XMITPTR=+$G(^SD(409.75,ERRPTR,0))
 .Q:('$D(^SD(409.73,XMITPTR,0)))
 .;Fix date/time of entry in Transmitted Outpatient Encounter file
 .D FIXDATE(XMITPTR)
 .;Mark entry in Transmitted Outpatient Encounter file for retransmission
 .D STREEVNT^SCDXFU01(XMITPTR)
 .D XMITFLAG^SCDXFU01(XMITPTR)
 .;Increment count of fixed encounters
 .S FIXED=FIXED+1
 ;Build completion bulletin
 S MSGTEXT(1)=" "
 S MSGTEXT(2)="Correction was started on "_TIMESTRT
 S MSGTEXT(3)="Correction ended on "_$$FMTE^XLFDT($$NOW^XLFDT(),1)
 S MSGTEXT(4)=FIXED_" Outpatient Encounters were corrected"
 S MSGTEXT(5)=" "
 ;Send completion bulletin to current user
 S XMSUB="ACRP correction of rejected encounters with bad date/time completed"
 S XMTEXT="MSGTEXT("
 S XMY(DUZ)=""
 S XMCHAN=1
 S XMDUZ="ACRP - SD*5.3*96"
 D ^XMD
 ;Done
 Q
 ;
FIXDATE(XMITPTR) ;Fix encounter date/time for entry in 409.73
 ;
 ;Input  : XMITPTR - Pointer to entry in TRANSMITTED OUTPATIENT
 ;                   ENCOUNTER file (#409.73)
 ;Output : None
 ;
 ;Check input
 S XMITPTR=+$G(XMITPTR)
 Q:('$D(^SD(409.73,XMITPTR,0)))
 ;Declare variables
 N XMITNODE,ENCPTR,DELPTR,VSITPTR,VSITDATE
 ;Get zero node of entry in Transmitted Outpatient Encounter
 S XMITNODE=$G(^SD(409.73,XMITPTR,0))
 ;Get pointer to Outpatient Encounter file (#409.68)
 S ENCPTR=+$P(XMITNODE,"^",2)
 ;Get pointer to Deleted Outpatient Encounter file (#409.74)
 S DELPTR=+$P(XMITNODE,"^",3)
 Q:(('ENCPTR)&('DELPTR))
 I (ENCPTR) Q:('$D(^SCE(ENCPTR,0)))
 I (DELPTR) Q:('$D(^SD(409.74,DELPTR,1)))
 ;Determine correct date/time of encounter
 I (ENCPTR) D
 .;Get pointer to Visit file (#9000010)
 .S VSITPTR=+$P($G(^SCE(ENCPTR,0)),"^",5)
 .;Get date/time of visit
 .S VSITDATE=+$G(^AUPNVSIT(VSITPTR,0))
 ;Determine correct date/time of deleted encounter
 I (DELPTR) D
 .;New date/time is validated version of currently stored date/time
 .S VSITDATE=+$G(^SD(409.74,DELPTR,1))
 .S VSITDATE=+$$DATECHCK^SDVSIT(VSITDATE)
 ;Update date/time of encounter and mark for retransmission
 D NEWDATE(ENCPTR,DELPTR,VSITDATE)
 ;Done
 Q
 ;
NEWDATE(ENCPTR,DELPTR,NEWDATE) ;Store new encounter date/time
 ;
 ;Input  : ENCPTR - Pointer to entry in OUTPATIENT ENCOUNTER file
 ;                  (#409.68)
 ;         DELENC - Pointer to entry in DELETED OUTPATIENT ENCOUNTER
 ;                  file (#409.74)
 ;         NEWDATE - New date/time (FileMan format)
 ;Output : None
 ;Notes  : If NEWDATE is not passed, the date/time currently on file
 ;         will be validated and used as the new date/time
 ;
 ;Check input
 S ENCPTR=+$G(ENCPTR)
 I (ENCPTR) Q:('$D(^SCE(ENCPTR,0)))
 S DELPTR=+$G(DELPTR)
 I (DELPTR) Q:(('$D(^SD(409.74,DELPTR,0)))!('$D(^SD(409.74,DELPTR,1))))
 Q:(('ENCPTR)&('DELPTR))
 S NEWDATE=+$G(NEWDATE)
 I ('NEWDATE) S:(ENCPTR) NEWDATE=+^SCE(ENCPTR,0) S:(DELPTR) NEWDATE=+^SD(409.74,DELPTR,1)
 S NEWDATE=+$$DATECHCK^SDVSIT(NEWDATE)
 ;Declare variables
 N SDINARR,SDOUTARR,DELNODE1,IENS
 ;Set up FDA array for updating Outpatient Encounter
 I (ENCPTR) D
 .S IENS=ENCPTR_","
 .S SDINARR(409.68,IENS,.01)=NEWDATE
 ;Set up FDA array for updating Deleted Outpatient Encounter
 I (DELPTR) D
 .S IENS=DELPTR_","
 .S SDINARR(409.74,IENS,.01)=NEWDATE
 .S DELNODE1=^SD(409.74,DELPTR,1)
 .S $P(DELNODE1,"^",1)=NEWDATE
 .S SDINARR(409.74,IENS,11)=DELNODE1
 ;Store new encounter date/time
 D FILE^DIE("","SDINARR","SDOUTARR")
 ;Done
 Q

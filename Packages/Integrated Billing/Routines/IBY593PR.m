IBY593PR ;EDE/HN - Pre-Installation for IB patch 593 ; 17-APR-2017
 ;;2.0;INTEGRATED BILLING;**593**;21-MAR-94;Build 31
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; post routine stuff is below
POST ; POST ROUTINE(S)
 N IBXPD,IBPRD,XPDIDTOT
 S XPDIDTOT=3
 ;
 ; Determine if we're in a TEST or a PRODUCTION environment.
 S IBPRD=$S($$PROD^XUPROD(1)=1:"P",1:"T")
 ;
 ; Reindex Patient File for fields 2.312,3 and 2.312,8
 D REINDEX(1)
 D PATIENT(2)
 D ADDSOI(3)
 D DONE
 Q
 ;
DONE ; Displays the 'Done' message and finishes the progress bar
 D MES^XPDUTL("")
 D MES^XPDUTL("POST-Install Completed.")
 Q
 ;
REINDEX(IBXPD) ; Run new indices.  This is needed for entries at site not in file coming across.
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Building new ACHI index in the background ")
 N MSG,ZTDESC,ZTRTN,ZTQUEUED
 S ZTQUEUED=""
 S ZTDESC="IBCN CREATE ACHI INDEX"
 S ZTRTN="XREF^IBCNERTC"
 S MSG=$$TASK("NOW",ZTDESC,ZTRTN)
 D MES^XPDUTL(MSG)
 D UPDATE^XPDID(IBXPD)
 Q
 ;
PATIENT(IBXPD) ; Kick off Patient file update of Covered by Health Insurance flag (2.3192)
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Tasking Covered by Health Insurance update ... ")
 N MSG,ZTDESC,ZTRTN,ZTQUEUED
 S ZTQUEUED=1
 S ZTDESC="IBCN COVERED BY HEALTH INSURANCE FLAG UPDATE"
 S ZTRTN="UPATF^IBCNERTC"
 S MSG=$$TASK("T@2100",ZTDESC,ZTRTN)
 D MES^XPDUTL(MSG)
 D UPDATE^XPDID(IBXPD)
 Q
 ;
ADDSOI(IBXPD) ; Add new Source of Information.
 N IBLN,IBPCE,IBDATA,IBERR,IBIEN,IBSTR
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Adding New Source of Information Codes ... ")
 F IBLN=2:1 S IBSTR=$P($T(EN35512+IBLN),";;",2) Q:IBSTR=""  D
 . F IBPCE=1:1:3 S IBDATA(IBPCE/100)=$P(IBSTR,U,IBPCE)
 . I $D(^IBE(355.12,"C",IBDATA(.02))) D  Q
 .. D MES^XPDUTL("  "_IBDATA(.02)_" ALEADY EXISTS IN THE SOURCE OF INFORMATION TABLE (#355.12)") Q
 . S IBIEN=$$ADD^IBDFDBS(355.12,,.IBDATA,.IBERR)
 . I IBERR D  Q
 .. D BMES^XPDUTL("*** ERROR ADDING "_IBDATA(.02)_" CODE TO THE SOURCE OF INFORMATION TABLE (#355.12) ***")
 . D BMES^XPDUTL("  "_$$GET1^DIQ(355.12,IBIEN_",",.02)_" CODE ADDED TO THE SOURCE OF INFORMATION TABLE (#355.12)")
 D MES^XPDUTL("STEP "_IBXPD_" of "_XPDIDTOT_" COMPLETE")
 D UPDATE^XPDID(IBXPD)
 Q
 ;
EN35512 ; Add Source of Information Codes
 ;
 ;;13^INSURANCE IMPORT^INSPT
 ;;14^PURCHASED CARE CHOICE^PCC
 ;;15^PURCHASED CARE FEE-BASIS^PCFB
 ;;16^PURCHASED CARE OTHER^PCOTR
 ;;17^INSURANCE INTAKE^INSIN
 ;;18^INSURANCE VERIFICATION^INSVR
 ;;19^VETERAN APPT REQUEST^VAR
 ;
 Q
 ;
TASK(X,ZTDESC,ZTRTN) ;bypass for queued task
 N Y,IDT,XDT,TSK,MSG,ZTIO,ZTSK
 S %DT="FR"
 D ^%DT
 S IDT=Y D DD^%DT S XDT=Y
 ;
 ;Check if task already scheduled for date/time
 S TSK=$$GETTASK(IDT)
 I TSK D  G TASKQ
 . S Y=$P(TSK,U,2) D DD^%DT
 . S MSG=" Task (#"_+TSK_") already scheduled to run on "_Y
 ;
 ;Schedule the task
 S TSK=$$SCHED(IDT)
 ;
 ;Check for scheduling problem
 I '$G(TSK) S MSG=" Task Could Not Be Scheduled" G TASKQ
 ;
 ;Send successful schedule message
 S MSG=" Update Covered by Health Insurance Flag Scheduled for "_XDT
 ;
TASKQ ;
 Q MSG
 ;
GETTASK(IDT) ;
 N TASK,TASKNO,TDT,XUSUCI,Y,ZTSK0
 ;
 ;Retrieve UCI
 X ^%ZOSF("UCI") S XUSUCI=Y
 ;       
 S (TASK,TDT)=0,TASKNO=""
 F  S TASK=$O(^%ZTSK(TASK)) Q:'TASK  D  Q:TASKNO
 .I $G(^%ZTSK(TASK,.03))[ZTDESC D
 ..S ZTSK0=$G(^%ZTSK(TASK,0))
 ..;
 ..;Exclude tasks scheduled by TaskMan
 ..Q:ZTSK0["ZTSK^XQ1"
 ..;
 ..;Exclude tasks in other ucis
 ..Q:(($P(ZTSK0,U,11)_","_$P(ZTSK0,U,12))'=XUSUCI)
 ..;
 ..;Check for correct date and time
 ..S TDT=$$HTFM^XLFDT($P(ZTSK0,"^",6))
 ..;I TDT=IDT S TASKNO=TASK
 Q TASKNO_U_TDT
 ;
SCHED(ZTDTH) ;
 N XUSUCI,ZTIO,ZTSK
 ;Retrieve UCI
 X ^%ZOSF("UCI") S XUSUCI=Y
 S ZTIO=""
 D ^%ZTLOAD
 Q ZTSK

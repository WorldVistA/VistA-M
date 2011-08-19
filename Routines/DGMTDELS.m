DGMTDELS ;ALB/GAH - Delete means test for deceased patient; August 14, 2006 14:35:54
 ;;5.3;Registration;**714**;Aug 14, 2006;Build 5
 ;
 ; This routine deletes a patient's last means test if the patient
 ; is deceased and the last means test has a status of REQUIRED.
 ; It can be run in foreground at CHECK, OK2DELMT, or DELMT.  It
 ; can be queued to run in background by calling line tag START. 
 ;
 ; Must be run from line tag
 Q
 ;
START(DFN) ;Start process
 N NAMSPC,TASK,U
 S U="^"
 D QUEUE($$QTIME)
 Q
QUEUE(ZTDTH)    ; Queue the process
 N NAMSPC,ZTRTN,ZTDESC,ZTIO,ZTSK
 S NAMSPC=$$NAMSPC
 S ZTRTN="CHECK^DGMTDELS("_DFN_")"
 S ZTDESC=NAMSPC_" - Remove REQUIRED MT for deceased patients"
 S ZTIO=""
 D ^%ZTLOAD
 D HOME^%ZIS
 Q
QTIME() ; Get the run time for queuing
 N %,%H,%I,X
 D NOW^%DTC
 Q $P(%,".")_"."_$E($P(%,".",2),1,4)
 ;
NAMSPC() ;
 Q $T(+0)
CHECK(DFN) ; Check that the criteria to delete a means test is met
 N DGMTI
 F  Q:'$$OK2DEL(DFN,.DGMTI)  D DELMT(DGMTI)  ; Delete means test with REQUIRED status
 Q
OK2DEL(DFN,DGMTI) ;
 ; Returns 1 and the last mean test IEN if the patient has a date of death and
 ; the means test has a status of REQUIRED.
 N DGMT,STATUS,U
 S U="^"
 S DGMT=$$LST^DGMTU(DFN)
 Q:DGMT="" 0
 S STATUS=$P(DGMT,U,3)
 S DGMTI=$P(DGMT,U)
 ; Status must be REQUIRED
 Q:STATUS'="REQUIRED" 0
 ; There must be a date of death
 Q:'+$P($G(^DPT(DFN,.35)),U) 0
 Q 1
DELMT(DGMTI) ;
 ; Delete the means test
 N DFN,DGMT0,DGMTD,DGMTYPT,DQ,U
 S U="^"
 S DGMT0=$G(^DGMT(408.31,DGMTI,0))
 Q:DGMT0=""
 S DFN=$P(DGMT0,U,2)
 S DGMTD=$P(DGMT0,U)
 S DGMTYPT=$P(DGMT0,U,19)
 D VAR^DGMTDEL1
 D DEL^DGMTDEL1
 Q

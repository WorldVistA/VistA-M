SDAPICO ;ALB/MJK - API - Common Check-Out Processing;04 MAR 1993 10:00 am
 ;;5.3;Scheduling;**27,44,78,93,132**;Aug 13, 1993
 ;
FILE(SDOE,SDUZ) ; File Data after checks
 ; Input  -- SDOE      Outpatient Encounter IEN
 ;           SDUZ      User ien to file 200
 ; Output -- <none>
 ;
 N SDOE0,SDORG
 IF '$G(SDOE) D ERRFILE^SDAPIER(110) G FILEQ
 S SDOE0=$G(^SCE(+SDOE,0)),SDORG=$P(SDOE0,U,8)
 ;
 ; -- warning if check-out not required (for old appts)
 IF $$REQ^SDM1A(+SDOE0)'="CO" D ERRFILE^SDAPIER(1030)
 ;
 ; -- warning if not appt and not a clinic
 IF SDORG=1,'$$CLINIC^SDAMU($P(SDOE0,"^",4)) D ERRFILE^SDAPIER(130,$P(SDOE0,U,4)) G FILEQ
 ;
 ; -- warning if patient was inpatient at time of appt
 IF $$INP^SDAM2(+$P(SDOE0,"^",2),+SDOE0)="I" D ERRFILE^SDAPIER(1031,+SDOE0)
 ;
 ; -- process data
 D CLASS^SDAPICO1(SDOE) I $$ERRCHK^SDAPIER() G FILEQ
 ;
FILEQ Q
 ;
 ;
DEL(SDOE,SDFL,SDVAL) ; -- delete entry in file if match
 N DA,DIK,SDI
 S SDI=0
 F  S SDI=$O(^SDD(SDFL,"AO",+SDOE,+SDVAL,SDI)) Q:'SDI  S DIK="^SDD("_SDFL_",",DA=SDI D ^DIK K DIK,DA
 Q
 ;

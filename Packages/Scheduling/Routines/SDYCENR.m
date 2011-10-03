SDYCENR ;ALB/CAW - CLINIC ENROLLMENT ; 7/18/94
 ;;5.3;Scheduling;**21**;Aug 13, 1993
 ;
EN N SDFLAG,SDASH,SDPAGE,SDQUIT
 D WRT,INIT
 S %ZIS="PMQ" D ^%ZIS I POP G ENQ
 I '$D(IO("Q")) D LOOP G ENQ
 S Y=$$QUE
ENQ K SDASH,SDPAGE,SDQUIT
 D:'$D(ZTQUEUED) ^%ZISC Q
 ;
INIT ; Init variables
 S $P(SDASH,"=",80)="",SDPAGE=0,SDQUIT=0
 Q
LOOP ; Loop through the enrollment info
 N SDCLIN,SDCLN,SDENR,SDENROL,SDPAT
 K ^DPT("AEB1")
 K ^TMP("EN2",$J) S SDPAT=0
 F  S SDPAT=$O(^DPT(SDPAT)) Q:'SDPAT  D
 .S SDCLN=0 F  S SDCLN=$O(^DPT(SDPAT,"DE",SDCLN)) Q:'SDCLN  S SDCLIN=^(SDCLN,0) D
 ..S SDENR=0 F  S SDENR=$O(^DPT(SDPAT,"DE",SDCLN,1,SDENR)) Q:'SDENR  S SDENROL=^(SDENR,0) D
 ...S ^DPT("AEB1",+SDCLIN,+SDENROL,SDPAT,SDCLN,SDENR)=""
 ...D LOOP1
 D ^SDYCENR1
 Q
 ;
LOOP1 ; Find inactive enrollments with no date of discharge
 I ($P(SDCLIN,U,2)="I"&('$P(SDENROL,U,3))) S SDPT=$G(^DPT(SDPAT,0)) Q:SDPT=""  D
 .S ^TMP("EN2",$J,$P(SDPT,U),$P(SDPT,U,9),$P($G(^SC(+SDCLIN,0)),U))=""
 Q
WRT ;
 W !,"The following will provide a listing which will include patients that "
 W !,"have an inactive enrollment with no date of discharge.  Because the "
 W !,"date of discharge cannot be automatically determined, the dates of "
 W !,"discharge will have to be entered manually via the 'Edit Clinic "
 W !,"Enrollment Data' option.",!
 Q
 ;
QUE() ; -- que job
 ; return: did job que [ 1|yes   0|no ]
 ;
 K ZTSK,IO("Q")
 S ZTDESC="Enrollment Information Report",ZTRTN="LOOP^SDYCENR"
 S (ZTSAVE("SDPAGE"),ZTSAVE("SDASH"),ZTSAVE("SDQUIT"))=""
 D ^%ZTLOAD W:$D(ZTSK) "   (Task: ",ZTSK,")"
 Q $D(ZTSK)

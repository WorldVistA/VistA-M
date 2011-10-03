IBDF14 ;ALB/CJM - AICS LIST CLINIC SETUP ; JUL 20,1993
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
 ;
SETUPS ; -- Lists forms/reports defined in print manager clinic setup
 ;
% N CLINIC,SETUP,NODE,COND,INTRFACE,PAGE,IBQUIT,IBHDT,X,Y,FORM,REPORT,NAME,VAUTD,DIVIS,NEWDIV,CNT,MULTI
 W !!,"AICS Print Manager Clinic Setup Report",!!
 S IBQUIT=0
 D DIVIS G:IBQUIT EXIT
 D DEVICE G:IBQUIT EXIT
 D DQ
 G EXIT
 Q
 ;
EXIT ; -- exit module
 K ^TMP($J,"IBCS")
 I $D(ZTQUEUED) S ZTREQ="@" Q
 D ^%ZISC
 K ZTSK,ZTDESC,ZTSAVE,ZTRTN
 Q
 ;
DQ ; -- entry point from task man
 K ^TMP($J,"IBCS")
 S IBQUIT=0,PAGE=1
 S IBHDT=$$HTE^XLFDT($H,1)
 D ^IBDF14A
 Q
 ;
DEVICE ; -- ask device
 S %ZIS="MQ" D ^%ZIS I POP S IBQUIT=1 Q
 I $D(IO("Q")) S ZTRTN="DQ^IBDF14",ZTDESC="IBD - Print Manager Clinic Setup",ZTSAVE("VA*")="",ZTSAVE("MULTI")="" D ^%ZTLOAD W !,$S($D(ZTSK):"Request Queued Task="_ZTSK,1:"Request Canceled") D HOME^%ZIS S IBQUIT=1 Q
 U IO
 Q
 ;
DIVIS ; -- Select Division
 N X,Y S VAUTD=1,MULTI=0
 I $P($G(^DG(43,1,"GL")),"^",2) S MULTI=1 D DIVISION^VAUTOMA S:Y=-1 IBQUIT=1
 I 'VAUTD S X="" F  S X=$O(VAUTD(X)) Q:'X  S ^TMP($J,"IBCS",$P($G(^DG(40.8,+X,0)),"^"))=""
 Q

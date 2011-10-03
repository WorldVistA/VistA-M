VALMW1 ;MJK/ALB  ;08:33 PM  14 Jan 1993; Conversion Help
 ;;1;List Manager;;Aug 13, 1993
 ;
EN ;;VALM Conversion Analyzer
 N DIC,Y,VALMPKG,VALMPRE,Y
CONV W ! S DIC="^DIC(9.4,",DIC(0)="AEMQZ" D ^DIC K DIC G ENQ:Y<0
 S VALMPKG=+Y,VALMPRE=$P(Y(0),U,2)
 S %ZIS="PMQ" D ^%ZIS I POP G CONV
 I '$D(IO("Q")) D
 .D START
 E  D
 .D QUE
 D ^%ZISC G CONV
ENQ Q
 ;
START ; -- check for sdul references
 N VALMI,VALMPGE,VALMPKGN,VALMY,VALMP,X,VALMHIT,VALMP0,VALMPI,VALMESC,VALMC
 U IO
 S VALMPKGN=$P($G(^DIC(9.4,VALMPKG,0)),U),VALMPGE=0
 D HDR
 W !!,">>> Will determine if package PROTOCOLS refer to 'SDUL'..."
 S VALMC=VALMC+3,VALMP=VALMPRE,VALMESC=0
 F  S VALMP=$O(^ORD(101,"B",VALMP)) Q:VALMP=""!($E(VALMP,1,$L(VALMPRE))'=VALMPRE)  D  Q:VALMESC
 .S VALMPI=0,VALMHIT=0
 . F  S VALMPI=$O(^ORD(101,"B",VALMP,VALMPI)) Q:'VALMPI  D  Q:VALMESC  W:'VALMHIT "...nothing found"
 ..Q:'$D(^ORD(101,VALMPI,0))  S VALMP0=^(0)
 ..D CHK(2) Q:VALMESC  W !!?5,"-> ",VALMP
 ..I $D(^ORD(101,VALMPI,20)),^(20)["SDUL" D CHK(1) Q:VALMESC  W !?10,"Entry Action: ",^(20) S VALMHIT=1
 ..I $D(^ORD(101,VALMPI,15)),^(15)["SDUL" D CHK(1) Q:VALMESC  W !?10,"Exit Action: ",^(15) S VALMHIT=1
 ..I $D(^ORD(101,VALMPI,26)),^(26)["SDUL" D CHK(1) Q:VALMESC  W !?10,"Header Code: ",^(26) S VALMHIT=1
 ..S VALMI=0 K VALMY
 ..F  S VALMI=$O(^ORD(101,VALMPI,10,VALMI)) Q:'VALMI  S X=^(VALMI,0) D  Q:VALMESC
 ...I $P($G(^ORD(101,+X,0)),U)["SDUL" S VALMY($P(^(0),U))=""
 ..I $D(VALMY),'VALMESC D
 ...S VALMHIT=1
 ...D CHK(1) Q:VALMESC  W !?10,"Attached Protocols:"
 ...S X=""
 ...F  S X=$O(VALMY(X)) Q:X=""  D CHK(1) Q:VALMESC  W !?15,"o ",X
 D:'VALMESC TASKS
 Q
 ;
HDR ; -- print header
 S VALMPGE=VALMPGE+1
 W @IOF,!?5,">>> List Manager Conversion Analyzer for '",VALMPKGN,"' <<<",?70,"Page: ",VALMPGE,!
 S VALMC=2
 Q
 ;
CHK(INCR) ; -- check for ff
 N Y,X
 I (VALMC+INCR+3)>IOSL D  G CHKQ:VALMESC
 .I $E(IOST,1,2)="C-" D PAUSE^VALM1 I 'Y S VALMESC=1 Q
 .D HDR
 S VALMC=VALMC+INCR
CHKQ Q
 ;
QUE ; -- que job
 ;
 K ZTSK,IO("Q")
 S ZTDESC="List Manager Conversion Analyzer",ZTRTN="START^VALMW1"
 F X="VALMPRE","VALMPKG" S ZTSAVE(X)=""
 D ^%ZTLOAD W:$D(ZTSK) "   (Task: ",ZTSK,")"
 Q
 ;
TASKS ; -- list tasks
 N I,X
 F I=1:1 S X=$P($T(HELP+I),";",3) Q:X="$END"  D CHK(1) Q:VALMESC  W !,X
 Q
 ;
HELP ;
 ;;
 ;;
 ;;                     Conversion Task Outline
 ;;                     -----------------------
 ;;
 ;;   1) Change all references from SDUL to VALM in your routines
 ;;      (Use a utility like VAX DSM's %RCE.)
 ;;
 ;;   2) Using the above report, change all code references from
 ;;      SDUL to VALM in the indicated PROTOCOL fields.
 ;;      (You can use the Workbench [DO ^VALMWB] to edit protocols.)
 ;;
 ;;   3) If you are going to use List Manager's new 'hidden' menu
 ;;      capability, delete all SDUL protocols from your protocol
 ;;      menus. Otherwise, change all SDUL protocols to VALM protocols
 ;;      of the same name.
 ;;
 ;;      (Note: If 'SDUL EXPAND' was attached to any of your menus
 ;;             then you should always replace it with 'VALM EXPAND'.
 ;;             The expand action is not part of 'VALM HIDDEN
 ;;             ACTIONS' menu.)
 ;;
 ;;   4) If you are going to use 'hidden' menus, then use
 ;;      the Workbench to indicate 'VALM HIDDEN ACTIONS'
 ;;      as the template's hidden menu.
 ;;
 ;;   5) Finally, we recommend that you always use the Workbench to
 ;;      make changes to your List Manager applications.
 ;;
 ;;$END

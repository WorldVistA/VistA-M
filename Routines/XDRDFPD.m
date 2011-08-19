XDRDFPD ;IHS/OHPRD/LAB - find all potential duplicates for an entry in a file ;6/9/08  11:26
 ;;7.3;TOOLKIT;**113**;Apr 25, 1995;Build 5
 ;;Per VHA Directive 2004-038, this routine should not be modified.
START ;
INIT ;Initialization
 W !,"This option will collect all Potential Duplicates for an entry in a file.",!,"It will then add any pairs found to the Duplicate Record file.",!
 D PROCESS
 G:XDRQFLG END
 D INFORM
END D EOJ
 Q
PROCESS ;
 K XDRD
 ; Flag XDRNOPT makes FILE^XDRDQUE not allow selection of PATIENT file - XT*7.3*113
 N XDRNOPT S XDRNOPT=1
 S XDRQFLG=0,XDRDTYPE="b"
 S DIC("A")="Find Potential Duplicates for entry in what file: " D FILE^XDRDQUE
 G:XDRQFLG PROCESSX
 D SETUP
 S XDRGL=^DIC(XDRFL,0,"GL")
 I '$D(XDRCD) D LKUP Q:XDRQFLG
 W:'$D(ZTQUEUED) !!,"Hold On... This may take a little while...",!
 ;
 D POSDUPS^XDRDMAIN
 D:$D(^TMP("XDRD",$J,XDRFL)) CHECK
PROCESSX Q
EOJ ;clean up
 K XDRQFLG,XDRD,XDRDSCOR,XDRDTEST,XDRFL,XDRGL,XDRCD,XDRCD2,XDRDCNT,XDRDMAIN,XDRDTYPE,XDRDUP,XDRDFPD
 K ^TMP("XDRD",$J)
 Q
EN ;Entry Point (caller must pass XDRCD,XDRFL)
 I '$D(XDRCD) S XDRERR=15 D ^XDREMSG G ENX
 I '$D(XDRFL) S XDRERR=14 D ^XDREMSG G ENX
 I '$D(^VA(15.1,XDRFL,0)) S XDRERR=6 D ^XDREMSG G ENX
 D PROCESS
ENX ;
 K XDRDFPD,XDRDSCOR,XDRD,XDRDTEST,XDRGL,XDRCD2,XDRDCNT,XDRDMAIN,XDRDTYPE,XDRDUP
 Q
LKUP ;
 S DIC=XDRGL,DIC(0)="AEMQ",DIC("A")="Find Potential Duplicates for "_$P(^DIC(XDRFL,0),U)_":  "
 D ^DIC K DIC,DA
 I Y=-1 S XDRQFLG=1 G LKUPX
 S XDRCD=+Y
LKUPX ;
 Q
SETUP ;
 S XDRD("COLLECTION ROUTINE")=$S($P($P(XDRD(0),U,9),"-",2)]"":$P($P(XDRD(0),U,9),"-")_"^"_$P($P(XDRD(0),U,9),"-",2),1:U_$P(XDRD(0),U,9))
 I '$D(XDRD("DMAILGRP")),$D(XDRD(0)),$P(XDRD(0),U,11),$D(^XMB(3.8,$P(XDRD(0),U,11),1,"B")) F XDRI=0:0 S XDRI=$O(^XMB(3.8,$P(XDRD(0),U,11),1,"B",XDRI)) Q:'XDRI  S XDRD("DMAILGRP",XDRI)=""
 K XDRI
 D ^XDRDSCOR ; Sets up Duplicate Test Scores
SETUPX ;
 Q
CHECK ;check for duplicates and add to Duplicate record file
 F XDRCD2=0:0 S XDRCD2=$O(^TMP("XDRD",$J,XDRFL,XDRCD2)) Q:'XDRCD2!(XDRQFLG)  D CHECK^XDRDMAIN
 Q
INFORM ;
 S XDRDFPD("PAIR")="",%=0 F  S XDRDFPD("PAIR")=$O(^VA(15,"APOT",$P(XDRGL,"^",2),XDRDFPD("PAIR")))  Q:XDRDFPD("PAIR")=""  D
 .I $P(XDRDFPD("PAIR"),U)=XDRCD!($P(XDRDFPD("PAIR"),U,2)=XDRCD) S %=%+1,XDRDFPD("FOUND",%)=XDRDFPD("PAIR")
 .Q
 I '$D(XDRDFPD("FOUND")) W !!,"NO Potential Duplicates were found for ",$P(^DIC(XDRFL,0),U),":  ",$P(@(XDRGL_XDRCD_",0)"),U) Q
 W !!,"The following ",$P(^DIC(XDRFL,0),U)," entry(ies) are now in the Duplicate  ",!,"Record file as Potential Duplicates to ",!,$P(^DIC(XDRFL,0),U),":  ",$P(@(XDRGL_XDRCD_",0)"),U)
 S X="" F  S X=$O(XDRDFPD("FOUND",X)) Q:X=""  D
 .W !?20,$S($P(XDRDFPD("FOUND",X),U)=XDRCD:$P(@(XDRGL_$P(XDRDFPD("FOUND",X),U,2)_",0)"),U),1:$P(@(XDRGL_$P(XDRDFPD("FOUND",X),U)_",0)"),U))
 .Q
 Q

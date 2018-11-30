DVBCPRNT ;ALB/GTS-557/THM-FINAL REPORT DRIVER ; 5/17/91  10:29 AM
 ;;2.7;AMIE;;Apr 10, 1995
 ;
 I '$D(DUZ(2)) W *7,!!,"You DIVISION NUMBER is incorrect.",! H 2 Q
 I DUZ(2)<1 W !,*7,"Your DIVISION NUMBER is invalid.",! H 2 Q
 ;
SETUP K EDPRT,ULINE S XDD=^DD("DD"),$P(ULINE,"_",70)="_" K AUTO
 D HOME^%ZIS S FF=IOF,HD="C & P Exam Printing" W @IOF,!?(IOM-$L(HD)\2),HD,!!!
 S Y=DT X XDD S DVBCDT(0)=Y,PGHD="Compensation and Pension Exam Report",DVBCSITE=$S($D(^DVB(396.1,1,0)):$P(^(0),U,1),1:"Not specified")
 W !!,"Note:  All reports will be produced in 'terminal-digit' order.",!! H 1
 ;
DEVICE S %ZIS="AEQ",%ZIS("B")="0;P-OTHER",%ZIS("A")="Output device: " D ^%ZIS G:POP KILL^DVBCUTIL
 I $D(IO("Q")) S ZTRTN="GO^DVBCPRNT",ZTIO=ION,ZTDESC="2507 Final Exam Report" F I="D*","XDD","ULINE","HD","FF","PGHD" S ZTSAVE(I)=""
 I $D(IO("Q")) D ^%ZTLOAD W:$D(ZTSK) !!,"Request queued",!! K ZTSK G KILL^DVBCUTIL
 ;
GO D STM^DVBCUTL4
 U IO K ^TMP($J) D HDA S (XCNT,XPRINT)=0
 F DA(1)=0:0 S DA(1)=$O(^DVB(396.3,"AF","R",DUZ(2),DA(1))) Q:DA(1)=""  DO
 .I $D(^DVB(396.3,DA(1),0)) D GO1 S XPRINT=1,XCNT=XCNT+1
 .I '$D(^DVB(396.3,DA(1),0)) D BADXRF
 I XPRINT=0 K XPRINT,XPG,XXLN W !!!!!?25,"Nothing to print",!! H 2 D:$D(ZTQUEUED) KILL^%ZTLOAD G KILL^DVBCUTIL
 I XCNT>0,XPRINT=1 W !!,"Total requests to be printed: ",XCNT,!
 K XCNT,XXLN,XPG,XPRINT,OUT
 D SETLAB
 S (XCN,PNAM)=""
 F DVBCN=0:0 S XCN=$O(^TMP($J,XCN)) Q:XCN=""  F JJ=0:0 S PNAM=$O(^TMP($J,XCN,PNAM)) Q:PNAM=""  K PRINT F DA(1)=0:0 S DA(1)=$O(^TMP($J,XCN,PNAM,DA(1))) Q:DA(1)=""  S DA=DA(1) D VARS^DVBCUTIL,STEP2^DVBCPRN1 I '$D(AUTO) D ^DVBCLABR,LKILL^DVBCUTL3
 S XRTN=$T(+0)
 D SPM^DVBCUTL4
 K DVBCN S LKILL=1 D:$D(ZTQUEUED) KILL^%ZTLOAD G KILL^DVBCUTIL
 ;
GO1 S DFN=$P(^DVB(396.3,DA(1),0),U,1),PNAM=$P(^DPT(DFN,0),U,1) W $E(PNAM,1,25),?28,$E($P(^(0),U,9),1,3)_" "_$E($P(^(0),U,9),4,5)_" "_$E($P(^(0),U,9),6,9)
 S CNUM=$S($D(^DPT(DFN,.31)):$P(^(.31),U,3),1:"Missing") W ?43,CNUM,?55 S Y=$P(^DVB(396.3,DA(1),0),U,2) X XDD W Y,! D:$Y>(IOSL-16) HDA
 S XCN=$E(CNUM,$L(CNUM)-1,$L(CNUM)),XCN=+XCN
 I PNAM]"" S ^TMP($J,XCN,PNAM,DA(1))=""
 K PNAM,XCN,CNUM
 Q
 ;
SETLAB N XX S XX=1,DVBCRALC(XX)="^",Y=0
 F  S Y=$O(^DVB(396.1,1,4,"B",Y)) Q:(Y="")  I $D(^SC(+Y,0)) S DVBCRALC(XX)=DVBCRALC(XX)_+Y_U I $L(DVBCRALC(XX))>230 S XX=XX+1,DVBCRALC(XX)="^"
 Q
 ;
HDA S:'$D(XPG) XPG=0 S XPG=XPG+1
 I (IOST?1"C-".E)!($D(DVBAON2)) W @IOF
 S:('$D(DVBAON2)) DVBAON2=""
 W !,"Final C&P Reports for print date " S Y=DT X XDD W Y,!!,"Operator: ",$S($D(^VA(200,+DUZ,0)):$P(^(0),U,1),1:"Unknown operator"),!,"Location: ",$S($D(^DIC(4,+DUZ(2),0)):$P(^(0),U,1),1:"Unknown location"),!
 W !,"Veteran Name",?28,"SSN",?43,"C-Number",?55,"Request date",!
 F XXLN=1:1:79 W "-"
 W !!
 Q
 ;
WARN W !!,*7,"Too many locations to store!  Some locations may not be reported.",!! H 3 S OUT=1
 Q
 ;
BADXRF ; ** Display a message that a bad cross reference exists **
 W !,"A bad 'D' X-Reference exists on the 2507 Request File (#396.3) for"
 W " DA="_DA(1)_"."
 W !,"Please notify IRM at the facility where you have created"
 W " this report.",!!
 Q

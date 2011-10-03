PSALND ;BIR/LTL-Report Potential NDC Matches ;7/23/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**15,38**; 10/24/97
 ;
 ;References to ^PSDRUG( are covered by IA #2095
 ;References to ^PRC( are covered by IA #214
 ;References to ^PSDRUG("AB" are covered by IA #2095
 D DT^DICRW
DEV ;asks device and queueing info
 K IO("Q") N %ZIS,DIR,DTOUT,DUOUT,IOP,POP,PSAOUT S %ZIS="Q" D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" S PSAOUT=1 G QUIT
 I $D(IO("Q")) N ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTDTH,ZTSK S ZTRTN="START^PSALND",ZTDESC="Unlinked DRUG/ITEM FILE matches by NDC" D ^%ZTLOAD,HOME^%ZIS S PSAOUT=1 G QUIT
START ;compiles and prints data for report
 ;PSA*3.0*38;IOFO BAY PINES;VGF - set var PSAIA if item in item master file is inactive, no longer checking Drug File IFCAP cross reference
 N DIRUT,PSAPG,POP,PSA,PSAB,PSAD,PSADD,PSAIT,PSALN,PSARPDT,X,Y,PSAIA S (PSA,PSAD,PSAPG,PSAOUT)=0,Y=DT D DD^%DT S PSARPDT=Y D HEADER
LOOP F  S PSAD=$O(^PSDRUG(PSAD)) G:'PSAD QUIT D:$Y+7>IOSL HEADER G:PSAOUT QUIT W:'(PSAD#100) "." I $P($G(^PSDRUG(PSAD,2)),U,4)]"" S PSAD(1)=$P($G(^(2)),U,4) D:'$D(^PSDRUG(PSAD,"I"))  G:$G(PSAOUT) QUIT
 .S PSAIT=$$ITEM^PSAUTL(PSAD(1))
 .Q:'PSAIT
 .S PSAIA=0
 .I $D(^PRC(441,PSAIT,3)),$P(^(3),U)=1 S PSAIA=1
 .Q:PSAIA
 .I $D(^PRC(441,PSAIT,0)) Q:$O(^PSDRUG("AB",PSAIT,0))
 .W !!,"NDC:  "_$P(^PSDRUG(PSAD,2),U,4),?40,"Item Number:  "_$P(^PRC(441,PSAIT,0),U),!
 .W !,$E($P(^PSDRUG(PSAD,0),U),1,39)
 .I $L($G(^PRC(441,+PSAIT,1,1,0)))<40,'$O(^PRC(441,+PSAIT,1,1)) W ?40,$G(^PRC(441,+PSAIT,1,1,0)) Q
 .K ^UTILITY($J,"W") S DIWL=40,DIWR=80,DIWF="W"
 .F  S PSA=$O(^PRC(441,+PSAIT,1,+PSA)) Q:'PSA  S X=$G(^PRC(441,+PSAIT,1,+PSA,0)) D:$Y+3>IOSL HEADER Q:$G(PSAOUT)  D ^DIWP D ^DIWW
 .S PSA=0
QUIT I $E(IOST)'="C" W @IOF
 I $E(IOST,1,2)="C-",'PSAOUT W !! S DIR(0)="EA",DIR("A")="END OF REPORT!  Press <RET> to return to the menu." D ^DIR
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@" K IO("Q")
 Q
HEADER ;prints header info
 I $E(IOST,1,2)'="P-",PSAPG S DIR(0)="E" D ^DIR K DIR I 'Y S PSAOUT=1 Q
 I $$S^%ZTLOAD W !!,"Task #",$G(ZTSK),", ",$G(ZTDESC)," was stopped by ",$P($G(^VA(200,+$G(DUZ),0)),U),"." S PSAOUT=1 Q
 W:$Y @IOF S $P(PSALN,"*",81)="",PSAPG=PSAPG+1 W !?2,"Unlinked DRUG/ITEM MASTER file entries by common NDC",?55,PSARPDT,?70,"PAGE: "_PSAPG,!,PSALN,!,"DRUG file",?40,"ITEM MASTER file"
 W:$G(PSA)&($O(^PRC(441,+$G(PSAIT),1,+$G(PSA)))) !,$P(^PSDRUG(PSAD,0),U)," continued"
 Q

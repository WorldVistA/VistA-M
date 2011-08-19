PSALFS ;BIR/LTL-Report Potential FSN Matches ;7/23/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**15**; 10/24/97
 ;
 ;References to ^PSDRUG( are covered by IA #2095
 ;References to ^PRC( are covered by IA #214
 ;References to ^PSDRUG("AB" are covered by IA #2095
 ;
 D DT^DICRW
DEV ;asks device and queueing info
 K IO("Q") N %ZIS,DTOUT,DUOUT,IOP,POP,PSAOUT S %ZIS="Q" D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" S PSAOUT=1 G QUIT
 I $D(IO("Q")) N ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTDTH,ZTSK S ZTRTN="START^PSALFS",ZTDESC="Unlinked DRUG/ITEM FILE matches by FSN" D ^%ZTLOAD,HOME^%ZIS S PSAOUT=1 G QUIT
START ;compiles and prints data for report
 N DIR,DIRUT,PSAPG,POP,PSA,PSAD,PSADD,PSAF,PSAFSN,PSAIT,PSALN,PSARPDT,X,Y S (PSA,PSAD,PSAPG,PSAOUT)=0,Y=DT D DD^%DT S PSARPDT=Y D HEADER
LOOP F  S PSAD=$O(^PSDRUG(PSAD)) G:'PSAD QUIT D:$Y+4>IOSL HEADER G:PSAOUT QUIT I $P($G(^PSDRUG(PSAD,0)),U,6)]"",'$O(^PSDRUG(PSAD,441,0)),'$D(^PSDRUG(PSAD,"I")) D
 .W !!,$P($G(^PSDRUG(+PSAD,0)),U),!
FORM .S PSAFSN=$P(^PSDRUG(PSAD,0),U,6) W !,PSAFSN S PSAIT=$O(^PRC(441,"BB",PSAFSN,0)) W:'PSAIT ?40,"No matching NSN in ITEM MASTER file" Q:'PSAIT  D
 ..D
USED ...I $O(^PSDRUG("AB",PSAIT,"")) S PSADD=$O(^PSDRUG("AB",PSAIT,"")) W !,"**"_$P(^PSDRUG(PSADD,0),U)_" is already linked to Item #"_PSAIT_"**"
 ...W ?40,"ITEM Number:  "_PSAIT,!
 ..I $L($G(^PRC(441,+PSAIT,1,1,0)))<40,'$O(^PRC(441,+PSAIT,1,1)) W ?40,$G(^PRC(441,+PSAIT,1,1,0)),! Q
 ..K ^UTILITY($J,"W") S DIWL=40,DIWR=80,DIWF="W"
 ..F  S PSA=$O(^PRC(441,+PSAIT,1,PSA)) Q:'PSA  S X=$G(^PRC(441,+PSAIT,1,PSA,0)) D ^DIWP
 ..D ^DIWW S PSA=0
QUIT I $E(IOST)'="C" W @IOF
 I $E(IOST,1,2)="C-",'$G(PSAOUT) W !! S DIR(0)="EA",DIR("A")="END OF REPORT!  Press <RET> to return to the menu." D ^DIR
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@" K IO("Q")
 Q
HEADER ;prints header info
 I $E(IOST,1,2)'="P-",PSAPG S DIR(0)="E" D ^DIR K DIR I 'Y S PSAOUT=1 Q
 I $$S^%ZTLOAD W !!,"Task #",$G(ZTSK),", ",$G(ZTDESC)," was stopped by ",$P($G(^VA(200,+$G(DUZ),0)),U),"." S PSAOUT=1 Q
 W:$Y @IOF S $P(PSALN,"*",81)="",PSAPG=PSAPG+1 W !?2,"Unlinked DRUG/ITEM MASTER file entries by common FSN",?55,PSARPDT,?70,"PAGE: "_PSAPG,!,PSALN,!,"DRUG file FSN",?40,"ITEM MASTER file"
 Q

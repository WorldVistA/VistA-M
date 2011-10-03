PSAVIN ;BIR/LTL-Report of Inventory items' link to DRUG FILE ;7/23/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**15**; 10/24/97
 ;
 ;References to $$DESCR^PRCPUX1 are covered by IA #259
 ;References to $$INVNAME^PRCPUX1 are covered by IA #259
 ;References to ^PSDRUG( are covered by IA #2095
 ;References to ^PSDRUG("AB" are covered by IA #2095
 ;References to ^PRCP( are covered by IA #214
 ;
 D DT^DICRW N DIR,DIRUT,X,Y,PSALOC,PSAOUT,DIC,DTOUT,DUOUT,PSAINV,PSAIT
LOOK ;Select Inventory point
 S DIC="^PRCP(445,",DIC(0)="AEMQ",DIC("S")="I $P($G(^(0)),U,20)=""D""",PRCPPRIV=1 D ^DIC K DIC,PRCPPRIV S PSAINV=+Y,PSAIT=0 I Y<0 S PSAOUT=1 G QUIT
 I '$O(^PSD(58.8,"P",+PSAINV,0)) W !!,$$INVNAME^PRCPUX1(PSAINV)_" is NOT linked to a Drug Accountability Location.",!!
 S PSALOC=$O(^PSD(58.8,"P",+PSAINV,0)) W:PSALOC !!,$$INVNAME^PRCPUX1(PSAINV)_" is linked to",!!,$P($G(^PSD(58.8,+PSALOC,0)),U),!!
DEV ;asks device and queueing info
 K IO("Q") N %ZIS,IOP,POP S %ZIS="Q" D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" S PSAOUT=1 G QUIT
 I $D(IO("Q")) N ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTDTH,ZTSK S ZTRTN="START^PSAVIN",ZTDESC="Inventory items link to DRUG FILE Report",ZTSAVE("PSA*")="" D ^%ZTLOAD,HOME^%ZIS S PSAOUT=1 G QUIT
START N %DT,DIR,DIRUT,PSALN,PSAD,PSAPG,PSAOUT,PSARPDT,X,Y S (PSAPG,PSAOUT)=0,Y=DT D DD^%DT S PSARPDT=Y
 D HEADER
LOOP F  S PSAIT=$O(^PRCP(445,PSAINV,1,PSAIT)) Q:'PSAIT  D:$Y+4>IOSL HEADER Q:PSAOUT  D
 .W !!,PSAIT,?10,$E($$DESCR^PRCPUX1(PSAINV,PSAIT),1,33),?45,$E($S($P($G(^PSDRUG(+$O(^PSDRUG("AB",+PSAIT,0)),0)),U)]"":$P($G(^(0)),U),1:"NONE"),1,34)
QUIT I $E(IOST)'="C" W @IOF
 I $E(IOST,1,2)="C-",'$G(PSAOUT) W !! S DIR(0)="EA",DIR("A")="END OF REPORT!  Press <RET> to return to the menu." D ^DIR
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@" K IO("Q")
 Q
HEADER ;prints header info
 I $E(IOST,1,2)'="P-",PSAPG S DIR(0)="E" D ^DIR K DIR I 'Y S PSAOUT=1 Q
 I $$S^%ZTLOAD W !!,"Task #",$G(ZTSK),", ",$G(ZTDESC)," was stopped by ",$P($G(^VA(200,+$G(DUZ),0)),U),"." S PSAOUT=1 Q
 W:$Y @IOF S $P(PSALN,"-",81)="",PSAPG=PSAPG+1 W !,$E($$INVNAME^PRCPUX1(PSAINV),1,23)_" Items' Link to DRUG file",?50,PSARPDT,?70,"PAGE: "_PSAPG,!,PSALN,!,"ITEM",?10,"DESCRIPTION",?45,"DRUG FILE LINK"
 Q

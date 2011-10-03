PSANAC ;BIR/LTL-Populate Pharmacy Location with Inventory Items ;7/23/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**15,64**; 10/24/97;Build 4
 ;This routine loads inventory/DA items into a pharmacy location.
 ;
 ;References to ^PSDRUG( are covered by IA #2095
 ;References to ^PSDRUG("AB" are covered by IA #2095
 ;References to ^PRC( are covered by IA #214
 ;References to ^PRCP( are covered by IA #214
 ;References to ^PS(52.6 are covered by IA #270
 ;References to ^PS(52.7 are covered by IA #770
 ;
 ;
SETUP N DA,DIE,DIC,DIR,DIRUT,DTOUT,DUOUT,DR,PSAOUT,PSADRUG,PSAIT,PSAINV,PSAQTY,PSAY,X,Y
 ;LOOK UP LOCATION
LOOK D ^PSADA I '$G(PSALOC) S PSAOUT=1 G QUIT
NOINV I '$O(^PSD(58.8,+PSALOC,4,0)) W !,$G(PSALOCN)_" is not linked to an Inventory Point.",! S DIR(0)="Y",DIR("A")="Would you like to attempt a link now",DIR("B")="Yes" D ^DIR K DIR G:Y'=1 QUIT D  G:$D(Y)!('$G(PSAINV)) QUIT
INV .S DIE=58.8,DA=PSALOC,DR="[PSAGIP]" D ^DIE
CHEC S DIR(0)="Y",DIR("A")="Have you looked at the loadable Inventory items",DIR("B")="No" D ^DIR K DIR G:$D(DIRUT) QUIT D:Y'=1  G:$G(PSAOUT) QUIT
 .S DIR(0)="Y",DIR("A")="Would you like to look at them now",DIR("B")="Yes" D ^DIR K DIR D:Y=1 DEV^PSARIN
 .S:$D(DTOUT)!($D(DUOUT))!('$G(PSADRUG(1))) PSAOUT=1 Q:$G(PSAOUT)  S DIR(0)="Y",DIR("A")="Ready to load",DIR("B")="No" D ^DIR K DIR S:Y'=1 PSAOUT=1
 S DIR(0)="Y",DIR("A")="Load inventory quantities also",DIR("B")="Yes",DIR("?")="If yes, I'll bring over the current inventory quantity with each item." D ^DIR K DIR S:Y=1 PSAY=1 I $D(DIRUT) S PSAOUT=1 G QUIT
EXP W !,"I will display each item as it is loaded",!
 K IO("Q") N %ZIS,IOP,POP S %ZIS="Q",%ZIS("A")="Please select DEVICE for output:  " D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" S PSAOUT=1 G QUIT
 I $D(IO("Q")) N ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTDTH,ZTSK S ZTRTN="START^PSANAC",ZTDESC="Inventory items loading into DA Location",ZTSAVE("PSA*")="" D ^%ZTLOAD,HOME^%ZIS S PSAOUT=1 G QUIT
START N %DT,DIC,PSAD,PSADT,PSAL,PSALN,PSAT,PSAPG,PSARPDT,X,Y S (PSAPG,PSAOUT)=0,Y=DT D DD^%DT S PSARPDT=Y,PSAIT=0
 S PSAD="W !,PSAIT,?10,$E($$DESCR^PRCPUX1(PSAINV,PSAIT),1,34),?45,$E($P(^PSDRUG($O(^PSDRUG(""AB"",PSAIT,0)),0),U),1,34)"
 S PSAINV=$O(^PSD(58.8,+PSALOC,4,0))
 I $O(^PSD(58.8,+PSALOC,4,PSAINV)) D  S:Y<1 PSAOUT=1 G QUIT
 .S DIC="^PSD(58.8,+PSALOC,4,",DIC(0)="AEMQ",DA(1)=PSALOC D ^DIC K DIC
 .S PSAINV=+Y
 D HEADER
 S:'$D(^PSD(58.8,+PSALOC,1,0)) ^(0)="^58.8001IP^^"
LOOP F  S PSAIT=$O(^PRCP(445,PSAINV,1,PSAIT)) Q:'PSAIT  D:$Y+4>IOSL HEADER Q:PSAOUT  I '$G(^PRC(441,+PSAIT,3)),$O(^PSDRUG("AB",PSAIT,0)) S PSADRUG=$O(^PSDRUG("AB",PSAIT,0)) D:'$D(^PSD(58.8,+PSALOC,1,+PSADRUG,0))
 .I $S('$D(^PSDRUG(PSADRUG,"I")):1,+^("I")>DT:1,1:0) X PSAD D
STUFF ..S PSAQTY=$P($G(^PRCP(445,+PSAINV,1,+PSAIT,0)),U,7)*$S($P($G(^(0)),U,29):$P($G(^(0)),U,29),1:1)
 ..S:$G(PSAY) DIC("DR")="3////^S X=PSAQTY"
 ..S DIC="^PSD(58.8,+PSALOC,1,",DIC(0)="L",DA(1)=PSALOC,X=PSADRUG,DLAYGO=58.8 D ^DIC  K DIC,DLAYGO
 ..W !,"Loaded "_$P(^PSDRUG(PSADRUG,0),U)
 ..Q:'$G(PSAY)
 ..W !,"Updating beginning balance and transaction history.",!
 ..D NOW^%DTC S PSADT=+$E(%,1,12) K %
 ..S ^PSD(58.8,+PSALOC,1,+PSADRUG,5,0)="^58.801A^^"
 ..S DIC="^PSD(58.8,+PSALOC,1,+PSADRUG,5,",DIC(0)="L",(X,DINUM)=$E(DT,1,5)*100,DA(2)=PSALOC,DA(1)=PSADRUG,DIC("DR")="1////^S X=PSAQTY",DLAYGO=58.8 D ^DIC K DIC,DINUM,DLAYGO
 ..F  L +^PSD(58.81,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
FIND ..S PSAT=$P(^PSD(58.81,0),U,3)+1 I $D(^PSD(58.81,PSAT)) S $P(^PSD(58.81,0),U,3)=$P(^PSD(58.81,0),U,3)+1 G FIND
 ..S DIC="^PSD(58.81,",DIC(0)="L",DLAYGO=58.81,(DINUM,X)=PSAT D ^DIC K DIC,DINUM,DLAYGO L -^PSD(58.81,0)
 ..S DIE="^PSD(58.81,",DA=PSAT,DR="1////11;2////^S X=PSALOC;3////^S X=PSADT;4////^S X=PSADRUG;5////^S X=PSAQTY;6////^S X=DUZ;9////0" D ^DIE K DIE
 ..S:'$D(^PSD(58.8,+PSALOC,1,+PSADRUG,4,0)) ^(0)="^58.800119PA^^"
 ..S DIC="^PSD(58.8,+PSALOC,1,+PSADRUG,4,",DIC(0)="L",(X,DINUM)=PSAT
 ..S DA(2)=PSALOC,DA(1)=PSADRUG,DLAYGO=58.8 D ^DIC K DA,DIC,DINUM,DLAYGO
 ..I $E(IOST,1,2)="C-"&($O(^PS(52.6,"AC",+PSADRUG,0))!($O(^PS(52.7,"AC",+PSADRUG,0)))) S PSAIT(1)=PSAIT,PSAIT(2)=$P($G(^PSDRUG(+PSADRUG,0)),U),PSAIT(4)=$G(^PSDRUG(+PSADRUG,660)),PSAIT=PSADRUG D ^PSAPSI4 S PSAIT=PSAIT(1)
QUIT I $E(IOST)'="C" W @IOF
 I $E(IOST,1,2)="C-",'$G(PSAOUT) W !! S DIR(0)="EA",DIR("A")="END OF REPORT!  Press <RET> to return to the menu." D ^DIR
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 K %ZIS("B"),IO("Q") Q
HEADER I $E(IOST,1,2)'="P-",PSAPG S DIR(0)="E" D ^DIR K DIR I 'Y S PSAOUT=1 Q
 I $$S^%ZTLOAD W !!,"Task #",$G(ZTSK),", ",$G(ZTDESC)," was stopped by ",$P($G(^VA(200,+$G(DUZ),0)),U),"." S PSAOUT=1 Q
 ;PSA*3*25 Dave B - removed single reference for OP site
 D OPSITE^PSAUTL1 S PSAINV(1)=$G(PSAOSITN)
 S:$E(PSAINV(1),10)="(" PSAINV(1)=$E(PSAINV(1),1,9)
 W:$Y @IOF S $P(PSALN,"-",81)="",PSAPG=PSAPG+1 W !,$E($P(^PRCP(445,+PSAINV,0),U),1,24)," items loading into ",PSAINV(1),?56,PSARPDT,?70,"PAGE: ",PSAPG,!,PSALN,!,"ITEM",?10,"DESCRIPTION",?50,"DRUG FILE LINK",!
 Q

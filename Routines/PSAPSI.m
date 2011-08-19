PSAPSI ;BIR/LTL-IV Dispensing (Single Drug) ;7/23/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**3,15**; 10/24/97
 ;This routine gathers IV dispensing data for a single drug.
 ;
 ;References to ^DIC(19.2 are covered by IA #1064
 ;References to ^PSDRUG( are covered by IA #2095
 ;References to ^PS(50.8 are covered by IA #771
 ;References to ^PS(52.6 are covered by IA #270
 ;References to ^PS(52.7 are covered by IA #770
 ;
 K PSAQUIT D PSAWARN I $D(PSAQUIT) K PSAQUIT Q
 N DIC,DIE,DINUM,D0,D1,DLAYGO,DR,DIR,DIRUT,DTOUT,DUOUT,PSAPG,PSAW,PSAIV,PSAOUT,PSADT,DA,PSADRUG,PSADRUGN,PSALN,PSAQ,PSAR,X,Y
LOOK D ^PSADA I '$G(PSALOC) S PSAOUT=1 G QUIT
 I '$O(^PSD(58.8,+PSALOC,1,0)) W !!,"There are no drugs in ",PSALOCN,!! G QUIT
 D NOW^%DTC S PSADT=X,X="T-6000" D ^%DT S PSADT(1)=Y
 F  W ! S DIC="^PSD(58.8,+PSALOC,1,",DA(1)=PSALOC,DIC(0)="AEQ",DIC("A")="Please select "_PSALOCN_" drug: " D ^DIC G:Y<0 QUIT S PSADRUG=+Y,(PSAIV,PSADT(2))=0 D  G:$G(PSAOUT) QUIT D DEV
 .I '$O(^PS(52.6,"AC",+PSADRUG,0))&('$O(^PS(52.7,"AC",+PSADRUG,0))) W !!,"This drug is not linked to an entry in the IV ADDITIVE or SOLUTION file.",!! S PSAOUT=1 Q
 .S PSADRUG(1)=$O(^PS(52.6,"AC",+PSADRUG,0))
 .S PSADRUG(2)=$O(^PS(52.7,"AC",+PSADRUG,0))
 .D:'$P($G(^PSD(58.8,+PSALOC,1,+PSADRUG,6)),U,3)  Q:$G(PSAOUT)
 ..W !!,"IV dispensing data has never been collected for this drug.",!!
 ..S DIR(0)="D^"_PSADT(1)_":"_PSADT_":AEX",DIR("A")="How far back would you like to collect",DIR("B")="T-6000"  D ^DIR K DIR S (PSADT(2),PSAR)=Y,(PSADT(3),PSAR(1))=0 I Y<1 S PSAOUT=1 Q
 .I '$G(PSADT(2)) S PSADT(2)=$P($P($G(^PSD(58.8,+PSALOC,1,+PSADRUG,6)),U,3),","),PSADT(3)=0,PSA(7)=1
 .S PSAW=PSADT(3)
 .F  S PSAIV=$O(^PS(50.8,PSAIV)) Q:'PSAIV  F PSADT(4)=PSADT(2):0 S PSADT(4)=$O(^PS(50.8,+PSAIV,2,PSADT(4))) Q:'PSADT(4)  D  D:$O(^PS(50.8,+PSAIV,2,+PSADT(4),2,"AC",52.7,+PSADRUG(2),0)) ^PSAPSI5
 ..Q:'$O(^PS(50.8,+PSAIV,2,+PSADT(4),2,"AC",52.6,+PSADRUG(1),0))
 ..S PSADRUG(3)=$O(^PS(50.8,+PSAIV,2,+PSADT(4),2,"AC",52.6,+PSADRUG(1),0))
 ..F  S PSAW=$O(^PS(50.8,+PSAIV,2,+PSADT(4),2,+PSADRUG(3),3,PSAW)) Q:'PSAW  S PSAW(1)=PSAW D:$O(^PSD(58.8,"AB",PSAW,0))=PSALOC
 ...S PSAQ=$G(PSAQ)+$P($G(^PS(50.8,+PSAIV,2,+PSADT(4),2,+PSADRUG(3),3,PSAW,0)),U,2)-$P($G(^(0)),U,5)
 ..S:$G(PSAQ) ^TMP("PSA",$J,+PSADRUG,PSADT(4))=$G(^TMP("PSA",$J,+PSADRUG,PSADT(4)))+PSAQ S (PSAQ,PSAW)=0
DEV I '$D(^TMP("PSA",$J,+PSADRUG)) W !!,"Sorry, no dispensing for this drug has been compiled since " S Y=$G(PSADT(2)) X ^DD("DD") W $S(Y]"":Y,1:"ever"),".",!! D  G QUIT
 .W "The Compile IV Costs in Background option is scheduled to run "
 .S Y=$P($G(^DIC(19,+$O(^DIC(19,"B","PSJI BACKGROUND JOB",0)),200)),U)
 .X ^DD("DD") W $S(Y:Y,1:"*not scheduled*"),"."
 S DIR(0)="Y",DIR("A")="Would you like a report of daily dispensing totals",DIR("B")="Yes" D ^DIR K DIR G:$D(DIRUT) QUIT G:Y'=1 TR
 K IO("Q"),DIC N %ZIS,IOP,POP S %ZIS="Q" I Y=1 W ! D ^%ZIS
 I $G(POP) W !,"NO DEVICE SELECTED OR ACTION TAKEN!" S PSAOUT=1 G QUIT
 I $D(IO("Q")) N ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTDTH,ZTSK S ZTRTN="LUP^PSAPSI",ZTDESC="Daily drug dispensing log",(ZTSAVE("^TMP(""PSA"",$J,+PSADRUG,"),ZTSAVE("PSA*"))="" D ^%ZTLOAD,HOME^%ZIS G QUIT
LUP S (PSAPG,PSAOUT)=0,PSADRUG(1)=$P($G(^PSDRUG(+PSADRUG,660)),U,6),PSADRUG(2)=$P($G(^(660)),U,8)
 S X=PSADRUG(1),X2="3$" D COMMA^%DTC S PSADRUG(3)=X
 D HEADER
 S (PSA(4),PSA(6))=0 F  S PSA(4)=$O(^TMP("PSA",$J,+PSADRUG,PSA(4))) Q:'PSA(4)  D:$Y+5>IOSL HEADER G:PSAOUT STOP S PSA(6)=PSA(6)+1,Y=PSA(4) X ^DD("DD") D
 .W !!,Y
 .S (X,PSADRUG(6))=$G(^TMP("PSA",$J,+PSADRUG,PSA(4))),X2=0
 .S:$P($G(^PSD(58.8,+PSALOC,1,+PSADRUG,6)),U,4) X=X/$P($G(^(6)),U,4)
 .S PSADRUG(4)=$G(PSADRUG(4))+X
 .D COMMA^%DTC W ?14,X,PSADRUG(2),?40,PSADRUG(3),"/",PSADRUG(2),?63
 .S X=X*PSADRUG(1),PSADRUG(5)=$G(PSADRUG(5))+X,X2="2$" D COMMA^%DTC W ?40,X
 W !,PSALN,!,PSA(6)," DAY TOTALS: " S X=PSADRUG(4),X2=0 D COMMA^%DTC W ?5,X,PSADRUG(2)
 S X=PSADRUG(5),X2="2$" D COMMA^%DTC W ?63,X
STOP W:$E(IOST)'="C" @IOF
 I $E(IOST,1,2)="C-",'$G(PSAOUT) W ! S DIR(0)="EA",DIR("A")="END OF REPORT!  Press <RET> to return to the menu." D ^DIR K DIR
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@" K IO("Q")
 W:'$G(PSAOUT) !!,"Updating transaction history and dispensing totals."
TR I '$G(PSAOUT) S ZTIO="",ZTRTN="^PSAPSI1",ZTDESC="Update dispensing totals",ZTDTH=$H,(ZTSAVE("^TMP(""PSA"",$J,+PSADRUG,"),ZTSAVE("PSA*"))="" D ^%ZTLOAD,HOME^%ZIS
QUIT K:$G(PSADRUG) ^TMP("PSA",$J,+PSADRUG),PSADRUG K PSA
 Q
HEADER I $E(IOST,1,2)'="P-",PSAPG S DIR(0)="E" D ^DIR K DIR I 'Y S PSAOUT=1 Q
 I $$S^%ZTLOAD W !!,"Task #",$G(ZTSK),", ",$G(ZTDESC)," was stopped by ",$P($G(^VA(200,+$G(DUZ),0)),U),"." S PSAOUT=1 Q
 W:$Y @IOF S $P(PSALN,"-",81)="",PSAPG=PSAPG+1 W !,?2,"DAILY DISPENSING TOTALS FOR ",$E($P($G(^PSDRUG(+PSADRUG,0)),U),1,30),?70,"PAGE: ",PSAPG,!,PSALN,!
 W "  DATE",?23,"TOTAL",?45,"$/DISP",?67,"TOTAL",!
 W "DISPENSED",?23,"DISP",?46,"UNIT",?68,"COST",!,PSALN
 Q
 ;
PSAWARN ;DAVEB (PSA*3*3)
 ;
 W @IOF,!!,?30," ** W A R N I N G **",!!,"Execution of this option should only be done for either one of the following:",!
 W !,"1. The ""All Location Dispense/Purge"", [PSA IV ALL LOCATIONS] nightly back-"
 W !,"   ground option has failed to run.",!!,"2. New drugs have been added to a pharmacy location, and you would like to see",!,"   the dispensing activity that has occurred for up to the last sixty days.",!
 W !!,"Each time this option is executed, the balances are updated in the MONTHLY",!,"ACTIVITY multiple within the DRUG ACCOUNTABILITY STATS file (#58.8)."
 W !!,"The proram will continue to add or subtract the dispensed amount each time the ",!,"option is used.",!
ASK S DIR(0)="Y",DIR("A")="Do you really want to run this option",DIR("B")="NO" D ^DIR K DIR I $D(DIRUT) S PSAQUIT=1 Q
 I Y'>0 S PSAQUIT=1 Q
 K PSAQUIT Q

PSAOP ;BIR/LTL-Outpatient Dispensing (Single Drug) ;7/23/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**3,15**; 10/24/97
 ;This routine is the gathers OP dispensing for a date range.
 ;
 ;References to ^PSDRUG( are covered by IA #2095
 ;References to ^PSRX( are covered by IA #254
 ;
 D PSAWARN^PSAPSI I $D(PSAQUIT) K PSAQUIT Q
 ;
 N DIC,DIE,DINUM,D0,D1,DLAYGO,DR,DIR,DIRUT,DTOUT,DUOUT,PSADR,PSADREC,PSADT,PSAPG,PSAS,PSA,PSAOUT,PSARELDT,PSADT,DA,PSADRUG,PSADRUGN,PSALN,PSAP,PSAN,PSAQ,PSAR,X,X2,Y
LOOK D:'$G(PSALOC) OP^PSADA
 I $G(PSALOC)<0 K PSALOC G QUIT
 S:'$G(PSALOCN) PSALOCN=$P($G(^PSD(58.8,+PSALOC,0)),U)
 S DIR(0)="Y",DIR("A")="OK",DIR("B")="Yes",DIR("?")="No allows you to change Location." D ^DIR K DIR S:$D(DIRUT) PSAOUT=1 G:$D(DIRUT) QUIT I Y=0 K PSALOC D OP^PSADA G:'$G(PSALOC) QUIT
 I '$O(^PSD(58.8,+PSALOC,1,0)) W !!,"There are no drugs in ",PSALOCN G QUIT
 D NOW^%DTC S PSADT=X,X="T-6000" D ^%DT S PSADT(1)=Y
 S DIC="^PSD(58.8,+PSALOC,1,",DIC(0)="AEQ",DIC("A")="Please select "_PSALOCN_"'S drug: ",DIC("S")="I $S($P($G(^(0)),U,14):$P($G(^(0)),U,14)>DT,1:1)"
 S PSAS=$P($G(^PSD(58.8,+PSALOC,0)),U,10),PSADT(3)=0
 F  W ! S DA(1)=PSALOC D ^DIC G:Y<0 QUIT S PSADRUG=+Y D  G:$G(PSAOUT) QUIT G:$G(PSA(5)) TR D DEV Q:$G(PSAOUT)
 .D:'$G(^PSD(58.8,+PSALOC,1,+PSADRUG,6))  Q:$G(PSAOUT)
 ..W !!,"Dispensing has never been collected for this drug.",!!
 ..S DIR(0)="D^"_PSADT(1)_":"_PSADT_":AEX",DIR("A")="How far back would you like to collect",DIR("B")="T-6000"  D ^DIR K DIR S (PSADT(2),PSADT(4),PSAR,PSAP,PSAN)=Y,(PSADT(3),PSAR(1),PSAP(1),PSAN(1))=0 I Y<1 S PSAOUT=1 Q
 .S PSAG=$G(^PSD(58.8,+PSALOC,1,+PSADRUG,6))
 .S:'$G(PSADT(2)) PSADT(2)=$P(PSAG,U),PSA(7)=1
 .W !!,"Checking dispensing"
 .S:'$G(PSAR) PSAR=$P(PSAG,U,2) S:'$G(PSAP) PSAP=$P(PSAG,U,7)
 .S:'$G(PSAN) PSAN=$P(PSAG,U,9) S (PSAR(1),PSAP(1),PSAN(1))=0
 .F  S PSADT(2)=$O(^PSRX("AL",PSADT(2))) Q:'PSADT(2)  F  S PSADT(3)=$O(^PSRX("AL",+PSADT(2),PSADT(3))) Q:'PSADT(3)  W:'(PSADT(3)#10) "." D:$P($G(^PSRX(+PSADT(3),0)),U,6)=PSADRUG&($P($G(^PSRX(+PSADT(3),2)),U,9)=PSAS)
 ..S PSADT(4)="" F  S PSADT(4)=$O(^PSRX("AL",+PSADT(2),+PSADT(3),PSADT(4))) Q:PSADT(4)=""  D
 ...;
 ...;DAVE B (PSA*3*3)
 ...Q:$D(^PSRX("AR",+PSADT(2),+PSADT(3),PSADT(4)))  ;Released to CMOP, do not count
 ...S ^TMP("PSA",$J,+PSADRUG,$E(PSADT(2),1,7))=($P($G(^TMP("PSA",$J,+PSADRUG,$E(PSADT(2),1,7))),U)+$S(PSADT(4):$P($G(^PSRX(+PSADT(3),1,+PSADT(4),0)),U,4),1:$P($G(^PSRX(+PSADT(3),0)),U,7)))_U_PSADT(2)_U_PSADT(3),PSA(9)=PSADT(3)
 .W !!,"Checking refills"
 .D:$O(^PSRX("AJ",PSAR))
 ..F  S PSAR=$O(^PSRX("AJ",PSAR)) Q:'PSAR  F  S PSAR(1)=$O(^PSRX("AJ",+PSAR,+PSAR(1))) Q:'PSAR(1)  W "." D:$P($G(^PSRX(+PSAR(1),0)),U,6)=PSADRUG&($P($G(^PSRX(+PSAR(1),2)),U,9)=PSAS)
 ...S PSAR(3)="" F  S PSAR(3)=$O(^PSRX("AJ",+PSAR,+PSAR(1),PSAR(3))) Q:PSAR(3)=""  D
 ....S $P(^TMP("PSA",$J,+PSADRUG,$E(PSAR,1,7)),U)=($P($G(^TMP("PSA",$J,+PSADRUG,$E(PSAR,1,7))),U)-$S(PSAR(3):$P($G(^PSRX(+PSAR(1),1,+PSAR(3),0)),U,4),1:$P($G(^PSRX(+PSAR(1),0)),U,7)))
 ....S $P(^TMP("PSA",$J,+PSADRUG,$E(PSAR,1,7)),U,4)=PSAR,$P(^($E(PSAR,1,7)),U,5)=PSAR(1),PSAR(2)=PSAR(1)
 .D:$O(^PSRX("AM",+PSAP))!($O(^PSRX("AN",+PSAN))) AM^PSAOP4
 .I '$D(^TMP("PSA",$J,+PSADRUG)) W !!,"Sorry, no dispensing for this drug has occurred since " S Y=$S($P(PSAG,U):$P(PSAG,U),1:$G(PSADT(4))) X ^DD("DD") W Y,".",! S PSAOUT=1 Q
 .S DIR(0)="Y",DIR("A")="Would you like a report of dispensing totals",DIR("B")="Yes" D ^DIR K DIR S:$D(DIRUT) PSAOUT=1 S:Y'=1 PSA(5)=1
 ;
DEV K IO("Q") N %ZIS,IOP,POP S %ZIS="Q" I Y=1 W ! D ^%ZIS
 I $G(POP) W !,"NO DEVICE SELECTED OR ACTION TAKEN!" S PSAOUT=1 G QUIT
 I $D(IO("Q")) N ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTDTH,ZTSK S ZTRTN="LUP^PSAOP",ZTDESC="Drug Acct-OP Dispensing Log",(ZTSAVE("^TMP(""PSA"",$J,+PSADRUG,"),ZTSAVE("PSA*"))="" D ^%ZTLOAD,HOME^%ZIS G QUIT
LUP S (PSAPG,PSAOUT)=0,PSADRUG(1)=$P($G(^PSDRUG(+PSADRUG,660)),U,6),PSADRUG(2)=$P($G(^(660)),U,8)
 S X=PSADRUG(1),X2="3$" D COMMA^%DTC S PSADRUG(3)=X
 D HEADER
 S (PSA(4),PSA(6))=0 F  S PSA(4)=$O(^TMP("PSA",$J,+PSADRUG,PSA(4))) Q:'PSA(4)  S PSA(6)=PSA(6)+1,Y=PSA(4) X ^DD("DD") D
 .W !!,Y S X=$P($G(^TMP("PSA",$J,+PSADRUG,PSA(4))),U),X2=0 D COMMA^%DTC W ?14,X,PSADRUG(2),?40,PSADRUG(3),"/",PSADRUG(2),?63
 .S PSADRUG(4)=$G(PSADRUG(4))+$P($G(^TMP("PSA",$J,+PSADRUG,PSA(4))),U)
 .S X=$P($G(^TMP("PSA",$J,+PSADRUG,PSA(4))),U)*PSADRUG(1),PSADRUG(5)=$G(PSADRUG(5))+X,X2="2$" D COMMA^%DTC W ?40,X
 W !,PSALN,!,PSA(6)," DAY TOTALS: " S X=PSADRUG(4),X2=0 D COMMA^%DTC W ?5,X,PSADRUG(2)
 S X=PSADRUG(5),X2="2$" D COMMA^%DTC W ?63,X
STOP W:$E(IOST)'="C" @IOF
 I $E(IOST,1,2)="C-",'$G(PSAOUT) W ! S DIR(0)="EA",DIR("A")="END OF REPORT!  Press <RET> to return to the menu." D ^DIR K DIR
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@" K IO("Q")
 W !!,"Updating history and dispensing totals."
TR S ZTIO="",ZTRTN="LOOP^PSAOP",ZTDESC="Drug Acct-Dispensing Totals",ZTDTH=$H,(ZTSAVE("^TMP(""PSA"",$J,+PSADRUG,"),ZTSAVE("PSA*"))="" D ^%ZTLOAD,HOME^%ZIS
 K ^TMP("PSA",$J,+PSADRUG),PSA,PSADRUG
QUIT Q
HEADER I $E(IOST,1,2)'="P-",PSAPG S DIR(0)="E" D ^DIR K DIR I 'Y S PSAOUT=1 Q
 I $$S^%ZTLOAD S PSAOUT=1 Q
 W:$Y @IOF S $P(PSALN,"-",81)="",PSAPG=PSAPG+1 W !,?2,"DAILY DISPENSING TOTALS FOR ",$E($P($G(^PSDRUG(+PSADRUG,0)),U),1,30),?70,"PAGE: ",PSAPG,!,PSALN,!
 W "  DATE",?23,"TOTAL",?45,"$/DISP",?67,"TOTAL",!
 W "DISPENSED",?23,"DISP",?46,"UNIT",?68,"COST",!,PSALN
 Q
LOOP S PSA(2)=0 F  S PSA(2)=$O(^TMP("PSA",$J,+PSADRUG,PSA(2))) Q:'PSA(2)  S PSA(3)=$P(^TMP("PSA",$J,+PSADRUG,PSA(2)),"^") D
 .;PSA*3*25 Dave B - Remove single reference for OP site
 .S PSA=^TMP("PSA",$J,+PSADRUG,PSA(2)),PSAOP=+$P($G(^PSD(58.8,PSALOC,0)),"^",10),PSARELDT=+$P(PSA(2),".")
 .K:$D(^XTMP("PSA",PSAOP,PSADRUG,PSARELDT)) ^XTMP("PSA",PSAOP,PSADRUG,PSARELDT)
 .D ^PSAOP1
 .S DIE="^PSD(58.8,"_+PSALOC_",1,",DA(1)=PSALOC,DA=PSADRUG
 .S DR="22////"_$P(PSA,U,2)_";22.1////"_$P(PSA,U,3)_";23////"_$P(PSA,U,4)_";23.1////"_$P(PSA,U,5)_";22.2////"_$P(PSA,U,6)_";22.3////"_$P(PSA,U,7)_";23.2////"_$P(PSA,U,8)_";23.3////"_$P(PSA,U,9)
 .D ^DIE K DA,DIE,DR
 Q

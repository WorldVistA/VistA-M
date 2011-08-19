PSAREVD ;BIR/LTL-Drug Receipt History Review ;7/23/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**15**; 10/24/97
 ;This routine reviews receipt transactions for a drug.
 ;
 ;References to ^PSDRUG( are covered by IA #2095
 ;References to ^PRC( are covered by IA #214
 ;References to ^PRCS( are covered by IA #198
 ;
 N DIC,DIR,DTOUT,DUOUT,PSA,PSACNT,PSALOCN,PSAR,PSAU,PSAOUT,PSAT,X,Y S PSAOUT=1,PSAU=0
LOOK D ^PSADA I '$G(PSALOC) S PSAOUT=1 G END
 I '$O(^PSD(58.8,PSALOC,1,0)) W !!,"There are no drugs in ",PSALOCN G END
 S PSACNT=0 W !!,"You may select one, several, or ^ALL drugs.",!
CHKD F  S DIC="^PSD(58.8,+PSALOC,1,",DIC(0)="AEMQ",DIC("A")="Please Select "_PSALOCN_"'s Drug: ",DIC("S")="I $S($G(^(""I"")):$G(^(""I""))>DT,1:1)" W ! D ^DIC K DIC G:X'="^ALL"&(Y<1)&('PSACNT) END Q:Y<0  S PSA(+Y)="",PSACNT=PSACNT+1
 I PSACNT=1&('$O(^PSD(58.81,"F",+$O(PSA(0)),0))) W !!,"There have been no receipts for this drug.",!! G END
 I X="^ALL" F  S PSAU=$O(^PSD(58.8,+PSALOC,1,PSAU)) Q:'PSAU  S PSA(PSAU)=""
 S DIR(0)="D:AEP",DIR("A")="How far back in time do you want to go? ",DIR("B")="T-6M",DIR("?")="I will list receipts for your selected drug(s) within the last six months if you press return" W ! D ^DIR K DIR G:$D(DIRUT) END
 S PSAT=Y
DEV ;asks device and queueing info
 K IO("Q"),PSALOC N %ZIS,IOP,POP S %ZIS="Q" W ! D ^%ZIS I POP W !,"NO DEVICE SELECTED OR OUTPUT PRINTED!" Q
 I $D(IO("Q")) N ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTDTH,ZTSK S ZTRTN="START^PSAREVD",ZTDESC="Drug receipt transaction review",ZTSAVE("PSA*")="" D ^%ZTLOAD,HOME^%ZIS S PSAOUT=1 G END
START ;compiles and prints output
 N %DT,PSALN,PSAR,PSAPG,PSARPDT S (PSAPG,PSAOUT)=0,Y=DT,PSAR="" X ^DD("DD") S PSARPDT=Y,PSAU(1)=$O(PSA(0)) D HEADER S PSAU=0
 F  S PSAU=$O(PSA(PSAU)) Q:'PSAU  K PSAR(1) D  G:PSAOUT END I 'PSAR,$O(PSA(PSAU)) S PSAU(1)=$O(PSA(PSAU))
LOOP .F  S PSAR=$O(^PSD(58.81,"F",PSAU,PSAR)) Q:'PSAR  D:$Y+6>IOSL HEADER Q:PSAOUT  S PSAR(2)=$G(^PSD(58.81,+PSAR,0)) D:$P(PSAR(2),U,4)'<PSAT&($P(PSAR(2),U,2)=1)
 ..S PSAR(1)=$G(PSAR(1))+1 W:PSAR(1)=1 $P($G(^PSDRUG(+PSAU,0)),U),!
 ..I '$D(PSALOC) S PSALOC=$P(PSAR(2),U,3) W !,"Receiving Site: ",$P($G(^PSD(58.8,+PSALOC,0)),U),!
 ..I $G(PSALOC)'=$P(PSAR(2),U,3) S PSALOC=$P(PSAR(2),U,3) W !,"Receiving site: ",$P($G(^PSD(58.8,+PSALOC,0)),U),!
 ..S Y=$E($P(PSAR(2),U,4),1,12) X ^DD("DD") W !,Y,"   -> "
 ..W $P(PSAR(2),U,6)," received by ",$P($G(^VA(200,+$P(PSAR(2),U,7),0)),U),!!
 ..W:$P($G(^PRC(442,+$P(PSAR(2),U,9),0)),U) "PO#:  ",$P($G(^(0)),U),?20
 ..W:$P($G(^PRCS(410,+$P(PSAR(2),U,8),0)),U) "TR#:  ",$P($G(^(0)),U),"  "
 ..W:$P($G(^PSD(58.81,+PSAR,8)),U)]"" "INV#:  ",$P($G(^(8)),U)
 ..W !,PSALN,!
END W:$E(IOST)'="C" @IOF
 I $E(IOST,1,2)="C-",'PSAOUT S DIR(0)="EA",DIR("A")="END OF REPORT!  Press <RET> to return to the menu." D ^DIR
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@" K IO("Q")
 Q
HEADER ;prints header info
 I $E(IOST,1,2)'="P-",PSAPG S DIR(0)="E" D ^DIR K DIR I 'Y S PSAOUT=1 Q
 I $$S^%ZTLOAD W !!,"Task #",$G(ZTSK),", ",$G(ZTDESC)," was stopped by ",$P($G(^VA(200,+$G(DUZ),0)),U),"." S PSAOUT=1 Q
 W:$Y @IOF S $P(PSALN,"-",81)="",PSAPG=PSAPG+1 W !?2,"History of Drug Receipts",?50,PSARPDT,?70,"PAGE: ",PSAPG,!,PSALN,!
 Q

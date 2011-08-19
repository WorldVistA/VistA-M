PSAVIN1 ;BIR/LTL-Physical Inventory Balance Review ;7/23/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**15**; 10/24/97
 ;This routine reviews balances for a drug.
 ;
 ;References to $$DESCR^PRCPUX1 are covered by IA #259
 ;References to $$INVNAME^PRCPUX1 are covered by IA #259
 ;References to ^PSDRUG( are covered by IA #2095
 ;References to ^PRCP( are covered by IA #214
 ;
 N DIC,DIR,DTOUT,DUOUT,PSA,PSACNT,PSALOCN,PSAR,PSAU,PSAOUT,PSAT,X,Y S PSAOUT=1,PSAU=0
LOOK D ^PSADA I '$G(PSALOC) S PSAOUT=1 G END
 I '$O(^PSD(58.8,PSALOC,1,0)) W !!,"There are no drugs in ",PSALOCN G END
 W !!,"The balances displayed from a Primary Inventory Point are based on the most",!,"recent physical inventory and may NOT reflect accurate quantities when",!,"converted to the dispensing unit level."
 S PSACNT=0 W !!,"You may select one, several, or ^ALL drugs.",!
CHKD F  S DIC="^PSD(58.8,+PSALOC,1,",DIC(0)="AEMQ",DIC("A")="Please Select "_PSALOCN_"'s Drug: ",DIC("S")="I $S($G(^(""I"")):$G(^(""I""))>DT,1:1)" W ! D ^DIC K DIC G:X'="^ALL"&(Y<1)&('PSACNT) END Q:Y<0  S PSA(+Y)="",PSACNT=PSACNT+1
 I X="^ALL" F  S PSAU=$O(^PSD(58.8,+PSALOC,1,PSAU)) Q:'PSAU  S PSA(PSAU)=""
DEV ;asks device and queueing info
 K IO("Q") N %ZIS,IOP,POP S %ZIS="Q" W ! D ^%ZIS I POP W !,"NO DEVICE SELECTED OR OUTPUT PRINTED!" Q
 I $D(IO("Q")) N ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTDTH,ZTSK S ZTRTN="START^PSAVIN1",ZTDESC="Drug balance review",ZTSAVE("PSA*")="" D ^%ZTLOAD,HOME^%ZIS S PSAOUT=1 G END
START ;compiles and prints output
 N %DT,PSALN,PSAR,PSAPG,PSARPDT S (PSAPG,PSAOUT)=0,Y=DT,PSAR="" X ^DD("DD") S PSARPDT=Y,PSAU(1)=$O(PSA(0)) D HEADER S PSAU=0
 F  S PSAU=$O(PSA(PSAU)) Q:'PSAU  D  Q:$G(PSAOUT)
LOOP .D:$Y+8>IOSL HEADER  Q:$G(PSAOUT)
 .I $G(PSAU(5))>1 W "Total of all Primary Inventory items: ",$G(PSAU(7)),!!
 .W !,$P($G(^PSDRUG(+PSAU,0)),U) K PSAU(5),PSAU(7)
 .W !!,$G(PSALOCN),"'s balance: ",$P($G(^PSD(58.8,+PSALOC,1,+PSAU,0)),U,4)," "
 .W $P($G(^PSDRUG(+PSAU,660)),U,8),!!
 .Q:'$O(^PSDRUG(+PSAU,441,0))
 .F PSAU(1)=0:0 S PSAU(1)=$O(^PSDRUG(+PSAU,441,PSAU(1))) Q:'PSAU(1)  D
 ..S PSAU(2)=$P($G(^PSDRUG(+PSAU,441,+PSAU(1),0)),U) Q:'PSAU(2)
 ..Q:'$O(^PRCP(445,"AE",+PSAU(2),0))
 ..F PSAU(3)=0:0 S PSAU(3)=$O(^PRCP(445,"AE",+PSAU(2),PSAU(3))) Q:'PSAU(3)  D:$O(^PSD(58.8,"P",PSAU(3),0))
 ...S PSAU(5)=$G(PSAU(5))+1
 ...W $$DESCR^PRCPUX1(PSAU(3),PSAU(2))
 ...W !!,$$INVNAME^PRCPUX1(PSAU(3)),"'s balance: "
 ...S PSAU(6)=$P($G(^PRCP(445,+PSAU(3),1,+PSAU(2),0)),U,7)*$S($P($G(^(0)),U,29):$P($G(^(0)),U,29),1:1) W PSAU(6)," ",$P($G(^(0)),U,28),!!
 ...S PSAU(7)=$G(PSAU(7))+PSAU(6)
 W:$G(PSAU(5))>1 "Total of all Primary Inventory items: ",$G(PSAU(7)),!!
END W:$E(IOST)'="C" @IOF
 I $E(IOST,1,2)="C-",'PSAOUT S DIR(0)="EA",DIR("A")="END OF REPORT!  Press <RET> to return to the menu." D ^DIR
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@" K IO("Q")
 Q
HEADER ;prints header info
 I $E(IOST,1,2)'="P-",PSAPG S DIR(0)="E" D ^DIR K DIR I 'Y S PSAOUT=1 Q
 I $$S^%ZTLOAD W !!,"Task #",$G(ZTSK),", ",$G(ZTDESC)," was stopped by ",$P($G(^VA(200,+$G(DUZ),0)),U),"." S PSAOUT=1 Q
 W:$Y @IOF S $P(PSALN,"&",81)="",PSAPG=PSAPG+1 W !?2,"Physical Inventory Balance Review",?55,PSARPDT,?70,"PAGE: ",PSAPG,!,PSALN,!
 Q

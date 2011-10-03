PSAVIN2 ;BIR/LTL-Compares Prices (DA/GIP) ;7/23/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**15**; 10/24/97
 ;This routine reviews prices for a drug.
 ;
 ;References to $$DESCR^PRCPUX1 are covered by IA #259
 ;References to $$INVNAME^PRCPUX1 are covered by IA #259
 ;References to $$UNITCODE^PRCPUX1 are covered by IA #259
 ;References to ^PSDRUG( are covered by IA #2095
 ;References to ^PRCP( are covered by IA #214
 ;References to ^DIC(51.5 are covered by IA #1931
 ;
 N DIC,DIR,DTOUT,DUOUT,PSA,PSACNT,PSALOCN,PSAR,PSAU,PSAOUT,PSAT,X,X2,X3,Y S PSAOUT=1,PSAU=0
LOOK D ^PSADA I '$G(PSALOC) S PSAOUT=1 G END
 I '$O(^PSD(58.8,PSALOC,1,0)) W !!,"There are no drugs in ",PSALOCN G END
 S PSACNT=0 W !!,"You may select one, several, or ^ALL drugs.",!
CHKD F  S DIC="^PSD(58.8,+PSALOC,1,",DIC(0)="AEMQ",DIC("A")="Please Select "_PSALOCN_"'s Drug: ",DIC("S")="I $S($G(^(""I"")):$G(^(""I""))>DT,1:1)" W ! D ^DIC K DIC G:X'="^ALL"&(Y<1)&('PSACNT) END Q:Y<0  S PSA(+Y)="",PSACNT=PSACNT+1
 I X="^ALL" F  S PSAU=$O(^PSD(58.8,+PSALOC,1,PSAU)) Q:'PSAU  S PSA(PSAU)=""
DEV ;asks device and queueing info
 K IO("Q") N %ZIS,IOP,POP S %ZIS="Q" W ! D ^%ZIS I POP W !,"NO DEVICE SELECTED OR OUTPUT PRINTED!" Q
 I $D(IO("Q")) N ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTDTH,ZTSK S ZTRTN="START^PSAVIN2",ZTDESC="Drug price review",ZTSAVE("PSA*")="" D ^%ZTLOAD,HOME^%ZIS S PSAOUT=1 G END
START ;compiles and prints output
 N %DT,PSALN,PSAR,PSAPG,PSARPDT S (PSAPG,PSAOUT)=0,Y=DT,PSAR="" X ^DD("DD") S PSARPDT=Y,PSAU(1)=$O(PSA(0)) D HEADER S PSAU=0
 F  S PSAU=$O(PSA(PSAU)) Q:'PSAU  D  Q:$G(PSAOUT)
LOOP .D:$Y+8>IOSL HEADER  Q:$G(PSAOUT)
 .W !,$P($G(^PSDRUG(+PSAU,0)),U)
 .S PSAU(9)=$G(^PSDRUG(+PSAU,660))
 .W !!,"DRUG file prices: "
 .S X=$P(PSAU(9),U,3),X2="2$",X3=4 D COMMA^%DTC W X,"/"
 .S PSAU(8)=$P($G(^DIC(51.5,+$P(PSAU(9),U,2),0)),U)
 .W PSAU(8),"     (",$P(PSAU(9),U,5)," ",$P(PSAU(9),U,8),"/",PSAU(8)
 .S X=$P(PSAU(9),U,6),X2="3$",X3=4 D COMMA^%DTC
 .W ")     => ",X,"/",$P(PSAU(9),U,8),!!
 .Q:'$O(^PSDRUG(+PSAU,441,0))
 .F PSAU(1)=0:0 S PSAU(1)=$O(^PSDRUG(+PSAU,441,PSAU(1))) Q:'PSAU(1)  D
 ..S PSAU(2)=$P($G(^PSDRUG(+PSAU,441,+PSAU(1),0)),U) Q:'PSAU(2)
 ..Q:'$O(^PRCP(445,"AE",+PSAU(2),0))
 ..F PSAU(3)=0:0 S PSAU(3)=$O(^PRCP(445,"AE",+PSAU(2),PSAU(3))) Q:'PSAU(3)  D:$O(^PSD(58.8,"P",PSAU(3),0))
 ...S PSAU(5)=$G(PSAU(5))+1
 ...W $$DESCR^PRCPUX1(PSAU(3),PSAU(2))
 ...W !!,$$INVNAME^PRCPUX1(PSAU(3)),"'s prices: "
 ...S PSAU(6)=$G(^PRCP(445,+PSAU(3),1,+PSAU(2),0))
 ...S X=$P(PSAU(6),U,15),X2="2$",X3=4 D COMMA^%DTC W X,"/"
 ...S PSAU(11)=$$UNITCODE^PRCPUX1($P(PSAU(6),U,5))
 ...W PSAU(11),"     (",$P(PSAU(6),U,29)
 ...W " ",$P(PSAU(6),U,28),"/",PSAU(11),")"
 ...S X=($P(PSAU(6),U,15)/($S(($P(PSAU(6),U,29)>0):$P(PSAU(6),U,29),1:1)))
 ...S X2="3$",X3=4 D COMMA^%DTC W "  => ",X,"/",$P(PSAU(6),U,28),!!
END W:$E(IOST)'="C" @IOF
 I $E(IOST,1,2)="C-",'PSAOUT S DIR(0)="EA",DIR("A")="END OF REPORT!  Press <RET> to return to the menu." D ^DIR
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@" K IO("Q")
 Q
HEADER ;prints header info
 I $E(IOST,1,2)'="P-",PSAPG S DIR(0)="E" D ^DIR K DIR I 'Y S PSAOUT=1 Q
 I $$S^%ZTLOAD W !!,"Task #",$G(ZTSK),", ",$G(ZTDESC)," was stopped by ",$P($G(^VA(200,+$G(DUZ),0)),U),"." S PSAOUT=1 Q
 W:$Y @IOF S $P(PSALN,"&",81)="",PSAPG=PSAPG+1 W !?2,"DRUG File/Inventory Price Review",?55,PSARPDT,?70,"PAGE: ",PSAPG,!,PSALN,!
 Q

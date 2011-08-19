PSACON2 ;BIR/LTL-Display Connected Drug and Procurement History - CONT'D ;7/23/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**15**; 10/24/97
 ;This routine is called by PSACON.
 ;
 ;References to $$UNITCODE^PRCPUX1 are covered by IA #259
 ;References to $$VENNAME^PRCPUX1 are covered by IA #259
 ;References to ^PSDRUG( are covered by IA #2095
 ;References to ^PRC( are covered by IA #214
 ;
 Q:'$O(^PRC(441,+PSA(1),4,0))!($G(PSAOUT))
HIS K PSACON N DIRUT,PSADT,PSAOUT,PSAB,PSAD,PSAQ S (PSA(9),PSAOUT)=0
 I PSA(1) F  S PSA(9)=$O(^PRC(441,+PSA(1),4,PSA(9))) Q:'PSA(9)  S:$O(^PRC(441,+PSA(1),4,+PSA(9),1,0)) PSA(10)=1
 I $G(PSA(10)) S DIR(0)="Y",DIR("A")="Procurement history exists, would you like to review",DIR("B")="Yes" W ! D ^DIR K DIR D:Y  I Y<1 S PSAOUT=1 G END G:$D(DIRUT) END
 .S DIR(0)="D",DIR("A")="How far back in time would you like to go",DIR("B")="T-6M" W ! D ^DIR K DIR Q:$D(DIRUT)  S PSA(13)=+Y
 .X ^DD("DD") S PSADT=Y
 .D NOW^%DTC S X1=X,X2=PSA(13) D ^%DTC S PSAD=$S(X/30>0:X/30,1:1)
 .S PSA(9)=$O(^PRC(441,+PSA(1),4,0)),Y=1
 I '$O(^PRC(441,+PSA(1),4,PSA(9))) G DEV
 S DIC="^PRC(441,+PSA(1),4,",DIC(0)="AEMQZ",DIC("W")="W:'$O(^(1,0)) ""  NO HISTORY""",DA(1)=PSA(1) W ! D ^DIC K DIC S PSA(9)=+Y I Y<0 S PSAOUT=1 G END
 I '$O(^PRC(441,+PSA(1),4,+PSA(9),1,0)) W !,"Sorry, no history for that particular Control Point.",! G END
DEV K IO("Q") N %ZIS,IOP,POP S %ZIS="Q",%ZIS("A")="For procurement history, please select DEVICE: " W ! D ^%ZIS I POP W !,"NO DEVICE SELECTED OR OUTPUT PRINTED!" S PSAOUT=1 G END
 I $D(IO("Q")) N ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTDTH,ZTSK S ZTRTN="LOOP^PSACON2",ZTDESC="Drug Procurement History",ZTSAVE("PSA*")="" D ^%ZTLOAD,HOME^%ZIS S PSAOUT=1 G END
LOOP N PSALN,PSAPG,PSARPDT S (PSAPG,PSA(11))=0,Y=1 D HEADER
 F  S PSA(11)=$O(^PRC(441,+PSA(1),4,+PSA(9),1,PSA(11))),PSA(14)=$P($G(^PRC(442,+PSA(11),1)),U,15) Q:'PSA(11)!(PSAOUT)  D:$Y+4>IOSL HEADER G:'Y END D:PSA(14)'<PSA(13)
 .W !,$E($P($G(^PRC(442,+PSA(11),0)),U),5,10)
 .W ?8,$E($$VENNAME^PRCPUX1($P($G(^PRC(442,+PSA(11),1)),U)_"PRC(440"),1,20)
 .S Y=PSA(14) X ^DD("DD") W ?32,Y
 .S PSA(12)=$O(^PRC(442,+PSA(11),2,"AE",+PSA(1),""))
 .W ?45,$J($P($G(^PRC(442,+PSA(11),2,+PSA(12),0)),U,2),3) S PSAQ=$G(PSAQ)+$P($G(^(0)),U,2)
 .W " ",$$UNITCODE^PRCPUX1($P($G(^PRC(442,+PSA(11),2,+PSA(12),0)),U,3))
 .W ?55,"$",$J($P($G(^PRC(442,+PSA(11),2,+PSA(12),2)),U),9,2) S PSAB=$G(PSAB)+$P($G(^(2)),U)
 .W ?70,$P($G(^PRC(442,+PSA(11),2,+PSA(12),2)),U,8),! S Y=1
 .I '$O(^PRC(441,+PSA(1),4,+PSA(9),1,PSA(11))) S X=$G(PSAQ)/PSAD,X2=1,X3=5 D COMMA^%DTC W PSALN,!!,"Average ordered/month: ",X,?34,"TOTAL ORD: ",$J($G(PSAQ),3),?50,"TOTAL $: " S X=PSAB,X2="0$",X3=5 D COMMA^%DTC W X
END W:$E(IOST)'="C" @IOF
 I $E(IOST,1,2)="C-",'PSAOUT S DIR(0)="EA",DIR("A")="END OF HISTORY!  Press <RET> to return to the option." W ! D ^DIR K DIR
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@" K IO("Q")
 K PSA,PSACON
 Q
HEADER I $E(IOST,1,2)'="P-",PSAPG S DIR(0)="E" D ^DIR K DIR I 'Y S PSAOUT=1 Q
 I $$S^%ZTLOAD W !!,"Task #",$G(ZTSK),", ",$G(ZTDESC)," was stopped by ",$P($G(^VA(200,+$G(DUZ),0)),U),"." S PSAOUT=1 Q
 W:$Y @IOF S $P(PSALN,"-",81)="",PSAPG=PSAPG+1 W !,$E($P($G(^PSDRUG(+PSA,0)),U),1,40)
 W "=> from ",$G(PSADT),?60,"PAGE: ",PSAPG,!,PSALN,!,"PO #",?10,"VENDOR",?33,"PO DATE",?45,"QTY ORD",?57,"COST",?70,"QTY RECD",!,PSALN,!
 Q

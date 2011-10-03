PSALOG2 ;BIR/LTL-Post Drug Procurement History ;7/23/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**15**; 10/24/97
 ;This routine compiles a report of warehouse drugs.
 ;
 ;References to $$DESCR^PRCPUX1 are covered by IA #259
 ;References to $$INVNAME^PRCPUX1 are covered by IA #259
 ;References to ^PRC( are covered by IA #214
 ;References to ^PRCS( are covered by IA #198
 ;References to ^PRCP( are covered by IA #214
 ;
 N PSA,PSAB,PSAC,PSAION,PSAOUT,X,X2,X3,Y,PSAPG,DIR,DIRUT,DTOUT,DUOUT,%DT,PSALN
 S %DT="AEP",%DT("A")="Please select month: ",%DT("B")="T-1M"
 D ^%DT S PSA(11)=$E(Y,1,5),PSA(12)=$E(PSA(11),4,5),PSAOUT=0
 I Y<0 S PSAOUT=1 G END
 X ^DD("DD") S PSA(13)=$E(Y,1,3)_" '"_$E(PSA(11),2,3)
 K IO("Q") N %ZIS,IOP,POP S %ZIS="Q" W ! D ^%ZIS S PSAION=$G(ION)
 I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" S PSAOUT=1 G END
 I $D(IO("Q")) N ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTDTH,ZTSK S ZTRTN="GO^PSALOG2",ZTDESC="Monthly warehoused drug report",ZTSAVE("PSA*")="" D ^%ZTLOAD,HOME^%ZIS S PSAOUT=1 G END
GO S PSA=$O(^PRCP(445,"AC","W","")),(PSA(1),PSAPG)=0 D HEADER
 F  S PSA(1)=$O(^PRCP(445,+PSA,1,PSA(1))) Q:'PSA(1)  I $P($G(^PRC(441,+PSA(1),0)),U,3)=6505 W:$E($G(IOST))="C" "." S ^TMP("PSA",$J,$P($G(^PRC(441,+PSA(1),0)),U,2))=$G(^(0))
 S PSA(2)=0
 F  S PSA(2)=$O(^TMP("PSA",$J,PSA(2))) Q:PSA(2)']""  S PSA(3)=$P($G(^TMP("PSA",$J,PSA(2))),U) D:$O(^PRCP(445.2,"AD",PSA,PSA(3),""))
 .S PSA(4)=0
 .F  S PSA(4)=$O(^PRCP(445.2,"AD",+PSA,PSA(3),PSA(4))) Q:'PSA(4)  D:$P($G(^PRCP(445.2,+PSA(4),0)),U,4)?1"R"&($E($P($G(^(0)),U,17),1,5)=PSA(11))
 ..S ^TMP("PSAB",$J,$P($G(^PRCP(445.2,+PSA(4),0)),U,18),$P($G(^(0)),U,5),PSA(4))=$G(^(0))
 S (PSA(4),PSAB,PSAB(1))=0
 F PSAC=0:1 S PSAB=$O(^TMP("PSAB",$J,PSAB)) Q:'PSAB  D:PSAC HEADER G:PSAOUT END W !!,"PRIMARY INVENTORY: ",$$INVNAME^PRCPUX1(PSAB) F  S PSA(4)=$O(^TMP("PSAB",$J,PSAB,PSA(4))) Q:'PSA(4)!(PSAOUT)  D  G:PSAOUT END
 .W !!,"ITEM #: ",PSA(4),?15,$$DESCR^PRCPUX1(PSAB,PSA(4)),!!,"QTY",?9,"QTY",?19,"PKG",?29,"UNIT",?40,"TOTAL",?51,"DATE",?61,"TRANSACTION",!,"ORD",?9,"REC",?29,"COST",?40,"COST"
 .F  S PSAB(1)=$O(^TMP("PSAB",$J,+PSAB,+PSA(4),PSAB(1))) Q:'PSAB(1)!(PSAOUT)  S PSA(5)=$G(^TMP("PSAB",$J,+PSAB,+PSA(4),+PSAB(1))) D  D:$Y+6>IOSL HEADER Q:PSAOUT
 ..Q:'$P(PSA(5),U,19)
 ..S PSA(22)=0,PSA(33)=$O(^PRCS(410,"B",$P(PSA(5),U,19),""))
 ..F  S PSA(22)=$O(^PRCS(410,+PSA(33),"IT",PSA(22))) Q:'PSA(22)  S:$P($G(^PRCS(410,+PSA(33),"IT",PSA(22),0)),U,5)=PSA(4) PSA(44)=$P($G(^(0)),U,2)
 ..W !!,$J($G(PSA(44)),3)
 ..S PSA(99)=$G(PSA(99))+PSA(44) K PSA(44)
 ..S PSA(8)=-$P(PSA(5),U,7),PSA(9)=$G(PSA(9))+PSA(8) W ?9,$J(PSA(8),3)
 ..W ?18,$P(PSA(5),U,6)
 ..S (X,PSA(7))=$P(PSA(5),U,9),X2="2$" D COMMA^%DTC W X
 ..S X=-$P(PSA(5),U,7)*PSA(7),X2="2$",PSA(10)=$G(PSA(10))+X D COMMA^%DTC W X
 ..S Y=$P($P(PSA(5),U,17),".") X ^DD("DD") W ?50,$S($L(Y)=11:$E(Y,1,6),$L(Y)=10:$E(Y,1,5),1:"UNKNOWN")
 ..W ?59,$P(PSA(5),U,19)
 ..I '$O(^TMP("PSAB",$J,+PSAB,+PSA(4),+PSAB(1))) W !,PSALN,!,$J(PSA(99),3),?9,$J(PSA(9),3) S X=$G(PSA(10)),X2="2$" D COMMA^%DTC W ?16,"<TOTALS>",?34,X S ^TMP("PSAC",$J,(999999999-PSA(10)),+PSA(4))=PSA(10)_U_PSAB K PSA(9),PSA(10),PSA(99)
 I '$D(^TMP("PSAB",$J)) W !,"Sorry, no procurements for that month!",! S PSAOUT=1
 I $D(ZTQUEUED),$D(^TMP("PSAB",$J)) S PSA(44)=500 D LOOP2^PSALOG3
END W:$E(IOST)'="C" @IOF
 I $E(IOST,1,2)="C-",'$G(PSAOUT) W ! S DIR(0)="EA",DIR("A")="END OF REPORT!  Press <RET> to return to the menu." D ^DIR K DIR
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@" K IO("Q")
 K ^TMP("PSA",$J),^TMP("PSAB",$J) I $G(PSAOUT) K ^TMP("PSAC",$J) Q
 S DIR(0)="Y",DIR("A")="Would you like a list of high dollar items",DIR("B")="Yes",DIR("?")="If yes, I'll let you pick a cut-off dollar amount and sort from high to low" W ! D ^DIR K DIR I 'Y S PSAOUT=1 G END
 S DIR(0)="N",DIR("A")="Please enter the lowest amount you are interested in listing",DIR("B")=1000,DIR("?")="Enter the lowest dollar amount that you want included, without $" W ! D ^DIR K DIR S:Y PSA(44)=Y I 'Y S PSAOUT=1 G END
 K IO("Q") N %ZIS,IOP,POP,X3 S %ZIS="Q",%ZIS("B")=$G(PSAION) W ! D ^%ZIS
 I POP W !,"NO DEVICE SELECTED OR OUTPUT PRINTED!" S PSAOUT=1 G END
 I $D(IO("Q")) N ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTDTH,ZTSK S ZTRTN="LOOP2^PSALOG3",ZTDESC="High Dollar Drug Report",ZTSAVE("^TMP(""PSAC"",$J,")="",ZTSAVE("PSA*")="",ZTSAVE("PSALN")="" D ^%ZTLOAD,HOME^%ZIS S PSAOUT=1 G END
 D LOOP2^PSALOG3 G END
HEADER I $E(IOST,1,2)'="P-",PSAPG S DIR(0)="E" D ^DIR K DIR I 'Y S PSAOUT=1 Q
 I $$S^%ZTLOAD W !!,"Task #",$G(ZTSK),", ",$G(ZTDESC)," was stopped by ",$P($G(^VA(200,+$G(DUZ),0)),U),"." S PSAOUT=1 Q
 W:$Y @IOF S $P(PSALN,"-",81)="",PSAPG=PSAPG+1
 W !,?2,"WAREHOUSE DRUG PROCUREMENTS FOR ",PSA(13),?70,"PAGE: ",PSAPG,!,PSALN
 Q

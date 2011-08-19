PSACONW ;BIR/LTL-Display Connected Drug and Procurement History - CONT'D ;7/23/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**15**; 10/24/97
 ;This routine contains the history of warehoused drugs. It is called
 ;by PSACON.
 ;
 ;References to $$INVNAME^PRCPUX1 are covered by IA #259
 ;References to ^PSDRUG( are covered by IA #2095
 ;References to ^PRCP( are covered by IA #214
 ;
 N PSAI,PSAD,PSAN,PSAQ S (PSAI,PSAOUT)=0
 W !!,"The Supply Warehouse is the mandatory source for this item.",!
 I '$O(^PRCP(445.2,"AD",+PSAW,+PSA(1),"")) W !!,"NO HISTORY!" Q
 W !,"There is a procurement history."
 S DIR(0)="D",DIR("A")="How far back in time would you like to view",DIR("B")="T-3M" W ! D ^DIR K DIR S PSAD=Y I $D(DIRUT) S PSAOUT=1 G QUIT
 X ^DD("DD") S PSAD(2)=Y
 D NOW^%DTC S X1=X,X2=PSAD D ^%DTC S PSAD(1)=$S(X/30>0:X/30,1:1)
 K IO("Q") N %ZIS,IOP,POP S %ZIS="Q" W ! D ^%ZIS
 I POP W !,"NO DEVICE SELECTED OR OUTPUT PRINTED!" S PSAOUT=1 G QUIT
 I $D(IO("Q")) N ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTDTH,ZTSK S ZTRTN="LOOP^PSACONW",ZTDESC="Drug Issue history",ZTSAVE("PSA*")="" D ^%ZTLOAD,HOME^%ZIS S PSAOUT=1 G QUIT
LOOP N PSALN,PSAPG S PSAPG=0 D HEADER
 F  S PSAI=$O(^PRCP(445.2,"AD",+PSAW,+PSA(1),+PSAI)) Q:PSAOUT!('PSAI)  D:$Y+4>IOSL HEADER G:PSAOUT QUIT I $P($G(^PRCP(445.2,PSAI,0)),U,2)?1"R".N S PSAN=$G(^(0)) D:$G(PSAN)&($P($G(PSAN),U,17)'<PSAD)
 .S Y=$P($P(PSAN,U,17),".") D DD^%DT W !!,Y
 .W ?14,$P(PSAN,U,19),?33,$J(-$P(PSAN,U,7),3) S PSAQ=$G(PSAQ)-$P(PSAN,U,7)
 .W ?39,$P(PSAN,U,6)
 .S X=$P(PSAN,U,9),X2="2$",X3=5 D COMMA^%DTC S PSAN(1)=X
 .S X=$P(PSAN,U,9)*-$P(PSAN,U,7),X2="2$",X3=10 D COMMA^%DTC S PSAN(2)=X,PSAN(3)=$G(PSAN(3))+($P(PSAN,U,9)*-$P(PSAN,U,7))
 .W ?47,PSAN(1),?55,PSAN(2)
 .W ?66,$E($$INVNAME^PRCPUX1($P(PSAN,U,18)),1,14)
 S X=$G(PSAQ)/PSAD(1),X2=1,X3=5 D COMMA^%DTC W !,PSALN,!!,"Average ord/mon: ",X,?24,"TOT ORD: ",$J($G(PSAQ),3),?49,"TOTAL $: " S X=$G(PSAN(3)),X2="2$",X3=4 D COMMA^%DTC W X
QUIT W:$E(IOST)'="C" @IOF
 I $E(IOST,1,2)="C-",'PSAOUT S DIR(0)="EA",DIR("A")="END OF HISTORY!  Press <RET> to return to the option." W ! D ^DIR K DIR
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@" K IO("Q") D HOME^%ZIS
 Q
HEADER I $E(IOST,1,2)'="P-",PSAPG S DIR(0)="E" D ^DIR K DIR I 'Y S PSAOUT=1 Q
 I $$S^%ZTLOAD W !!,"Task #",$G(ZTSK),", ",$G(ZTDESC)," was stopped by ",$P($G(^VA(200,+$G(DUZ),0)),U),"." S PSAOUT=1 Q
 W:$Y @IOF S $P(PSALN,"-",81)="",PSAPG=PSAPG+1
 W !,$E($P($G(^PSDRUG(+PSA,0)),U),1,40),"=> from ",PSAD(2),?60,"PAGE: ",PSAPG,!,PSALN,!?2,"DATE",?16,"TRANSACTION",?33,"QTY",?39,"PKG",?47,"UNIT $",?57,"TOTAL $",?66,"INVENTORY",!,PSALN

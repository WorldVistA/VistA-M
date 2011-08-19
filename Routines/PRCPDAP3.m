PRCPDAP3 ;WISC/RFJ-drug accountability/prime vendor (print items)   ;15 Mar 94
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
LINEITEM ;  print line items
 D H1
 S (LINEITEM,TOTAL)=0 F  S LINEITEM=$O(^TMP($J,"PRCPDAPV SET",STCTRL,"IT",LINEITEM)) Q:'LINEITEM!($G(PRCPFLAG))  S DATA=^(LINEITEM) D
 .   I $Y>(IOSL-8) D:SCREEN P^PRCPUREP Q:$G(PRCPFLAG)  D H,H1
 .   S TOTCOST=$J($P(DATA,"^")*$P(DATA,"^",3),0,2),TOTAL=TOTAL+TOTCOST
 .   W !,LINEITEM,?10,$P(DATA,"^",4),?30,$E($P(DATA,"^",5),1,14),?44,$J($P(DATA,"^"),8),$J($P(DATA,"^",2),6),$J($P(DATA,"^",3),10,2),$J(TOTCOST,12,2)
 .   I $D(^TMP($J,"PRCPDAPV SET",STCTRL,"IT",LINEITEM,"E")) W !?3,^("E") Q
 .   S ITEMDA=+$P(DATA,"^",6),VENDA=+$P(DATA,"^",7)
 .   S VENDATA=$G(^PRC(441,ITEMDA,2,VENDA,0))
 .   W !,?10,$E($$DESCR^PRCPUX1(0,ITEMDA),1,25),?35,"(#",ITEMDA,")",?45,"VN# ",VENDA,?54,$J($$UNITCODE^PRCPUX1(+$P(VENDATA,"^",7)),4),$J($P(VENDATA,"^",2),10,2)
 .   I $D(^TMP($J,"PRCPDAPV SET",STCTRL,"IT",LINEITEM,"E1")) W !?3,^("E1")
 .   I $D(^TMP($J,"PRCPDAPV SET",STCTRL,"IT",LINEITEM,"E2")) W !?3,^("E2")
 .   W !
 I $G(PRCPFLAG) Q
 I $Y>(IOSL-6) D:SCREEN P^PRCPUREP Q:$G(PRCPFLAG)  D H
 W !?68,"------------",!?10,"* * * * *   T O T A L   C O S T   - - - - - - >",?68,$J(TOTAL,12,2)
 I '$D(^TMP($J,"PRCPDAPV SET",STCTRL,"RIL")) K X S X(1)="REPETITIVE ITEM LIST NOT BUILT" D DISPLAY^PRCPUX2(1,80,.X) D:SCREEN P^PRCPUREP Q
 W !!,"* * * *   R E P E T I T I V E   I T E M   L I S T :",$J(^TMP($J,"PRCPDAPV SET",STCTRL,"RIL"),29)
 D:SCREEN P^PRCPUREP
 Q
 ;
 ;
H1 ;  item header
 W !!?10,"* * * * *   I N V O I C E   L I N E   I T E M S   * * * * *"
 W !,"LN",?10,"NDC (6-4-2)",?30,"VENDOR NUMBER",?44,$J("QTY",8),$J("UNIT",6),$J("UNITCOST",10),$J("TOTALCOST",12)
 Q
 ;
 ;
H S %=NOW_"  PAGE "_PAGE,PAGE=PAGE+1 I PAGE'=2!(SCREEN) W @IOF
 W $C(13),"PRIME VENDOR UPLOAD REPORT",?(80-$L(%)),%
 S %="",$P(%,"-",81)=""
 W !,"  SET CONTROL NUMBER: ",STCTRL,!,%
 Q

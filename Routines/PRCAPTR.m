PRCAPTR ;WASH-ISC@ALTOONA,PA/RGY-Print PENDING TRANSACTION ;8/25/93  9:11 AM
V ;;4.5;Accounts Receivable;;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 NEW PRCAE,X0,X1,CNT,TOTAL
 S (CNT,TOTAL)=0
 W:$E(IOST)="C" @IOF D HDR
 F PRCAE=0:0 S PRCAE=$O(^PRCA(433,"AE",1,PRCAE)),X="" Q:'PRCAE  D TOP:$Y+5>IOSL Q:X="^"  D:$P(^PRCA(433,PRCAE,0),"^",4)=2 PRNTL
 I X'="^" W:$Y+5>IOSL @IOF W !?69,"----------",!?60,"TOTAL:",?69,$J(TOTAL,10,2),!?60,"COUNT:",?69,$J(CNT,10,2) W:CNT !?60,"MEAN:",?69,$J(TOTAL/CNT,10,2)
 W:$E(IOST)="P" @IOF Q
TOP ;
 I $E(IOST)="C" S X="" R !,"Press return to continue: ",X:DTIME S:'$T X="^" G:X="^" Q2
 W @IOF D HDR
Q2 Q
PRNTL ;
 S X0=$G(^PRCA(433,PRCAE,0)),X1=$G(^(1)) W !,+X0,?9,$P($G(^PRCA(430,+$P(X0,"^",2),0)),"^")
 W ?22 S Y=+X1 D DT W ?37,$E($P($G(^PRCA(430.2,+$P($G(^PRCA(430,+$P(X0,"^",2),0)),"^",2),0)),"^"),1,15),?55,$E($P($G(^PRCA(430.3,+$P(X1,"^",2),0)),"^"),1,10),?69,$J($P(X1,"^",5),10,2)
 S CNT=CNT+1,TOTAL=TOTAL+$P(X1,"^",5)
 Q
HDR ;
 W !,"Pending Transaction List",!,"Date Printed: " S Y=DT D DT
 W !!,"Tran. #",?9,"Bill #",?22,"Tran. Date",?37,"Category",?55,"Type",?73,"Amount",!
 S X="",$P(X,"-",IOM)="" W X,!
 Q
DT I Y W $P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC",U,$E(Y,4,5))_" " W:Y#100 $J(Y#100\1,2)_"," W Y\10000+1700 W:Y#1 "  "_$E(Y_0,9,10)_":"_$E(Y_"000",11,12) Q
 Q
TSK ;
 NEW ZTSK
 S %ZIS="MQ" D ^%ZIS G:POP Q1
 I '$D(IO("Q")) U IO D PRCAPTR U IO(0) G Q1
 S ZTRTN="^PRCAPTR",ZTDESC="Print Pending Transaction List" D ^%ZTLOAD
Q1 D ^%ZISC K POP Q

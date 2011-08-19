PRCE0A ;WISC/PLT-IFCAP Fiscal Utility ; 04/21/93  3:00 PM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 QUIT  ;illegal entry point
 ;
EN1(PRC410,PRC442,T) ;check adj $amount in 410 and obl/liq/autho amounts in 442
 N A,B,C,D,E S E=0
 S A=$P($G(^PRCS(410,PRC410,4)),U,6),B=$G(^PRC(442,PRC442,8))
 S C=$P(B,U,2),D=$P(B,U,3),B=+B
 I A+B<0 W:T !,$C(7),"This new adjustment amount will make the 1358 amount be negative.",! S E=1 G EX1
 I C>0,A+B<C W:T !,$C(7),"This new adjustment amount will make the 1358 amount be less than the total liquiation amount.",! S E=2 G EX1
 I D>0,A+B<D W:T !,$C(7),"This new adjustment amount will make the 1358 amount be less than the total authorization amount." S E=3 G EX1
EX1 QUIT E

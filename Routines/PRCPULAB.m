PRCPULAB ;WISC/RGY-print barcode labels ;4.21.98
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
S W !!,"Do you want to (S)earch/sort inventory items before printing",!,"... or just (P)rint a range of inventory items ? P//" R X:DTIME S:'$T X="^" S:X="" X="P" G:X="^" Q
 I "SP"'[X W $C(7),!!,"Enter an 'S' to search and print or 'P' to print a specific range of items",! G S
 I X="S" D Q G EN^PRCTLAB
 W ! S DIC="^PRCP(445,",DIC(0)="QEAM",PRCPPRIV=1 D ^DIC K PRCPPRIV G:Y<0 Q S PRCPIP=+Y
STA R !,"Start with item #: ",X:DTIME G:"^"[$E(X) Q I X'?.N W !!,"Enter the item number for this inventory point that you want to start",!,"printing from.",! G STA
 S PRCPSTA=X
END R !,"  End with item #: ",X:DTIME G:"^"[$E(X) Q I X'?.N W !!,"Enter the item number for this inventory point that you want to end with.",! G END
 S PRCPEND=X
 I PRCPSTA=PRCPEND,'$D(^PRCP(445,PRCPIP,1,PRCPSTA,0)) W $C(7),!!,"There is not item # "_PRCPSTA_" defined for this inventory point.",! G STA
 I PRCPSTA>PRCPEND W $C(7),!!,"The beginning item number is greater than the ending item number.",! G STA
DEV ;  select device
 S %ZIS("A")="Select BAR CODE PRINTER: ",%ZIS("B")="",%ZIS="Q"
 K IO("Q") D ^%ZIS K %ZIS G:POP Q
 G:'$D(IO("Q")) DQ
 ;  queueing has been requested
 S ZTRTN="DQ^PRCPULAB" F X="PRCPIP","PRCPSTA","PRCPEND","PRCT" S ZTSAVE(X)=""
 S ZTDESC="Bar Code Label Print",ZTIO=ION D ^%ZTLOAD,HOME^%ZIS K PRCT
Q K POP,PRCPSTA,PRCPEND,PRCPIP Q
 ;
DQ ;
 G:$S('$D(PRCT):1,'$D(^PRCT(446.5,PRCT,0)):1,'$D(^PRCT(446.6,+$P(^(0),"^",6),0)):1,1:0) Q1 S PRCT=$P(^PRCT(446.5,PRCT,0),"^",6) F X=0:0 S X=$O(^PRCT(446.6,PRCT,1,X)) Q:'X  W @^(X,0)
 F PRCPSTA=PRCPSTA-1:0 S PRCPSTA=$O(^PRCP(445,PRCPIP,1,PRCPSTA)) Q:PRCPSTA>PRCPEND!'PRCPSTA  D PRNT
Q1 K PRCPSTA,PRCPEND,PRCPIP,PRCT Q
PRNT ;
 F X=0:0 S X=$O(^PRCT(446.6,PRCT,2,X)) Q:'X  W @(^(X,0))
 S X=$$DESCR^PRCPUX1(PRCPIP,PRCPSTA) S:X="" X="NO DESCRIPTION" W $E(X,1,30),!," ",!,"IE",PRCPIP," ",PRCPSTA
 F X=0:0 S X=$O(^PRCT(446.6,PRCT,3,X)) Q:'X  W @(^(X,0))
 Q

PRCHFGRP ;WISC/AKS-Updating of FOOD GROUP field in file 441 ;8-20-92/09:55
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 N X,Y,ITMZ,PRCPDESC
ITEM W ! S DIC="^PRC(441,",DIC(0)="AEMQ",DIC("A")="Select Item no.: "
 S DIC("S")="I '+$G(^(3))&($P($P(^(0),U,3)/100,""."")=89)"
 S DIC("W")="S ITMZ=^PRC(441,+Y,0),PRCPDESC=$P(ITMZ,U,2) D WD^PRCHFGRP"
 D ^DIC K DIC,DA I X']""!(X="^") G EXIT
 W ! S DR="20//",DIE="^PRC(441,",DA=+Y D ^DIE K DIE,DA,DR
 G ITEM
EXIT QUIT
WD S DESC=$E(PRCPDESC,1,30),DESC=DESC_$J("",30-$L(DESC))
 W $E("     ",$L(X),5) S ZX=$X+1 W DESC_"     NSN: "_$P(ITMZ,U,5) W:$L(PRCPDESC)>30 !,?ZX,$E(PRCPDESC,31,60) K ITMZ,ZX,DESC Q

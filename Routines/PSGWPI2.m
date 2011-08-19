PSGWPI2 ;BHAM ISC/MPH,CML-Print AOU Inventory Sheet - CONTINUED ; 06/28/89 11:38
 ;;2.3; Automatic Replenishment/Ward Stock ;;4 JAN 94
EN1 I $D(STKCHG) W !!!!,"* Indicates change in stock level." K STKCHG
 S $P(LN,"-",132)="",$P(LN1,"-",118)="",$P(LN2,"-",95)="" W:$Y @IOF W !,"WARD STOCK INVENTORY FOR" S Y=PSGWIN X ^DD("DD") W ?26,Y,"  INVENTORY # ",PSGWIDA,?99,PSGTODAY,?120,"PAGE ",PSGPAGE,!,"GROUP: "
 I $P(^PSI(58.19,PSGWIDA,0),"^",4)'="" D WRTGRP
 I $D(BARFLG) D BARHDR G EN1A
 W !,?10,"ITEM",?51,"STOCK",?58,"QUICK",?66,"ON"
 I $P(PSGWSITE,"^",5) W ?74,"REORDER",?83,"MINIMUM QTY",?97,"QUANTITY"
 I $P(PSGWSITE,"^",6) S TAB1=$S($P(PSGWSITE,"^",5):120,1:82) W ?TAB1,"RETURN"
 W !,?51,"LEVEL",?58,"CODE",?66,"HAND"
 I $P(PSGWSITE,"^",5) W ?74,"LEVEL",?83,"TO DISPENSE",?97,"DISPENSED"
 I $P(PSGWSITE,"^",6) S TAB1=$S($P(PSGWSITE,"^",5):109,1:74),TAB2=$S($P(PSGWSITE,"^",5):120,1:82) W ?TAB1,"RETURN",?TAB2,"REASON"
EN1A I PSGPAGE=1 W !!?80,"INVENTORIED/DELIVERED BY __________________________" S LNCNT=LNCNT+3
 W !,LN S PSGPAGE=PSGPAGE+1 I $D(^PSI(58.1,PSGDA,0)) W !!?12,$P(^(0),"^") I $D(^PSI(58.1,PSGDA,"I")),^("I")]"",^("I")'>DT W "   *** INACTIVE ***"
 I $D(^PSI(58.1,PSGDA,0)),$D(PSGWBARS),PSGWBARS S X="S",X2="A"_PSGDA W "   " S X1=$X W @PSGWBAR1,X2,@PSGWBAR0 S LNCNT=LNCNT+3
 Q
 ;
WRTGRP ;Write name(s) of inventory group on header.
 I '$D(PSGWGRP) S PSGWGRP=$S(($P(^PSI(58.19,PSGWIDA,0),"^",4)'=""):$P(^(0),"^",4),1:"")
 F PSGWLP=2:1:($L(PSGWGRP,",")-1) S PSGWPC=$P(PSGWGRP,",",PSGWLP) W $S($D(^PSI(58.2,PSGWPC,0)):$P(^(0),"^"),1:"") W:PSGWLP<($L(PSGWGRP,",")-1) ", "
 Q
 ;
EN2 S ^PSI(58.1,PSGDA,1,J,1,PSGWIDA,0)=PSGWIDA_"^"_$P(^PSI(58.1,PSGDA,1,J,0),"^",2)
 I '$D(^PSI(58.1,PSGDA,1,J,1,0)) S ^(0)="^58.12P^"_PSGWIDA_"^1"
 E  S ^(0)=$P(^PSI(58.1,PSGDA,1,J,1,0),"^",1,2)_"^"_$S($P(^(0),"^",3)<PSGWIDA:PSGWIDA,1:$P(^(0),"^",3))_"^"_($P(^(0),"^",4)+1)
 Q
BARHDR ;Bar Coded Inventory Header
 S LNCNT=0 W !?10,"ITEM",?73,"STOCK" I $P(PSGWSITE,"^",5) W ?80,"REORDER",?89,"MINIMUM QTY",?102,"QUANTITY"
 E  W ?80,"ON"
 I $P(PSGWSITE,"^",6) S TAB1=$S($P(PSGWSITE,"^",5):121,1:97) W ?TAB1,"RETURN"
 W !?73,"LEVEL" I $P(PSGWSITE,"^",5) W ?80,"LEVEL",?89,"TO DISPENSE",?102,"DISPENSED"
 E  W ?80,"HAND"
 I $P(PSGWSITE,"^",6) S TAB1=$S($P(PSGWSITE,"^",5):113,1:87),TAB2=$S($P(PSGWSITE,"^",5):121,1:97) W ?TAB1,"RETURN",?TAB2,"REASON"
 Q
BARWRT ;Bar Coded data lines
 W !?10,PSGDR I DRGDA,$D(PSGWBARS),PSGWBARS S X="S",X2="I"_DRGDA W ?55 S X1=$X W @PSGWBAR1,X2,@PSGWBAR0,*13
 I $D(^PSI(58.1,PSGDA,1,PSGDDA,"EXP")) S Y=^("EXP") I Y X ^DD("DD") W ?14,"Expiration Date: ",Y
 I $P(LOC,"^",5)="Y" W ?72,"*" S STKCHG="Y",$P(^PSI(58.1,PSGDA,1,PSGDDA,0),"^",5)=""
 I (($P(LOC,"^",3)'>PSGWDT)&($P(LOC,"^",10)="Y")) W ?72,"*" S PSGINAD="Y",$P(^PSI(58.1,PSGDA,1,PSGDDA,0),"^",10)=""
 W ?74,$J(STLEV,3) I '$P(PSGWSITE,"^",5) W ?80,"_____"
 I $P(PSGWSITE,"^",5) W ?80,$S(+$P(LOC,"^",11):$J($P(LOC,"^",11),5),1:""),?91,$S($P(LOC,"^",12):$J($P(LOC,"^",12),5),1:""),?103,"______"
 I $P(PSGWSITE,"^",6) S TAB1=$S($P(PSGWSITE,"^",5):113,1:87),TAB2=$S($P(PSGWSITE,"^",5):120,1:97) W ?TAB1,"______",?TAB2,"E O D C"
 I $D(PSGINAD) W !?14,"*Inactivated Item, pull existing stock" K PSGINAD S LNCNT=LNCNT+1
 W !?10,$S($P(PSGWSITE,"^",5):LN1,1:LN2) S LNCNT=LNCNT+3 Q

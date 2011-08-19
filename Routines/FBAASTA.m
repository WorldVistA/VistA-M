FBAASTA ;AISC/GRR-SIGNON STATUS DISPLAY ;28JUL86
 ;;3.5;FEE BASIS;;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 I '$D(^FBAA(161.4,1,0)) W !!,*7,"Site parameters must be entered before using the Fee system!",!,*7 Q
 K UL S $P(UL,"-",40)="-"
 I '$D(^FBAA(161.7,"AB","O",DUZ)) G NONE
SHOW D HED
 F J=0:0 S J=$O(^FBAA(161.7,"AB","O",DUZ,J)) Q:J'>0  I $D(^FBAA(161.7,J,0)) S Y(0)=^(0) D MORE
END K FBBN,FBBT,FBON,FBDO,J,UL Q
MORE S FBBN=$P(Y(0),"^",1),FBON=$P(Y(0),"^",2),FBBT=$P(Y(0),"^",3),FBDO=$P(Y(0),"^",4)
 W !,FBBN,?9,$S(FBBT="B3":"Medical",FBBT="B5":"Pharmacy",FBBT="B2":"Travel",FBBT="B9":"CH/CNH",1:"Unknown"),?21,FBON,?30,$E(FBDO,4,5),"/",$E(FBDO,6,7),"/",$E(FBDO,2,3)
 Q
NONE W !,*7,"You have no open Batches!!",!
 G END
HED D HOME^%ZIS W @IOF,"You currently have the following Batches Open",!!,"Batch",?9,"Batch",?19,"Obligation",?30," Date",!,"  #  ",?10,"Type",?22,"Number",?30,"Opened",!,UL,!

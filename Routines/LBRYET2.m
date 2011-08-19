LBRYET2 ;ISC2/DJM-INPUT TRANSFORMS FOR 681 ;[ 07/09/97  6:36 PM ]
 ;;2.5;Library;**2**;Mar 11, 1996
EN5 ;EDIT TRANSFORM FOR COPY NUMBER (^LBRY(681,1)
 I $G(LBRYLOC)="" Q
 S X2=$G(^LBRY(680,LBRYLOC,7)),X3=$P(X2,U,1) I X3<1 K X,X2,X3 Q
 S X1=X-.1,X1=$O(^LBRY(681,"AC",LBRYLOC,X1)) K:X1=X X
 W:'$D(X) !,"This copy number is already used for this title."
 K X2,X3 Q
E7 ;COPY NUMBER (^LBRY(681,1) HELP MESSAGE
 S LDFX=$P(^LBRY(681,DA,0),U,2) G:$P(^LBRY(680,LDFX,0),U,2)]"" E70
 W "If you choose a COPY NUMBER and select ROUTED or ROUTED TO RETURN at COPY"
 W !,"DISPOSITION you will be asked for a routing list. The routing slip will"
 W !,"list all persons, places etc. in the ROUTING ORDER you selected."
 W !!,"If you choose ToC (Table of Contents) you will be asked for a routing list."
 W !,"A separate routing slip will be produced for each entry in the Table of"
 W !,"Contents routing list.",!
 G EXE7
E70 S XXZ=$S($P(^LBRY(680,LDFX,0),U,2)]"":$P(^(0),U,2),1:"")
 W !,"This title is ",$S(XXZ="C":"cancelled",XXZ="D":"a dead title",XXZ="R":"renamed",1:"not completely set up"),"."
 W:XXZ="" "  Complete the COPIES ORDERED entry using"
 W !,"LTS before entering any copy specific information here."
EXE7 K XXZ Q

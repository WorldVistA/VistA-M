LRBLDELT ;AVAMC/REG - DELETE FILE 65 ENTRIES ;8/18/89  10:55 ;
 ;;5.2;LAB SERVICE;**247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 D END S X="BLOOD BANK" D ^LRUTL G:Y=-1 END
 W !!?25,"DELETE INVENTORY FILE ENTRIES",!?28,"WITH FINAL DISPOSITIONS"
 W !!,$C(7),!!,"Has the tape of the blood inventory file (65) been made ?" S %=2 D YN^LRU G:%'=1 END
 W !!?20,"Delete units (which have final dispositions)",!?20,"received prior to:"
 S %DT="AEQM",%DT("A")="Enter Date:" D ^%DT K %DT G:Y<1 END S LR=Y D D^LRU S X1=LR,LR=Y,X2=-1 D C^%DTC S LRLDT=X
 W !!?20,"Ok to delete units with final disposition",!?20,"received prior to ",LR S %=2 D YN^LRU G:%'=1 END
 S LR=0 D WAIT^LRU W !,"."
 F LRA=0:0 S LRA=$O(^LRD(65,"A",LRA)) Q:'LRA!(LRA>LRLDT)  F LRI=0:0 S LRI=$O(^LRD(65,"A",LRA,LRI)) Q:'LRI  D K
 L +^LRD(65) S X(1)=$O(^LRD(65,0)) S:'X(1) X(1)=0 S X=^LRD(65,0),^(0)=$P(X,"^",1,2)_"^"_X(1)_"^"_($P(X,"^",4)-LR) L -^LRD(65) W $C(7),!!,"Deletion completed.",! Q
K Q:'$D(^LRD(65,LRI,4))  I $P(^(4),"^")=""&('$D(^(6))) Q
 S Y=^LRD(65,LRI,0),C=$P(Y,"^",4),R=$P(Y,"^",5),E=$P(Y,"^",6),Z=$P(Y,"^")
 W:LR#25=0 "." F W=0:0 S W=$O(^LRD(65,LRI,3,W)) Q:'W  S V=+^(W,0) K ^LRD(65,"AL",V,LRI)
 I $D(^LRD(65,LRI,8)) S LRP=+^(8) K:LRP ^LRD(65,"AU",LRP,LRI)
 F W=0:0 S W=$O(^LRD(65,LRI,2,W)) Q:'W  K ^LRD(65,"AP",W,LRI) F V=0:0 S V=$O(^LRD(65,LRI,2,W,1,V)) Q:'V  S Y=$P(^(V,0),"^",9) I Y K ^LRD(65,"AN",Y,LRI,W,V)
 I $L(Z)>2 F X(1)=3:1:4 I '$E(Z,X(1)) K ^LRD(65,"B",$E(Z,X(1),$L(Z)),LRI) Q
 S X(1)=$S($D(^LRD(65,LRI,4)):$P(^(4),"^",2),1:"") K:X(1) ^LRD(65,"AB",X(1),LRI)
 K ^LRD(65,LRI),^LRD(65,"A",R,LRI),^LRD(65,"B",Z),^LRD(65,"AT",Z),^LRD(65,"AI",C,Z),^LRD(65,"AE",C,E,LRI),^LRO(69.2,LRAA,8,65,1,LRI),^LRO(69.2,LRAA,8,65,1,"B",Z)
 S LR=LR+1 Q
 ;
END D V^LRU Q

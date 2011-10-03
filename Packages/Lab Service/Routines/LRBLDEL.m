LRBLDEL ;AVAMC/REG - DELETE FILE 65 ENTRIES ;8/14/90  14:36 ;
 ;;5.2;LAB SERVICE;**247,408**;Sep 27, 1994;Build 8
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 Q  D END S X="BLOOD BANK" D ^LRUTL G:Y=-1 END
 W !!?25,"DELETE INVENTORY FILE ENTRIES",!?28,"WITH FINAL DISPOSITIONS"
 I '$D(^LRO(69.2,LRAA,8,65,1)) W !!?26,$C(7),"NO DELETION LIST",!,"USE Print units with final disposition OPTION under supervisor OPTIONS" G END:'$D(^XUSEC("LRLIASON",DUZ)),A
 S X=^LRO(69.2,LRAA,8,65,0),LR=0
 W !!?15,"Units received from: ",$P(X,U,2)," to ",$P(X,U,3),!?15,"with final dispositions will be deleted. OK " S %=2 D YN^LRU G:%'=1 END
 D WAIT^LRU W !,"."
 S X=0 F LRA=1:1 S X=$O(^LRO(69.2,LRAA,8,65,1,X)) Q:'X  I $D(^LRD(65,X,0)) S Y=^(0),C=$P(Y,"^",4),R=$P(Y,"^",5),E=$P(Y,"^",6),Z=$P(Y,"^") D K
OUT L +^LRD(65) S X(1)=$O(^LRD(65,0)) S:'X(1) X(1)=0 S X=^LRD(65,0),^(0)=$P(X,"^",1,2)_"^"_X(1)_"^"_($P(X,"^",4)-LR) L -^LRD(65) K ^LRO(69.2,LRAA,8,65,1) W $C(7),!!,"Deletion completed.",! G END
K W:LRA#25=0 "." F W=0:0 S W=$O(^LRD(65,X,3,W)) Q:'W  S V=+^(W,0) K ^LRD(65,"AL",V,X)
 F W=0:0 S W=$O(^LRD(65,X,15,W)) Q:'W  S V=$P(^(W,0),"^",8) K:V ^LRD(65,"A",V,X)
 I $D(^LRD(65,X,8)) S LRP=+^(8) K:LRP ^LRD(65,"AU",LRP,X)
 F W=0:0 S W=$O(^LRD(65,X,2,W)) Q:'W  K ^LRD(65,"AP",W,X) F V=0:0 S V=$O(^LRD(65,X,2,W,1,V)) Q:'V  S Y=$P(^(V,0),"^",9) I Y K ^LRD(65,"AN",Y,X,W,V)
 S DA=X D K^LRBLU
 S X(1)=$S($D(^LRD(65,X,4)):$P(^(4),"^",2),1:"") K:X(1) ^LRD(65,"AB",X(1),X)
 K ^LRD(65,X),^LRD(65,"A",R,X),^LRD(65,"B",Z),^LRD(65,"AT",Z),^LRD(65,"AI",C,Z),^LRD(65,"AE",C,E,X),^LRO(69.2,LRAA,8,65,1,X),^LRO(69.2,LRAA,8,65,1,"B",Z)
 S LR=LR+1 Q
A G:$P($T(LRBLDEL+1),"~",2)<5.3 END
 W !!,"To delete units without a deletion list:",!,"Did you make a backup tape of the BLOOD INVENTORY file " S %=2 D YN^LRU G:%'=1 END
 W !,"Did you check the backup tape " S %=2 D YN^LRU G:%'=1 END W !!?19,"Ok to delete units with final disposition",!?19,"from one date received to another " S %=2 D YN^LRU G:%'=1 END W !
 D B G:Y<0 END S LRLDT=LRLDT+.99,LRSDT=LRSDT-.0001,LR=0 D WAIT^LRU
 F A=1:1 S LRSDT=$O(^LRD(65,"A",LRSDT)) Q:'LRSDT!(LRSDT>LRLDT)  F X=0:0 S X=$O(^LRD(65,"A",LRSDT,X)) Q:'X  I $D(^LRD(65,X,4)),$P(^(4),"^")]"",$D(^(0)) S Y=^(0),C=$P(Y,"^",4),R=$P(Y,"^",5),E=$P(Y,"^",6),Z=$P(Y,"^") D:R=LRSDT K
 G OUT
 ;
B S %DT="AEX",%DT(0)="-N",%DT("A")="Start with Date: " D ^%DT K %DT
 Q:Y<1  S LRSDT=Y
 S %DT="AEX",%DT("A")="Go    to   Date " D ^%DT K %DT
 Q:Y<1  S LRLDT=Y I LRSDT>LRLDT S X=LRSDT,LRSDT=LRLDT,LRLDT=X
 S Y=LRSDT D D^LRU S LRSTR=Y,Y=LRLDT D D^LRU S LRLST=Y Q
END D V^LRU Q

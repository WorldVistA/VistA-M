LRBLDK ;AVAMC/REG - DELETE EX-DONORS (65.5 ENTRIES) ; 11/12/88  13:19 ;
 ;;5.2;LAB SERVICE;**247,408**;Sep 27, 1994;Build 8
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 Q  D V^LRU S X="BLOOD BANK" D ^LRUTL G:Y=-1 END
 W !!?15,"DONORS WHO HAVE NOT DONATED SINCE A SPECIFIED DATE",!
 I '$D(^LRO(69.2,LRAA,8,65.5,1)) W !!?32,$C(7),"NO DELETION LIST",!!?14,"To obtain a list of donors to delete first print them",!,"using the Print ex-donors OPTION under supervisor OPTIONS" G END
 S X=^LRO(69.2,LRAA,8,65.5,0),LR=$P(^(1,0),U,4)
 W !!?20,"DONORS NOT DONATING SINCE ",$P(X,U,2),!?20,"will be deleted. OK " S %=2 D YN^LRU G:%'=1 END
 D WAIT^LRU W !,"."
 S X=0 F A=1:1 S X=$O(^LRO(69.2,LRAA,8,65.5,1,X)) Q:'X  I $D(^LRE(X,0)) S Y=^(0),Z=$P(Y,"^"),Z(1)=$E(Y,1)_$E($P(Y,"^",3),4,7),S=$P(Y,"^",13) D K
 L +^LRE(0) S X=^LRE(0),X(1)=$O(^(0)),^(0)=$P(X,"^",1,2)_"^"_X(1)_"^"_($P(X,"^",4)-LR) L -^LRE(0) G END
K W:A#25=0 "." F W=0:0 S W=$O(^LRE(X,5,W)) Q:'W  S W(1)=^(W,0),V=+W(1) K ^LRE("AD",$P(V,".",1),X) S W(4)=$P(W(1),"^",4) I W(4)]"" K ^LRE("C",W(4),X,W),^LRE("AT",W(4)) K:$L(W(4))>2 ^LRE("C",$E(W(4),3,12),X,W)
 I S]"" K ^LRE("G",S,X) S S=$E(Z)_$E(S,6,10) K ^LRE("G4",S,X)
 K ^LRE("D",Z(1),X),^LRE("B",Z,X),^LRE(X) Q
 ;
END D V^LRU Q

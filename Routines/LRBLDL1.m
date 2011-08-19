LRBLDL1 ;AVAMC/REG - BLOOD DONOR LABELS ; 10/23/88  15:45 ;
 ;;5.2;LAB SERVICE;**247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 U IO S P=P(1) F A=0:1 S P=$O(^LRE("B",P)) G:P=""!(P]P(2)) END F I=0:0 S I=$O(^LRE("B",P,I)) Q:'I  S W=$O(^LRE(I,5,0)) I W>LRSDT S W=^(W,0) D W
END D V^LRU,END^LRUTL Q
 ;
W Q:$P(^LRE(I,0),"^",10)  S W(7)=$P(W,"^",7) I LR,W(7)'=LR,'$D(^LRE(I,2,LR)) Q
 S C=1 W $P(P,",",2)_" "_$P(P,",",1)
 I $D(^LRE(I,1)) S X=^(1) D A
 F B=C:1:LR(1) W !
 Q
A F B=1:1:3 I $P(X,"^",B)]"" S C=C+1 W !,$P(X,"^",B)
 S C=C+1 W !,$P(X,"^",4) W:$P(X,"^",5) ", ",$P(^DIC(5,$P(X,"^",5),0),"^",2) W " ",$P(X,"^",6) Q

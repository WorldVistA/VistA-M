LRSPGD ;AVAMC/REG - ANATOMIC PATH DESCRIPTION ;9/20/95  10:56 ;
 ;;5.2;LAB SERVICE;**72**;Sep 27, 1994
 S A=$O(^LR(LRDFN,LRSS,LRI,.1,0)) Q:'A  S X=^(A,0) S:$E(X,1)=" " X=$E(X,2,255) Q:X=""  S X=$P(X,"^")
 F A=0:0 S A=$O(^LAB(62.5,"B",X,A)) Q:'A  I $E(LRSS)_"I"[$P(^LAB(62.5,A,0),"^",4) D S Q
 Q
S S %X="^LAB(62.5,A,""WP"",",%Y="^LR(LRDFN,LRSS,LRI,1," D %XY^%RCR Q
M S %X="^LAB(62.5,A,""WP"",",%Y="^LR(LRDFN,LRSS,LRI,1.1," D %XY^%RCR Q
D S %X="^LAB(62.5,A,""WP"",",%Y="^LR(LRDFN,LRSS,LRI,1.4," D %XY^%RCR Q
A S %X="^LAB(62.5,A,""WP"",",%Y="^LR(LRDFN,82," D %XY^%RCR Q
EN ;
 S A=$O(^LR(LRDFN,LRSS,LRI,1.1,0)) G:'A DX S X=$P(^(A,0),"*",2) G:X="" DX
 I $O(^LR(LRDFN,LRSS,LRI,1.1,A)) G DX
 F A=0:0 S A=$O(^LAB(62.5,"B",X,A)) Q:'A  I $E(LRSS)_"I"[$P(^LAB(62.5,A,0),"^",4) K ^LR(LRDFN,LRSS,LRI,1.1) D M Q
DX S A=$O(^LR(LRDFN,LRSS,LRI,1.4,0)) Q:'A  S X=$P(^(A,0),"*",2) Q:X=""
 Q:$O(^LR(LRDFN,LRSS,LRI,1.4,A))
 F A=0:0 S A=$O(^LAB(62.5,"B",X,A)) Q:'A  I $E(LRSS)_"I"[$P(^LAB(62.5,A,0),"^",4) K ^LR(LRDFN,LRSS,LRI,1.4) D D Q
 Q
AU ;
 S A=$O(^LR(LRDFN,82,0)) Q:'A  S B=$O(^(A)) Q:B  S X=$P(^(A,0),"*",2) Q:X=""
 K ^LR(LRDFN,82) F A=0:0 S A=$O(^LAB(62.5,"B",X,A)) Q:'A  I $E(LRSS)_"I"[$P(^LAB(62.5,A,0),"^",4) D A Q
 Q

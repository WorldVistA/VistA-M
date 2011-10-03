LRAPBS2 ;AVAMC/REG - BLOCK/SLIDE DATA ENTRY ;2/6/92  19:19 ;
 ;;5.2;LAB SERVICE;;Sep 27, 1994
 ;put date stained/block prepared/gross cutting in lab data file
 I $D(LRF) D C Q
 F A=0:0 S A=$O(^LR(LRDFN,LRSS,LRI,.1,A)) Q:'A  F B=0:0 S B=$O(^LR(LRDFN,LRSS,LRI,.1,A,B)) Q:'B  F C=0:0 S C=$O(^LR(LRDFN,LRSS,LRI,.1,A,B,C)) Q:'C  D:$D(LRK(1)) BLK D X
 Q
X F E=0:0 S E=$O(^LR(LRDFN,LRSS,LRI,.1,A,B,C,1,E)) Q:'E  S:'$P(^(E,0),"^",4) $P(^(0),"^",4)=LRK
 Q
BLK S:'$P(^LR(LRDFN,LRSS,LRI,.1,A,B,C,0),"^",2) $P(^(0),"^",2)=LRK(1) Q
 ;
C F A=0:0 S A=$O(^LR(LRDFN,LRSS,LRI,.1,A)) Q:'A  S:'$P(^(A,0),"^",3) $P(^(0),"^",3)=LRK
 Q
EN ;
 G:LRSS'="AU" LRAPBS2
 ;put date autopsy blocks/stains prepared in lab data file
 F A=0:0 S A=$O(^LR(LRDFN,33,A)) Q:'A  F B=0:0 S B=$O(^LR(LRDFN,33,A,B)) Q:'B  F C=0:0 S C=$O(^LR(LRDFN,33,A,B,C)) Q:'C  D:$D(LRK(1)) AUBLK D AUX
 Q
AUX F E=0:0 S E=$O(^LR(LRDFN,33,A,B,C,1,E)) Q:'E  S:'$P(^(E,0),"^",4) $P(^(0),"^",4)=LRK
 Q
AUBLK S:'$P(^LR(LRDFN,33,A,B,C,0),"^",2) $P(^(0),"^",2)=LRK(1) Q

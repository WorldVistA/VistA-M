LRBLDC1 ;AVAMC/REG - COMPONENT PREP WORKLOAD ;4/20/93  11:49
 ;;5.2;LAB SERVICE;**247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 Q:'LRI!('LRCAPA)  F A=0:0 S A=$O(^LRE(LRQ,5,LRI,66,A)) Q:'A  S LRK=$P(^(A,0),"^",3) D:LRK S
 Q
S K B F B=0:0 S B=$O(^LAB(66,A,9,B)) Q:'B  S B(B)=""
 I $D(B)'=11 W $C(7),!!,$P(^LAB(66,A,0),"^")," -No WKLD codes entered in BLOOD PRODUCT file",!,"Component preparation workload will not be recorded" Q
 S:'$D(^LRE(LRQ,5,LRI,99,0)) ^(0)="^65.599PA^^" I '$D(^(LRT,0)) S ^(0)=LRT,X=^LRE(LRQ,5,LRI,99,0),^(0)=$P(X,"^",1,2)_"^"_LRT_"^"_($P(X,"^",4)+1)
 S:'$D(^LRE(LRQ,5,LRI,99,LRT,1,0)) ^(0)="^65.5991DA^^" I '$D(^LRE(LRQ,5,LRI,99,LRT,1,LRK,0)) S ^(0)=LRK_"^"_DUZ,X=^LRE(LRQ,5,LRI,99,LRT,1,0),^(0)=$P(X,"^",1,2)_"^"_LRK_"^"_($P(X,"^",4)+1)
 F C=0:0 S C=$O(B(C)) Q:'C  D STF
 S ^LRE("AA",LRQ,LRI,LRT,LRK)=$P(^LRE(LRQ,5,LRI,0),"^",4) I '$D(^LRE(LRQ,5,LRI,99,LRT,1,LRK,1,0)) K ^LRE(LRQ,5,LRI,99,LRT,1,LRK) S X=^LRE(LRQ,5,LRI,99,LRT,1,0),X(1)=$O(^(0)),^(0)=$P(X,"^",1,2)_"^"_X(1)_"^"_($P(X,"^",4)-1)
 Q
STF Q:$D(^LRE(LRQ,5,LRI,99,LRT,1,LRK,1,C,0))
 S:'$D(^LRE(LRQ,5,LRI,99,LRT,1,LRK,1,0)) ^(0)="^65.59911PA^^" L +^LRE(LRQ,5,LRI,99,LRT,1,LRK,1)
 S X=^LRE(LRQ,5,LRI,99,LRT,1,LRK,1,0),^(0)=$P(X,"^",1,2)_"^"_C_"^"_($P(X,"^",4)+1),^(C,0)=C_"^"_1 L -^LRE(LRQ,5,LRI,99,LRT,1,LRK,1) Q

LRUTRAN ;AVAMC/REG - TRANSFER ^LR(LRDF,LRSS, TO ^LR(LRDFN#2,LRSS, ;5/9/91  18:24 ;
 ;;5.2;LAB SERVICE;;Sep 27, 1994
 W !,"Transfer data in Lab Data File (#63) from one entry to another"
 S LRDPAF=1,U="^",DIC=68,DIC(0)="AEMOQZ",DIC("A")="Select AP section: ",DIC("S")="I ""CYEMSP""[$P(^(0),U,2)&($P(^(0),U,2)]"""")" D ^DIC G:Y<1 END S LRAA=+Y,LRSS=$P(Y(0),U,2) D XR^LRU
 ;
A K DIC W !!?7,"Transfer from" D ^LRDPA G:LRDFN<1 END S LR(1)=LRDFN
 S X=$S('$D(^LR(LRDFN,LRSS,0)):1,'$P(^(0),U,4):1,1:0) I X W $C(7),!,"There are no entries to transfer !" G A
 W !!?7,"Transfer   to" D ^LRDPA G:LRDFN<1 A S LR(2)=LRDFN
 I LR(1)=LR(2) W $C(7),!!?22,"Same patient- transfer not necessary!" G A
 W !!,"OK to transfer " S %=2 D YN^LRU G:%'=1 A
 F A=0:0 S A=$O(^LR(LR(1),LRSS,A)) Q:'A  S X=^(A,0),R=$P(X,"^",10),N=$P(X,"^",6),Y=$E(R,1,3) K ^LR(LRXR,R,LR(1),A),^LR(LRXREF,Y,N,LR(1),A) S ^LR(LRXR,R,LR(2),A)="",^LR(LRXREF,Y,N,LR(2),A)="" D B
 S %X="^LR(LR(1),LRSS,",%Y="^LR(LR(2),LRSS," D %XY^%RCR
 K ^LR(LR(1),LRSS) S X=0 F A=0:1 S X=$O(^LR(LR(2),LRSS,X)) Q:'X
 S X=^LR(LR(2),LRSS,0),^(0)=$P(X,"^",1,2)_"^^"_A Q
 ;
B I $D(^LRO(68,LRAA,1,Y,1,N,0)) S Y=Y_"0000",$P(^(0),"^")=LR(2) Q
 ;
END D V^LRU Q

LRCKF69 ;SLC/RWF - CHECK FILE 69 ; 2/22/87  1:47 PM ;
 ;;5.2;LAB SERVICE;**272,293**;Sep 27, 1994
 S ZTRTN="ENT^LRCKF69" D LOG^LRCKF Q:LREND  D ENT W !! W:$E(IOST,1,2)="P-" @IOF D ^%ZISC Q
ENT ;from LRCKF
 U IO W !,"   CHECKING FILE 69",! S LRPSN=0,U="^" S:'$D(LRODT) LRODT=DT F I=1:1:10 S E(9,I)=0
 F LRODT=0:0 S LRODT=$O(^LRO(69,LRODT)) Q:LRODT<1  D LRSN
 W !! W:$E(IOST,1,2)="P-" @IOF Q
 Q
LRSN I '$O(^LRO(69,LRODT,1,0)) W "." Q
 S Y=LRODT D DD^LRX W:$Y'<IOSL @IOF W !,"ORDER DATE: ",Y
 I LRODT["." W !?10,"BAD ORDER DATE ",!
 F LRSN=0:0 S LRSN=$O(^LRO(69,LRODT,1,LRSN)) Q:LRSN'>0  D CHK69
 Q
NAME S E(9,E)=1+E(9,E) I E(9,E)>20 S E=0 Q
 I LRPSN'=LRSN W !!,"ORDER: ",LRORDER," LRSN: ",LRSN S LRPSN=LRSN
 Q
CHK69 I $D(^LRO(69,LRODT,1,LRSN,0))[0 Q  ;MUST BE A PLACE HOLDER
 S LA=^LRO(69,LRODT,1,LRSN,0),LRDFN=+LA,LRORDER=$S($D(^(.1)):^(.1),1:""),LRCTRL=$S($D(^LR(LRDFN,0))#2:$P(^(0),U,2),1:0)=62.3
 I $D(^LR(LRDFN,0))[0 S E=1 D NAME I E W !?5,"F- Entry ",LRDFN," in ^LR( is missing."
 I 'LRCTRL,LRORDER="" S E=2 D NAME I E W !?5,"F- Does not have an ORDER number."
 I 'LRCTRL,$D(^LAB(62,+$P(LA,U,3),0))[0 S E=3 D NAME I E W !?5,"F- BAD pointer (",$P(LA,U,3),") to collection file."
 I 'LRCTRL,$D(^VA(200,+$P(LA,U,2),0))[0 S E=4 D NAME I E W !?5,"F- BAD pointer to user New Person file."
 F T=0:0 S T=$O(^LRO(69,LRODT,1,LRSN,2,T)) Q:T'>0  I $D(^(T,0))#2 S X=^(0) D TEST
 F T=0:0 S T=$O(^LRO(69,LRODT,1,LRSN,4,T)) Q:T'>0  I $D(^(T,0))#2 S X=^(0) D SPEC
 Q
TEST I $D(^LAB(60,+X,0))[0 S E=5 D NAME I E W !?5,"F- BAD pointer to test file (60)."
 I $D(^LAB(62.05,+$P(X,U,2),0))[0 S E=6 D NAME I E W !?5,"F- BAD pointer to urgency file (62.05)."
 S LRAD=$P(X,U,3),LRAA=$P(X,U,4),LRAN=$P(X,U,5)
 I LRAA,LRAD,LRAN,$D(^LRO(68,LRAA,1,LRAD,1,LRAN,0))[0 S E=7 D NAME I E W !?5,"F- BAD pointer to the accession file."
 Q
SPEC I $D(^LAB(61,+X,0))[0 S E=8 D NAME I E W !?5,"F- BAD pointer to the specimen file (61)."
 Q

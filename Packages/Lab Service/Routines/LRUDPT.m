LRUDPT ;AVAMC/REG - POW PTS ;2/18/93  12:36 ;
 ;;5.2;LAB SERVICE;;Sep 27, 1994
 D XR^LRU
 W !!?25,LRAA(1)," SEARCH FOR",!?28,"PRISONER OF WAR VETS",!!
 D B^LRU Q:Y<0  S LRSDT=LRSDT-.01,LRLDT=LRLDT+.99
DEV S ZTRTN="QUE^LRUDPT" D BEG^LRUTL Q:POP!($D(ZTSK))
QUE U IO K ^TMP($J) S Z(4)=0 D L^LRU,HDR
 F A=0:0 S LRSDT=$O(^LR(LRXR,LRSDT)) Q:LRSDT<1!(LRSDT>LRLDT)  D LRDFN
 D WRT W:IO'=IO(0) @IOF K N,P,LRP,LRXREF,LRXR,^TMP($J) D END^LRUTL Q
LRDFN F LRDFN=0:0 S LRDFN=$O(^LR(LRXR,LRSDT,LRDFN)) Q:LRDFN<1  D CK
 Q
CK Q:$P(^LR(LRDFN,0),"^",2)'=2  S DFN=$P(^(0),"^",3),S(4)=""
POW I $D(^DPT(DFN,.52)),$P(^(.52),"^",5)="Y" S X=$P(^(.52),"^",6) S:X X=$S($D(^DIC(22,X,0)):$P(^(0),"^"),1:"") S S(4)=S(4)_"POW " S:$L(X) S(4)=S(4)_" PERIOD "_X
 D:$Y>60 HDR I $L(S(4)) S X=^DPT(DFN,0),LRDPF=2,LRP=$P(X,"^"),SSN=$P(X,"^",9),Y=$P(X,"^",3) D D^LRU,SSN^LRU S ^TMP($J,LRP,SSN)=Y_"^"_S(4)
 Q
HDR S Z(4)=Z(4)+1,%DT="T",X="N" D ^%DT,D^LRU W @IOF,!?23,"LABORATORY SERVICE ",$$INS^LRU,!,Y,?22,LRAA(1)," Special patients  ",?73,"Pg: ",Z(4),!,"From: ",LRSTR," to ",LRLST,!
 W !,"Patient",?40,"DOB",?60,"ID",!,LR("%") Q
WRT S N=0 F A=0:0 S N=$O(^TMP($J,N)) Q:N=""  S I=0 F B=0:0 S I=$O(^TMP($J,N,I)) Q:I=""  S P=^(I) D:$Y>60 HDR W !,N,?40,$P(P,"^"),?60,I,!?5,$P(P,"^",2)
 Q

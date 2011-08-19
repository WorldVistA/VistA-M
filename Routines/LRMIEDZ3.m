LRMIEDZ3 ;SLC/CJS/BA - MICROBIOLOGY EDIT ROUTINE CONT. ; 7/21/87  11:01 ;
 ;;5.2;LAB SERVICE;;Sep 27, 1994
TIME ;from LRMIEDZ2
 F I=0:0 S %DT="XT",X="N",LREND=0 D:'LRFIFO COMP Q:X=""!(X=U)!(X="@")  D ^%DT I X'="?" D:Y>0 STORE Q:Y'<1!('$L(X))
 I X'=U D:LRSAME POST
 K %DT
 Q
COMP S Y=$P(^LRO(68,LRAA,1,LRAD,1,+LRAN,4,LRTS,0),U,5) D:Y>0 DD^LRX W !,$P(^LAB(60,LRTS,0),U)," completed: "
 W:Y'="" Y," //" R X:DTIME S:X=U LREND=1
 Q:X=U!(X="")  I X="@" D DEL Q
 S %DT="XET" W:X="?" !,"Return represents an incomplete test, date/time represents when completed."
 Q
DEL F I=0:0 W !,"  Sure you want to delete" S %=2 D YN^DICN Q:%  W !,"This will set the test back to 'incomplete' status."
 I %=1 S Y=+$P(^LRO(68,LRAA,1,LRAD,1,+LRAN,4,LRTS,0),U,5),$P(^LRO(68,LRAA,1,LRAD,1,+LRAN,4,LRTS,0),U,5)="" K:Y ^LRO(68,LRAA,1,LRAD,1,"AD",$P(Y,"."),+LRAN),^LRO(68,LRAA,1,LRAD,1,"AC",Y,+LRAN)
 Q
STORE D NOW^%DTC I Y>% W !,$C(7),"Date must not be in the future.",! S Y=-1 Q
 S $P(^LRO(68,LRAA,1,LRAD,1,+LRAN,4,LRTS,0),U,4,5)=DUZ_U_Y,^LRO(68,LRAA,1,LRAD,1,"AD",$P(Y,"."),+LRAN)="",^LRO(68,LRAA,1,LRAD,1,"AC",Y,+LRAN)=""
 Q
POST S LRI=0 F I=0:0 S LRI=$O(LRTS(LRI)) Q:LRI<1  Q:LRTS(LRI)=LRTS
 Q:LRI<1  S K=0,J=0 F I=0:0 S J=$O(LRTX(J)) Q:J<1  I J'=LRI,LRTX(J)=LRTX(LRI) S K=1 W !,$P(^LAB(60,+LRTS(J),0),U)
 Q:'K
 F I=0:0 S Y=$P(^LRO(68,LRAA,1,LRAD,1,+LRAN,4,LRTS,0),U,5) Q:'Y  W !,"  Have the same edit template.",!,"    Are all complete" S %=2 D YN^DICN Q:%
 I Y,%=1 F J=0:0 S J=$O(LRTX(J)) Q:J<1  I J'=LRI,LRTX(J)=LRTX(LRI) S:'$P(^LRO(68,LRAA,1,LRAD,1,+LRAN,4,+LRTS(J),0),U,5) $P(^(0),U,4,5)=DUZ_U_Y,^LRO(68,LRAA,1,LRAD,1,"AD",$P(Y,"."),+LRAN)="",^LRO(68,LRAA,1,LRAD,1,"AC",Y,+LRAN)=""
 Q

LRUFILE ;AVAMC/REG - FILE OUTLINE ;8/16/95  15:42 ;
 ;;5.2;LAB SERVICE;**72**;Sep 27, 1994
ASK D END F LRA=1:1 S DIC="^DIC(",DIC(0)="AEQM",DIC("S")="I Y>59.9999&(Y<70)" D ^DIC K DIC Q:Y<1  S LRG(LRA)=+Y
 G:LRA=1 END W !!,"Brief listing: " S %=1 D YN^LRU G:%<1 END S LRB="" S:%=1 LRB=1
DEV S ZTRTN="QUE^LRUFILE" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO S X="T",%DT="" D ^%DT,D^LRU,L^LRU,S^LRU S LRH(0)=Y F A=0:0 S A=$O(LRG(A)) Q:'A  S F=LRG(A) D REST
 W:IO'=IO(0) @IOF D END^LRUTL,END Q
REST S Z(4)=1,LRFNAM=$O(^DD(F,0,"NM",0)) W @IOF,!,LRH(0),?25,LRFNAM," (",F,")",?73,"Pg ",Z(4),!,LR("%")
FF S W=1,E=0,I=0 F  S V=1,I=$O(^DD(F,I)) D UP:I'>0 Q:F=-1  I V D WR,DN:$P(^DD(F,I,0),"^",2)
 Q
DN S E=E+1,F(E)=F_"^"_I,X=I,F=+$P(^DD(F,I,0),"^",2),I=0,W=W+2 Q:'LRB  W " (Subfile ",F,")" Q
UP G UP1:E=0 S F=+F(E),I=$P(F(E),"^",2) K F(E) S V=0,W=W-2,E=E-1 Q
WR D:$Y>60 HDR S X=^DD(F,I,0) W !?W,I,?W+4," ",$P(X,"^") Q:LRB  W "^",$P(X,"^",2,5) Q
UP1 S F=-1 Q
HDR S Z(4)=Z(4)+1 W @IOF,!,LRH(0),?25,LRFNAM," (",F,")",?73,"Pg ",Z(4),!,LR("%") Q
LIST ;print all file titles from one number to another
BEG R !,"Start with file number: ",LR:DTIME G:LR=""!(LR["^") END I LR'=+LR D HELP G BEG
 S LR=LR-.0000001
E R !,"End with file number: ",LR(1):DTIME G:LR(1)=""!(LR["^") END I LR(1)'=+LR(1) D HELP G E
 S LR(1)=LR(1)+.0000001
 S ZTRTN="QUE1^LRUFILE" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE1 U IO D S^LRU,H
 F LR(2)=LR:0 S LR(2)=$O(^DIC(LR(2))) Q:LR(2)>LR(1)!('LR(2))  D:$Y>(IOSL-7) H I $D(^DIC(LR(2),0)) W !?10,LR(2),?20,$P(^(0),"^")
 W:IO'=IO(0) @IOF D END^LRUTL,END Q
 ;
H S X="N",%DT="T" D ^%DT,D^LRU K %DT S LRQ=LRQ+1 W @IOF,!,Y,?30,"TABLE OF CONTENTS FOR FILES",?(IOM-8),"Pg: ",LRQ,!?30,LRQ(1),!! Q
 ;
HELP W $C(7),!!,"Enter a number.  No other characters allowed.",! Q
 ;
END D V^LRU Q

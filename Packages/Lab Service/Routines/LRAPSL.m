LRAPSL ;AVAMC/REG/CYM - ANATOMIC PATH SLIDE LABELS ;2/13/98  13:41 ;
 ;;5.2;LAB SERVICE;**72,201**;Sep 27, 1994
 D ^LRAP G:'$D(Y) END I LRSS="AU" D AU^LRAPBS1 G:J END S:'$D(LRW(0)) LRW(0)=$O(^LAB(60,"B","AUTOPSY H & E",0))
ASK S LRZ=1,%DT="",X="T" D ^%DT S LRY=$E(Y,1,3)+1700 W !,"Enter year: ",LRY,"// " R X:DTIME G:'$T!(X[U) END S:X="" X=LRY
 S %DT="EQ" D ^%DT G:Y<1 ASK S LRY=$E(Y,1,3),LRH(0)=LRY+1700 W "  ",LRH(0)
 S LRR=0 W !!,"Reprint slide labels " S %=2 D YN^LRU G:%<1 END I %=1 S LRR=1 G R
 W !!,"Add/Delete slide labels to print " S %=2 D YN^LRU G:%<1 END I %=1 D S^LRAPST,^LRAPSL1
 W !!,"Print ",LRO(68)," slide labels for ",LRY+1700
R R !!,"Start with accession number: ",X:DTIME G:X=""!(X[U) END S LR(3)=X I +X'=X D HELP G R
RR R !,"Go    to   accession number: LAST// ",LR(4):DTIME G:'$T!(LR(4)[U) END S:LR(4)="" LR(4)=9999999 I LR(4)'=+LR(4) D HELP G RR
 S:'LR(4) LR(4)=9999999
 I LR(4)<LR(3) S X=LR(3),LR(3)=LR(4),LR(4)=X
 D SET W !!,"Just a moment while I check to see if there are labels to print",!! D C I '$D(LRZ(1)) W $C(7),?20,"There are no labels to print" G END
 K LRZ S ZTRTN="QUE^LRAPSL" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO W $C(13) D SET
 D C F A=0:0 S A=$O(^TMP($J,A)) Q:'A  D W
 D END^LRUTL,END Q
C F A=LR(3)-1:0 S A=$O(^LR(LRXREF,LRY,LRABV,A)) Q:'A!(A>LR(4))  S LRDFN=$O(^(A,0)),LRI=$O(^(LRDFN,0)) D S
 Q
W W !,LRABV,?10,LRABV,?20,LRABV,?30,LRABV,?40,LRABV,?50,LRABV
 F C=2:1:4 W ! F B=0:1:5 W ?B*10,$S($D(^TMP($J,A,B+1,C)):^(C),1:"")
 W !,LR(12),?10,LR(12),?20,LR(12),?30,LR(12),?40,LR(12),?50,LR(12)
 W ! Q
S I LRSS="AU" D AU Q
 F B=0:0 S B=$O(^LR(LRDFN,LRSS,LRI,.1,B)) Q:'B!($D(LRZ(1)))  F J=0:0 S J=$O(^LR(LRDFN,LRSS,LRI,.1,B,J)) Q:'J!($D(LRZ(1)))  F C=0:0 S C=$O(^LR(LRDFN,LRSS,LRI,.1,B,J,C)) Q:'C!($D(LRZ(1)))  S LRB=$P(^(C,0),"^") D T
 Q
T F E=0:0 S E=$O(^LR(LRDFN,LRSS,LRI,.1,B,J,C,1,E)) Q:'E  S X=^(E,0),F=$S('LRR:$P(X,"^",7),1:$P(X,"^",6)) D:'F X I F S:$D(LRZ) LRZ(1)=1 Q:$D(LRZ)  S $P(^(0),"^",7)=0,LR(9)=$S($D(^LAB(60,E,.1)):$P(^(.1),"^"),1:"") D P
 Q
P F G=1:1:F S LR(6)=LR(6)+1,LR(8)=LR(6)#6,LR(7)=LR(6)\6+1 S:'LR(8) LR(7)=LR(7)-1 S:'LR(8) LR(8)=6 S ^TMP($J,LR(7),LR(8),2)=LR(1)_A,^(3)=$E(LRB,1,9),^(4)=LR(9)
 Q
X S F=$P(X,"^",2)+$P(X,"^",3) S:LRSS'="AU"&('$D(LRZ)) $P(^LR(LRDFN,LRSS,LRI,.1,B,J,C,1,E,0),"^",6)=F I LRSS="AU"&('$D(LRZ)) S $P(^LR(LRDFN,33,B,J,C,1,E,0),"^",6)=F
 S:'LRR F=F-$P(X,"^",6) S:F<0 F=0 Q
AU F B=0:0 S B=$O(^LR(LRDFN,33,B)) Q:'B  F J=0:0 S J=$O(^LR(LRDFN,33,B,J)) Q:'J  F C=0:0 S C=$O(^LR(LRDFN,33,B,J,C)) Q:'C  S LRB=$P(^(C,0),"^") D AUT
 Q
AUT F E=0:0 S E=$O(^LR(LRDFN,33,B,J,C,1,E)) Q:'E  S X=^(E,0),F=$S('LRR:$P(X,"^",7),1:$P(X,"^",6)) D:'F X I F S:$D(LRZ) LRZ(1)=1 Q:$D(LRZ)  S $P(^(0),"^",7)=0,LR(9)=$S($D(^LAB(60,E,.1)):$P(^(.1),"^"),1:"") D P
 Q
CK I LRR S:'F F=1 Q
 S:$P(X,"^",7)="" F=1 Q
HELP W $C(7),!!,"Enter numbers only",! Q
END D V^LRU Q
SET K ^TMP($J) S (LR("FORM"),LR("LINE"))=1,LR(12)=$S(DUZ("AG")="V":"VAMC "_+$$SITE^VASITE,1:$E($$INS^LRU,1,9)),LR(6)=0,LR(1)=($E(LRY,1,3)+1700)_"-",LRXREF="A"_LRSS_"A" Q

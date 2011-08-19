LRAPAP ;AVAMC/REG - ANATOMIC SORT BY PARENT FILE ; 10/25/88  20:15 ;
 ;;5.2;LAB SERVICE;;Sep 27, 1994
 W !!?15,LRAA(1)," Entries Alphabetically by Patient",!!
A R !!,"Start with letter: ",X:DTIME G:X=""!(X[U) END D CK G:'$D(X) A S A(1)=X
B R !!,"End   with letter: ",X:DTIME G:X=""!(X[U) END D CK G:'$D(X) B S A(2)=X
 S ZTRTN="QUE^LRAPAP" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO S LRQ=0
 F Q=0:0 S Q=$O(^DIC("AC","LR",Q)) Q:'Q  S Q(1)=^DIC(Q,0),Q(2)=^(0,"GL") S LRNM=$C(A(1)) ; unfinished D ^LRAPAP1
 D END^LRUTL,END Q
CK S X=$A(X) I X<65!(X>90) W $C(7),!!,"Letter must be UPPER CASE (A to Z)" K X Q
 Q
 ;
END D V^LRU Q

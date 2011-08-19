LRFNDLOC ;SLC/CJS - RETURN A LOCATION FROM ^LRO(69,LRODT,1,"AR",LRLLOC,SN) ;2/8/91  08:42 ;
 ;;5.2;LAB SERVICE;;Sep 27, 1994
 S:'$D(DIC("A")) DIC("A")="Select PATIENT LOCATION: "
LOOP S LRLLOC="" W !,DIC("A") R X:DTIME S LRLLOC=X G LEND:X["^"!(X="")!(X'?.ANP),LALL:X["?" I $D(^LRO(69,LRODT,1,"AC",X)) S LRLLOC=X G LEND
 S:X?.N X=X_$C(31)
SOME S Y=$O(^LRO(69,LRODT,1,"AC",X)) G LALL:Y=""!($E(Y,1,$L(LRLLOC))'=LRLLOC)
 S %=$O(^LRO(69,LRODT,1,"AC",Y)) I $E(%,1,$L(LRLLOC))'=LRLLOC W $E(Y,$L(LRLLOC)+1,$L(Y)) S LRLLOC=Y G LEND
 K % S Y=X F %=1:1 S Y=$O(^LRO(69,LRODT,1,"AC",Y)) Q:Y=""!($E(Y,1,$L(LRLLOC))'=LRLLOC)  S %(%)=Y W !,?5,%,?9,Y I '(%#10) R !,"Press ""^"" to quit ",X:DTIME Q:X["^"
 S %=%-1 W !,"CHOOSE 1-",%,": " R X:DTIME G LALL:X["?" G LOOP:X["^"!(X="")
 I X\1'=+X!(X<1)!(X>%) W " ??",$C(7),! G LOOP
 S LRLLOC=%(X) G LEND
LALL S Y="" W !,"CHOOSE FROM:" F %=1:1 S Y=$O(^LRO(69,LRODT,1,"AC",Y)) Q:Y=""  W !,?5,Y I '(%#10) R !,"Press ""^"" to quit ",X:DTIME Q:X["^"
 G LOOP
LEND K %,X,Y Q

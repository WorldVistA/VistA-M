LRAPWEA ;AVAMC/REG - EM GRIDS SCANNED/PRINTS MADE ;1/12/92  18:04
 ;;5.2;LAB SERVICE;;Sep 27, 1994
 I '$D(LR(2)) S LRX=1
 E  R !,"Select *BLOCK ID#: ",LRX:DTIME Q:LRX[U!(LRX="")  I '$D(LR(LRX)) W $C(7),"  Select a number from 1 to ",LR G LRAPWEA
 S X=LR(LRX),A=$P(X,U),E=$P(X,U,2),B=$P(X,U,3),LRZ(8)=$P(X,U,7),LRZ(10)=$P(X,U,8),LRZ(1)=$P(X,U,10),LRZ(2)=$P(X,U,11) W !?3,$P(^LR(LRDFN,LRSS,LRI,.1,A,E,B,0),U) D:LRV GS D PM Q:'$D(LR(2))  G LRAPWEA
 ;
GS S %DT="AEQTRX",%DT("A")="DATE/TIME grids scanned: ",%DT(0)="-N",Y=$P(^LR(LRDFN,LRSS,LRI,.1,A,E,B,1,LRW,0),U,5),LRZ(4)=$P(^(0),U,4) D:Y DA^LRU S %DT("B")=Y D ^%DT K %DT Q:Y<1  I Y<LRZ(4) D CK G GS
 S $P(^LR(LRDFN,LRSS,LRI,.1,A,E,B,1,LRW,0),U,5)=Y,$P(LR(LRX),"^",5)=Y
NGS W !!,"TOTAL NUMBER of grids scanned:",LRZ(8),$S(LRZ(8):"//",1:"") R X:DTIME Q:X[U!('$T)  S:X="" X=LRZ(8) X $P(^DD(63.20211,.08,0),U,5,99) I '$D(X) W $C(7),!,$G(^(3)) X $G(^(4)) G NGS
 I X>$P(LR(LRX),U,4) W $C(7),!,"Total number of grids scanned cannot exceed number of grids prepared" G NGS
 I LRZ(1),X<LRZ(1) W $C(7),!,"Total number of grids scanned cannot be less than previous count (",LRZ(1),")" G NGS
 S $P(^LR(LRDFN,LRSS,LRI,.1,A,E,B,1,LRW,0),U,8)=X,$P(LR(LRX),U,7)=X Q
 ;
PM W ! S %DT="AEQTRX",%DT("A")="DATE/TIME prints made: ",%DT(0)="-N",Y=$P(^LR(LRDFN,LRSS,LRI,.1,A,E,B,1,LRW,0),U,11),LRZ(4)=$P(^(0),U,4) D:Y DA^LRU S %DT("B")=Y D ^%DT K %DT Q:Y<1  I Y<LRZ(4) D CK1 G PM
 S $P(^LR(LRDFN,LRSS,LRI,.1,A,E,B,1,LRW,0),U,11)=Y,$P(LR(LRX),"^",9)=Y
NPM I '$P(LR(LRX),U,4) W $C(7),!,"No prints can be made if no grids prepared." Q
 W !!,"TOTAL NUMBER of prints made:",LRZ(10),$S(LRZ(10):"//",1:"") R X:DTIME Q:X[U!('$T)  S:X="" X=LRZ(10) X $P(^DD(63.20211,.1,0),U,5,99) I '$D(X) W $C(7),!,$G(^(3)) X $G(^(4)) G NPM
 I LRZ(2),X<LRZ(2) W $C(7),!,"Total number of prints made cannot be less than previous count (",LRZ(2),")" S LRZ(10)=LRZ(2) G NPM
 S $P(^LR(LRDFN,LRSS,LRI,.1,A,E,B,1,LRW,0),U,10)=X,$P(LR(LRX),U,8)=X Q
 ;
CK W $C(7),!?3,"Date/time grids scanned  (" D DD^%DT W Y,") cannot be before",!?3,"Date/time grids prepared" S Y=LRZ(4) D:Y DD^%DT W:Y]"" " (",Y,")" Q
 ;
CK1 W $C(7),!?3,"Date/time prints   made  (" D DD^%DT W Y,") cannot be before",!?3,"Date/time grids prepared" S Y=LRZ(4) D:Y DD^%DT W:Y]"" " (",Y,")" Q

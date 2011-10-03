LRAPSA ;AVAMC/REG - TISSUE STAIN LIST ;8/12/95  13:19 ;
 ;;5.2;LAB SERVICE;**72**;Sep 27, 1994
 D ^LRAP G:'$D(Y) END
 W !!?20,LRO(68)," STAIN LIST" S X="T",%DT="" D ^%DT S X=$E(Y,2,3),%DT="" D ^%DT S X=Y D D^LRU S LRD=Y,Y=X
 W !!,"Stain list date: ",LRD,"  OK " S %=1 D YN^LRU G:%<1 END
A I %=2 W ! S %DT("A")="Select DATE: ",%DT="AQE" D ^%DT K %DT G:Y<1 END S X=Y D D^LRU S LRD=Y,Y=X
 S LRY=$E(Y,1,3)
N1 R !,"Start with Acc #: ",N(1):DTIME G:N(1)=""!(N(1)[U) END I N(1)'?1N.N W $C(7),!!,"NUMBERS ONLY !!" G N1
N2 R !,"Go    to   Acc #: LAST // ",N(2):DTIME G:N(2)='$T!(N(2)[U) END S:N(2)="" N(2)=999999 I N(2)'?1N.N W $C(7),!!,"NUMBERS ONLY !!",!! G N2
 S ZTRTN="QUE^LRAPSA" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO D S^LRAPST,L^LRU,S^LRU,XR^LRU,H S LR("F")=1,N(1)=N(1)-1
 F LRA(8)=N(1):0 S LRA(8)=$O(^LR(LRXREF,LRY,LRABV,LRA(8))) Q:'LRA(8)!(LRA(8)>N(2))!(LR("Q"))  S LRDFN=$O(^(LRA(8),0)),LRI=$O(^(LRDFN,0)) D W
 D END^LRUTL,END Q
W S X=^LR(LRDFN,0),LRA(9)=$S(LRSS'="AU":^(LRSS,LRI,0),1:^("AU")),LRTK=+LRA(9),Y=$P(X,"^",3),(LRDPF,X)=$P(X,"^",2),X=^DIC(X,0,"GL"),X=@(X_Y_",0)"),LRP=$P(X,"^"),SSN=$P(X,"^",9) D SSN^LRU
 K LRAN S LRAN=$P(LRA(9),U,6),Y=+LRA(9) D D^LRU S LRA(6)=Y
 D:$Y>(IOSL-4) H Q:LR("Q")  W !!,LRAN,?16,LRA(6),"  ",LRP," ",SSN S LRW=$S(LRA(6)'[1700:LRA(6),1:"") I LRSS="AU" D AU Q
 F A=0:0 S A=$O(^LR(LRDFN,LRSS,LRI,.1,A)) Q:'A!(LR("Q"))  S LRA=^(A,0) D:$Y>(IOSL-4) H1 Q:LR("Q")  W !,$P(LRA,"^") D S
 Q
S F E=0:0 S E=$O(^LR(LRDFN,LRSS,LRI,.1,A,E)) Q:'E  S B=0 F F=1:1 S B=$O(^LR(LRDFN,LRSS,LRI,.1,A,E,B)) Q:'B!(LR("Q"))  S LRA(1)=$P(^(B,0),U) D:$Y>(IOSL-4) H2 Q:LR("Q")  D B,T
 Q
T F C=0:0 S C=$O(^LR(LRDFN,LRSS,LRI,.1,A,E,B,1,C)) Q:'C!(LR("Q"))  S LRX=^(C,0) D:$Y>(IOSL-4) H3 Q:LR("Q")  D C
 Q
AU F A=0:0 S A=$O(^LR(LRDFN,33,A)) Q:'A!(LR("Q"))  S LRA=$P(^(A,0),U) D:$Y>(IOSL-4) H1 Q:LR("Q")  W !,LRA D AUS
 Q
AUS F E=0:0 S E=$O(^LR(LRDFN,33,A,E)) Q:'E  S B=0 F F=1:1 S B=$O(^LR(LRDFN,33,A,E,B)) Q:'B!(LR("Q"))  S LRA(1)=$P(^(B,0),U) D:$Y>(IOSL-4) H2 Q:LR("Q")  D B,AUT
 Q
AUT F C=0:0 S C=$O(^LR(LRDFN,33,A,E,B,1,C)) Q:'C!(LR("Q"))  S LRX=^(C,0) D:$Y>(IOSL-4) H3 Q:LR("Q")  D C
 Q
B W !,LRSS(LRSS,E),!?3,LRA(1),?16,"Stain/Procedure" Q
C S X=$P(LRX,U,2),Z=$P(LRX,U,3) W !?16,$P(^LAB(60,C,0),U),?47 W:X $J(X,5) W:Z ?52,"/",Z S Y=$P(LRX,U,4) D:Y DT^LRU W ?59,Y Q
H I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,LRO(68)," (",LRABV,")",$S(LRSS="SP":" BLOCKS",LRSS="CY":" PROCEDURES",1:""),"/STAINS",!,LR("%") Q
H1 D H Q:LR("Q")  W !!,LRAN,?16,LRA(6),"  ",LRP," ",SSN Q
H2 D H1 Q:LR("Q")  W !,LRA Q
H3 D H2 Q:LR("Q")  W !!?3,LRA(1),?16,"Stain/Procedure" Q
END D V^LRU Q

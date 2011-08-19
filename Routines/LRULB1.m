LRULB1 ;AVAMC/REG - LAB LOG-BOOK CONT. ;3/3/94  14:28 ;
 ;;5.2;LAB SERVICE;;Sep 27, 1994
 S LRAN=N(1)-1 D H S LR("F")=1 F B=0:0 S LRAN=$O(^LRO(68,LRAA,1,LRAD,1,LRAN)) Q:'LRAN!(LRAN>N(2))!(LR("Q"))  D PRT
 W:IOST'?1"C".E @IOF D END^LRUTL,V^LRU Q
T S X=X_"0000",Y=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3) I $P(X,".",2) S Y=Y_" "_$E($P(X,".",2),1,2)_":"_$E($P(X,".",2),3,4)
 Q
PRT Q:'$D(^LRO(68,LRAA,1,LRAD,1,LRAN,0))  I +^(0) S X=^(0),LRDFN=+X,LRLLOC=$E($P(X,"^",7),1,18),N(3)=^(3),LRC(5)=$P(N(3),"^",6)
 Q:'$D(^LR(LRDFN,0))  S LRI=$P(N(3),"^",5),X=^(0) D ^LRUP
 S X=$S($D(^LRO(68,LRAA,1,LRAD,1,LRAN,5,1,0)):^(0),1:""),O(1)=$S(+X:+X,1:""),C(1)=$P(X,"^",2) S X=$P(N(3),"^") D T S H(1)=Y,X=$P(N(3),"^",3) D T S H(2)=Y
 S O(1)=$S(O(1):$E($P(^LAB(61,O(1),0),"^"),1,14),1:C(1))
 D:$Y>(IOSL-8) H Q:LR("Q")  W !,$J(LRAN,5) W:P("F")'=2 ?7,"#" W ?7,$E(LRP,1,15),?24,$E(O(1),1,14),?48,H(2),?65,H(1)
 I LRSS="SP" D ORG Q
W S A=0 I $D(^LRO(68,LRAA,1,LRAD,1,LRAN,4,0))#2 S Z=0 F A=0:1 S Z=$O(^LRO(68,LRAA,1,LRAD,1,LRAN,4,Z)) Q:'Z!(LR("Q"))  S X=+^(Z,0) D LIST
 W:A<1 !?8,SSN,?27,LRLLOC W:$L(LRC(5)) !,LRC(5) W !!,LR("%") Q
LIST S X=$S($D(^LAB(60,X,0)):$P(^(0),"^"),1:"??") W:A=0 !?7,SSN,?27,LRLLOC W:A>0 ! W ?50,$E(X,1,30)
 Q
ORG S O=0 F Q=0:1 S O=$O(^LR(LRDFN,LRSS,LRI,2,O)) Q:'O!(LR("Q"))  S O(1)=+^(O,0) D LST
 Q
LST W:Q>0 ! W ?46,$S($D(^LAB(61,O(1),0)):$E($P(^LAB(61,O(1),0),"^"),1,14),1:"") Q
H I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,"LABORATORY SERVICE",?22,LRAA(1)," Log-Book for ",LRH(0)
 W !,"#= Not PATIENT file",?48,"|-------Date/time----|",!,"Acc no",?14,"Name",?24,"Spec/Sample",?39,"Results",?48,"Received",?65,"Taken",!?14,"SSN",?24,"Location",?58,"Tests"
 W !,LR("%") Q

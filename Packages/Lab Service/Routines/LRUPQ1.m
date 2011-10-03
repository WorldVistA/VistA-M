LRUPQ1 ;AVAMC/REG - LAB RESULTS BY ACCESSION AREA (COND'T) ;3/8/94  09:03 ;
 ;;5.2;LAB SERVICE;;Sep 27, 1994
 S X=$S($D(^LRO(68,LR,1,LRAD,1,N,5,1,0)):^(0),1:""),C(3)=+X S:'C(3) C(3)=LRU S C(2)=$P(X,"^",2) S:'C(2) C(2)=LRU(1)
 Q:'$D(^LRO(68,LR,1,LRAD,1,N,0))  S X=^(0),LRDFN=+X,A(3)=$P(X,"^",3),A(7)=$P(X,"^",7) Q:'$D(^(3))  S X=^(3),LRI=$P(X,"^",5),(Y,A(3))=$S($P(X,"^",3):$P(X,"^",3),1:A(3)) D:Y T S M=Y
 I '$D(^LR(LRDFN,0)) W !,$J(N,7),?11,"Entry not in lab results file" Q
 S Y=$P(^LR(LRDFN,LR(3),LRI,0),"^",3) D:Y T S M(1)=Y
 D:$Y>(IOSL-6) H^LRUPQ Q:LR("Q")  W !,$J(N,5) S X=^LR(LRDFN,0),Y=$P(X,"^",3),(LRDPF,X)=$P(X,"^",2),P(0)=$P(^DIC(X,0),"^"),X=^DIC(X,0,"GL")
 S X=@(X_Y_",0)"),SSN=$P(X,"^",9),LRP=$P(X,"^") D SSN^LRU
 W ?7 W:P(0)'="PATIENT" "#" W $E(LRP,1,20),?28,SSN(1),?34,$E(A(7),1,5)
 I '$D(^LR(LRDFN,LR(3),LRI,0)) W ?40,"Not in lab results file" Q
 W ?41,$S(C(2)>0&(P(0)="STERILIZER"!(P(0)="ENVIRONMENTAL")):$E($P(^LAB(62,C(2),0),"^"),1,14),$D(^LAB(61,C(3),0)):$E($P(^(0),"^"),1,13),1:""),?56,M,?68,M(1)
W S Z=0 F A=0:1 S Z=$O(^LRO(68,LR,1,LRAD,1,N,4,Z)) Q:'Z!(LR("Q"))  W:'A !?7,"Test(s): " S Z(3)=^(Z,0) D:+Z(3) L
 F Z=2,3,8,7,6,5,19,18,17,15,4,11,12,10,9,14,13,16 I $D(^LR(LRDFN,"CH",LRI,Z)) S LR(5)=^(Z) D:$Y>(IOSL-6) H Q:LR("Q")  W !,$E($P(^DD(63.04,Z,0),"^"),1,20),?21,$J($P(LR(5),"^"),7)
 S Z=19 F A=0:1 S Z=$O(^LR(LRDFN,"CH",LRI,Z)) Q:'Z!(LR("Q"))  S LR(5)=^(Z) D:$Y>(IOSL-6) H Q:LR("Q")  W !,$E($P(^DD(63.04,Z,0),"^"),1,20),?21,$J($P(LR(5),"^"),7)
 Q
L W:$X>(IOM-7) ! W " ",$P(^LAB(60,Z,.1),"^") Q
 ;
H D H^LRUPQ Q:LR("Q")  W !,LR(4),!,LRP," ",SSN," (continued from pg ",LRQ-1,")" Q
T S Y=Y_"000",Y=$E(Y,4,5)_"/"_$E(Y,6,7)_" "_$S(Y[".":$E(Y,9,10)_":"_$E(Y,11,12),1:"") Q

LRUPA1 ;AVAMC/REG - LAB ACCESSION LIST COND'T ;3/3/94  10:07 ;
 ;;5.2;LAB SERVICE;;Sep 27, 1994
 S X=$S($D(^LRO(68,LRAA,1,LRAD,1,N,5,1,0)):^(0),1:""),C(3)=+X S:'C(3) C(3)=LRU S C(2)=$P(X,"^",2) S:'C(2) C(2)=LRU(1) I $D(C(1)),C(1)'=C(2) Q
 Q:'$D(^LRO(68,LRAA,1,LRAD,1,N,0))  S X=^(0),LRDFN=+X,A(3)=$P(X,"^",3),A(7)=$P(X,"^",7) Q:'$D(^(3))  S X=^(3),LRI=$P(X,"^",5),A(3)=$S($P(X,"^",3):$P(X,"^",3),1:A(3))
 S N(6)=$S($D(^LRO(68,LRAA,1,LRAD,1,N,6)):^(6),1:"") I '$D(^LR(LRDFN,0)) D:$Y>(IOSL-8) H^LRUPA Q:LR("Q")  W !,$J(N,7),?11,"Entry not in lab results file" Q
 S:LRSS="CY" Q(2)=Q(2)+N(6),Q(1)=Q(1)+$P(N(6),"^",2) D V Q:LR("Q")  W:$L(LRC(5)) !,LRC(5),! Q
V D:$Y>(IOSL-8) H^LRUPA Q:LR("Q")  W ! I A(3)<LRAD W $E(A(3),4,5),"/",$E(A(3),6,7)
 W ?5,$J(N,5) S (X,Z)=^LR(LRDFN,0),Y=$P(X,"^",3),(LRDPF,X)=$P(X,"^",2),P(0)=$P(^DIC(X,0),"^"),X=^DIC(X,0,"GL")
 S X=@(X_Y_",0)"),SSN=$P(X,"^",9),LRP=$P(X,"^") D SSN^LRU
 W ?12 W:P(0)'="PATIENT" "#" W $E(LRP,1,15),?28,SSN(1),?34,$E(A(7),1,5) I LRSS="BB" D:$Y>(IOSL-8) H^LRUPA Q:LR("Q")  W !?7,SSN," ",$P(Z,"^",5)," ",$P(Z,"^",6)
 I LRSS="AU" Q:'$D(^LR(LRDFN,"AU"))  S X=^("AU") W ?40,$S('$P(X,"^",3):"%",1:"") S Y=+X D:Y D^LRU W ?42,Y Q
 I '$D(^LR(LRDFN,LRSS,LRI,0)) W ?40,"Not in lab results file" Q
 I "CYEMSP"[LRSS S X=^LR(LRDFN,LRSS,LRI,0),C(6)=$S($P(X,"^",12):"*",1:"") W:'$P(X,"^",3) ?40,"%" I "CYEMSP"[LRSS D O Q:LR("Q")  Q:"EMSP"[LRSS
 I LRSS="CY" W ?72,$J(+N(6),5) W:$P(N(6),"^",2) "b" W ?79,C(6) Q
 I LRSS="BB" S Y=+^LR(LRDFN,LRSS,LRI,0) D DT^LRU W ?40,Y S LRA=Y
 E  W ?41,$S(C(2)>0&(P(0)="STERILIZER"!(P(0)="ENVIRONMENTAL")):$E($P(^LAB(62,C(2),0),"^"),1,14),$D(^LAB(61,C(3),0)):$E($P(^(0),"^"),1,13),1:"")
W S Z(2)=$S($P(^LR(LRDFN,LRSS,LRI,0),"^",3):"","CHBBMI"[LRSS:"",1:"%"),Z=0 F A=0:1 S Z=$O(^LRO(68,LRAA,1,LRAD,1,N,4,Z)) Q:'Z!(LR("Q"))  S Z(3)=^(Z,0) D:+Z(3) L
 Q
L Q:LR("Q")!($P($G(^LAB(60,Z,0)),"^",4)="WK")
 D:$Y>(IOSL-8) H Q:LR("Q")  W:A>0 ! I LRSS="CH",$P(Z(3),"^",2)=1 W ?54,"*"
 W:A=0 ?55,Z(2) W ?55 W $S(LRSS="BB"&($P(Z(3),"^",4)=""):"%",1:"") W ?56,$E($P(^LAB(60,Z,0),"^"),1,19),?76 S X=$P(Z(3),"^",4) W $S('X:X,1:$P($G(^VA(200,X,0)),"^",2)) Q
 ;
O S C(4)=0 F B=0:1 S C(4)=$O(^LR(LRDFN,LRSS,LRI,2,C(4))) Q:'C(4)!(LR("Q"))  S C(3)=+^(C(4),0) D:$Y>(IOSL-8) H^LRUPA Q:LR("Q")  W:B>0 ! W ?46,$S($D(^LAB(61,C(3),0)):$E($P(^(0),"^"),1,23),1:"")
 Q:LR("Q")  W:B=0 ?46,"No SNOMED code" Q
 ;
H D H^LRUPA Q:LR("Q")  W ! I A(3)<LRAD W $E(A(3),4,5),"/",$E(A(3),6,7)
 W ?5,$J(N,5),?12 W:P(0)'="PATIENT" "#" W $E(LRP,1,20),?28,SSN(1),?34,$E(A(7),1,5) W:LRSS="BB" ?40,LRA Q

LRUPAD1 ;AVAMC/REG/WTY - LAB ACCESSION LIST COND'T ;9/25/00
 ;;5.2;LAB SERVICE;**248**;Sep 27, 1994
 ;
 ;Reference to ^DIC( supported by IA #916
 ;Reference to ^VA(200 supported by IA #10060
 ;Reference to DIC supported by IA #10006
 ;
 S X=$S($D(^LRO(68,LRAA,1,I,1,N,5,1,0)):^(0),1:""),C(3)=+X
 S:'C(3) C(3)=LRU(1) S C(2)=$P(X,"^",2) S:'C(2) C(2)=LRU(1)
 I $D(C(1)),C(1)'=C(2) Q
 Q:'$D(^LRO(68,LRAA,1,I,1,N,3))  S X=^(3),LRI=$P(X,"^",5)
 S A(3)=$P(X,"^",3),X=^LRO(68,LRAA,1,I,1,N,0),LRIFN=+X
 S A(7)=$P(X,"^",7),A(8)=$P(X,"^",8) S:'A(3) A(3)=$P(X,"^",3)
 S A(3)=$E(A(3),4,5)_"/"_$E(A(3),6,7)
 S N(6)=$S($D(^LRO(68,LRAA,1,I,1,N,6)):^(6),1:"")
 Q:'$D(^LR(LRIFN,0))  S X=^(0),DA=$P(X,"^",3),(LRDPF,X)=$P(X,"^",2)
 S DIC="^DIC(",DIC(0)="Z" D ^DIC Q:Y=-1
 S P(0)=Y(0,0) K DIC,Y
 S DIC=^DIC(X,0,"GL"),DIC(0)="NZ",X=DA D ^DIC Q:Y=-1
 S SSN=$P(Y(0),"^",9),LRP=$P(Y(0),"^") K DIC,DA,Y
 D SSN^LRU
 S:LRSS="CY" Q(2)=Q(2)+N(6),Q(1)=Q(1)+$P(N(6),"^",2) D V
 W:$L(LRC(5)) !?4,LRC(5)
 Q
V D:$Y>(IOSL-8) H Q:LR("Q")  W !,$J(N,5)
 I LRSS'="AU",'$D(^LR(LRIFN,LRSS,LRI,0)) D  Q
 .W ?8,$J(A(3),5),?14 W:P(0)'="PATIENT" "#"
 .W $E(LRP,1,20),?34,SSN(1)
 .W " Data NOT in lab results file #63 !!!"
 W ?8,$J(A(3),5),?14 W:P(0)'="PATIENT" "#"
 W $E(LRP,1,20),?34,SSN(1),?40,$E(A(7),1,5)
 I LRSS="AU" Q:'$D(^LR(LRIFN,"AU"))  S X=^("AU") D  Q
 .W ?45,$S('$P(X,"^",3):"%",1:"")
 .S Y=+X D:Y D^LRU W ?47,Y
 I $L(A(8)),"CYEMSP"[LRSS D
 .W ?46,$E($S($D(^VA(200,A(8),0)):$P(^(0),"^"),1:A(8)),1,10)
 I "CYEMSP"[LRSS D  Q:"EMSP"[LRSS
 .S X=^LR(LRIFN,LRSS,LRI,0),C(6)=$S($P(X,"^",12):"*",1:"")
 .W:'$P(X,"^",3) ?57,"%"
 .S:$D(^LR(LRIFN,LRSS,LRI,99,1,0)) LRC(5)=^(0)
 .D O
 I LRSS="CY" W ?72,$J(+N(6),5) W:$P(N(6),"^",2) "b" W ?79,C(6) Q
 W ?46,$S(C(2)>0&(P(0)="STERILIZER"!(P(0)="ENVIRONMENTAL")):$E($P(^LAB(62,C(2),0),"^"),1,14),$D(^LAB(61,C(3),0)):$E($P(^LAB(61,C(3),0),"^"),1,13),1:"")
W S Z(2)=$S($P(^LR(LRIFN,LRSS,LRI,0),"^",3):"",LRSS="MI":"",1:"%"),Z=0
 F A=0:1 S Z=$O(^LRO(68,LRAA,1,I,1,N,4,Z)) Q:'Z!(LR("Q"))  D  Q:LR("Q")
 .S Z(3)=$S($D(^LRO(68,LRAA,1,I,1,N,4,Z,0)):^(0),1:"")
 .D:+Z(3) L
 Q
L W:A>0 !
 W ?61,Z(2),?62,$E($P(^LAB(60,+Z(3),0),"^"),1,13)
 S TECH=$P(Z(3),"^",4)
 S:TECH?1N.N TECH=$P($G(^VA(200,TECH,0)),"^",2)
 W ?76,$E(TECH,1,4)
 K TECH
 D:$Y>(IOSL-8) H Q:LR("Q")
 Q
O S C(4)=0
 F E=0:1 S C(4)=$O(^LR(LRIFN,LRSS,LRI,2,C(4))) Q:'C(4)!(LR("Q"))  D
 .S C(3)=+^LR(LRIFN,LRSS,LRI,2,C(4),0)
 .D T
 Q:LR("Q")  W:E=0 ?58,"No SNOMED code" Q
T D:$Y>(IOSL-8) H Q:LR("Q")  W:E>0 !
 W ?58,$S($D(^LAB(61,C(3),0)):$E($P(^LAB(61,C(3),0),"^"),1,14),1:"")
 Q
H D H^LRUPAD W !
 Q

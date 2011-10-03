LRUPAD2 ;AVAMC/REG/WTY - LAB ACCESSION LIST BY PATIENT ;9/25/00
 ;;5.2;LAB SERVICE;**72,248**;Sep 27, 1994
 ;
 ;Reference to ^DIC( supported by IA #916
 ;Reference to ^VA(200 supported by IA #10060
 ;
 S ZTRTN="QUE^LRUPAD2" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO K ^TMP($J) D L^LRU,S^LRU D:IOST?1"C".E WAIT^LRU
 S V(1)=V(1)-1,LRI=""
 F I=V(1):0 S I=$O(^LRO(68,LRAA,1,I)) Q:'I!(I>V)  S LRSA=LRSDT-.01 F B=LRSA:0 S B=$O(^LRO(68,LRAA,1,I,1,"E",B)) Q:'B!(B>LRLDT)  F N=0:0 S N=$O(^LRO(68,LRAA,1,I,1,"E",B,N)) Q:'N  D P
 D H S LR("F")=1,V=0 F B=1:1 S V=$O(^TMP($J,V)) Q:V=""!(LR("Q"))  D XT
 W:IOST'?1"C".E&($E(IOST,1,2)'="P-"!($D(LR("FORM")))) @IOF
 D END,END^LRUTL Q
NEW D H Q:LR("Q")
 W !,$J(B,3),")",?6,$P(M,"-",3),?11,$E(V,1,19),?31,$J(N,5)
 S LRX=^TMP($J,V,M,O,N)
 W ?37,$E($P(LRX,"^"),1,5),?44,$P(LRX,"^",5),?52,$E($P(LRX,"^",2),1,5)
 Q
W S Z(2)=$S('$D(^LR(LRDFN,LRSS,LRI,0)):"",$P(^(0),"^",3):"",LRSS="MI":"",1:"%"),Z=0
 F A=0:1 S Z=$O(^LRO(68,LRAA,1,O,1,N,4,Z)) Q:'Z!(LR("Q"))  D
 .S Z(1)=^LRO(68,LRAA,1,O,1,N,4,Z,0) D:+Z(1) T
 Q
O Q:LR("Q")  Q:LRSS="AU"
 I '$D(^LR(LRDFN,LRSS,LRI,0)) W ?40,"Entry not in lab data file." Q
 S Z(2)=$S($P(^LR(LRDFN,LRSS,LRI,0),"^",3):"",1:"%")
 S C(4)=0
 F F=0:1 S C(4)=$O(^LR(LRDFN,LRSS,LRI,2,C(4))) Q:'C(4)!(LR("Q"))  D
 .S C(3)=+^LR(LRDFN,LRSS,LRI,2,C(4),0) D L
 Q:LR("Q")  W:F=0 ?46,"No SNOMED code" Q
L D:$Y>(IOSL-8) H2 Q:LR("Q")  W:F>0 !
 W ?44,Z(2)
 W ?45,$S($D(^LAB(61,C(3),0)):$E($P(^LAB(61,C(3),0),"^"),1,26),1:"")
 Q
T W:A>0 !
 W ?59,$E($P(^LAB(60,+Z(1),0),"^"),1,15)
 S TECH=$P(Z(1),"^",4)
 S:TECH?1N.N TECH=$P($G(^VA(200,TECH,0)),"^",2)
 W ?76,$E(TECH,1,4)
 K TECH
 D:$Y>(IOSL-8) NEW Q:LR("Q")
 Q
XT S M=0 F Y=0:0 S M=$O(^TMP($J,V,M)) Q:M=""!(LR("Q"))  D A
 Q
A F O=0:0 S O=$O(^TMP($J,V,M,O)) Q:'O!(LR("Q"))  D B
 Q
B D:$Y>(IOSL-8) H Q:LR("Q")
 W !,$J(B,3),")",?6,$P(M,"-",3),?11,$E(V,1,19) S N=0
 F E=0:1 S N=$O(^TMP($J,V,M,O,N)) Q:'N!(LR("Q"))  D  Q:LR("Q")
 .S LRX=^TMP($J,V,M,O,N),LRDFN=$P(LRX,"^",3),LRI=$P(LRX,"^",4)
 .D:$Y>(IOSL-8) H2 Q:LR("Q")  D C
 Q
C W:E>0 ! W ?31,$J(N,5),?37,$J($P(LRX,"^"),5),?44,$P(LRX,"^",5)
 W ?52,$E($P(LRX,"^",2),1,5) D W:"MICHBL"[LRSS,O:"AUCYEMSP"[LRSS
 Q
P S (B(5),C(1))=""
 S:$D(^LRO(68,LRAA,1,I,1,N,5,1,0)) X=^(0),B(5)=+X,C(1)=$P(X,"^",2)
 S:B(5) B(5)=$P(^LAB(61,B(5),0),"^")
 Q:'$D(^LRO(68,LRAA,1,I,1,N,3))  S X=^(3)
 S A(3)=$P(X,"^",3),LRI=$P(X,"^",5)
 S X=^LRO(68,LRAA,1,I,1,N,0),LRDFN=+X
 S A(3)=$S(A(3):A(3),1:$P(X,"^",3))
 S A(3)=$E(A(3),4,5)_"/"_$E(A(3),6,7)
 S LRF=$P(^LRO(68,LRAA,1,I,1,N,0),"^",7)
 Q:'$D(^LR(LRDFN,0))  S X=^(0),DA=$P(X,"^",3),(LRDPF,X)=$P(X,"^",2)
 S DIC="^DIC(",DIC(0)="Z" D ^DIC Q:Y=-1
 S P(0)=Y(0,0) K DIC,Y
 S DIC=^DIC(X,0,"GL"),DIC(0)="NZ",X=DA D ^DIC Q:Y=-1
 S SSN=$P(Y(0),"^",9),LRP=$P(Y(0),"^") K DIC,DA,Y
 D SSN^LRU
 S:P(0)'="PATIENT" LRP="#"_LRP
 I LRSS="AU",$D(^LR(LRDFN,"AU")) S B(5)=$S('$P(^("AU"),"^",3):"%",1:"")
 Q:'$L(SSN)
 S ^TMP($J,$E(LRP,1,20),SSN,I,N)=A(3)_"^"_B(5)_"^"_LRDFN_"^"_LRI_"^"_$E(LRF,1,7)
 S (B(5),LRDFN,LRI)=""
 Q
H I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU
 W !,LRO(68)," ACCESSIONS(",LRSTR,"-",LRLST,")"
 W !,"# = Not VA patient",?36,$S("AUBBCYEMSP"[LRSS:"% =Incomplete",1:"")
 W !,"Count",?7,"ID",?11,"Patient",?32,"ACC#"
 I "AUCYEMSP"'[LRSS D
 .W ?37,"Date",?44,"Loc",?52,"Specimen",?64,"Test",?76,"Tech"
 .W !,LR("%")
 Q
H1 D H W ! Q
H2 D H Q:LR("Q")  W !,$J(B,3),")",?6,$P(M,"-",3),?11,$E(V,1,19) Q
 ;
END D V^LRU Q

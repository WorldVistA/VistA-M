LRUPA2 ;AVAMC/REG/WTY - LAB ACCESSION LIST BY PAT ;9/25/00
 ;;5.2;LAB SERVICE;**72,248**;Sep 27, 1994
 ;
 ;Reference to ^DIC( supported by IA #916
 ;Reference to ^VA(200 supported by IA #10060
 ;Reference to DIC supported by IA #10006
 ;
 S ZTRTN="QUE^LRUPA2" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO K ^TMP($J) S (B(5),C(1))="",N=N(1)-1
 F B=0:0 S N=$O(^LRO(68,LRAA,1,LRAD,1,N)) Q:'N!(N>N(2))  S (B(5),C(1))="" S:$D(^LRO(68,LRAA,1,LRAD,1,N,5,1,0)) X=^(0),B(5)=+X,C(1)=$P(X,"^",2) D PRT
 D L^LRU,S^LRU,H S LR("F")=1,V=0 F B=1:1 S V=$O(^TMP($J,V)) Q:V=""!(LR("Q"))  D XT
 W:IOST'?1"C".E&($E(IOST,1,2)'="P-"!($D(LR("FORM")))) @IOF
 K ^TMP($J) D END^LRUTL,END
 Q
W S X=$S($D(^LR(LRDFN,LRSS,LRI,0)):^(0),1:"") I X="" W ?50,"Not in lab results file" Q
 S Z(2)=$S($P(X,"^",3):"","CHBBMI"[LRSS:"",1:"%"),Z=0 F A=0:1 S Z=$O(^LRO(68,LRAA,1,LRAD,1,N,4,Z)) Q:'Z!(LR("Q"))  S Z(3)=^(Z,0) D:+Z(3) L
 Q
O S C(4)=0 I '$D(^LR(LRDFN,LRSS,LRI,0)) W ?40,"Entry not in lab result file #63." Q
 F E=0:1 S C(4)=$O(^LR(LRDFN,LRSS,LRI,2,C(4))) Q:'C(4)!(LR("Q"))  S C(3)=+^(C(4),0) D:$Y>(IOSL-8) H2 Q:LR("Q")  W:E>0 ! W ?43,$S($D(^LAB(61,C(3),0)):$E($P(^(0),"^"),1,35),1:"")
 Q:LR("Q")  W:E=0 ?43,"No SNOMED code" Q
L Q:LR("Q")!($P($G(^LAB(60,Z,0)),"^",4)="WK")
 W:A=0 ?55,Z(2) W:A>0 !?55 W $S(LRSS="BB"&($P(Z(3),"^",4)=""):"%",1:"") W ?56,$E($P(^LAB(60,Z,0),"^"),1,19),?76 S X=$P(Z(3),"^",4) W $S('X:X,1:$P($G(^VA(200,X,0)),"^",2)) Q
 ;
XT S M=0 F Y=0:0 S M=$O(^TMP($J,V,M)) Q:M=""!(LR("Q"))  D A
 Q
A D:$Y>(IOSL-8) H Q:LR("Q")  W !,$J(B,3),")",?6,$P(M,"-",3),?12,V I LRSS="BB" W !?12,M," " S X=$O(^TMP($J,V,M,0)) S:X X=^(X),X=$P(X,"^",2),X=^LR(X,0) W " ",$P(X,"^",5)," ",$P(X,"^",6)
 S N=0 F B(2)=0:1 S N=$O(^TMP($J,V,M,N)) Q:'N!(LR("Q"))  S B(3)=^(N),B(4)=$P(B(3),"^"),LRI=$P(B(3),"^",3),LRDFN=$P(B(3),"^",2) D C
 Q
C D:$Y>(IOSL-8) H1 Q:LR("Q")  W:B(2)>0 ! D:LRSS="BB" D W ?33,$J(N,4),?38,B(4) D:"AUEMSPCY"[LRSS B I "SPCYEMAU"'[LRSS D W
 Q
B S LRDFN=$P(B(3),"^",2),LRI=$P(B(3),"^",3)
 D:"SPCYEM"[LRSS O
 Q:LR("Q")  W:LRSS="AU" ?40,LRI Q
PRT Q:'$D(^LRO(68,LRAA,1,LRAD,1,N,3))  S X=^(3),A(3)=$P(X,"^",3)
 S LRI=$P(X,"^",5),X=^LRO(68,LRAA,1,LRAD,1,N,0),LRDFN=+X
 S A(3)=$S(A(3):A(3),1:$P(X,"^",3))
 S B(5)=$S(B(5)>0:$P(^LAB(61,B(5),0),"^"),C(1)>0:$P(^LAB(62,C(1),0),"^"),1:"")
 S B(5)=$S(B(5)]"":B(5),1:C(1))
 Q:'$D(^LR(LRDFN,0))  S X=^(0),DA=$P(X,"^",3),(LRDPF,X)=$P(X,"^",2)
 S DIC="^DIC(",DIC(0)="Z" D ^DIC Q:Y=-1
 S P(0)=Y(0,0) K DIC,Y
 S DIC=^DIC(X,0,"GL"),DIC(0)="NZ",X=DA D ^DIC Q:Y=-1
 S SSN=$P(Y(0),"^",9),LRP=$P(Y(0),"^") K DIC,DA,Y
 D SSN^LRU
 S:P(0)'="PATIENT" LRP="#"_LRP
 I LRSS="AU",$D(^LR(LRDFN,"AU")) D
 .S X=^("AU"),B(5)=$S($P(X,"^",3):"",1:"%") S Y=+X D D^LRU S LRI=Y
 I "CYSPEM"[LRSS S B(5)="" D
 .I $D(^LR(LRDFN,LRSS,LRI,0)),'$P(^(0),"^",3) S B(5)="%"
 S ^TMP($J,$E(LRP,1,20),SSN,N)=B(5)_"^"_LRDFN_"^"_LRI
 S (B(5),LRDFN,LRI)=""
 Q
D S Y=+^LR($P(B(3),"^",2),"BB",$P(B(3),"^",3),0) D DT^LRU S B(4)=Y Q
H I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,LRO(68)," ACCESSIONS for ",Z(1),"  BY PATIENT"
 W !,"# =Not VA patient",?36,$S("AUBBCYEMSP"[LRSS:"% =Incomplete",1:"")
 W !,"Count",?7,"ID",?12,"Patient",?35,"ACC#" W ?36 W:"AUBBCYEMSP"'[LRSS "Specimen" W:LRSS="BB" "Specimen date" W:"AUCYEMSP"'[LRSS ?50,"Test",?76,"Tech" W:"CYEMSP"[LRSS ?43,"Organ/tissue" W:LRSS="AU" ?40,"Date/time of Autopsy"
 W !,LR("%") Q
H1 D H Q:LR("Q")  S B(2)=0 W !,$J(B,3),")",?6,$P(M,"-",3),?12,V Q
H2 D H Q:LR("Q")  W !,$J(B,3),")",?6,$P(M,"-",3),?12,V,?33,$J(N,4) S E=0 Q
 ;
END D V^LRU Q

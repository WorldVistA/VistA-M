LRBLCMV ;AVAMC/REG - UNIT PHENOTYPE BY ABO/RH ;9/13/89  19:30 ;
 ;;5.2;LAB SERVICE;**247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 D END W !!?20,"CMV ANTIBODY tested units" S:'$D(DTIME) DTIME=60 S C(9)="POSNEG"
SEL W !!,"Select CMV ANTIBODY: NEG// " R X:DTIME G:X[U!'$T END S:X="" X="NEG"
 I X'?1"N".U&(X'?1"P".U)!($L(X)>3)!(C(9)'[X) W $C(7),!,"Enter 'POS' for CMV ANTIBODY POSITIVE units",!,"Enter 'NEG' for CMV ANTIBODY NEGATIVE units." G SEL
 S X(1)=$S($A(X)=80:"POS",1:"NEG") W $E(X(1),$L(X)+1,3)
 S LRV=$S(X="NEG":0,1:1)
 S DIC="^LAB(66,",DIC(0)="AEQM",DIC("A")="Select BLOOD COMPONENT: " D ^DIC K DIC G:X=""!(X[U) END S C=+Y,C(1)=$P(Y,U,2)
ABO R !,"Select ABO group: ",C(7):DTIME Q:C(7)["^"!(C(7)="")  I C(7)'="A"&(C(7)'="B")&(C(7)'="O")&(C(7)'="AB") W $C(7),!,"Enter A, B, AB or O" G ABO
RH R !,"Select Rh type: ",X:DTIME Q:X=""!(X["^")  I X'?1"N".U&(X'?1"P".U)!($L(X)>3)!(C(9)'[X) W $C(7),"  Enter 'NEG' or 'POS'" G RH
 S C(8)=$S($A(X)=80:"POS",1:"NEG") W $E(C(8),$L(X)+1,3)
 S ZTRTN="QUE^LRBLCMV" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO D L^LRU,S^LRU S X="N",%DT="T",Z=0 D ^%DT S N=Y,H=$P(Y,".") D D^LRU S Z(1)=Y D H S LR("F")=1
 S A=0 F B=0:1 S A=$O(^LRD(65,"AI",C,A)) Q:A=""!(LR("Q"))  S Q=$O(^LRD(65,"AI",C,A,0)) Q:'Q  D I
 W:'Z !!,"No CMV ANTIBODY ",$S(LRV=0:"NEG",1:"POS"),"  ",C(7)," ",C(8),"  ",C(1),"." D END,END^LRUTL Q
 ;
I I Q[".",Q<N K ^LRD(65,"AI",C,A,Q) Q
 I Q<H K ^LRD(65,"AI",C,A,Q) Q
 K F,J S V=+$O(^LRD(65,"AI",C,A,Q,0)) Q:'$D(^LRD(65,V,0))  S F=^(0) Q:$P(F,"^",15)'=LRV
 Q:$P(F,"^",7)'=C(7)!($P(F,"^",8)'=C(8))
 S Z=Z+1 D:$Y>(IOSL-6) H Q:LR("Q")  W !,$J(Z,3),")",?5,$P(F,"^"),?20 S Y=$P(F,"^",6) D DT^LRU W Y
 W !,LR("%") Q
 ;
H I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,"LABORATORY SERVICE",!,C(1),"  ",C(7)," ",C(8),"  CMV ",$S(LRV:"POS",1:"NEG")," units"
 W !?5,"Unit",?20,"Exp date",?40,!,LR("%") Q
END D V^LRU Q

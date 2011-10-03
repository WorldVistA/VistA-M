LRBLJPH ;AVAMC/REG - UNIT PHENOTYPE BY ABO/RH ;2/18/93  09:26 ;
 ;;5.2;LAB SERVICE;**247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 D END W !!,"Phenotyped units" S C(9)="POSNEG"
ABO R !,"Select ABO group: ",C(7):DTIME Q:C(7)["^"!(C(7)="")  I C(7)'="A"&(C(7)'="B")&(C(7)'="O")&(C(7)'="AB") W $C(7),!,"Enter A, B, AB or O" G ABO
RH R !,"Select Rh type: ",X:DTIME G:X=""!(X["^") END I X'?1"N".U&(X'?1"P".U)!($L(X)>3)!(C(9)'[X) W $C(7),"  Enter 'NEG' or 'POS'" G RH
 S C(8)=$S($A(X)=80:"POS",1:"NEG") W $E(C(8),$L(X)+1,3)
 S ZTRTN="QUE^LRBLJPH" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO D L^LRU,S^LRU S Z=0,X="N",%DT="T" D ^%DT S N=Y,H=$P(Y,".") D D^LRU S Z(1)=Y D H S LR("F")=1
 F X=0:0 S X=$O(^LAB(66,X)) Q:'X  S Y=^(X,0) I $P(Y,"^",19) S LRC(X)=""
 F C=0:0 S C=$O(LRC(C)) Q:'C!(LR("Q"))  D A
 W:'Z !!,"No phenotyped ",C(7)," ",C(8)," units available !" D END,END^LRUTL Q
 ;
A S (A,LRE)=0 F LRB=0:1 S A=$O(^LRD(65,"AI",C,A)) Q:A=""!(LR("Q"))  S Q=$O(^LRD(65,"AI",C,A,0)) Q:'Q  D I
 Q
I I Q[".",Q<N K ^LRD(65,"AI",C,A,Q) Q
 I Q<H K ^LRD(65,"AI",C,A,Q) Q
 K F,J S V=+$O(^LRD(65,"AI",C,A,Q,0)) Q:'$D(^LRD(65,V,0))  S F=^(0)
 Q:$P(F,"^",7)'=C(7)!($P(F,"^",8)'=C(8))
 I '$O(^LRD(65,V,60,0)),'$O(^LRD(65,V,70,0)) Q
 S LRE=LRE+1 W:LRE=1 !!,$P(^LAB(66,C,0),U),":" S Z=Z+1 D:$Y>(IOSL-6) H1 Q:LR("Q")  W !,$J(Z,3),")" W ?5,$P(F,"^"),?20 S Y=$P(F,"^",6) D D^LRU W Y
 F LRDFN=0:0 S LRDFN=$O(^LRD(65,V,2,LRDFN)) Q:'LRDFN!(LR("Q"))  I $D(^LRD(65,"AP",LRDFN,V)) D P W !,"Assigned:",$P(X,"^")
 S E=1,(F(1),G)="" F B=0:0 S B=$O(^LRD(65,V,60,B)) Q:'B  S I=$P(^LAB(61.3,B,0),"^"),F(E)=F(E)_I_" ",G=G+1 I $L(F(E))>19 S F(E)=$P(F(E)," ",1,G-1),E=E+1,F(E)=I_" ",G=""
 S K=E,E=1,(J(1),G)="" F B=0:0 S B=$O(^LRD(65,V,70,B)) Q:'B  S I=$P(^LAB(61.3,B,0),"^"),J(E)=J(E)_I_" ",G=G+1 I $L(J(E))>18 S J(E)=$P(J(E)," ",1,G-1),E=E+1,J(E)=I_" ",G=""
 S:E>K K=E F E=1:1:K W:E>1 ! W:$D(F(E)) ?40,$J(F(E),19) W:$D(J(E)) ?60,"|",$J(J(E),18)
 W !,LR("%") Q
 ;
P S X=^LR(LRDFN,0),Y=$P(X,"^",3),X=^DIC($P(X,"^",2),0,"GL"),X=@(X_Y_",0)") Q
H I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,"LABORATORY SERVICE",?40,C(7)," ",C(8),"  Phenotyped units"
 W !,"Count",?6,"Unit ID",?20,"Exp date",?40,"Antigen(s) present",?60,"| Antigen(s) absent",!,LR("%") Q
H1 D H Q:LR("Q")  W !!,$P(^LAB(66,C,0),U) Q
END D V^LRU Q

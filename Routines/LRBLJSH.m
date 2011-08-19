LRBLJSH ;AVAMC/REG - BB INVENTORY SHIPMENTS ;2/18/93  09:31 ;
 ;;5.2;LAB SERVICE;**247,408**;Sep 27, 1994;Build 8
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 Q  D END S:'$D(DTIME) DTIME=300 S LRI=$O(^LAB(65.9,"B","SHIPPING INVOICE",0)) I 'LRI W $C(7),!!,"SHIPPING INVOICE must be an entry in the LAB LETTER FILE (65.9)." G END
 S IOP="HOME" D ^%ZIS W @IOF,?18,"INVOICE FOR SHIPMENT OF BLOOD COMPONENTS"
 D B^LRU G:Y<0 END S LRLDT=LRLDT+.99,LRSDT=LRSDT-.01
I R !!,"Enter SHIPPING INVOICE#: ",X:DTIME G:X[U!(X="") END S LRB=X X $P(^DD(65,.13,0),U,5,99) S:'$D(X) X="?" I X["?" W $C(7),"  Enter invoice # (2-10 characters)" G I
A R !!,"Enter name to appear on invoice: ",X:DTIME G:X[U END D CK G:'$D(X) A S LR=X I X="" W $C(7),"  Must have a name. Enter '^' to quit" G A
B R !!,"Enter address line 1: ",X:DTIME G:X[U END D CK G:'$D(X) B S LR(1)=X
C R !,"Enter address line 2: ",X:DTIME G:X[U END D CK G:'$D(X) C S LR(2)=X
D R !,"Enter address line 3: ",X:DTIME G:X[U END D CK G:'$D(X) D S LR(3)=X
 S ZTRTN="QUE^LRBLJSH" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO K ^TMP($J) S Z=0 D L^LRU,S^LRU
 F B=0:0 S LRSDT=$O(^LRD(65,"AB",LRSDT)) Q:'LRSDT!(LRSDT>LRLDT)  F LRA=0:0 S LRA=$O(^LRD(65,"AB",LRSDT,LRA)) Q:'LRA  I $D(^LRD(65,LRA,0)),$P(^(0),"^",13)=LRB S W=^(0) D SET
 D WRT D:$Y>(IOSL-6) H Q:LR("Q")  W !,LR("%"),!,"Total unit count (all components): ",Z K ^TMP($J)
 D E,END,END^LRUTL Q
SET S ^TMP($J,$P(W,"^",4),$P(W,"^",7),$P(W,"^",8),$P(W,"^"))=$P(W,"^",6)_"^"_LRA Q
WRT D H1 Q:LR("Q")  S LR("F")=1 F C=0:0 S C=$O(^TMP($J,C)) Q:'C!(LR("Q"))  S V=0 D:$Y>(IOSL-6) H1 Q:LR("Q")  W !!,"Component: " S C(1)=^LAB(66,C,0),C(20)=$P(C(1),"^",20),C(1)=$P(C(1),"^") W C(1) W:C(20)]"" " (",C(20),")" D ABO
 Q
ABO S A=0 F B=0:1 S A=$O(^TMP($J,C,A)) Q:A=""!(LR("Q"))  S R=0 F E=0:0 S R=$O(^TMP($J,C,A,R)) Q:R=""!(LR("Q"))  S I=0 F F=0:0 S I=$O(^TMP($J,C,A,R,I)) Q:I=""!(LR("Q"))  S W=^(I) D W
 Q
W D:$Y>(IOSL-6) H2 Q:LR("Q")  S V=V+1,Z=Z+1,Y=+W D D^LRU W !,$J(V,5) W:$P($G(^LRD(65,+$P(W,"^",2),8)),"^",2) "  Pos/Incomplete Tests" W ?28,$J(A,2),?32,R,?38,I,?53,Y Q
 ;
H I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,"BLOOD BANK",?21,"SHIPPING INVOICE#: ",LRB,!?21,"To: ",LR F X=0:0 S X=$O(LR(X)) Q:'X  W:LR(X)]"" !?25,LR(X)
 Q
H1 D H Q:LR("Q")  W !?28,"ABO",?32,"Rh",?38,"UNIT ID",?53,"Expiration date",!,LR("%") Q
H2 D H1 Q:LR("Q")  W !!,"Component: ",C(1) W:C(20)]"" " (",C(20),")" W ! Q
H3 D H Q:LR("Q")  W !,LR("%"),!!! Q
 ;
CK I $L(X)>30!(X'?.ANP)!(X["?") W !,$C(7),"Entry must be less than 31 characters with no control characters." K X
 Q
E D:$Y>(IOSL-6) H Q:LR("Q")  K ^TMP($J) W !,LR("%") S X=^LAB(65.9,LRI,0),DIWL=$P(X,U,5),DIWR=IOM-$P(X,U,6),DIWF="W"
 S LRA=0 F LRZ=0:1 S LRA=$O(^LAB(65.9,LRI,2,LRA)) Q:'LRA!(LR("Q"))  D:$Y>(IOSL-6) H3 Q:LR("Q")  S X=^LAB(65.9,LRI,2,LRA,0) D ^DIWP
 Q:LR("Q")  D:LRZ ^DIWW Q
END D V^LRU Q

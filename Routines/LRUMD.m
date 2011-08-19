LRUMD ;AVAMC/REG/CYM - MD SELECTED LAB RESULTS ;2/19/98  09:13 ;
 ;;5.2;LAB SERVICE;**201,341**;Sep 27, 1994
 D L G:Y=-1 END K LRDPAF D LR^LRUMD2 S LRDFN(1)=0,(LRA,LRE,LRG,LRV)=""
 W !!,"Print/display tests for a single patient or group " S %=2 D YN^LRU I %=1 D ^LRUMDS G END:'$D(X),MI
 D ^LRUMD1 G END:LRV=1,D^LRUMD2:LRV=2 I '$O(^LRO(69.2,LRAA,7,DUZ,1,0)) G END
MI W !!?11,"Print/display microbiology results (excluding antibiotics)",!?26,"instead of defined lab tests" S %=2 D YN^LRU G END:%<1 I %=1 S LRM=1 G DT
A W !!,"Print by (T)est list  (P)atient list",! R "Enter T or P: ",Z:DTIME Q:Z=""!(Z[U)  S X=$A(Z) S:X>84 X=X-32,Z=$C(X) I X'=80,X'=84 W $C(7),"  Enter 'T' for Test List or 'P' for Patient list" G A
 D EN^LRUMDS G:%<1 END
DT D B^LRU G:Y<0 END S LRLDT=9999998-LRLDT,LRSDT=9999999-LRSDT G:$D(LRM) ^LRUMDM
 G ^LRUMDP:$A(Z)=80 S ZTRTN="QUE^LRUMD" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO K ^TMP($J) S Z(2)=$O(^LAB(61,"B","SERUM",0)),Z(3)=$O(^LAB(61,"B","BLOOD",0)),Z(5)=$O(^LAB(61,"B","PLASMA",0))
 D L^LRU,L1^LRU,S^LRU,EN^LRUMD1 S LR=0 F F=0:1 S LR=$O(^TMP($J,"N",LR)) Q:'LR!(LR("Q"))  D P
 W:$E(IOST)="P" @IOF D END^LRUTL,END Q
P S LRR=0 I LRDFN(1) D I Q
 I LRG]""!(LRE) D EN^LRUMDP:LRG]"",EN1^LRUMDP:LRE S P=0 F R=0:0 S P=$O(^TMP($J,P)) Q:P=""!(LR("Q"))  F LRDFN=0:0 S LRDFN=$O(^TMP($J,P,LRDFN)) Q:'LRDFN!(LR("Q"))  D I
 Q:LRG]""!(LRE)  S P=0 F R=0:0 S P=$O(^LRO(69.2,LRAA,7,DUZ,1,"C",P)) Q:P=""!(LR("Q"))  F LRDFN=0:0 S LRDFN=$O(^LRO(69.2,LRAA,7,DUZ,1,"C",P,LRDFN)) Q:'LRDFN!(LR("Q"))  Q:'$$GRP  D I
 Q
I S LRI=LRLDT,W(1)=0 F E=0:0 S LRI=$O(^LR(LRDFN,"CH",LRI)) Q:'LRI!(LRI>LRSDT)!(LR("Q"))  I $P(^(LRI,0),"^",4) F B=0:0 S B=$O(^TMP($J,"L",LR,B)) Q:'B!(LR("Q"))  S LRT=^(B) I $D(^LR(LRDFN,"CH",LRI,LRT)) D W Q
 Q:LR("Q")  W:W(1) !,LR("%") Q
 ;
W S LRR=LRR+1 I LRR=1 D H Q:LR("Q")  S LR("F")=1
 S W(1)=W(1)+1,X=^LR(LRDFN,"CH",LRI,0),T=$P(X,"^",5),LRDATE=$TR($$Y2K^LRX(+X,"5M"),"@"," ")
 I W(1)=1 S X=^LR(LRDFN,0),Y=$P(X,"^",3),(LRDPF,X)=$P(X,"^",2),X=^DIC(X,0,"GL"),V=@(X_Y_",0)"),LRP=$P(V,"^"),SSN=$P(V,"^",9),LRL=$S($D(@(X_Y_".1)")):^(.1),$D(^LR(LRDFN,.1)):^(.1),1:"") D SSN^LRU
 D:$Y>(IOSL-6) H1 Q:LR("Q")  W:W(1)=1 !,SSN,?18,$E(LRL,1,5),?39,LRP W !,LRDATE W:T'=Z(2)&(T'=Z(3))&(T'=Z(5)) ?17,$E($P(^LAB(61,T,0),"^"),1,7)
 F X=0:0 S X=$O(^TMP($J,"L",LR,X)) Q:'X  S LRT=^(X) I $D(^LR(LRDFN,"CH",LRI,LRT)) S Y=^(LRT) W ?(16+(X*8)),$J($P(Y,"^"),6),$P(Y,"^",2)
 Q
H I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,"List for: ",$P(^VA(200,DUZ,0),"^") W:LRE ?40,LRE(1) W:IOST'?1"C".E !,"Work copy- DO NOT PUT IN PATIENT'S CHART"
 W !?3,"SSN",?18,"Location",?39,"Patient",! F X=0:0 S X=$O(^TMP($J,"N",LR,X)) Q:'X  W ?(16+(X*8)),$J(^TMP($J,"N",LR,X),7)
 W !,LR("%1") Q
H1 D H Q:LR("Q")  I W(1)>1 W !,SSN,?18,$E(LRL,1,5),?39,LRP
 Q
L ;from LRUMDU
 D END S X="CHEMISTRY" D ^LRUTL Q
EN D L Q:Y=-1  S DA=LRAA,DR=60,DIE=69.2 D ^DIE G END
END D V^LRU Q
EN2 D L Q:Y=-1  W !?10,"Delete users' lab test/patient lists" R !?10,"if they haven't used the lists since: T-6 MONTHS// ",X:DTIME Q:X[U!'$T  S:X="" X="T-6M"
 S %DT="E",%DT(0)="-N" D ^%DT K %DT I Y<1 W !?10,"Enter a date in the past",! G EN2
 W !!?10,"OK to delete " S %=1 D YN^LRU Q:%'=1
 S Y=Y+.99,A(1)=0 F A=0:0 S A=$O(^LRO(69.2,LRAA,7,A)) Q:'A  S X=^(A,0) I $P(X,"^",2)<Y K ^LRO(69.2,LRAA,7,A) W "." S A(1)=A(1)+1
 S X(1)=$O(^LRO(69.2,LRAA,7,0)) S:'X(1) X(1)=0 L +^LRO(69.2,LRAA,7) S X=^LRO(69.2,LRAA,7,0),^(0)=$P(X,"^",1,2)_"^"_X(1)_"^"_$S(X(1)=0:X(1),1:($P(X,"^",4)-1)) L -^LRO(69.2,LRAA,7) W !!,"DONE" Q
 W !!?10,$C(7),"DONE" D V^LRU Q
GRP() ; function to determine if patient is in selected patient group list when printing by test list
 ; returns 1 if patient is ok to print, 0 if patient is not in selected patient group list
 N X,Y
 S X=1
 I $G(LRA)]"" D
 . S Y=$G(^LRO(69.2,LRAA,7,DUZ,1,LRDFN,1))
 . I Y'=LRA S X=0
 Q X

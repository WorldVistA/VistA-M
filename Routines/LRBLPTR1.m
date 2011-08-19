LRBLPTR1 ;AVAMC/REG - TRANSFUSIONS/HEM RESULTS ;3/5/91  09:20 ;
 ;;5.2;LAB SERVICE;**247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 S LRS=$O(^LAB(61,"B","BLOOD",0)) I 'LRS W $C(7),!,"BLOOD must be an entry in TOPOGRAPHY file (#61)",! Q
 S X="BLOOD BANK" D ^LRUTL Q:Y=-1  S B=0 F A=0:0 S A=$O(^LRO(69.2,LRAA,61,LRS,2,A)) Q:'A  S Y=^(A,0),W=$P(Y,"^",2),Y=+Y D S
 S LRT(0)=B I 'B W $C(7),!!,"Must have tests to print entered in the",!,"'Tests for inclusion in transfusion report option' in",!,"Blood bank supervisor menu",! Q
 K ^TMP($J) I IOST?1"C".E W !!,"Please hold while I sort transfusions with hematology results..."
 S LRP=0 F LRA=0:0 S LRP=$O(^TMP("LRBL",$J,LRP)) Q:LRP=""  F LRDFN=0:0 S LRDFN=$O(^TMP("LRBL",$J,LRP,LRDFN)) Q:'LRDFN  S X=^(LRDFN),LRLDT=9999998-$P(X,"^",2),LRSDT=9999999-$P(X,"^") D A
 D WRT Q
A S ^TMP($J,LRDFN)="" F A=LRLDT:0 S A=$O(^LR(LRDFN,1.6,A)) Q:'A!(A>LRSDT)  S X=^(A,0),^TMP($J,LRDFN,A,0)=+X,^(.1)=$P(X,"^",2,99)
 F A=LRLDT:0 S A=$O(^LR(LRDFN,"CH",A)) Q:'A!(A>LRSDT)  S X=^(A,0) F B=1:1:LRT(0) S Z=$S($D(^LR(LRDFN,"CH",A,LRV(B))):$P(^(LRV(B)),"^"),1:"") I Z]"",$P(X,"^",5)=LRS(B) S ^TMP($J,LRDFN,A,0)=+X,^(B)=Z
 Q
WRT S N=0 F A=0:0 S N=$O(^TMP("LRBL",$J,N)) Q:N=""!(LR("Q"))  F LRDFN=0:0 S LRDFN=$O(^TMP("LRBL",$J,N,LRDFN)) Q:'LRDFN!(LR("Q"))  D W
 Q
W D G S LRQ=0 D H Q:LR("Q")
 F A=0:0 S A=$O(^TMP($J,LRDFN,A)) Q:'A!(LR("Q"))  S T=+^(A,0) D T,P
 Q:LR("Q")  D:DFN ^LRBLPC1 Q
P D:$Y>(IOSL-6) H Q:LR("Q")  W !,T S Q=$S($D(^TMP($J,LRDFN,A,.1)):^(.1),1:"") W:Q ?12,$E($P(^LAB(66,+Q,0),"^"),1,28),$S($P(Q,"^",6):"("_$P(Q,"^",6)_")",1:"")
 Q:'$O(^TMP($J,LRDFN,A,.1))
 S X(1)=0 F B=1:1:LRT(0) S X(1)=X(1)+1 S:$X>(IOM-9) X(1)=1 W:$X>(IOM-9) !?32 W ?32+(8*X(1)) I $D(^TMP($J,LRDFN,A,B)) W $J(^(B),5)
 Q
S S X=^LAB(60,Y,0),X(1)=$S($D(^(.1)):$P(^(.1),"^"),1:"??"),Z=$S($D(^(1,W,0)):$P(^(0),"^",7),1:"")
 S B=B+1,LRT(B)=$P($P(X,"^",5),";",2,3)_"^"_W_"^"_$P(X,"^")_"^"_Z_"^"_$P(^LAB(61,W,0),"^")_"^"_Y_"^"_X(1),LRV(B)=+LRT(B),LRS(B)=W Q
T S T=T_"000",T=$E(T,4,5)_"/"_$E(T,6,7)_$S(T[".":" "_$E(T,9,10)_":"_$E(T,11,12),1:"") Q
 ;
H I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,W(2),?31,W(10),?45,"DOB: ",W(4),!,"Location:",?12,W(5),!,"Mo/Da TIME",?12,"Blood component"
 S X(1)=0 F X=1:1:LRT(0) S X(1)=X(1)+1 S:$X>(IOM-8) X(1)=1 W:$X>(IOM-8) !?32 W ?32+(8*X(1)),$P(LRT(X),"^",7)
 W !,LR("%") Q
G S X=^LR(LRDFN,0),(LRDPF,LRPF)=$P(X,"^",2),Y=$P(X,"^",3),X=^DIC(LRPF,0,"GL"),X=@(X_Y_",0)"),W(2)=$P(X,"^"),DFN=$S(LRPF=2:Y,1:""),Y=$P(X,"^",3),SSN=$P(X,"^",9),W(5)=$S($D(^(.1)):^(.1),1:"") D SSN^LRU,D^LRU S W(4)=Y,W(10)=SSN Q
 ;

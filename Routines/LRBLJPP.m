LRBLJPP ;AVAMC/REG - PLATLET TX ;2/18/93  09:28 ;
 ;;5.2;LAB SERVICE;**247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 W !!,"Platelet transfusions from one date received to another."
 D END S X="BLOOD BANK" D ^LRUTL G:Y=-1 END S LRS=$O(^LAB(61,"B","BLOOD",0)) I 'LRS W $C(7),!,"BLOOD must be an entry in TOPOGRAPHY file (#61)",! G END
 I '$O(^LRO(69.2,LRAA,61,LRS,2,0)) W $C(7),!!,"Must have tests to print entered in the",!,"'Tests for inclusion in transfusion report option' in",!,"Blood bank supervisor menu",! G END
 S DIC="^LRO(69.2,LRAA,61,LRS,2,",DIC(0)="AEQMZ" F LRA=1:1 D ^DIC Q:Y<1  S W=$P(Y(0),"^",2),Y=+Y(0) D S
 I LRA=1 W $C(7),!,"No tests selected." G END
 S LRT(0)=LRA-1 D B^LRU G:Y<0 END S LRE=LRLDT+.99,LRB=LRSDT-.0001,ZTRTN="QUE^LRBLJPP" D BEG^LRUTL G:$D(ZTSK)!(POP) END
QUE U IO K ^TMP($J) D:IOST?1"C".E WAIT^LRU D L^LRU,S^LRU,H S LR("F")=1
 F B=0:0 S LRB=$O(^LRD(65,"A",LRB)) Q:'LRB!(LRB>LRE)  F LRI=0:0 S LRI=$O(^LRD(65,"A",LRB,LRI)) Q:'LRI  I $D(^LRD(65,LRI,4)),$P(^(4),"^")="T",$D(^(0)) S Y=$P(^(0),"^",4) I Y,$D(^LAB(66,Y,0)) S Y=$P(^(0),"^") D:Y["PLAT"!(Y["PLT") A
 S X1=LRLDT,X2=5 D C^%DTC S LRLDT=9999998-X S X1=LRSDT,X2=-5 D C^%DTC S LRSDT=9999999-X
 F LRDFN=0:0 S LRDFN=$O(^TMP($J,LRDFN)) Q:'LRDFN  D B
 D WRT W:IO'=IO(0) @IOF D END^LRUTL,END Q
A S X=^LRD(65,LRI,6),Y=$P(X,"^",4),LRDFN=+X,X=^LR(LRDFN,1.6,Y,0),^TMP($J,LRDFN)="",^(LRDFN,Y,0)=+X,^(.1)=$P(X,"^",2,99) Q
B F A=LRLDT:0 S A=$O(^LR(LRDFN,"CH",A)) Q:'A!(A>LRSDT)  S X=^(A,0) F B=1:1:LRT(0) S Z=$S($D(^LR(LRDFN,"CH",A,LRV(B))):$P(^(LRV(B)),"^"),1:"") I Z]"",$P(X,"^",5)=LRS(B) S ^TMP($J,LRDFN,A,0)=+X,^(B)=Z
 Q
WRT F A=0:0 S A=$O(^TMP($J,A)) Q:'A  S X=^LR(A,0),Y=$P(X,"^",3),X=$P(X,"^",2),X=^DIC(X,0,"GL"),X=@(X_Y_",0)"),^TMP($J,"B",$P(X,"^"),A)=$P(X,"^",2,99)
 S LRP=0 F LRA=0:0 S LRP=$O(^TMP($J,"B",LRP)) Q:LRP=""!(LR("Q"))  F LRDFN=0:0 S LRDFN=$O(^TMP($J,"B",LRP,LRDFN)) Q:'LRDFN!(LR("Q"))  S LRX=^(LRDFN),SSN=$P(LRX,"^",8),Y=$P(LRX,"^",2),LRDPF=$P(^LR(LRDFN,0),U,2) D D^LRU,SSN^LRU S DOB=Y D W
 Q
W D:$Y>(IOSL-6) H Q:LR("Q")  W !!,LRP,?31,SSN,?45,"DOB: ",DOB F A=0:0 S A=$O(^TMP($J,LRDFN,A)) Q:'A!(LR("Q"))  S T=+^(A,0) D T,P
 S X=^LR(LRDFN,0) I $P(X,"^",2)=2 S DFN=$P(X,"^",3) D ^LRBLJPP1
 Q
P D:$Y>(IOSL-6) H1 Q:LR("Q")  W !,T S Q=$S($D(^TMP($J,LRDFN,A,.1)):^(.1),1:"") W:Q ?15,$E($P(^LAB(66,+Q,0),"^"),1,25),$S($P(Q,"^",6):"("_$P(Q,"^",6)_")",1:"")
 Q:'$O(^TMP($J,LRDFN,A,.1))
 D:$Y>(IOSL-6) H1 Q:LR("Q")  S X(1)=0 F B=1:1:LRT(0) S X(1)=X(1)+1 S:$X>(IOM-9) X(1)=1 W:$X>(IOM-9) !?32 W ?32+(8*X(1)) I $D(^TMP($J,LRDFN,A,B)) W $J(^(B),5)
 Q
S S X=^LAB(60,Y,0),X(1)=$S($D(^(.1)):$P(^(.1),"^"),1:"??"),Z=$S($D(^(1,W,0)):$P(^(0),"^",7),1:"")
 S LRT(LRA)=$P($P(X,"^",5),";",2,3)_"^"_W_"^"_$P(X,"^")_"^"_Z_"^"_$P(^LAB(61,W,0),"^")_"^"_Y_"^"_X(1),LRV(LRA)=+LRT(LRA),LRS(LRA)=W Q
T S T=T_"000",T=$E(T,4,5)_"/"_$E(T,6,7)_"/"_$E(T,2,3)_$S(T[".":" "_$E(T,9,10)_":"_$E(T,11,12),1:"") Q
 ;
H I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,"Mo/Da TIME",?12,"Blood component"
 S X(1)=0 F X=1:1:LRT(0) S X(1)=X(1)+1 S:$X>(IOM-8) X(1)=1 W:$X>(IOM-8) !?32 W ?32+(8*X(1)),$P(LRT(X),"^",7)
 W !,LR("%") Q
H1 D H Q:LR("Q")  W !!,LRP,?31,SSN,?45,"DOB: ",DOB Q
 ;
END D V^LRU Q

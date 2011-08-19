LRUMDP ;AVAMC/REG/CYM - MD SELECTED LAB RESULTS ;2/19/98  09:16 ;
 ;;5.2;LAB SERVICE;**3,153,201**;Sep 27, 1994
 W !!,"New page for each patient " S %=2 D YN^LRU G:%<1 END S:%=1 LRK=1
 S ZTRTN="QUE^LRUMDP" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO K ^TMP($J) S Z(2)=$O(^LAB(61,"B","SERUM",0)),Z(3)=$O(^LAB(61,"B","BLOOD",0)),Z(5)=$O(^LAB(61,"B","PLASMA",0))
 D L^LRU,L1^LRU,S^LRU,EN^LRUMD1 D:'$D(LRK) H S P=0,LR("F")=1 I LRDFN(1) D I G OUT
 I LRG]""!(LRE) D EN:LRG]"",EN1:LRE D L G OUT
 F R=0:0 S P=$O(^LRO(69.2,LRAA,7,DUZ,1,"C",P)) Q:P=""!(LR("Q"))  F LRDFN=0:0 S LRDFN=$O(^LRO(69.2,LRAA,7,DUZ,1,"C",P,LRDFN)) Q:'LRDFN!(LR("Q"))  D I
OUT W:$E(IOST)="P" @IOF D END^LRUTL,END Q
I I LRA]"" Q:'$D(^LRO(69.2,LRAA,7,DUZ,1,LRDFN,1))  Q:LRA'=^(1)
J ;
 Q:'$D(^LR(LRDFN,0))  S X=^(0) D
 .S Y=$P(X,"^",3),(LRDPF,X)=$P(X,"^",2),X=^DIC(X,0,"GL"),V=@(X_Y_",0)"),LRP=$P(V,"^"),SSN=$P(V,"^",9),LRL=$S($D(@(X_Y_",.1)")):^(.1)_" "_$G(@(X_Y_",.101)")),$D(^LR(LRDFN,.1)):^(.1)_" "_$G(@(X_Y_",.101)")),1:"No Room") D SSN^LRU
 D:$Y>(IOSL-6)!($D(LRK)) H Q:LR("Q")  W !,SSN,?19,"LOC:",LRL,?44,"Patient: ",LRP S LR=0 F F=0:1 S LR=$O(^TMP($J,"N",LR)) Q:'LR!(LR("Q"))  D T
 Q:LR("Q")  W !,LR("%1") Q
T S LRI=LRLDT,W(1)=0 F  S LRI=$O(^LR(LRDFN,"CH",LRI)) Q:'LRI!(LRI>LRSDT)!(LR("Q"))  I $P(^(LRI,0),"^",4) F B=0:0 S B=$O(^TMP($J,"L",LR,B)) Q:'B!(LR("Q"))  S LRT=^(B) Q:LRT=""  I $D(^LR(LRDFN,"CH",LRI,LRT)) D W Q
 Q:LR("Q")  W:W(1) !,LR("%") Q
 ;
W I $Y>(IOSL-6) D H1 Q:LR("Q")  S W(1)=W(1)+1
 S W(1)=W(1)+1,X=^LR(LRDFN,"CH",LRI,0),Y=+X_"000",T=$P(X,"^",5),LRDATE=$TR($$Y2K^LRX(Y,"5M"),"@"," ")
 D:W(1)=1 A W !,LRDATE W:T'=Z(2)&(T'=Z(3))&(T'=Z(5)) ?15,$E($P(^LAB(61,T,0),"^"),1,7)
 F X=0:0 S X=$O(^TMP($J,"L",LR,X)) Q:'X  S LRT=^(X) I LRT'="",$D(^LR(LRDFN,"CH",LRI,LRT)) S Y=^(LRT) W ?(16+(X*8)),$J($P(Y,"^"),6),$P(Y,"^",2)
 Q
H I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,"List for: ",$P(^VA(200,DUZ,0),"^") W:LRA]"" ?40,"PT GRP: ",LRA W:LRE ?40,LRE(1) W:IOST'?1"C".E !,"Work copy- DO NOT PUT IN PATIENT'S CHART" W !,LR("%") Q
H1 D H Q:LR("Q")  W !,SSN,?19,"LOC:",LRL,?44,"Patient: ",LRP Q:W(1)=1
A W ! F X=0:0 S X=$O(^TMP($J,"N",LR,X)) Q:'X  W ?(16+(X*8)),$J(^TMP($J,"N",LR,X),7)
 Q
L F R=0:0 S P=$O(^TMP($J,P)) Q:P=""!(LR("Q"))  F LRDFN=0:0 S LRDFN=$O(^TMP($J,P,LRDFN)) Q:'LRDFN!(LR("Q"))  D:P'="N"&(P'="L") J
 Q
EN F X=0:0 S X=$O(^DPT("CN",LRG,X)) Q:'X  I $D(^DPT(X,"LR")) S Y=^("LR") S:Y ^TMP($J,$P(^DPT(X,0),"^"),Y)=""
 Q
EN1 F X=LRE(2):0 S X=$O(^SC(LRE,"S",X)) Q:'X!(X\1-LRE(2))  F Y=0:0 S Y=$O(^SC(LRE,"S",X,1,Y)) Q:'Y  S Z=+^(Y,0),A=$S($D(^DPT(Z,"LR")):+^("LR"),1:0) S:A ^TMP($J,$P(^DPT(Z,0),"^"),A)=""
 Q
 ;
END W:$E(IOST)="P" @IOF D V^LRU K LRE,E Q

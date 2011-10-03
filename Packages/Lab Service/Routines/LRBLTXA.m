LRBLTXA ;AVAMC/REG - TRANSFUSION FOLLOW-UP ;2/18/93  09:55 ;
 ;;5.2;LAB SERVICE;**247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 D END S X="BLOOD BANK" D ^LRUTL G:Y=-1 END W !!,"Search for possible transfusion related disorders"
 D B^LRU G:Y<0 END S X1=LRSDT,X2=-185 D C^%DTC S LRT=9999999-X,J=LRSDT-1,LRSDT=9999999-LRSDT,LRJ=9999998-LRLDT
 S ZTRTN="QUE^LRBLTXA" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO K ^TMP($J) S LR("D")=0,Z(2)=$O(^LAB(61,"B","SERUM",0)),Z(3)=$O(^LAB(61,"B","BLOOD",0)),Z(5)=$O(^LAB(61,"B","PLASMA",0)) D L^LRU,S^LRU,H S LR("F")=1
 F A=0:0 S A=$O(^LRO(69.2,LRAA,60,A)) Q:'A  F B=0:0 S B=$O(^LRO(69.2,LRAA,60,A,1,B)) Q:'B  S C=^(B,0),N(A,B)=$P(^LAB(60,+C,.1),"^"),L(A,B)=$P($P(^(0),"^",5),";",2)_"^"_$P(C,"^",2,3)
 F A=J:0 S A=$O(^LRO(69,A)) Q:'A!(A>LRLDT)  F B=0:0 S B=$O(^LRO(69,A,1,"AA",B)) Q:'B  S T=$O(^LR(B,1.6,0)) I T,T<LRT D P
 S LRP=0 F A=0:0 S LRP=$O(^TMP($J,LRP)) Q:LRP=""!(LR("Q"))  F LRDFN=0:0 S LRDFN=$O(^TMP($J,LRP,LRDFN)) Q:'LRDFN!(LR("Q"))  S LRP(1)=^(LRDFN),SSN=$P(LRP(1),"^"),LRDPF=$P(^LR(LRDFN,0),U,2) D SSN^LRU,T
 W !,LR("%") S A=0 F B=0:0 S A=$O(LR("D",A)) Q:A=""  D:$Y>(IOSL-6) H Q:LR("Q")  W !,A,?5,"= ",LR("D",A)
 D END^LRUTL,END Q
T S W(1)=0 F LRI=LRJ:0 S LRI=$O(^LR(LRDFN,"CH",LRI)) Q:'LRI!(LRI>LRSDT)!(LR("Q"))  S X=^(LRI,0),Y=+X_"000",T=$P(X,"^",5),T(1)=$E(Y,4,5)_"/"_$E(Y,6,7)_"/"_$E(Y,2,3)_" "_$S(Y[".":$E(Y,9,10)_":"_$E(Y,11,12),1:"") D W
 I W(1),DFN S W(2)=LRP,W(10)=$P(LRP(1),"^"),W(5)=$P(LRP(1),"^",2),W(4)=$P(LRP(1),"^",4) D ^LRBLPC1
 W:W(1) !,LR("%") Q
W F LR=0:0 S LR=$O(L(LR)) Q:'LR!(LR("Q"))  S J(2)=0 F B=0:0 S B=$O(L(LR,B)) Q:'B!(LR("Q"))  D B Q:LR("Q")
 Q
B S J=$P(L(LR,B),"^",3),X=$S($D(^LR(LRDFN,"CH",LRI,+L(LR,B))):$P(^(+L(LR,B)),"^"),1:"") S:"<>"[$E(X) X=$E(X,2,99) I X]"",T=$P(L(LR,B),"^",2) D L Q:J(2)
 Q
L I $E(J)="[" Q:X'[$E(J,2,99)  G M
 I $E(J)="=" Q:X'=$E(J,2,99)  G M
 I X=+X,@(X_J) G M
 Q
M S J(2)=1,W(1)=W(1)+1,DFN=$P(LRP(1),"^",3),W(4)=$P(LRP(1),"^",4) D:$Y>(IOSL-6) H1 Q:LR("Q")
 W:W(1)=1 !,LRP," SSN:",SSN," Loc: ",$P(LRP(1),"^",2) D:W(1)=1 A,C W !,T(1) W:T'=Z(2)&(T'=Z(3))&(T'=Z(5)) ?13,$E($P(^LAB(61,T,0),"^"),1,7)
 F X=0:0 S X=$O(L(LR,X)) Q:'X  I $D(^LR(LRDFN,"CH",LRI,+L(LR,X))) W ?(16+(X*8)),$J($P(^(+L(LR,X)),"^"),7)
 S B=99 Q
A F E=0:0 S E=$O(^LR(LRDFN,1.6,E)) Q:'E!(E>LRT)!(LR("Q"))  S X=^(E,0),F=$E(X,1,5),G=$P(X,"^",2) S:'$D(E(F,G)) E(F,G)=0 S E(F,G)=E(F,G)+1
 F F=0:0 S F=$O(E(F)) Q:'F!(LR("Q"))  D:$Y>(IOSL-6) H2 Q:LR("Q")  W !,$E(F,4,5)_"/"_$E(F,2,3) F G=0:0 S G=$O(E(F,G)) Q:'G  S X=^LAB(66,G,0),Y=$P(X,"^",2) S:Y="" Y="?" W "  ",Y,":",E(F,G) S LR("D",Y)=$P(X,"^")
 K E Q
C I LR W ! F X=0:0 S X=$O(N(LR,X)) Q:'X  W ?(16+(X*8)),$J(N(LR,X),7)
 Q
P S X=^LR(B,0),Y=$P(X,"^",3),X=$P(X,"^",2),DFN=$S(X=2:Y,1:""),L=^DIC(X,0,"GL"),X=@(L_Y_",0)"),L=$S($D(@(L_Y_",.1)")):^(.1),$D(^LR(B,.1)):^(.1),1:"UNKNOWN"),Y=$P(X,"^",3) D:Y D^LRU S W(4)=Y
 S ^TMP($J,$P(X,"^"),B)=$P(X,"^",9)_"^"_L_"^"_DFN_"^"_W(4) Q
 ;
END D V^LRU Q
 ;
H I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,"BLOOD BANK  SEARCH FOR TRANSFUSION RELATED DISORDERS",!?24,"FROM ",LRSTR," TO ",LRLST,!,LR("%") Q
H1 D H Q:LR("Q")  W:W(1)>1 !,LRP," SSN:",SSN," Loc: ",$P(LRP(1),"^",2) D:W(1)>1 C Q
H2 D H Q:LR("Q")  W !,LRP," SSN:",SSN," Loc: ",$P(LRP(1),"^",2) Q

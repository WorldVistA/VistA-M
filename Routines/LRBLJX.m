LRBLJX ;AVAMC/REG - UNITS ON XMATCH ;2/18/93  09:36 ;
 ;;5.2;LAB SERVICE;**247,267**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 W !!?10,"Units on crossmatch by date/time crossmatched",!!
 S ZTRTN="QUE^LRBLJX" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO K ^TMP($J) D L^LRU,S^LRU
 F A=0:0 S A=$O(^LRD(65,"AP",A)) Q:'A  F B=0:0 S B=$O(^LRD(65,"AP",A,B)) Q:'B  D A
 D W W:IOST'?1"C".E @IOF K ^TMP($J) D END^LRUTL,END Q
T ;from LRBLJR
 Q:'T  I $E(T,1,3)>$E(DT,1,3) S T=$E(T,4,5)_"/"_$E(T,6,7)_"/"_$E(T,2,3) Q
 S T=T_"000",T=$E(T,4,5)_"/"_$E(T,6,7)_$S(T[".":" "_$E(T,9,10)_":"_$E(T,11,12),1:"") Q
W D H S LR("F")=1 F A=0:0 S A=$O(^TMP($J,A)) Q:'A!(LR("Q"))  S T=A D T S T(1)=T D I
 Q
I S B=0 F C=0:0 S B=$O(^TMP($J,A,B)) Q:B=""!(LR("Q"))  F E=0:0 S E=$O(^TMP($J,A,B,E)) Q:E=""!(LR("Q"))  S W=^(E) D:$Y>(IOSL-6) H Q:LR("Q")  D P
 Q
P W !,T(1),?12 S T=$P(W,"^",6) D T W T,?24,$P(B,"""",2),?38,$J($P(W,"^",4),2),$P(W,"^",5),?42,$P(W,"^"),?47 S T=$P(W,"^",2) D T W T,?60,$P(^LAB(66,$P(W,"^",3),0),"^",2)
 S X=^LR(E,0),Y=$P(X,"^",3),(LRDPF,X)=$P(X,"^",2),X=^DIC(X,0,"GL"),Y=@(X_Y_",0)") S SSN=$P(Y,"^",9) D SSN^LRU W ?66 W:IOM>80 $P(Y,"^"),?94,SSN W:IOM<81 $E($P(Y,"^"),1,10),SSN(1) Q
A S X=^LRD(65,B,0),M=$P(^LRD(65,B,2,A,0),"^",2),L=$O(^LRD(65,B,3,0)),L=$S(L:$E($P(^(L,0),"^",4),1,4),1:"BB"),X(8)=$P(X,"^",8),X(8)=$S(X(8)="POS":"+",X(8)="NEG":"-",1:"") I 'M K ^LRD(65,"AP",A,B) Q
 S K=$O(^LRD(65,B,2,A,1,0)),K=$S('K:"",1:+^(K,0)),X(1)=""""_$P(X,"^")_""""
 S ^TMP($J,M,X(1),A)=L_"^"_$P(X,"^",6)_"^"_$P(X,"^",4)_"^"_$P(X,"^",7)_"^"_X(8)_"^"_K
 Q
H I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,"Blood Bank "
 W !,"XMATCHED",?13,"SPECIMEN",?46,"EXPIRES",!,"Mo/Da TIME",?12,"Mo/Da TIME",?24,"Unit ID",?37,"Type",?42,"Loc",?47,"Mo/Da TIME",?60,"Prod",?66,"Patient/SSN",!,LR("%") Q
 ;
END D V^LRU Q

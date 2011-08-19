LRBLJU1 ;AVAMC/REG - FIND UNITS NO DISPOSITION ;5/17/96  08:34
 ;;5.2;LAB SERVICE;**72,247,267**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 S (LRK,T(1),LRF)=0
 F C=0:0 S C=$O(^TMP($J,C)) Q:'C!(LR("Q"))  S LRF=LRF+1,C(1)=$S($D(^LAB(66,C,0)):$P(^(0),"^"),1:C) D H Q:LR("Q")  S LR("F")=1 D A
 I 'LRF D F^LRU W !,"Transfusion Service - Units ",$S(LROPT="EN1":"in & out date without final disposition",1:"available"),!,LR("%"),!,"There are no units ",$S(LROPT="":"available.",1:"without a final disposition.")
 Q
A S A=0 F A(1)=0:0 S A=$O(^TMP($J,C,A)) Q:A=""!(LR("Q"))  D B
 Q:LR("Q")  W !,C(1)," Total units: ",T(1) S T(1)=0 Q
B S R=0 F A(2)=0:0 S R=$O(^TMP($J,C,A,R)) Q:R=""!(LR("Q"))  W ! D C
 Q
C S E=0,T(2)=0 F A(3)=0:0 S E=$O(^TMP($J,C,A,R,E)) Q:E=""!(LR("Q"))  S Y=E D D^LRU S C(6)=Y D D
 Q:LR("Q")  W !?4,"Total ",A," ",R," units: ",T(2) Q
D S I=0 F A(4)=0:0 S I=$O(^TMP($J,C,A,R,E,I)) Q:I=""!(LR("Q"))  S W=^(I),I(1)=+W D:$Y>(IOSL-6) H Q:LR("Q")  W !,A,?3,R,?7,I,?23,C(6),?43,$E($P(W,"^",2),1,8) D E
 Q
E S C(2)=0,T(1)=T(1)+1,T(2)=T(2)+1,X=$S($D(^LRD(65,I(1),8)):$P(^(8),"^",3),1:""),LRJ=$S(X="":0,X="A":1,X="D":1,1:0)
 S P=0 F P(1)=0:1 S P=$O(^LRD(65,I(1),2,P)) Q:'P!(LR("Q"))  D F
 I 'P(1)&LRJ!(LRJ&LRK) S P=+^LRD(65,I(1),8) W ?52,"*" I P D P W $E($P(Y,"^"),1,14)
 Q
F S LRK=0 I '$P(^LRD(65,I(1),2,P,0),"^",2) S LRK=1 Q
 S C(2)=C(2)+1 W:C(2)>1 ! Q:'$D(^LR(P,0))  D P
 W:LRJ ?52,"*" W ?53,$E($P(Y,"^"),1,14) S LRI=$O(^LRD(65,I(1),2,P,1,0)) Q:'LRI  S I(2)=+^(LRI,0),I(3)=$P(I(2),".",2),I(3)=I(3)_"0000",I(3)=$E(I(3),1,4) W ?68,$E(I(2),4,5)_"/"_$E(I(2),6,7) W:I(3) ?74,$E(I(3),1,2)_":"_$E(I(3),3,4) Q
 ;
P S X=^LR(P,0),Y=$P(X,"^",3),X=$P(X,"^",2),X=^DIC(X,0,"GL"),Y=@(X_Y_",0)") Q
H I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,"Transfusion Service ",LRAA(4),!,"Units of ",C(1),$S(LROPT["EN1":" in & out date ",1:" available")," (no disposition)"
 W !?49,"*Autologous/Directed",!,"ABO",?4,"Rh",?7,"ID",?23,"Expiration Date",?43,"Location",?52,"Patient Assigned",?69,"Spec Date",!,LR("%") Q

IB20PT88 ;ALB/CPM - EXPORT ROUTINE 'DG3PR0' ; 24-FEB-94
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;
DG3PR0 ;ALB/JDS - 10-10I ;01 JAN 1987
 ;;5.3;Registration;**26**;Aug 13, 1993
START K ^UTILITY($J) S (N(1),N(0),DG(1),DG(0))="" D ALL^IBCNS1(DFN,"DGIBINS") F I=0:0 S I=$O(DGIBINS(I)) Q:'I  S L=DGIBINS(I,0),M=$P(L,U,6),M=$S(M']"":0,1:M),^UTILITY($J,M,I)=L
 F I="v",0,"s","o" I $D(^UTILITY($J,I)) S DG(0)=^($O(^(I,0))),N(0)=I Q
 F I="v",0,"s","o" I $D(^UTILITY($J,I)) S L=$S(N(0)=I:$O(^($O(^(I,0)))),1:$O(^(I,0))) I L>0 S DG(1)=^UTILITY($J,I,L),N(1)=I Q
 ;K ^UTILITY($J)
PRINT ;
 G:$$FIRST^DGUTL Q
 I '$D(DGNOW) N DGNOW D NOW^%DTC,YX^%DTC S DGNOW=Y
 W "Printed: ",DGNOW
 S DIC(0)="LM",X="DG1010I",DIC="^DIC(47," D ^DIC G Q:Y'>0 S DGY=+Y
 F I=0,.21,.22,.25,.311 S D(I)=$S($D(^DPT(DFN,I)):^(I),1:"")
 S Y=$P(D(.22),U,5) D ZIPOUT^VAFADDR S X=$P(D(.311),U,6,7)_U_Y D AD2 S D(.311)=$P(D(.311),U,1)_U_$P(D(.311),U,9)_U_$P(D(.311),U,3)_" "_$P(D(.311),U,4)_" "_$P(D(.311),U,5)_U_X
 S Y=$P(D(.22),U,6) D ZIPOUT^VAFADDR S X=$P(D(.25),U,5,6)_U_Y D AD2 S D(.25)=$P(D(.25),U,1)_U_$P(D(.25),U,8)_U_$P(D(.25),U,2)_" "_$P(D(.25),U,3)_" "_$P(D(.25),U,4)_U_X
 F I=0,1 D SET
 S (L,DGL)=0 F I=0:0 S I=$O(^DIC(47,+DGY,1,I)) Q:'I!(DGL=I)  S J=^(I,0),X="" W ! F K=1:1 W $E($P(J,"{}",K),$S(K=1:1,X']"":1,1:$L(X)-1),999) S X=$P(J,"{",K+1) Q:X']""  S L=L+1 D SE W:X']"" "  "
Q D ENDREP^DGUTL K A,B,D,DG,DGL,DGY,DIC,E,I,J,K,L,M,N,X,X1,X2,Y,DGIBINS,^UTILITY($J)
 Q
SET S A=DG(I),A=$S($D(^DIC(36,+A,0)):^(0),1:""),B=$G(^DIC(36,+DG(I),.11)),Y=$P(B,U,6) D ZIPOUT^VAFADDR S X=$P(B,U,4,5)_U_Y D AD2
 S X(I)=$P(A,U,1)_U_$P($G(^DIC(36,+DG(I),.13)),U,1)_U_$P(B,U,1)_U_X_U_$P(DG(I),U,2)_U_$P(DG(I),U,3)_U,Y=$P(DG(I),U,8) X ^DD("DD") S X(I)=X(I)_Y_U,Y=$P(DG(I),U,7) X ^DD("DD") S X(I)=X(I)_Y
 S N=$S(N(I)="s":$P(DG(I),U,17)_U_"SPOUSE",(N(I)=0!(N(I)="v")):$P(D(0),U,1)_U_"SAME",1:$P(DG(I),U,17)_U)
 S E=$S(N(I)=0!(N(I)="v"):D(.311),N(I)="s":D(.25),1:"^^^^")
 S X=$P(DG(I),U,12,14) D AD2 S X1(I)=N_U_E,X2(I)=$P(DG(I),U,9,11)_U_X
 Q
AD2 S X=$P(X,U,1)_$S($P(X,U,1)]"":", ",1:"")_$S($D(^DIC(5,+$P(X,U,2),0)):$P(^(0),U,1),1:"")_" "_$P(X,U,3) Q
SE I L>2&(L<11) S X=$P(X(L\21),U,L-$S(L>20:20,1:2)) W X Q
 I L>10&(L<17) S X=$P(X1(L\21),U,L-10) W X Q
 I L>16&(L<21) S X=$P(X2(L\21),U,L-16) W X Q
 I L>20&(L<29) S X=$P(X(L\21),U,L-20) W X Q
 I L>28&(L<35) S X=$P(X1(L\21),U,L-28) W X Q
 I L>34 S X=$P(X2(L\21),U,L-34) W X Q
 S X=$P(D(0),U,$S(L=1:1,1:9)) W X Q
 Q

DITC2 ;SFISC/XAK-COMPARE FILE ENTRIES PRINT ;10/15/91  9:01 AM
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 S J=-1 D PG1 F K=0:0 S J=$O(^UTILITY($J,"DIT",J)) Q:X=U!(U[J)  S N=-1 F K=0:0 S N=$O(^UTILITY($J,"DIT",J,N)) Q:N=""!(X=U)  D D1 Q:X=U  D:+X(0) D2
 I X'=U D PG Q:X=U  D MUL:$D(^UTILITY($J,"DIT",U))
 Q
D1 ;
 I $Y+6>IOSL,'$D(DREDO) S DIJ=J,DIN=N D PG,PG1:X'=U S J=DIJ,N=DIN K DIJ,DIN
 Q:X=U
D11 F I=0:1:2 S X(I)=$S($D(^UTILITY($J,"DIT",J,N,I)):^(I),1:"") I X(I)["""" D D7
 S DEQ=X(1)=X(2) I $D(DDIF),DEQ I (DDIF=1)!(DDIF=2&$L(X(1))) S X(0)=0 K ^UTILITY($J,"DIT",J,N) Q
 Q:'$D(DIMERGE)  S X1=$P(X(0),U,3) I '$L(X1) S X1=$S(X(1)=X(2):0,'$L(X(DDEF)):'(DDEF-1)+1,1:DDEF),$P(^UTILITY($J,"DIT",J,N,0),U,3)=X1,$P(X(0),U,3)=X1
 Q
D2 ;
 K D S X2=$P(X(0),U,3),X(0)=$P(X(0),U,2)
D20 F I=0:1:2 S X=X(I),X1="" F D=1:1 Q:'$L(X)  D:($L(X)>(DV-6)) D5 S $P(D(D),U,I+1)=$S(I=X2&I:"["_X_"]",1:X) S X=X1,X1=""
D21 F I=1:1 Q:'$D(D(I))  D D3
 Q
D3 ;
 I $D(DREDO),I=1 X:$D(IOXY) IOXY W !,DREDO,".",?4 G D31
 W ! W:(I=1) ! I I=1,$D(DIMERGE) S DNUM=DNUM+1 W DNUM,"." S DNUM(DNUM)=J_U_N_U_$Y
 W:'DEQ&'$D(DIMERGE)&(I=1) "***" W ?4
D31 F X1=1:1:3 I $L($P(D(I),U,X1)) W ?(DV*(X1-1)) W $P(D(I),U,X1)
 I $D(DREDO) W $E(DDSPC,1,3)
 Q
D5 ;
 F K=DV-6:-1:1 Q:$E(X,K)?1P
 I $E(X,K)?1P S X1=$E(X,K+1,999),X=$E(X,1,K) Q
 S X1=$E(X,DV-1,999),X=$E(X,DV-2)
 Q
D7 S X(I)=$P(X(I),"""",1)_"'"_$P(X(I),"""",2,99) I X(I)["""" G D7
 Q
MUL ;
 S DIMUL=1 D PG1 S N=0
 F K=0:0 S N=$O(^UTILITY($J,"DIT",U,N)) Q:N=""!(X=U)  D EMUL
 K DIMUL Q
EMUL ;
 D:$Y+5>IOSL PG
 K D S X2="",J=^UTILITY($J,"DIT",U,N,0),X=$P(J,U,2),X1="",I=0 F D=1:1 Q:'$L(X)  D:($L(X)>(DV-6)) D5 S $P(D(D),U,I+1)=""""_X_"""" S X=X1,X1=""
 S X=J F I=1:1:2 S $P(D(1),U,I+1)=""""_$S('$P(X,U,I+3):"  ---",1:$J($P(X,U,I+3),2)_$S($P(X,U,I+3)>1:" entries",1:" entry"))_""""
 D D21
 Q
PG ;
 I '$D(DIMERGE)!$D(DIMUL) I IOST?1"C".E W $C(7) K DIR S DIR(0)="E" D ^DIR K DIR S:$D(DIRUT) X=U Q
 W:'$D(IOXY) !! Q:IOST'?1"C".E  I $D(IOXY) S DX=0,DY=IOSL-3 X IOXY W !
 W "Default is enclosed in brackets, e.g., [",$E($P(DHD(1),U,DDEF),1,(DV-6)),"]",! S %="Enter 1-"_DNUM_" to change default value, ^ to exit, RETURN to continue: " W %,$E(DDSPC,1,IOM-$L(%)-2)
 I $D(IOXY) S DX=$L(%),DY=IOSL-1 X IOXY
 I '$D(IOXY) F I=1:1:IOM-$L(%)-2 W $C(8)
 R X:DTIME S:'$T X=U,DTOUT=1 Q:X=U
 S X1="" I X=+X,X>0,X'>DNUM S J=$P(DNUM(X),U),N=$P(DNUM(X),U,2),X1=$P(^UTILITY($J,"DIT",J,N,0),U,3) G:'X1 PG I +^(0)=.01,$D(^UTILITY($J,"DITDINUM",J,N,0)) D ERD G PG
 I X1 S $P(^UTILITY($J,"DIT",J,N,0),U,3)='(X1-1)+1,DREDO=X,DX=5,DY=$P(DNUM(X),U,3)-1 D D1,D2 K DREDO G PG
 I $L(X) W $C(7) G PG
 Q
PG1 S DC=DC+1,DNUM=0 W:DIFF @IOF S DIFF=1 W DHD(0),?(IOM-29),DHD(9),"   PAGE ",DC
 S I=$S($D(DIMERGE):DDEF,1:0) F X1=1:1:DFL W ! W $E(DFL(X1),1,DV-1) W ?DV W:(I=1) "[" W $E($P(DHD(X1),U,1),1,DV-1) W:(I=1) "]" W ?(DV*2) W:(I=2) "[" W $E($P(DHD(X1),U,2),1,DV-1) W:(I=2) "]"
 W !,DDSH I $D(DIMUL) W !,?2,"NOTE: Multiples will be merged into the target record"
 Q
ERD W:'$D(IOXY) !! W $C(7) I $D(IOXY) S DX=0,DY=IOSL-1 X IOXY
 W "You must accept the default because this record is DINUMed!!",$E(DDSPC,1,IOM-62) I $D(IOXY) S DX=61,DY=IOSL-1 X IOXY
 R X:10 Q

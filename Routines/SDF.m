SDF ;SF/GFT - FILE ROOM LIST BY CLINIC ; 12 SEP 84  9:48 am
 ;;5.3;Scheduling;;Aug 13, 1993
 S U="^",DIV="" D DIV^SDUTL I $T D FRLST^SDDIV G QUIT:Y<0
 S %DT="AXE",%DT("A")="LIST APPOINTMENTS FOR WHAT DATE: " D ^%DT K %DT("A") G QUIT:Y<0 S SDDT=Y
A S Z="^CLINIC^TERMINAL DIGIT" W !,"ENTER 'C'LINIC IF YOU WANT LIST PRINTED BY CLINIC AND TERMINAL DIGIT ORDER" R !,"APPOINTMENT LIST ORDER: TERMINAL DIGIT ONLY// ",X:DTIME D IN^DGHELP G HELP:X["?",QUIT:X["^",A:"CT"'[X S ANS=$S(X']"":"T",1:X)
 S VAR="DIV^ANS^SDDT",VAL=DIV_"^"_ANS_"^"_SDDT,PGM="START^SDF" D ZIS^DGUTQ G QUIT:POP
START K ^UTILITY($J) G:ANS="T" ^SDF1
 S A=0 F AA=0:0 S A=$N(^SC("B",A)) Q:A<0  S C=$N(^SC("B",A,0)) I $D(^SC(C,0)),$S('$D(^SC(C,"I")):1,+^("I")=0:1,+^("I")>SDDT:1,+$P(^("I"),"^",2)'>SDDT&(+$P(^("I"),"^",2)'=0):1,1:0) D AHEAD
 G LST
AHEAD I $S(DIV="":1,$P(^SC(C,0),"^",15)=DIV:1,1:0),$P(^(0),"^",3)="C",$P(^(0),"^",17)'="Y"!$P(^(0),"^",21) F SC="S","C" F D=SDDT-.01:0 S D=$N(^SC(C,SC,D)) Q:D\1-SDDT  F P=0:0 S P=$N(^SC(C,SC,D,1,P)) Q:P'>0  S X=^(P,0) D C:$D(^DPT(+X,0))
 Q
LST U IO S DA=0
 F SC=0:0 S SC=$N(^UTILITY($J,SC)) Q:SC<0  S SDHED=1 F I=0:0 S DA=$N(^UTILITY($J,SC,DA)) Q:DA<0  F X=0:0 S X=$N(^UTILITY($J,SC,DA,X)) Q:X'>0  S D=^DPT(X,0) D SMORE
 W ! W:$E(IOST)'="C" @IOF D CLOSE^DGUTQ G QUIT
 ;
C S DA=$E($P(^(0),U,9),6,9),DA=$E(DA,3,4)_$E(DA,1,2),X=$P(X_"^^^^^",U,1,5) ; NAKED REFERENCE - ^DPT(DFN,0)
 I $D(^DPT(+X,"S",D,0)) S SDAPTT=$P(^(0),U,16) I $P(^(0),U,2)["C"!($P(^SC(C,SC,D,1,P,0),U,9)="C") S X=X_"^***CANCELLED!***"
 S ^UTILITY($J,C," "_DA,+X,D)=C_U_X,$P(^UTILITY($J,C," "_DA,+X,D),U,8)=$S($D(^DPT(+X,.1)):^(.1),1:"")
 I $D(^DPT(+X,.36)),$D(^DIC(8,+^DPT(+X,.36),0)),$P(^(0),"^",9)=13 S $P(^UTILITY($J,C," "_DA,+X,D),U,9)="** COLLATERAL **" Q
 I SC="S",$P(^SC(C,SC,D,1,P,0),"^",10)]"" S V=$P(^(0),"^",10),V=$S($D(^DIC(8,+V,0)):$P(^(0),"^",9)=13,1:0) I V S $P(^UTILITY($J,C," "_DA,+X,D),U,9)="** COLLATERAL **"
 S $P(^UTILITY($J,C," "_DA,+X,D),U,10)=$S('$D(SDAPTT):"",$D(^SD(409.1,+SDAPTT,0)):$P(^(0),"^",4),1:"UNSPECIFIED")
 K V Q
 ;
O D:SDHED!($Y+2>IOSL) WHED S Y=^UTILITY($J,SC,DA,X,C) W !,$E($P(D,U,9),6,9),?6,$E($P(D,U,1),1,23),?30,$E($P(D,U,9),1,9),?40," " S T=$P(C,".",2)_"000" I T W $E(T,1,2),":",$E(T,3,4)
 W ?64,$P(Y,U,10)," TYPE",!
 I $P(Y,U,8)]"" W ?48,"** WARD: ",$P(Y,U,8)," **"
 I $P(Y,U,7)]"" W !,?4,$P(Y,U,7)
 I $P(Y,U,9)]"" W !,?4,$P(Y,U,9)
 Q
SMORE S C=0 F CC=1:1 S C=$N(^UTILITY($J,SC,DA,X,C)) Q:C<0  D O
 Q
WHED S SDHED=0,SDSCN=$P(^SC(SC,0),"^",1) W !,@IOF,!?9,"FILE ROOM LIST FOR APPOINTMENTS " S Y=SDDT D DT^DIQ W !,?30-($L(SDSCN)\2),SDSCN,?55,"PRINTED: " S Y=DT D DT^DIQ W !!
 Q
HELP W !!,"DEPENDING ON TYPE OF SORT, ENTER:",!?5,"'C' - BY CLINIC NAME",!?5,"'T' - BY TERMINAL DIGIT",! G A
QUIT K %,%DT,A,AA,ALL,ANS,C,CC,D,DA,DIV,DTOUT,I,P,PGM,POP,SC,SDAPTT,SDDT,SDHED,SDSCN,T,VAL,VAR,X,Y,Z,^UTILITY($J) Q

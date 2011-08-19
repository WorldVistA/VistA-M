SDF1 ;SF/GFT - PRINT FILE ROOM LIST BY TERMINAL DIGIT ; 12 SEP 84  9:48 am
 ;;5.3;Scheduling;;Aug 13, 1993
 F C=0:0 S C=$N(^SC(C)) Q:C'>0  I $D(^SC(C,0)) D CHECK I $T F SC="S","C" F D=SDDT-.01:0 S D=$N(^SC(C,SC,D)) Q:D\1-SDDT  F P=0:0 S P=$N(^SC(C,SC,D,1,P)) Q:P'>0  S X=^(P,0) D C:$D(^DPT(+X,0))
 U IO W @IOF,!?9,"FILE ROOM LIST FOR APPOINTMENTS " S Y=SDDT D DT^DIQ W !?55,"PRINTED: " S Y=DT D DT^DIQ W !!! S DA=0
 F I=0:0 S DA=$N(^UTILITY($J,DA)) Q:DA<0  F X=0:0 S X=$N(^UTILITY($J,DA,X)) Q:X'>0  S SD1=0,D=^DPT(X,0) W !,$E($P(D,U,9),6,9),?6,$E($P(D,U,1),1,23),?30,$E($P(D,U,9),1,9) S C=0 F CC=1:1 S C=$N(^UTILITY($J,DA,X,C)) Q:C<0  D O
 W ! W:$E(IOST)'="C" @IOF D CLOSE^DGUTQ G QUIT
 ;
C S DA=$E($P(^(0),U,9),6,9),DA=$E(DA,3,4)_$E(DA,1,2) Q:$P(X,U,9)="C"&($D(^UTILITY($J," "_DA,+X)))  S X=$P(X_"^^^^^",U,1,5) ;NAKED REFERENCE ^DPT(DFN,0)
 I $D(^DPT(+X,"S",D,0)) S SDAPTT=$P(^(0),U,16) I $P(^(0),U,2)["C" S X=X_"^***CANCELLED!***"
 S ^UTILITY($J," "_DA,+X,D)=C_U_X
 S $P(^UTILITY($J," "_DA,+X,D),U,8)=$S($D(^DPT(+X,.1)):^(.1),1:"")
 I $D(^DPT(+X,.36)),$D(^DIC(8,+^DPT(+X,.36),0)),$P(^(0),"^",9)=13 S $P(^UTILITY($J," "_DA,+X,D),U,9)="** COLLATERAL **" Q
 I SC="S",$P(^SC(C,SC,D,1,P,0),"^",10)]"" S V=$P(^(0),"^",10),V=$S($D(^DIC(8,+V,0)):$P(^(0),"^",9)=13,1:0) I V S $P(^UTILITY($J," "_DA,+X,D),U,9)="** COLLATERAL **"
 S $P(^UTILITY($J," "_DA,+X,D),U,10)=$S('$D(SDAPTT):"",$D(^SD(409.1,+SDAPTT,0)):$P(^(0),"^",4),1:"UNSPECIFIED")
 Q
 ;
O S Y=^(C) I $P(Y,U,8)]"",'SD1 S SD1=1 W ?48,"** WARD: ",$P(Y,U,8)," **",! ;NAKED REFERENCE ^UTILITY($J,DA,X,0)
 W ?40,$E($P(^SC(+Y,0),U,1),1,16),?53," " S T=$P(C,".",2)_"000" W:T $E(T,1,2),":",$E(T,3,4)
 W ?61,$P(Y,U,10)," TYPE",!
 I $P(Y,U,7)]"" W ?4,$P(Y,U,7),!
 I $P(Y,U,9)]"" W ?4,$P(Y,U,9),!
 Q
CHECK I $P(^SC(C,0),"^",3)="C",$S(DIV="":1,$P(^SC(C,0),"^",15)=DIV:1,1:0),$P(^SC(C,0),"^",3)="C",$S('$D(^SC(C,"I")):1,+^("I")=0:1,+^("I")>SDDT:1,+$P(^("I"),"^",2)'>SDDT&(+$P(^("I"),"^",2)'=0):1,1:0),$P(^(0),"^",17)'="Y"!$P(^(0),"^",21)'=0
 Q
QUIT K %,%DT,A,ALL,ANS,C,CC,D,DA,DIV,I,P,PGM,POP,SC,SDAPTT,SD1,SDDT,T,VAL,VAR,X,Y,Z,^UTILITY($J) Q

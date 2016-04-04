DICATT3 ;SFISC/COMPUTED FIELDS ;6MAY2009
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**76,118,1035**
 ;
 K DIRUT,DTOUT D COMP I $P(^DD(A,DA,0),U,2)["C" G N^DICATT
 S DTOUT=1 G CHECK^DICATT
 ;
COMP N DIR,DICOMPX,DISPEC,DICMIN,DIL,DIJ,DIE,DIDEC
 S DISPEC=$P($G(^DD(A,DA,0)),U,2)
 S DIR(0)="FU",DIR("A")="'COMPUTED-FIELD' EXPRESSION"
 I O,$D(^DD(A,DA,9.1)) S DIR("B")=^(9.1)
 S DIR("?")="^D DICATT3^DIQQ"
 D ^DIR Q:$D(DIRUT)
 I $D(DIR("B")),DIR("B")=Y G GETTYPE
 K DICOMPX S DICOMPX=""
 S DICMIN=Y,DQI="Y("_A_","_DA_",",DICMX="X DICMX",DICOMP="?I"
 D ^DICOMP I '$D(X) W $C(7),"  ...??" G 6
 I DUZ(0)="@" W !,"TRANSLATES TO THE FOLLOWING CODE:",!,X,!
 I Y["m" W !,"FIELD IS 'MULTIPLE-VALUED'!",!
 I O,$D(^DD(A,DA,9.01))!(DICOMPX]"") D ACOMP
 S DISPEC=$E("D",Y["D")_$E("B",Y["B")_"C"_$S(Y'["m":"",1:"m"_$E("w",Y["w"))_$S(Y["p":"p"_$S($P(Y,"p",2):+$P(Y,"p",2),1:""),1:"")_$S(Y'["B":"",1:"J1")
 S ^DD(A,DA,0)=F_U_DISPEC_"^^ ; ^"_X,^(9)=U,^(9.1)=DICMIN,^(9.01)=DICOMPX
 F Y=9.2:0 Q:'$D(X(Y))  S ^(Y)=X(Y),Y=$O(X(Y))
 K X,DICOMPX
GETTYPE K DIR S DIR(0)="SBA^S:STRING;N:NUMERIC;B:BOOLEAN;D:DATE;m:MULTIPLE;p:POINTER;mp:MULTIPLE POINTER"
 S DIR("A")="TYPE OF RESULT: "
 S DIR("B")=$P($E(DIR(0),$F(DIR(0),$$TYPE(DISPEC)_":"),99),";")
 D ^DIR I $D(DIRUT) G END
 S DISPEC=$TR(Y,"SN") I Y="B"!(Y="D") D P(Y) G END
 I Y["p" D POINT G END
 S DIJ="",DIE=$P($P(O,U,2),"J",2) F J=0:0 S N=$E(DIE) Q:N?.A  S DIE=$E(DIE,2,99),DIJ=DIJ_N
 S DIDEC=$P(DIJ,",",2),DIL=$S(DIJ:+DIJ,1:8) S:Y'="N" DIDEC=""
 I DISPEC["m" D P(DISPEC) G END
 D DEC:Y="N" I '$D(DIRUT) D LEN
END I O S DI=A D PZ^DIU0 Q
 D SDIK^DICATT22
6 Q  ;leave this here
 ;
 ;
DEC N DG,O,M
FRAC K DIR S DIR("A")="NUMBER OF FRACTIONAL DIGITS TO OUTPUT: "
 I DIDEC]"" S DIR("B")=DIDEC
 S DIR("?")="Enter the number of decimal digits that should normally appear in the result."
 S DIR(0)="NAO^0:14:0" D ^DIR Q:$D(DIRUT)  S DIDEC=Y
 S DG=" S X=$J(X,0,",M=$P(^DD(A,DA,0),DG),%=M_DG_DIDEC_")"'=^(0)+1
 W !,"SHOULD VALUE ALWAYS BE INTERNALLY ROUNDED TO ",DIDEC," DECIMAL PLACE",$E("S",DIDEC'=1)
 D YN^DICN G FRAC:'% Q:%'>0  S ^DD(A,DA,0)=M_$P(DG_DIDEC_")",U,%)
S S DQI="Y(",O=$D(^(9.02)),X=^(9.1) K DICOMPX,^(9.02) Q:'$D(^(9.01))
 F Y=1:1 S M=$P(^(9.01),";",Y) Q:M=""  S DICOMPX(1,+M,+$P(M,U,2))="S("""_M_""")",DICOMPX=""
 Q:Y<2  I X'["/",X'["\" Q:X'["*"  Q:Y<3
 D ^DICOMP Q:$D(X)-1
 S %=2-O W !,"WHEN TOTALLING THIS FIELD, SHOULD THE SUM BE COMPUTED FROM",!?7,"THE SUMS OF THE COMPONENT FIELDS" D YN^DICN
 I %=1 S ^DD(A,DA,9.02)=X_" S Y=X"
 S:%<1 DIRUT=1
 Q
 ;
LEN K DIR
 S DIR(0)="NAO^1::0",DIR("A")="LENGTH OF FIELD: ",DIR("B")=DIL
 S DIR("?")="Maximum number of character expected to be output."
 D ^DIR Q:$D(DIRUT)
 D P($P(DISPEC,"J")_"J"_Y_$E(",",DIDEC]"")_DIDEC_DIE) Q
 ;
POINT K DIR
 S DIR(0)="P^1:QEF",DIR("A")="POINT TO WHAT FILE"
 S DIR("S")="I $$OKFILE^DICOMPX(Y,""W"")"
 S X=$P($P(^DD(A,DA,0),U,2),"p",2) I 'X S X=$P($P(O,U,2),"p",2)
 I X,$D(^DIC(+X,0)) S DIR("B")=$P(^(0),U)
 D ^DIR I '$D(DIRUT) S $P(DISPEC,"p",2)=+Y D P(DISPEC)
 Q
 ;
P(C) S $P(^DD(A,DA,0),U,2)="C"_$TR(C,"C^") Q
 ;
ACOMP ;SET/KILL ACOMP NODES
 N X,I I $G(^DD(A,DA,9.01))]"" S X=^(9.01) X ^DD(0,9.01,1,1,2)
 I DICOMPX]"" S X=DICOMPX X ^DD(0,9.01,1,1,1)
 Q
 ;
TYPE(S) ;
 Q $S(S["D":"D",S["B":"B",S["mp":"mp",S["m":"m",S["p":"p",S'["J":"S",S[",":"N",1:"S") ;figure out TYPE OF RESULT

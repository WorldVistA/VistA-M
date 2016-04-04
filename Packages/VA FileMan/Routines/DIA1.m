DIA1 ;SFISC/GFT-PROCESS TEMPLATES, RANGES FOR INPUT ;22JUL2014
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**142,1050**
 ;
S D NOW^%DTC S DIADT=+$J(%,0,4) K %,DW G Q:DRS<5 R !,"STORE THESE FIELDS IN TEMPLATE: ",X:DTIME S:'$T DTOUT=1 G Q:X="" S DIC(0)="LZSEQ",DLAYGO=0 D T K DLAYGO,DIC I Y<0 G S:X'[U K DR G Q
 S X=$P(^(0),U,6) I DUZ(0)'["@",X]"" F %=1:1 I DUZ(0)[$E(X,%) Q:%'>$L(X)  W !?7,$C(7),"YOU HAVE NO 'WRITE ACCESS' TO THIS TEMPLATE",! G S
 S DW=$S('$D(^("ROU")):1,^("ROU")'[U:1,$D(^("ROUOLD")):^("ROUOLD"),1:1),%=0,X=$P(Y,U,2)
 I $O(^(0))]"" W $C(7),!,X_" TEMPLATE ALREADY EXISTS.... OK TO REPLACE" D YN^DICN W ! G S:%-1 L +^DIE(+Y) S %Y="" F %X=0:0 S %Y=$O(^DIE(+Y,%Y)) Q:%Y=""  K:",%D,ROUOLD,W,"'[(","_%Y_",") ^(%Y)
 S ^DIE(+Y,0)=X_U_DIADT_U_$S('%:DUZ(0),1:$P(Y(0),U,3))_U_DI_U_DUZ_U_$S('%:DUZ(0),1:$P(Y(0),U,6))_U_DT,^DIE("F"_DI,X,+Y)=1 L -^DIE(+Y)
M S %X="DR(",%Y="^DIE(+Y,""DR""," D %XY^%RCR M ^DIE(+Y,"DIAB")=^UTILITY($J)
 S X=DW,DP=DIA("P"),DMAX=^DD("ROU") I X'=1,$D(^DD("OS",DISYS,"ZS")) D EN^DIEZ S DR(1,DIA("P"))=U_DNM
Q K DNM,DIAO,DI,DIAP,%,%I,DIADT,DIAT,DIE,DMAX,%X,%Y Q
 ;
ALL ;Called by DIETED, DIA
 S %=DI,^UTILITY($J,1,F,%,DIAP\1000)="ALL" K DA D  G UP^DIA:F,S:$D(DRS) Q
 .N DIA1 S DIA1=DIARLVL D A
 ;
RANGE ;called by DIA, DIE17, DIETED
 N DIA1 S DIA1=F+1 S %=DI I X>0 S Y=X-.000001 G B
A S Y=0
B S DA="",X=0
G S DG=Y
DR S Y=$O(^DD(%,Y)) S:Y="" Y=-1 I $D(D(F)),Y'>0!(Y>D(F)) D DG:X Q
 I Y'>0 D DG:X S:$D(DR(DIA1,%))[0 DR(DIA1,%)=DA Q
 I $D(^(Y,0)),X X DIC("S") G G:$T D DG G DR
 X DIC("S") E  G DR
 S X=Y G G
 ;
DG S DA=DA_$E(";",1,$L(DA))_X_$P(":"_DG,U,X'=DG)
 S DQ=0 F  S DQ=$O(^DD(%,"SB",DQ)) Q:DQ=""  S DP=$O(^(DQ,0)) I DP'<X,DP'>DG S Y(F,DQ)=""
 S DQ=-1
Y S X=$O(Y(F,0)) I X>0 K Y(F,X) S DA(F)=DA,Y(F)=Y,%(F)=%,F=F+1,DIA1=DIA1+1,%=X D A S F=F-1,DIA1=DIA1-1,%=%(F),Y=Y(F),DA=DA(F) G Y
 S X="",DG=0 K DP Q
 ;
TEMP ;
 S DIC(0)="ZSEQ" D T K DIC Q:$D(DTOUT)  G DB:Y<0
 S %=$P(Y(0),U,6) G ED:DUZ(0)="@"!'$L(%) F X=1:1:$L(%) I DUZ(0)[$E(%,X) G ED
GT I $G(^("ROU"))[U S DR(1,DIA("P"))=^("ROU")
 E  S:$D(^("W")) DIE("W")=^("W") S %X="^DIE(+Y,""DR"",",%Y="DR(" D %XY^%RCR
 S $P(^DIE(+Y,0),U,7)=DT
 Q
 ;
T K DIC("W") S D="F"_DI,X=$P(X,"]",1),X=$P(X,"[",1)_$P(X,"[",2),DIC="^DIE(",DIC("S")="I $P(^(0),U,4)=DI"_$P(" S %=$P(^(0),U,3) F DW=1:1:$L(%) I DUZ(0)[$E(%,DW) Q",9,DUZ(0)'="@") G IX^DIC
 ;
ED I Y<1!$G(^DIE(+Y,"CANONIC")) G GT
 S %=2 W !,"WANT TO EDIT '",$P(Y,U,2),"' INPUT TEMPLATE" D YN^DICN G GT:%-1
 S DIE="^DIE(",DA=+Y,DR=".01;3;6" D ^DIE K DR I '$D(DA) S DB=0 G DB
 S:$D(^DIE(DA,"DR"))#2 ^("DR",1,J(0))=^("DR")
 S DIAA=DA,DRS=9,DIAT=$S($D(^DIE(DA,"DR",1,J(0))):^(J(0)),1:"")
 M DI=^DIE(DA,"DIAB")
 S F=0,(DIARTLVL,DB)=1,DIAO=0 F DXS=1:1 Q:'$D(DR(99,DXS))
DB S DI=J(0) G ^DIA

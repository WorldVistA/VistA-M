DIE ;SFISC/GFT,XAK-PROC.DR-STR ;14AUG2006
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**1,4,8,11,95,142,1005,1008,1023**
 ;
 N DG,DNM,DICRREC K DB I DIE S DIE=^DIC(DIE,0,"GL")
 Q:$D(@(DIE_DA_",-9)"))  Q:'$D(@(DIE_"0)"))  S U="^",DP=+$P(^(0),U,2) Q:$P($G(^DD($$FNO^DILIBF(DP),0,"DI")),U,2)["Y"&'$D(DIOVRD)&'$G(DIFROM)
GO Q:DIE?1"^DIA(".E  Q:DA'>0  K DE,DOV,DIOV,DIEC,DTOUT N DIEDA D
 . N %
 . F %=1:1 Q:'$G(DA(%))  S DIEDA(%)=DA(%)
 . S DIEDA=DA
 . Q
 I $D(DIETMP)[0 N DIETMP S DIETMP=$$GETTMP^DIKC1("DIE")
 N DIEFXREF,DIIENS,DIE1,DIE1N K DIEFIRE,DIEBADK,DIESP S DIIENS=$$IENS^DIKCU(DP,.DA)
 S DL=1,DIE1=1,D0=DA,DI=DP,DR(1,DP)=DR D INI I $E(DR)'="[" D DR^DIE17
 S DP=DI,DA=D0,(DQ,DIEL,DK,DP(0))=0 K DIC("S")
MR S DK=DK+1,DH=$P(DR,";",DK) I +DH=DH S (DI,DM)=DH G S:$D(^DD(DP,DI)),MR
 S DI=$P(DH,":",1) I 'DI G K:DI=0,PB
J I DH["//" S DE(DQ+1,0)=$P(DH,"//",2,9),DI=$P(DI,"//",1),DH=""
 G K:+DI=DI S DM=+DI,Y=$P(DI,DM,2,99),DI=DM G MR:Y=""!'$D(^DD(DP,DI,0)) S DQ=DQ+1,DZ=^(0),DIFLD(DQ)=DI
 S $P(DZ,U)=$$LABEL^DIALOGZ(DP,DI) ;PROMPT FIELD NAME
SPC F %=1:1 S DIESP=$P(Y,$C(126),%) Q:DIESP=""  D
 .I DIESP="d"!(DIESP="R") S $P(DZ,U,2)=$P(DZ,U,2)_DIESP Q
 .I DIESP="T"!(DIESP="t") S:$G(^DD(DP,DI,.1))]"" $P(DZ,U)=^(.1) Q
 .S $P(DZ,U)=DIESP,DQ(DQ,"CAPTION")=DIESP
 S:DH'[$C(126) DH=DH_$C(126) S DQ(DQ)=DZ K DZ G Y
 ;
K S DM=$P(DH,":",2),DM=$S(DM:DM,1:DI) I DI,$D(^DD(DP,DI)) G S
NX S DI=$O(^DD(DP,DI)) S:DI="" DI=-1 G MR:DI'>0,MR:DI>DM
S I DQ'<50,'$D(DE(DQ+1)) G H
 S DQ=DQ+1,DQ(DQ)=$$LABEL^DIALOGZ(DP,DI)_U_$P(^DD(DP,DI,0),U,2,99),DIFLD(DQ)=DI ;FIELD NAME
Y S Y=$P(DQ(DQ),"^",4),DG=$P(Y,";",1)
 ;Determine whether field has a xref defined in the Index file
 S DIEXREF=0 F  S DIEXREF=$O(^DD("IX","F",DP,DI,DIEXREF)) Q:'DIEXREF  I $P($G(^DD("IX",DIEXREF,0)),U) S DIEXREF=1 Q
 I $D(^DD(DP,DI,1))!($P(DQ(DQ),U,2)["a")!DIEXREF S DE=0,DB=DM,DM=0,DE(Y)=DQ K DIEXREF F DW=1:1 S DE=$O(^DD(DP,DI,1,DE)) Q:DE<1  S DE(Y,DW,1)=^(DE,1),DE(Y,DW,2)=^(2)
 I  S:DE="" DE=-1
 I $P(DQ(DQ),U,2)["a" S DE(Y,DW,2)="S DIIX=2_U_DIFLD(DE(DQ)) D AUDIT^DIET",DE(Y,DW,1)="S DIIX=3_U_DIFLD(DE(DQ)) D AUDIT^DIET",DE(Y)=DQ I ^DD(DP,DI,"AUDIT")="e" S DE(Y,DW,1)="I $D(DE(DE(DQ)))#2 "_DE(Y,DW,1)
 S Y=$P(Y,";",2) I DU'=DG S D="",DU=DG,@DC G M:Y=0,B:DU=" ",EQ:DW[0 S D=^(DG)
 I Y S:$P(D,"^",Y)]"" DE(DQ)=$P(D,"^",Y)
 E  S Y=$E(D,+$E(Y,2,9),$P(Y,",",2)) S:Y'?." " DE(DQ)=Y
EQ G MR:DI=DM,NX:DM S DM=DB K DB G D
 ;
INI K DIC("S") S DIC=DIE,DU=-1,DC="DW=$D("_DIE_DA_",DG))"
Q Q
 ;
 ;
MORE ;from ^DIE1
 D INI G MR:DI=DM,NX:DI'[U,MR:'$D(^DD(DP,+DI)) S %=$P(DI,U,2),DI=+DI S:%]"" DQ(DQ+1,"CAPTION")=% G S
 ;
 ;
JMP ;from ^DIE0
 D INI G J
 ;
PB I DH="" G D:$D(DR(DIE1,DP))<9 S:'$D(DOV) DOV=0,DR(DIE1,DP)=DR S DOV=$O(DR(DIE1,DP,DOV)) S:DOV="" DOV=-1 G D:DOV'>0 S DR=DR(DIE1,DP,DOV),DK=0 G MR
 G MR:DH?1"@".N I 'DQ G TEM:DH?1"[".E S:"Q"'=DH DQ=1,DQ(0,1)=DH G MR:$A(DH)-94 S DC=$P(DH,U,1,4) X $P(DH,U,5,999) D DIE1N G O^DIE0
E S DK=DK-1,(DI,DM)=1
D G DQ^DIED
 ;
H S DI=DI_U G D
 ;Multiple field
M S Y=$P(DQ(DQ),U,2)_U_DG G DC:DW<9
 I $D(DSC(+Y))#2,$P(DSC(+Y),"I $D(^UTILITY(",1)="" S D=DIEL+1 D D1 X DSC(+Y) S D=$O(^(0)) S:D="" D=-1 S @DC S DC=$O(^(DG,0)) S:DC="" DC=-1 G DE
 I $D(^(DG,0)) S D=$P(^(0),U,3,4) S:$P(^(0),U,2)'=$P(Y,U) $P(^(0),U,2)=$P(Y,U) ;HMMM
 E  S D=$O(^(0)) S:D="" D=-1
DE I D>0 S Y=Y_U_D I DP(0)-Y!($P(DP(0),U,2)-DK),$D(^(+D,0)) S DE(DQ)=$P(^(0),U) ;Default value if this isn't same multiple we were down in before
DC S DC=$P(^DD(+Y,0),U,4)_U_Y,%=DQ(DQ),Y=^(.01,0)
MUL I $P(Y,U,2)'["W" S DQ(DQ)=$P($$EZBLD^DIALOG(8042,$G(DQ(DQ,"CAPTION"),$$LABEL^DIALOGZ(+$P(%,U,2),.01))),": ")_U_1_$P(Y,U,2,99) D DIE1N G D ;MULTIPLE-FIELD LABEL
 I DQ>1 K DQ(DQ) G E:$D(DE(DQ,0)),H
 D
 .Q:DH'[$C(126)
 .N DIEA S DIEA=$P($P(DH,+DH,2),$C(126)) Q:DIEA=""!(DIEA="d")!(DIEA="R")
 .I DIEA="T"!(DIEA="t") S:$D(^DD(+$P(%,U,2),.01,.1)) DQ(DQ,"CAPTION")=^(.1) Q
 .S DQ(DQ,"CAPTION")=DIEA
DIWE S Y=$G(DQ(DQ,"CAPTION"),$$LABEL^DIALOGZ(DP,DI))_U_$P(Y,U,2) D DIEN^DIWE K DQ,DG,DE S DQ=0 G QY^DIE1:$D(DTOUT) G MORE ;WORD-PROCESSING FIELD LABEL
 ;
D1 Q:D'>0  S:'$D(@("D"_D)) @("D"_D)=0 S D=D-1 G D1
 ;
DIE1N N M,I S DIE1N="" F I=DK,DK+1 S M=$P(DR,";",I) I M?1"^"1.NP S DIE1N=$P(M,U,2) S:I>DK DK=DK+1 Q  ;WPB-0804-30857
 Q
 ;
 ;
B K DQ(DQ) S DQ=DQ-1,DU=-9 G EQ
 ;
TEM K:$D(DIETMP)#2 @DIETMP,DIETMP
 S Y=0 F  S Y=$O(^DIE("B",$P($E(DR,2,99),"]"),Y)) G Q:Y="",Q:'$D(^DIE(+Y,0)) Q:$P(^(0),U,4)=DP
 S $P(^(0),U,7)=DT I $G(^("ROU"))[U,$$ROUEXIST^DILIBF($P(^("ROU"),U,2)) G @^DIE(+Y,"ROU")
 S:$D(^("W")) DIE("W")=^("W") S DIE("^")=DR K DR S %X="^DIE(+Y,""DR"",",%Y="DR(" D %XY^%RCR
 S DR=$G(^DIE(Y,"DR"),DR(1,DP)) D DIE K DR S DR=DIE(U)
 Q
 ;
 ;Silent call concerning editing and filing of data.
 ;
FILE(DIEFFLAG,DIEFAR,DIEFOUT) ;
 G FILEX^DIEF
 ;
WP(DIEFF,DIEFIEN,DIEFFLD,DIEFWPFL,DIEFTSRC,DIEFOUT) ;
 G WPX^DIEFW
 ;
HELP(DIEHF,DIEHIEN,DIEHFLD,DIEHFLG,DIEHOUT) ;
 G GETX^DIEH
 ;
VAL(DIEVF,DIEVIEN,DIEVFLD,DIEVFLG,DIEVAL,DIEVANS,DIEVFAR,DIOUTAR) ;
 G VALX^DIEV
 ;
KEYVAL(DIVKFLAG,DIVKFDA,DIVKOUT) ;
 G KEYVALX^DIEVK
 ;
VALS(DIVSFLAG,DIVSEFDA,DIVSIFDA,DIVSMSG) ;
 G VALSX^DIEVS
 ;
CHK(DIEVF,DIEVFLD,DIEVFLG,DIEVAL,DIEVANS,DIOUTAR) ;
 G CHKX^DIEV
 ;
UPDATE(DIFLAGS,DIFDA,DIEN,DIMSGA) ;SEA/TOAD
 ; ENTRY POINT--update database
 ; procedure, all passed by value
 G ADDX^DICA
 ;

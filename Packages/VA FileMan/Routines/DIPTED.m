DIPTED ;SFISC/GFT-EDIT PRINT TEMPLATE ;2013-07-10  2:34 PM
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**97,160,1045**
 ;
 N DIC,DIPT,DIPTED,DRK,DIPTEDTY,I,J
 S DIC=.4,DIC(0)="AEQ",DIC("S")="I $P(^(0),U,8)=7!'$P(^(0),U,8)" D ^DIC Q:Y<1
 K DIC
 S DIPT=+Y D E
 D PUT
K K ^TMP("DIPTED",$J),^UTILITY("DIP2",$J)
 Q
 ;
EDIT(DIPT) ; EDIT PRINT TEMPLATE 'DIPT' VIA VA FILEMAN SCREEN EDITOR
 N DIPTED,DRK,DIPTEDTY,I,J
E N DA,D0,DUOUT,DTOUT,DIPTEDER,DIPTH,L,DY,Y,DIPTX,D,C,Q,DIPTROW,DCL,DXS,DNP,DHD,DISH,DV,DJ,DL,DK,DIL
 D:'$D(DISYS) OS^DII X ^DD("OS",DISYS,"EON")
 I '$D(^DIPT(DIPT,0)) W !,"NO TEMPLATE SELECTED",! Q
 S DIPTED="Print",DIPTEDTY=$P(^(0),U,8) I DIPTEDTY=7 S DIPTED="EXPORT FIELDS"
 S DIPTED=DIPTED_" Template """_$P(^(0),U)_""""
 D GET("^TMP(""DIPTED"",$J)")
 S DIPTH="Editing "_DIPTED,DIPTROW=1
DDW D EDIT^DDW("^TMP(""DIPTED"",$J)","M",DIPTH,"(File "_DRK_")",DIPTROW)
 K ^UTILITY($J,0),^UTILITY("DIP2",$J),I,J
 I $D(DTOUT)!$D(DUOUT) K ^TMP("DIPTED",$J) W $C(7),$$EZBLD^DIALOG(8077) Q
 S (DV,DNP)="",(DIL,DJ)=0,(DL,DXS)=1,DK=DRK,J(0)=DK,I(0)=^DIC(DK,0,"GL")
 D PROCESS("^TMP(""DIPTED"",$J)")
 X ^DD("OS",DISYS,"EON")
 S DIPTROW=$O(DIPTEDER(0)) I DIPTROW W " ",DIPTEDER(DIPTROW) H 2 S DIPTH="ERROR!  Re-editing "_DIPTED K DIPTEDER G DDW
 I '$D(^UTILITY("DIP2",$J)) W "<NOTHING TO SAVE>",$C(7) G K
 S DDSCHG=1
 I $D(DXS)>9 M ^UTILITY("DIP2",$J,U,"DXS")=DXS
 M ^UTILITY("DIP2",$J,U,"DCL")=DCL
 I $D(DNP) S ^UTILITY("DIP2",$J,U,"DNP")=1
 I $G(DISH) S ^("SUB")=1
 I $G(DHD)]"" S ^("H")=DHD
 Q
 ;
GET(DIPTA,DIT) ;put displayable template into @DIPTA
 N DS,DIWD,D9,D0
 K @DIPTA
 I '$D(DIT) S DIT=$NA(^DIPT(DIPT)),D0=DIPT
 E  S D0=-1
 S (DRK,J(0))=$P(@DIT@(0),U,4),L=0,D(L)="0FIELD",C=",",D9="",Y=2,Q="""",DHD=$G(^("H")),DISH=$D(^("SUB"))
 F DS(1)=0:0 S DS(1)=$O(@DIT@("F",DS(1))) Q:DS(1)=""  S DY=^(DS(1)) D Y^DIPT
 D:D9]"" UP^DIPT
 F D=2:1 Q:'$D(DS(D))  S @DIPTA@(D-1)=$J("",D>2*$E($G(DIWD(D)))*3)_DS(D) ;indentation showing level of subfiles
 Q
 ;
PROCESS(DIPTA) ;puts nodes into ^UTILITY("DIP2")
 N D0,DM,DQI,DA,ERR,P,S,LINE,X,DIETAB
 S DIETAB=0
 F LINE=1:1 Q:'$D(@DIPTA@(LINE))  K ERR S X=^(LINE) D
 .I X?1"^".E S LINE=999999999 K ^UTILITY("DIP2",$J) Q
 .S X=$$LINE(X) I X]"" S ^($O(^UTILITY("DIP2",$J,""),-1)+1)=X Q
 .I $D(ERR) W "LINE ",LINE S DIPTEDER(LINE)=ERR,LINE=-LINE Q  ;stop if we find one error
 I LINE<0 W " ERROR!" Q
 Q
 ;
LINE(X) ;returns X as component of Template.  DD number is currently 'DK'
 N DIC,DICMX,DATE,Y,DICOMPX,DICOMP,DP,DJ
 I X?." " Q ""
 F P=$L(X):-1:1 Q:$A(X,P)>32  S X=$E(X,1,P-1) ;strip off trailing spaces
 F P=0:1  Q:$A(X)-32  S X=$E(X,2,999) ;strip off 'P' leading spaces
 I P<DIETAB,DL>1 F  D U I DL-1*3'>P Q  ;pop Up (MAYBE SEVERAL LEVELS) if we find outdentation
 S DIETAB=P
F S (P,S)=""
LIT I $E(X)="""",$L(X,"""")#2 F I=3:2:$L(X,"""") Q:$P(X,"""",I)]""&($E($P(X,"""",I)'=$C(95)))
 I  I $P($P(X,"""",I),";")="" G DJ
 S DIC="^DD(DK,",DIC(0)="ZO"
DIC I X="NUMBER" S Y=0 G S
 D ^DIC G GF:Y>0
 I X="" D U:DL>2 Q X
STRIP I DIPTEDTY-7 D  G:'$D(D) DIC S X=$RE(X) D  S X=$RE(X) G:'$D(D) DIC ;from beginning, then end
 .F D="+","#","*","&","!" I $E(X)=D S P=D,X=$E(X,2,999) K D Q
 I X[";" G EXP:DIPTEDTY=7 S S=";"_$P(X,";",2,99)_S,X=$P(X,";") G DIC
HARD S DM=X,DQI="DIP(",DA="DXS("_DXS_C,S=S_";Z;"""_X_"""",DICOMP=DIL_$E("?",''L)_"TI",DICOMPX=""
 I X'?.E1":" S DICMX="X DICMX" D EN^DICOMP G QQ:'$D(X) D FLY^DIP22 S X=S G DJ
 G EXP:DIPTEDTY=7 S DICMX="S DIXX=DIXX("_DL_") D M" D ^DICOMPW
 I $D(X) D  S S=U_$P(DP,U,2)_U_$E(1,Y["m")_U_S,DIL(DL)=DIL,DV(DL)=DV,DL(DL)=DK,DK=+DP,DV=DV_-DP_C,DL=DL+1,DIL=+Y,Y=0,X=DV_S K P G VAL3 ;relational jump
 .N Y D OVFL^DIP22,F^DIP22
QQ S ERR="" Q ""
 ;
GF I $P(Y(0),U,2) D D S X=$P($P(Y(0),U,4),";"),I(DIL)=$S(+X=X:X,1:Q_X_Q),J(DIL)=DK G WORD:$P($G(^DD(DK,.01,0)),U,2)["W" Q "" ;down to a multiple
 I +Y=.001 S Y=0
S S X=+Y_S
DJ S X=DV_X
VAL3 I DIPTEDTY'=7!(S'[";W"&(S'[";m")) S S="" D P Q X
EXP S ERR="NOT ALLOWED WHEN SELECTING EXPORT FIELDS" Q ""
 ;
P D:$D(P)  Q
 .I P="" K DNP Q
 .I P="*" S DCL=$G(DCL)+1
 .S DCL(DK_U_+Y)=$S($T:DCL_P,1:P)
 ;
D S DIL(DL)=DIL,DV(DL)=DV,DL(DL)=DK,DK=+$P(^DD(DK,+Y,0),U,2),DL=DL+1,DIL=DIL+1,DV=DV_+Y_C,Y=0 Q  ;go Down a level
 ;
WORD I DIPTEDTY=7 G EXP
 S Y=.01 D P S X=DV_Y_S D U Q X
 ;
U S DL=DL-1,DV=DV(DL),DK=DL(DL),DIL=DIL(DL) F %=DIL:0 S %=$O(I(%)) Q:%=""  K I(%),J(%)
 Q
 ;
SAVEFLDS(Y) ;POST-SAVE OF 'DIPTED' SCREENMAN FORM
 N DMAX,J,X
 Q:'$D(^UTILITY("DIP2",$J))!'$G(Y)
CLEAR S $X=0,$Y=0 I $G(IOXY)]"" N DX,DY S (DY,DX)=0 X IOXY W $C(27,91,74)
 S Y=$$CLONE(Y) Q:'Y  ;ASK 'SAVE AS'
 D NOW^%DTC S $P(^DIPT(Y,0),U,2)=+$J(%,0,4)
 S $P(^DIPT(Y,0),U,5)=$G(DUZ)
 K ^DIPT(Y,"F") S J="" D  D J
 .F %=1:1 Q:'$D(^UTILITY("DIP2",$J,%))  S X=^(%) I X]"" D
 ..I $L(J)+$L(X)>150 D J S J=""
 ..S J=J_X_$C(126)
 K ^DIPT(Y,"DXS"),^("DCL"),^("DNP")
 M ^DIPT(Y)=^UTILITY("DIP2",$J,U)
 I $D(^DIPT(Y,"ROU")) K ^("ROU") I $D(^("IOM")) S IOM=^("IOM") K ^("IOM") I $D(^("ROUOLD")) S X=^("ROUOLD") I X]"",$G(DISYS),$D(^DD("OS",DISYS,"ZS")) S DMAX=^DD("ROU") D ENZ^DIPZ I $D(^DIPT(DIPZ,"H")) S DHD=^("H")
 D K
 Q
 ;
J S ^($O(^DIPT(+Y,"F",""),-1)+1)=J Q
 ;
CLONE(DA) ;
 N DIC,DIPTEDTY,DIPTEDFI,X,Y,DIPTEDNM,DDS
 I '$D(^DIPT(DA,0)) Q 0
 S (DIPTEDNM,DIC("B"))=$P(^(0),U)
ASK S DIPTEDFI=$P(^DIPT(DA,0),U,4),DIPTEDTY=$P(^(0),U,8) I 'DIPTEDFI Q 0
 S DIC=.4,DIC("A")="Save revised Print Template "_DIPTEDNM_" as: ",DIC(0)="AEQL",DIC("S")="I $P(^(0),U,4)=DIPTEDFI,$P(^(0),U,8)=DIPTEDTY"
 D ^DIC I Y<0 Q 0
 I +Y=DA Q DA
 I $O(^DIPT(+Y,0))]"" W !,$C(7),"Are you sure you want to overwrite this '",$P(Y,U,2),"' Template" S %=1 D YN^DICN I %-1 K DIC G ASK:%=2 Q 0
 L +^DIPT(+Y):5 E  W !,$C(7),"Sorry. Another user is editing this template." Q 0
 S ^DIPT("F"_DIPTEDFI,$P(Y,U,2),+Y)=1
 S $P(^DIPT(+Y,0),U,4)=DIPTEDFI,$P(^(0),U,8)=DIPTEDTY
 L -^DIPT(+Y)
 Q +Y
 ;
 ;
PUT ;save template from ^UTILITY
 I '$D(^UTILITY("DIP2",$J)) Q
 N DIC,DIPZ
 S DIC("B")=DIPT
SAVEAS S DIC=.4,DIC("A")="Save revised "_DIPTED_" as: ",DIC(0)="AEQL",DIC("S")="I $P(^(0),U,4)=DRK,$P(^(0),U,8)=DIPTEDTY"
 D ^DIC
 Q:Y<0  I $O(^DIPT(+Y,0))]"" W !,$C(7),"Are you sure you want to overwrite this '",$P(Y,U,2),"' Template" S %=1 D YN^DICN I %-1 Q:%<2  K DIC("B") G SAVEAS
 L +^DIPT(+Y):5 E  W !,$C(7),"Sorry. Another user is editing this template." Q
 S ^DIPT("F"_J(0),$P(Y,U,2),+Y)=1
 S $P(^DIPT(+Y,0),U,4)=J(0),$P(^(0),U,8)=DIPTEDTY
 L -^DIPT(+Y)
 D SAVEFLDS(+Y)
 Q

DIPZ ;SFISC/XAK,TKW-COMPILE PRINT TEMPLATES ;3FEB2011
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**163,1041**
 ;
 I $G(DUZ(0))'="@" W:$D(^DI(.84,0)) $C(7),$$EZBLD^DIALOG(101) Q
EN1 N DNM,X,Y,Z D K I '$D(DISYS) N DISYS D OS^DII
 I '$D(^DD("OS",DISYS,"ZS")) W $C(7),$$EZBLD^DIALOG(820) Q
 S DTIME=$S('$D(DTIME):300,1:DTIME)
 D SIZ^DIPZ0(8034) G:$D(DTOUT)!$D(DUOUT)!'X K S DMAX=X
TEM K DIC S DIC="^DIPT(",DIC(0)="AIEQ"
 S DIC("W")="W ?40,""FILE #"",$P(^(0),U,4) W:$D(^(""ROU"")) ?60,^(""ROU"")"
 S DIC("S")="I $D(^(""F""))>9,'$P(^(0),U,8),Y'<1" D ^DIC G K:Y<0
 S DIPZ=+Y
 D RNM^DIPZ0(8034) G:$D(DTOUT)!($D(DUOUT))!(X="") K S DNM=X K DIC
IOM K DIR S DIR("B")=$G(^DIPT(DIPZ,"IOM")) K:'DIR("B") DIR
 S DIR(0)="N^19:255",DIR("A")=$$EZBLD^DIALOG(8022) D BLD^DIALOG(8023,"","","DIR(""?"")")
 D ^DIR K DIR G:$D(DTOUT)!($D(DUOUT))!'X K S IOM=X
 W ! S DIR(0)="Y",DIR("A")=$$EZBLD^DIALOG(8020) D ^DIR K DIR G K:'Y!($D(DIRUT))
 S X=DNM,Y=DIPZ D ENZ
K K DMAX,DIC,DCL,R,M,DE,DI,DPP,DIPZ,DHD,DIWL,DIWR,DK,DP,DNP,DCL,DITTO,DUOUT,DIRUT,DIROUT,DTOUT
 K %,%H,I,O,C,D,DD,DHT,DIL0,DIP,DN,DU,F,H,L,N,S,Q,CP,DINC Q
 ;
EN ;
 Q:'$D(^DIPT(Y,"IOM"))!($P($G(^DIPT(Y,0)),U,8))  S IOM=^("IOM") D ENZ G K
 ;
ENZ S (R,DCL,DPP)=0 F %=0:0 S R=$O(^DIPT(+Y,"DCL",R)) Q:R=""  F %=1:1 Q:%>$L(^(R))  S Z=$E(^(R),%) I Z?1P S DCL(R)=$G(DCL(R))_Z
ENDIP ;
 W:'$G(DIPZS) ! K ^UTILITY($J),^("DIL",$J),^UTILITY("DIPZ",$J),DIPZ,DNP,DIPZLR,DRN,DIPZL,DX,DXS,R N DIPZQ S DIPZQ=0 D DELETROU^DIEZ(X)
 S DNM=X,DIPZ=+Y,DRD=0,DP=$P(^DIPT(DIPZ,0),U,4),DHD=$S(^("H")="@":"@",1:3) S:$D(^("DNP")) DNP=1
 S DK=^DIC(DP,0,"GL"),DMAX=DMAX-$S($D(DCL)>9:1600,1:1300),DRN=0,R="",L=0,DINC=1
 I '$D(@(DK_"0)")) Q  ;THE DATA FILE MAY BE GONE
 I '$D(IOM) Q:$D(^DIPT(DIPZ,"IOM"))[0  S IOM=^("IOM")
AF D DT^DICRW,INIT^DIP5 S X=-1
 S T(1)=$P(^DIPT(DIPZ,0),U),T(2)=$$EZBLD^DIALOG(8034),T(3)=DP D BLD^DIALOG(8024,.T,"","DIR")
 W:'$G(DIPZS) !,DIR K DIR
 F T=0:0 S X=$O(^DIPT("AF",X)) Q:X=""  F %=0:0 S %=$O(^DIPT("AF",X,%)) Q:'%  K:$D(^(%,DIPZ)) ^(DIPZ)
 F C=1:1 Q:'$D(^DIPT(DIPZ,"DXS",C,9.2))&'$D(^(9))  D DXS S:DIDXS DXS(C)=""
 S DL=1,DIPZL=0,DHT=-1,C=",",Q="""",^UTILITY($J,1)=""
 F DIP=-1:0 S DIP=$O(^DIPT(DIPZ,"F",DIP)) Q:DIP=""  S R=^(DIP) D ^DIL
 D UNSTACK^DIL:DM,A^DIL,T^DIL2 K ^DIPT(DIPZ,"T") F R=-1:0 S R=$O(^UTILITY($J,"T",R)) Q:R=""  S ^DIPT(DIPZ,"T",R)=^(R)
 S DX=DX+999,Y=$P(" D ^DIWW",1,''$D(DIWR))_" K Y" I DIWL S Y=Y_" K DIWF" S:DIWL=1 ^UTILITY("DIPZ",$J,.5)=" S DIWF=""W"""
 D PX^DIPZ1 G ^DIPZ2
DXS S DIDXS=1
 I $D(^DIPT(DIPZ,"DXS",C,9)) S X=^(9) D ^DIM I '$D(X) S DIDXS=0
 Q
 ;
EN2(Y,DIPZFLGS,X,DMAX,DIPZRLA,DIPZZMSG) ;Silent or Talking with parameter passing
 ;and optionally return list of routines built and if successful
 ;IEN,FLAGS,ROUTINE,RTNMAXSIZE,RTNLISTARRAY,MSGARRAY
 ;Y=TEMPLATE IEN (required)
 ;FLAGS="T"alk (optional)
 ;X=ROUTINE NAME (required)
 ;DMAX=ROUTINE SIZE (optional)
 ;DIPZRLA=ROUTINE LIST ARRAY, by value (optional)
 ;DIPZZMSG=MESSAGE ARRAY (optional) (default ^TMP)
 ;*
 ;DIPZS will be used to indicate "silent" if set to 1
 ;Write statements are made conditional, if not "silent"
 ;*
 N DIPZS,DNM,DIQUIET,DIPZRIEN,DIPZRLAZ,Z,DIPZRLAF
 N DIK,DIC,%I,DICS
 S DIPZS=$G(DIPZFLGS)'["T"
 S:DIPZS DIQUIET=1
 I '$D(DIFM) N DIFM S DIFM=1 D
 .N Y,DIPZFLGS,X,DMAX,DIPZRLA,DIPZS
 .D INIZE^DIEFU
 I $G(Y)'>0 D BLD^DIALOG(1700,"IEN for Print Template missing or invalid") G EN2E
 I '$D(^DIPT(Y,0)) D BLD^DIALOG(1700,"No Print Template on file with IEN="_Y) G EN2E
 I $G(^DIPT(Y,"IOM"))'>0 D BLD^DIALOG(1700,"No Margin Width for Print Template, IEN="_Y) G EN2E
 I $P($G(^DIPT(Y,0)),"^",8) D BLD^DIALOG(1700,"Print Template Invalid, IEN="_Y) G EN2E
 I $G(X)']"" D BLD^DIALOG(1700,"Routine name missing this Print Template, IEN="_Y) G EN2E
 I X'?1U.NU&(X'?1"%"1U.NU) D BLD^DIALOG(1700,"Routine name invalid") G EN2E
 I $L(X)>7 D BLD^DIALOG(1700,"Routine name too long") G EN2E
 S DIPZRLA=$G(DIPZRLA,"DIPZRLAZ"),DIPZRIEN=Y
 S:DIPZRLA="" DIPZRLA="DIPZRLAZ" S:$G(DMAX)'>0!($G(DMAX)>^DD("ROU")) DMAX=^DD("ROU")
 S DIPZRLAF=""
 K @DIPZRLA
 D EN
 G:'DIPZS!(DIPZRLAF) EN2E
 D BLD^DIALOG(1700,"Compiling Print Template (IEN="_DIPZRIEN_")"_$S(DIPZRLAF=0:", routine name too long",1:""))
EN2E I 'DIPZS D MSG^DIALOG() Q
 I $G(DIPZZMSG)]"" D CALLOUT^DIEFU(DIPZZMSG)
 Q
 ;
 ;DIALOG #101    'only those with programmer's access'
 ;       #820    'no way to save routines on the system'
 ;       #8020   'Should the compilation run now?'
 ;       #8022   'Margin Width for output.'
 ;       #8023   'Type a number from 19 to 255.  This is the number...'
 ;       #8024   'Compiling template name Print template of file n'
 ;       #8034   'Print template'

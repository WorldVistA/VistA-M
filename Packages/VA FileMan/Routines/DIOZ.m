DIOZ ;SFISC/TKW - COMPILED SORT TEMPLATE ; 30NOV2012
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
ENCU ;MARK A SORT TEMPLATE FOR ROUTINE COMPILATION
 I $G(DUZ(0))'="@" W !,$C(7),$$EZBLD^DIALOG(101) Q
EN1 N DDH,DIC,DIR,DIROUT,DIRUT,DUOUT,DTOUT,X,Y,DIOZ
 ; NB: next 2 lines same in ENC. Need to make shared.
 D OS^DII:'$D(DISYS)
 I $G(^DD("OS",DISYS,"ZS"))="" D BLD^DIALOG(820) G QSV
 D DIC Q:Y<0  S DIOZ=+Y
 S DIR(0)="Y"
 I $G(^DIBT(+Y,"ROU"))="" D  Q
 .D BLD^DIALOG(8029,$$EZBLD^DIALOG(8035),"","DIR(""A"")")
 .S DIR("B")="YES" D BLD^DIALOG(9014,"","","DIR(""?"")"),^DIR Q:'Y
 .S ^DIBT(DIOZ,"ROU")="^DISZ",^("ROUOLD")="DISZ"
 .W !!,$C(7),DIR("?",2),!,DIR("?")
 .Q
 S X(1)=$$EZBLD^DIALOG(8035),X(2)="DISZ" D BLD^DIALOG(8028,.X,"","DIR(""A"")")
 S DIR("B")="NO" D BLD^DIALOG(9019,"","","DIR(""?"")"),^DIR Q:'Y
 K ^DIBT(DIOZ,"ROU")
 W !!,$C(7),DIR("?",2),!,DIR("?")
 Q
 ;
DIC S DIC="^DIBT(",DIC(0)="AEIQ",DIC("W")="W ?40,""FILE #"",$P(^(0),U,4) W:$D(^(""ROU"")) ?60,""Compiled"""
 S DIC("S")="I '$P(^(0),U,8),Y'<1,$O(^DIBT(+Y,2,0))"
 D ^DIC Q
 ;
ENC ;CREATE COMPILED SORT ROUTINE
 ; NB: next 2 lines same in EN. Need to make shared.
 D OS^DII:'$D(DISYS)
 I $G(^DD("OS",DISYS,"ZS"))="" D BLD^DIALOG(820) G QSV
 I $O(^TMP("DIBTC",$J,""))="" D BLD^DIALOG(1501) G QSV
 N %,%H,%I,DIROUT,DIRUT,DTOUT,DUOUT,DRN,I,J,K,X,Y,DIR
 D NEW G:$D(DIERR) QSV
 S K=2,I="" F  S I=$O(^TMP("DIBTC",$J,I)) Q:I=""  F J=0:0 S J=$O(^TMP("DIBTC",$J,I,J)) Q:'J  S X=^(J) I X]"" S K=K+1,^UTILITY($J,0,K)=X
 F I=1:1 S X=$P($T(TXT+I),";",3) Q:X=""  S K=K+1,^UTILITY($J,0,K)=X
 S X=$P(DIBTPGM,U,2) X ^DD("OS",DISYS,"ZS")
 K ^TMP("DIBTC",$J)
 Q
 ;
NEW I DIBTPGM'?1"^"1.7U1.4N D NXTNO(.DRN) Q:$D(DIERR)  S DIBTPGM=DIBTPGM_$E("000",1,(4-$L(DRN)))_DRN
 D NOW^%DTC,YX^%DTC
 K ^UTILITY($J,0)
 S ^UTILITY($J,0,1)=$P(DIBTPGM,U,2)_" ; GENERATED FROM '"_$P(^DIBT(DIBT1,0),U,1)_"' SORT TEMPLATE (#"_DIBT1_"), FILE:"_DP_",  USER:"_$S($G(^VA(200,+DUZ,0))]"":$P(^(0),U),1:$P($G(^DIC(3,+DUZ,0)),U))_" ; "_Y
 S ^UTILITY($J,0,2)=$T(DIOZ+1)
 Q
 ;
NXTNO(DRN) ; GET NEXT AVAILABLE ROUTINE NUMBER
 N DILOCK S DRN=0 D  Q:DRN
N1 . S DILOCK=0,DRN=$O(^DI(.83,"C","n",DRN)) Q:'DRN  D N3 G:DILOCK N1
N2 S DILOCK=0,DRN=$$NXTNO^DICLIB("^DI(.83,","","U") I DRN>9999 D BLD^DIALOG(1502) Q
 D N3 G:DILOCK N2
 Q
N3 L +^DI(.83,DRN,0):10 I '$T S DILOCK=1 Q
 S ^DI(.83,DRN,0)=DRN_"^y",^DI(.83,"B",DRN,DRN)="",^DI(.83,"C","y",DRN)="" K ^DI(.83,"C","n",DRN) L -^DI(.83,DRN,0) Q
 Q
 ;
ENRLS(DRN) ; MAKE ROUTINE NUMBER AVAILABLE FOR REUSE & DELETE ROUTINE
 N DICLEAN,X S DRN=+$G(DRN),DICLEAN='DRN G:DRN R1
R S DRN=$O(^DI(.83,DRN)) Q:'DRN
R1 I $G(^DI(.83,DRN,0))]"" S $P(^(0),U,2)="n",^DI(.83,"C","n",DRN)="" K ^DI(.83,"C","y",DRN)
 S X="DISZ"_$E("000",1,(4-$L(DRN)))_DRN X $G(^DD("OS",DISYS,"DEL"))
 G:DICLEAN R
 Q
 ;
QSV D:$G(DRN) ENRLS(DRN) K DIBTPGM
QER Q:$G(DIQUIET)
 D MSG^DIALOG("W") S DIERR=1 Q
 ;
 ;DIALOG #101    'only those with programmer's access'                 
 ;       #820    'no way to save routines on the system'               
 ;       #1501   'There is no code to save for this compiled...'
 ;       #1502   'All available routine numbers...are in use...'
 ;       #8028   '...currently compiled under namespace...'
 ;       #8029   '...not currently compiled.'
 ;       #8035   'Sort template'
 ;       #9014   (help) 'if YES...Sort logic will be compiled...'
 ;       #9019   (help) 'if YES...Sort logic...will NOT be compiled...' 
 ;
TXT ;;
 ;;M X $S($D(DPQ):DX(DIXX),1:^UTILITY($J,99,DIXX))

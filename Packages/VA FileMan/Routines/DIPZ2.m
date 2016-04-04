DIPZ2 ;SFISC/GFT,XAK-COMPILE PRINT TEMPLATES ;07:33 PM  16 Dec 1999
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**999**
 ;
 F R=0:0 S R=$O(DXS(R)),W="" Q:'R  K:$D(DXS(R))>9 ^DIPT(DIPZ,"DXS",R) F R=R:0 S W=$O(DXS(R,W)) Q:W=""  S ^DIPT(DIPZ,"DXS",R,W)=DXS(R,W)
 S DIPZLR=DRN,DRN="",DIL=0 D NEW
DXS I $D(^DIPT(DIPZ,"DXS")) S X=" I $D(DXS)<9 M DXS=^DIPT("_DIPZ_",""DXS"")" D L
 S X=" S I(0)="""_$$CONVQQ^DILIBF(DK)_""",J(0)="_DP D L
DIL S DIL=$O(^UTILITY("DIPZ",$J,DIL)) G DHD:'DIL
 S DHT=^(DIL) I DRN<DIPZLR,DIL>DRN(+DRN) D SAVE G:DIPZQ K
 S X=DHT D L G DIL
 ;
DHD F F=2.9:0 S F=$O(^UTILITY($J,F)) Q:'F  S DIL=$L(^(F))+DIL
 I DIL+DIPZL>DMAX D SAVE G:DIPZQ K
 S X=" Q" D L S X="HEAD ;" D L F F=2.9:0 S F=$O(^UTILITY($J,F)) Q:'F  S X=" "_^(F) D L
 S X=" W !,""" F %=1:1 S X=X_"-" I %=IOM!(%>239) S X=X_""",!!" D L Q
END D SAVE G:DIPZQ K
EGP S ^DIPT(DIPZ,"ROUOLD")=DNM,^("IOM")=IOM,^("ROU")=U_DNM,^("LAST")=$S(DRN>1:DRN-1,1:""),DM=0,F="" I $G(DUZ("LANG")) S ^("ROULANG")=DUZ("LANG") ;**CCO/NI REMEMBER LANGUAGE
 K ^("STATS"),DXS F DIP="L","H","DITTO","CP","Q","N","S" I $D(@DIP)>9 S %X=DIP_"(",%Y="^DIPT(DIPZ,""STATS"",DIP," D %XY^%RCR
 F DIP=-1:0 S DIP=$O(^DIPT(DIPZ,"F",DIP)) Q:DIP=""  S R=^(DIP) W:'$G(DIPZS) "." D R
K K ^UTILITY($J),^("DIPZ",$J),DIPZL,DISMIN,%X,%Y,DG,DIL,DLN,DL,DM,DMAX,DNM,DRD,DRJ,DIO,DX,DY,DRN,DIPZLR,V,R,W,Y,T,DIDXS,DINC
 Q
 ;
R Q:R=""  S W=$P(R,$C(126),1),R=$P(R,$C(126),2,999)
DM I DM G UP:$P(W,F,1)]"" S W=$P(W,F,2,999)
 I 'W S:W?1"0".E ^DIPT("AF",DP,.001,DIPZ)="" G R
 I $P(W,";",1)=+W S ^DIPT("AF",DP,+W,DIPZ)="" G R
 G R:W'?.NP1",".E I W<0 S X=-W G DOWN
 G R:'$D(^DD(DP,+W,0)) S X=+$P(^(0),U,2) G R:'X
DOWN S DM=DM+1,DP(DM)=DP,DP=X,F=F_+W_C G DM
UP S DP=DP(DM),DM=DM-1,F=$P(F,C,1,DM)_$E(C,DM>0) G DM
 ;
SAVE ;
 S L=1.001,DINC=.001 S X=" G BEGIN" D L,OS^DII:'$D(DISYS) F %=$S($D(DCL)>9:1,0'[DCL:7,1:10):1 S X=$E($T(TEXT+%),4,999) Q:X=""  D L
 I $L(DNM_DRN)>8 S DIPZQ=1 W:'$G(DIPZS) $C(7),!,DNM_DRN_$$EZBLD^DIALOG(1503) S:$G(DIPZRLA)]"" DIPZRLAF=0 Q
 S X=DNM_DRN X ^DD("OS",DISYS,"ZS") S %(1)=X D BLD^DIALOG(8025,.%,"","DIR") W:'$G(DIPZS) !,DIR K %,DIR S:$G(DIPZRLA)]"" @DIPZRLA@(DNM_DRN)="",DIPZRLAF=1
 S DRN=DRN+1
NEW K ^UTILITY($J,0) S X=DNM_DRN_" ; GENERATED FROM '"_$P(^DIPT(DIPZ,0),U,1)_"' PRINT TEMPLATE (#"_DIPZ_") ; "_$E(DT,4,5)_"/"_$E(DT,6,7)_"/"_$E(DT,2,3)
 S X=X_" ; ("_$S(DRN="":"FILE "_DP_", MARGIN="_IOM_")",1:"continued)"),L=1,DINC=1,^UTILITY($J,0,L)=X
 S X=" S:'$D(DN) DN=1 S DISTP=$G(DISTP),DILCT=$G(DILCT)"
L S L=L+DINC,^UTILITY($J,0,L)=X Q
 ;
 ;DIALOG #1503  'routine name is too long.  Compilation...aborted'
 ;       #8025  '...routine filed.'
 ;**CCO/NI TAG 'TEXT+15' CHANGED FOR DATE OUTPUT
TEXT ;
 ;;CP G CP^DIO2
 ;;C S DQ(C)=Y
 ;;S S Q(C)=Y*Y+Q(C) S:L(C)>Y L(C)=Y S:H(C)<Y H(C)=Y
 ;;P S N(C)=N(C)+1
 ;;A S S(C)=S(C)+Y
 ;; Q
 ;;D I Y=DITTO(C) S Y="" Q
 ;; S DITTO(C)=Y
 ;; Q
 ;;N W !
 ;;T W:$X ! I '$D(DIOT(2)),DN,$D(IOSL),$S('$D(DIWF):1,$P(DIWF,"B",2):$P(DIWF,"B",2),1:1)+$Y'<IOSL,$D(^UTILITY($J,1))#2,^(1)?1U1P1E.E X ^(1)
 ;; S DISTP=DISTP+1,DILCT=DILCT+1 D:'(DISTP#100) CSTP^DIO2
 ;; Q
 ;;DT I $G(DUZ("LANG"))>1,Y W $$OUT^DIALOGU(Y,"DD") Q
 ;; X ^DD("DD")
 ;; W Y Q
 ;;M D @DIXX
 ;; Q
 ;;BEGIN ;

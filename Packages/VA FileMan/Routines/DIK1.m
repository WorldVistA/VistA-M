DIK1 ;SFISC/GFT-ACTUAL INDEXER ;7SEP2011
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**1,10,41,146,160,165,168**
 ;
EN N DIC D DI
 D
 . N DIKSV S DIKSV=DIK N DIK,DIKJ,DIFKEP
 . D INDEX^DIKC(DIKSV,.DA,"","","KT")
 D K G Q:'$D(@(DIK_"0)")) ;IF ZERO NODE IS THERE, RE-SET IT
 S Y=^(0),DH=$S($O(^(0))'>0:0,1:$P(Y,U,4)-1),X=$P($P(Y,U,3),U,DH>0) D 3:X=DA
 S ^(0)=$P(Y,U,1,2)_U_X_U_DH
IDENTF I DIK?1"^DD(".NP1",",$G(DA(1)),DIK[DA(1) K ^DD(DA(1),0,"ID",DA),^("W"_DA)
Q K:$G(DIKJ) ^UTILITY("DIK",DIKJ)
 K DB(0),DIKJ,DIKS,DIN,DH,DU,DV,DW,DIKGP Q
 ;
K S X="",Y=1 I $D(DIFKEP(DA))#2,DIK="^DIC(",$D(@(DIK_DA_",0,""GL"")")) S X=^("GL"),Y="^DIC("_DA_","
 I X'=Y K @(DIK_"DA)"),X,Y Q
 S X=DIK_"DA,",DH=@(X_"0)") K ^(0),^("%") S Y="""%""" F  S Y=$O(@(X_Y_")")) Q:$E(Y)'="%"  S Y=""""_Y_"""" K @(X_Y_")")
 S @(X_"0)")=DH K X,Y
 Q
 ;
3 N X1
 S X1=X,X=+$O(^(X1),-1)
 S:X'>0 X=+$O(^(X1))
 Q
 ;
DI S (DIC,DIN)=DIK,DH=DH(DU),DV=1 F  S DV=$O(DA(DV)) Q:DV'>0  S DU=DU+1
DIN S DV=0 F  S DV=$O(^UTILITY("DIK",DIKJ,DH,DV)) Q:DV=""  D R:$G(DIKSET)!(DV-.01)
DVA S DV=$O(DV(DH,DV)) I DV="" Q:$G(DIKSET)  S DV=.01 D R:$D(^UTILITY("DIK",DIKJ,DH,DV)) Q
 S X=DIN_DA_","_DV(DH,DV) I @("'$D("_X_"))") G DVA
 S DU(DU)=DIN,DIN=X_",",DH(DU)=DH,DH=DV(DH,DV,0),DV(DU)=DV,DU=DU+1 F X=DU:-1:1 I $D(DA(X)) S DA(X+1)=DA(X)
 S DA(1)=DA,DA=0
DA I '$D(DV(DH(DU-1),DV,"NOLOOP")) F  S @("DA=$O("_DIN_"DA))") Q:DA'>0  D DIN
 D:$D(^UTILITY("DIK",DIKJ,"KW",DH)) KW(DH,DIN)
 S DU=DU-1,DIN=DU(DU),DH=DH(DU),DV=DV(DU),DA=DA(1) K DA(1) F X=2:1 G DVA:'$D(DA(X)) S DA(X-1)=DA(X) K DA(X)
 ;EXECUTE CROSS-REFERENCES
R S X=^UTILITY("DIK",DIKJ,DH,DV),%=^(DV,0) I @("$D("_DIN_DA_",X))[0") Q
 X % Q:X']""  S DIKS=X,DW=0
XEC S DW=$O(^UTILITY("DIK",DIKJ,DH,DV,DW)) Q:DW=""  D NXEC(^(DW)) S X=DIKS G XEC
 ;
NXEC(DICODE) ;New variables and execute programming hook
 I DICODE="D RCR"
 E  I $G(DW)=99,DICODE?.E1" AUDIT"
 E  N DH,DIFKEP,DIK,DIKJ,DIKS,DIKSET,DIN,DU,DV,DW,KW
 X DICODE
 Q
RCR K Y,%RCR F %="DIKS","DIK","DW","DH","DIN","DU","DV","X","KW","DIKSET" S %RCR(%)=""
 S %RCR="RR^DIK1",Y=^UTILITY("DIK",DIKJ,DH,DV,DW,0) G STORLIST^%RCR
 ;
RR X Y Q
 ;
AUDIT N %,%F,%T,%D,DIKF,DIKDA Q:DIIX=3&($D(DIKNM)!$D(DIKKS))  S %=DV N DV S DV=%
 S %F=DH F %=1:1 Q:'$D(^DD(%F,0,"UP"))  S %D=%F,%F=^("UP"),DV(%)=$O(^DD(%F,"SB",%D,0)) S:DV(%)="" DV(%)=-1
 S DIKDA="",DIKF="" F %=%-1:-1:1 S DIKDA=DIKDA_DA(%)_",",DIKF=DIKF_DV(%)_","
 I $G(^DD(DH,DV,"AX"))]"" D NXEC(^("AX")) I '$T Q
 D ADD^DIET S DIAU(DH,DV,DIKDA_DA)="^DIA("_%F_","_+Y_",",^DIA(%F,%D,0)=DIKDA_DA_U_%T_U_DIKF_DV_U_DUZ,^DIA(%F,"B",DIKDA_DA,%D)=""
SET N C S (%F,C)=$P(^DD(DH,DV,0),U,2),Y=X D:Y]"" S^DIQ S @(DIAU(DH,DV,DIKDA_DA)_"DIIX)")=Y S:DIIX=2&($D(DIKNM)!$D(DIKKS)) ^(3)=Y
 K DIAU I %F["P"!(%F["V")!(%F["S") S ^(DIIX+.1)=X_U_%F
 Q
 ;
1 ;
 N DIKLK
 S DIKLK=DIK_DA_")" L +@DIKLK:10 K:'$T DIKLK D DI L:$D(DIKLK) -@DIKLK G Q
 ;
CNT ;
 N DIKLK,DIKLAST S DIKLAST=$S(DA:DA,1:"")
 S DU=$E(DIK,1,$L(DIK)-1),DIKLK=$S(DIK[",":DU_")",1:DU) L +@DIKLK:10 K:'$T DIKLK
C I @("$O("_DIK_"DA))'>0") S $P(@(DIK_"0)"),U,4)=DCNT D:'$P(^(0),U,3)  D:$D(^UTILITY("DIK",DIKJ,"KW",DH(1))) KW(DH(1),DIK) K DCNT L:$D(DIKLK) -@DIKLK G Q ;**DI*22*146
 .S DCNT=$O(^(" "),-1) I DCNT S $P(^(0),U,3)=DCNT
 S DA=$O(^(DA)) G C:$P($G(^(DA,0)),U)']"" S DIKLAST=DA,DU=1,DCNT=DCNT+1 S:DA="" DA=-1 D:(DCNT#100=0)  D DI K DB(0) G C
 .I $D(IO)#2,$D(IO(0))#2,IO=IO(0),IO="" Q
 .I '$D(ZTQUEUED) W "."
 ;
KW(FIL,DIN) ;Kill entire regular indexes
 N NAM
 S NAM="" F  S NAM=$O(^UTILITY("DIK",DIKJ,"KW",FIL,NAM)) Q:NAM=""  K @(DIN_""""_NAM_""")")
 Q

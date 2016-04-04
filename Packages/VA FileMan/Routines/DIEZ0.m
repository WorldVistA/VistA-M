DIEZ0 ;SFISC/GFT-COMPILE INPUT TEMPLATE ;13SEP2004
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**142,999**
 ;
 D L
DL S DQ=0,DK=0,DQFF=0
MR S DK=DK+1,DH=$P(DR,";",DK),DI=$P(DH,":",1),(DIEZP,DIEZDUP,DIEZR)="" G:'DI K:DI=0,PB S DPR=$P(DH,"//",2,99),DM=+DI S:DPR]"" DI=$P(DI,"//",1),DH=""
 G K:DM=DI S Y=$P(DI,DM,2,99) G MR:Y=""!'$D(^DD(DP,DM,0)) F %=1:1 S X=$P(Y,$C(126),%) Q:X=""  S:X="d" DIEZDUP=X S:X="R" DIEZR=X S:X'="d"&(X'="R")&(X'="T") DIEZP=X D:X="T"
 .I $D(^DD(DP,DM,.1)) S DIEZP=^(.1) Q
 .I +$P(^DD(DP,DM,0),U,2),$P(^DD(+$P(^(0),U,2),.01,0),U,2)["W",$D(^(.1)) S DIEZP=^(.1)
 .Q
 S (DI,DM)=+DI G S
K S DM=$P(DH,":",2),DM=$S(DM:DM,1:+DI) I DI,$D(^DD(DP,+DI)) G S
NX ;
 S DI=$O(^DD(DP,+DI)),DIEZP="" S:DI="" DI=-1 G MR:DI'>0,MR:DI>DM
S S Y=^DD(DP,+DI,0),DV=$P(Y,U,2)_$E("#",Y["DINUM")_DIEZR_DIEZDUP ;**CCO/NI FIELD NAME (THRU NEXT 2 LINES)
 S X=$S(DIEZP=""&'DV:"$$LABEL^DIALOGZ(DP,DIFLD)",1:""""_DIEZP_"""")
 S DW=$P(Y,U,4) G NX:$A(DW)=32 I T>DMAX D SV G:DIEZQ K^DIEZ2 G S
 W:'$G(DIEZS) "." S DQ=DQ+1,DI=+DI,DU=$P(Y,U,3),%=" S "
 K DIEZOT I DV["O",$D(^(2)) D O^DIEZ2
 I DQFF S %=" D:$D(DG)>9 F^DIE17,DE S DQ="_DQ_",",DQFF=0
 I DV S Y=X,X=DQ_%_"D=0 K DE(1) ;"_DI D L,DRN G MUL^DIEZ2
VARS S ^UTILITY($J,U,$P(DW,";",1),$P(DW,";",2),DQ)="",T=T+35,X=DQ_%_"DW="""_DW_""",DV="""_DV_""",DU="""",DIFLD="_DI_",DLB="_X D L ;**CCO/NI COMPILE 'SET DLB=$$LABEL^DIALOGZ...' RATHER THAN FIELD NAME, SO IT WORKS FOR ANY LANGUAGE
 I $D(DIEZOT) S X=DIEZOT D L K DIEZOT
 S DIEZXREF=$O(^DD("IX","F",DP,DI,0))
 I $O(^DD(DP,DI,1,0))>0!(DV["a")!DIEZXREF D
 . S DQFF=1,X=" S DE(DW)=""C"_DQ_U_DNM_DRN_""""
 . S:DIEZXREF X=X_",DE(DW,""INDEX"")=1"
 . ;Determine whether this field is part of a field-level key.
 . ;Also, build list: DIEZKEY(uniquenessIndex)=""
 . ;for those indexes that are uniqueness indexes for keys.
 . N DIEZK,DIEZUI
 . K DIEZKEY S DIEZK=0
 . F  S DIEZK=$O(^DD("KEY","F",DP,DI,DIEZK)) Q:'DIEZK  D
 .. S DIEZUI=$P($G(^DD("KEY",DIEZK,0)),U,4) Q:'DIEZUI
 .. S:$P($G(^DD("IX",DIEZUI,0)),U,6)="F" DIEZKEY(DIEZUI)=""
 . S:$D(DIEZKEY) X=X_",DE(DW,""KEY"")=""$$K"_DQ_""""
 . D L
 K DIEZXREF
X D PR,XREF^DIEZ2:DQFF S %=$P(Y,U,5,99),X=$F(%,"%DT=""") I X,DPR?1"/".E S Y=$F(%,"E",X) I Y S %=$E(%,1,Y-2)_$E(%,Y,999)
 I DPR?1"//".E S %=""
 D AF^DIEZ2 S X="X"_DQ_" " I "Q"[% S X=X_"Q" D L G NX
 S X=X_% D L I DV["F" S X=" I $D(X),X'?.ANP K X" D L
 S X=" Q" D L S X=" ;" D L G NX
 ;
PB I DH="" S:'$D(DOV(DL)) DOV(DL)=0 S DOV(DL)=$O(^DIE(DIEZ,"DR",DIER,DP,DOV(DL))) S:DOV(DL)="" DOV(DL)=-1 G UP:DOV(DL)<0 S DR=^(DOV(DL)),DK=0 G MR
 S DQ=DQ+1 I DH?1"@".N S X=DQ_" S DQ="_(DQ+1)_" ;"_DH,^UTILITY($J,"AB",DIEZAB,DH)=DQ_U_DNM_DRN G M
 S X=DQ_" D:$D(DG)>9 F^DIE17,DE S Y=U,DQ="_DQ_" " I "Q"[DH S X=X_"G A" G M
 I DH?1"^".E S F=0,X=X_$P(DH,U,5,999),Q=$P(DH,U,1,3) D L,DRN,QFF^DIEZ2,DIERN^DIEZ2 S X=" S DGO=""^"_DNM_%_""",DC="_Q_" G DIEZ^DIE0",DRN(%)=$P(DH,U,2)_U_DIERN_U_$P(DH,U,3)_U_U_DQ_U_DRN D L S X="R"_DQ_" D DE G A" D L S X=" ;" G M
 S X=X_"D X"_DQ_" D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)=""F"",DW=DQ G OUT^DIE17" D L S X="X"_DQ_" "_DH D L S X=" Q"
M D L G MR
 ;
UP S DQ=DQ+1,X=DQ_" G "_(DL>1)_"^DIE17" D L,^DIEZ1 G:DIEZQ K^DIEZ2 S Y=0
LV S Y=$O(DRN(Y)) S:Y="" Y=-1 I Y<0 G ^DIEZ2
 S X=DRN(Y) G LV:X=U S DRN=Y,DP=+X,DIER=$P(X,U,2),DL=DIER\1,DIE=U_$P(X,U,3),DIEZL=+$P(X,U,4),DIEZAB=$P(X,U,5)_U_DNM_$P(X,U,6),DR=$S($D(^DIE(DIEZ,"DR",DIER,DP)):^(DP),1:"0:9999999"),DRN(Y)=U D N S:+DR=.01!(DR?1"0:".E) ^(3)=^(3)_"+D G B" G DL
 ;
PR ;
 D DU^DIEZ2:DU]"" S X=" G RE" I DW="0;1",DL>1,DQ=1 S X=X_":'D S DQ=2 G 2"
 D PR^DIEZ2:DPR]""
L S L=L+1,^UTILITY($J,0,L)=X,T=T+$L(X)+2 S:X?1N.E T=T+15 Q
 ;
SV D DRN
 S X=DQ+1_" D:$D(DG)>9 F^DIE17 G ^"_DNM_%,DQ=% D L,^DIEZ1 Q:DIEZQ
N G NEWROU^DIEZ
 ;
DRN F %=DRN+1:1 Q:'$D(DRN(%))

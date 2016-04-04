DIEZ2 ;SFISC/GFT-COMPILE INPUT TEMPLATE ;15JUN2006
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**11,95,142,1024**
 ;
 K DIEZAR D RECXR^DIEZ4(.DIEZAR)
 K ^DIE(DIEZ,"AR") M:$D(DIEZAR) ^DIE(DIEZ,"AR")=DIEZAR
 S %X="^UTILITY($J,""AF"",",%Y="^DIE(""AF""," D %XY^%RCR
 K ^DIE(DIEZ,"AB") S %X="^UTILITY($J,""AB"",",%Y="^DIE(DIEZ,""AB""," D %XY^%RCR
 S ^DIE(DIEZ,"ROUOLD")=DNM,^("ROU")=U_DNM
K K ^DIBT(.402,1,DIEZ),^UTILITY($J)
 K @DIEZTMP,DIEZTMP,DIEZAR,DIER,DIERN
 K DIE,DINC,DK,DL,DMAX,DNR,DP,DQ,DQFF,DRD,DS,DSN,DV,DW,DI,DH,%,%X,%Y,%H,X,Y
 K DIEZ,DIEZDUP,DIEZR,Q,DPP,DPR,DM,DR,DU,T,F,DRN,DOV,DIEZL,DIEZP,DIEZAB
 Q
 ;
XREF ;
 N DIEZR,DIEZX,DIEZLN
 S X="C"_DQ_" G C"_DQ_"S:$D(DE("_DQ_"))[0 K DB" D L
 S DIEZX=L,DIEZLN=0 ;remember cross-refs will start after 'L'
 F %=0:0 S %=$O(^DD(DP,DI,1,%)) Q:%'>0  S DW=^(%,2),X=" S X=DE("_DQ_"),DIC=DIE" D SK ;first build the KILL XREFS
 I DV["a" S X=" S X=DE("_DQ_"),DIIX=2_U_DIFLD D AUDIT^DIET" D X
 ;I X]"" S X="C"_DQ_" ;" D L
 D OVERFLO
 S X="C"_DQ_"S S X="""" G:DG(DQ)=X C"_DQ_"F1 K DB" D L S X=""
 S DIEZX=L,DIEZLN=L
 F %=0:0 S %=$O(^DD(DP,DI,1,%)) Q:%'>0  S DW=^(%,1),X=X_" S X=DG(DQ),DIC=DIE" D SK ;then the SET XREFS
 I DV["a" S X=X_" I $D(DE("_DQ_"))'[0!($G(^DD(DP,DIFLD,""AUDIT""))[""y"") S X=DG(DQ),DIIX=3_U_DIFLD D AUDIT^DIET" D X
 D OVERFLO
 ;Build index code and code to check key
 D INDEX
 S X=X_" Q" D L
 I $D(DIEZKEY) D GETKEY^DIEZ3(DP,DI,.DIEZKEY,DQ) K DIEZKEY
 Q
 ;
SK D X I "Q"[DW S X=" ;" G X
 I DW["Q",^DD(DP,DI,1,%,0)["MUMPS" S Q=DW,F=0 D QFF S X=" X "_Q G X
 S X=" "_DW
X D L S DIEZLN=DIEZLN+$L(X),X="" Q
 ;
OVERFLO I DIEZLN+T+100<DMAX!'DIEZLN Q
 K ^UTILITY($J,"DIEZXR") M ^UTILITY($J,"DIEZXR")=^UTILITY($J,0)
 S DIEZR=DRN,(DIEZR(1),DRN)=$O(DRN(""),-1)+1 D
 .N T,DQ,L
 .D NEWROU^DIEZ ;make a new routine holding just the X-REFS
 .F T=2:1 S DIEZX=DIEZX+1 Q:'$D(^UTILITY($J,"DIEZXR",DIEZX))  S ^UTILITY($J,0,T)=^(DIEZX) K ^UTILITY($J,"DIEZXR",DIEZX)
 .F  K ^UTILITY($J,0,T) S T=$O(^(T)) Q:'T
 .D SAVE^DIEZ1
 K ^UTILITY($J,0) M ^UTILITY($J,0)=^UTILITY($J,"DIEZXR")
 S DRN=DIEZR,T=T-DIEZLN,X=" D ^"_DNM_DIEZR(1) D L
 Q
 ;
MUL ;
 S DNR=%,DW=$P(DW,";",1),X=$P(^DD(+DV,0),U,4)_U_DV_U_DW_U,%=^(.01,0),DV=+DV_$P(%,U,2)
 G 1:DV'["W" I DPR]"" S F=0,Q=DPR D QFF S X=" S DE(1,0)="_Q D L
WPEGP S X=" S Y=""^"_$P(%,U,2,9)_""" S $P(Y,U)="_$S(DIEZP]"":""""_DIEZP_"""",1:"$$LABEL^DIALOGZ(DP,"_DI_")")_" S DG="""_DW_""",DC=""^"_+DV_""" D DIEN^DIWE K DE(1) G A" D L S X=" ;" D L,AF ;**CC0/NI WORD-PROCESSING FIELD LABEL
 S ^UTILITY($J,"AF",+DV,.01,DIEZ)="" D AB G NX^DIEZ0
 ;
1 ;**CCO/NI COMPILE 'SELECT FIELD:' SO IT WORKS FOR ANY LANGUAGE
 S X=" S DIFLD="_DI_",DGO=""^"_DNM_DNR_""",DC="""_X_""",DV="""_DV_""",DW=""0;1"",DOW="_$S(DIEZP]"":""""_DIEZP_"""",1:"$$LABEL^DIALOGZ(DP,DIFLD)")_",DLB=$P($$EZBLD^DIALOG(8042,DOW),"": "") S:D DC=DC_D",DPP=DV["M",DU=$P(^(0),U,3) D L,DU:DU]""
 S X=$P(" G RE:D",U,DPP)_" I $D(DSC("_+DV_"))#2,$P(DSC("_+DV_"),""I $D(^UTILITY("",1)="""" X DSC("_+DV_") S D=$O(^(0)) S:D="""" D=-1 G M"_DQ D L
 S:+DW'=DW DW=""""_DW_"""" S X=" S D=$S($D("_DIE_"DA,"_DW_",0)):$P(^(0),U,3,4),$O(^(0))'="""":$O(^(0)),1:-1)" D L
 S X="M"_DQ_" I D>0 S DC=DC_D I $D("_DIE_"DA,"_DW_",+D,0)) S DE("_DQ_")=$P(^(0),U,1)" D L
 D PR^DIEZ0 S X="R"_DQ_" D DE" D L
 S X=$S(DPP:" S D=$S($D("_DIE_"DA,"_DW_",0)):$P(^(0),U,3,4),1:1) G "_DQ_"+1",1:" G A") D L S X=" ;" D L,AF,DIERN
 S DRN(DNR)=+DV_U_DIERN_DIE_"D"_DIEZL_","_DW_","_U_(DIEZL+1)_U_DQ_U_DRN G NX^DIEZ0
 ;
DIERN ;
 N M S DIERN=DL+1,M=$P(DR,";",DK+1) S:M?1"^"1.NP DK=DK+1,DIERN=$P(M,U,2) Q
 ;
AF ;
 S ^UTILITY($J,"AF",DP,DI,DIEZ)=""
AB I '$D(^UTILITY($J,"AB",DIEZAB,DI)) S ^(DI)=DQ_U_DNM_DRN S:DPR?1"/".E ^(DI,"///")=""
 Q
 ;
DU S F=0,Q=DU D QFF S X=" S DU="_Q,DU=""
L S L=L+1,^UTILITY($J,0,L)=X,T=T+$L(X)+2 Q
 ;
O ;
 S F=0,Q=^(2) D QFF S DIEZOT=" S DQ("_DQ_",2)="_Q Q
 ;
PR ;
 F %=1,2,3 Q:$E(DPR,%)'="/"
 S X=$E(DPR,%,999),Q=X,F=0 D QFF I $A(X)-94 S X=" S Y="_Q
 E  S X=" "_$E(X,2,999) D L S X=" S Y=X"
 D L S X=" G Y" I %>1 S DPP=0,X=" S X=Y,DB(DQ)=1"_$S(%=3:",DE(DW,""4/"")=""""",1:"")_" G:X="""" N^DIE17:DV,A I $D(DE(DQ)),DV[""I""!(DV[""#"") D E^DIE0 G A:'$D(X)" D L S X=" G "_$S(%=3:"RD:X=""@"",Z",1:"RD")
 Q
QF ;
 S F=0,Q=DIE
QFF ;
 S F=$F(Q,"""",F) I F S Q=$E(Q,1,F-1)_$E(Q,F-1,999),F=F+1 G QFF
 S Q=""""_Q_""""
 Q
 ;
INDEX ;Build code field and record level cross references.
 ;In:
 ; DP = file #
 ; DI = field #
 ; DIEZKEY(xref#) = "" : for each xref that is a Uniqueness Index
 ;                       for a simple (single-field key)
 N DIEZCNT,DIEZFLST,DIEZI,DIEZRLST,DIEZXR,DIEZXREF
 S DIEZCNT=0
 ;
 ;Get field- and record-level xrefs
 D LOADFLD^DIKC1(DP,DI,"KS","","@DIEZTMP@(""V"",","DIEZXREF",$NA(@DIEZTMP@("R")),.DIEZFLST,.DIEZRLST)
 I DIEZFLST="",DIEZRLST="" S X="C"_DQ_"F1" Q
 ;
 ;Build code for each field-level xref
 ;Save DIEZKEY(uniquenessIndex)=index tag # (DIEZCNT)
 I DIEZFLST]"" S DIEZXR=0 F  S DIEZXR=$O(DIEZXREF(DP,DIEZXR)) Q:'DIEZXR  D
 . D GETXR(DIEZXR,.DIEZCNT)
 . S:$D(DIEZKEY(DIEZXR))#2 DIEZKEY(DIEZXR)=DIEZCNT
 ;
 ;Build code to set the DIEZRXR array for each record-level xref
 S X="C"_DQ_"F"_(DIEZCNT+1)
 Q:DIEZRLST=""
 S X=X_" S DIEZRXR("_DP_",DIIENS)=$$OREF^DILF($NA(@$$CREF^DILF(DIE)))" D L
 S X=" F DIXR="_$TR(DIEZRLST,U,",")_" S DIEZRXR("_DP_",DIXR)=""""" D L
 S DIEZI=0 F  S DIEZI=$O(DIEZRLST(DIEZI)) Q:'DIEZI  D
 . S X=" F DIXR="_$TR(DIEZRLST(DIEZI),U,",")_" S DIEZRXR("_DP_",DIEZIENS)=""""" D L
 ;
 S X=""
 Q
 ;
GETXR(DIEZXR,DIEZCNT) ;Get code for one index DIEZXR
 N DIEZCOD,DIEZF,DIEZKLOG,DIEZNSS,DIEZSLOG,DIEZO
 S DIEZCNT=$G(DIEZCNT)+1
 ;
 ;Build code to call subroutine to set X array
 S X="C"_DQ_"F"_DIEZCNT_$S(DIEZCNT=1:" N X,X1,X2",1:"")_" S DIXR="_DIEZXR_" D C"_DQ_"X"_DIEZCNT_"(U) K X2 M X2=X D C"_DQ_"X"_DIEZCNT_"(""O"") K X1 M X1=X"
 D L
 ;
 ;Build code to check for null subscripts
 S DIEZNSS="",DIEZO=0
 F  S DIEZO=$O(DIEZXREF(DP,DIEZXR,DIEZO)) Q:'DIEZO  D
 . Q:'$G(DIEZXREF(DP,DIEZXR,DIEZO,"SS"))
 . I DIEZNSS="" S DIEZNSS="$G(X("_DIEZO_"))]"""""
 . E  S DIEZNSS=DIEZNSS_",$G(X("_DIEZO_"))]"""""
 I DIEZNSS]"" S DIEZNSS=" I "_DIEZNSS_" D"
 E  S DIEZNSS=" D"
 ;
 ;Get kill logic and condition
 S DIEZKLOG=$G(DIEZXREF(DP,DIEZXR,"K"))
 I DIEZKLOG'?."^" D
 . S X=DIEZNSS D L
 . ;Get kill condition code
 . S DIEZCOD=$G(DIEZXREF(DP,DIEZXR,"KC"))
 . I DIEZCOD'?."^" D
 .. S X=" . N DIEXARR M DIEXARR=X S DIEZCOND=1" D L
 .. S X=" . "_DIEZCOD D L
 .. S X=" . S DIEZCOND=$G(X) K X M X=DIEXARR Q:'DIEZCOND" D L
 . ;Get kill logic
 . S X=" . "_DIEZKLOG D L
 ;
 ;Get set logic and condition
 S DIEZSLOG=$G(DIEZXREF(DP,DIEZXR,"S"))
 I DIEZSLOG'?."^" D
 . S X=" K X M X=X2"_DIEZNSS D L
 . ;Get set condition code
 . S DIEZCOD=$G(DIEZXREF(DP,DIEZXR,"SC"))
 . I DIEZCOD'?."^" D
 .. S X=" . N DIEXARR M DIEXARR=X S DIEZCOND=1" D L
 .. S X=" . "_DIEZCOD D L
 .. S X=" . S DIEZCOND=$G(X) K X M X=DIEXARR Q:'DIEZCOND" D L
 . ;Get set logic
 . S X=" . "_DIEZSLOG D L
 ;
 S X=" G C"_DQ_"F"_(DIEZCNT+1) D L
 ;
 ;Build code to set X array
 S DIEZF=$O(DIEZXREF(DP,DIEZXR,0))
 S X="C"_DQ_"X"_DIEZCNT_"(DION) K X" D L
 S DIEZO=0
 F  S DIEZO=$O(DIEZXREF(DP,DIEZXR,DIEZO)) Q:'DIEZO  D
 . D BLDDEC(DP,DIEZXR,DIEZO)
 S X=" S X=$G(X("_DIEZF_"))" D L
 S X=" Q" D L
 Q
 ;
BLDDEC(DP,DIEZXR,DIEZO) ;Build data extraction code
 N CODE,NODE,TRANS
 ;
 S CODE=$G(DIEZXREF(DP,DIEZXR,DIEZO)) Q:CODE?."^"
 S TRANS=$G(DIEZXREF(DP,DIEZXR,DIEZO,"T"))
 I TRANS'?."^" D
 . S X=" "_CODE D L
 . D DOTLINE(" I $D(X)#2 "_TRANS)
 . S X=" S:$D(X)#2 X("_DIEZO_")=X" D L
 E  I $D(DIEZXREF(DP,DIEZXR,DIEZO,"F"))#2,CODE?1"S X=".E D
 . S X=" S X("_DIEZO_")"_$E(CODE,4,999) D L
 E  D
 . S X=" "_CODE D L
 . S X=" S:$D(X)#2 X("_DIEZO_")=X" D L
 Q
 ;
DOTLINE(CODE) ;
 I CODE[" Q"!(CODE[" Q:") D
 . S X=" D" D L
 . S X=" ."_CODE D L
 E  S X=CODE D L
 Q

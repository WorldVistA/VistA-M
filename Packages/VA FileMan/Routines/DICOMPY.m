DICOMPY ;SFISC/GFT-EVALUATE COMPUTED FLD EXPR ;10:22 AM  8 Jan 2003
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**6,44,76,114**
 ;
 N DICOINS,DICOLEFT
 S K(K+1)=X,I=$E(I,M+1,999)
 I I'[")" K Y Q
ARG D  S DICOLEFT=$E(I,%+1,999),I=$E(I,1,%-1)
 .N C,S S S=0
 .F %=1:1 S C=$E(I,%) D:C=""""  S:C="(" S=S+1 S:C=")" S=S-1 Q:S<0!(C="")
 ..F %=%+1:1 Q:""""[$E(I,%)
PREVNEXT I DICF="PREVIOUS"!(DICF="NEXT") N DICMX D  D RCR^DICOMPZ(I) G BAD:'$D(Y) S DICN=X,X=DICF G OK
 .D SV^DICOMPX(DLV0)
 .S %=DLV#100,DICF=" S D"_%_"=+$O("_$$REF^DICOMPZ(DLV)_")"_$P(",-1",U,DICF="PREVIOUS")_") "
 D FUNC
 N DICMX S DICMX=DICOINS
 D RCR^DICOMPZ(I) I $G(Y)'["m" G BAD
OK S K=K+1,K(K)=X,K(K,2)=0,K=K+1,K(K)=DICN I "TOTAL"=DICF!("COUNT"=DICF) K DATE(K-1)
RES S I=DICOLEFT,M=0 Q
 ;
FUNC S DICN=$$DGI^DICOMP,W=DLV#100,K=K+2,K(K)=" S "_DICN_"="""""
NUMBER I DICF S %X=$$DGI^DICOMP,K(K)=" S "_%X_"=0"_K(K) D L S DICOINS=DICOINS_" "_%X_"="_%X_"+1 I "_%X_"="_+DICF_",Y'?."" "" S "_DICN_"=Y Q  ",DPS(DPS,"O")="" Q
 I $T(@DICF)]"" G @DICF
BAD S DPS=0 Q
 ;
 ;
MAXIMUM S %X="'>" G MM
MINIMUM S %X="'<"
MM D L S DICOINS=DICOINS_"&("_DICN_%X_"Y!'$L("_DICN_")) "_DICN_"=Y" Q
TOTAL S DICOINS="S "_DICN_"="_DICN_"+X" Q
COUNT S DICOINS="S:X'?."" "" "_DICN_"="_DICN_"+1",DICN="+"_DICN Q
LAST D L S DICOINS=DICOINS_" "_DICN_"=Y" Q
L S DICOINS="S Y=X S:Y'?."" """
 Q
 ;
 ;
W S X=$P(Y(0),U,4),Y=$P(X,";",1),X=$P(X,";",2) Q
 ;
DICS ;
 S:DUZ(0)'="@" D=DICOMP["W"+8,DIC("S")=DIC("S")_" Q:'$L($G("_DIC_"Y,"_D_")))  I $TR(DUZ(0),^("_D_"))'=DUZ(0)" Q
G ;
 D W I X="" S Y=T#100,X=$S(T<DLV0&$D(M(Y,T))!(DICOMP["T"&(T<DICO(0))):$S(DA:DQI_(T+80)_")",1:"I("_T_",0)"),1:"$S('$D(D"_Y_"):"""",D"_Y_"<0:"""",1:D"_Y_")") Q
 I '$D(DG(%,T_U_Y)) S (DG(%),DG(%,T_U_Y))=DG(%)+1
 S Y="("_DQI_DG(%,T_U_Y)_"),"
EP I X S X="$P"_Y_"U,"_X_")" Q
 I X?1"E".E S X="$E"_Y_+$E(X,2,9)_","_$P(X,",",2)_")"
 Q

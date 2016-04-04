DIET ;SFISC/XAK-DISPLAY INPUT TEMPLATE    ALSO DOES AUDITING! ;15OCT2009
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**69,49,104,129,1009,147,1024,1034**
 ;
 N DICMX
 I '$D(^DIE(D0,0)) G EXIT
 S DICMX="W X,!"
EN ;
 N DI,DIET,DIETS,D
 S DIET=D0 D GET^DIETED("DIETS")
 F D=0:0 S D=$O(DIETS(D)) Q:'D  S X=DIETS(D) X DICMX Q:'$D(D)
EXIT S X="" Q
 ;
 ;
 ;
AUD N DP,DG,DPS,DIEX,DIIX,DIANUM ; From ^DICN0  DI*22*49
 S DIIX="3^.01^A",DP=+DO(2) D AUDIT:DP>0 Q
AUDIT ;
 N C,DIEDA,DIEF,%T,%F,%D,%,Y
 I $D(^DD(DP,+$P(DIIX,U,2),"AX")) X ^("AX") Q:'$T
 K % S DIEX=X D @+DIIX
 K DIIX,DPS,DIEX
 Q
3 ;'X' is NEW value
 I $D(DG),$D(DIANUM($P(DIIX,U,2))) S Y=X,(DIEX(1),C)=$P(^DD(DP,+$P(DIIX,U,2),0),U,2) D Y^DIQ S @DIANUM($P(DIIX,U,2))=Y K DIANUM($P(DIIX,U,2)) G I
2 ;'X' is OLD value
 S:$D(DP(1)) DPS=DP(1) S DIEDA="",DIEF="",%=1,DP(1)=DP,%F=+DP,X=DA
 F C=1:1 Q:'$D(^DD(DP(1),0,"UP"))  S %F=^("UP"),%=$O(^DD(%F,"SB",DP(1),0)) G Q:'$D(DA(C)) S DIEDA=DA(C)_","_DIEDA,DIEF=%_","_DIEF,DP(1)=%F
 D ADD I $D(DG),+DIIX=2 S DIANUM($P(DIIX,U,2))="^DIA("_%F_","_+Y_",3)"
 S (DIEX(1),C)=$P(^DD(DP,+$P(DIIX,U,2),0),U,2),Y=DIEX D 
 .N %F,%D,DA,DIEX,DP,DPS
 .D Y^DIQ
 S ^DIA(%F,"B",DIEDA_DA,%D)="",X=DIEX S:$D(DPS) DP(1)=DPS
 S ^DIA(%F,%D,0)=DIEDA_DA_U_%T_U_DIEF_+$P(DIIX,U,2)_U_DUZ_U_$P(DIIX,U,3),^(+DIIX)=Y
I I (DIEX(1)["D")!(DIEX(1)["P")!(DIEX(1)["V")!(DIEX(1)["S") S ^(DIIX+.1)=X_U_DIEX(1)
Q Q
 ;
 ;
 ;
 ;
 ;
WP(%F,FLD,IENS,DIEFNODE) ;AUDIT WP FIELD FLD IN (SUB)FILE %F
 N Y,%D,%T,X
 S Y=+$P($G(^DD(%F,FLD,0)),U,2) Q:'Y  Q:$P($G(^DD(+Y,.01,0)),U,2)'["a"  Q:$G(^("AUDIT"))="e"&'$O(@DIEFNODE@(0))
 S X=""
 F  Q:'IENS  S Y=%F,X=+IENS_","_X,IENS=$P(IENS,",",2,99)  Q:'$G(^DD(Y,0,"UP"))  S %F=^("UP"),%=$O(^DD(%F,"SB",Y,0)) I % S FLD=%_","_FLD
 S X=$E(X,1,$L(X)-1) D ADD S ^DIA(%F,Y,0)=X_U_%T_U_FLD_U_DUZ,^DIA(%F,"B",X,Y)=""
 M ^DIA(%F,Y,2.14)=@DIEFNODE
 Q
 ;
 ;
 ;
ACCESSED(%F,REF) ;WILL FLAG ENTRY 'REF' IN FILE '%F' AS BEING ACCESSED BY CURRENT USER, CURRENT TIME, CURRENT OPTION
 N Y,X,%T,%D,%,%I,%H
 Q:'$G(DUZ)
 I '$G(DT) D NOW^%DTC S DT=X,U="^"
 Q:'%F!'REF  S %F=+%F,(REF,X)=+REF Q:'$D(^DIC(%F))
 D ADD ;COMES BACK WITH %T AND Y--THE AUDIT REF
 S ^DIA(%F,Y,0)=REF_U_%T_U_.01_U_DUZ_U_U_"i"
 S ^DIA(%F,"B",REF,Y)=""
 Q
 ;
 ;
 ;
ADD S Y=$O(^DIA(%F,"A"),-1) I 'Y S ^DIA(%F,0)=$P(^DIC(%F,0),U)_" AUDIT^1.1I"
 F Y=Y+1:1 I '$D(^(Y)) D LOCK^DILF("^DIA(%F,Y)") I  Q:'$D(^(Y))  L -^DIA(%F,Y) ;**PATCH 147
 S ^(Y,0)=X L -^DIA(%F,Y)
 S %T=$G(XQY),%D=$S($D(XQORNOD)#2:XQORNOD,$D(HLORNOD)#2:HLORNOD,1:"") I %T!%D S ^DIA(%F,Y,4.1)=%T_U_%D
 S $P(^(0),U,3,4)=Y_U_($P(^DIA(%F,0),U,4)+1)
TIME S %D=Y,%T=$$HTFM^DILIBF($H)
 S ^DIA(%F,"C",%T,Y)="",^DIA(%F,"D",DUZ,Y)=""
 Q

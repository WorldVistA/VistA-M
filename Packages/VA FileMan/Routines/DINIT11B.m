DINIT11B ;SFISC/GFT,DCM,TKW-INITIALIZE VA FILEMAN ;15SEP2010
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**7,1023,1040**
 ;
DD F I=1:1 S X=$T(DD+I),Y=$P(X," ",3,99) G ^DINIT11C:X?.P S @("^DD("_$E($P(X," ",2),3,99)_")=Y")
 ;;1,0 ATTRIBUTE^N
 ;;1,0,"NM","FILE"
 ;;1,.01,0 NAME^RF^^0;1^K:$L(X)>45!($L(X)<3) X
 ;;1,.01,1,0 ^.1^1^1
 ;;1,.01,1,1,0 1^B
 ;;1,.01,1,1,1 S @(DIC_"""B"",$E(X,1,30),DA)=""""")
 ;;1,.01,1,1,2 K @(DIC_"""B"",$E(X,1,30),DA)")
 ;;1,.01,1,2,0 1^AD^MUMPS
 ;;1,.01,1,2,1 I DIC'?1"^DOPT(".E,$D(^DIC(DA,0,"GL"))  S $P(@(^DIC(DA,0,"GL")_"0)"),U,1)=X
 ;;1,.01,1,2,2 Q
 ;;1,.01,1,3,0 1^AE^MUMPS
 ;;1,.01,1,3,1 S:DIC'?1"^DOPT(".E ^DD(DA,0,"NM",X)=""
 ;;1,.01,1,3,2 K ^DD(DA,0,"NM")
 ;;1,.01,3 3-45 CHARACTERS
 ;;1,.01,"DEL",1,0 I DIC="^DIC(" D K^DIU2
 ;;1,.01,"DEL",.5,0 I DIC="^DIC(" D CHECKPT^DIU2
 ;;1,.01,"DEL","TRB",0 I $D(^DD(DA,"TRB")) D TRIG^DIDH
 ;;1,1,0 GLOBAL NAME^CJ14^^ ; ^S X=$S($D(^DIC(D0,0,"GL")):^("GL"),1:"")
 ;;1,1.1,0 ENTRIES^CJ7,0^^ ; ^S @("X=+$P("_$S($D(^DIC(D0,0,"GL")):"$S($D("_^("GL")_"0)):^(0),1:0)",1:0)_",""^"",4)")
 ;;1,4,0 DESCRIPTION^1.001^^%D;0
 ;;1.001,0 DESCRIPTION
 ;;1.001,.01,0 DESCRIPTION^W^^0;1
 ;;1.001,0,"UP" 1
 ;;1,10,0 APPLICATION GROUP^1.005^^%;0
 ;;1,20,0 DEVELOPER^P200'^VA(200,^%A;1^Q
 ;;1,21,0 DATE^D^^%A;2^S %DT="" D ^%DT S X=Y K:X<9 X
 ;;1,21.214,0 LAST DD MODIFICATION^D^^%MSC;1^S %DT="TSX" D ^%DT S X=Y K:X<9 X
 ;;1.005,0 APPLICATION GROUP^
 ;;1.005,0,"NM","APPLICATION-GROUP"
 ;;1.005,0,"UP" 1
 ;;1.005,.01,0 APPLICATION GROUP^MF^^0;1^K:X'?.U!($L(X)+1\3-1) X
 ;;1.005,.01,3 A 'NAMESPACE' (2-4 BYTES) INDICATING A PACKAGE ACCESSING THIS FILE
 ;;1.005,.01,1,0 ^.1^2^2
 ;;1.005,.01,1,1,0 1.005^B
 ;;1.005,.01,1,1,1 S ^DIC(DA(1),"%","B",X,DA)=""
 ;;1.005,.01,1,1,2 K ^DIC(DA(1),"%","B",X,DA)
 ;;1.005,.01,1,2,0 1^AC
 ;;1.005,.01,1,2,1 S ^DIC("AC",X,DA(1),DA)=""
 ;;1.005,.01,1,2,2 K ^DIC("AC",X,DA(1),DA)
 ;;1.005,1,0 PACKAGE NAME^CJ30^^ ; ^S X=$S($D(^DIC(9.4,+$O(^DIC(9.4,"C",$P(^DIC(D0,"%",D1,0),U),0)),0)):$P(^(0),U,1),1:"")
 ;;1.01,0 ATTRIBUTE
 ;;1.01,0,"NM","OPTION"
 ;;1.01,.001,0 NUMBER^N^^ ^K:X\1'=X X
 ;;1.01,.01,0 NAME^RF^^0;1^K:$L(X)>70 X
 ;;1.01,.01,1,0 ^.1
 ;;1.01,.01,1,1,0 1.01^B
 ;;1.01,.01,1,1,1 S @(DIC_"""B"",$E(X,1,30),DA)=""""")
 ;;1.01,.01,1,1,2 K @(DIC_"""B"",$E(X,1,30),DA)")

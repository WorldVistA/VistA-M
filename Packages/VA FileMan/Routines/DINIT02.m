DINIT02 ;SFISC/DPC-EXPORT TOOL PRINT TEMPLATES ;10:05 AM  17 Sep 1998
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(ENTRY+I) G:X="" ^DINIT07 S Y=$E($T(ENTRY+I+1),5,999),X=$E(X,4,999),@X=Y
 Q
ENTRY ;
 ;;^DIPT(.441,0)
 ;;=DDXP FORMAT DOC^2921023.1533^@^.44^^@^2921130
 ;;^DIPT(.441,"F",2)
 ;;="DESCRIPTION:";S~30,.01~"USAGE NOTE:";C2;S~31,.01~50,"OTHER NAME:";C5;S~50,.01~50,"DESCRIPTION:";C8;S~50,1,.01~
 ;;^DIPT(.441,"H")
 ;;=AVAILABLE FORMATS
 ;;^DIPT(.442,0)
 ;;=DDXP FORMAT DOC HDR^2921112.1536^@^.44^^@^2921130
 ;;^DIPT(.442,"F",1)
 ;;="AVAILABLE FOREIGN FORMATS"~S %=$P($H,",",2),X=DT_(%\60#60/100+(%\3600)+(%#60/10000)/100) S Y=X D DT K DIP;C45;L18;Z;"NOW"~
 ;;^DIPT(.442,"F",2)
 ;;=S X="Page ",DIP(1)=X,X=$S($D(DC)#2:DC,1:"") S Y=X,X=DIP(1),X=X S X=X_Y W X K DIP;C67;Z;""Page "_PAGE"~
 ;;^DIPT(.442,"F",3)
 ;;=S X="_",DIP(1)=X,DIP(2)=X,X=$S($D(IOM):IOM,1:80) S X=X,X1=DIP(1) S %=X,X="" Q:X1=""  S $P(X,X1,%\$L(X1)+1)=X1,X=$E(X,1,%) W X K DIP;C1;Z;"DUP("_",IOM)"~
 ;;^DIPT(.442,"H")
 ;;=@

DINIT28 ;SFISC/XAK-INITIALIZE VA FILEMAN ;9/9/94  14:19
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(Q+I) G ^DINIT285:X="" S Y=$E($T(Q+I+1),5,999),X=$E(X,4,999),@X=Y
Q Q
 ;;^DIC(1.12,0,"GL")
 ;;=^DIAR(1.12,
 ;;^DIC("B","FILEGRAM HISTORY",1.12)
 ;;=
 ;;^DIC(1.12,"%D",0)
 ;;=^^1^1^2930712^
 ;;^DIC(1.12,"%D",1,0)
 ;;=This file stores information and status of filegram activities.
 ;;^DD(1.12,0)
 ;;=FIELD^^.07^7
 ;;^DD(1.12,0,"ID",.03)
 ;;=W "   ",$P(^(0),U,3)
 ;;^DD(1.12,0,"ID",.04)
 ;;=S %I=Y,Y=$S('$D(^(0)):"",$D(^DIC(+$P(^(0),U,4),0))#2:$P(^(0),U,1),1:""),C=$P(^DD(1,.01,0),U,2) D Y^DIQ:Y]"" W "   ",Y,@("$E("_DIC_"%I,0),0)") S Y=%I K %I
 ;;^DD(1.12,0,"IX","B",1.12,.01)
 ;;=
 ;;^DD(1.12,.01,0)
 ;;=DATE/TIME^RDX^^0;1^S %DT="ETX" D ^%DT S X=Y K:Y<1 X
 ;;^DD(1.12,.01,1,0)
 ;;=^.1
 ;;^DD(1.12,.01,1,1,0)
 ;;=1.12^B
 ;;^DD(1.12,.01,1,1,1)
 ;;=S ^DIAR(1.12,"B",$E(X,1,30),DA)=""
 ;;^DD(1.12,.01,1,1,2)
 ;;=K ^DIAR(1.12,"B",$E(X,1,30),DA)
 ;;^DD(1.12,.01,3)
 ;;=
 ;;^DD(1.12,.02,0)
 ;;=SENT/INSTALLED^RS^s:SENT;i:INSTALLED;u:UNSUCCESSFUL;^0;2^Q
 ;;^DD(1.12,.03,0)
 ;;=USER^RF^^0;3^K:$L(X)>30!($L(X)<1) X
 ;;^DD(1.12,.03,3)
 ;;=Answer must be 1-30 characters in length.
 ;;^DD(1.12,.04,0)
 ;;=FILE^P1'^DIC(^0;4^Q
 ;;^DD(1.12,.05,0)
 ;;=ENTRY NUMBER^RNJ8,0^^0;5^K:+X'=X!(X>99999999)!(X<.001)!(X?.E1"."1N.N) X
 ;;^DD(1.12,.05,3)
 ;;=Type a Number between .001 and 99999999, 0 Decimal Digits
 ;;^DD(1.12,.06,0)
 ;;=MESSAGE^P3.9'^XMB(3.9,^0;6^Q
 ;;^DD(1.12,.07,0)
 ;;=FILEGRAM^P.4'^DIPT(^0;7^Q

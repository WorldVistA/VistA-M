DINIT14 ;SFISC/YJK-INITIALIZE VA FILEMAN ;08:33 AM  13 Aug 2002
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**999**
 ;
 F I=1:2 S X=$T(Q+I) G:X="" ^DINIT2 S Y=$E($T(Q+I+1),5,999),X=$E(X,4,999),@X=Y
Q Q
 ;;^DIC(.6,0)
 ;;=DD AUDIT^.6
 ;;^DIC(.6,0,"GL")
 ;;=^DDA(
 ;;^DIC("B","DD AUDIT",.6)
 ;;=
 ;;^DIC(.6,"%D",0)
 ;;=^^1^1^2940908^
 ;;^DIC(.6,"%D",1,0)
 ;;=This file stores an audit trail of changes made to data dictionaries.
 ;;^DD(.6,0)
 ;;=FIELD^^.07^12
 ;;^DD(.6,0,"ID",.03)
 ;;=W "   ",$$NAKED^DIUTL("$$DATE^DIUTL($P(^(0),U,3))")
 ;;^DD(.6,0,"ID",.04)
 ;;=S %I=Y,Y=$S('$D(^(0)):"",$D(^VA(200,+$P(^(0),U,4),0))#2:$P(^(0),U,1),1:""),C=$P($G(^DD(200,.01,0)),U,2) D:C]"" Y^DIQ:Y]"" W "   ",Y,@("$E("_DIC_"%I,0),0)") S Y=%I K %I
 ;;^DD(.6,0,"NM","DD AUDIT")
 ;;=
 ;;^DD(.6,.001,0)
 ;;=NUMBER^NJ7,0^^ ^K:+X'=X!(X>9999999)!(X<1)!(X?.E1"."1N.N) X
 ;;^DD(.6,.001,3)
 ;;=A whole number greater than 1.
 ;;^DD(.6,.01,0)
 ;;=FIELD NUMBER^RF^^0;1^K:$L(X)>10!($L(X)<1)!'(X'?1P.E) X
 ;;^DD(.6,.01,1,0)
 ;;=^.1
 ;;^DD(.6,.01,1,1,0)
 ;;=.6^B
 ;;^DD(.6,.01,1,1,1)
 ;;=S ^DDA(DDA,"B",$E(X,1,30),DA)=""
 ;;^DD(.6,.01,1,1,2)
 ;;=K ^DDA(DDA,"B",$E(X,1,30),DA)
 ;;^DD(.6,.01,3)
 ;;=Answer must be 1-10 characters in length.
 ;;^DD(.6,.02,0)
 ;;=TYPE^RS^E:EDIT;N:NEW;D:DELETE;^0;2^Q
 ;;^DD(.6,.03,0)
 ;;=DATE UPDATED^RD^^0;3^S %DT="ETR" D ^%DT S X=Y K:Y<1 X
 ;;^DD(.6,.03,1,0)
 ;;=^.1
 ;;^DD(.6,.03,1,1,0)
 ;;=.6^D
 ;;^DD(.6,.03,1,1,1)
 ;;=S ^DDA(DDA,"D",$E(X,1,30),DA)=""
 ;;^DD(.6,.03,1,1,2)
 ;;=K ^DDA(DDA,"D",$E(X,1,30),DA)
 ;;^DD(.6,.04,0)
 ;;=USER^RP200'^VA(200,^0;4^Q
 ;;^DD(.6,.04,1,0)
 ;;=^.1
 ;;^DD(.6,.04,1,1,0)
 ;;=.6^E
 ;;^DD(.6,.04,1,1,1)
 ;;=S ^DDA(DDA,"E",$E(X,1,30),DA)=""
 ;;^DD(.6,.04,1,1,2)
 ;;=K ^DDA(DDA,"E",$E(X,1,30),DA)
 ;;^DD(.6,.05,0)
 ;;=ATTRIBUTE NAME^F^^0;5^K:$L(X)>75!($L(X)<1) X
 ;;^DD(.6,.05,3)
 ;;=Answer must be 1-75 characters in length.
 ;;^DD(.6,.06,0)
 ;;=ATTRIBUTE NUMBER^F^^0;6^K:$L(X)>30!($L(X)<1) X
 ;;^DD(.6,.06,3)
 ;;=Answer must be 1-30 characters in length.
 ;;^DD(.6,.07,0)
 ;;=FILE NUMBER^F^^0;7^K:$L(X)>15!($L(X)<1) X
 ;;^DD(.6,.07,3)
 ;;=Answer must be 1-15 characters in length.
 ;;^DD(.6,1,0)
 ;;=OLD VALUE^F^^1;E1,245^K:$L(X)>245!($L(X)<1) X
 ;;^DD(.6,1.1,0)
 ;;=OLD VALUE(S)^.601^^1.1;0
 ;;^DD(.6,2,0)
 ;;=NEW VALUE^F^^2;E1,245^K:$L(X)>245!($L(X)<1) X
 ;;^DD(.6,2.1,0)
 ;;=NEW VALUE(S)^.602^^2.1;0
 ;;^DD(.601,0)
 ;;=OLD VALUE(S) SUB-FIELD^^.01^1
 ;;^DD(.601,0,"NM","OLD VALUE(S)")
 ;;=
 ;;^DD(.601,0,"UP")
 ;;=.6
 ;;^DD(.601,.01,0)
 ;;=OLD VALUE(S)^WL^^0;1^Q
 ;;^DD(.602,0)
 ;;=NEW VALUE(S) SUB-FIELD^^.01^1
 ;;^DD(.602,0,"NM","NEW VALUE(S)")
 ;;=
 ;;^DD(.602,0,"UP")
 ;;=.6
 ;;^DD(.602,.01,0)
 ;;=NEW VALUE(S)^WL^^0;1^Q

DINIT22 ;SFISC/DPC-LOAD DATA TYPE FILE DD ;9/9/94  13:22
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(Q+I) G ^DINIT220:X="" S Y=$E($T(Q+I+1),5,999),X=$E(X,4,999),@X=Y
Q Q
 ;;^DIC(.81,0,"GL")
 ;;=^DI(.81,
 ;;^DIC("B","DATA TYPE",.81)
 ;;=
 ;;^DIC(.81,"%D",0)
 ;;=^^2^2^2940908^
 ;;^DIC(.81,"%D",1,0)
 ;;=This file stores all of the data types that VA FileMan allows in the
 ;;^DIC(.81,"%D",2,0)
 ;;=MODIFY FILE ATTRIBUTES option.
 ;;^DD(.81,0)
 ;;=FIELD^^1^2
 ;;^DD(.81,0,"DDA")
 ;;=N
 ;;^DD(.81,0,"DT")
 ;;=2921009
 ;;^DD(.81,0,"IX","B",.81,.01)
 ;;=
 ;;^DD(.81,0,"IX","C",.81,1)
 ;;=
 ;;^DD(.81,0,"NM","DATA TYPE")
 ;;=
 ;;^DD(.81,0,"PT",.42,1)
 ;;=
 ;;^DD(.81,.01,0)
 ;;=NAME^RF^^0;1^K:$L(X)>30!(X?.N)!($L(X)<3)!'(X'?1P.E) X K X
 ;;^DD(.81,.01,1,0)
 ;;=^.1
 ;;^DD(.81,.01,1,1,0)
 ;;=.81^B
 ;;^DD(.81,.01,1,1,1)
 ;;=S ^DI(.81,"B",$E(X,1,30),DA)=""
 ;;^DD(.81,.01,1,1,2)
 ;;=K ^DI(.81,"B",$E(X,1,30),DA)
 ;;^DD(.81,.01,3)
 ;;=NAME MUST BE 3-30 CHARACTERS, NOT NUMERIC OR STARTING WITH PUNCTUATION
 ;;^DD(.81,.01,"DEL",1,0)
 ;;=I DA<100
 ;;^DD(.81,1,0)
 ;;=INTERNAL REPRESENTATION^F^^0;2^K:X[""""!($A(X)=45) X I $D(X) K:$L(X)>1!($L(X)<1) X
 ;;^DD(.81,1,1,0)
 ;;=^.1
 ;;^DD(.81,1,1,1,0)
 ;;=.81^C
 ;;^DD(.81,1,1,1,1)
 ;;=S ^DI(.81,"C",$E(X,1,30),DA)=""
 ;;^DD(.81,1,1,1,2)
 ;;=K ^DI(.81,"C",$E(X,1,30),DA)
 ;;^DD(.81,1,1,1,"DT")
 ;;=2921009
 ;;^DD(.81,1,3)
 ;;=Answer must be 1 character in length.
 ;;^DD(.81,1,"DT")
 ;;=2921009

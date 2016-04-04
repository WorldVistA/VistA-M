DINIT255 ;SFISC/MLH-FILEGRAM ERROR LOG ;9/9/94  14:26
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(Q+I) G ^DINIT26:X="" S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
Q Q
 ;;^DIC(1.13,"%D",0)
 ;;=^^2^2^2930712^
 ;;^DIC(1.13,"%D",1,0)
 ;;=This file stores information about Filegram errors and the text
 ;;^DIC(1.13,"%D",2,0)
 ;;=of the affected Filegrams.
 ;;^DD(1.13,0,"IX","B",1.13,.01)
 ;;=
 ;;^DIC("B","FILEGRAM ERROR LOG",1.13)
 ;;=
 ;;^DD(1.13,0)
 ;;=FIELD^^2100^4
 ;;^DD(1.13,0,"DDA")
 ;;=N
 ;;^DD(1.13,0,"DT")
 ;;=2900904
 ;;^DD(1.13,0,"NM","FILEGRAM ERROR LOG")
 ;;=
 ;;^DD(1.13,.001,0)
 ;;=FILEGRAM NUMBER^NJ6,0^^ ^K:+X'=X!(X>999999)!(X<1)!(X?.E1"."1N.N) X
 ;;^DD(1.13,.001,3)
 ;;=Type a Number between 1 and 999999, 0 Decimal Digits
 ;;^DD(1.13,.001,23,0)
 ;;=^^1^1^2900904^
 ;;^DD(1.13,.001,23,1,0)
 ;;=Filegram number
 ;;^DD(1.13,.001,"DT")
 ;;=2900904
 ;;^DD(1.13,.01,0)
 ;;=LINE OF ERROR^RNJ5,0^^0;1^K:+X'=X!(X>99999)!(X<1)!(X?.E1"."1N.N) X
 ;;^DD(1.13,.01,1,0)
 ;;=^.1
 ;;^DD(1.13,.01,1,1,0)
 ;;=1.13^B
 ;;^DD(1.13,.01,1,1,1)
 ;;=S ^DIAR(1.13,"B",$E(X,1,30),DA)=""
 ;;^DD(1.13,.01,1,1,2)
 ;;=K ^DIAR(1.13,"B",$E(X,1,30),DA)
 ;;^DD(1.13,.01,3)
 ;;=Type a Number between 1 and 99999, 0 Decimal Digits
 ;;^DD(1.13,.01,23,0)
 ;;=^^2^2^2900904^
 ;;^DD(1.13,.01,23,1,0)
 ;;=Line number returned in second piece of DIFGER indicating filegram line
 ;;^DD(1.13,.01,23,2,0)
 ;;=where error occurred
 ;;^DD(1.13,.01,"DT")
 ;;=2900904
 ;;^DD(1.13,.02,0)
 ;;=ERROR CODE^NJ2,0^^0;2^K:+X'=X!(X>99)!(X<1)!(X?.E1"."1N.N) X
 ;;^DD(1.13,.02,3)
 ;;=Type a Number between 1 and 99, 0 Decimal Digits
 ;;^DD(1.13,.02,23,0)
 ;;=^^2^2^2900904^
 ;;^DD(1.13,.02,23,1,0)
 ;;=Error code returned in first piece of DIFGER indicating type of
 ;;^DD(1.13,.02,23,2,0)
 ;;=installation error
 ;;^DD(1.13,.02,"DT")
 ;;=2900904
 ;;^DD(1.13,2100,0)
 ;;=FILEGRAM^1.1321^^21;0
 ;;^DD(1.13,2100,23,0)
 ;;=^^1^1^2900904^
 ;;^DD(1.13,2100,23,1,0)
 ;;=Text of the filegram
 ;;^DD(1.1321,0)
 ;;=FILEGRAM SUB-FIELD^^.01^1
 ;;^DD(1.1321,0,"DT")
 ;;=2900904
 ;;^DD(1.1321,0,"NM","FILEGRAM")
 ;;=
 ;;^DD(1.1321,0,"UP")
 ;;=1.13
 ;;^DD(1.1321,.01,0)
 ;;=FILEGRAM^WL^^0;1^Q
 ;;^DD(1.1321,.01,"DT")
 ;;=2900904

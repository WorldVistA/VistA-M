DINIT25 ;SFISC/XAK-INITIALIZE VA FILEMAN ;3/16/94  11:26 AM
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(Q+I) G ^DINIT250:X="" S Y=$E($T(Q+I+1),5,999),X=$E(X,4,999),@X=Y
Q Q
 ;;^DD(.41,0)
 ;;=FILEGRAM/EXTR FILE SUB-FIELD^^13^13
 ;;^DD(.41,0,"NM","FILEGRAM/EXTR FILE")
 ;;=
 ;;^DD(.41,0,"UP")
 ;;=.4
 ;;^DD(.41,.001,0)
 ;;=ORDER^NJ4,0^^ ^K:+X'=X!(X>9999)!(X<1)!(X?.E1"."1N.N) X
 ;;^DD(.41,.001,3)
 ;;=Type a Number between 1 and 9999, 0 Decimal Digits
 ;;^DD(.41,.01,0)
 ;;=FILEGRAM/EXTR FILE^NJ16,4^^0;1^K:+X'=X!(X>99999999999)!(X<2)!(X?.E1"."5N.N) X
 ;;^DD(.41,.01,1,0)
 ;;=^.1
 ;;^DD(.41,.01,1,1,0)
 ;;=.41^B
 ;;^DD(.41,.01,1,1,1)
 ;;=S ^DIPT(DA(1),1,"B",$E(X,1,30),DA)=""
 ;;^DD(.41,.01,1,1,2)
 ;;=K ^DIPT(DA(1),1,"B",$E(X,1,30),DA)
 ;;^DD(.41,.01,3)
 ;;=Type a Number between 2 and 99999999999, 4 Decimal Digits
 ;;^DD(.41,.02,0)
 ;;=LEVEL^RNJ2,0^^0;2^K:+X'=X!(X>99)!(X<1)!(X?.E1"."1N.N) X
 ;;^DD(.41,.02,3)
 ;;=Type a Number between 1 and 99, 0 Decimal Digits
 ;;^DD(.41,.03,0)
 ;;=PARENT^NJ14,4^^0;3^K:+X'=X!(X>999999999)!(X<2)!(X?.E1"."5N.N) X
 ;;^DD(.41,.03,3)
 ;;=Type a Number between 2 and 999999999, 4 Decimal Digits
 ;;^DD(.41,.04,0)
 ;;=LINK TYPE^S^1:DINUM;2:DIRECT POINTER;3:MULTIPLE;4:BACKPOINTER^0;4^Q
 ;;^DD(.41,.05,0)
 ;;=USER RESPONSE TO GET HERE^F^^0;5^K:$L(X)>30!($L(X)<1) X
 ;;^DD(.41,.05,3)
 ;;=Answer must be 1-30 characters in length.
 ;;^DD(.41,.06,0)
 ;;=DATE LAST STORED^D^^0;6^S %DT="EX" D ^%DT S X=Y K:Y<1 X
 ;;^DD(.41,.07,0)
 ;;=CROSS-REFERENCE^F^^0;7^K:$L(X)>30!($L(X)<1) X
 ;;^DD(.41,.07,3)
 ;;=Answer must be 1-30 characters in length.
 ;;^DD(.41,.07,21,0)
 ;;=^^1^1^2900405^
 ;;^DD(.41,.07,21,1,0)
 ;;=This field holds the X-ref to use in a backpointer.
 ;;^DD(.41,.08,0)
 ;;=ALL FIELDS IN FILE^S^1:YES;^0;8^Q
 ;;^DD(.41,10,0)
 ;;=FIELD NUMBER^.411A^^F;0
 ;;^DD(.41,11,0)
 ;;=DESTINATION FILE^NJ16,6^^0;9^K:+X'=X!(X>999999999)!(X<2)!(X?.E1"."7N.N) X
 ;;^DD(.41,11,3)
 ;;=Type a Number between 2 and 999999999, 6 Decimal Digits
 ;;^DD(.41,11,21,0)
 ;;=^^1^1^2921002^
 ;;^DD(.41,11,21,1,0)
 ;;=This field holds the number of the destination file or the destination subfile.
 ;;^DD(.41,12,0)
 ;;=DESTINATION FILE PARENT^NJ16,6^^0;10^K:+X'=X!(X>999999999)!(X<2)!(X?.E1"."7N.N) X
 ;;^DD(.41,12,3)
 ;;=Type a Number between 2 and 999999999, 6 Decimal Digits
 ;;^DD(.41,12,21,0)
 ;;=^^2^2^2921002^
 ;;^DD(.41,12,21,1,0)
 ;;=This field holds the number of the parent file or subfile of the
 ;;^DD(.41,12,21,2,0)
 ;;=DESTINATION FILE.
 ;;^DD(.41,13,0)
 ;;=DESTINATION FILE LOCATION^F^^0;11^K:$L(X)>30!($L(X)<1) X
 ;;^DD(.41,13,3)
 ;;=Answer must be 1-30 characters in length.
 ;;^DD(.41,13,21,0)
 ;;=^^1^1^2921002^
 ;;^DD(.41,13,21,1,0)
 ;;=This field holds the node and piece location of the DESTINATION FILE.
 ;;^DD(.411,0)
 ;;=FIELD NUMBER SUB-FIELD^^4^5
 ;;^DD(.411,0,"NM","FIELD NUMBER")
 ;;=
 ;;^DD(.411,0,"UP")
 ;;=.41
 ;;^DD(.411,.001,0)
 ;;=FIELD ORDER^NJ8,0^^ ^K:+X'=X!(X>99999999)!(X<1)!(X?.E1"."1N.N) X
 ;;^DD(.411,.001,3)
 ;;=Type a Number between 1 and 99999999, 0 Decimal Digits
 ;;^DD(.411,.01,0)
 ;;=FIELD NUMBER^NJ14,4^^0;1^K:+X'=X!(X>999999999)!(X<.001)!(X?.E1"."5N.N) X
 ;;^DD(.411,.01,1,0)
 ;;=^.1^^0
 ;;^DD(.411,.01,3)
 ;;=Type a Number between .001 and 999999999, 4 Decimal Digits
 ;;^DD(.411,1,0)
 ;;=CAPTION^CJ30^^ ; ^S %=+^DIPT(D0,1,D1,0),X=$S('%:"",$D(^DD(%,+^DIPT(D0,1,D1,"F",D2,0),0)):$P(^(0),U),1:"")
 ;;^DD(.411,1,9)
 ;;=^
 ;;^DD(.411,1,9.01)
 ;;=
 ;;^DD(.411,1,9.1)
 ;;=S %=+^DIPT(D0,1,D1,0),X=$S('%:"",$D(^DD(%,+^DIPT(D0,1,D1,"F",D2,0),0)):$P(^(0),U),1:"")
 ;;^DD(.411,3,0)
 ;;=DESTINATION FIELD NUMBER^NJ14,4^^0;3^K:+X'=X!(X>999999999)!(X<.001)!(X?.E1"."5N.N) X
 ;;^DD(.411,3,3)
 ;;=Type a Number between .001 and 999999999, 4 Decimal Digits
 ;;^DD(.411,3,21,0)
 ;;=^^2^2^2921002^
 ;;^DD(.411,3,21,1,0)
 ;;=This field holds the number of the field in the destination file
 ;;^DD(.411,3,21,2,0)
 ;;=that will contain the extracted data from FIELD NUMBER in the source file.
 ;;^DD(.411,4,0)
 ;;=DESTINATION FIELD LOCATION^F^^0;4^K:$L(X)>30!($L(X)<3) X
 ;;^DD(.411,4,3)
 ;;=Answer must be 3-30 characters in length.
 ;;^DD(.411,4,21,0)
 ;;=^^3^3^2921002^
 ;;^DD(.411,4,21,1,0)
 ;;=This field holds the node and piece location of the DESTINATION FIELD
 ;;^DD(.411,4,21,2,0)
 ;;=NUMBER. This is used at the time extract data is moved to the destination
 ;;^DD(.411,4,21,3,0)
 ;;=file.
 ;;^DD(.411,5,0)
 ;;= EXTERNAL FORMAT^S^1:MOVE EXTERNAL FORMAT TO DESTINATION FILE;^0;5^Q
 ;;^DD(.411,5,3)
 ;;=Enter 1 if external format of data should be moved to destination file.
 ;;^DD(.411,5,21,0)
 ;;=^^3^3^2921208^
 ;;^DD(.411,5,21,1,0)
 ;;=This code is used to determine if the external form of the data in the
 ;;^DD(.411,5,21,2,0)
 ;;=source file should be moved to the destination file.  If null, the
 ;;^DD(.411,5,21,3,0)
 ;;=internal format of the data is moved.

DINIT250 ;SFISC/DPC-LOAD PRINT TEMPLATE FILE DD (CONT) ;10/14/94  14:56
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(Q+I) G ^DINIT255:X="" S Y=$E($T(Q+I+1),5,999),X=$E(X,4,999),@X=Y
Q Q
 ;;^DD(.42,0)
 ;;=EXPORT FIELD SUB-FIELD^^3^4
 ;;^DD(.42,0,"DT")
 ;;=2921013
 ;;^DD(.42,0,"IX","B",.42,.01)
 ;;=
 ;;^DD(.42,0,"NM","EXPORT FIELD")
 ;;=
 ;;^DD(.42,0,"UP")
 ;;=.4
 ;;^DD(.42,.01,0)
 ;;=FIELD ORDER^RNJ2,0^^0;1^K:+X'=X!(X>99)!(X<1)!(X?.E1"."1N.N) X
 ;;^DD(.42,.01,1,0)
 ;;=^.1
 ;;^DD(.42,.01,1,1,0)
 ;;=.42^B
 ;;^DD(.42,.01,1,1,1)
 ;;=S ^DIPT(DA(1),100,"B",$E(X,1,30),DA)=""
 ;;^DD(.42,.01,1,1,2)
 ;;=K ^DIPT(DA(1),100,"B",$E(X,1,30),DA)
 ;;^DD(.42,.01,3)
 ;;=Type a Number between 1 and 99, 0 Decimal Digits
 ;;^DD(.42,.01,21,0)
 ;;=^^3^3^2941014^^
 ;;^DD(.42,.01,21,1,0)
 ;;=The integer in this field represents the order in which fields are
 ;;^DD(.42,.01,21,2,0)
 ;;=exported.  The field order numbers are not always consecutive,
 ;;^DD(.42,.01,21,3,0)
 ;;=but they do represent the sequence in which fields are sent.
 ;;^DD(.42,.01,"DT")
 ;;=2920903
 ;;^DD(.42,1,0)
 ;;=DATA TYPE^*P.81'^DI(.81,^0;2^S DIC("S")="N %IR S %IR=$P($G(^(0)),U,2) I (%IR=""D"")!(%IR=""N"")!(%IR=""F"")" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 ;;^DD(.42,1,3)
 ;;=
 ;;^DD(.42,1,12)
 ;;=Only data types of free text, date, and numeric are recognized for exported fields.
 ;;^DD(.42,1,12.1)
 ;;=S DIC("S")="N %IR S %IR=$P($G(^(0)),U,2) I (%IR=""D"")!(%IR=""N"")!(%IR=""F"")"
 ;;^DD(.42,1,21,0)
 ;;=^^3^3^2921119^
 ;;^DD(.42,1,21,1,0)
 ;;=The data type of the field as derived by the export tool or as input by the
 ;;^DD(.42,1,21,2,0)
 ;;=user is held in this field.  This data type may not correspond to the data
 ;;^DD(.42,1,21,3,0)
 ;;=type found in the data dictionary.
 ;;^DD(.42,1,"DT")
 ;;=2921013
 ;;^DD(.42,2,0)
 ;;=LENGTH FOR OUTPUT^NJ5,0^^0;3^K:+X'=X!(X>10000)!(X<1)!(X?.E1"."1N.N) X
 ;;^DD(.42,2,3)
 ;;=Type a Number between 1 and 10000, 0 Decimal Digits
 ;;^DD(.42,2,21,0)
 ;;=^^2^2^2921119^
 ;;^DD(.42,2,21,1,0)
 ;;=The number of characters allotted to the field for fixed length export is
 ;;^DD(.42,2,21,2,0)
 ;;=stored here.
 ;;^DD(.42,2,"DT")
 ;;=2920903
 ;;^DD(.42,3,0)
 ;;=NAME OF FOREIGN FIELD^F^^0;4^K:$L(X)>30!($L(X)<1) X
 ;;^DD(.42,3,3)
 ;;=Answer must be 1-30 characters in length.
 ;;^DD(.42,3,21,0)
 ;;=^^2^2^2921119^
 ;;^DD(.42,3,21,1,0)
 ;;=The name of the field as it is known in the importing application is
 ;;^DD(.42,3,21,2,0)
 ;;=stored here.  The user supplies this information.
 ;;^DD(.42,3,"DT")
 ;;=2921123

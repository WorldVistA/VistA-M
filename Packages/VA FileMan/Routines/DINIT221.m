DINIT221 ;SFISC/DPC - 'DATA TYPE PROPERTY' AND 'DATA TYPE METHOD' FILE DDs ;10MAR2016
 ;;22.2;VA FileMan;**2**;Jan 05, 2016;Build 139
 ;;Per VA Directive 6402, this routine should not be modified.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(Q+I) G ^DINIT220:X="" S Y=$E($T(Q+I+1),5,999),X=$E(X,4,999),@X=Y
Q Q
 ;;^DIC(.86,0,"GL")
 ;;=^DI(.86,
 ;;^DIC("B","DATA TYPE PROPERTY",.86)
 ;;=
 ;;^DIC(.86,"%D",0)
 ;;=^^1^1^
 ;;^DIC(.86,"%D",1,0)
 ;;=This file stores the names of different kinds of STRINGS that describe data.
 ;;^DD(.86,0)
 ;;=FIELD^^51^12
 ;;^DD(.86,0,"DDA")
 ;;=N
 ;;^DD(.86,0,"ID",1)
 ;;=W "   ",$P(^(0),U,2)
 ;;^DD(.86,0,"IX","B",.86,.01)
 ;;=
 ;;^DD(.86,0,"IX","C",.86,1)
 ;;=
 ;;^DD(.86,0,"NM","DATA TYPE PROPERTY")
 ;;=
 ;;^DD(.86,0,"PT",.81101,.01)
 ;;=
 ;;^DD(.86,.001,0)
 ;;=NUMBER^NJ16,2^^ ^K:+X'=X!(X>9999999999999.99)!(X<1)!(X?.E1"."3N.N) X
 ;;^DD(.86,.001,3)
 ;;=Type a Number between 1 and 9999999999999.99, 2 Decimal Digits
 ;;^DD(.86,.001,21,0)
 ;;=^^1^1^^
 ;;^DD(.86,.001,21,1,0)
 ;;=This NUMBER should be number-spaced to your institution, if you create a new one.
 ;;^DD(.86,.01,0)
 ;;=NAME^RF^^0;1^K:$L(X)>30!(X?.N)!($L(X)<3)!'(X'?1P.E) X
 ;;^DD(.86,.01,1,0)
 ;;=^.1
 ;;^DD(.86,.01,1,1,0)
 ;;=.86^B
 ;;^DD(.86,.01,1,1,1)
 ;;=S ^DI(.86,"B",$E(X,1,30),DA)=""
 ;;^DD(.86,.01,1,1,2)
 ;;=K ^DI(.86,"B",$E(X,1,30),DA)
 ;;^DD(.86,.01,3)
 ;;=Enter 3-30 characters, a unique name for the PROPERTY.
 ;;^DD(.86,.01,21,0)
 ;;=^^1^1^^
 ;;^DD(.86,.01,21,1,0)
 ;;=This NAME will appear in a list of PROPERTIES  (e.g., "FIELD LENGTH")
 ;;^DD(.86,1,0)
 ;;=ABBREVIATION^FIX^^0;2^K:$L(X)>10!($L(X)<2)!(X=+$P(X,"E")) X
 ;;^DD(.86,1,1,0)
 ;;=^.1
 ;;^DD(.86,1,1,1,0)
 ;;=.86^C
 ;;^DD(.86,1,1,1,1)
 ;;=S ^DI(.86,"C",$E(X,1,30),DA)=""
 ;;^DD(.86,1,1,1,2)
 ;;=K ^DI(.86,"C",$E(X,1,30),DA)
 ;;^DD(.86,1,1,1,"%D",0)
 ;;=^^1^1^
 ;;^DD(.86,1,1,1,"%D",1,0)
 ;;=This cross reference allows looking up a METHOD by its short ABBREVIATION, if there is one.
 ;;^DD(.86,1,3)
 ;;=Answer must be 2-10 characters in length.
 ;;^DD(.86,1,21,1,0)
 ;;=Enter an abbreviation for this property.  
 ;;^DD(.86,11,0)
 ;;=SHORT DESCRIPTION^F^^11;E1,245^K:$L(X)>245!($L(X)<1) X
 ;;^DD(.86,11,3)
 ;;=Answer must be 1-245 characters in length.
 ;;^DD(.86,11,21,0)
 ;;=^^1^1^^
 ;;^DD(.86,11,21,1,0)
 ;;=This should tell briefly what the PROPERTY is used for.
 ;;^DD(.86,21,0)
 ;;=DESCRIPTION^.861^^21;0
 ;;^DD(.86,41,0)
 ;;=DATA TYPE^P.81'^DI(.81,^41;1^Q
 ;;^DD(.86,41,3)
 ;;=Enter the data type (numeric or free-text, usually) of this PROPERTY.
 ;;^DD(.86,41,21,0)
 ;;=^^1^1^
 ;;^DD(.86,41,21,1,0)
 ;;=This should tell the attribute of the PROPERTY.
 ;;^DD(.86,42,0)
 ;;=DIR(0)^F^^42;E1,245^K:$L(X)>245!($L(X)<1) X
 ;;^DD(.86,42,3)
 ;;=Answer must be 1-245 characters in length.
 ;;^DD(.86,42,21,0)
 ;;=^^1^1^2951214^
 ;;^DD(.86,42,21,1,0)
 ;;=Enter the string that goes into DIR(0) for a ^DIR call.
 ;;^DD(.861,0)
 ;;=DESCRIPTION SUB-FIELD^^.01^1
 ;;^DD(.861,0,"NM","DESCRIPTION")
 ;;=
 ;;^DD(.861,0,"UP")
 ;;=.86
 ;;^DD(.861,.01,0)
 ;;=DESCRIPTION^W^^0;1^Q
 ;;^DIC(.87,0,"GL")
 ;;=^DI(.87,
 ;;^DIC("B","DATA TYPE METHOD",.87)
 ;;=
 ;;^DIC(.87,"%D",0)
 ;;=^^1^1
 ;;^DIC(.87,"%D",1,0)
 ;;=This file stores the names of different kinds of lines of MUMPS code that are used in the definitions of DATA TYPES
 ;;^DD(.87,0)
 ;;=FIELD^^.001^4
 ;;^DD(.87,0,"IX","B",.87,.01)
 ;;=
 ;;^DD(.87,0,"NM","DATA TYPE METHOD")
 ;;=
 ;;^DD(.87,0,"PT",.81201,.01)
 ;;=
 ;;^DD(.87,.001,0)
 ;;=NUMBER^NJ16,2^^ ^K:+X'=X!(X>9999999999999.99)!(X<1)!(X?.E1"."3N.N) X
 ;;^DD(.87,.001,3)
 ;;=Type a Number between 1 and 9999999999999.99, 2 Decimal Digits
 ;;^DD(.87,.001,21,0)
 ;;=^^1^1^^
 ;;^DD(.87,.001,21,1,0)
 ;;=This NUMBER should be number-spaced to your institution, if you create a new one.
 ;;^DD(.87,.01,0)
 ;;=NAME^RF^^0;1^K:$L(X)>50!($L(X)<3)!'(X'?1P.E) X
 ;;^DD(.87,.01,1,0)
 ;;=^.1
 ;;^DD(.87,.01,1,1,0)
 ;;=.87^B
 ;;^DD(.87,.01,1,1,1)
 ;;=S ^DI(.87,"B",$E(X,1,30),DA)=""
 ;;^DD(.87,.01,1,1,2)
 ;;=K ^DI(.87,"B",$E(X,1,30),DA)
 ;;^DD(.87,.01,3)
 ;;=Answer with a NAME 3-50 characters in length.
 ;;^DD(.87,.01,21,0)
 ;;=^^1^1^^
 ;;^DD(.87,.01,21,1,0)
 ;;=This NAME will appear in a list of METHODs  (e.g., "INPUT TRANSFORM")
 ;;^DD(.87,11,0)
 ;;=SHORT DESCRIPTION^F^^11;E1,245^K:$L(X)>245!($L(X)<1) X
 ;;^DD(.87,11,3)
 ;;=Answer must be 1-245 characters in length.
 ;;^DD(.87,11,21,0)
 ;;=^^1^1^^
 ;;^DD(.87,11,21,1,0)
 ;;=This should tell briefly what the METHOD is used for.
 ;;^DD(.87,21,0)
 ;;=DESCRIPTION^.871^^21;0
 ;;^DD(.871,0)
 ;;=DESCRIPTION SUB-FIELD^^.01^1
 ;;^DD(.871,0,"NM","DESCRIPTION")
 ;;=
 ;;^DD(.871,0,"UP")
 ;;=.87
 ;;^DD(.871,.01,0)
 ;;=DESCRIPTION^W^^0;1^Q

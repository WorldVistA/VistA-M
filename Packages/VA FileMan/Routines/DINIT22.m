DINIT22 ;SFISC/DPC - DATA TYPE FILE DD ;23NOV2016
 ;;22.2;VA FileMan;**2**;Jan 05, 2016;Build 139
 ;;Per VA Directive 6402, this routine should not be modified.
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC FileMan 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 K ^DD(.81101,"GL")
 F I=1:2 S X=$T(Q+I) G ^DINIT221:X="" S Y=$E($T(Q+I+1),5,999),X=$E(X,4,999),@X=Y
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
 ;;=FIELD^^201^9
 ;;^DD(.81,0,"DDA")
 ;;=N
 ;;^DD(.81,0,"IX","B",.81,.01)
 ;;=
 ;;^DD(.81,0,"IX","C",.81,1)
 ;;=
 ;;^DD(.81,0,"NM","DATA TYPE")
 ;;=
 ;;^DD(.81,0,"PT",.4014,15)
 ;;=
 ;;^DD(.81,0,"PT",.42,1)
 ;;=
 ;;^DD(.81,0,"PT",.86,41)
 ;;=
 ;;^DD(.81,.001,0)
 ;;=NUMBER^NJ16,2^^ ^K:+X'=X!(X>9999999999999.99)!(X<1)!(X?.E1"."3N.N) X
 ;;^DD(.81,.001,3)
 ;;=Type a Number between 1 and 9999999999999.99, 2 Decimal Digits
 ;;^DD(.81,.01,0)
 ;;=NAME^RF^^0;1^K:$L(X)>30!(X?.N)!($L(X)<3)!'(X'?1P.E) X
 ;;^DD(.81,.01,1,0)
 ;;=^.1
 ;;^DD(.81,.01,1,1,0)
 ;;=.81^B
 ;;^DD(.81,.01,1,1,1)
 ;;=S ^DI(.81,"B",$E(X,1,30),DA)=""
 ;;^DD(.81,.01,1,1,2)
 ;;=K ^DI(.81,"B",$E(X,1,30),DA)
 ;;^DD(.81,.01,3)
 ;;=NAME MUST BE 3-30 CHARACTERS
 ;;^DD(.81,.01,"DEL",1,0)
 ;;=D DELETEQ^DIETLIB
 ;;^DD(.81,1,0)
 ;;=INTERNAL REPRESENTATION^F^^0;2^I ",N,F,D,S,P,K,"'[X!($L(X)>1) K X
 ;;^DD(.81,1,1,0)
 ;;=^.1
 ;;^DD(.81,1,1,1,0)
 ;;=.81^C
 ;;^DD(.81,1,1,1,1)
 ;;=S ^DI(.81,"C",$E(X,1,30),DA)=""
 ;;^DD(.81,1,1,1,2)
 ;;=K ^DI(.81,"C",$E(X,1,30),DA)
 ;;^DD(.81,1,3)
 ;;=MUST BE ONE OF THE BASIC CODES (N,F,D,S,P,K) DENOTING FILEMAN FIELD TYPES
 ;;^DD(.81,2,0)
 ;;=STANDARD PROMPT^F^^0;3^K:$L(X)>70!($L(X)<1) X
 ;;^DD(.81,2,3)
 ;;=Answer must be 1-70 characters in length.
 ;;^DD(.81,2,21,0)
 ;;=^^2^2^2960124^
 ;;^DD(.81,2,21,1,0)
 ;;=This is the default prompt used during a Reader (^DIR) call of this
 ;;^DD(.81,2,21,2,0)
 ;;=data type, when no prompt is supplied in DIR("A").
 ;;^DD(.81,3,0)
 ;;=SORT BY EXTERNAL?^S^0:NO;1:YES;^0;4^Q
 ;;^DD(.81,3,21,0)
 ;;=^^2^2^2960806^
 ;;^DD(.81,3,21,1,0)
 ;;=Enter 'YES' if, by default, data of this data type should sort by its
 ;;^DD(.81,3,21,2,0)
 ;;=external rather than internal form.
 ;;^DD(.81,11,0)
 ;;=SHORT DESCRIPTION^F^^11;E1,245^K:$L(X)>245!($L(X)<1) X
 ;;^DD(.81,11,3)
 ;;=Answer must be 1-245 characters in length.
 ;;^DD(.81,21,0)
 ;;=DESCRIPTION^.8121^^21;0
 ;;^DD(.81,41,0)
 ;;=FIELDS DEFINED BY THIS TYPE^.81215^^41;0
 ;;^DD(.81,41,9)
 ;;=^
 ;;^DD(.81,41,21,0)
 ;;=^^2^2^
 ;;^DD(.81,41,21,1,0)
 ;;=This multiple field list all fields in this database that point to this DATA TYPE.  These are not editable here.
 ;;^DD(.81,41,21,2,0)
 ;;=The values are stuffed automatically when a field using this DATA TYPE is created under 'MODIFY FILE ATTRIBUTES'.
 ;;^DD(.81,101,0)
 ;;=PROPERTY^.81101P^^101;0
 ;;^DD(.81,101,21,0)
 ;;=^^1^1
 ;;^DD(.81,101,21,1,0)
 ;;=This multiple lists all the PROPERTIES that specify what this DATA TYPE does.
 ;;^DD(.81,201,0)
 ;;=METHOD^.81201P^^201;0
 ;;^DD(.81,201,21,0)
 ;;=^^1^1
 ;;^DD(.81,201,21,1,0)
 ;;=This multiple lists all the METHODS that specify what this DATA TYPE does.
 ;;^DD(.81101,0)
 ;;=PROPERTY SUB-FIELD^^61^8
 ;;^DD(.81101,0,"IX","AC",.81101,1)
 ;;=
 ;;^DD(.81101,0,"IX","B",.81101,.01)
 ;;=
 ;;^DD(.81101,0,"NM","PROPERTY")
 ;;=
 ;;^DD(.81101,0,"UP")
 ;;=.81
 ;;^DD(.81101,.01,0)
 ;;=PROPERTY^MP.86X^DI(.86,^0;1^S DINUM=X
 ;;^DD(.81101,.01,1,0)
 ;;=^.1
 ;;^DD(.81101,.01,1,1,0)
 ;;=.81101^B
 ;;^DD(.81101,.01,1,1,1)
 ;;=S ^DI(.81,DA(1),101,"B",$E(X,1,30),DA)=""
 ;;^DD(.81101,.01,1,1,2)
 ;;=K ^DI(.81,DA(1),101,"B",$E(X,1,30),DA)
 ;;^DD(.81101,.01,3)
 ;;=Select a PROPERTY that needs to have a VALUE for this DATA TYPE.
 ;;^DD(.81101,.01,21,0)
 ;;=^^2^2
 ;;^DD(.81101,.01,21,1,0)
 ;;=Existing PROPERTY names should only be edited with great care.
 ;;^DD(.81101,.01,21,2,0)
 ;;=A PROPERTY is a string or number that defines something about the Data Type.
 ;;^DD(.81101,1,0)
 ;;=ORDER^NJ4,1^^0;2^K:+X'=X!(X>99.9)!(X<1)!(X?.E1"."2N.N) X
 ;;^DD(.81101,1,1,0)
 ;;=^.1
 ;;^DD(.81101,1,1,1,0)
 ;;=.81101^AC
 ;;^DD(.81101,1,1,1,1)
 ;;=S ^DI(.81,DA(1),101,"AC",$E(X,1,30),DA)=""
 ;;^DD(.81101,1,1,1,2)
 ;;=K ^DI(.81,DA(1),101,"AC",$E(X,1,30),DA)
 ;;^DD(.81101,1,1,1,"%D",0)
 ;;=^^1^1^
 ;;^DD(.81101,1,1,1,"%D",1,0)
 ;;=This cross reference allows sorting PROPERTIES by the ORDER in which they should be presented.
 ;;^DD(.81101,1,3)
 ;;=Type a Number between 1 and 99.9, 1 Decimal Digit
 ;;^DD(.81101,1,21,0)
 ;;=^^2^2^2951205^
 ;;^DD(.81101,1,21,1,0)
 ;;=Enter the relative order in which FileMan should prompt for this property
 ;;^DD(.81101,1,21,2,0)
 ;;=at field creation.
 ;;^DD(.81101,10,0)
 ;;=PROMPT?^K^^10;E1,245^K:$L(X)>245 X D:$D(X) ^DIM
 ;;^DD(.81101,10,3)
 ;;=This is Standard MUMPS code.
 ;;^DD(.81101,10,9)
 ;;=@
 ;;^DD(.81101,10,21,0)
 ;;=^^3^3^2951205^
 ;;^DD(.81101,10,21,1,0)
 ;;=Enter MUMPS code that sets $T.  If $T evaluates to TRUE, then FileMan
 ;;^DD(.81101,10,21,2,0)
 ;;=will prompt for this property when a field of this Data Type is created.
 ;;^DD(.81101,10,21,3,0)
 ;;=A null value is equivalent to "I 1".
 ;;^DD(.81101,31,0)
 ;;=VALUE^F^^31;E1,245^K:$L(X)>245!($L(X)<1) X
 ;;^DD(.81101,31,3)
 ;;=Enter the string that will become the default value for this PROPERTY, 1 to 245 characters.
 ;;^DD(.81101,31,21,0)
 ;;=^^3^3
 ;;^DD(.81101,31,21,1,0)
 ;;=This value will be inserted into the definition of fields defined by this Data Type Property.
 ;;^DD(.81101,31,21,2,0)
 ;;=For a PROPERTY like FIELD LENGTH, the VALUE will be a number.
 ;;^DD(.81101,31,21,3,0)
 ;;=For a PROPERTY like SET OF CODES, the VALUE will be a string (like "1:TRUE;0:FALSE")
 ;;^DD(.81101,33,0)
 ;;=DEFAULT VALUE PROMPTED^F^^33;E1,245^K:$L(X)>245!($L(X)<1) X
 ;;^DD(.81101,33,3)
 ;;=Enter the string that will show as the expected value (internal form) for this PROPERTY, 1 to 245 characters.
 ;;^DD(.81101,33,21,0)
 ;;=^^3^3
 ;;^DD(.81101,33,21,1,0)
 ;;=This field should have a value only if, when a new FileMan field is being created (MODIFY FILE ATTRIBUTES),
 ;;^DD(.81101,33,21,2,0)
 ;;=the PROPERTY should be prompted with a default.  For example, if a true/false PROPERTY normally takes a 'NO' value,
 ;;^DD(.81101,33,21,3,0)
 ;;=then this field has the value '0', which is usually the internal form of 'NO'.
 ;;^DD(.81201,0)
 ;;=METHOD SUB-FIELD^^31.1^4
 ;;^DD(.81201,0,"IX","B",.81201,.01)
 ;;=
 ;;^DD(.81201,0,"NM","METHOD")
 ;;=
 ;;^DD(.81201,0,"UP")
 ;;=.81
 ;;^DD(.81201,.01,0)
 ;;=METHOD^MP.87X^DI(.87,^0;1^S DINUM=X
 ;;^DD(.81201,.01,1,0)
 ;;=^.1
 ;;^DD(.81201,.01,1,1,0)
 ;;=.81201^B
 ;;^DD(.81201,.01,1,1,1)
 ;;=S ^DI(.81,DA(1),201,"B",$E(X,1,30),DA)=""
 ;;^DD(.81201,.01,1,1,2)
 ;;=K ^DI(.81,DA(1),201,"B",$E(X,1,30),DA)
 ;;^DD(.81201,.01,3)
 ;;=Select a METHOD that needs to have MUMPS code for this DATA TYPE.
 ;;^DD(.81201,.01,21,0)
 ;;=^^1^1
 ;;^DD(.81201,.01,21,1,0)
 ;;=This step allows a programmer to change the name of or specify the METHOD.
 ;;^DD(.81201,31,0)
 ;;=M CODE^F^^31;E1,245^D ^DIM
 ;;^DD(.81201,31,3)
 ;;=Enter MUMPS code that will perform the METHOD
 ;;^DD(.81201,31,9)
 ;;=@
 ;;^DD(.81201,31,21,0)
 ;;=^^1^1
 ;;^DD(.81201,31,21,1,0)
 ;;=Code that will do what the METHOD requires.
 ;;^DD(.8121,0)
 ;;=DESCRIPTION SUB-FIELD^^.01^1
 ;;^DD(.8121,0,"NM","DESCRIPTION")
 ;;=
 ;;^DD(.8121,0,"UP")
 ;;=.81
 ;;^DD(.8121,.01,0)
 ;;=DESCRIPTION^W^^0;1^Q
 ;;^DD(.81215,0)
 ;;=FIELD DEFINED BY THIS TYPE SUB-FIELD^^.01^1
 ;;^DD(.81215,0,"NM","FIELD DEFINED BY THIS TYPE")
 ;;=
 ;;^DD(.81215,0,"UP")
 ;;=.81
 ;;^DD(.81215,.01,0)
 ;;=FIELD DEFINED BY THIS TYPE^F^^0;1^I X'?1.NP1","1.NP K X
 ;;^DD(.81215,.01,1,0)
 ;;=^.1
 ;;^DD(.81215,.01,1,1,0)
 ;;=.81^AFDEF
 ;;^DD(.81215,.01,1,1,1)
 ;;=S ^DI(.81,"AFDEF",DA(1),$E(X,1,30),DA)=""
 ;;^DD(.81215,.01,1,1,2)
 ;;=K ^DI(.81,"AFDEF",DA(1),$E(X,1,30),DA)
 ;;^DD(.81215,.01,3)
 ;;=Enter a file number, then comma, then field number, of a field defined by this DATA TYPE

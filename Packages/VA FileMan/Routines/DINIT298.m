DINIT298 ;SFISC/MKO-FORM AND BLOCK FILES ;10:49 AM  30 Mar 1999
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
 G ^DINIT299
Q Q
 ;;^DD(.4044,10,21,16,0)
 ;;=The variable X contains the current internal value of the field, DDSEXT
 ;;^DD(.4044,10,21,17,0)
 ;;=contains the current external value of the field, and DDSOLD contains the
 ;;^DD(.4044,10,21,18,0)
 ;;=previous internal value of the field.
 ;;^DD(.4044,11,0)
 ;;=PRE ACTION^K^^11;E1,245^K:$L(X)>245 X D:$D(X) ^DIM
 ;;^DD(.4044,11,3)
 ;;=Enter standard MUMPS code that will be executed when the user navigates to this field.
 ;;^DD(.4044,11,9)
 ;;=@
 ;;^DD(.4044,11,21,0)
 ;;=^^2^2^2940629^
 ;;^DD(.4044,11,21,1,0)
 ;;=This MUMPS code is executed when the user reaches the field.  The variable
 ;;^DD(.4044,11,21,2,0)
 ;;=X contains the current value of the field.
 ;;^DD(.4044,12,0)
 ;;=POST ACTION^K^^12;E1,245^K:$L(X)>245 X D:$D(X) ^DIM
 ;;^DD(.4044,12,3)
 ;;=Enter standard MUMPS code that will be executed when the user leaves this field.
 ;;^DD(.4044,12,9)
 ;;=@
 ;;^DD(.4044,12,21,0)
 ;;=^^6^6^2950306^
 ;;^DD(.4044,12,21,1,0)
 ;;=This MUMPS code is executed when the user leaves the field, except on
 ;;^DD(.4044,12,21,2,0)
 ;;=time-out.
 ;;^DD(.4044,12,21,3,0)
 ;;= 
 ;;^DD(.4044,12,21,4,0)
 ;;=The variable X contains the current internal value of the field, DDSEXT
 ;;^DD(.4044,12,21,5,0)
 ;;=contains the current external value of the field, and DDSOLD contains
 ;;^DD(.4044,12,21,6,0)
 ;;=the previous internal value of the field.
 ;;^DD(.4044,12,"DT")
 ;;=2950306
 ;;^DD(.4044,13,0)
 ;;=POST ACTION ON CHANGE^K^^13;E1,245^K:$L(X)>245 X D:$D(X) ^DIM
 ;;^DD(.4044,13,3)
 ;;=Enter standard MUMPS code that will be executed when the user changes the value of this field.
 ;;^DD(.4044,13,9)
 ;;=@
 ;;^DD(.4044,13,21,0)
 ;;=^^4^4^2940629^
 ;;^DD(.4044,13,21,1,0)
 ;;=This MUMPS code is executed only if the user changed the value of the
 ;;^DD(.4044,13,21,2,0)
 ;;=field.  The variables X and DDSEXT contain the new internal and external
 ;;^DD(.4044,13,21,3,0)
 ;;=values of the field, and DDSOLD contains the original internal value of
 ;;^DD(.4044,13,21,4,0)
 ;;=the field.
 ;;^DD(.4044,13,"DT")
 ;;=2931029
 ;;^DD(.4044,14,0)
 ;;=DATA VALIDATION^K^^14;E1,245^K:$L(X)>245 X D:$D(X) ^DIM
 ;;^DD(.4044,14,3)
 ;;=This is Standard MUMPS code.
 ;;^DD(.4044,14,9)
 ;;=@
 ;;^DD(.4044,14,21,0)
 ;;=^^5^5^2940907^
 ;;^DD(.4044,14,21,1,0)
 ;;=Enter MUMPS code that will be executed after the user enters a new
 ;;^DD(.4044,14,21,2,0)
 ;;=value for this field.  If the code sets DDSERROR, the value will
 ;;^DD(.4044,14,21,3,0)
 ;;=be rejected.  You might also want to ring the bell and make a call to
 ;;^DD(.4044,14,21,4,0)
 ;;=HLP^DDSUTL to display a message to the user that indicates the reason the
 ;;^DD(.4044,14,21,5,0)
 ;;=value was rejected.
 ;;^DD(.4044,14,"DT")
 ;;=2930820
 ;;^DD(.4044,20.1,0)
 ;;=READ TYPE^S^D:DATE;F:FREE TEXT;L:LIST OR RANGE;N:NUMERIC;P:POINTER;S:SET OF CODES;Y:YES OR NO;DD:DATA DICTIONARY;^20;1^Q
 ;;^DD(.4044,20.1,21,0)
 ;;=^^1^1^2930812^^
 ;;^DD(.4044,20.1,21,1,0)
 ;;=Enter the data type of this form-only field.
 ;;^DD(.4044,20.1,"DT")
 ;;=2930812
 ;;^DD(.4044,20.2,0)
 ;;=PARAMETERS^F^^20;2^K:$L(X)>2!($L(X)<1) X
 ;;^DD(.4044,20.2,3)
 ;;=Answer must be 1-2 characters in length.
 ;;^DD(.4044,20.2,21,0)
 ;;=^^8^8^2940907^
 ;;^DD(.4044,20.2,21,1,0)
 ;;=This property coressponds to the parameters that can be used in the first
 ;;^DD(.4044,20.2,21,2,0)
 ;;=^-piece of the DIR(0) input variable to ^DIR.  The "O" parameter has no
 ;;^DD(.4044,20.2,21,3,0)
 ;;=effect, since the Required property can be used to make a field required.
 ;;^DD(.4044,20.2,21,4,0)
 ;;=The "A" and "B" parameters also have no effect.
 ;;^DD(.4044,20.2,21,5,0)
 ;;= 
 ;;^DD(.4044,20.2,21,6,0)
 ;;=Free text fields can use the "U" parameter.
 ;;^DD(.4044,20.2,21,7,0)
 ;;=List or Range fields can use the "C" parameter.
 ;;^DD(.4044,20.2,21,8,0)
 ;;=Set of Codes fields can use the "X" and "M" parameters.
 ;;^DD(.4044,20.2,"DT")
 ;;=2930812
 ;;^DD(.4044,20.3,0)
 ;;=QUALIFIERS^F^^20;3^K:$L(X)>100!($L(X)<1) X
 ;;^DD(.4044,20.3,3)
 ;;=Answer must be 1-100 characters in length.
 ;;^DD(.4044,20.3,21,0)
 ;;=^^14^14^2940908^^
 ;;^DD(.4044,20.3,21,1,0)
 ;;=This property corresponds to the second ^-piece of the DIR(0) input
 ;;^DD(.4044,20.3,21,2,0)
 ;;=variable to ^DIR.  For Data Dictionary type form only fields, it
 ;;^DD(.4044,20.3,21,3,0)
 ;;=identifies the file and field.
 ;;^DD(.4044,20.3,21,4,0)
 ;;= 
 ;;^DD(.4044,20.3,21,5,0)
 ;;=Valid qualifiers are:
 ;;^DD(.4044,20.3,21,6,0)
 ;;= 
 ;;^DD(.4044,20.3,21,7,0)
 ;;=  Date             Minimum date:Maximum date:%DT
 ;;^DD(.4044,20.3,21,8,0)
 ;;=  Free Text        Minimum length:Maximum length
 ;;^DD(.4044,20.3,21,9,0)
 ;;=  List or Range    Minimum:Maximum:Maximum decimals
 ;;^DD(.4044,20.3,21,10,0)
 ;;=  Numeric          Minimum:Maximum:Maximum decimals
 ;;^DD(.4044,20.3,21,11,0)
 ;;=  Pointer          Global root or #:DIC(0)
 ;;^DD(.4044,20.3,21,12,0)
 ;;=  Set of Codes     Code:Stands for;Code:Stands for;
 ;;^DD(.4044,20.3,21,13,0)
 ;;=  Yes or No
 ;;^DD(.4044,20.3,21,14,0)
 ;;=  Data Dictionary  file#,field#
 ;;^DD(.4044,20.3,"DT")
 ;;=2930812
 ;;^DD(.4044,21,0)
 ;;=HELP^.404421^^21;0
 ;;^DD(.4044,21,"DT")
 ;;=2930812
 ;;^DD(.4044,22,0)
 ;;=INPUT TRANSFORM^K^^22;E1,245^K:$L(X)>245 X D:$D(X) ^DIM
 ;;^DD(.4044,22,3)
 ;;=Enter standard MUMPS code.
 ;;^DD(.4044,22,9)
 ;;=@
 ;;^DD(.4044,22,21,0)
 ;;=^^3^3^2940908^
 ;;^DD(.4044,22,21,1,0)
 ;;=This is MUMPS code that can examine X, the value entered by the user, and
 ;;^DD(.4044,22,21,2,0)
 ;;=kill X if it is invalid.  It corresponds to the third ^-piece of the
 ;;^DD(.4044,22,21,3,0)
 ;;=DIR(0) input variable to ^DIR.
 ;;^DD(.4044,22,"DT")
 ;;=2930812
 ;;^DD(.4044,23,0)
 ;;=SAVE CODE^K^^23;E1,245^K:$L(X)>245 X D:$D(X) ^DIM
 ;;^DD(.4044,23,3)
 ;;=Enter Standard MUMPS code.
 ;;^DD(.4044,23,9)
 ;;=@
 ;;^DD(.4044,23,21,0)
 ;;=^^8^8^2930920^^
 ;;^DD(.4044,23,21,1,0)
 ;;=This is MUMPS code that is executed when the user issues a Save command
 ;;^DD(.4044,23,21,2,0)
 ;;=and the value of this field changed since the last Save.  You can use this
 ;;^DD(.4044,23,21,3,0)
 ;;=field to save in global or local variables the value the user enters into
 ;;^DD(.4044,23,21,4,0)
 ;;=this field.  The following variables are available:
 ;;^DD(.4044,23,21,5,0)
 ;;= 
 ;;^DD(.4044,23,21,6,0)
 ;;=     X      = The new value of the field in internal form
 ;;^DD(.4044,23,21,7,0)
 ;;=     DDSEXT = The new value of the field in external form
 ;;^DD(.4044,23,21,8,0)
 ;;=     DDSOLD = The original (pre-save) value of the field in internal form

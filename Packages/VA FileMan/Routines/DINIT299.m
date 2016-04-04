DINIT299 ;SFISC/MKO-FORM AND BLOCK FILES ;10:49 AM  30 Mar 1999
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
 G ^DINIT29P
Q Q
 ;;^DD(.4044,23,"DT")
 ;;=2930812
 ;;^DD(.4044,24,0)
 ;;=SCREEN^K^^24;E1,245^K:$L(X)>245 X D:$D(X) ^DIM
 ;;^DD(.4044,24,3)
 ;;=Enter standard MUMPS code that sets the variable DIR("S").
 ;;^DD(.4044,24,9)
 ;;=@
 ;;^DD(.4044,24,21,0)
 ;;=^^4^4^2940908^
 ;;^DD(.4044,24,21,1,0)
 ;;=This screen is valid only for pointer and set-type form-only fields.
 ;;^DD(.4044,24,21,2,0)
 ;;= 
 ;;^DD(.4044,24,21,3,0)
 ;;=You can enter MUMPS code that sets the variable DIR("S"), to screen the
 ;;^DD(.4044,24,21,4,0)
 ;;=the values that can be selected.
 ;;^DD(.4044,24,"DT")
 ;;=2930812
 ;;^DD(.4044,30,0)
 ;;=COMPUTED EXPRESSION^FX^^30;E1,245^K:$L(X)>245!($L(X)<1) X I $D(X) D CEXPR^DDSIT
 ;;^DD(.4044,30,3)
 ;;=Answer must be 1-245 characters in length.
 ;;^DD(.4044,30,21,0)
 ;;=^^13^13^2940908^
 ;;^DD(.4044,30,21,1,0)
 ;;=You can enter MUMPS code that sets the variable Y equal to the value of
 ;;^DD(.4044,30,21,2,0)
 ;;=the computed field.  Alternatively, you can precede the computed
 ;;^DD(.4044,30,21,3,0)
 ;;=expression with an equal sign (=).
 ;;^DD(.4044,30,21,4,0)
 ;;= 
 ;;^DD(.4044,30,21,5,0)
 ;;=For example,
 ;;^DD(.4044,30,21,6,0)
 ;;= 
 ;;^DD(.4044,30,21,7,0)
 ;;=       S:$D(var)#2 Y="The value is: "_{NUMERIC}
 ;;^DD(.4044,30,21,8,0)
 ;;=       ={FIRST NAME}_" "_{LAST NAME}
 ;;^DD(.4044,30,21,9,0)
 ;;=       ={FO(PRICE)}*1.085
 ;;^DD(.4044,30,21,10,0)
 ;;= 
 ;;^DD(.4044,30,21,11,0)
 ;;=NUMERIC, FIRST NAME, and LAST NAME are the name of FileMan fields used on
 ;;^DD(.4044,30,21,12,0)
 ;;=the form, and PRICE is the caption of a form-only field found on the
 ;;^DD(.4044,30,21,13,0)
 ;;=current page and block of the form.
 ;;^DD(.4044,30,"DT")
 ;;=2931201
 ;;^DD(.404421,0)
 ;;=HELP SUB-FIELD^^.01^1
 ;;^DD(.404421,0,"DT")
 ;;=2930218
 ;;^DD(.404421,0,"NM","HELP")
 ;;=
 ;;^DD(.404421,0,"UP")
 ;;=.4044
 ;;^DD(.404421,.01,0)
 ;;=HELP^W^^0;1^Q
 ;;^DD(.404421,.01,21,0)
 ;;=^^3^3^2940908^
 ;;^DD(.404421,.01,21,1,0)
 ;;=This text is displayed when the user enters ? at this form-only field.
 ;;^DD(.404421,.01,21,2,0)
 ;;=The lines in this word processing field correspond to the nodes in the
 ;;^DD(.404421,.01,21,3,0)
 ;;=DIR("?",#) input array to ^DIR.
 ;;^DD(.404421,.01,"DT")
 ;;=2930812

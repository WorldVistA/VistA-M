DINIT297 ;SFISC/MKO-FORM AND BLOCK FILES ;3:30 PM  20 Apr 1999
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**8**
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
 G ^DINIT298
Q Q
 ;;^DD(.4044,5.1,1,0)
 ;;=^.1^^0
 ;;^DD(.4044,5.1,3)
 ;;=Enter the caption coordinate relative to the block.  Answer must be two positive integers separated by a comma (,), as follows:  'Row,Column'.
 ;;^DD(.4044,5.1,21,0)
 ;;=^^2^2^2940907^^
 ;;^DD(.4044,5.1,21,1,0)
 ;;=Caption coordinate is relative to the position of the block.  The
 ;;^DD(.4044,5.1,21,2,0)
 ;;=top left corner of the block has coordinate 1,1.
 ;;^DD(.4044,5.1,"DT")
 ;;=2940908
 ;;^DD(.4044,5.2,0)
 ;;=SUPPRESS COLON AFTER CAPTION?^S^0:NO;1:YES;^2;4^Q
 ;;^DD(.4044,5.2,1,0)
 ;;=^.1^^0
 ;;^DD(.4044,5.2,3)
 ;;=
 ;;^DD(.4044,5.2,21,0)
 ;;=^^2^2^2940907^^
 ;;^DD(.4044,5.2,21,1,0)
 ;;=Enter 'YES' to suppress the display of a colon and space after the
 ;;^DD(.4044,5.2,21,2,0)
 ;;=caption.
 ;;^DD(.4044,5.2,"DT")
 ;;=2940629
 ;;^DD(.4044,6,0)
 ;;=DEFAULT^F^^3;1^K:X[""""!($A(X)=45) X I $D(X) K:$L(X)>245!($L(X)<1) X
 ;;^DD(.4044,6,3)
 ;;=Answer must be 1-245 characters in length.
 ;;^DD(.4044,6,21,0)
 ;;=^^8^8^2940907^
 ;;^DD(.4044,6,21,1,0)
 ;;=Enter the default you want displayed when the user first loads the page
 ;;^DD(.4044,6,21,2,0)
 ;;=on which this field is located, and the field's value is originally null.
 ;;^DD(.4044,6,21,3,0)
 ;;=Since ScreenMan validates the default, it must be valid, unambiguous, and
 ;;^DD(.4044,6,21,4,0)
 ;;=in external form; otherwise, it is not used.
 ;;^DD(.4044,6,21,5,0)
 ;;= 
 ;;^DD(.4044,6,21,6,0)
 ;;=If you want to create an executable default, i.e., a default whose value
 ;;^DD(.4044,6,21,7,0)
 ;;=is determined at run time when the page is first loaded, the value of
 ;;^DD(.4044,6,21,8,0)
 ;;=this field must be "!M".
 ;;^DD(.4044,6,"DT")
 ;;=2920218
 ;;^DD(.4044,6.01,0)
 ;;=EXECUTABLE DEFAULT^K^^3.1;E1,245^K:$L(X)>245 X D:$D(X) ^DIM
 ;;^DD(.4044,6.01,3)
 ;;=Enter standard MUMPS code that sets the variable Y.
 ;;^DD(.4044,6.01,9)
 ;;=@
 ;;^DD(.4044,6.01,21,0)
 ;;=^^4^4^2940907^
 ;;^DD(.4044,6.01,21,1,0)
 ;;=Enter MUMPS code that sets the variable Y equal to the default you want
 ;;^DD(.4044,6.01,21,2,0)
 ;;=displayed when the page is first loaded and the data value on file is
 ;;^DD(.4044,6.01,21,3,0)
 ;;=null.  Y must be set to a valid, unambiguous user response; otherwise, it
 ;;^DD(.4044,6.01,21,4,0)
 ;;=is ignored.
 ;;^DD(.4044,6.01,"DT")
 ;;=2920218
 ;;^DD(.4044,6.1,0)
 ;;=REQUIRED^S^0:NO;1:YES;^4;1^Q
 ;;^DD(.4044,6.1,3)
 ;;=
 ;;^DD(.4044,6.1,21,0)
 ;;=^^5^5^2940907^
 ;;^DD(.4044,6.1,21,1,0)
 ;;=Whenever the user attempts a Save, ScreenMan checks all required fields
 ;;^DD(.4044,6.1,21,2,0)
 ;;=on all pages accessed during the editing session, as well as all pages
 ;;^DD(.4044,6.1,21,3,0)
 ;;=linked to the first page via the Next and Previous Page links.  If any of
 ;;^DD(.4044,6.1,21,4,0)
 ;;=the required fields have null values, no Save occurs.  You need not make a
 ;;^DD(.4044,6.1,21,5,0)
 ;;=field required that is already required by its data definition.
 ;;^DD(.4044,6.2,0)
 ;;=DUPLICATE^S^0:NO;1:YES;^4;2^Q
 ;;^DD(.4044,6.2,3)
 ;;=Enter 'YES' if the field value from the previous record can be duplicated with the 'spacebar-return' feature.
 ;;^DD(.4044,6.2,21,0)
 ;;=^^1^1^2940629^
 ;;^DD(.4044,6.2,21,1,0)
 ;;=This field is not currently being used.
 ;;^DD(.4044,6.3,0)
 ;;=RIGHT JUSTIFY^S^0:NO;1:YES;^4;3^Q
 ;;^DD(.4044,6.3,21,0)
 ;;=^^2^2^2940907^
 ;;^DD(.4044,6.3,21,1,0)
 ;;=Enter 'YES' if the data for this field should be displayed right-justified
 ;;^DD(.4044,6.3,21,2,0)
 ;;=in the editing window.
 ;;^DD(.4044,6.3,"DT")
 ;;=2940625
 ;;^DD(.4044,6.4,0)
 ;;=DISABLE EDITING^S^0:NO;1:YES;2:REACHABLE;^4;4^Q
 ;;^DD(.4044,6.4,3)
 ;;=
 ;;^DD(.4044,6.4,21,0)
 ;;=^^3^3^2940907^^^
 ;;^DD(.4044,6.4,21,1,0)
 ;;=Enter 'YES' to disable editing and to prevent the user from navigating
 ;;^DD(.4044,6.4,21,2,0)
 ;;=to the field.  Enter 'REACHABLE' to disable editing, but allow the user to
 ;;^DD(.4044,6.4,21,3,0)
 ;;=navigate to the field.
 ;;^DD(.4044,6.4,"DT")
 ;;=2940625
 ;;^DD(.4044,6.5,0)
 ;;=DISALLOW LAYGO^S^0:NO;1:YES;^4;5^Q
 ;;^DD(.4044,6.5,3)
 ;;=
 ;;^DD(.4044,6.5,21,0)
 ;;=^^2^2^2931020^
 ;;^DD(.4044,6.5,21,1,0)
 ;;=Enter 'YES' to prohibit the user from adding new subentries into this
 ;;^DD(.4044,6.5,21,2,0)
 ;;=multiple.  This question only pertains to multiple-valued fields.
 ;;^DD(.4044,6.6,0)
 ;;=ASK 'OK'^S^0:NO;1:YES;^4;6^Q
 ;;^DD(.4044,6.6,21,0)
 ;;=^^5^5^2990420^
 ;;^DD(.4044,6.6,21,1,0)
 ;;=Answer 'YES' to ask the user whether the looked-up entry is 'OK'. If only
 ;;^DD(.4044,6.6,21,2,0)
 ;;=one match is made to the user's lookup value, then ScreenMan will ask
 ;;^DD(.4044,6.6,21,3,0)
 ;;="OK?" instead of automatically selecting the found entry. This property
 ;;^DD(.4044,6.6,21,4,0)
 ;;=corresponds to the "V" flag in the DIC(0) input variable to ^DIC and only
 ;;^DD(.4044,6.6,21,5,0)
 ;;=pertains to multiple-valued fields.
 ;;^DD(.4044,8,0)
 ;;=SUB PAGE LINK^NJ5,1^^7;2^K:+X'=X!(X>999.9)!(X<1)!(X?.E1"."2N.N) X
 ;;^DD(.4044,8,3)
 ;;=Enter the Page Number of the page to open up when the user presses <Return> at this field.  Type a Number between 1 and 999.9, 1 Decimal Digit.
 ;;^DD(.4044,8,21,0)
 ;;=^^7^7^2940907^
 ;;^DD(.4044,8,21,1,0)
 ;;=If you wish to take users to a pop-up page when they press <RET> at
 ;;^DD(.4044,8,21,2,0)
 ;;=this field, enter the Page Number of that page.  When users exit that
 ;;^DD(.4044,8,21,3,0)
 ;;=pop-up page, ScreenMan will automatically take them to the field following
 ;;^DD(.4044,8,21,4,0)
 ;;=this field.
 ;;^DD(.4044,8,21,5,0)
 ;;= 
 ;;^DD(.4044,8,21,6,0)
 ;;=You can also use the Parent Field property of the pop-up page to link a
 ;;^DD(.4044,8,21,7,0)
 ;;=field to the pop-up page.
 ;;^DD(.4044,10,0)
 ;;=BRANCHING LOGIC^K^^10;E1,245^K:$L(X)>245 X D:$D(X) ^DIM
 ;;^DD(.4044,10,3)
 ;;=Enter Standard MUMPS code, 1-245 characters in length.
 ;;^DD(.4044,10,9)
 ;;=@
 ;;^DD(.4044,10,21,0)
 ;;=^^18^18^2940907^
 ;;^DD(.4044,10,21,1,0)
 ;;=This MUMPS code is executed whenever the user presses <RET> at the
 ;;^DD(.4044,10,21,2,0)
 ;;=field.  Here you can set DDSBR equal to the field, block, and page,
 ;;^DD(.4044,10,21,3,0)
 ;;=separated by up-arrow delimiters, of the field to which you wish to take
 ;;^DD(.4044,10,21,4,0)
 ;;=users when they press <RET>.  For example,
 ;;^DD(.4044,10,21,5,0)
 ;;= 
 ;;^DD(.4044,10,21,6,0)
 ;;=     S:X="Y" DDSBR="TEST FIELD 1^TEST BLOCK 1^TEST PAGE 2"
 ;;^DD(.4044,10,21,7,0)
 ;;= 
 ;;^DD(.4044,10,21,8,0)
 ;;=would take the user to the field with unique name or caption "TEST FIELD
 ;;^DD(.4044,10,21,9,0)
 ;;=1" on the block named "TEST BLOCK 1" on a page named "TEST PAGE 2".
 ;;^DD(.4044,10,21,10,0)
 ;;= 
 ;;^DD(.4044,10,21,11,0)
 ;;=Alternatively, if you wish to take users to another page when they press
 ;;^DD(.4044,10,21,12,0)
 ;;=<RET> at this field, and then when they close that page, automatically
 ;;^DD(.4044,10,21,13,0)
 ;;=take them to the field immediately following this field, you can set
 ;;^DD(.4044,10,21,14,0)
 ;;=DDSSTACK equal to the page name or number of that page.
 ;;^DD(.4044,10,21,15,0)
 ;;= 

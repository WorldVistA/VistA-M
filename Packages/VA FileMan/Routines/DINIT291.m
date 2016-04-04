DINIT291 ;SFISC/MKO-FORM AND BLOCK FILES ;7APR2005
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**999,1013**
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
 G ^DINIT292
Q Q
 ;;^DD(.403,7,1,1,3)
 ;;=Programmer only
 ;;^DD(.403,7,1,1,"%D",0)
 ;;=^^2^2^2900911^
 ;;^DD(.403,7,1,1,"%D",0,"LE")
 ;;=1
 ;;^DD(.403,7,1,1,"%D",1,0)
 ;;=This cross-reference is used to quickly find all ScreenMan templates
 ;;^DD(.403,7,1,1,"%D",2,0)
 ;;=associated with a file.
 ;;^DD(.403,7,1,1,"DT")
 ;;=2900911
 ;;^DD(.403,7,3)
 ;;=Answer must be 1-16 characters in length.
 ;;^DD(.403,7,21,0)
 ;;=^^2^2^2920407^
 ;;^DD(.403,7,21,1,0)
 ;;=Enter a file number, greater than or equal to 2, which represents the data
 ;;^DD(.403,7,21,2,0)
 ;;=dictionary number of the primary file for this form.
 ;;^DD(.403,7,"DT")
 ;;=2920407
 ;;^DD(.403,8,0)
 ;;=DISPLAY ONLY^SI^0:NO;1:YES;^0;9^Q
 ;;^DD(.403,8,21,0)
 ;;=^^2^2^2931027^^^^
 ;;^DD(.403,8,21,1,0)
 ;;=This is a flag that indicates none of the blocks on the form are edit
 ;;^DD(.403,8,21,2,0)
 ;;=blocks.  This flag is set during form compilation.
 ;;^DD(.403,8,"DT")
 ;;=2931028
 ;;^DD(.403,9,0)
 ;;=FORM ONLY^SI^0:NO;1:YES;^0;10^Q
 ;;^DD(.403,9,21,0)
 ;;=^^2^2^2931027^
 ;;^DD(.403,9,21,1,0)
 ;;=This is a flag that indicates none of the fields on the form are data
 ;;^DD(.403,9,21,2,0)
 ;;=dictionary fields.  This flag is set during form compilation.
 ;;^DD(.403,9,"DT")
 ;;=2931028
 ;;^DD(.403,10,0)
 ;;=COMPILED^SI^0:NO;1:YES;^0;11^Q
 ;;^DD(.403,10,1,0)
 ;;=^.1^^0
 ;;^DD(.403,10,21,0)
 ;;=^^2^2^2940908^
 ;;^DD(.403,10,21,1,0)
 ;;=This is a flag that indicates that the form is compiled.  This flag is
 ;;^DD(.403,10,21,2,0)
 ;;=set during form compilation.
 ;;^DD(.403,10,"DT")
 ;;=2940701
 ;;^DD(.403,11,0)
 ;;=PRE ACTION^K^^11;E1,245^K:$L(X)>245 X D:$D(X) ^DIM
 ;;^DD(.403,11,3)
 ;;=Enter standard MUMPS code which will be executed at the beginning of the form.
 ;;^DD(.403,11,9)
 ;;=@
 ;;^DD(.403,11,21,0)
 ;;=^^2^2^2940906^
 ;;^DD(.403,11,21,1,0)
 ;;=This is MUMPS code that is executed when the form is first invoked,
 ;;^DD(.403,11,21,2,0)
 ;;=before any of the pages are loaded and displayed.
 ;;^DD(.403,12,0)
 ;;=POST ACTION^K^^12;E1,245^K:$L(X)>245 X D:$D(X) ^DIM
 ;;^DD(.403,12,3)
 ;;=Enter standard MUMPS code which will be executed at the end of the form.
 ;;^DD(.403,12,9)
 ;;=@
 ;;^DD(.403,12,21,0)
 ;;=^^2^2^2940906^^
 ;;^DD(.403,12,21,1,0)
 ;;=This is MUMPS code that is executed before ScreenMan returns to the
 ;;^DD(.403,12,21,2,0)
 ;;=calling application.
 ;;^DD(.403,14,0)
 ;;=POST SAVE^K^^14;E1,245^K:$L(X)>245 X D:$D(X) ^DIM
 ;;^DD(.403,14,3)
 ;;=This is Standard MUMPS code.
 ;;^DD(.403,14,9)
 ;;=@
 ;;^DD(.403,14,21,0)
 ;;=^^2^2^2940906^
 ;;^DD(.403,14,21,1,0)
 ;;=This is MUMPS code that is executed when the user saves changes.  It is 
 ;;^DD(.403,14,21,2,0)
 ;;=executed only if all data is valid, and after all data has been filed.
 ;;^DD(.403,14,"DT")
 ;;=2930813
 ;;^DD(.403,15,0)
 ;;=DESCRIPTION^.40315^^15;0
 ;;^DD(.403,20,0)
 ;;=DATA VALIDATION^K^^20;E1,245^K:$L(X)>245 X D:$D(X) ^DIM
 ;;^DD(.403,20,3)
 ;;=Enter standard MUMPS code.
 ;;^DD(.403,20,9)
 ;;=@
 ;;^DD(.403,20,21,0)
 ;;=^^8^8^2940906^
 ;;^DD(.403,20,21,1,0)
 ;;=This is MUMPS code that is executed when the user attempts to save changes
 ;;^DD(.403,20,21,2,0)
 ;;=to the form.  If the code sets DDSERROR, the user is unable to save
 ;;^DD(.403,20,21,3,0)
 ;;=changes.  If the code sets DDSBR, the user is taken to the specified
 ;;^DD(.403,20,21,4,0)
 ;;=field.
 ;;^DD(.403,20,21,5,0)
 ;;= 
 ;;^DD(.403,20,21,6,0)
 ;;=In addition to $$GET^DDSVAL, PUT^DDSVAL, and HLP^DDSUTL, you 
 ;;^DD(.403,20,21,7,0)
 ;;=can use MSG^DDSUTL to print on a separate screen messages to the user 
 ;;^DD(.403,20,21,8,0)
 ;;=about the validity of the data.
 ;;^DD(.403,21,0)
 ;;=RECORD SELECTION PAGE^NJ5,1^^21;1^K:+X'=X!(X>999.9)!(X<1)!(X?.E1"."2N.N) X
 ;;^DD(.403,21,3)
 ;;=Type a Number between 1 and 999.9, 1 Decimal Digit
 ;;^DD(.403,21,21,0)
 ;;=^^12^12^2940906^
 ;;^DD(.403,21,21,1,0)
 ;;=Enter the page number of the page that is used for record selection.
 ;;^DD(.403,21,21,2,0)
 ;;= 
 ;;^DD(.403,21,21,3,0)
 ;;=If you define a Record Selection Page, the user can select another entry
 ;;^DD(.403,21,21,4,0)
 ;;=in the file, and, if LAYGO is allowed, add another entry into the file
 ;;^DD(.403,21,21,5,0)
 ;;=without exiting the form.  The Record Selection Page should be a pop-up
 ;;^DD(.403,21,21,6,0)
 ;;=page that contains one form-only field that performs a pointer-type read
 ;;^DD(.403,21,21,7,0)
 ;;=into the Primary File of the form.  The Record Selection Page property
 ;;^DD(.403,21,21,8,0)
 ;;=should be set equal to the Page Number of the Record Selection Page.
 ;;^DD(.403,21,21,9,0)
 ;;=
 ;;^DD(.403,21,21,10,0)
 ;;=The user can open the Record Selection Page by pressing <F1>L.  After the
 ;;^DD(.403,21,21,11,0)
 ;;=user selects a record and closes the Record Selection Page, the data for
 ;;^DD(.403,21,21,12,0)
 ;;=the selected record is displayed.
 ;;^DD(.403,40,0)
 ;;=PAGE^.4031I^^40;0
 ;;^DD(.403,21400,0)
 ;;=BUILD(S)^Cmp9.6^^ ; ^N DISNAME,D S DISNAME=$P($G(^DIST(.403,D0,0)),U)_"    FILE #"_$P($G(^(0)),U,8) F D=0:0 S D=$O(^XPD(9.6,D)) Q:'D  I $D(^(D,"KRN",.403,"NM","B",DISNAME)) N D0 S D0=D,X=$P(^XPD(9.6,D,0),U) X DICMX Q:'$D(D)
 ;;^DD(.4031,0)
 ;;=PAGE SUB-FIELD^^40^13
 ;;^DD(.4031,0,"DT")
 ;;=2940506
 ;;^DD(.4031,0,"ID","WRITE")
 ;;=D:$D(^(1))#2 EN^DDIOL($P(^(1),U),"","?12")
 ;;^DD(.4031,0,"IX","AC",.4031,5)
 ;;=
 ;;^DD(.4031,0,"IX","B",.4031,.01)
 ;;=
 ;;^DD(.4031,0,"IX","C",.4031,7)
 ;;=
 ;;^DD(.4031,0,"NM","PAGE")
 ;;=
 ;;^DD(.4031,0,"UP")
 ;;=.403
 ;;^DD(.4031,.01,0)
 ;;=PAGE NUMBER^MNJ5,1X^^0;1^K:+X'=X!(X>999.9)!(X<1)!(X?.E1"."2N.N)!$D(^DIST(.403,DA(1),40,"B",X)) X
 ;;^DD(.4031,.01,1,0)
 ;;=^.1
 ;;^DD(.4031,.01,1,1,0)
 ;;=.4031^B
 ;;^DD(.4031,.01,1,1,1)
 ;;=S ^DIST(.403,DA(1),40,"B",$E(X,1,30),DA)=""
 ;;^DD(.4031,.01,1,1,2)
 ;;=K ^DIST(.403,DA(1),40,"B",$E(X,1,30),DA)
 ;;^DD(.4031,.01,3)
 ;;=Enter a number between 1 and 999.9, up to 1 Decimal Digit, that identifies the page.
 ;;^DD(.4031,.01,21,0)
 ;;=^^2^2^2940907^^^
 ;;^DD(.4031,.01,21,1,0)
 ;;=This is the unique page number of the page.  You can use this number to
 ;;^DD(.4031,.01,21,2,0)
 ;;=refer to the page in ScreenMan functions and utilities.
 ;;^DD(.4031,1,0)
 ;;=HEADER BLOCK^P.404^DIST(.404,^0;2^Q
 ;;^DD(.4031,1,1,0)
 ;;=^.1
 ;;^DD(.4031,1,1,1,0)
 ;;=.403^AC
 ;;^DD(.4031,1,1,1,1)
 ;;=S ^DIST(.403,"AC",$E(X,1,30),DA(1),DA)=""
 ;;^DD(.4031,1,1,1,2)
 ;;=K ^DIST(.403,"AC",$E(X,1,30),DA(1),DA)
 ;;^DD(.4031,1,1,1,"DT")
 ;;=2930702
 ;;^DD(.4031,1,3)
 ;;=Enter the block which will be used as a header for this page.
 ;;^DD(.4031,1,21,0)
 ;;=^^7^7^2940907^^^
 ;;^DD(.4031,1,21,1,0)
 ;;=The header block always appears at row 1, column 1 relative to the page
 ;;^DD(.4031,1,21,2,0)
 ;;=on which it is defined.  It is for display purposes only -- the user

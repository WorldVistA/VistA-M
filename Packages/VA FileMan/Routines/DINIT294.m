DINIT294 ;SFISC/MKO-FORM AND BLOCK FILES ;1NOV2004
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**8,1003,1004**
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
 G ^DINIT295
Q Q
 ;;^DD(.4032,3,21,5,0)
 ;;=of those two kinds of fields so that the user can press <RET> to view or
 ;;^DD(.4032,3,21,6,0)
 ;;=edit the subfields in the multiple or invoke an editor to view the
 ;;^DD(.4032,3,21,7,0)
 ;;=contents of the word processing field.
 ;;^DD(.4032,3,"DT")
 ;;=2940413
 ;;^DD(.4032,4,0)
 ;;=POINTER LINK^FX^^1;1^K:$L(X)>245!($L(X)<1) X I $D(X) D PLINK^DDSIT
 ;;^DD(.4032,4,3)
 ;;=Answer must be 1-245 characters in length.
 ;;^DD(.4032,4,21,0)
 ;;=^^9^9^2940907^^
 ;;^DD(.4032,4,21,1,0)
 ;;=If the fields displayed in this block are reached through a relational
 ;;^DD(.4032,4,21,2,0)
 ;;=jump from the primary file of the form, enter the relational expression
 ;;^DD(.4032,4,21,3,0)
 ;;=that describes this jump.  Your frame of reference is the primary file of
 ;;^DD(.4032,4,21,4,0)
 ;;=the form.
 ;;^DD(.4032,4,21,5,0)
 ;;= 
 ;;^DD(.4032,4,21,6,0)
 ;;=For example, if the primary file has a field #999 called TEST that points
 ;;^DD(.4032,4,21,7,0)
 ;;=to the file associated with this block, enter
 ;;^DD(.4032,4,21,8,0)
 ;;= 
 ;;^DD(.4032,4,21,9,0)
 ;;=     999 or TEST
 ;;^DD(.4032,4,"DT")
 ;;=2931201
 ;;^DD(.4032,5,0)
 ;;=REPLICATION^NJ3,0^^2;1^K:+X'=X!(X>999)!(X<2)!(X?.E1"."1N.N) X
 ;;^DD(.4032,5,3)
 ;;=Type a Number between 2 and 999, 0 Decimal Digits
 ;;^DD(.4032,5,21,0)
 ;;=^^3^3^2940907^^
 ;;^DD(.4032,5,21,1,0)
 ;;=If this is a repeating block, enter the number of times the fields
 ;;^DD(.4032,5,21,2,0)
 ;;=defined in this block should be replicated.  If used, this number must
 ;;^DD(.4032,5,21,3,0)
 ;;=be greater than 1.
 ;;^DD(.4032,5,"DT")
 ;;=2940503
 ;;^DD(.4032,6,0)
 ;;=INDEX^F^^2;2^K:$L(X)>63!($L(X)<1) X
 ;;^DD(.4032,6,3)
 ;;=Answer must be 1-63 characters in length.
 ;;^DD(.4032,6,21,0)
 ;;=^^7^7^2941020^
 ;;^DD(.4032,6,21,1,0)
 ;;=Enter the name of the cross reference that should be used to pick up the
 ;;^DD(.4032,6,21,2,0)
 ;;=subentries in the multiple.  ScreenMan will initially display the
 ;;^DD(.4032,6,21,3,0)
 ;;=subentries to the user sorted in the order defined by this index.  The
 ;;^DD(.4032,6,21,4,0)
 ;;=default INDEX is B.
 ;;^DD(.4032,6,21,5,0)
 ;;= 
 ;;^DD(.4032,6,21,6,0)
 ;;=If the multiple has no index, or you wish to display the subentries
 ;;^DD(.4032,6,21,7,0)
 ;;=in record number order, enter !IEN.
 ;;^DD(.4032,6,21,8,0)
 ;;=  LEAVE THIS VALUE EMPTY IF YOU WANT TO ENTER 'COMPUTED MULTIPLE' CODE TO DO THE SELECTION
 ;;^DD(.4032,7,0)
 ;;=INITIAL POSITION^S^f:FIRST;l:LAST;n:NEW;u:USER'S LAST^2;3^Q
 ;;^DD(.4032,7,21,0)
 ;;=^^5^5^2940908^
 ;;^DD(.4032,7,21,1,0)
 ;;=This is the position in the list where the cursor should initially rest
 ;;^DD(.4032,7,21,2,0)
 ;;=when the user first navigates to the repeating block.  NEW indicates that
 ;;^DD(.4032,7,21,3,0)
 ;;=the cursor should initially rest on the blank line at the end of the list.  
 ;;^DD(.4032,7,21,4,0)
 ;;=USER'S LAST is the last choice that the User has made for this file -- what  
 ;;^DD(.4032,7,21,5,0)
 ;;=would be retrieved by the SPACE-BAR.  The default INITIAL POSITION is FIRST.
 ;;^DD(.4032,7,"DT")
 ;;=2940503
 ;;^DD(.4032,8,0)
 ;;=DISALLOW LAYGO^S^0:NO;1:YES;^2;4^Q
 ;;^DD(.4032,8,21,0)
 ;;=^^3^3^2940907^^
 ;;^DD(.4032,8,21,1,0)
 ;;=If set to YES, this prohibits the user from entering new subentries into
 ;;^DD(.4032,8,21,2,0)
 ;;=the multiple.  If null or set to NO, the setting in the data dictionary
 ;;^DD(.4032,8,21,3,0)
 ;;=determines whether LAYGO is allowed.
 ;;^DD(.4032,8,"DT")
 ;;=2940505
 ;;^DD(.4032,9,0)
 ;;=FIELD FOR SELECTION^F^^2;5^K:$L(X)>30!($L(X)<1) X
 ;;^DD(.4032,9,3)
 ;;=Answer must be 1-30 characters in length.
 ;;^DD(.4032,9,21,0)
 ;;=^^5^5^2940907^^
 ;;^DD(.4032,9,21,1,0)
 ;;=This is the field order of the field that defines the column position of
 ;;^DD(.4032,9,21,2,0)
 ;;=the blank line at the end of the list.  The default is the first editable
 ;;^DD(.4032,9,21,3,0)
 ;;=field in the block.  This is also the field before which ScreenMan prints
 ;;^DD(.4032,9,21,4,0)
 ;;=the plus sign (+) to indicate there are more entries above or below the
 ;;^DD(.4032,9,21,5,0)
 ;;=displayed list.
 ;;^DD(.4032,9,"DT")
 ;;=2940506
 ;;^DD(.4032,10,0)
 ;;=ASK 'OK'^S^0:NO;1:YES;^2;6^Q
 ;;^DD(.4032,10,21,0)
 ;;=^^5^5^2990420^
 ;;^DD(.4032,10,21,1,0)
 ;;=Answer 'YES' to ask the user whether the looked-up entry is 'OK'. If only
 ;;^DD(.4032,10,21,2,0)
 ;;=one match is made to the user's lookup value, then ScreenMan will ask
 ;;^DD(.4032,10,21,3,0)
 ;;="OK?" instead of automatically selecting the found entry. This property
 ;;^DD(.4032,10,21,4,0)
 ;;=corresponds to the "V" flag in the DIC(0) input variable to ^DIC and only
 ;;^DD(.4032,10,21,5,0)
 ;;=pertains to multiple-valued fields.
 ;;^DD(.4032,10,"DT")
 ;;=2990420
 ;;^DD(.4032,11,0)
 ;;=PRE ACTION^K^^11;E1,245^K:$L(X)>245 X D:$D(X) ^DIM
 ;;^DD(.4032,11,3)
 ;;=This is Standard MUMPS code.
 ;;^DD(.4032,11,9)
 ;;=@
 ;;^DD(.4032,11,21,0)
 ;;=^^5^5^2940907^
 ;;^DD(.4032,11,21,1,0)
 ;;=Enter MUMPS code that is executed whenever the user reaches this block.
 ;;^DD(.4032,11,21,2,0)
 ;;= 
 ;;^DD(.4032,11,21,3,0)
 ;;=This pre-action is a characteristic of the block only as it is used on
 ;;^DD(.4032,11,21,4,0)
 ;;=this form.  If you place this block on another form, you can define a
 ;;^DD(.4032,11,21,5,0)
 ;;=different pre-action.
 ;;^DD(.4032,11,"DT")
 ;;=2930610
 ;;^DD(.4032,12,0)
 ;;=POST ACTION^K^^12;E1,245^K:$L(X)>245 X D:$D(X) ^DIM
 ;;^DD(.4032,12,3)
 ;;=This is Standard MUMPS code.
 ;;^DD(.4032,12,9)
 ;;=@
 ;;^DD(.4032,12,21,0)
 ;;=^^5^5^2940907^
 ;;^DD(.4032,12,21,1,0)
 ;;=Enter MUMPS code that is executed whenever the user leaves this block.
 ;;^DD(.4032,12,21,2,0)
 ;;= 
 ;;^DD(.4032,12,21,3,0)
 ;;=This post-action is a characteristic of the block only as it is used on
 ;;^DD(.4032,12,21,4,0)
 ;;=this form.  If you place this block on another form, you can define a
 ;;^DD(.4032,12,21,5,0)
 ;;=different post-action.
 ;;^DD(.4032,12,"DT")
 ;;=2930610
 ;;^DD(.4032,98,0)
 ;;=COMPUTED MULTIPLE^K^^COMP MUL;E1,999^D ^DIM
 ;;^DD(.4032,98,3)
 ;;=THIS IS MUMPS CODE THAT XECUTES 'DICMX' WITH DIFFERENT VALUES OF 'D0' AS INTERNAL ENTRY NUMBERS
 ;;^DD(.4032,98.1,0)
 ;;=COMPUTED MUL PTR^NJ13,9^^COMP MUL PTR;E1,999^K:+$P(X,"E")'=X X
 ;;^DD(.4032,98.1,3)
 ;;=FILE POINTER (USUALLY THE SAME FILE)

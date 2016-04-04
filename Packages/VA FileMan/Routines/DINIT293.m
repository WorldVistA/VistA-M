DINIT293 ;SFISC/MKO-FORM AND BLOCK FILES ;05:35 PM  21 Aug 2002
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**8,999**
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
 G ^DINIT294
Q Q
 ;;^DD(.4031,8,1,0)
 ;;=^.1^^0
 ;;^DD(.4031,8,3)
 ;;=Answer must be 5-92 characters in length.
 ;;^DD(.4031,8,21,0)
 ;;=^^25^25^2940907^
 ;;^DD(.4031,8,21,1,0)
 ;;=This property can be used instead of Subpage Link to link a subpage to a
 ;;^DD(.4031,8,21,2,0)
 ;;=field.
 ;;^DD(.4031,8,21,3,0)
 ;;= 
 ;;^DD(.4031,8,21,4,0)
 ;;=Parent Field has the following format:
 ;;^DD(.4031,8,21,5,0)
 ;;= 
 ;;^DD(.4031,8,21,6,0)
 ;;=       Field id,Block id,Page id
 ;;^DD(.4031,8,21,7,0)
 ;;= 
 ;;^DD(.4031,8,21,8,0)
 ;;=where,
 ;;^DD(.4031,8,21,9,0)
 ;;= 
 ;;^DD(.4031,8,21,10,0)
 ;;=       Field id  =  Field Order number; or
 ;;^DD(.4031,8,21,11,0)
 ;;=                    Caption of the field; or
 ;;^DD(.4031,8,21,12,0)
 ;;=                    Unique Name of the field
 ;;^DD(.4031,8,21,13,0)
 ;;= 
 ;;^DD(.4031,8,21,14,0)
 ;;=       Block id  =  Block Order number; or
 ;;^DD(.4031,8,21,15,0)
 ;;=                    Block Name
 ;;^DD(.4031,8,21,16,0)
 ;;= 
 ;;^DD(.4031,8,21,17,0)
 ;;=       Page id   =  Page Number; or
 ;;^DD(.4031,8,21,18,0)
 ;;=                    Page Name
 ;;^DD(.4031,8,21,19,0)
 ;;= 
 ;;^DD(.4031,8,21,20,0)
 ;;=For example:
 ;;^DD(.4031,8,21,21,0)
 ;;= 
 ;;^DD(.4031,8,21,22,0)
 ;;=       ZZFIELD 1,ZZBLOCK 1,ZZPAGE 1
 ;;^DD(.4031,8,21,23,0)
 ;;= 
 ;;^DD(.4031,8,21,24,0)
 ;;=identifies the field with Caption or Unique Name "ZZFIELD 1," on the block
 ;;^DD(.4031,8,21,25,0)
 ;;=named "ZZBLOCK 1," on the page named "ZZPAGE 1".
 ;;^DD(.4031,8,"DT")
 ;;=2931201
 ;;^DD(.4031,11,0)
 ;;=PRE ACTION^K^^11;E1,245^K:$L(X)>245 X D:$D(X) ^DIM
 ;;^DD(.4031,11,3)
 ;;=Enter Standard MUMPS code that will be executed before the user reaches a page.
 ;;^DD(.4031,11,9)
 ;;=@
 ;;^DD(.4031,11,21,0)
 ;;=^^1^1^2940907^^^^
 ;;^DD(.4031,11,21,1,0)
 ;;=This MUMPS code is executed when the user reaches a page.
 ;;^DD(.4031,11,22)
 ;;=
 ;;^DD(.4031,12,0)
 ;;=POST ACTION^K^^12;E1,245^K:$L(X)>245 X D:$D(X) ^DIM
 ;;^DD(.4031,12,3)
 ;;=Enter Standard MUMPS code that will be executed after the user leaves a page.
 ;;^DD(.4031,12,9)
 ;;=@
 ;;^DD(.4031,12,21,0)
 ;;=^^1^1^2940907^^^
 ;;^DD(.4031,12,21,1,0)
 ;;=This MUMPS code is executed when the user leaves the page.
 ;;^DD(.4031,15,0)
 ;;=DESCRIPTION^.403115^^15;0
 ;;^DD(.4031,40,0)
 ;;=BLOCK^.4032IP^^40;0
 ;;^DD(.403115,0)
 ;;=DESCRIPTION SUB-FIELD^^.01^1
 ;;^DD(.403115,0,"DT")
 ;;=2910204
 ;;^DD(.403115,0,"NM","DESCRIPTION")
 ;;=
 ;;^DD(.403115,0,"UP")
 ;;=.4031
 ;;^DD(.403115,.01,0)
 ;;=DESCRIPTION^W^^0;1^Q
 ;;^DD(.403115,.01,3)
 ;;=Enter text which describes the page.
 ;;^DD(.403115,.01,21,0)
 ;;=^^1^1^2940908^^
 ;;^DD(.403115,.01,21,1,0)
 ;;=Enter text that describes this page.
 ;;^DD(.40315,0)
 ;;=DESCRIPTION SUB-FIELD^^.01^1
 ;;^DD(.40315,0,"DT")
 ;;=2910204
 ;;^DD(.40315,0,"NM","DESCRIPTION")
 ;;=
 ;;^DD(.40315,0,"UP")
 ;;=.403
 ;;^DD(.40315,.01,0)
 ;;=DESCRIPTION^W^^0;1^Q
 ;;^DD(.40315,.01,3)
 ;;=
 ;;^DD(.40315,.01,21,0)
 ;;=^^1^1^2940908^^^^
 ;;^DD(.40315,.01,21,1,0)
 ;;=Enter text that describes this form.
 ;;^DD(.4032,0)
 ;;=BLOCK SUB-FIELD^^12^13
 ;;^DD(.4032,0,"DT")
 ;;=2940506
 ;;^DD(.4032,0,"ID","WRITE")
 ;;=D EN^DDIOL("(Block Order "_$P(^(0),U,2)_")","","?35")
 ;;^DD(.4032,0,"IX","AC",.4032,1)
 ;;=
 ;;^DD(.4032,0,"IX","B",.4032,.01)
 ;;=
 ;;^DD(.4032,0,"NM","BLOCK")
 ;;=
 ;;^DD(.4032,0,"UP")
 ;;=.4031
 ;;^DD(.4032,.01,0)
 ;;=BLOCK NAME^MP.404'X^DIST(.404,^0;1^S:$D(X) DINUM=X
 ;;^DD(.4032,.01,1,0)
 ;;=^.1
 ;;^DD(.4032,.01,1,1,0)
 ;;=.4032^B
 ;;^DD(.4032,.01,1,1,1)
 ;;=S ^DIST(.403,DA(2),40,DA(1),40,"B",$E(X,1,30),DA)=""
 ;;^DD(.4032,.01,1,1,2)
 ;;=K ^DIST(.403,DA(2),40,DA(1),40,"B",$E(X,1,30),DA)
 ;;^DD(.4032,.01,1,2,0)
 ;;=.403^AB
 ;;^DD(.4032,.01,1,2,1)
 ;;=S ^DIST(.403,"AB",$E(X,1,30),DA(2),DA(1),DA)=""
 ;;^DD(.4032,.01,1,2,2)
 ;;=K ^DIST(.403,"AB",$E(X,1,30),DA(2),DA(1),DA)
 ;;^DD(.4032,.01,1,2,"%D",0)
 ;;=^^2^2^2930521^
 ;;^DD(.4032,.01,1,2,"%D",1,0)
 ;;=This cross reference provides an index that can be used to determine
 ;;^DD(.4032,.01,1,2,"%D",2,0)
 ;;=the forms on which a block is used.
 ;;^DD(.4032,.01,1,2,"DT")
 ;;=2930521
 ;;^DD(.4032,.01,21,0)
 ;;=^^1^1^2940908^^^^
 ;;^DD(.4032,.01,21,1,0)
 ;;=Enter the name of the block to be placed on this page of the form.
 ;;^DD(.4032,.01,"DT")
 ;;=2930521
 ;;^DD(.4032,1,0)
 ;;=BLOCK ORDER^RNJ4,1X^^0;2^K:+X'=X!(X>99.9)!(X<1)!(X?.E1"."2N.N)!$D(^DIST(.403,DA(2),40,DA(1),40,"AC",X)) X
 ;;^DD(.4032,1,1,0)
 ;;=^.1
 ;;^DD(.4032,1,1,1,0)
 ;;=.4032^AC
 ;;^DD(.4032,1,1,1,1)
 ;;=S ^DIST(.403,DA(2),40,DA(1),40,"AC",$E(X,1,30),DA)=""
 ;;^DD(.4032,1,1,1,2)
 ;;=K ^DIST(.403,DA(2),40,DA(1),40,"AC",$E(X,1,30),DA)
 ;;^DD(.4032,1,1,1,"%D",0)
 ;;=^^2^2^2910118^^
 ;;^DD(.4032,1,1,1,"%D",1,0)
 ;;=This cross-reference is used to ensure that order numbers are unique for
 ;;^DD(.4032,1,1,1,"%D",2,0)
 ;;=the page.
 ;;^DD(.4032,1,1,1,"DT")
 ;;=2910118
 ;;^DD(.4032,1,3)
 ;;=Enter a number between 1 and 99.9, 1 Decimal Digit, which represents the order in which the block will be processed within the page.  This number must be unique for the page.
 ;;^DD(.4032,1,21,0)
 ;;=^^5^5^2940907^^
 ;;^DD(.4032,1,21,1,0)
 ;;=The Block Order determines the order users traverse fields on a page when
 ;;^DD(.4032,1,21,2,0)
 ;;=they press <F1><F4> to go to the next block, or press <RET> to move from
 ;;^DD(.4032,1,21,3,0)
 ;;=the last field on one block to the first field on the next.  When the user
 ;;^DD(.4032,1,21,4,0)
 ;;=first reaches a page, ScreenMan places the user on the block with the
 ;;^DD(.4032,1,21,5,0)
 ;;=lowest Block Order number.
 ;;^DD(.4032,2,0)
 ;;=BLOCK COORDINATE^F^^0;3^K:$L(X)>7!($L(X)<1)!'(X?.N1",".N) X
 ;;^DD(.4032,2,3)
 ;;=Enter the block coordinate relative to the page coordinate.  Answer must be two positive integers separated by a comma (,), as follows:  'Upper left row,Upper left column.'
 ;;^DD(.4032,2,21,0)
 ;;=^^2^2^2940907^^
 ;;^DD(.4032,2,21,1,0)
 ;;=The block coordinate is relative to the page coordinate.  The first row
 ;;^DD(.4032,2,21,2,0)
 ;;=and column on the block have a coordinate of 1,1.
 ;;^DD(.4032,2,"DT")
 ;;=2940908
 ;;^DD(.4032,3,0)
 ;;=TYPE OF BLOCK^S^e:EDIT;d:DISPLAY;^0;4^Q
 ;;^DD(.4032,3,3)
 ;;=
 ;;^DD(.4032,3,21,0)
 ;;=^^7^7^2940907^
 ;;^DD(.4032,3,21,1,0)
 ;;=Enter 'EDIT' if users can navigate to as well as edit fields in this
 ;;^DD(.4032,3,21,2,0)
 ;;=block.  Enter 'DISPLAY' if users cannot edit any of the fields in this
 ;;^DD(.4032,3,21,3,0)
 ;;=block.  User's can navigate to a DISPLAY block only if it contains
 ;;^DD(.4032,3,21,4,0)
 ;;=multiple or word processing fields, in which case, the cursor stops at any

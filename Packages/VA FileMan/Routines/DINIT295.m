DINIT295 ;SFISC/MKO-FORM AND BLOCK FILES ;11:18 AM  20 Aug 2002
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**8,999**
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
 G ^DINIT296
Q Q
 ;;^DIC(.404,0,"GL")
 ;;=^DIST(.404,
 ;;^DIC("B","BLOCK",.404)
 ;;=
 ;;^DIC(.404,"%D",0)
 ;;=^^2^2^2940914^
 ;;^DIC(.404,"%D",1,0)
 ;;=This file stores ScreenMan blocks, which are used to build forms in the
 ;;^DIC(.404,"%D",2,0)
 ;;=Form file.
 ;;^DD(.404,0)
 ;;=FIELD^^40^7
 ;;^DD(.404,0,"DT")
 ;;=2940625
 ;;^DD(.404,0,"IX","B",.404,.01)
 ;;=
 ;;^DD(.404,0,"NM","BLOCK")
 ;;=
 ;;^DD(.404,0,"PT",.4031,1)
 ;;=
 ;;^DD(.404,0,"PT",.4032,.01)
 ;;=
 ;;^DD(.404,.01,0)
 ;;=NAME^RFX^^0;1^K:$L(X)>30!($L(X)<3)!(X?1P.E)!(X=+$P(X,"E")) X I $D(X),$S($D(DDS)&$G(DA):$P($G(^DIST(.404,DA,0)),U)'=X,1:1),$D(^DIST(.404,"B",X)) K X
 ;;^DD(.404,.01,1,0)
 ;;=^.1
 ;;^DD(.404,.01,1,1,0)
 ;;=.404^B
 ;;^DD(.404,.01,1,1,1)
 ;;=S ^DIST(.404,"B",$E(X,1,30),DA)=""
 ;;^DD(.404,.01,1,1,2)
 ;;=K ^DIST(.404,"B",$E(X,1,30),DA)
 ;;^DD(.404,.01,1,1,"DT")
 ;;=2900912
 ;;^DD(.404,.01,3)
 ;;=Answer must be 3-30 characters in length.
 ;;^DD(.404,.01,21,0)
 ;;=^^2^2^2940907^^
 ;;^DD(.404,.01,21,1,0)
 ;;=Enter the name of the block, 3-30 characters in length.  The block name
 ;;^DD(.404,.01,21,2,0)
 ;;=must be unique and cannot be numeric or start with punctuation.
 ;;^DD(.404,.01,"DEL",1,0)
 ;;=I '$D(DDSDEL) D EN^DDIOL($C(7)_"You must use the FileMan options to delete blocks.") I 1
 ;;^DD(.404,.01,"DT")
 ;;=2931020
 ;;^DD(.404,1,0)
 ;;=DATA DICTIONARY NUMBER^FX^^0;2^K:X'=+$P(X,"E")!(X<2)!($L(X)>16)!'$D(^DD(X)) X
 ;;^DD(.404,1,3)
 ;;=Answer must be 1-16 characters in length.
 ;;^DD(.404,1,21,0)
 ;;=^^3^3^2940907^
 ;;^DD(.404,1,21,1,0)
 ;;=Enter the data dictionary number of the file or subfile that contains the
 ;;^DD(.404,1,21,2,0)
 ;;=fields that are placed on this block.  A block can contain fields from
 ;;^DD(.404,1,21,3,0)
 ;;=only one file or subfile.
 ;;^DD(.404,1,"DT")
 ;;=2930406
 ;;^DD(.404,2,0)
 ;;=DISABLE NAVIGATION^S^0:NO;1:YES;2:OUTOK;^0;3^Q
 ;;^DD(.404,2,3)
 ;;=
 ;;^DD(.404,2,21,0)
 ;;=^^8^8^2940907^^
 ;;^DD(.404,2,21,1,0)
 ;;=Enter 'YES' if navigation within the block should be disabled.  When
 ;;^DD(.404,2,21,2,0)
 ;;=navigation is disabled, user cannot ^-jump to other fields, they cannot
 ;;^DD(.404,2,21,3,0)
 ;;=^-jump to the Command Line, and the <Up>, <Down>, <Tab>, and <F4> keys
 ;;^DD(.404,2,21,4,0)
 ;;=traverse the fields in the same order as the <RET> key -- that is, in the
 ;;^DD(.404,2,21,5,0)
 ;;=order established by the Field Order property of the fields.
 ;;^DD(.404,2,21,6,0)
 ;;= 
 ;;^DD(.404,2,21,7,0)
 ;;=Enter 'OUTOK' to disable navigation, but allow the user to ^-jump to the
 ;;^DD(.404,2,21,8,0)
 ;;=Command Line.
 ;;^DD(.404,11,0)
 ;;=PRE ACTION^K^^11;E1,245^K:$L(X)>245 X D:$D(X) ^DIM
 ;;^DD(.404,11,3)
 ;;=Enter standard MUMPS code that will be executed when the user navigates to the block.
 ;;^DD(.404,11,9)
 ;;=@
 ;;^DD(.404,11,21,0)
 ;;=^^6^6^2940907^^
 ;;^DD(.404,11,21,1,0)
 ;;=This is MUMPS code that is executed when the user navigates to the
 ;;^DD(.404,11,21,2,0)
 ;;=block.
 ;;^DD(.404,11,21,3,0)
 ;;= 
 ;;^DD(.404,11,21,4,0)
 ;;=This pre-action is part of the block definition itself, so if this
 ;;^DD(.404,11,21,5,0)
 ;;=block is used on another page or another form, the pre-action still
 ;;^DD(.404,11,21,6,0)
 ;;=applies.
 ;;^DD(.404,12,0)
 ;;=POST ACTION^K^^12;E1,245^K:$L(X)>245 X D:$D(X) ^DIM
 ;;^DD(.404,12,3)
 ;;=Enter standard MUMPS that will be executed when the user leaves the block.
 ;;^DD(.404,12,9)
 ;;=@
 ;;^DD(.404,12,21,0)
 ;;=^^5^5^2940907^^
 ;;^DD(.404,12,21,1,0)
 ;;=This is MUMPS code that is executed when the user leaves the block.
 ;;^DD(.404,12,21,2,0)
 ;;= 
 ;;^DD(.404,12,21,3,0)
 ;;=This post-action is part of the block definition itself, so if the
 ;;^DD(.404,12,21,4,0)
 ;;=block is used on another page or on another form, the post-action still
 ;;^DD(.404,12,21,5,0)
 ;;=applies.
 ;;^DD(.404,15,0)
 ;;=DESCRIPTION^.40415^^15;0
 ;;^DD(.404,40,0)
 ;;=FIELD^.4044I^^40;0
 ;;^DD(.404,40,"DT")
 ;;=2931029
 ;;^DD(.40415,0)
 ;;=DESCRIPTION SUB-FIELD^^.01^1
 ;;^DD(.40415,0,"DT")
 ;;=2910204
 ;;^DD(.40415,0,"NM","DESCRIPTION")
 ;;=
 ;;^DD(.40415,0,"UP")
 ;;=.404
 ;;^DD(.40415,.01,0)
 ;;=DESCRIPTION^W^^0;1^Q
 ;;^DD(.40415,.01,3)
 ;;=
 ;;^DD(.40415,.01,21,0)
 ;;=^^1^1^2940908^^^
 ;;^DD(.40415,.01,21,1,0)
 ;;=Enter text that describes this block.
 ;;^DD(.4044,0)
 ;;=FIELD SUB-FIELD^^30^33
 ;;^DD(.4044,0,"DT")
 ;;=2940625
 ;;^DD(.4044,0,"ID","WRITE")
 ;;=D EN^DDIOL($S($P(^(0),U,2)?1"Select "1.E:$E($P(^(0),U,2),8,999),1:$S($P(^(0),U,2)="!M":$G(^(.1)),1:$P(^(0),U,2)))_$S($P(^(0),U,4)]"":"  ("_$P(^(0),U,4)_")",1:""),"","?9")
 ;;^DD(.4044,0,"ID","WRITE1")
 ;;=D EN^DDIOL($S($P($G(^(7)),U,2):"  (Sub Page Link defined)",1:"")_$S($G(^(1)):"   (Field #"_^(1)_")",1:"")_$S($P(^(0),U,5)]"":"  ("_$P(^(0),U,5)_")",1:""),"","?0")
 ;;^DD(.4044,0,"IX","B",.4044,.01)
 ;;=
 ;;^DD(.4044,0,"IX","C",.4044,1)
 ;;=
 ;;^DD(.4044,0,"IX","D",.4044,3.1)
 ;;=
 ;;^DD(.4044,0,"NM","FIELD")
 ;;=
 ;;^DD(.4044,0,"UP")
 ;;=.404
 ;;^DD(.4044,.01,0)
 ;;=FIELD ORDER^MNJ4,1X^^0;1^K:X'=+$P(X,"E")!(X>99.9)!(X<0)!(X?.E1"."2N.N) X I $D(X),$D(^DIST(.404,DA(1),40,"B",X)) K X
 ;;^DD(.4044,.01,1,0)
 ;;=^.1
 ;;^DD(.4044,.01,1,1,0)
 ;;=.4044^B
 ;;^DD(.4044,.01,1,1,1)
 ;;=S ^DIST(.404,DA(1),40,"B",$E(X,1,30),DA)=""
 ;;^DD(.4044,.01,1,1,2)
 ;;=K ^DIST(.404,DA(1),40,"B",$E(X,1,30),DA)
 ;;^DD(.4044,.01,3)
 ;;=Enter a unique number between 0 and 99.9, inclusive, which represents the order in which the fields will be edited.
 ;;^DD(.4044,.01,21,0)
 ;;=^^2^2^2940907^
 ;;^DD(.4044,.01,21,1,0)
 ;;=The Field Order number determines the order in which users traverse the
 ;;^DD(.4044,.01,21,2,0)
 ;;=fields in the block as they press <RET>.
 ;;^DD(.4044,1,0)
 ;;=CAPTION^FX^^0;2^K:$L(X)>80!($L(X)<1) X S:$E($G(X))="!"&($G(X)'="!M") X=$$FUNC^DDSCAP(X)
 ;;^DD(.4044,1,1,0)
 ;;=^.1^^-1
 ;;^DD(.4044,1,1,2,0)
 ;;=.4044^C^MUMPS
 ;;^DD(.4044,1,1,2,1)
 ;;=S:X'="!M" ^DIST(.404,DA(1),40,"C",$$UP^DILIBF($E($S(X?1"Select "1.E:$P(X,"Select ",2,99),1:X),1,63)),DA)=""
 ;;^DD(.4044,1,1,2,2)
 ;;=K:X'="!M" ^DIST(.404,DA(1),40,"C",$$UP^DILIBF($E($S(X?1"Select "1.E:$P(X,"Select ",2,99),1:X),1,63)),DA)
 ;;^DD(.4044,1,1,2,3)
 ;;=Programmer only
 ;;^DD(.4044,1,1,2,"%D",0)
 ;;=^^2^2^2931029^^^^
 ;;^DD(.4044,1,1,2,"%D",1,0)
 ;;=This cross referenced is used to allow selection of fields by caption name
 ;;^DD(.4044,1,1,2,"%D",2,0)
 ;;=as well as by order number when entering new fields in the block.
 ;;^DD(.4044,1,1,2,"DT")
 ;;=2920214

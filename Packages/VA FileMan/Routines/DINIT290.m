DINIT290 ;SFISC/MKO-FORM AND BLOCK FILES ;07:10 PM  5 Aug 2002
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
 G ^DINIT291
Q Q
 ;;^DIC(.403,0,"GL")
 ;;=^DIST(.403,
 ;;^DIC("B","FORM",.403)
 ;;=
 ;;^DIC(.403,"%D",0)
 ;;=^^3^3^2940914^
 ;;^DIC(.403,"%D",1,0)
 ;;=This file stores ScreenMan forms, which are composed of blocks.  The
 ;;^DIC(.403,"%D",2,0)
 ;;=form's attributes that describe how information is presented on the screen
 ;;^DIC(.403,"%D",3,0)
 ;;=are contained in this file.
 ;;^DD(.403,0)
 ;;=FIELD^^40^18
 ;;^DD(.403,0,"DT")
 ;;=2941018
 ;;^DD(.403,0,"ID","WRITE")
 ;;=N D,D1,D2 S D2=^(0) S:$X>30 D1(1,"F")="!" S D=$P(D2,U,5) S:D D1(2)="("_$$DATE^DIUTL(D)_")",D1(2,"F")="?30" S D=$P(D2,U,4) S:D D1(3)="User #"_D,D1(3,"F")="?50" S D=$P(D2,U,8) S:D D1(4)=" File #"_D,D1(4,"F")="?59" D EN^DDIOL(.D1)
 ;;^DD(.403,0,"ID","WRITED")
 ;;=I $G(DZ)?1"???".E N D S D=0 F  S D=$O(^DIST(.403,Y,15,D)) Q:D'>0  I $D(^(D,0))#2 D EN^DDIOL(^(0),"","!?5")
 ;;^DD(.403,0,"IX","AB",.4032,.01)
 ;;=
 ;;^DD(.403,0,"IX","AC",.4031,1)
 ;;=
 ;;^DD(.403,0,"IX","AY",.403,.01)
 ;;=
 ;;^DD(.403,0,"IX","B",.403,.01)
 ;;=
 ;;^DD(.403,0,"IX","C",.403,6)
 ;;=
 ;;^DD(.403,0,"IX","F",.403,7)
 ;;=
 ;;^DD(.403,0,"IX","F1",.403,.01)
 ;;=
 ;;^DD(.403,0,"NM","FORM")
 ;;=
 ;;^DD(.403,.01,0)
 ;;=NAME^RFX^^0;1^K:X[""""!($A(X)=45) X I $D(X) K:$L(X)>30!($L(X)<3)!'(X'?1P.E)!(X=+$P(X,"E")) X
 ;;^DD(.403,.01,1,0)
 ;;=^.1
 ;;^DD(.403,.01,1,1,0)
 ;;=.403^B
 ;;^DD(.403,.01,1,1,1)
 ;;=S ^DIST(.403,"B",$E(X,1,30),DA)=""
 ;;^DD(.403,.01,1,1,2)
 ;;=K ^DIST(.403,"B",$E(X,1,30),DA)
 ;;^DD(.403,.01,1,2,0)
 ;;=.403^F1^MUMPS
 ;;^DD(.403,.01,1,2,1)
 ;;=X "S %=$P("_DIC_"DA,0),U,8) S:$L(%) "_DIC_"""F""_%,X,DA)=1"
 ;;^DD(.403,.01,1,2,2)
 ;;=X "S %=$P("_DIC_"DA,0),U,8) K:$L(%) "_DIC_"""F""_%,X,DA)"
 ;;^DD(.403,.01,1,2,3)
 ;;=Programmer only
 ;;^DD(.403,.01,1,2,"%D",0)
 ;;=^^6^6^2910812^
 ;;^DD(.403,.01,1,2,"%D",1,0)
 ;;=This cross-reference is used to quickly find all ScreenMan templates
 ;;^DD(.403,.01,1,2,"%D",2,0)
 ;;=associated with a file.  It has the form:
 ;;^DD(.403,.01,1,2,"%D",3,0)
 ;;=
 ;;^DD(.403,.01,1,2,"%D",4,0)
 ;;=  ^DIST(.403,"F"_file#,"formname",DA)=1
 ;;^DD(.403,.01,1,2,"%D",5,0)
 ;;=
 ;;^DD(.403,.01,1,2,"%D",6,0)
 ;;=A comparable cross-reference also exists on the PRIMARY FILE field.
 ;;^DD(.403,.01,1,2,"DT")
 ;;=2910812
 ;;^DD(.403,.01,1,3,0)
 ;;=.403^AY^MUMPS
 ;;^DD(.403,.01,1,3,1)
 ;;=Q
 ;;^DD(.403,.01,1,3,2)
 ;;=Q
 ;;^DD(.403,.01,1,3,3)
 ;;=Programmer only
 ;;^DD(.403,.01,1,3,"%D",0)
 ;;=^^7^7^2980924^
 ;;^DD(.403,.01,1,3,"%D",1,0)
 ;;=This is a no-op cross reference defined merely to document the data stored
 ;;^DD(.403,.01,1,3,"%D",2,0)
 ;;=under ^DIST(.403,form IEN,"AY").
 ;;^DD(.403,.01,1,3,"%D",3,0)
 ;;= 
 ;;^DD(.403,.01,1,3,"%D",4,0)
 ;;=This global stores the compiled data for a Form. Form compilation occurs
 ;;^DD(.403,.01,1,3,"%D",5,0)
 ;;=automatically whenever a Form is edited through the FileMan supplied
 ;;^DD(.403,.01,1,3,"%D",6,0)
 ;;=options. The compiled data stored in this global is static information
 ;;^DD(.403,.01,1,3,"%D",7,0)
 ;;=that is used whenever a Form is run.
 ;;^DD(.403,.01,1,3,"DT")
 ;;=2980904
 ;;^DD(.403,.01,3)
 ;;=Answer must be 3-30 characters in length.
 ;;^DD(.403,.01,21,0)
 ;;=^^3^3^2940906^
 ;;^DD(.403,.01,21,1,0)
 ;;=Enter the name of the form, 3-30 characters in length.  The form name
 ;;^DD(.403,.01,21,2,0)
 ;;=must be unique and cannot be numeric or start with a punctuation
 ;;^DD(.403,.01,21,3,0)
 ;;=character.  It should also be namespaced.
 ;;^DD(.403,.01,"DEL",1,0)
 ;;=D EN^DDIOL($C(7)_"You must use the FileMan option to delete forms.") I 1
 ;;^DD(.403,.01,"DT")
 ;;=2980904
 ;;^DD(.403,1,0)
 ;;=READ ACCESS^FX^^0;2^I DUZ(0)'="@" N DDZ F DDZ=1:1:$L(X) K:DUZ(0)'[$E(X,DDZ) X
 ;;^DD(.403,1,3)
 ;;=Enter VA FileMan access code(s) which control access to the form.
 ;;^DD(.403,1,21,0)
 ;;=^^1^1^2931020^^
 ;;^DD(.403,1,21,1,0)
 ;;=Non-programmers can enter only their own VA FileMan access code(s).
 ;;^DD(.403,1,"DT")
 ;;=2931020
 ;;^DD(.403,2,0)
 ;;=WRITE ACCESS^FX^^0;3^I DUZ(0)'="@" N DDZ F DDZ=1:1:$L(X) K:DUZ(0)'[$E(X,DDZ) X
 ;;^DD(.403,2,3)
 ;;=Enter VA FileMan access code(s) which control access to the form.
 ;;^DD(.403,2,21,0)
 ;;=^^1^1^2931020^
 ;;^DD(.403,2,21,1,0)
 ;;=Non-programmers can enter only their own VA FileMan access code(s).
 ;;^DD(.403,2,"DT")
 ;;=2931020
 ;;^DD(.403,3,0)
 ;;=CREATOR^NJ3,0X^^0;4^K:X'?.N X
 ;;^DD(.403,3,3)
 ;;=Enter the VA FileMan User Number of the form creator.
 ;;^DD(.403,3,21,0)
 ;;=^^2^2^2931020^^
 ;;^DD(.403,3,21,1,0)
 ;;=This is the DUZ of the person who created the form.  The ScreenMan
 ;;^DD(.403,3,21,2,0)
 ;;=options to create the form automatically put a value into this field.
 ;;^DD(.403,4,0)
 ;;=DATE CREATED^D^^0;5^S %DT="ETX" D ^%DT S X=Y K:Y<1 X
 ;;^DD(.403,4,3)
 ;;=Enter the date the form was created.
 ;;^DD(.403,4,21,0)
 ;;=^^2^2^2941018^^
 ;;^DD(.403,4,21,1,0)
 ;;=This is the date the form was created.  The ScreenMan options to create
 ;;^DD(.403,4,21,2,0)
 ;;=the form automatically put a value into this field.
 ;;^DD(.403,4,"DT")
 ;;=2941018
 ;;^DD(.403,5,0)
 ;;=DATE LAST USED^D^^0;6^S %DT="ETX" D ^%DT S X=Y K:Y<1 X
 ;;^DD(.403,5,3)
 ;;=Enter the date and time the form was last used.
 ;;^DD(.403,5,21,0)
 ;;=^^2^2^2941018^^
 ;;^DD(.403,5,21,1,0)
 ;;=This is the date the form was last used.  ScreenMan automatically
 ;;^DD(.403,5,21,2,0)
 ;;=puts a value into this field when the form is invoked.
 ;;^DD(.403,5,"DT")
 ;;=2941018
 ;;^DD(.403,6,0)
 ;;=TITLE^F^^0;7^K:$L(X)>50!($L(X)<1) X
 ;;^DD(.403,6,1,0)
 ;;=^.1
 ;;^DD(.403,6,1,1,0)
 ;;=.403^C
 ;;^DD(.403,6,1,1,1)
 ;;=S ^DIST(.403,"C",$E(X,1,30),DA)=""
 ;;^DD(.403,6,1,1,2)
 ;;=K ^DIST(.403,"C",$E(X,1,30),DA)
 ;;^DD(.403,6,1,1,"DT")
 ;;=2940908
 ;;^DD(.403,6,3)
 ;;=Answer must be 1-50 characters in length.
 ;;^DD(.403,6,21,0)
 ;;=^^4^4^2940908^
 ;;^DD(.403,6,21,1,0)
 ;;=The TITLE property can be used by the form designer to help identify a
 ;;^DD(.403,6,21,2,0)
 ;;=form.  It is cross referenced and need not be unique.  ScreenMan does not
 ;;^DD(.403,6,21,3,0)
 ;;=automatically display the TITLE to the user, but the form designer can
 ;;^DD(.403,6,21,4,0)
 ;;=choose to define a caption-only field that displays the title to the user.
 ;;^DD(.403,6,22)
 ;;=
 ;;^DD(.403,6,"DT")
 ;;=2940908
 ;;^DD(.403,7,0)
 ;;=PRIMARY FILE^RFX^^0;8^K:X'=+$P(X,"E")!(X<2)!($L(X)>16)!'$D(^DIC(X)) X
 ;;^DD(.403,7,1,0)
 ;;=^.1
 ;;^DD(.403,7,1,1,0)
 ;;=.403^F^MUMPS
 ;;^DD(.403,7,1,1,1)
 ;;=X "S %=$P("_DIC_"DA,0),U) S "_DIC_"""F""_X,%,DA)=1"
 ;;^DD(.403,7,1,1,2)
 ;;=X "S %=$P("_DIC_"DA,0),U) K "_DIC_"""F""_X,%,DA)"

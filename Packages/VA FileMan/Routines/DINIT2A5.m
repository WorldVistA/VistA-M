DINIT2A5 ;SFISC/MKO-KEY AND INDEX FILES ;10:50 AM  30 Mar 1999
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
 G ^DINIT2A6
Q Q
 ;;^DIC(.31,0,"GL")
 ;;=^DD("KEY",
 ;;^DIC("B","KEY",.31)
 ;;=
 ;;^DIC(.31,"%D",0)
 ;;=^^12^12^2980911^
 ;;^DIC(.31,"%D",1,0)
 ;;=This file stores information about keys on a file or subfile. A key is a
 ;;^DIC(.31,"%D",2,0)
 ;;=set of one or more fields that uniquely identifies a record in a file. If
 ;;^DIC(.31,"%D",3,0)
 ;;=more than one set of fields can uniquely identify a record, one of those
 ;;^DIC(.31,"%D",4,0)
 ;;=sets should be designated the primary key; all others should be designated
 ;;^DIC(.31,"%D",5,0)
 ;;=secondary keys. The primary key is the principal means of identifying
 ;;^DIC(.31,"%D",6,0)
 ;;=records in the file.
 ;;^DIC(.31,"%D",7,0)
 ;;= 
 ;;^DIC(.31,"%D",8,0)
 ;;=To allow FileMan to enforce key uniqueness, the database designer must
 ;;^DIC(.31,"%D",9,0)
 ;;=define a regular index that consists of all the fields that make up the
 ;;^DIC(.31,"%D",10,0)
 ;;=key. This index is called the uniqueness index.
 ;;^DIC(.31,"%D",11,0)
 ;;= 
 ;;^DIC(.31,"%D",12,0)
 ;;=All key fields must have values. They cannot be null.
 ;;^DD(.31,0)
 ;;=FIELD^^3^5
 ;;^DD(.31,0,"DDA")
 ;;=N
 ;;^DD(.31,0,"DT")
 ;;=2980611
 ;;^DD(.31,0,"IX","B",.31,.01)
 ;;=
 ;;^DD(.31,0,"NM","KEY")
 ;;=
 ;;^DD(.31,.01,0)
 ;;=FILE^RNJ20,7^^0;1^K:+X'=X!(X>999999999999)!(X<0)!(X?.E1"."8N.N) X
 ;;^DD(.31,.01,1,0)
 ;;=^.1^^-1
 ;;^DD(.31,.01,1,1,0)
 ;;=.31^B
 ;;^DD(.31,.01,1,1,1)
 ;;=S ^DD("KEY","B",$E(X,1,30),DA)=""
 ;;^DD(.31,.01,1,1,2)
 ;;=K ^DD("KEY","B",$E(X,1,30),DA)
 ;;^DD(.31,.01,1,1,3)
 ;;=Lets developers pick keys by their file number
 ;;^DD(.31,.01,1,1,"%D",0)
 ;;=^^2^2^2980911^^
 ;;^DD(.31,.01,1,1,"%D",1,0)
 ;;=The B index on the .01 (File) of the Key file lets developers pick keys by
 ;;^DD(.31,.01,1,1,"%D",2,0)
 ;;=the file whose records they uniquely distinguish.
 ;;^DD(.31,.01,3)
 ;;=Type a Number between 0 and 999999999999, 7 Decimal Digits. Answer '??' for more help.
 ;;^DD(.31,.01,4)
 ;;=
 ;;^DD(.31,.01,21,0)
 ;;=^^2^2^2980908^
 ;;^DD(.31,.01,21,1,0)
 ;;=Answer should be the number of the file or subfile identified by this key.
 ;;^DD(.31,.01,21,2,0)
 ;;=A file may have more than one key, but only one primary key.
 ;;^DD(.31,.01,"DT")
 ;;=2980611
 ;;^DD(.31,.02,0)
 ;;=NAME^RF^^0;2^K:$L(X)>1!($L(X)<1)!'(X?1U) X
 ;;^DD(.31,.02,3)
 ;;=Answer must be 1 upper case letter. Answer '??' for more help.
 ;;^DD(.31,.02,4)
 ;;=
 ;;^DD(.31,.02,21,0)
 ;;=^^3^3^2980908^^
 ;;^DD(.31,.02,21,1,0)
 ;;=Answer must be the name of this key. The name of a file's primary key
 ;;^DD(.31,.02,21,2,0)
 ;;=should be A, with subsequent keys for the same file named B, C, and so
 ;;^DD(.31,.02,21,3,0)
 ;;=on.
 ;;^DD(.31,.02,"DT")
 ;;=2960122
 ;;^DD(.31,1,0)
 ;;=PRIORITY^RS^P:PRIMARY;S:SECONDARY;^0;3^Q
 ;;^DD(.31,1,3)
 ;;=Answer '??' for more help.
 ;;^DD(.31,1,21,0)
 ;;=^^2^2^2980911^
 ;;^DD(.31,1,21,1,0)
 ;;=Answer 'PRIMARY' if this is the primary key of the file, the key that will
 ;;^DD(.31,1,21,2,0)
 ;;=usually be used for identifying entries. Otherwise, answer 'SECONDARY'.
 ;;^DD(.31,1,"DT")
 ;;=2970725
 ;;^DD(.31,2,0)
 ;;=FIELD^.312IA^^2;0
 ;;^DD(.31,2,"DT")
 ;;=2980310
 ;;^DD(.31,3,0)
 ;;=UNIQUENESS INDEX^*P.11'^DD("IX",^0;4^S DIC("S")="I 1 Q:'$D(DDS)!'$D(DIKKEY)  I $P(^(0),U,9)=$P(^DD(""KEY"",DIKKEY,0),U)" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 ;;^DD(.31,3,3)
 ;;=Answer '??' for more help.
 ;;^DD(.31,3,12)
 ;;=Root File of Index must equal File of Key.
 ;;^DD(.31,3,12.1)
 ;;=S DIC("S")="I 1 Q:'$D(DDS)!'$D(DIKKEY)  I $P(^(0),U,9)=$P(^DD(""KEY"",DIKKEY,0),U)"
 ;;^DD(.31,3,21,0)
 ;;=^^3^3^2981120^
 ;;^DD(.31,3,21,1,0)
 ;;=Answer with the index that FileMan should use to ensure that new key
 ;;^DD(.31,3,21,2,0)
 ;;=values are unique. It must be a new-style index that resides in the
 ;;^DD(.31,3,21,3,0)
 ;;=Index file, and must cross-reference the key fields in proper sequence.
 ;;^DD(.31,3,"DT")
 ;;=2980611
 ;;^DD(.312,0)
 ;;=FIELD SUB-FIELD^^1^3
 ;;^DD(.312,0,"DT")
 ;;=2960219
 ;;^DD(.312,0,"ID","WRITE")
 ;;=D EN^DDIOL("   "_$P(^(0),U,2),"","?0")
 ;;^DD(.312,0,"IX","B",.312,.01)
 ;;=
 ;;^DD(.312,0,"NM","FIELD")
 ;;=
 ;;^DD(.312,0,"UP")
 ;;=.31
 ;;^DD(.312,.01,0)
 ;;=FIELD^MRFX^^0;1^D ITFLD^DIKKDD I $D(X) K:$L(X)>20!($L(X)<1) X
 ;;^DD(.312,.01,1,0)
 ;;=^.1
 ;;^DD(.312,.01,1,1,0)
 ;;=.312^B
 ;;^DD(.312,.01,1,1,1)
 ;;=S ^DD("KEY",DA(1),2,"B",$E(X,1,30),DA)=""
 ;;^DD(.312,.01,1,1,2)
 ;;=K ^DD("KEY",DA(1),2,"B",$E(X,1,30),DA)
 ;;^DD(.312,.01,1,1,3)
 ;;=LETS DEVELOPER PICK KEY FIELDS BY NUMBER
 ;;^DD(.312,.01,1,1,"%D",0)
 ;;=^^2^2^2980908^
 ;;^DD(.312,.01,1,1,"%D",1,0)
 ;;=The B index, on the .01 (Field) of the Fields multiple, lets the developer
 ;;^DD(.312,.01,1,1,"%D",2,0)
 ;;=pick key fields by field number.
 ;;^DD(.312,.01,1,2,0)
 ;;=^^TRIGGER^.312^.02
 ;;^DD(.312,.01,1,2,1)
 ;;=K DIV S DIV=X,D0=DA(1),DIV(0)=D0,D1=DA,DIV(1)=D1 S Y(1)=$S($D(^DD("KEY",D0,2,D1,0)):^(0),1:"") S X=$P(Y(1),U,2),X=X S DIU=X K Y X ^DD(.312,.01,1,2,1.1) X ^DD(.312,.01,1,2,1.4)
 ;;^DD(.312,.01,1,2,1.1)
 ;;=S X=DIV S X=$P(^DD("KEY",DA(1),0),U)
 ;;^DD(.312,.01,1,2,1.4)
 ;;=S DIH=$S($D(^DD("KEY",DIV(0),2,DIV(1),0)):^(0),1:""),DIV=X S $P(^(0),U,2)=DIV,DIH=.312,DIG=.02 D ^DICR:$O(^DD(DIH,DIG,1,0))>0
 ;;^DD(.312,.01,1,2,2)
 ;;=Q
 ;;^DD(.312,.01,1,2,"CREATE VALUE")
 ;;=S X=$P(^DD("KEY",DA(1),0),U)
 ;;^DD(.312,.01,1,2,"DELETE VALUE")
 ;;=NO EFFECT
 ;;^DD(.312,.01,1,2,"DT")
 ;;=2980310
 ;;^DD(.312,.01,1,2,"FIELD")
 ;;=FILE
 ;;^DD(.312,.01,3)
 ;;=Answer must be 1-20 characters in length. Answer '??' for more help.
 ;;^DD(.312,.01,4)
 ;;=D EHFLD^DIKKDD
 ;;^DD(.312,.01,21,0)
 ;;=^^1^1^2980908^
 ;;^DD(.312,.01,21,1,0)
 ;;=Answer must be the number of one of this key's fields.
 ;;^DD(.312,.01,"DT")
 ;;=2980611
 ;;^DD(.312,.02,0)
 ;;=FILE^RNJ20,7I^^0;2^K:+X'=X!(X>999999999999)!(X<0)!(X?.E1"."8N.N) X
 ;;^DD(.312,.02,.1)
 ;;=
 ;;^DD(.312,.02,1,0)
 ;;=^.1^^0
 ;;^DD(.312,.02,3)
 ;;=Type a Number between 0 and 999999999999, 7 Decimal Digits. Answer '??' for more help.
 ;;^DD(.312,.02,5,1,0)
 ;;=.312^.01^2
 ;;^DD(.312,.02,21,0)
 ;;=^^3^3^2980908^
 ;;^DD(.312,.02,21,1,0)
 ;;=Answer must be the number of the file that holds this key field. It must
 ;;^DD(.312,.02,21,2,0)
 ;;=equal the number of the file whose records are uniquiely identified by
 ;;^DD(.312,.02,21,3,0)
 ;;=this key.
 ;;^DD(.312,.02,"DT")
 ;;=2980908
 ;;^DD(.312,1,0)
 ;;=SEQUENCE NUMBER^RNJ3,0^^0;3^K:+X'=X!(X>125)!(X<1)!(X?.E1"."1N.N) X
 ;;^DD(.312,1,3)
 ;;=Answer must be between 1 and 125, with no decimal digits. Answer '??' for more help.

DINIT2C0 ;SFISC/MKO-IMPORT TEMPLATE FILE ;06:12 PM  16 Dec 1999
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**999**
 ;
 ;**CCO/NI TAG 'Q+12' CHANGED FOR DATE FORMAT
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
 G ^DINIT3
Q Q
 ;;^DIC(.46,0,"GL")
 ;;=^DIST(.46,
 ;;^DIC("B","IMPORT TEMPLATE",.46)
 ;;=
 ;;^DD(.46,0)
 ;;=FIELD^^2^9
 ;;^DD(.46,0,"DDA")
 ;;=N
 ;;^DD(.46,0,"DT")
 ;;=2960531
 ;;^DD(.46,0,"ID","WRITE")
 ;;=N D,D1,D2 S D2=^(0) S:$X>30 D1(1,"F")="!" S D=$P(D2,U,2) S:D D1(2)="("_$$DATE^DIUTL(D)_")",D1(2,"F")="?30" S D=$P(D2,U,5) S:D D1(3)="User #"_D,D1(3,"F")="?47" S D=$P(D2,U,4) S:D D1(4)=" File #"_D,D1(4,"F")="?59" D EN^DDIOL(.D1)
 ;;^DD(.46,0,"IX","B",.46,.01)
 ;;=
 ;;^DD(.46,0,"IX","F",.46,4)
 ;;=
 ;;^DD(.46,0,"IX","F1",.46,.01)
 ;;=
 ;;^DD(.46,0,"NM","IMPORT TEMPLATE")
 ;;=
 ;;^DD(.46,.01,0)
 ;;=NAME^RF^^0;1^K:$L(X)>30!(X?.N)!($L(X)<3)!'(X'?1P.E) X
 ;;^DD(.46,.01,1,0)
 ;;=^.1^^-1
 ;;^DD(.46,.01,1,1,0)
 ;;=.46^B
 ;;^DD(.46,.01,1,1,1)
 ;;=S ^DIST(.46,"B",$E(X,1,30),DA)=""
 ;;^DD(.46,.01,1,1,2)
 ;;=K ^DIST(.46,"B",$E(X,1,30),DA)
 ;;^DD(.46,.01,1,3,0)
 ;;=.46^F1^MUMPS
 ;;^DD(.46,.01,1,3,1)
 ;;=N DDMPX S DDMPX=$P($G(^DIST(.46,DA,0)),U,4) I DDMPX]"" S ^DIST(.46,"F"_DDMPX,X,DA)=""
 ;;^DD(.46,.01,1,3,2)
 ;;=N DDMPX S DDMPX=$P($G(^DIST(.46,DA,0)),U,4) I DDMPX]"" K ^DIST(.46,"F"_DDMPX,X,DA)
 ;;^DD(.46,.01,1,3,3)
 ;;=Along with F cross-reference manages F_file# index.
 ;;^DD(.46,.01,1,3,"%D",0)
 ;;=^^2^2^2960531^^
 ;;^DD(.46,.01,1,3,"%D",1,0)
 ;;=Creates a cross-reference based on F_file# that is used as a lookup
 ;;^DD(.46,.01,1,3,"%D",2,0)
 ;;=cross-reference.  Allows quick lookups by file number.
 ;;^DD(.46,.01,1,3,"DT")
 ;;=2960531
 ;;^DD(.46,.01,3)
 ;;=NAME MUST BE 3-30 CHARACTERS, NOT NUMERIC OR STARTING WITH PUNCTUATION
 ;;^DD(.46,.01,"DT")
 ;;=2960531
 ;;^DD(.46,2,0)
 ;;=DATE CREATED^D^^0;2^S %DT="E" D ^%DT S X=Y K:Y<1 X
 ;;^DD(.46,2,21,0)
 ;;=^^1^1^2960531^
 ;;^DD(.46,2,21,1,0)
 ;;=Date that the import template was created.
 ;;^DD(.46,2,"DT")
 ;;=2960531
 ;;^DD(.46,3,0)
 ;;=READ ACCESS^F^^0;3^K:$L(X)>15!($L(X)<1) X
 ;;^DD(.46,3,3)
 ;;=Answer must be 1-15 characters in length.
 ;;^DD(.46,3,21,0)
 ;;=^^2^2^2960531^
 ;;^DD(.46,3,21,1,0)
 ;;=Access codes necessary to use the Import Template.
 ;;^DD(.46,3,21,2,0)
 ;;=If null, anyone can use the template.
 ;;^DD(.46,3,"DT")
 ;;=2960531
 ;;^DD(.46,4,0)
 ;;=PRIMARY FILE^RP1'^DIC(^0;4^Q
 ;;^DD(.46,4,1,0)
 ;;=^.1
 ;;^DD(.46,4,1,1,0)
 ;;=.46^F^MUMPS
 ;;^DD(.46,4,1,1,1)
 ;;=N DDMPX S DDMPX=$P($G(^DIST(.46,DA,0)),U,1) I DDMPX]"" S ^DIST(.46,"F"_X,DDMPX,DA)=""
 ;;^DD(.46,4,1,1,2)
 ;;=N DDMPX S DDMPX=$P($G(^DIST(.46,DA,0)),U,1) I DDMPX]"" K ^DIST(.46,"F"_X,DDMPX,DA)
 ;;^DD(.46,4,1,1,3)
 ;;=With F1 cross-reference manages the F_file# index.
 ;;^DD(.46,4,1,1,"%D",0)
 ;;=^^2^2^2960531^
 ;;^DD(.46,4,1,1,"%D",1,0)
 ;;=Creates an index under F_file# that is used as a compound index for
 ;;^DD(.46,4,1,1,"%D",2,0)
 ;;=lookups when the file# is known.
 ;;^DD(.46,4,1,1,"DT")
 ;;=2960531
 ;;^DD(.46,4,21,0)
 ;;=^^1^1^2960531^^^
 ;;^DD(.46,4,21,1,0)
 ;;=File that is the starting point for data import.
 ;;^DD(.46,4,"DT")
 ;;=2960531
 ;;^DD(.46,5,0)
 ;;=CREATOR^P200'^VA(200,^0;5^Q
 ;;^DD(.46,5,21,0)
 ;;=^^1^1^2960531^
 ;;^DD(.46,5,21,1,0)
 ;;=Person who created the import template.
 ;;^DD(.46,5,"DT")
 ;;=2960531
 ;;^DD(.46,6,0)
 ;;=WRITE ACCESS^F^^0;6^K:$L(X)>15!($L(X)<1) X
 ;;^DD(.46,6,3)
 ;;=Answer must be 1-15 characters in length.
 ;;^DD(.46,6,21,0)
 ;;=^^2^2^2960531^
 ;;^DD(.46,6,21,1,0)
 ;;=Access codes needed to change or delete the import template.  If null,
 ;;^DD(.46,6,21,2,0)
 ;;=anyone can change or delete the template.
 ;;^DD(.46,6,"DT")
 ;;=2960531
 ;;^DD(.46,7,0)
 ;;=DATE LAST USED^D^^0;7^S %DT="EX" D ^%DT S X=Y K:Y<1 X
 ;;^DD(.46,7,21,0)
 ;;=^^1^1^2960531^
 ;;^DD(.46,7,21,1,0)
 ;;=Date template was last used.
 ;;^DD(.46,7,"DT")
 ;;=2960531
 ;;^DD(.46,10,0)
 ;;=DESCRIPTION^.461^^10;0
 ;;^DD(.46,30,0)
 ;;=IMPORT FIELDS^.463^^30;0
 ;;^DD(.461,0)
 ;;=DESCRIPTION SUB-FIELD^^.01^1
 ;;^DD(.461,0,"DT")
 ;;=2960531
 ;;^DD(.461,0,"NM","DESCRIPTION")
 ;;=
 ;;^DD(.461,0,"UP")
 ;;=.46
 ;;^DD(.461,.01,0)
 ;;=DESCRIPTION^W^^0;1^Q
 ;;^DD(.461,.01,"DT")
 ;;=2960531
 ;;^DD(.463,0)
 ;;=IMPORT FIELDS SUB-FIELD^^20^6
 ;;^DD(.463,0,"DT")
 ;;=2960530
 ;;^DD(.463,0,"IX","B",.463,.01)
 ;;=
 ;;^DD(.463,0,"NM","IMPORT FIELDS")
 ;;=
 ;;^DD(.463,0,"UP")
 ;;=.46
 ;;^DD(.463,.01,0)
 ;;=IMPORT SEQUENCE^MRNJ3,0X^^0;1^K:+X'=X!(X>999)!(X<1)!(X?.E1"."1N.N) X S:$D(X) DINUM=X
 ;;^DD(.463,.01,1,0)
 ;;=^.1
 ;;^DD(.463,.01,1,1,0)
 ;;=.463^B
 ;;^DD(.463,.01,1,1,1)
 ;;=S ^DIST(.46,DA(1),30,"B",$E(X,1,30),DA)=""
 ;;^DD(.463,.01,1,1,2)
 ;;=K ^DIST(.46,DA(1),30,"B",$E(X,1,30),DA)
 ;;^DD(.463,.01,3)
 ;;=Type a Number between 1 and 999, 0 Decimal Digits
 ;;^DD(.463,.01,21,0)
 ;;=^^1^1^2960530^^
 ;;^DD(.463,.01,21,1,0)
 ;;=Sequence of fields being imported.
 ;;^DD(.463,.01,"DT")
 ;;=2960530
 ;;^DD(.463,1,0)
 ;;=FILE^RP1'^DIC(^0;2^Q
 ;;^DD(.463,1,21,0)
 ;;=^^2^2^2960530^
 ;;^DD(.463,1,21,1,0)
 ;;=The file or subfile number in which the imported data for a field will
 ;;^DD(.463,1,21,2,0)
 ;;=be filed.
 ;;^DD(.463,1,"DT")
 ;;=2960530
 ;;^DD(.463,2,0)
 ;;=FIELD^RF^^0;3^K:$L(X)>12!($L(X)<1) X
 ;;^DD(.463,2,3)
 ;;=Answer must be 1-12 characters in length.
 ;;^DD(.463,2,21,0)
 ;;=^^1^1^2960530^
 ;;^DD(.463,2,21,1,0)
 ;;=Field into which imported data will be filed.
 ;;^DD(.463,2,"DT")
 ;;=2960530
 ;;^DD(.463,3,0)
 ;;=LENGTH^NJ4,0^^0;4^K:+X'=X!(X>9999)!(X<0)!(X?.E1"."1N.N) X
 ;;^DD(.463,3,3)
 ;;=Type a Number between 0 and 9999, 0 Decimal Digits
 ;;^DD(.463,3,21,0)
 ;;=^^2^2^2960530^
 ;;^DD(.463,3,21,1,0)
 ;;=Length of data for an imported field.  Relevant only for fixed length
 ;;^DD(.463,3,21,2,0)
 ;;=imports.
 ;;^DD(.463,3,"DT")
 ;;=2960530
 ;;^DD(.463,10,0)
 ;;=PATH^F^^10;E1,245^K:$L(X)>245!($L(X)<1) X
 ;;^DD(.463,10,3)
 ;;=Answer must be 1-245 characters in length.
 ;;^DD(.463,10,21,0)
 ;;=^^3^3^2960530^
 ;;^DD(.463,10,21,1,0)
 ;;=The path from the Primary File to the field being imported.  Format
 ;;^DD(.463,10,21,2,0)
 ;;=is field#^file#[:field#^file#]... where field# is a multiple indicating
 ;;^DD(.463,10,21,3,0)
 ;;=subfile at next lower level.
 ;;^DD(.463,10,"DT")
 ;;=2960530
 ;;^DD(.463,20,0)
 ;;=CAPTION^F^^20;E1,245^K:$L(X)>245!($L(X)<1) X
 ;;^DD(.463,20,3)
 ;;=Answer must be 1-245 characters in length.
 ;;^DD(.463,20,21,0)
 ;;=^^2^2^2960530^
 ;;^DD(.463,20,21,1,0)
 ;;=The readable description of the field being imported, including any
 ;;^DD(.463,20,21,2,0)
 ;;=higher level files and subfiles.
 ;;^DD(.463,20,"DT")
 ;;=2960530

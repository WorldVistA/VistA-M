DINIT120 ;SFISC/MKO-SORT TEMPLATE FILE ;2014-12-30  1:14 PM
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**999,1049**
 ;
 ;**CCO/NI  TAG Q+24 CHANGED FOR DATE FORMAT
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
 G ^DINIT121
Q Q
 ;;^DIC(.401,0,"GL")
 ;;=^DIBT(
 ;;^DIC("B","SORT TEMPLATE",.401)
 ;;=
 ;;^DIC(.401,"%D",0)
 ;;=^^4^4^2940908^^
 ;;^DIC(.401,"%D",1,0)
 ;;=This file stores either SORT or SEARCH criteria. For SORT criteria, the
 ;;^DIC(.401,"%D",2,0)
 ;;=SORT DATA multiple contains the sort parameters. For SEARCH criteria, the
 ;;^DIC(.401,"%D",3,0)
 ;;=template also contains a list of record numbers selected as the result of
 ;;^DIC(.401,"%D",4,0)
 ;;=running the search.
 ;;^DD(.401,0)
 ;;=FIELD^^491620^21
 ;;^DD(.401,0,"DDA")
 ;;=N
 ;;^DD(.401,0,"DI")
 ;;=^
 ;;^DD(.401,0,"DT")
 ;;=2960910
 ;;^DD(.401,0,"ID","WRITE")
 ;;=N D,D1,D2 S D2=^(0) S:$X>30 D1(1,"F")="!" S D=$P(D2,U,2) S:D D1(2)="("_$$DATE^DIUTL(D)_")",D1(2,"F")="?30" S D=$P(D2,U,5) S:D D1(3)=" User #"_D,D1(3,"F")="?50" S D=$P(D2,U,4) S:D D1(4)=" File #"_D,D1(4,"F")="?59" D EN^DDIOL(.D1)
 ;;^DD(.401,0,"ID","WRITE1")
 ;;=N D1 S D1=$S($D(^DIBT(+Y,2))!$D(^("BY0")):"SORT",$D(^("DIS")):"SEARCH",$D(^(1)):"INQ",1:"") D EN^DDIOL(D1,"","?73")
 ;;^DD(.401,0,"ID","WRITED")
 ;;=I $G(DZ)?1"???".E N % S %=0 F  S %=$O(^DIBT(Y,"%D",%)) Q:%'>0  I $D(^(%,0))#2 D EN^DDIOL(^(0),"","!?5")
 ;;^DD(.401,0,"IX","B",.401,.01)
 ;;=
 ;;^DD(.401,0,"NM","SORT TEMPLATE")
 ;;=
 ;;^DD(.401,0,"PT",1.11,2)
 ;;=
 ;;^DD(.401,.01,0)
 ;;=NAME^F^^0;1^K:$L(X)<2!($L(X)>30) X
 ;;^DD(.401,.01,1,0)
 ;;=^.1^2^2
 ;;^DD(.401,.01,1,1,0)
 ;;=.401^B
 ;;^DD(.401,.01,1,1,1)
 ;;=S @(DIC_"""B"",X,DA)=""""")
 ;;^DD(.401,.01,1,1,2)
 ;;=K @(DIC_"""B"",X,DA)")
 ;;^DD(.401,.01,1,2,0)
 ;;=^^MUMPS
 ;;^DD(.401,.01,1,2,1)
 ;;=X "S %=$P("_DIC_"DA,0),U,4) S:$L(%) "_DIC_"""F""_+%,X,DA)=1"
 ;;^DD(.401,.01,1,2,2)
 ;;=X "S %=$P("_DIC_"DA,0),U,4) K:$L(%) "_DIC_"""F""_+%,X,DA)"
 ;;^DD(.401,.01,3)
 ;;=2-30 CHARACTERS
 ;;^DD(.401,2,0)
 ;;=DATE CREATED^D^^0;2^S %DT="ET" D ^%DT S X=Y K:Y<1 X
 ;;^DD(.401,3,0)
 ;;=READ ACCESS^F^^0;3^I DUZ(0)'="@" F I=1:1:$L(X) I DUZ(0)'[$E(X,I) K X Q
 ;;^DD(.401,4,0)
 ;;=FILE^P1'I^DIC(^0;4^Q
 ;;^DD(.401,4,1,0)
 ;;=^.1^1^1
 ;;^DD(.401,4,1,1,0)
 ;;=^^^MUMPS
 ;;^DD(.401,4,1,1,1)
 ;;=X "S %=$P("_DIC_"DA,0),U,1),"_DIC_"""F""_+X,%,DA)=1"
 ;;^DD(.401,4,1,1,2)
 ;;=Q
 ;;^DD(.401,5,0)
 ;;=USER #^N^^0;5^Q
 ;;^DD(.401,6,0)
 ;;=WRITE ACCESS^F^^0;6^I DUZ(0)'="@" F I=1:1:$L(X) I DUZ(0)'[$E(X,I) K X Q
 ;;^DD(.401,7,0)
 ;;=DATE LAST USED^D^^0;7^S %DT="EX" D ^%DT S X=Y K:Y<1 X
 ;;^DD(.401,8,0)
 ;;=TEMPLATE TYPE^S^1:ARCHIVING SEARCH;^0;8^Q
 ;;^DD(.401,8,3)
 ;;=Enter a 1 if this is an ARCHIVING SEARCH template (i.e., used to store lists of records to be archived) as opposed to a normal SEARCH or SORT template
 ;;^DD(.401,9,0)
 ;;=SEARCH COMPLETE DATE^D^^QR;1^S %DT="ESTXR" D ^%DT S X=Y K:Y<1 X
 ;;^DD(.401,9,3)
 ;;=Enter the date/time that this search was run to completion.
 ;;^DD(.401,9,21,0)
 ;;=^^4^4^2921124^
 ;;^DD(.401,9,21,1,0)
 ;;=  This field will be filled in automatically by the search option, but
 ;;^DD(.401,9,21,2,0)
 ;;=only if the search runs to completion.  It will contain the date/time
 ;;^DD(.401,9,21,3,0)
 ;;=that the search last ran.  If it was not allowed to run to completion,
 ;;^DD(.401,9,21,4,0)
 ;;=this field will be empty.
 ;;^DD(.401,9,23,0)
 ;;=^^1^1^2921124^^
 ;;^DD(.401,9,23,1,0)
 ;;=Filled in automatically by the FileMan search option.
 ;;^DD(.401,9,"DT")
 ;;=2921124
 ;;^DD(.401,10,0)
 ;;=DESCRIPTION^.4012^^%D;0
 ;;^DD(.401,11,0)
 ;;=TOTAL RECORDS SELECTED^NJ10,0^^QR;2^K:+X'=X!(X>9999999999)!(X<1)!(X?.E1"."1N.N) X
 ;;^DD(.401,11,3)
 ;;=Type a Number between 1 and 9999999999, 0 Decimal Digits
 ;;^DD(.401,11,21,0)
 ;;=^^5^5^2921125^^
 ;;^DD(.401,11,21,1,0)
 ;;=  This field is filled in automatically by the FileMan search option.
 ;;^DD(.401,11,21,2,0)
 ;;=If the search is allowed to run to completion, the total number of
 ;;^DD(.401,11,21,3,0)
 ;;=records that met the search criteria is stored in this field.  If the
 ;;^DD(.401,11,21,4,0)
 ;;=last search was not allowed to run to completion, this field will be
 ;;^DD(.401,11,21,5,0)
 ;;=null.
 ;;^DD(.401,11,23,0)
 ;;=^^1^1^2921124^
 ;;^DD(.401,11,23,1,0)
 ;;=Filled in automatically by the FileMan search option.
 ;;^DD(.401,11,"DT")
 ;;=2921125
 ;;^DD(.401,15,0)
 ;;=SEARCH SPECIFICATIONS^.4011^^O;0
 ;;^DD(.401,1620,0)
 ;;=SORT FIELDS^CmJ50^^ ; ^N DPP D DIBT^DIPT
 ;;^DD(.401,1621,0)
 ;;=SORT FIELD DATA^.4014^^2;0
 ;;^DD(.401,1622,0)
 ;;=BY(0)^FX^^BY0;1^K:$L(X)>30!($L(X)<3)!'(X?1.ANP1"(".ANP) X
 ;;^DD(.401,1622,3)
 ;;=Enter the static part of a global.  The leading up-arrow can be omitted.
 ;;^DD(.401,1622,21,0)
 ;;=^^4^4^2960911^^
 ;;^DD(.401,1622,21,1,0)
 ;;=Enter the static, unchanging part of an open global reference for either a
 ;;^DD(.401,1622,21,2,0)
 ;;=global or a cross-reference that contains the list of record numbers to
 ;;^DD(.401,1622,21,3,0)
 ;;=sort through on the first pass.  The leading up-arrow can be omitted.  
 ;;^DD(.401,1622,21,4,0)
 ;;=For example:  DIZ(662001,"A", or TMP("NMSP",$J,
 ;;^DD(.401,1622,23,0)
 ;;=^^1^1^2960911^^^^
 ;;^DD(.401,1622,23,1,0)
 ;;=Equivalent to the BY(0) input variable to programmer call EN1^DIP.
 ;;^DD(.401,1622,"DT")
 ;;=2960924
 ;;^DD(.401,1623,0)
 ;;=L(0)^NJ1,0^^BY0;2^K:+X'=X!(X>8)!(X<1)!(X?.E1"."1N.N) X
 ;;^DD(.401,1623,3)
 ;;=Type a Number between 1 and 8, 0 Decimal Digits
 ;;^DD(.401,1623,21,0)
 ;;=^^4^4^2960911^^^
 ;;^DD(.401,1623,21,1,0)
 ;;=Enter the total number of subscripts that must be sorted through on the
 ;;^DD(.401,1623,21,2,0)
 ;;=global referenced by BY(0), including 1 for the record number.  Ex., to
 ;;^DD(.401,1623,21,3,0)
 ;;=sort through the "B" x-ref, we sort through the cross-referenced value
 ;;^DD(.401,1623,21,4,0)
 ;;=itself, then the record number, so L(0)=2.
 ;;^DD(.401,1623,23,0)
 ;;=^^1^1^2960911^^^
 ;;^DD(.401,1623,23,1,0)
 ;;=Equivalent to the L(0) input variable to programmer call EN1^DIP.
 ;;^DD(.401,1623,"DT")
 ;;=2960828
 ;;^DD(.401,1624,0)
 ;;=SORT RANGE DATA FOR BY(0)^.4011624^^BY0D;0
 ;;^DD(.401,1815,0)
 ;;=ROUTINE INVOKED^F^^ROU;E1,13^K:$L(X)>5!($L(X)<5) X
 ;;^DD(.401,1815,3)
 ;;=Answer must be 5 characters in length.Must contain '^DISZ'.
 ;;^DD(.401,1815,21,0)
 ;;=^^7^7^2930331^^^
 ;;^DD(.401,1815,21,1,0)
 ;;=  If this sort template is compiled, the first characters of the name
 ;;^DD(.401,1815,21,2,0)
 ;;=of that compiled routine will appear on this node.  Compiled sort
 ;;^DD(.401,1815,21,3,0)
 ;;=routines are re-created each time the sort/print runs.  These characters
 ;;^DD(.401,1815,21,4,0)
 ;;=are concatenated with the next available number from the COMPILED ROUTINE

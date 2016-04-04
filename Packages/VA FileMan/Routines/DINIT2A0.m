DINIT2A0 ;SFISC/MKO-KEY AND INDEX FILES ;10:50 AM  30 Mar 1999
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
 G ^DINIT2A1
Q Q
 ;;^DIC(.11,0,"GL")
 ;;=^DD("IX",
 ;;^DIC("B","INDEX",.11)
 ;;=
 ;;^DIC(.11,"%D",0)
 ;;=^^5^5^2980911^
 ;;^DIC(.11,"%D",1,0)
 ;;=This file stores information about new-style cross-references defined on a
 ;;^DIC(.11,"%D",2,0)
 ;;=file. Whereas traditional cross-references are stored under the 1 nodes of
 ;;^DIC(.11,"%D",3,0)
 ;;=the ^DD for a particular field, new-style cross-references are stored in
 ;;^DIC(.11,"%D",4,0)
 ;;=this file and can consist of one field (simple cross-references), as well
 ;;^DIC(.11,"%D",5,0)
 ;;=as more than one field (compound cross-references).
 ;;^DD(.11,0)
 ;;=FIELD^^11.1^20
 ;;^DD(.11,0,"DDA")
 ;;=N
 ;;^DD(.11,0,"DT")
 ;;=2980908
 ;;^DD(.11,0,"ID","DI SHORT DESCRIPTION 50")
 ;;=D EN^DDIOL($E($P(^(0),U,3),1,50),"","?0")
 ;;^DD(.11,0,"IX","AC",.11,.51)
 ;;=
 ;;^DD(.11,0,"IX","B",.11,.01)
 ;;=
 ;;^DD(.11,0,"NM","INDEX")
 ;;=
 ;;^DD(.11,0,"PT",.31,3)
 ;;=
 ;;^DD(.11,.01,0)
 ;;=FILE^RNJ20,7^^0;1^K:+X'=X!(X>999999999999)!(X<0)!(X?.E1"."8N.N) X
 ;;^DD(.11,.01,1,0)
 ;;=^.1^^-1
 ;;^DD(.11,.01,1,1,0)
 ;;=.11^B
 ;;^DD(.11,.01,1,1,1)
 ;;=S ^DD("IX","B",$E(X,1,30),DA)=""
 ;;^DD(.11,.01,1,1,2)
 ;;=K ^DD("IX","B",$E(X,1,30),DA)
 ;;^DD(.11,.01,1,1,3)
 ;;=Lets developers pick indexes by file number
 ;;^DD(.11,.01,1,1,"%D",0)
 ;;=^^2^2^2980911^
 ;;^DD(.11,.01,1,1,"%D",1,0)
 ;;=The B index, on the .01 (File) of the Index file, lets developers pick
 ;;^DD(.11,.01,1,1,"%D",2,0)
 ;;=indexes by the numbers of the files they cross-reference.
 ;;^DD(.11,.01,3)
 ;;=Answer must be between 0 and 999999999999, with up to 7 decimal digits. Answer '??' for more help.
 ;;^DD(.11,.01,21,0)
 ;;=^^3^3^2980910^^
 ;;^DD(.11,.01,21,1,0)
 ;;=Answer should be the number of the file cross-referenced by this index.
 ;;^DD(.11,.01,21,2,0)
 ;;=For whole file cross-references on subfiles, answer with the number of
 ;;^DD(.11,.01,21,3,0)
 ;;=the file where the index physically resides, not the subfile number.
 ;;^DD(.11,.01,"DT")
 ;;=2980611
 ;;^DD(.11,.02,0)
 ;;=NAME^RF^^0;2^K:$L(X)>30!($L(X)<1)!'(X?1A.AN) X
 ;;^DD(.11,.02,1,0)
 ;;=^.1^^0
 ;;^DD(.11,.02,3)
 ;;=Answer must be 1-30 characters in length. Answer '??' for more help.
 ;;^DD(.11,.02,21,0)
 ;;=^^4^4^2980911^
 ;;^DD(.11,.02,21,1,0)
 ;;=Answer must be the name of the index. For example, the name of the default
 ;;^DD(.11,.02,21,2,0)
 ;;=lookup index on a file's .01 field is B, the name of the uniqueness index
 ;;^DD(.11,.02,21,3,0)
 ;;=of a compound key is BB, and the name of an index not used for lookup must
 ;;^DD(.11,.02,21,4,0)
 ;;=start with A.
 ;;^DD(.11,.02,"DT")
 ;;=2990303
 ;;^DD(.11,.1,0)
 ;;=DESCRIPTION^.1101^^.1;0
 ;;^DD(.11,.11,0)
 ;;=SHORT DESCRIPTION^RF^^0;3^K:$L(X)>79!($L(X)<1) X
 ;;^DD(.11,.11,3)
 ;;=Answer must be 1-79 characters in length. Answer '??' for more help.
 ;;^DD(.11,.11,21,0)
 ;;=^^2^2^2980910^
 ;;^DD(.11,.11,21,1,0)
 ;;=Answer should be text briefly explaining the function of this
 ;;^DD(.11,.11,21,2,0)
 ;;=cross-reference.
 ;;^DD(.11,.11,"DT")
 ;;=2960216
 ;;^DD(.11,.2,0)
 ;;=TYPE^RS^R:REGULAR;MU:MUMPS;^0;4^Q
 ;;^DD(.11,.2,3)
 ;;=Answer '??' for more help.
 ;;^DD(.11,.2,21,0)
 ;;=^^5^5^2980911^
 ;;^DD(.11,.2,21,1,0)
 ;;=REGULAR - One or more field values are stored in an index on the file. The
 ;;^DD(.11,.2,21,2,0)
 ;;=index can be used for sorting, or optionally, looking up entries.
 ;;^DD(.11,.2,21,3,0)
 ;;= 
 ;;^DD(.11,.2,21,4,0)
 ;;=MUMPS - Customizable M code executes whenever a field that makes up the
 ;;^DD(.11,.2,21,5,0)
 ;;=cross-references changes.
 ;;^DD(.11,.2,"DT")
 ;;=2970718
 ;;^DD(.11,.4,0)
 ;;=EXECUTION^RS^F:FIELD;R:RECORD;^0;6^Q
 ;;^DD(.11,.4,1,0)
 ;;=^.1^^0
 ;;^DD(.11,.4,3)
 ;;=Answer '??' for more help.
 ;;^DD(.11,.4,21,0)
 ;;=^^7^7^2980911^^
 ;;^DD(.11,.4,21,1,0)
 ;;=Answer with the code that indicates whether the cross reference logic
 ;;^DD(.11,.4,21,2,0)
 ;;=should be executed after a field in the index changes, or only after all
 ;;^DD(.11,.4,21,3,0)
 ;;=fields in a record are updated. The logic for most simple (single-field)
 ;;^DD(.11,.4,21,4,0)
 ;;=indexes should be executed immediately after the field changes, and so
 ;;^DD(.11,.4,21,5,0)
 ;;=should get the code 'F'. The logic for most compound indexes should be
 ;;^DD(.11,.4,21,6,0)
 ;;=executed only once after a transaction on the entire record is complete,
 ;;^DD(.11,.4,21,7,0)
 ;;=and so should get the code 'R'. Exceptions to this rule are rare.
 ;;^DD(.11,.4,"DT")
 ;;=2980611
 ;;^DD(.11,.41,0)
 ;;=ACTIVITY^FX^^0;7^K:$L(X)>2!($L(X)<1)!($TR(X,"IR")]"") X
 ;;^DD(.11,.41,3)
 ;;=Answer must be 2 characters in length. Answer '??' for more help.
 ;;^DD(.11,.41,21,0)
 ;;=^^15^15^2990225^
 ;;^DD(.11,.41,21,1,0)
 ;;=Answer with the flags that control whether FileMan fires this
 ;;^DD(.11,.41,21,2,0)
 ;;=cross-reference during an installation and a re-cross-referencing
 ;;^DD(.11,.41,21,3,0)
 ;;=operation. The possible flags are:
 ;;^DD(.11,.41,21,4,0)
 ;;= 
 ;;^DD(.11,.41,21,5,0)
 ;;=  I = Installing an entry at a site
 ;;^DD(.11,.41,21,6,0)
 ;;=  R = Re-cross-referencing this index
 ;;^DD(.11,.41,21,7,0)
 ;;= 
 ;;^DD(.11,.41,21,8,0)
 ;;=FileMan automatically fires cross-references during an edit, regardless of
 ;;^DD(.11,.41,21,9,0)
 ;;=Activity, though you can control whether a cross-reference is fired by
 ;;^DD(.11,.41,21,10,0)
 ;;=entering Set and Kill Conditions.
 ;;^DD(.11,.41,21,11,0)
 ;;= 
 ;;^DD(.11,.41,21,12,0)
 ;;=Also, if you explicity select a cross-reference in an EN^DIK, EN1^DIK, or
 ;;^DD(.11,.41,21,13,0)
 ;;=ENALL^DIK call, or in the UTILITY FUNCTIONS/RE-INDEX FILE option on the VA
 ;;^DD(.11,.41,21,14,0)
 ;;=FileMan menu, that cross-reference will be fired whether or not its
 ;;^DD(.11,.41,21,15,0)
 ;;=Activity contains an "R".
 ;;^DD(.11,.41,"DT")
 ;;=2980611
 ;;^DD(.11,.42,0)
 ;;=USE^S^LS:LOOKUP & SORTING;S:SORTING ONLY;A:ACTION;^0;14^Q
 ;;^DD(.11,.42,3)
 ;;=Controls how the index will be used by Classic FileMan Lookup (^DIC), Finder (FIND^DIC and $$FIND1^DIC) and Sort/Print (EN1^DIP). Answer '??' for more help.
 ;;^DD(.11,.42,21,0)
 ;;=^^15^15^2980911^^
 ;;^DD(.11,.42,21,1,0)
 ;;=LOOKUP & SORTING - The index name starts with "B" or a letter that
 ;;^DD(.11,.42,21,2,0)
 ;;=alphabetically follows "B".  Calls to Classic FileMan lookup (^DIC) or the
 ;;^DD(.11,.42,21,3,0)
 ;;=Finder (FIND^DIC or $$FIND1^DIC) where the index is not specified will
 ;;^DD(.11,.42,21,4,0)
 ;;=include this index in the search. The index will be available for use by

DINIT005 ; SFISC/TKW-DIALOG & LANGUAGE FILE INITS ; 3/30/99  10:41:48
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
Q Q
 ;;^UTILITY(U,$J,.84,205,1,3,0)
 ;;=the IEN string do not match the file/subfile level according to the "UP"
 ;;^UTILITY(U,$J,.84,205,1,4,0)
 ;;=nodes).
 ;;^UTILITY(U,$J,.84,205,2,0)
 ;;=^^1^1^2960827^^^
 ;;^UTILITY(U,$J,.84,205,2,1,0)
 ;;=File# |1| and IEN string |IENS| represent different subfile levels.
 ;;^UTILITY(U,$J,.84,205,3,0)
 ;;=^.845^2^2
 ;;^UTILITY(U,$J,.84,205,3,1,0)
 ;;=1^File or subfile number
 ;;^UTILITY(U,$J,.84,205,3,2,0)
 ;;=IENS^IEN string
 ;;^UTILITY(U,$J,.84,205,5,0)
 ;;=^.841^2^2
 ;;^UTILITY(U,$J,.84,205,5,1,0)
 ;;=DIT3^IENCHK
 ;;^UTILITY(U,$J,.84,205,5,2,0)
 ;;=DICA3^ERR
 ;;^UTILITY(U,$J,.84,206,0)
 ;;=206^1^y^5
 ;;^UTILITY(U,$J,.84,206,1,0)
 ;;=^^3^3^2960124^
 ;;^UTILITY(U,$J,.84,206,1,1,0)
 ;;=FileMan is trying to pack fields onto a single node for a record, and the
 ;;^UTILITY(U,$J,.84,206,1,2,0)
 ;;=data will not fit. The application has asked for too many fields back for
 ;;^UTILITY(U,$J,.84,206,1,3,0)
 ;;=this record.
 ;;^UTILITY(U,$J,.84,206,2,0)
 ;;=^^1^1^2960124^
 ;;^UTILITY(U,$J,.84,206,2,1,0)
 ;;=The data requested for record |1| is too long to pack together.
 ;;^UTILITY(U,$J,.84,206,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,206,3,1,0)
 ;;=1^Record Number.
 ;;^UTILITY(U,$J,.84,207,0)
 ;;=207^1^y^5
 ;;^UTILITY(U,$J,.84,207,1,0)
 ;;=^^5^5^2960318^
 ;;^UTILITY(U,$J,.84,207,1,1,0)
 ;;=The library function $$HTML^DILF can encode or decode a string to and from
 ;;^UTILITY(U,$J,.84,207,1,2,0)
 ;;=HTML, used within FileMan to pack a value containing embedded ^s into a
 ;;^UTILITY(U,$J,.84,207,1,3,0)
 ;;=^-delimited string. Encoding increases the length of the string. If
 ;;^UTILITY(U,$J,.84,207,1,4,0)
 ;;=encoding would cause the length to exceed the portable string length
 ;;^UTILITY(U,$J,.84,207,1,5,0)
 ;;=limit, $$HTML^DILF instead returns this error.
 ;;^UTILITY(U,$J,.84,207,2,0)
 ;;=^^1^1^2960318^
 ;;^UTILITY(U,$J,.84,207,2,1,0)
 ;;=The value |1| is too long to encode into HTML.
 ;;^UTILITY(U,$J,.84,207,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,207,3,1,0)
 ;;=1^Value.
 ;;^UTILITY(U,$J,.84,208,0)
 ;;=208^1^^5^Illegal number error
 ;;^UTILITY(U,$J,.84,208,2,0)
 ;;=^^1^1^2970829^
 ;;^UTILITY(U,$J,.84,208,2,1,0)
 ;;=Input value is an illegal number.
 ;;^UTILITY(U,$J,.84,209,0)
 ;;=209^1^^5
 ;;^UTILITY(U,$J,.84,209,2,0)
 ;;=^^1^1^2980709^
 ;;^UTILITY(U,$J,.84,209,2,1,0)
 ;;=Input value is too long.
 ;;^UTILITY(U,$J,.84,209,5,0)
 ;;=^.841^2^2
 ;;^UTILITY(U,$J,.84,209,5,1,0)
 ;;=DIC0^CHKVAL2
 ;;^UTILITY(U,$J,.84,209,5,2,0)
 ;;=DIC11^PR1
 ;;^UTILITY(U,$J,.84,299,0)
 ;;=299^1^y^5
 ;;^UTILITY(U,$J,.84,299,1,0)
 ;;=^^2^2^2970423^^^^
 ;;^UTILITY(U,$J,.84,299,1,1,0)
 ;;=A lookup that was restricted to finding a single entry found more than
 ;;^UTILITY(U,$J,.84,299,1,2,0)
 ;;=one.
 ;;^UTILITY(U,$J,.84,299,2,0)
 ;;=^^1^1^2970423^
 ;;^UTILITY(U,$J,.84,299,2,1,0)
 ;;=More than one entry matches the value(s) '|1|'.
 ;;^UTILITY(U,$J,.84,299,3,0)
 ;;=^.845^3^3
 ;;^UTILITY(U,$J,.84,299,3,1,0)
 ;;=1^Lookup Value.
 ;;^UTILITY(U,$J,.84,299,3,2,0)
 ;;=FILE^File #.
 ;;^UTILITY(U,$J,.84,299,3,3,0)
 ;;=IENS^IEN String.
 ;;^UTILITY(U,$J,.84,301,0)
 ;;=301^1^y^5
 ;;^UTILITY(U,$J,.84,301,1,0)
 ;;=^^1^1^2931110^^
 ;;^UTILITY(U,$J,.84,301,1,1,0)
 ;;=Flags passed in a variable (like DIC(0)) or in a parameter are incorrect.
 ;;^UTILITY(U,$J,.84,301,2,0)
 ;;=^^1^1^2931110^^
 ;;^UTILITY(U,$J,.84,301,2,1,0)
 ;;=The passed flag(s) '|1|' are unknown or inconsistent.
 ;;^UTILITY(U,$J,.84,301,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,301,3,1,0)
 ;;=1^Letter(s) from flag.
 ;;^UTILITY(U,$J,.84,302,0)
 ;;=302^1^y^5
 ;;^UTILITY(U,$J,.84,302,1,0)
 ;;=^^2^2^2940215^
 ;;^UTILITY(U,$J,.84,302,1,1,0)
 ;;=The calling application has asked us to add a new record, and has supplied
 ;;^UTILITY(U,$J,.84,302,1,2,0)
 ;;=a record number, but a record already exists at that number.
 ;;^UTILITY(U,$J,.84,302,2,0)
 ;;=^^1^1^2941018^
 ;;^UTILITY(U,$J,.84,302,2,1,0)
 ;;=Entry '|IENS|' already exists.
 ;;^UTILITY(U,$J,.84,302,3,0)
 ;;=^.845^2^2
 ;;^UTILITY(U,$J,.84,302,3,1,0)
 ;;=FILE^File #.
 ;;^UTILITY(U,$J,.84,302,3,2,0)
 ;;=IENS^IEN String.
 ;;^UTILITY(U,$J,.84,304,0)
 ;;=304^1^y^5
 ;;^UTILITY(U,$J,.84,304,1,0)
 ;;=^^2^2^2940628^^^^
 ;;^UTILITY(U,$J,.84,304,1,1,0)
 ;;=The problem with this IEN string is that it lacks the final ','. This is a
 ;;^UTILITY(U,$J,.84,304,1,2,0)
 ;;=common mistake for beginners.
 ;;^UTILITY(U,$J,.84,304,2,0)
 ;;=^^1^1^2941018^
 ;;^UTILITY(U,$J,.84,304,2,1,0)
 ;;=The IENS '|IENS|' lacks a final comma.
 ;;^UTILITY(U,$J,.84,304,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,304,3,1,0)
 ;;=IENS^IENS.
 ;;^UTILITY(U,$J,.84,305,0)
 ;;=305^1^y^5
 ;;^UTILITY(U,$J,.84,305,1,0)
 ;;=^^1^1^2931109^
 ;;^UTILITY(U,$J,.84,305,1,1,0)
 ;;=A root is used to identify an input array.  But the array is empty.
 ;;^UTILITY(U,$J,.84,305,2,0)
 ;;=^^1^1^2931109^
 ;;^UTILITY(U,$J,.84,305,2,1,0)
 ;;=The array with a root of '|1|' has no data associated with it.
 ;;^UTILITY(U,$J,.84,305,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,305,3,1,0)
 ;;=1^Passed root.
 ;;^UTILITY(U,$J,.84,305,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,305,5,1,0)
 ;;=DIE^FILE
 ;;^UTILITY(U,$J,.84,306,0)
 ;;=306^1^y^5
 ;;^UTILITY(U,$J,.84,306,1,0)
 ;;=^^2^2^2940628^
 ;;^UTILITY(U,$J,.84,306,1,1,0)
 ;;=When an IENS is used to explicitly identify a subfile, not a subfile
 ;;^UTILITY(U,$J,.84,306,1,2,0)
 ;;=entry, then the first comma-piece should be empty. This one wasn't.
 ;;^UTILITY(U,$J,.84,306,2,0)
 ;;=^^1^1^2941018^
 ;;^UTILITY(U,$J,.84,306,2,1,0)
 ;;=The first comma-piece of IENS '|IENS|' should be empty.
 ;;^UTILITY(U,$J,.84,306,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,306,3,1,0)
 ;;=IENS^IENS.
 ;;^UTILITY(U,$J,.84,307,0)
 ;;=307^1^y^5
 ;;^UTILITY(U,$J,.84,307,1,0)
 ;;=^^2^2^2940629^
 ;;^UTILITY(U,$J,.84,307,1,1,0)
 ;;=One of the IENs in the IENS has been left out, leaving an empty
 ;;^UTILITY(U,$J,.84,307,1,2,0)
 ;;=comma-piece. 
 ;;^UTILITY(U,$J,.84,307,2,0)
 ;;=^^1^1^2941018^
 ;;^UTILITY(U,$J,.84,307,2,1,0)
 ;;=The IENS '|IENS|' has an empty comma-piece.
 ;;^UTILITY(U,$J,.84,307,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,307,3,1,0)
 ;;=IENS^IENS.
 ;;^UTILITY(U,$J,.84,308,0)
 ;;=308^1^y^5
 ;;^UTILITY(U,$J,.84,308,1,0)
 ;;=^^3^3^2940629^
 ;;^UTILITY(U,$J,.84,308,1,1,0)
 ;;=The syntax of this IENS is incorrect. For example, a record number may be
 ;;^UTILITY(U,$J,.84,308,1,2,0)
 ;;=illegal; or a subfile may be specified as already existing, but have a
 ;;^UTILITY(U,$J,.84,308,1,3,0)
 ;;=parent that is just now being added.

DINIT009 ; SFISC/TKW-DIALOG & LANGUAGE FILE INITS ; 3/30/99  10:41:48
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
Q Q
 ;;^UTILITY(U,$J,.84,630,0)
 ;;=630^1^y^5
 ;;^UTILITY(U,$J,.84,630,1,0)
 ;;=^^2^2^2941128^
 ;;^UTILITY(U,$J,.84,630,1,1,0)
 ;;=The database is corrupted. The value for a specific field in one entry
 ;;^UTILITY(U,$J,.84,630,1,2,0)
 ;;=should be a certain data type, but it is not.
 ;;^UTILITY(U,$J,.84,630,2,0)
 ;;=^^2^2^2941128^
 ;;^UTILITY(U,$J,.84,630,2,1,0)
 ;;=In Entry #|1| of File #|FILE|, the value '|2|' for Field #|FIELD| is not a
 ;;^UTILITY(U,$J,.84,630,2,2,0)
 ;;=valid |3|.
 ;;^UTILITY(U,$J,.84,630,3,0)
 ;;=^.845^5^5
 ;;^UTILITY(U,$J,.84,630,3,1,0)
 ;;=1^Entry #.
 ;;^UTILITY(U,$J,.84,630,3,2,0)
 ;;=2^Field Value.
 ;;^UTILITY(U,$J,.84,630,3,3,0)
 ;;=3^Data Type.
 ;;^UTILITY(U,$J,.84,630,3,4,0)
 ;;=FIELD^Field #.
 ;;^UTILITY(U,$J,.84,630,3,5,0)
 ;;=FILE^File #.
 ;;^UTILITY(U,$J,.84,648,0)
 ;;=648^1^y^5
 ;;^UTILITY(U,$J,.84,648,1,0)
 ;;=^^3^3^2940214^
 ;;^UTILITY(U,$J,.84,648,1,1,0)
 ;;=The database is corrupted. In a specific variable pointer field of a
 ;;^UTILITY(U,$J,.84,648,1,2,0)
 ;;=certain entry, the field's value points to a file that either does not
 ;;^UTILITY(U,$J,.84,648,1,3,0)
 ;;=exist or that lacks a Header Node.
 ;;^UTILITY(U,$J,.84,648,2,0)
 ;;=^^2^2^2940214^
 ;;^UTILITY(U,$J,.84,648,2,1,0)
 ;;=In Entry #|1| of File #|FILE|, the value '|2|' for Field #|FIELD| points
 ;;^UTILITY(U,$J,.84,648,2,2,0)
 ;;=to a file that does not exist or lacks a Header Node.
 ;;^UTILITY(U,$J,.84,648,3,0)
 ;;=^.845^4^4
 ;;^UTILITY(U,$J,.84,648,3,1,0)
 ;;=1^Entry #.
 ;;^UTILITY(U,$J,.84,648,3,2,0)
 ;;=2^Field Value.
 ;;^UTILITY(U,$J,.84,648,3,3,0)
 ;;=FILE^File #.
 ;;^UTILITY(U,$J,.84,648,3,4,0)
 ;;=FIELD^Field #.
 ;;^UTILITY(U,$J,.84,701,0)
 ;;=701^1^y^5
 ;;^UTILITY(U,$J,.84,701,1,0)
 ;;=^^3^3^2931109^
 ;;^UTILITY(U,$J,.84,701,1,1,0)
 ;;=The value is invalid.  Possible causes include:  value did not pass input 
 ;;^UTILITY(U,$J,.84,701,1,2,0)
 ;;=transform, value for a pointer or variable pointer field cannot be found in 
 ;;^UTILITY(U,$J,.84,701,1,3,0)
 ;;=the pointed-to file, a screen was not passed.
 ;;^UTILITY(U,$J,.84,701,2,0)
 ;;=^^1^1^2931110^^
 ;;^UTILITY(U,$J,.84,701,2,1,0)
 ;;=The value '|3|' for field |1| in file |2| is not valid.
 ;;^UTILITY(U,$J,.84,701,3,0)
 ;;=^.845^6^6
 ;;^UTILITY(U,$J,.84,701,3,1,0)
 ;;=1^Field name.
 ;;^UTILITY(U,$J,.84,701,3,2,0)
 ;;=2^File name.
 ;;^UTILITY(U,$J,.84,701,3,3,0)
 ;;=3^Value that was found to be invalid.
 ;;^UTILITY(U,$J,.84,701,3,4,0)
 ;;=FIELD^Field number. (external only)
 ;;^UTILITY(U,$J,.84,701,3,5,0)
 ;;=FILE^File number.  (external only)
 ;;^UTILITY(U,$J,.84,701,3,6,0)
 ;;=IENS^IEN string identifying entry with invalid value. (external only, sometimes returned)
 ;;^UTILITY(U,$J,.84,701,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,701,5,1,0)
 ;;=DIE^FILE
 ;;^UTILITY(U,$J,.84,703,0)
 ;;=703^1^y^5
 ;;^UTILITY(U,$J,.84,703,1,0)
 ;;=^^1^1^2940317^
 ;;^UTILITY(U,$J,.84,703,1,1,0)
 ;;=The value passed cannot be found in the indicated file using $$FIND1^DIC.
 ;;^UTILITY(U,$J,.84,703,2,0)
 ;;=^^1^1^2940317^
 ;;^UTILITY(U,$J,.84,703,2,1,0)
 ;;=The value '|1|' cannot be found in file #|FILE|.
 ;;^UTILITY(U,$J,.84,703,3,0)
 ;;=^.845^3^3
 ;;^UTILITY(U,$J,.84,703,3,1,0)
 ;;=FILE^File #.
 ;;^UTILITY(U,$J,.84,703,3,2,0)
 ;;=IENS^IEN String.
 ;;^UTILITY(U,$J,.84,703,3,3,0)
 ;;=1^Lookup Value.
 ;;^UTILITY(U,$J,.84,710,0)
 ;;=710^1^y^5
 ;;^UTILITY(U,$J,.84,710,1,0)
 ;;=^^2^2^2931123^^^^
 ;;^UTILITY(U,$J,.84,710,1,1,0)
 ;;=The data dictionary specifies that the field is uneditable.  Data already
 ;;^UTILITY(U,$J,.84,710,1,2,0)
 ;;=exists in the field.  It cannot be changed.
 ;;^UTILITY(U,$J,.84,710,2,0)
 ;;=^^1^1^2931110^^^
 ;;^UTILITY(U,$J,.84,710,2,1,0)
 ;;=Data in Field #|FIELD| in File #|FILE| cannot be edited.
 ;;^UTILITY(U,$J,.84,710,3,0)
 ;;=^.845^2^2
 ;;^UTILITY(U,$J,.84,710,3,1,0)
 ;;=FIELD^Field number.
 ;;^UTILITY(U,$J,.84,710,3,2,0)
 ;;=FILE^File number.
 ;;^UTILITY(U,$J,.84,712,0)
 ;;=712^1^y^5
 ;;^UTILITY(U,$J,.84,712,1,0)
 ;;=^^3^3^2931109^
 ;;^UTILITY(U,$J,.84,712,1,1,0)
 ;;=The value of a field cannot be deleted either because it is a required 
 ;;^UTILITY(U,$J,.84,712,1,2,0)
 ;;=field, because it is the .01 of a file, or because the test in the "DEL"
 ;;^UTILITY(U,$J,.84,712,1,3,0)
 ;;=node was not passed.
 ;;^UTILITY(U,$J,.84,712,2,0)
 ;;=^^1^1^2931109^
 ;;^UTILITY(U,$J,.84,712,2,1,0)
 ;;=The value of field |1| in file |2| cannot be deleted.
 ;;^UTILITY(U,$J,.84,712,3,0)
 ;;=^.845^4^4
 ;;^UTILITY(U,$J,.84,712,3,1,0)
 ;;=1^Field name.
 ;;^UTILITY(U,$J,.84,712,3,2,0)
 ;;=2^File name.
 ;;^UTILITY(U,$J,.84,712,3,3,0)
 ;;=FIELD^Field number.  (external only)
 ;;^UTILITY(U,$J,.84,712,3,4,0)
 ;;=FILE^File number.  (external only)
 ;;^UTILITY(U,$J,.84,712,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,712,5,1,0)
 ;;=DIE^FILE
 ;;^UTILITY(U,$J,.84,714,0)
 ;;=714^1^y^5
 ;;^UTILITY(U,$J,.84,714,1,0)
 ;;=^^2^2^2931109^^
 ;;^UTILITY(U,$J,.84,714,1,1,0)
 ;;=The field uses $Piece storage and the data contains an '^'.  The data
 ;;^UTILITY(U,$J,.84,714,1,2,0)
 ;;=cannot be filed.
 ;;^UTILITY(U,$J,.84,714,2,0)
 ;;=^^1^1^2931109^^
 ;;^UTILITY(U,$J,.84,714,2,1,0)
 ;;=Data for Field |1| in File |2| contains an '^'.
 ;;^UTILITY(U,$J,.84,714,3,0)
 ;;=^.845^4^4
 ;;^UTILITY(U,$J,.84,714,3,1,0)
 ;;=1^Field name.
 ;;^UTILITY(U,$J,.84,714,3,2,0)
 ;;=2^File name.
 ;;^UTILITY(U,$J,.84,714,3,3,0)
 ;;=FILE^File number.  (external only)
 ;;^UTILITY(U,$J,.84,714,3,4,0)
 ;;=FIELD^Field number. (external only)
 ;;^UTILITY(U,$J,.84,714,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,714,5,1,0)
 ;;=DIE^FILE
 ;;^UTILITY(U,$J,.84,716,0)
 ;;=716^1^y^5
 ;;^UTILITY(U,$J,.84,716,1,0)
 ;;=^^2^2^2931109^
 ;;^UTILITY(U,$J,.84,716,1,1,0)
 ;;=Data being filed is too long for the field.  Specifically, this occurs 
 ;;^UTILITY(U,$J,.84,716,1,2,0)
 ;;=when data of the wrong length is being filed in a $Extract (Em,n) field.
 ;;^UTILITY(U,$J,.84,716,2,0)
 ;;=^^1^1^2931109^
 ;;^UTILITY(U,$J,.84,716,2,1,0)
 ;;=Data for field |1| in file |2| is too long.
 ;;^UTILITY(U,$J,.84,716,3,0)
 ;;=^.845^4^4
 ;;^UTILITY(U,$J,.84,716,3,1,0)
 ;;=1^Field name.
 ;;^UTILITY(U,$J,.84,716,3,2,0)
 ;;=2^File name.
 ;;^UTILITY(U,$J,.84,716,3,3,0)
 ;;=FIELD^Field number. (external only)
 ;;^UTILITY(U,$J,.84,716,3,4,0)
 ;;=FILE^File number.  (external only)
 ;;^UTILITY(U,$J,.84,716,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,716,5,1,0)
 ;;=DIE^FILE
 ;;^UTILITY(U,$J,.84,720,0)
 ;;=720^1^^5
 ;;^UTILITY(U,$J,.84,720,1,0)
 ;;=^^2^2^2931110^^
 ;;^UTILITY(U,$J,.84,720,1,1,0)
 ;;=The lookup for a pointer fails.  This is an error only when

DINIT00A ; SFISC/TKW-DIALOG & LANGUAGE FILE INITS ; 3/30/99  10:41:48
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
Q Q
 ;;^UTILITY(U,$J,.84,720,1,2,0)
 ;;=LAYGO is not allowed.
 ;;^UTILITY(U,$J,.84,720,2,0)
 ;;=^^1^1^2931109^
 ;;^UTILITY(U,$J,.84,720,2,1,0)
 ;;=The value cannot be found in the pointed-to file.
 ;;^UTILITY(U,$J,.84,720,3,0)
 ;;=^.845^2^2
 ;;^UTILITY(U,$J,.84,720,3,1,0)
 ;;=FILE^File number -- the number of the file in which the pointer field exists.
 ;;^UTILITY(U,$J,.84,720,3,2,0)
 ;;=FIELD^Field number of the pointer field.
 ;;^UTILITY(U,$J,.84,726,0)
 ;;=726^1^y^5
 ;;^UTILITY(U,$J,.84,726,1,0)
 ;;=^^2^2^2931110^
 ;;^UTILITY(U,$J,.84,726,1,1,0)
 ;;=There is an attempt to take an action with word processing data, but
 ;;^UTILITY(U,$J,.84,726,1,2,0)
 ;;=the specified field is not a word processing field.
 ;;^UTILITY(U,$J,.84,726,2,0)
 ;;=^^1^1^2931110^
 ;;^UTILITY(U,$J,.84,726,2,1,0)
 ;;=Field #|FIELD| in File #|FILE| is not a word processing field.
 ;;^UTILITY(U,$J,.84,726,3,0)
 ;;=^.845^2^2
 ;;^UTILITY(U,$J,.84,726,3,1,0)
 ;;=FIELD^Field number.
 ;;^UTILITY(U,$J,.84,726,3,2,0)
 ;;=FILE^File number.
 ;;^UTILITY(U,$J,.84,730,0)
 ;;=730^1^y^5
 ;;^UTILITY(U,$J,.84,730,1,0)
 ;;=^^2^2^2941128^
 ;;^UTILITY(U,$J,.84,730,1,1,0)
 ;;=Based on how the data type is defined by a specific field in a specific
 ;;^UTILITY(U,$J,.84,730,1,2,0)
 ;;=file, the passed value is not valid.
 ;;^UTILITY(U,$J,.84,730,2,0)
 ;;=^^2^2^2941128^
 ;;^UTILITY(U,$J,.84,730,2,1,0)
 ;;=The value '|1|' is not a valid |2| according to the definition in Field
 ;;^UTILITY(U,$J,.84,730,2,2,0)
 ;;=#|FIELD| of File #|FILE|.
 ;;^UTILITY(U,$J,.84,730,3,0)
 ;;=^.845^4^4
 ;;^UTILITY(U,$J,.84,730,3,1,0)
 ;;=1^Passed Value.
 ;;^UTILITY(U,$J,.84,730,3,2,0)
 ;;=2^Data Type.
 ;;^UTILITY(U,$J,.84,730,3,3,0)
 ;;=FIELD^Field #.
 ;;^UTILITY(U,$J,.84,730,3,4,0)
 ;;=FILE^File #.
 ;;^UTILITY(U,$J,.84,740,0)
 ;;=740^1^y^5
 ;;^UTILITY(U,$J,.84,740,1,0)
 ;;=^^5^5^2980407^^^^
 ;;^UTILITY(U,$J,.84,740,1,1,0)
 ;;=When one or more fields are declared as a key for a file, there cannot be 
 ;;^UTILITY(U,$J,.84,740,1,2,0)
 ;;=duplicate values in those field(s) for entries in the file.  The values
 ;;^UTILITY(U,$J,.84,740,1,3,0)
 ;;=being passed for validation, when combined with values for unchanging 
 ;;^UTILITY(U,$J,.84,740,1,4,0)
 ;;=fields in the entry if necessary, create a duplicate key.  The changes 
 ;;^UTILITY(U,$J,.84,740,1,5,0)
 ;;=destroy the integrity of the key.  Therefore, they are invalid.
 ;;^UTILITY(U,$J,.84,740,2,0)
 ;;=^^1^1^2980407^
 ;;^UTILITY(U,$J,.84,740,2,1,0)
 ;;=New values are invalid because they create a duplicate Key '|1|' for the |2| file.
 ;;^UTILITY(U,$J,.84,740,3,0)
 ;;=^.845^5^5
 ;;^UTILITY(U,$J,.84,740,3,1,0)
 ;;=1^Name of Key.
 ;;^UTILITY(U,$J,.84,740,3,2,0)
 ;;=2^Name of affected file.
 ;;^UTILITY(U,$J,.84,740,3,3,0)
 ;;=FILE^File number.
 ;;^UTILITY(U,$J,.84,740,3,4,0)
 ;;=KEY^IEN of the invalid key.
 ;;^UTILITY(U,$J,.84,740,3,5,0)
 ;;=IENS^IENS of record with invalid key.
 ;;^UTILITY(U,$J,.84,741,0)
 ;;=741^1^^5
 ;;^UTILITY(U,$J,.84,741,1,0)
 ;;=^^3^3^2981208^
 ;;^UTILITY(U,$J,.84,741,1,1,0)
 ;;=Error message generated when user is adding a new entry using classic
 ;;^UTILITY(U,$J,.84,741,1,2,0)
 ;;=FileMan lookup ^DIC routines, and either key values are not entered, or
 ;;^UTILITY(U,$J,.84,741,1,3,0)
 ;;=they create a duplicate key.
 ;;^UTILITY(U,$J,.84,741,2,0)
 ;;=^^1^1^2981208^
 ;;^UTILITY(U,$J,.84,741,2,1,0)
 ;;=Either key values are null, or they create a duplicate key.
 ;;^UTILITY(U,$J,.84,741,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,741,5,1,0)
 ;;=DICN1^A
 ;;^UTILITY(U,$J,.84,742,0)
 ;;=742^1^y^5
 ;;^UTILITY(U,$J,.84,742,1,0)
 ;;=^^2^2^2980407^^^^
 ;;^UTILITY(U,$J,.84,742,1,1,0)
 ;;=Every field in a key must have a value.  The incoming data cannot delete
 ;;^UTILITY(U,$J,.84,742,1,2,0)
 ;;=the value for any field in a key.
 ;;^UTILITY(U,$J,.84,742,2,0)
 ;;=^^1^1^2980407^^
 ;;^UTILITY(U,$J,.84,742,2,1,0)
 ;;=The value of field |1| in the |2| file cannot be deleted because that field is part of the '|3|' key.
 ;;^UTILITY(U,$J,.84,742,3,0)
 ;;=^.845^6^6
 ;;^UTILITY(U,$J,.84,742,3,1,0)
 ;;=1^Field name
 ;;^UTILITY(U,$J,.84,742,3,2,0)
 ;;=2^File name
 ;;^UTILITY(U,$J,.84,742,3,3,0)
 ;;=3^Key name
 ;;^UTILITY(U,$J,.84,742,3,4,0)
 ;;=FILE^File number.
 ;;^UTILITY(U,$J,.84,742,3,5,0)
 ;;=FIELD^Field number.
 ;;^UTILITY(U,$J,.84,742,3,6,0)
 ;;=IENS^IENS
 ;;^UTILITY(U,$J,.84,744,0)
 ;;=744^1^y^5
 ;;^UTILITY(U,$J,.84,744,1,0)
 ;;=^^2^2^2980413^^^^
 ;;^UTILITY(U,$J,.84,744,1,1,0)
 ;;=Every field that is in a key must have a value.  No value for this field 
 ;;^UTILITY(U,$J,.84,744,1,2,0)
 ;;=exists.
 ;;^UTILITY(U,$J,.84,744,2,0)
 ;;=^^1^1^2980407^^^^
 ;;^UTILITY(U,$J,.84,744,2,1,0)
 ;;=Field |1| is part of Key '|2|', but the field has not been assigned a value.
 ;;^UTILITY(U,$J,.84,744,3,0)
 ;;=^.845^5^5
 ;;^UTILITY(U,$J,.84,744,3,1,0)
 ;;=1^Field name.
 ;;^UTILITY(U,$J,.84,744,3,2,0)
 ;;=2^Key name.
 ;;^UTILITY(U,$J,.84,744,3,3,0)
 ;;=FIELD^Field number.
 ;;^UTILITY(U,$J,.84,744,3,4,0)
 ;;=FILE^File number.
 ;;^UTILITY(U,$J,.84,744,3,5,0)
 ;;=IENS^IENS of record with incomplete key.
 ;;^UTILITY(U,$J,.84,746,0)
 ;;=746^1^y^5
 ;;^UTILITY(U,$J,.84,746,1,0)
 ;;=^^2^2^2980415^^^^
 ;;^UTILITY(U,$J,.84,746,1,1,0)
 ;;=A lookup node is present in the FDA, but no Primary Key fields are
 ;;^UTILITY(U,$J,.84,746,1,2,0)
 ;;=provided.
 ;;^UTILITY(U,$J,.84,746,2,0)
 ;;=^^1^1^2980415^
 ;;^UTILITY(U,$J,.84,746,2,1,0)
 ;;=No fields in Primary Key '|1|' have been provided in the FDA to look up '|IENS|' in the |2| file.
 ;;^UTILITY(U,$J,.84,746,3,0)
 ;;=^.845^5^5
 ;;^UTILITY(U,$J,.84,746,3,1,0)
 ;;=1^Key name.
 ;;^UTILITY(U,$J,.84,746,3,2,0)
 ;;=2^File name.
 ;;^UTILITY(U,$J,.84,746,3,3,0)
 ;;=IENS^IENS of lookup node.
 ;;^UTILITY(U,$J,.84,746,3,4,0)
 ;;=KEY^Key number.
 ;;^UTILITY(U,$J,.84,746,3,5,0)
 ;;=FILE^File number.
 ;;^UTILITY(U,$J,.84,810,0)
 ;;=810^1^^5
 ;;^UTILITY(U,$J,.84,810,1,0)
 ;;=^^3^3^2931109^
 ;;^UTILITY(U,$J,.84,810,1,1,0)
 ;;=A %ZOSF node required to perform a function does not exist.  The
 ;;^UTILITY(U,$J,.84,810,1,2,0)
 ;;=VA FileMan Programmer's Manual contains a complete list of %ZOSF
 ;;^UTILITY(U,$J,.84,810,1,3,0)
 ;;=nodes.
 ;;^UTILITY(U,$J,.84,810,2,0)
 ;;=^^1^1^2931109^
 ;;^UTILITY(U,$J,.84,810,2,1,0)
 ;;=A necessary %ZOSF node does not exist on your system.
 ;;^UTILITY(U,$J,.84,820,0)
 ;;=820^1^^5
 ;;^UTILITY(U,$J,.84,820,1,0)
 ;;=^^3^3^2931109^
 ;;^UTILITY(U,$J,.84,820,1,1,0)
 ;;=The ZSAVE CODE field (#2619) in the MUMPS Operating System file (#.7)

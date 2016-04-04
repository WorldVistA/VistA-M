DINIT008 ; SFISC/TKW-DIALOG & LANGUAGE FILE INITS ; 3/30/99  10:41:48
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
Q Q
 ;;^UTILITY(U,$J,.84,501,1,1,0)
 ;;=A search of the data dictionary reveals that the field name or number
 ;;^UTILITY(U,$J,.84,501,1,2,0)
 ;;=passed does not exist in the specified file.
 ;;^UTILITY(U,$J,.84,501,2,0)
 ;;=^^1^1^2940214^^
 ;;^UTILITY(U,$J,.84,501,2,1,0)
 ;;=File #|FILE| does not contain a field |1|.
 ;;^UTILITY(U,$J,.84,501,3,0)
 ;;=^.845^3^3
 ;;^UTILITY(U,$J,.84,501,3,1,0)
 ;;=1^Field name or number.
 ;;^UTILITY(U,$J,.84,501,3,2,0)
 ;;=FILE^File number.
 ;;^UTILITY(U,$J,.84,501,3,3,0)
 ;;=FIELD^Field number.
 ;;^UTILITY(U,$J,.84,502,0)
 ;;=502^1^y^5
 ;;^UTILITY(U,$J,.84,502,1,0)
 ;;=^^3^3^2940715^
 ;;^UTILITY(U,$J,.84,502,1,1,0)
 ;;=The field has been identified, but some key part of its definition is
 ;;^UTILITY(U,$J,.84,502,1,2,0)
 ;;=missing or corrupted. ^DD(file#,field#,0) may not be defined. Some key
 ;;^UTILITY(U,$J,.84,502,1,3,0)
 ;;=piece of that node may be missing.
 ;;^UTILITY(U,$J,.84,502,2,0)
 ;;=^^1^1^2940715^
 ;;^UTILITY(U,$J,.84,502,2,1,0)
 ;;=Field# |FIELD| in file# |FILE| has a corrupted definition.
 ;;^UTILITY(U,$J,.84,502,3,0)
 ;;=^.845^2^2
 ;;^UTILITY(U,$J,.84,502,3,1,0)
 ;;=FILE^File #.
 ;;^UTILITY(U,$J,.84,502,3,2,0)
 ;;=FIELD^Field #.
 ;;^UTILITY(U,$J,.84,505,0)
 ;;=505^1^y^5
 ;;^UTILITY(U,$J,.84,505,1,0)
 ;;=^^2^2^2931110^^
 ;;^UTILITY(U,$J,.84,505,1,1,0)
 ;;=The field name passed is ambiguous.  It cannot be determined to which field
 ;;^UTILITY(U,$J,.84,505,1,2,0)
 ;;=in the file it refers.
 ;;^UTILITY(U,$J,.84,505,2,0)
 ;;=^^1^1^2931116^^
 ;;^UTILITY(U,$J,.84,505,2,1,0)
 ;;=There is more than one field named '|1|' in File #|FILE|.
 ;;^UTILITY(U,$J,.84,505,3,0)
 ;;=^.845^2^2
 ;;^UTILITY(U,$J,.84,505,3,1,0)
 ;;=1^Field name.
 ;;^UTILITY(U,$J,.84,505,3,2,0)
 ;;=FILE^File #.
 ;;^UTILITY(U,$J,.84,510,0)
 ;;=510^1^y^5
 ;;^UTILITY(U,$J,.84,510,1,0)
 ;;=^^2^2^2940214^^^^
 ;;^UTILITY(U,$J,.84,510,1,1,0)
 ;;=For some reason, the data type for the specified field cannot be determined.
 ;;^UTILITY(U,$J,.84,510,1,2,0)
 ;;=This may mean that the data dictionary is corrupted.
 ;;^UTILITY(U,$J,.84,510,2,0)
 ;;=^^1^1^2940214^^
 ;;^UTILITY(U,$J,.84,510,2,1,0)
 ;;=The data type for Field #|FIELD| in File #|FILE| cannot be determined.
 ;;^UTILITY(U,$J,.84,510,3,0)
 ;;=^.845^2^2
 ;;^UTILITY(U,$J,.84,510,3,1,0)
 ;;=FIELD^Field number.
 ;;^UTILITY(U,$J,.84,510,3,2,0)
 ;;=FILE^File number.
 ;;^UTILITY(U,$J,.84,520,0)
 ;;=520^1^y^5
 ;;^UTILITY(U,$J,.84,520,1,0)
 ;;=^^3^3^2931110^^
 ;;^UTILITY(U,$J,.84,520,1,1,0)
 ;;=An incorrect kind of field is being processed.  For example, filing is 
 ;;^UTILITY(U,$J,.84,520,1,2,0)
 ;;=being attempted for a computed field or validation for a word
 ;;^UTILITY(U,$J,.84,520,1,3,0)
 ;;=processing field.
 ;;^UTILITY(U,$J,.84,520,2,0)
 ;;=^^1^1^2931110^^
 ;;^UTILITY(U,$J,.84,520,2,1,0)
 ;;=A |1| field cannot be processed by this utility.
 ;;^UTILITY(U,$J,.84,520,3,0)
 ;;=^.845^3^3
 ;;^UTILITY(U,$J,.84,520,3,1,0)
 ;;=1^Data type or other field characteristic (e.g., .001, DINUMed).
 ;;^UTILITY(U,$J,.84,520,3,2,0)
 ;;=FILE^File #.
 ;;^UTILITY(U,$J,.84,520,3,3,0)
 ;;=FIELD^Field #.
 ;;^UTILITY(U,$J,.84,520,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,520,5,1,0)
 ;;=DIE^FILE
 ;;^UTILITY(U,$J,.84,525,0)
 ;;=525^1^y
 ;;^UTILITY(U,$J,.84,525,1,0)
 ;;=^^2^2^2950317^
 ;;^UTILITY(U,$J,.84,525,1,1,0)
 ;;=It is indicated that a subfile is involved (for example, by choosing a
 ;;^UTILITY(U,$J,.84,525,1,2,0)
 ;;=multiple field's field number), but no fields from the subfile are chosen.
 ;;^UTILITY(U,$J,.84,525,2,0)
 ;;=^^1^1^2950317^
 ;;^UTILITY(U,$J,.84,525,2,1,0)
 ;;=No fields are specified for subfile #|FILE|.
 ;;^UTILITY(U,$J,.84,525,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,525,3,1,0)
 ;;=FILE^Subfile #.
 ;;^UTILITY(U,$J,.84,537,0)
 ;;=537^1^y^5
 ;;^UTILITY(U,$J,.84,537,1,0)
 ;;=^^7^7^2940213^
 ;;^UTILITY(U,$J,.84,537,1,1,0)
 ;;=This error means that a certain field in a certain file has a data type of
 ;;^UTILITY(U,$J,.84,537,1,2,0)
 ;;=pointer, but something is wrong with the rest of the DD info needed to
 ;;^UTILITY(U,$J,.84,537,1,3,0)
 ;;=make that pointer work. For example, perhaps the number of the pointed to
 ;;^UTILITY(U,$J,.84,537,1,4,0)
 ;;=file, which should follow the P in the second ^-piece of the field
 ;;^UTILITY(U,$J,.84,537,1,5,0)
 ;;=descriptor node, is missing. Another problem would be if the global root
 ;;^UTILITY(U,$J,.84,537,1,6,0)
 ;;=of the pointed to file were missing from the field's definition; that
 ;;^UTILITY(U,$J,.84,537,1,7,0)
 ;;=should be found in the third ^-piece of the field descriptor.
 ;;^UTILITY(U,$J,.84,537,2,0)
 ;;=^^1^1^2940213^
 ;;^UTILITY(U,$J,.84,537,2,1,0)
 ;;=Field #|FIELD| in File #|FILE| has a corrupted pointer definition.
 ;;^UTILITY(U,$J,.84,537,3,0)
 ;;=^.845^2^2
 ;;^UTILITY(U,$J,.84,537,3,1,0)
 ;;=FILE^File #.
 ;;^UTILITY(U,$J,.84,537,3,2,0)
 ;;=FIELD^Field #.
 ;;^UTILITY(U,$J,.84,601,0)
 ;;=601^1^^5
 ;;^UTILITY(U,$J,.84,601,1,0)
 ;;=^^1^1^2940426^
 ;;^UTILITY(U,$J,.84,601,1,1,0)
 ;;=The entry identified by FILE and IENS does not exist in the database.
 ;;^UTILITY(U,$J,.84,601,2,0)
 ;;=^^1^1^2940426^^
 ;;^UTILITY(U,$J,.84,601,2,1,0)
 ;;=The entry does not exist.
 ;;^UTILITY(U,$J,.84,601,3,0)
 ;;=^.845^2^2
 ;;^UTILITY(U,$J,.84,601,3,1,0)
 ;;=FILE^File or subfile #. (external only)
 ;;^UTILITY(U,$J,.84,601,3,2,0)
 ;;=IENS^IEN string (external only)
 ;;^UTILITY(U,$J,.84,602,0)
 ;;=602^1^^5
 ;;^UTILITY(U,$J,.84,602,1,0)
 ;;=^^1^1^2931109^
 ;;^UTILITY(U,$J,.84,602,1,1,0)
 ;;=There is a -9 node for the entry; therefore, the entry cannot be accessed.
 ;;^UTILITY(U,$J,.84,602,2,0)
 ;;=^^1^1^2931109^
 ;;^UTILITY(U,$J,.84,602,2,1,0)
 ;;=The entry is not available for editing.
 ;;^UTILITY(U,$J,.84,602,3,0)
 ;;=^.845^2^2
 ;;^UTILITY(U,$J,.84,602,3,1,0)
 ;;=FILE^File or subfile #. (external only)
 ;;^UTILITY(U,$J,.84,602,3,2,0)
 ;;=IENS^IEN string. (external only)
 ;;^UTILITY(U,$J,.84,603,0)
 ;;=603^1^y^5
 ;;^UTILITY(U,$J,.84,603,1,0)
 ;;=^^2^2^2940214^
 ;;^UTILITY(U,$J,.84,603,1,1,0)
 ;;=A specific entry in a specific file lacks a value for a required field.
 ;;^UTILITY(U,$J,.84,603,1,2,0)
 ;;=This error message returns which field is missing.
 ;;^UTILITY(U,$J,.84,603,2,0)
 ;;=^^1^1^2940214^
 ;;^UTILITY(U,$J,.84,603,2,1,0)
 ;;=Entry #|1| in File #|FILE| lacks the required Field #|FIELD|.
 ;;^UTILITY(U,$J,.84,603,3,0)
 ;;=^.845^3^3
 ;;^UTILITY(U,$J,.84,603,3,1,0)
 ;;=1^Entry #.
 ;;^UTILITY(U,$J,.84,603,3,2,0)
 ;;=FILE^File #.
 ;;^UTILITY(U,$J,.84,603,3,3,0)
 ;;=FIELD^Field #.

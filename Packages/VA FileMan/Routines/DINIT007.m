DINIT007 ; SFISC/TKW-DIALOG & LANGUAGE FILE INITS ; 3/30/99  10:41:48
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
Q Q
 ;;^UTILITY(U,$J,.84,352,3,0)
 ;;=^.845^2^2
 ;;^UTILITY(U,$J,.84,352,3,1,0)
 ;;=FILE^File number.
 ;;^UTILITY(U,$J,.84,352,3,2,0)
 ;;=IENS^IENS subscript for LAYGO or LAYGO Finding node.
 ;;^UTILITY(U,$J,.84,401,0)
 ;;=401^1^y^5
 ;;^UTILITY(U,$J,.84,401,1,0)
 ;;=^^2^2^2990218^^^^
 ;;^UTILITY(U,$J,.84,401,1,1,0)
 ;;=The specified file or subfile does not exist; it is not present in the 
 ;;^UTILITY(U,$J,.84,401,1,2,0)
 ;;=data dictionary.
 ;;^UTILITY(U,$J,.84,401,2,0)
 ;;=^^1^1^2990218^^^^
 ;;^UTILITY(U,$J,.84,401,2,1,0)
 ;;=File #|FILE| does not exist.
 ;;^UTILITY(U,$J,.84,401,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,401,3,1,0)
 ;;=FILE^File number.
 ;;^UTILITY(U,$J,.84,402,0)
 ;;=402^1^y^5
 ;;^UTILITY(U,$J,.84,402,1,0)
 ;;=^^2^2^2940316^^^^
 ;;^UTILITY(U,$J,.84,402,1,1,0)
 ;;=The specified file or subfile lacks a valid global root; the global root
 ;;^UTILITY(U,$J,.84,402,1,2,0)
 ;;=is missing or is syntactically not valid.
 ;;^UTILITY(U,$J,.84,402,2,0)
 ;;=^^1^1^2940316^^^^
 ;;^UTILITY(U,$J,.84,402,2,1,0)
 ;;=The global root of file #|FILE| is missing or not valid.
 ;;^UTILITY(U,$J,.84,402,3,0)
 ;;=^.845^3^3
 ;;^UTILITY(U,$J,.84,402,3,1,0)
 ;;=FILE^File number.
 ;;^UTILITY(U,$J,.84,402,3,2,0)
 ;;=ROOT^File root.
 ;;^UTILITY(U,$J,.84,402,3,3,0)
 ;;=IENS^IEN String.
 ;;^UTILITY(U,$J,.84,403,0)
 ;;=403^1^y^5
 ;;^UTILITY(U,$J,.84,403,1,0)
 ;;=^^3^3^2940213^
 ;;^UTILITY(U,$J,.84,403,1,1,0)
 ;;=The File Header Node, the top level of the data file as described in the
 ;;^UTILITY(U,$J,.84,403,1,2,0)
 ;;=Programmer Manual, must be present for FileMan to determine certain kinds
 ;;^UTILITY(U,$J,.84,403,1,3,0)
 ;;=of information about a file.
 ;;^UTILITY(U,$J,.84,403,2,0)
 ;;=^^1^1^2940213^
 ;;^UTILITY(U,$J,.84,403,2,1,0)
 ;;=File #|FILE| lacks a Header Node.
 ;;^UTILITY(U,$J,.84,403,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,403,3,1,0)
 ;;=FILE^File #.
 ;;^UTILITY(U,$J,.84,404,0)
 ;;=404^1^y^5
 ;;^UTILITY(U,$J,.84,404,1,0)
 ;;=^^4^4^2940214^
 ;;^UTILITY(U,$J,.84,404,1,1,0)
 ;;=We have identified a file by the global node of its data file, and found
 ;;^UTILITY(U,$J,.84,404,1,2,0)
 ;;=its Header Node. We needed to use the Header Node to identify the number
 ;;^UTILITY(U,$J,.84,404,1,3,0)
 ;;=of the file, but that piece of information is missing from the Header
 ;;^UTILITY(U,$J,.84,404,1,4,0)
 ;;=Node.
 ;;^UTILITY(U,$J,.84,404,2,0)
 ;;=^^1^1^2940214^
 ;;^UTILITY(U,$J,.84,404,2,1,0)
 ;;=The File Header node of the file stored at |1| lacks a file number.
 ;;^UTILITY(U,$J,.84,404,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,404,3,1,0)
 ;;=1^File Root.
 ;;^UTILITY(U,$J,.84,405,0)
 ;;=405^1^y^5
 ;;^UTILITY(U,$J,.84,405,1,0)
 ;;=^^2^2^2931110^^
 ;;^UTILITY(U,$J,.84,405,1,1,0)
 ;;=The NO EDIT flag is set for the file.  No instruction to override
 ;;^UTILITY(U,$J,.84,405,1,2,0)
 ;;=that flag is present.
 ;;^UTILITY(U,$J,.84,405,2,0)
 ;;=^^1^1^2931109^
 ;;^UTILITY(U,$J,.84,405,2,1,0)
 ;;=Entries in file |1| cannot be edited.
 ;;^UTILITY(U,$J,.84,405,3,0)
 ;;=^.845^2^2
 ;;^UTILITY(U,$J,.84,405,3,1,0)
 ;;=1^File Name.
 ;;^UTILITY(U,$J,.84,405,3,2,0)
 ;;=FILE^File number.
 ;;^UTILITY(U,$J,.84,406,0)
 ;;=406^1^y^5
 ;;^UTILITY(U,$J,.84,406,1,0)
 ;;=^^2^2^2940317^
 ;;^UTILITY(U,$J,.84,406,1,1,0)
 ;;=The data definition for a .01 field for the specified file is missing.
 ;;^UTILITY(U,$J,.84,406,1,2,0)
 ;;=This file is therefore not valid for most database operations.
 ;;^UTILITY(U,$J,.84,406,2,0)
 ;;=^^1^1^2940317^
 ;;^UTILITY(U,$J,.84,406,2,1,0)
 ;;=File #|FILE| has no .01 field definition.
 ;;^UTILITY(U,$J,.84,406,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,406,3,1,0)
 ;;=FILE^File #.
 ;;^UTILITY(U,$J,.84,407,0)
 ;;=407^1^^5
 ;;^UTILITY(U,$J,.84,407,1,0)
 ;;=^^4^4^2940317^
 ;;^UTILITY(U,$J,.84,407,1,1,0)
 ;;=The subfile number of a word processing field has been passed in the place
 ;;^UTILITY(U,$J,.84,407,1,2,0)
 ;;=of a file parameter. This is not acceptable. Although we implement word
 ;;^UTILITY(U,$J,.84,407,1,3,0)
 ;;=processing fields as independent files, we do not allow them to be treated
 ;;^UTILITY(U,$J,.84,407,1,4,0)
 ;;=as files for purposes of most database activities.
 ;;^UTILITY(U,$J,.84,407,2,0)
 ;;=^^1^1^2940317^
 ;;^UTILITY(U,$J,.84,407,2,1,0)
 ;;=A word-processing field is not a file.
 ;;^UTILITY(U,$J,.84,407,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,407,3,1,0)
 ;;=FILE^Subfile # of word-processing field.
 ;;^UTILITY(U,$J,.84,408,0)
 ;;=408^1^y^5
 ;;^UTILITY(U,$J,.84,408,1,0)
 ;;=^^2^2^2940715^
 ;;^UTILITY(U,$J,.84,408,1,1,0)
 ;;=The file lacks a name. For subfiles, $P(^DD(file#,0),U) is null. For root
 ;;^UTILITY(U,$J,.84,408,1,2,0)
 ;;=files, $O(^DD(file#,0,"NM",""))="". 
 ;;^UTILITY(U,$J,.84,408,2,0)
 ;;=^^1^1^2940715^
 ;;^UTILITY(U,$J,.84,408,2,1,0)
 ;;=File# |FILE| lacks a name.
 ;;^UTILITY(U,$J,.84,408,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,408,3,1,0)
 ;;=FILE^File #.
 ;;^UTILITY(U,$J,.84,409,0)
 ;;=409^1^y
 ;;^UTILITY(U,$J,.84,409,1,0)
 ;;=^^1^1^2950317^
 ;;^UTILITY(U,$J,.84,409,1,1,0)
 ;;=The indicated file does not exist in the FileMan database.
 ;;^UTILITY(U,$J,.84,409,2,0)
 ;;=^^1^1^2950317^
 ;;^UTILITY(U,$J,.84,409,2,1,0)
 ;;=File '|1|' could not be found.
 ;;^UTILITY(U,$J,.84,409,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,409,3,1,0)
 ;;=1^File name or number.
 ;;^UTILITY(U,$J,.84,410,0)
 ;;=410^1^y^5
 ;;^UTILITY(U,$J,.84,410,1,0)
 ;;=^^1^1^2980602^^^
 ;;^UTILITY(U,$J,.84,410,1,1,0)
 ;;=The global node is either missing or incomplete.
 ;;^UTILITY(U,$J,.84,410,2,0)
 ;;=^^1^1^2980602^
 ;;^UTILITY(U,$J,.84,410,2,1,0)
 ;;=Missing or incomplete global node |1|.
 ;;^UTILITY(U,$J,.84,410,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,410,3,1,0)
 ;;=1^GLOBAL NODE
 ;;^UTILITY(U,$J,.84,420,0)
 ;;=420^1^y^5
 ;;^UTILITY(U,$J,.84,420,1,0)
 ;;=^^4^4^2940628^
 ;;^UTILITY(U,$J,.84,420,1,1,0)
 ;;=A cross reference was specified for look-up, but that cross reference 
 ;;^UTILITY(U,$J,.84,420,1,2,0)
 ;;=does not exist on the file. The file has entries, but the index does not.
 ;;^UTILITY(U,$J,.84,420,1,3,0)
 ;;=This error implies nothing about whether the index is defined in the
 ;;^UTILITY(U,$J,.84,420,1,4,0)
 ;;=file's DD.
 ;;^UTILITY(U,$J,.84,420,2,0)
 ;;=^^1^1^2931109^
 ;;^UTILITY(U,$J,.84,420,2,1,0)
 ;;=There is no |1| index for File #|FILE|.
 ;;^UTILITY(U,$J,.84,420,3,0)
 ;;=^.845^2^2
 ;;^UTILITY(U,$J,.84,420,3,1,0)
 ;;=1^Cross reference name.
 ;;^UTILITY(U,$J,.84,420,3,2,0)
 ;;=FILE^File number.
 ;;^UTILITY(U,$J,.84,501,0)
 ;;=501^1^y^5
 ;;^UTILITY(U,$J,.84,501,1,0)
 ;;=^^2^2^2940214^^^

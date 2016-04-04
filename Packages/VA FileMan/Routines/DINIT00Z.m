DINIT00Z ; SFISC/TKW-DIALOG & LANGUAGE FILE INITS ; 3/30/99  10:41:48
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
Q Q
 ;;^UTILITY(U,$J,.84,9537,0)
 ;;=9537^1^y^5
 ;;^UTILITY(U,$J,.84,9537,1,0)
 ;;=^^1^1^2940909^^^
 ;;^UTILITY(U,$J,.84,9537,1,1,0)
 ;;=Unable to find exact match and resolve pointer.
 ;;^UTILITY(U,$J,.84,9537,2,0)
 ;;=^^1^1^2940909^^^
 ;;^UTILITY(U,$J,.84,9537,2,1,0)
 ;;=Unable to find exact match and resolve pointer |1|.
 ;;^UTILITY(U,$J,.84,9538,0)
 ;;=9538^1^y^5
 ;;^UTILITY(U,$J,.84,9538,1,0)
 ;;=^^1^1^2940909^^
 ;;^UTILITY(U,$J,.84,9538,1,1,0)
 ;;=Pointer resolved value is missing.
 ;;^UTILITY(U,$J,.84,9538,2,0)
 ;;=^^1^1^2940909^^
 ;;^UTILITY(U,$J,.84,9538,2,1,0)
 ;;=Pointer resolved value is missing |1|.
 ;;^UTILITY(U,$J,.84,9539,0)
 ;;=9539^1^y^5
 ;;^UTILITY(U,$J,.84,9539,1,0)
 ;;=^^1^1^2940914^
 ;;^UTILITY(U,$J,.84,9539,1,1,0)
 ;;=File not on this system.
 ;;^UTILITY(U,$J,.84,9539,2,0)
 ;;=^^1^1^2940914^
 ;;^UTILITY(U,$J,.84,9539,2,1,0)
 ;;=File #|1| not on this system.
 ;;^UTILITY(U,$J,.84,9540,0)
 ;;=9540^1^y^5
 ;;^UTILITY(U,$J,.84,9540,1,0)
 ;;=^^1^1^2940914^^
 ;;^UTILITY(U,$J,.84,9540,1,1,0)
 ;;=DD not on this system.
 ;;^UTILITY(U,$J,.84,9540,2,0)
 ;;=^^1^1^2940914^^
 ;;^UTILITY(U,$J,.84,9540,2,1,0)
 ;;=DD #|1| not on this system.
 ;;^UTILITY(U,$J,.84,9541,0)
 ;;=9541^1^y^5
 ;;^UTILITY(U,$J,.84,9541,1,0)
 ;;=^^1^1^2940914^^
 ;;^UTILITY(U,$J,.84,9541,1,1,0)
 ;;=Field not on this system.
 ;;^UTILITY(U,$J,.84,9541,2,0)
 ;;=^^1^1^2940914^^
 ;;^UTILITY(U,$J,.84,9541,2,1,0)
 ;;=Field #|1|, DD #|2|, not on this system.
 ;;^UTILITY(U,$J,.84,9542,0)
 ;;=9542^1^^5
 ;;^UTILITY(U,$J,.84,9542,1,0)
 ;;=^^1^1^2940914^
 ;;^UTILITY(U,$J,.84,9542,1,1,0)
 ;;=File number missing or invalid for FIA structure.
 ;;^UTILITY(U,$J,.84,9542,2,0)
 ;;=^^1^1^2940914^
 ;;^UTILITY(U,$J,.84,9542,2,1,0)
 ;;=File number missing or invalid to build FIA structure.
 ;;^UTILITY(U,$J,.84,9543,0)
 ;;=9543^1^y^5
 ;;^UTILITY(U,$J,.84,9543,1,0)
 ;;=^^4^4^2980505^
 ;;^UTILITY(U,$J,.84,9543,1,1,0)
 ;;=Each field involved in an INDEX or KEY entry should be included in the
 ;;^UTILITY(U,$J,.84,9543,1,2,0)
 ;;=KIDS' transport global.  If a field participating in an INDEX or KEY entry
 ;;^UTILITY(U,$J,.84,9543,1,3,0)
 ;;=is missing from the transport global, the INDEX or KEY entry is not
 ;;^UTILITY(U,$J,.84,9543,1,4,0)
 ;;=exported.
 ;;^UTILITY(U,$J,.84,9543,2,0)
 ;;=^^2^2^2980505^^
 ;;^UTILITY(U,$J,.84,9543,2,1,0)
 ;;=Field |1| of file |2|, part of '|3|' |4| entry, is missing from the
 ;;^UTILITY(U,$J,.84,9543,2,2,0)
 ;;=transport global.
 ;;^UTILITY(U,$J,.84,9543,3,0)
 ;;=^.845^4^4
 ;;^UTILITY(U,$J,.84,9543,3,1,0)
 ;;=1^Field name
 ;;^UTILITY(U,$J,.84,9543,3,2,0)
 ;;=2^File name
 ;;^UTILITY(U,$J,.84,9543,3,3,0)
 ;;=3^Index or Key name
 ;;^UTILITY(U,$J,.84,9543,3,4,0)
 ;;=4^KEY or INDEX
 ;;^UTILITY(U,$J,.84,9543,5,0)
 ;;=^.841^2^2
 ;;^UTILITY(U,$J,.84,9543,5,1,0)
 ;;=DIFROMSX^DDIXOUT
 ;;^UTILITY(U,$J,.84,9543,5,2,0)
 ;;=DIFROMSY^DDKEYOUT
 ;;^UTILITY(U,$J,.84,9544,0)
 ;;=9544^1^y^5
 ;;^UTILITY(U,$J,.84,9544,1,0)
 ;;=^^4^4^2980505^^
 ;;^UTILITY(U,$J,.84,9544,1,1,0)
 ;;=Each field involved in an INDEX or KEY entry should be included in the
 ;;^UTILITY(U,$J,.84,9544,1,2,0)
 ;;=KIDS' transport global. If any fields participating in an INDEX or KEY
 ;;^UTILITY(U,$J,.84,9544,1,3,0)
 ;;=entry are missing from the transport global, the INDEX or KEY entry is not
 ;;^UTILITY(U,$J,.84,9544,1,4,0)
 ;;=exported.
 ;;^UTILITY(U,$J,.84,9544,2,0)
 ;;=^^2^2^2980507^
 ;;^UTILITY(U,$J,.84,9544,2,1,0)
 ;;=Field(s) that are part of '|1|' |2| entry for file |3| are missing from
 ;;^UTILITY(U,$J,.84,9544,2,2,0)
 ;;=the transport global.
 ;;^UTILITY(U,$J,.84,9544,3,0)
 ;;=^.845^3^3
 ;;^UTILITY(U,$J,.84,9544,3,1,0)
 ;;=1^Key or Index Name
 ;;^UTILITY(U,$J,.84,9544,3,2,0)
 ;;=2^KEY or INDEX
 ;;^UTILITY(U,$J,.84,9544,3,3,0)
 ;;=3^File Name
 ;;^UTILITY(U,$J,.84,9544,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9544,5,1,0)
 ;;=DIFROMSX^DDIXOUT
 ;;^UTILITY(U,$J,.84,9545,0)
 ;;=9545^1^y^5
 ;;^UTILITY(U,$J,.84,9545,1,0)
 ;;=^^2^2^2980505^^
 ;;^UTILITY(U,$J,.84,9545,1,1,0)
 ;;=INDEX entry not installed.  This entry references a field that does not
 ;;^UTILITY(U,$J,.84,9545,1,2,0)
 ;;=exist on the target system.
 ;;^UTILITY(U,$J,.84,9545,2,0)
 ;;=^^2^2^2980507^
 ;;^UTILITY(U,$J,.84,9545,2,1,0)
 ;;=|1| '|2|' not installed.  Field |3| in file |4|
 ;;^UTILITY(U,$J,.84,9545,2,2,0)
 ;;=does not exist on the system.
 ;;^UTILITY(U,$J,.84,9545,3,0)
 ;;=^.845^4^4
 ;;^UTILITY(U,$J,.84,9545,3,1,0)
 ;;=2^This is name of the Index file entry.
 ;;^UTILITY(U,$J,.84,9545,3,2,0)
 ;;=3^This is the field that is being referenced by the Index entry.
 ;;^UTILITY(U,$J,.84,9545,3,3,0)
 ;;=4^This is the file that is being referenced by the Index entry.
 ;;^UTILITY(U,$J,.84,9545,3,4,0)
 ;;=1^KEY or INDEX
 ;;^UTILITY(U,$J,.84,9545,5,0)
 ;;=^.841^2^2
 ;;^UTILITY(U,$J,.84,9545,5,1,0)
 ;;=DDFROMSX^DDIXIN
 ;;^UTILITY(U,$J,.84,9545,5,2,0)
 ;;=DDFROMSY^DDKEYIN
 ;;^UTILITY(U,$J,.84,9546,0)
 ;;=9546^1^y^5
 ;;^UTILITY(U,$J,.84,9546,1,0)
 ;;=^^2^2^2980505^
 ;;^UTILITY(U,$J,.84,9546,1,1,0)
 ;;=Uniqueness index pointer either missing from KEY file entry or invalid,
 ;;^UTILITY(U,$J,.84,9546,1,2,0)
 ;;=when trying to transport the KEY.
 ;;^UTILITY(U,$J,.84,9546,2,0)
 ;;=^^2^2^2980505^
 ;;^UTILITY(U,$J,.84,9546,2,1,0)
 ;;=KEY '|1|' for file |2| cannot be transported, problem with Uniqueness
 ;;^UTILITY(U,$J,.84,9546,2,2,0)
 ;;=Index for the KEY.
 ;;^UTILITY(U,$J,.84,9546,3,0)
 ;;=^.845^2^2
 ;;^UTILITY(U,$J,.84,9546,3,1,0)
 ;;=1^This is the name of the KEY file entry.
 ;;^UTILITY(U,$J,.84,9546,3,2,0)
 ;;=2^This is the file number that owns the KEY file entry.
 ;;^UTILITY(U,$J,.84,9547,0)
 ;;=9547^1^y^5
 ;;^UTILITY(U,$J,.84,9547,1,0)
 ;;=^^2^2^2980505^^
 ;;^UTILITY(U,$J,.84,9547,1,1,0)
 ;;=KEY file entry cannot be installed because Uniqueness Index pointer can't
 ;;^UTILITY(U,$J,.84,9547,1,2,0)
 ;;=be resolved.
 ;;^UTILITY(U,$J,.84,9547,2,0)
 ;;=^^2^2^2980507^
 ;;^UTILITY(U,$J,.84,9547,2,1,0)
 ;;=KEY entry '|1|' for file |2| not installed.  Pointer to Uniqueness Index
 ;;^UTILITY(U,$J,.84,9547,2,2,0)
 ;;=cannot be resolved.
 ;;^UTILITY(U,$J,.84,9547,3,0)
 ;;=^.845^2^2
 ;;^UTILITY(U,$J,.84,9547,3,1,0)
 ;;=1^This is the name of the KEY file entry
 ;;^UTILITY(U,$J,.84,9547,3,2,0)
 ;;=2^This is the number of the file that owns the KEY.
 ;;^UTILITY(U,$J,.84,9547,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9547,5,1,0)
 ;;=DIFROMSY^DDKEYIN
 ;;^UTILITY(U,$J,.84,9548,0)
 ;;=9548^1^y^5
 ;;^UTILITY(U,$J,.84,9548,1,0)
 ;;=^^2^2^2980610^
 ;;^UTILITY(U,$J,.84,9548,1,1,0)
 ;;=Error from TRANSFER mode, when DD is being cloned from the transfer FROM

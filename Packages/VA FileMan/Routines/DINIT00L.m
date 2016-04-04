DINIT00L ; SFISC/TKW-DIALOG & LANGUAGE FILE INITS ;29AUG2003
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**999,122**
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
Q Q
 ;;^UTILITY(U,$J,.84,8084,2,0)
 ;;=^^1^1^2940318^
 ;;^UTILITY(U,$J,.84,8084,2,1,0)
 ;;=file number
 ;;^UTILITY(U,$J,.84,8084,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8084,5,1,0)
 ;;=DIT^TRNMRG
 ;;^UTILITY(U,$J,.84,8085,0)
 ;;=8085^2^^5
 ;;^UTILITY(U,$J,.84,8085,1,0)
 ;;=^^1^1^2940426^^
 ;;^UTILITY(U,$J,.84,8085,1,1,0)
 ;;=The words 'IEN string' to be used in any dialog.
 ;;^UTILITY(U,$J,.84,8085,2,0)
 ;;=^^1^1^2940426^^
 ;;^UTILITY(U,$J,.84,8085,2,1,0)
 ;;=IEN string
 ;;^UTILITY(U,$J,.84,8085,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8085,5,1,0)
 ;;=DIT^TRNMRG
 ;;^UTILITY(U,$J,.84,8086,0)
 ;;=8086^2^^5
 ;;^UTILITY(U,$J,.84,8086,1,0)
 ;;=^^1^1^2940608^^^^
 ;;^UTILITY(U,$J,.84,8086,1,1,0)
 ;;=Warning to use the merge only during non-peak times.
 ;;^UTILITY(U,$J,.84,8086,2,0)
 ;;=^^5^5^2940608^
 ;;^UTILITY(U,$J,.84,8086,2,1,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,8086,2,2,0)
 ;;=NOTE: Use this option ONLY DURING NON-PEAK HOURS if merging entries in a
 ;;^UTILITY(U,$J,.84,8086,2,3,0)
 ;;=file that is pointed-to either by many files, or by large files.
 ;;^UTILITY(U,$J,.84,8086,2,4,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,8086,2,5,0)
 ;;=MERGE ENTRIES AFTER COMPARING THEM 
 ;;^UTILITY(U,$J,.84,8087,0)
 ;;=8087^2^y^5^End of Page message for Lookup (DIC)
 ;;^UTILITY(U,$J,.84,8087,1,0)
 ;;=^^2^2^2970529^
 ;;^UTILITY(U,$J,.84,8087,1,1,0)
 ;;=Displays the end of page message displayed at the bottom of a screen after
 ;;^UTILITY(U,$J,.84,8087,1,2,0)
 ;;=a list of selectable entries is displayed during lookup (^DIC).
 ;;^UTILITY(U,$J,.84,8087,2,0)
 ;;=^^1^1^2970529^
 ;;^UTILITY(U,$J,.84,8087,2,1,0)
 ;;=Press <Enter> to see more, '^' to exit this list, |T| OR
 ;;^UTILITY(U,$J,.84,8087,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,8087,3,1,0)
 ;;=T^TO EXIT ALL LISTS
 ;;^UTILITY(U,$J,.84,8087,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8087,5,1,0)
 ;;=DIC1^DSP
 ;;^UTILITY(U,$J,.84,8088,0)
 ;;=8088^2^y^5
 ;;^UTILITY(U,$J,.84,8088,1,0)
 ;;=^^2^2^2970529^^
 ;;^UTILITY(U,$J,.84,8088,1,1,0)
 ;;=Message directing the user to Choose one of the displayed selections
 ;;^UTILITY(U,$J,.84,8088,1,2,0)
 ;;=during lookup (^DIC).
 ;;^UTILITY(U,$J,.84,8088,2,0)
 ;;=^^1^1^2970529^
 ;;^UTILITY(U,$J,.84,8088,2,1,0)
 ;;=CHOOSE |1|-|2|: 
 ;;^UTILITY(U,$J,.84,8088,3,0)
 ;;=^.845^2^2
 ;;^UTILITY(U,$J,.84,8088,3,1,0)
 ;;=1^Starting number in displayed list
 ;;^UTILITY(U,$J,.84,8088,3,2,0)
 ;;=2^Ending number in displayed list
 ;;^UTILITY(U,$J,.84,8088,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8088,5,1,0)
 ;;=DIC1^DSP
 ;;^UTILITY(U,$J,.84,8089,0)
 ;;=8089^2^y^5
 ;;^UTILITY(U,$J,.84,8089,1,0)
 ;;=^^2^2^2970609^^
 ;;^UTILITY(U,$J,.84,8089,1,1,0)
 ;;=Message used during interactive ^DIC to display the file and index name
 ;;^UTILITY(U,$J,.84,8089,1,2,0)
 ;;=on which the displayed entries were found.
 ;;^UTILITY(U,$J,.84,8089,2,0)
 ;;=^^1^1^2970609^^
 ;;^UTILITY(U,$J,.84,8089,2,1,0)
 ;;=Matches to: |1| |2|.
 ;;^UTILITY(U,$J,.84,8089,3,0)
 ;;=^.845^2^2
 ;;^UTILITY(U,$J,.84,8089,3,1,0)
 ;;=1^File name
 ;;^UTILITY(U,$J,.84,8089,3,2,0)
 ;;=2^Indexed field name
 ;;^UTILITY(U,$J,.84,8089,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8089,5,1,0)
 ;;=DIC1^DSP
 ;;^UTILITY(U,$J,.84,8090,0)
 ;;=8090^2^^5
 ;;^UTILITY(U,$J,.84,8090,1,0)
 ;;=^^3^3^2970626^
 ;;^UTILITY(U,$J,.84,8090,1,1,0)
 ;;=Used in displaying an error message when the lookup value X does not pass
 ;;^UTILITY(U,$J,.84,8090,1,2,0)
 ;;=the Pre-lookup transform code (^DD(File#,.01,7.5) node) during ^DIC or
 ;;^UTILITY(U,$J,.84,8090,1,3,0)
 ;;=Finder lookups.
 ;;^UTILITY(U,$J,.84,8090,2,0)
 ;;=^^1^1^2970626^
 ;;^UTILITY(U,$J,.84,8090,2,1,0)
 ;;=Pre-lookup transform (7.5 node)
 ;;^UTILITY(U,$J,.84,8090,5,0)
 ;;=^.841^2^2
 ;;^UTILITY(U,$J,.84,8090,5,1,0)
 ;;=DIC
 ;;^UTILITY(U,$J,.84,8090,5,2,0)
 ;;=DICF
 ;;^UTILITY(U,$J,.84,8091,0)
 ;;=8091^1^^5^
 ;;^UTILITY(U,$J,.84,8091,1,0)
 ;;=^^1^1^2970715^
 ;;^UTILITY(U,$J,.84,8091,1,1,0)
 ;;=Error set when user times out.
 ;;^UTILITY(U,$J,.84,8091,2,0)
 ;;=^^1^1^2970715^
 ;;^UTILITY(U,$J,.84,8091,2,1,0)
 ;;=User timed out.
 ;;^UTILITY(U,$J,.84,8091,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8091,5,1,0)
 ;;=DIC1^Y
 ;;^UTILITY(U,$J,.84,8092,0)
 ;;=8092^1^^5
 ;;^UTILITY(U,$J,.84,8092,1,0)
 ;;=^^1^1^2970715^
 ;;^UTILITY(U,$J,.84,8092,1,1,0)
 ;;=Error when user up-arrows out.
 ;;^UTILITY(U,$J,.84,8092,2,0)
 ;;=^^1^1^2970715^
 ;;^UTILITY(U,$J,.84,8092,2,1,0)
 ;;=User up-arrowed out.
 ;;^UTILITY(U,$J,.84,8092,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8092,5,1,0)
 ;;=DIC1^Y
 ;;^UTILITY(U,$J,.84,8093,0)
 ;;=8093^1^^5
 ;;^UTILITY(U,$J,.84,8093,1,0)
 ;;=^^4^4^2970722^
 ;;^UTILITY(U,$J,.84,8093,1,1,0)
 ;;=Error that occurs when user passes too many lookup values to either the
 ;;^UTILITY(U,$J,.84,8093,1,2,0)
 ;;=Finder call ^DICF or the FileMan lookup ^DIC.  When the number of lookup
 ;;^UTILITY(U,$J,.84,8093,1,3,0)
 ;;=values exceeds the number of subscripts in the index passed (or the
 ;;^UTILITY(U,$J,.84,8093,1,4,0)
 ;;=default index if no index is passed).
 ;;^UTILITY(U,$J,.84,8093,2,0)
 ;;=^^1^1^2970722^
 ;;^UTILITY(U,$J,.84,8093,2,1,0)
 ;;=Too many lookup values for this index.
 ;;^UTILITY(U,$J,.84,8093,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8093,5,1,0)
 ;;=DIC3^ASK
 ;;^UTILITY(U,$J,.84,8094,0)
 ;;=8094^1^^5
 ;;^UTILITY(U,$J,.84,8094,1,0)
 ;;=^^3^3^2970820^
 ;;^UTILITY(U,$J,.84,8094,1,1,0)
 ;;=Error message returned from ^DICF or ^DIC when flags parameter or
 ;;^UTILITY(U,$J,.84,8094,1,2,0)
 ;;=DIC(0) contains an "X", but not enough lookup values passed for the number
 ;;^UTILITY(U,$J,.84,8094,1,3,0)
 ;;=of subscripts in the lookup index.
 ;;^UTILITY(U,$J,.84,8094,2,0)
 ;;=^^1^1^2970820^
 ;;^UTILITY(U,$J,.84,8094,2,1,0)
 ;;=Not enough lookup values provided for an exact match on this index.
 ;;^UTILITY(U,$J,.84,8094,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8094,5,1,0)
 ;;=DIC31^CHKVAL1
 ;;^UTILITY(U,$J,.84,8095,0)
 ;;=8095^1^^5
 ;;^UTILITY(U,$J,.84,8095,1,0)
 ;;=^^3^3^2990104^^
 ;;^UTILITY(U,$J,.84,8095,1,1,0)
 ;;=In calls to the Finder, IX^DIC or MIX^DIC, if the first index passed (or
 ;;^UTILITY(U,$J,.84,8095,1,2,0)
 ;;=the default index) is a compound index, then only one index can be passed,
 ;;^UTILITY(U,$J,.84,8095,1,3,0)
 ;;=so DIC(0) (or flags) cannot contain "M".
 ;;^UTILITY(U,$J,.84,8095,2,0)
 ;;=^^1^1^2990104^
 ;;^UTILITY(U,$J,.84,8095,2,1,0)
 ;;=First lookup index is compound, so "M"ultiple index lookups not allowed.
 ;;^UTILITY(U,$J,.84,8095,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8095,5,1,0)
 ;;=DIC31^CHKVAL1
 ;;^UTILITY(U,$J,.84,8096,0)
 ;;=8096^1^^5
 ;;^UTILITY(U,$J,.84,8096,1,0)
 ;;=^^2^2^2971001^
 ;;^UTILITY(U,$J,.84,8096,1,1,0)
 ;;=Error message from ^DIC or ^DICQ when DIC contains a subfile number

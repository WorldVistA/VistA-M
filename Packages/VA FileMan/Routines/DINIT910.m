DINIT910 ;GFT/GFT-DIALOG FILE INITS ;07:09 PM  31 Aug 2002
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
Q Q
 ;;^UTILITY(U,$J,.84,347,0)
 ;;=347^1^^2
 ;;^UTILITY(U,$J,.84,347,2,0)
 ;;=^^1^1^
 ;;^UTILITY(U,$J,.84,347,2,1,0)
 ;;=Unable to change text.  Resultant line is too long.
 ;;^UTILITY(U,$J,.84,347,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,347,5,1,0)
 ;;=DDWC^RS+5
 ;;^UTILITY(U,$J,.84,830,0)
 ;;=830^1^^2
 ;;^UTILITY(U,$J,.84,830,2,0)
 ;;=^^1^1^
 ;;^UTILITY(U,$J,.84,830,2,1,0)
 ;;=This terminal does not support scroll region or reverse index
 ;;^UTILITY(U,$J,.84,830,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,830,5,1,0)
 ;;=DDBR
 ;;^UTILITY(U,$J,.84,831,0)
 ;;=831^1^^2
 ;;^UTILITY(U,$J,.84,831,2,0)
 ;;=^^1^1^
 ;;^UTILITY(U,$J,.84,831,2,1,0)
 ;;=TOP & BOTTOM MARGINS
 ;;^UTILITY(U,$J,.84,831,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,831,5,1,0)
 ;;=DDBR
 ;;^UTILITY(U,$J,.84,832,0)
 ;;=832^1^^2
 ;;^UTILITY(U,$J,.84,832,2,0)
 ;;=^^1^1^
 ;;^UTILITY(U,$J,.84,832,2,1,0)
 ;;=TOP MARGIN
 ;;^UTILITY(U,$J,.84,832,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,832,5,1,0)
 ;;=DDBR
 ;;^UTILITY(U,$J,.84,833,0)
 ;;=833^1^^2
 ;;^UTILITY(U,$J,.84,833,2,0)
 ;;=^^1^1^
 ;;^UTILITY(U,$J,.84,833,2,1,0)
 ;;=BOTTOM MARGIN
 ;;^UTILITY(U,$J,.84,833,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,833,5,1,0)
 ;;=DDBR
 ;;^UTILITY(U,$J,.84,834,0)
 ;;=834^1^^2
 ;;^UTILITY(U,$J,.84,834,2,0)
 ;;=^^1^1^
 ;;^UTILITY(U,$J,.84,834,2,1,0)
 ;;=SCROLL REGION TOO SMALL
 ;;^UTILITY(U,$J,.84,834,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,834,5,1,0)
 ;;=DDBR
 ;;^UTILITY(U,$J,.84,835,0)
 ;;=835^1^^2
 ;;^UTILITY(U,$J,.84,835,2,0)
 ;;=^^1^1^
 ;;^UTILITY(U,$J,.84,835,2,1,0)
 ;;=REVERSE INDEX
 ;;^UTILITY(U,$J,.84,835,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,835,5,1,0)
 ;;=DDBR
 ;;^UTILITY(U,$J,.84,836,0)
 ;;=836^2^^2
 ;;^UTILITY(U,$J,.84,836,2,0)
 ;;=^^1^1^
 ;;^UTILITY(U,$J,.84,836,2,1,0)
 ;;=Enter a column number between 1 and 255
 ;;^UTILITY(U,$J,.84,836,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,836,5,1,0)
 ;;=DDBR0
 ;;^UTILITY(U,$J,.84,1404,0)
 ;;=1404^1^^2
 ;;^UTILITY(U,$J,.84,1404,2,0)
 ;;=^^1^1^
 ;;^UTILITY(U,$J,.84,1404,2,1,0)
 ;;=NO TEXT!
 ;;^UTILITY(U,$J,.84,1404,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,1404,5,1,0)
 ;;=DDBR
 ;;^UTILITY(U,$J,.84,1405,0)
 ;;=1405^2^y^2
 ;;^UTILITY(U,$J,.84,1405,2,0)
 ;;=^^1^1^
 ;;^UTILITY(U,$J,.84,1405,2,1,0)
 ;;=...Searching for '|1|' ...
 ;;^UTILITY(U,$J,.84,1405,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,1405,3,1,0)
 ;;=1^String being searched for
 ;;^UTILITY(U,$J,.84,1405,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,1405,5,1,0)
 ;;=DDBR1
 ;;^UTILITY(U,$J,.84,1406,0)
 ;;=1406^1^^2
 ;;^UTILITY(U,$J,.84,1406,2,0)
 ;;=^^1^1^
 ;;^UTILITY(U,$J,.84,1406,2,1,0)
 ;;=NO PREVIOUS FIND STRING AVAILABLE
 ;;^UTILITY(U,$J,.84,1406,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,1406,5,1,0)
 ;;=DDBR1
 ;;^UTILITY(U,$J,.84,1407,0)
 ;;=1407^2^^2
 ;;^UTILITY(U,$J,.84,1407,2,0)
 ;;=^^1^1^
 ;;^UTILITY(U,$J,.84,1407,2,1,0)
 ;;=Please enter a string of characters to search for  (or '^')
 ;;^UTILITY(U,$J,.84,1407,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,1407,5,1,0)
 ;;=DDBR1
 ;;^UTILITY(U,$J,.84,1408,0)
 ;;=1408^2^^2
 ;;^UTILITY(U,$J,.84,1408,2,0)
 ;;=^^1^1^
 ;;^UTILITY(U,$J,.84,1408,2,1,0)
 ;;=GoTo
 ;;^UTILITY(U,$J,.84,1408,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,1408,5,1,0)
 ;;=DDBR1
 ;;^UTILITY(U,$J,.84,1409,0)
 ;;=1409^2^^2
 ;;^UTILITY(U,$J,.84,1409,2,0)
 ;;=^^1^1^
 ;;^UTILITY(U,$J,.84,1409,2,1,0)
 ;;=Screen (default), or line number preceeded by 'S' or 'L'
 ;;^UTILITY(U,$J,.84,1409,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,1409,5,1,0)
 ;;=DDBR1
 ;;^UTILITY(U,$J,.84,1409.1,0)
 ;;=1409.1^2^^2
 ;;^UTILITY(U,$J,.84,1409.1,2,0)
 ;;=^^1^1^
 ;;^UTILITY(U,$J,.84,1409.1,2,1,0)
 ;;=Screen (default), column, or line number preceeded by 'S, 'C' or 'L'
 ;;^UTILITY(U,$J,.84,1409.1,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,1409.1,5,1,0)
 ;;=DDBR1
 ;;^UTILITY(U,$J,.84,1901,0)
 ;;=1901^2^^2
 ;;^UTILITY(U,$J,.84,1901,2,0)
 ;;=^^1^1^
 ;;^UTILITY(U,$J,.84,1901,2,1,0)
 ;;=REPORT CANCELLED!
 ;;^UTILITY(U,$J,.84,1901,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,1901,5,1,0)
 ;;=DDBRP
 ;;^UTILITY(U,$J,.84,3090,0)
 ;;=3090^1^y^2
 ;;^UTILITY(U,$J,.84,3090,2,0)
 ;;=^^1^1^
 ;;^UTILITY(U,$J,.84,3090,2,1,0)
 ;;='|1|' is UNEDITABLE
 ;;^UTILITY(U,$J,.84,3090,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,3090,3,1,0)
 ;;=1^Field name
 ;;^UTILITY(U,$J,.84,3090,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,3090,5,1,0)
 ;;=DIED^O+2
 ;;^UTILITY(U,$J,.84,3092.1,0)
 ;;=3092.1^1^^2
 ;;^UTILITY(U,$J,.84,3092.1,2,0)
 ;;=^^1^1^
 ;;^UTILITY(U,$J,.84,3092.1,2,1,0)
 ;;=This is a required field
 ;;^UTILITY(U,$J,.84,3092.1,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,3092.1,5,1,0)
 ;;=DDS02^EXT+22
 ;;^UTILITY(U,$J,.84,3092.2,0)
 ;;=3092.2^1^^2
 ;;^UTILITY(U,$J,.84,3092.2,2,0)
 ;;=^^1^1^
 ;;^UTILITY(U,$J,.84,3092.2,2,1,0)
 ;;=This is a required KEY field
 ;;^UTILITY(U,$J,.84,3092.2,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,3092.2,5,1,0)
 ;;=DIED^NKEY+1
 ;;^UTILITY(U,$J,.84,3093,0)
 ;;=3093^1^^2
 ;;^UTILITY(U,$J,.84,3093,2,0)
 ;;=^^1^1^
 ;;^UTILITY(U,$J,.84,3093,2,1,0)
 ;;=You cannot save changes here.  To close the current page, press <F1>C.
 ;;^UTILITY(U,$J,.84,3093,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,3093,5,1,0)
 ;;=DDS02^SV+5
 ;;^UTILITY(U,$J,.84,3094,0)
 ;;=3094^1^^2
 ;;^UTILITY(U,$J,.84,3094,2,0)
 ;;=^^1^1^
 ;;^UTILITY(U,$J,.84,3094,2,1,0)
 ;;=Another Entry already exists with this KEY value.
 ;;^UTILITY(U,$J,.84,3094,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,3094,5,1,0)
 ;;=DDS02^
 ;;^UTILITY(U,$J,.84,3095,0)
 ;;=3095^1^^2
 ;;^UTILITY(U,$J,.84,3095,2,0)
 ;;=^^1^1^
 ;;^UTILITY(U,$J,.84,3095,2,1,0)
 ;;=Exit not allowed
 ;;^UTILITY(U,$J,.84,3095,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,3095,5,1,0)
 ;;=DIE0
 ;;^UTILITY(U,$J,.84,3096,0)
 ;;=3096^1^^2
 ;;^UTILITY(U,$J,.84,3096,2,0)
 ;;=^^1^1^
 ;;^UTILITY(U,$J,.84,3096,2,1,0)
 ;;=No Jumping allowed
 ;;^UTILITY(U,$J,.84,3096,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,3096,5,1,0)
 ;;=DIE0^
 ;;^UTILITY(U,$J,.84,3097,0)
 ;;=3097^1^^2
 ;;^UTILITY(U,$J,.84,3097,2,0)
 ;;=^^1^1^
 ;;^UTILITY(U,$J,.84,3097,2,1,0)
 ;;=Jumping forward not allowed
 ;;^UTILITY(U,$J,.84,3097,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,3097,5,1,0)
 ;;=DIE0^
 ;;^UTILITY(U,$J,.84,3098,0)
 ;;=3098^1^y^2
 ;;^UTILITY(U,$J,.84,3098,2,0)
 ;;=^^1^1^
 ;;^UTILITY(U,$J,.84,3098,2,1,0)
 ;;='|1|' matches no Field or Caption on this screen
 ;;^UTILITY(U,$J,.84,3098,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,3098,3,1,0)
 ;;=1^Incorrect input after the "^"
 ;;^UTILITY(U,$J,.84,3098,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,3098,5,1,0)
 ;;=DDS2^NO
 ;;^UTILITY(U,$J,.84,7067,0)
 ;;=7067^2^^2
 ;;^UTILITY(U,$J,.84,7067,2,0)
 ;;=^^1^1^
 ;;^UTILITY(U,$J,.84,7067,2,1,0)
 ;;=  Do you mean ALL the fields in the file? 
 ;;^UTILITY(U,$J,.84,7067,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,7067,5,1,0)
 ;;=DIP2^2+5
 ;;^UTILITY(U,$J,.84,7067.1,0)
 ;;=7067.1^2^^2
 ;;^UTILITY(U,$J,.84,7067.1,2,0)
 ;;=^^1^1
 ;;^UTILITY(U,$J,.84,7067.1,2,1,0)
 ;;= Answer YES only if you want every field in the file.
 ;;^UTILITY(U,$J,.84,7067.1,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,7067.1,5,1,0)
 ;;=DIP2^2+5
 ;;^UTILITY(U,$J,.84,7075,0)
 ;;=7075^3^^2
 ;;^UTILITY(U,$J,.84,7075,2,0)
 ;;=^^1^1^
 ;;^UTILITY(U,$J,.84,7075,2,1,0)
 ;;=(Note that this value, starting with a quote ("), precedes all alphanumerics)
 ;;^UTILITY(U,$J,.84,7075,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,7075,5,1,0)
 ;;=DIP1^QUOTE

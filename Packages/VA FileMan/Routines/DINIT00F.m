DINIT00F ; SFISC/TKW-DIALOG & LANGUAGE FILE INITS ;31JAN2005
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**143**
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
Q Q
 ;;^UTILITY(U,$J,.84,7003,0)
 ;;=7003^2^^5
 ;;^UTILITY(U,$J,.84,7003,1,0)
 ;;=^^1^1^2960321^^
 ;;^UTILITY(U,$J,.84,7003,1,1,0)
 ;;=Yes/No prompt for Reader
 ;;^UTILITY(U,$J,.84,7003,2,0)
 ;;=^^1^1^2960321^^^
 ;;^UTILITY(U,$J,.84,7003,2,1,0)
 ;;=y:YES;n:NO
 ;;^UTILITY(U,$J,.84,7003,4,0)
 ;;=^.847P^2^1
 ;;^UTILITY(U,$J,.84,7003,4,2,0)
 ;;=2
 ;;^UTILITY(U,$J,.84,7003,4,2,1,0)
 ;;=^^1^1^2960321^
 ;;^UTILITY(U,$J,.84,7003,4,2,1,1,0)
 ;;=j:JA;n:NEIN
 ;;^UTILITY(U,$J,.84,7004,0)
 ;;=7004^2^^5
 ;;^UTILITY(U,$J,.84,7004,1,0)
 ;;=^^2^2^2940909^^^^
 ;;^UTILITY(U,$J,.84,7004,1,1,0)
 ;;=Set of codes for reader call when asking user whether they want to include
 ;;^UTILITY(U,$J,.84,7004,1,2,0)
 ;;=computed fields and/or IEN in CAPTIONED output.
 ;;^UTILITY(U,$J,.84,7004,2,0)
 ;;=^^4^4^2940914^^
 ;;^UTILITY(U,$J,.84,7004,2,1,0)
 ;;=N:NO - No record number (IEN), no Computed Fields;
 ;;^UTILITY(U,$J,.84,7004,2,2,0)
 ;;=Y:Computed Fields;
 ;;^UTILITY(U,$J,.84,7004,2,3,0)
 ;;=R:Record Number (IEN);
 ;;^UTILITY(U,$J,.84,7004,2,4,0)
 ;;=B:BOTH Computed Fields and Record Number (IEN)
 ;;^UTILITY(U,$J,.84,7005,0)
 ;;=7005^1^^13^You must have a valid DUZ
 ;;^UTILITY(U,$J,.84,7005,2,0)
 ;;=^^1^1^3050128^^^
 ;;^UTILITY(U,$J,.84,7005,2,1,0)
 ;;=You must have a valid DUZ!
 ;;^UTILITY(U,$J,.84,7005,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,7005,5,1,0)
 ;;=DII
 ;;^UTILITY(U,$J,.84,8001,0)
 ;;=8001^2^^5
 ;;^UTILITY(U,$J,.84,8001,1,0)
 ;;=^^1^1^2941118^^^^
 ;;^UTILITY(U,$J,.84,8001,1,1,0)
 ;;=Prompt for name of compiled template or cross-reference routine.
 ;;^UTILITY(U,$J,.84,8001,2,0)
 ;;=^^1^1^2941118^^
 ;;^UTILITY(U,$J,.84,8001,2,1,0)
 ;;=Routine Name
 ;;^UTILITY(U,$J,.84,8001,5,0)
 ;;=^.841^3^3
 ;;^UTILITY(U,$J,.84,8001,5,1,0)
 ;;=DIPZ^ 
 ;;^UTILITY(U,$J,.84,8001,5,2,0)
 ;;=DIEZ^ 
 ;;^UTILITY(U,$J,.84,8001,5,3,0)
 ;;=DIKZ^ 
 ;;^UTILITY(U,$J,.84,8002,0)
 ;;=8002^2^^5
 ;;^UTILITY(U,$J,.84,8002,1,0)
 ;;=^^1^1^2940426^^^^
 ;;^UTILITY(U,$J,.84,8002,1,1,0)
 ;;=Prompt for including computed fields and/or IEN in CAPTIONED output.
 ;;^UTILITY(U,$J,.84,8002,2,0)
 ;;=^^1^1^2940909^^^^
 ;;^UTILITY(U,$J,.84,8002,2,1,0)
 ;;=Include COMPUTED fields
 ;;^UTILITY(U,$J,.84,8003,0)
 ;;=8003^2^y^5
 ;;^UTILITY(U,$J,.84,8003,1,0)
 ;;=^^2^2^2931101^^^^
 ;;^UTILITY(U,$J,.84,8003,1,1,0)
 ;;=Used in Print to display sort criteria in heading--when BY(0) contains
 ;;^UTILITY(U,$J,.84,8003,1,2,0)
 ;;=a search template name.
 ;;^UTILITY(U,$J,.84,8003,2,0)
 ;;=^^1^1^2931102^
 ;;^UTILITY(U,$J,.84,8003,2,1,0)
 ;;=Records from list on |1| search template
 ;;^UTILITY(U,$J,.84,8003,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,8003,3,1,0)
 ;;=1^Name of search template.
 ;;^UTILITY(U,$J,.84,8003,5,0)
 ;;=^.841^2^2
 ;;^UTILITY(U,$J,.84,8003,5,1,0)
 ;;=DIP^EN1
 ;;^UTILITY(U,$J,.84,8003,5,2,0)
 ;;=DIS^ENS
 ;;^UTILITY(U,$J,.84,8004,0)
 ;;=8004^2^y^5
 ;;^UTILITY(U,$J,.84,8004,1,0)
 ;;=^^3^3^2931101^
 ;;^UTILITY(U,$J,.84,8004,1,1,0)
 ;;=Used in Print to display sort criteria in heading--when BY(0) contains
 ;;^UTILITY(U,$J,.84,8004,1,2,0)
 ;;=the global reference for a cross-reference or for another global
 ;;^UTILITY(U,$J,.84,8004,1,3,0)
 ;;=containing a list of record numbers.
 ;;^UTILITY(U,$J,.84,8004,2,0)
 ;;=^^1^1^2931101^^
 ;;^UTILITY(U,$J,.84,8004,2,1,0)
 ;;=Sort using |1|
 ;;^UTILITY(U,$J,.84,8004,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,8004,3,1,0)
 ;;=1^Global reference passed in BY(0)
 ;;^UTILITY(U,$J,.84,8004,5,0)
 ;;=^.841^2^2
 ;;^UTILITY(U,$J,.84,8004,5,1,0)
 ;;=DIP^EN1
 ;;^UTILITY(U,$J,.84,8004,5,2,0)
 ;;=DIS^ENS
 ;;^UTILITY(U,$J,.84,8005,0)
 ;;=8005^2^y^5
 ;;^UTILITY(U,$J,.84,8005,1,0)
 ;;=^^4^4^2940908^^
 ;;^UTILITY(U,$J,.84,8005,1,1,0)
 ;;=At the heading prompt during the FileMan print, the user can enter flags
 ;;^UTILITY(U,$J,.84,8005,1,2,0)
 ;;=to either suppress printing of the header if there are no records to
 ;;^UTILITY(U,$J,.84,8005,1,3,0)
 ;;=print, or to cause the search/sort criteria to print in the header.  This
 ;;^UTILITY(U,$J,.84,8005,1,4,0)
 ;;=is the help prompt.
 ;;^UTILITY(U,$J,.84,8005,2,0)
 ;;=^^11^11^2940908^^^^
 ;;^UTILITY(U,$J,.84,8005,2,1,0)
 ;;=There are two different options:
 ;;^UTILITY(U,$J,.84,8005,2,2,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,8005,2,3,0)
 ;;=1) Accept the default heading or enter a custom heading.
 ;;^UTILITY(U,$J,.84,8005,2,4,0)
 ;;= For no heading at all, type @.
 ;;^UTILITY(U,$J,.84,8005,2,5,0)
 ;;= To use a Print Template for the heading, type [TEMPLATE NAME].
 ;;^UTILITY(U,$J,.84,8005,2,6,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,8005,2,7,0)
 ;;=2) Replace the default heading with:
 ;;^UTILITY(U,$J,.84,8005,2,8,0)
 ;;= S  to Suppress the |1|, and/or
 ;;^UTILITY(U,$J,.84,8005,2,9,0)
 ;;= C  to print |2| Criteria in the heading.
 ;;^UTILITY(U,$J,.84,8005,2,10,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,8005,2,11,0)
 ;;=If S and/or C is entered, the heading prompt will re-appear.
 ;;^UTILITY(U,$J,.84,8005,3,0)
 ;;=^.845^2^2
 ;;^UTILITY(U,$J,.84,8005,3,1,0)
 ;;=1^Text from either entry #8006 or #8007, depending on whether we're coming from the search or print.
 ;;^UTILITY(U,$J,.84,8005,3,2,0)
 ;;=2^Text from either entry #8038 or #8037, depending on whether we're coming from the search or print.
 ;;^UTILITY(U,$J,.84,8005,5,0)
 ;;=^.841^2^2
 ;;^UTILITY(U,$J,.84,8005,5,1,0)
 ;;=DIP^EN1
 ;;^UTILITY(U,$J,.84,8005,5,2,0)
 ;;=DIS^ENS
 ;;^UTILITY(U,$J,.84,8006,0)
 ;;=8006^2^^5
 ;;^UTILITY(U,$J,.84,8006,1,0)
 ;;=^^1^1^2940526^^^^
 ;;^UTILITY(U,$J,.84,8006,1,1,0)
 ;;=Inserted as a parameter to #8005 when called from the SEARCH Option.
 ;;^UTILITY(U,$J,.84,8006,2,0)
 ;;=^^1^1^2940526^^
 ;;^UTILITY(U,$J,.84,8006,2,1,0)
 ;;=Number of Matches from the search
 ;;^UTILITY(U,$J,.84,8006,5,0)
 ;;=^.841^2^2
 ;;^UTILITY(U,$J,.84,8006,5,1,0)
 ;;=DIP^EN1
 ;;^UTILITY(U,$J,.84,8006,5,2,0)
 ;;=DIS^ENS
 ;;^UTILITY(U,$J,.84,8007,0)
 ;;=8007^2^^5
 ;;^UTILITY(U,$J,.84,8007,1,0)
 ;;=^^1^1^2940526^^^^
 ;;^UTILITY(U,$J,.84,8007,1,1,0)
 ;;=Inserted as a parameter to #8005 when called from the PRINT Option.
 ;;^UTILITY(U,$J,.84,8007,2,0)
 ;;=^^1^1^2940526^
 ;;^UTILITY(U,$J,.84,8007,2,1,0)
 ;;=heading when there are no records to print
 ;;^UTILITY(U,$J,.84,8007,5,0)
 ;;=^.841^2^2
 ;;^UTILITY(U,$J,.84,8007,5,1,0)
 ;;=DIP^EN1
 ;;^UTILITY(U,$J,.84,8007,5,2,0)
 ;;=DIS^ENS
 ;;^UTILITY(U,$J,.84,8008,0)
 ;;=8008^2^^5
 ;;^UTILITY(U,$J,.84,8008,1,0)
 ;;=^^4^4^2940908^
 ;;^UTILITY(U,$J,.84,8008,1,1,0)
 ;;=At the HEADING prompt during the FileMan print, the user can enter flags
 ;;^UTILITY(U,$J,.84,8008,1,2,0)
 ;;=to either suppress printing of the header if there are no records to
 ;;^UTILITY(U,$J,.84,8008,1,3,0)
 ;;=print, or to cause the sort criteria to print in the header.  This is the
 ;;^UTILITY(U,$J,.84,8008,1,4,0)
 ;;=prompt for the reader call.
 ;;^UTILITY(U,$J,.84,8008,2,0)
 ;;=^^1^1^2940909^

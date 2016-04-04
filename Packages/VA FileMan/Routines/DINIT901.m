DINIT901 ;GFT/GFT-DIALOG FILE INITS 
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
Q Q
 ;;^UTILITY(U,$J,.84,210,0)
 ;;=210^1^^2
 ;;^UTILITY(U,$J,.84,210,2,0)
 ;;=^^1^1^2991028^
 ;;^UTILITY(U,$J,.84,210,2,1,0)
 ;;=Response must be a positive number
 ;;^UTILITY(U,$J,.84,210,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,210,5,1,0)
 ;;=DIR3
 ;;^UTILITY(U,$J,.84,211,0)
 ;;=211^1^y^2
 ;;^UTILITY(U,$J,.84,211,2,0)
 ;;=^^1^1^2991028^^^
 ;;^UTILITY(U,$J,.84,211,2,1,0)
 ;;=Response must contain no more than |1| decimal digit(s)
 ;;^UTILITY(U,$J,.84,211,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,211,3,1,0)
 ;;=1^Number of decimal digits
 ;;^UTILITY(U,$J,.84,211,5,0)
 ;;=^.841^2^2
 ;;^UTILITY(U,$J,.84,211,5,1,0)
 ;;=DIR3
 ;;^UTILITY(U,$J,.84,211,5,2,0)
 ;;=DIR1
 ;;^UTILITY(U,$J,.84,212,0)
 ;;=212^1^y^2
 ;;^UTILITY(U,$J,.84,212,2,0)
 ;;=^^1^1^2991028^
 ;;^UTILITY(U,$J,.84,212,2,1,0)
 ;;=Response must be no less than |1| and no greater than |2|
 ;;^UTILITY(U,$J,.84,212,3,0)
 ;;=^.845^2^2
 ;;^UTILITY(U,$J,.84,212,3,1,0)
 ;;=1^LOW VALUE
 ;;^UTILITY(U,$J,.84,212,3,2,0)
 ;;=2^HIGH VALUE
 ;;^UTILITY(U,$J,.84,212,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,212,5,1,0)
 ;;=DIR3
 ;;^UTILITY(U,$J,.84,213,0)
 ;;=213^1^y^2
 ;;^UTILITY(U,$J,.84,213,2,0)
 ;;=^^1^1^2991028^^
 ;;^UTILITY(U,$J,.84,213,2,1,0)
 ;;=Response must contain from |1| to |2| characters.
 ;;^UTILITY(U,$J,.84,213,3,0)
 ;;=^.845^2^2
 ;;^UTILITY(U,$J,.84,213,3,1,0)
 ;;=1^SMALLEST NUMBER OF CHARACTERS
 ;;^UTILITY(U,$J,.84,213,3,2,0)
 ;;=2^LARGEST NUMBER OF CHARACTERS
 ;;^UTILITY(U,$J,.84,213,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,213,5,1,0)
 ;;=DIR1^F+2
 ;;^UTILITY(U,$J,.84,214,0)
 ;;=214^1^^2
 ;;^UTILITY(U,$J,.84,214,2,0)
 ;;=^^1^1^2991028^^
 ;;^UTILITY(U,$J,.84,214,2,1,0)
 ;;=Response must not contain embedded uparrows(^).
 ;;^UTILITY(U,$J,.84,214,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,214,5,1,0)
 ;;=DIR1^F+2
 ;;^UTILITY(U,$J,.84,504,0)
 ;;=504^1^y^2
 ;;^UTILITY(U,$J,.84,504,2,0)
 ;;=^^1^1^2991026^
 ;;^UTILITY(U,$J,.84,504,2,1,0)
 ;;='|1|' IS NOT A WORD-PROCESSING FIELD!
 ;;^UTILITY(U,$J,.84,504,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,504,3,1,0)
 ;;=1^NAME OF FIELD
 ;;^UTILITY(U,$J,.84,504,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,504,5,1,0)
 ;;=DIWE3^ACC+3
 ;;^UTILITY(U,$J,.84,1401,0)
 ;;=1401^1^^2
 ;;^UTILITY(U,$J,.84,1401,2,0)
 ;;=^^1^1^2991025^^
 ;;^UTILITY(U,$J,.84,1401,2,1,0)
 ;;=That is not a valid Response.
 ;;^UTILITY(U,$J,.84,1401,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,1401,5,1,0)
 ;;=DIWE3^%+6
 ;;^UTILITY(U,$J,.84,1402,0)
 ;;=1402^1^^2
 ;;^UTILITY(U,$J,.84,1402,2,0)
 ;;=^^1^1^2991025^
 ;;^UTILITY(U,$J,.84,1402,2,1,0)
 ;;=No Record Found.
 ;;^UTILITY(U,$J,.84,1402,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,1402,5,1,0)
 ;;=DIWE3^DIC+2
 ;;^UTILITY(U,$J,.84,1403,0)
 ;;=1403^1^^2
 ;;^UTILITY(U,$J,.84,1403,2,0)
 ;;=^^1^1^2991025^
 ;;^UTILITY(U,$J,.84,1403,2,1,0)
 ;;=There is no text to Transfer.
 ;;^UTILITY(U,$J,.84,1403,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,1403,5,1,0)
 ;;=DIWE3^GET1+3
 ;;^UTILITY(U,$J,.84,1410,0)
 ;;=1410^1^^2
 ;;^UTILITY(U,$J,.84,1410,2,0)
 ;;=^^1^1^2991025^
 ;;^UTILITY(U,$J,.84,1410,2,1,0)
 ;;=You have no READ ACCESS to the File.
 ;;^UTILITY(U,$J,.84,1410,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,1410,5,1,0)
 ;;=DIWE3^ACC
 ;;^UTILITY(U,$J,.84,1509,0)
 ;;=1509^1^^2
 ;;^UTILITY(U,$J,.84,1509,1,0)
 ;;=^^1^1^2990903^
 ;;^UTILITY(U,$J,.84,1509,1,1,0)
 ;;=This Search Template has no search results!
 ;;^UTILITY(U,$J,.84,1509,2,0)
 ;;=^^1^1^2990903^
 ;;^UTILITY(U,$J,.84,1509,2,1,0)
 ;;=This Search Template has no search results!
 ;;^UTILITY(U,$J,.84,1509,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,1509,5,1,0)
 ;;=DIP11^EMPTY
 ;;^UTILITY(U,$J,.84,1510,0)
 ;;=1510^1^^2
 ;;^UTILITY(U,$J,.84,1510,2,0)
 ;;=^^1^1^2991012^
 ;;^UTILITY(U,$J,.84,1510,2,1,0)
 ;;=The START WITH File Number must be less than the GO TO File Number.
 ;;^UTILITY(U,$J,.84,1510,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,1510,5,1,0)
 ;;=DICRW1
 ;;^UTILITY(U,$J,.84,1511,0)
 ;;=1511^1^^2
 ;;^UTILITY(U,$J,.84,1511,2,0)
 ;;=^^1^1^2991012^
 ;;^UTILITY(U,$J,.84,1511,2,1,0)
 ;;=   The START WITH value follows the GO TO value.
 ;;^UTILITY(U,$J,.84,1511,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,1511,5,1,0)
 ;;=DIP100
 ;;^UTILITY(U,$J,.84,1519,0)
 ;;=1519^1^y^2
 ;;^UTILITY(U,$J,.84,1519,2,0)
 ;;=^^1^1^2991002^^
 ;;^UTILITY(U,$J,.84,1519,2,1,0)
 ;;=*** Job stopped because maximum number of SPOOL lines (|1|) has been exceeded ***
 ;;^UTILITY(U,$J,.84,1519,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,1519,3,1,0)
 ;;=1^Maximum number of spool lines
 ;;^UTILITY(U,$J,.84,1519,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,1519,5,1,0)
 ;;=DIO2
 ;;^UTILITY(U,$J,.84,1520,0)
 ;;=1520^1^^2
 ;;^UTILITY(U,$J,.84,1520,2,0)
 ;;=^^2^2^2991028^
 ;;^UTILITY(U,$J,.84,1520,2,1,0)
 ;;=A histogram cannot be displayed.  No SUB-COUNTs were calculated on the last
 ;;^UTILITY(U,$J,.84,1520,2,2,0)
 ;;=Fileman print job from this device.
 ;;^UTILITY(U,$J,.84,1520,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,1520,5,1,0)
 ;;=DIH
 ;;^UTILITY(U,$J,.84,1521,0)
 ;;=1521^1^^2
 ;;^UTILITY(U,$J,.84,1521,2,0)
 ;;=^^2^2^2991028^^
 ;;^UTILITY(U,$J,.84,1521,2,1,0)
 ;;=A scattergram cannot be displayed.  No SUB-SUB-COUNTs were calculated on the last
 ;;^UTILITY(U,$J,.84,1521,2,2,0)
 ;;=Fileman print job from this device.
 ;;^UTILITY(U,$J,.84,1521,5,0)
 ;;=^.841^^0
 ;;^UTILITY(U,$J,.84,1528,0)
 ;;=1528^1^y^2
 ;;^UTILITY(U,$J,.84,1528,2,0)
 ;;=^^1^1^2991002^
 ;;^UTILITY(U,$J,.84,1528,2,1,0)
 ;;=*** TASK |1| stopped by user during Print Execution ***
 ;;^UTILITY(U,$J,.84,1528,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,1528,3,1,0)
 ;;=1^Task Number
 ;;^UTILITY(U,$J,.84,1528,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,1528,5,1,0)
 ;;=DIO2^TASKSTOP
 ;;^UTILITY(U,$J,.84,1529,0)
 ;;=1529^1^y^2
 ;;^UTILITY(U,$J,.84,1529,2,0)
 ;;=^^1^1^2991002^^
 ;;^UTILITY(U,$J,.84,1529,2,1,0)
 ;;=*** TASK |1| stopped by user during Sort Execution ***
 ;;^UTILITY(U,$J,.84,1529,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,1529,3,1,0)
 ;;=1^Task Number
 ;;^UTILITY(U,$J,.84,1529,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,1529,5,1,0)
 ;;=DIO2^TASKSTOP
 ;;^UTILITY(U,$J,.84,7050,0)
 ;;=7050^2^^2
 ;;^UTILITY(U,$J,.84,7050,1,0)
 ;;=^^1^1^2990710^
 ;;^UTILITY(U,$J,.84,7050,1,1,0)
 ;;=ARE YOU SURE?
 ;;^UTILITY(U,$J,.84,7050,2,0)
 ;;=^^1^1^2990710^^
 ;;^UTILITY(U,$J,.84,7050,2,1,0)
 ;;=ARE YOU SURE
 ;;^UTILITY(U,$J,.84,7050,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,7050,5,1,0)
 ;;=DIWE3^YN
 ;;^UTILITY(U,$J,.84,7060,0)
 ;;=7060^2^y^2
 ;;^UTILITY(U,$J,.84,7060,2,0)
 ;;=2
 ;;^UTILITY(U,$J,.84,7060,2,1,0)
 ;;=Within |1|, |2| by
 ;;^UTILITY(U,$J,.84,7060,3,0)
 ;;=^.845^2^2
 ;;^UTILITY(U,$J,.84,7060,3,1,0)
 ;;=1^NAME OF PREVIOUS SORT FIELD
 ;;^UTILITY(U,$J,.84,7060,3,2,0)
 ;;=2^AN IMPERATIVE PHRASE LIKE 'SORT BY'
 ;;^UTILITY(U,$J,.84,7060,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,7060,5,1,0)
 ;;=DIP^EGP
 ;;^UTILITY(U,$J,.84,7061,0)
 ;;=7061^2^y^2
 ;;^UTILITY(U,$J,.84,7061,2,0)
 ;;=^^1^1^2991013^^^
 ;;^UTILITY(U,$J,.84,7061,2,1,0)
 ;;=|1| by
 ;;^UTILITY(U,$J,.84,7061,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,7061,3,1,0)
 ;;=1^THE WORD 'SORT' OR SIMILAR
 ;;^UTILITY(U,$J,.84,7061,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,7061,5,1,0)
 ;;=DIP^BY
 ;;^UTILITY(U,$J,.84,7062,0)
 ;;=7062^2^^2
 ;;^UTILITY(U,$J,.84,7062,2,0)
 ;;=^^1^1^2991013^
 ;;^UTILITY(U,$J,.84,7062,2,1,0)
 ;;=Sort
 ;;^UTILITY(U,$J,.84,7062,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,7062,5,1,0)
 ;;=DIP^SORT
 ;;^UTILITY(U,$J,.84,7063,0)
 ;;=7063^2^y^2
 ;;^UTILITY(U,$J,.84,7063,2,0)
 ;;=^^1^1^2991028^
 ;;^UTILITY(U,$J,.84,7063,2,1,0)
 ;;=|1| Print |2|: 
 ;;^UTILITY(U,$J,.84,7063,3,0)
 ;;=^.845^2^2
 ;;^UTILITY(U,$J,.84,7063,3,1,0)
 ;;=1^'FIRST' OR 'THEN'
 ;;^UTILITY(U,$J,.84,7063,3,2,0)
 ;;=2^'FIELD' or similar
 ;;^UTILITY(U,$J,.84,7063,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,7063,5,1,0)
 ;;=DIP2^2
 ;;^UTILITY(U,$J,.84,7064,0)
 ;;=7064^2^y^2
 ;;^UTILITY(U,$J,.84,7064,2,0)
 ;;=^^1^1^2991028^^
 ;;^UTILITY(U,$J,.84,7064,2,1,0)
 ;;=|1| Export |2|: 
 ;;^UTILITY(U,$J,.84,7064,3,0)
 ;;=^.845^2^2

DINIT907 ;GFT/GFT-DIALOG FILE INITS ;20APR2014
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
Q Q
 ;;^UTILITY(U,$J,.84,9079,2,3,0)
 ;;=-|3|- to be evaluated as "true".
 ;;^UTILITY(U,$J,.84,9079,3,0)
 ;;=^.845^3^3
 ;;^UTILITY(U,$J,.84,9079,3,1,0)
 ;;=1^TRUTH CONDITION IN WORDS
 ;;^UTILITY(U,$J,.84,9079,3,2,0)
 ;;=2^OPERATOR
 ;;^UTILITY(U,$J,.84,9079,3,3,0)
 ;;=3^TRUTH CONDITION LETTER
 ;;^UTILITY(U,$J,.84,9079,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9079,5,1,0)
 ;;=DIQQQ^DIS
 ;;^UTILITY(U,$J,.84,9080,0)
 ;;=9080^3^^2
 ;;^UTILITY(U,$J,.84,9080,2,0)
 ;;=^^1^1^2990710^
 ;;^UTILITY(U,$J,.84,9080,2,1,0)
 ;;=Use EXTERNAL VALUE (from the list on the RIGHT)
 ;;^UTILITY(U,$J,.84,9080,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9080,5,1,0)
 ;;=DIQQQ^DIS
 ;;^UTILITY(U,$J,.84,9081,0)
 ;;=9081^3^y^2
 ;;^UTILITY(U,$J,.84,9081,2,0)
 ;;=^^4^4^2991015^^^^
 ;;^UTILITY(U,$J,.84,9081,2,1,0)
 ;;=To |1| in sequence, starting from a certain |2|,
 ;;^UTILITY(U,$J,.84,9081,2,2,0)
 ;;=type that |2|.  
 ;;^UTILITY(U,$J,.84,9081,2,3,0)
 ;;=   'FIRST' means 'START FROM THE BEGINNING OF THE RANGE OF VALUES'
 ;;^UTILITY(U,$J,.84,9081,2,4,0)
 ;;=   '@' means 'INCLUDE NULL |2| FIELDS'
 ;;^UTILITY(U,$J,.84,9081,2,5,0)
 ;;=   '@' followed by a Computed Expression for |2| to be evaluated at run time, is also allowed
 ;;^UTILITY(U,$J,.84,9081,3,0)
 ;;=^.845^2^2
 ;;^UTILITY(U,$J,.84,9081,3,1,0)
 ;;=1^LIST
 ;;^UTILITY(U,$J,.84,9081,3,2,0)
 ;;=2^ENTRY
 ;;^UTILITY(U,$J,.84,9081,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9081,5,1,0)
 ;;=DIQQ^DIP1F
 ;;^UTILITY(U,$J,.84,9082,0)
 ;;=9082^3^y^2
 ;;^UTILITY(U,$J,.84,9082,2,0)
 ;;=^^4^4^2991015^^^^
 ;;^UTILITY(U,$J,.84,9082,2,1,0)
 ;;=To |1| only up to a certain |2|,
 ;;^UTILITY(U,$J,.84,9082,2,2,0)
 ;;=type that |2|.  
 ;;^UTILITY(U,$J,.84,9082,2,3,0)
 ;;=   'LAST' means 'GO TO THE END OF THE RANGE OF VALUES'
 ;;^UTILITY(U,$J,.84,9082,2,4,0)
 ;;=   '@' means 'INCLUDE NULL |2| FIELDS'
 ;;^UTILITY(U,$J,.84,9082,3,0)
 ;;=^.845^2^2
 ;;^UTILITY(U,$J,.84,9082,3,1,0)
 ;;=1^LIST
 ;;^UTILITY(U,$J,.84,9082,3,2,0)
 ;;=2^ENTRY
 ;;^UTILITY(U,$J,.84,9082,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9082,5,1,0)
 ;;=DIQQ^DIP1T
 ;;^UTILITY(U,$J,.84,9083,0)
 ;;=9083^3^^2
 ;;^UTILITY(U,$J,.84,9083,1,0)
 ;;=^^3^3^2990710^^
 ;;^UTILITY(U,$J,.84,9083,1,1,0)
 ;;=This template may eventually be used with a different 'SORT-BY' sequence.
 ;;^UTILITY(U,$J,.84,9083,1,2,0)
 ;;=Answering 'Y' here insures that, in that case, the user won't have  to
 ;;^UTILITY(U,$J,.84,9083,1,3,0)
 ;;=remember...
 ;;^UTILITY(U,$J,.84,9083,2,0)
 ;;=^^3^3^2990710^^
 ;;^UTILITY(U,$J,.84,9083,2,1,0)
 ;;=This template may eventually be used with a different 'SORT-BY' sequence.
 ;;^UTILITY(U,$J,.84,9083,2,2,0)
 ;;=Answering 'Y' here insures that, in that case, the user won't have
 ;;^UTILITY(U,$J,.84,9083,2,3,0)
 ;;=to remember to type the '@' in order to keep sub-headers from appearing.
 ;;^UTILITY(U,$J,.84,9083,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9083,5,1,0)
 ;;=DIQQQ^DIP21
 ;;^UTILITY(U,$J,.84,9085,0)
 ;;=9085^3^y^2
 ;;^UTILITY(U,$J,.84,9085,2,0)
 ;;=^^3^3^2990710^
 ;;^UTILITY(U,$J,.84,9085,2,1,0)
 ;;=Since you are calling for output on device '|1|',
 ;;^UTILITY(U,$J,.84,9085,2,2,0)
 ;;=you may use the terminal you are now typing on for something else,
 ;;^UTILITY(U,$J,.84,9085,2,3,0)
 ;;=by answering 'Y'.
 ;;^UTILITY(U,$J,.84,9085,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,9085,3,1,0)
 ;;=1^IO DEVICE
 ;;^UTILITY(U,$J,.84,9085,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9085,5,1,0)
 ;;=DIQQ^DIP3
 ;;^UTILITY(U,$J,.84,9086,0)
 ;;=9086^3^^2
 ;;^UTILITY(U,$J,.84,9086,2,0)
 ;;=^^1^1^2990710^^
 ;;^UTILITY(U,$J,.84,9086,2,1,0)
 ;;=If you want page numbering to start at a number higher than 1, type that number.
 ;;^UTILITY(U,$J,.84,9086,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9086,5,1,0)
 ;;=DIQQQ^DIP3
 ;;^UTILITY(U,$J,.84,9108,0)
 ;;=9108^3^^2
 ;;^UTILITY(U,$J,.84,9108,2,0)
 ;;=^^2^2^2990828^
 ;;^UTILITY(U,$J,.84,9108,2,1,0)
 ;;=   If you answer 'N', you"ll be asked to create a formatted display,
 ;;^UTILITY(U,$J,.84,9108,2,2,0)
 ;;=   as in the PRINT Option.
 ;;^UTILITY(U,$J,.84,9108,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9108,5,1,0)
 ;;=DII^O+1
 ;;^UTILITY(U,$J,.84,9109,0)
 ;;=9109^3^^2
 ;;^UTILITY(U,$J,.84,9109,2,0)
 ;;=^^1^1^2990828^
 ;;^UTILITY(U,$J,.84,9109,2,1,0)
 ;;=Answer 'Y' to display the audit trail for each entry.
 ;;^UTILITY(U,$J,.84,9109,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9109,5,1,0)
 ;;=DII
 ;;^UTILITY(U,$J,.84,9110.1,0)
 ;;=9110.1^3^^2
 ;;^UTILITY(U,$J,.84,9110.1,2,0)
 ;;=^^1^1^2990906^
 ;;^UTILITY(U,$J,.84,9110.1,2,1,0)
 ;;=or 012057  (omitting punctuation)
 ;;^UTILITY(U,$J,.84,9110.1,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9110.1,5,1,0)
 ;;=DIEH1
 ;;^UTILITY(U,$J,.84,9110.2,0)
 ;;=9110.2^3^^2
 ;;^UTILITY(U,$J,.84,9110.2,2,0)
 ;;=^^1^1^2990906^
 ;;^UTILITY(U,$J,.84,9110.2,2,1,0)
 ;;=assumes a date in the PAST.
 ;;^UTILITY(U,$J,.84,9110.2,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9110.2,5,1,0)
 ;;=DIEH1
 ;;^UTILITY(U,$J,.84,9110.3,0)
 ;;=9110.3^3^^2
 ;;^UTILITY(U,$J,.84,9110.3,2,0)
 ;;=^^1^1^2990906^
 ;;^UTILITY(U,$J,.84,9110.3,2,1,0)
 ;;=assumes a date in the FUTURE.
 ;;^UTILITY(U,$J,.84,9110.3,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9110.3,5,1,0)
 ;;=DIEH1
 ;;^UTILITY(U,$J,.84,9110.4,0)
 ;;=9110.4^3^^2
 ;;^UTILITY(U,$J,.84,9110.4,2,0)
 ;;=^^1^1^2990906^
 ;;^UTILITY(U,$J,.84,9110.4,2,1,0)
 ;;=uses CURRENT YEAR.
 ;;^UTILITY(U,$J,.84,9110.4,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9110.4,5,1,0)
 ;;=DIEH1
 ;;^UTILITY(U,$J,.84,9110.5,0)
 ;;=9110.5^3^^2
 ;;^UTILITY(U,$J,.84,9110.5,2,0)
 ;;=^^1^1^2990906^^
 ;;^UTILITY(U,$J,.84,9110.5,2,1,0)
 ;;=A 2-digit year means no more than 20 years in the future, or 80 years in the past.
 ;;^UTILITY(U,$J,.84,9110.5,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9110.5,5,1,0)
 ;;=DIEH1
 ;;^UTILITY(U,$J,.84,9110.6,0)
 ;;=9110.6^3^^2
 ;;^UTILITY(U,$J,.84,9110.6,2,0)
 ;;=^^1^1^2990906^
 ;;^UTILITY(U,$J,.84,9110.6,2,1,0)
 ;;=You may omit the precise day of the month, e.g.: Jan, 1957
 ;;^UTILITY(U,$J,.84,9110.6,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9110.6,5,1,0)
 ;;=DIEH1
 ;;^UTILITY(U,$J,.84,9112,0)
 ;;=9112^3^^2
 ;;^UTILITY(U,$J,.84,9112,2,0)
 ;;=^^1^1^2990906^
 ;;^UTILITY(U,$J,.84,9112,2,1,0)
 ;;=Seconds may be entered, as e.g.: 10:30:30  or 103030AM
 ;;^UTILITY(U,$J,.84,9112,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9112,5,1,0)
 ;;=DIEH1
 ;;^UTILITY(U,$J,.84,9113,0)
 ;;=9113^3^^2
 ;;^UTILITY(U,$J,.84,9113,2,0)
 ;;=^^1^1^2990906^
 ;;^UTILITY(U,$J,.84,9113,2,1,0)
 ;;=Time is REQUIRED to be entered.
 ;;^UTILITY(U,$J,.84,9113,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9113,5,1,0)
 ;;=DIEH1
 ;;^UTILITY(U,$J,.84,9114,0)
 ;;=9114^3^y^2
 ;;^UTILITY(U,$J,.84,9114,2,0)
 ;;=^^1^1^2991122^
 ;;^UTILITY(U,$J,.84,9114,2,1,0)
 ;;=ENTER A DATE BETWEEN |1| AND |2|
 ;;^UTILITY(U,$J,.84,9114,3,0)
 ;;=^.845^2^2
 ;;^UTILITY(U,$J,.84,9114,3,1,0)
 ;;=1^EARLIEST DATE
 ;;^UTILITY(U,$J,.84,9114,3,2,0)
 ;;=2^LATEST DATE
 ;;^UTILITY(U,$J,.84,9114,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9114,5,1,0)
 ;;=DIALOGZ
 ;;^UTILITY(U,$J,.84,9114.01,0)
 ;;=9114.01^3^y^2
 ;;^UTILITY(U,$J,.84,9114.01,2,0)
 ;;=^^1^1^2991122^
 ;;^UTILITY(U,$J,.84,9114.01,2,1,0)
 ;;=ENTER A DATE NOT EARLIER THAN |1|
 ;;^UTILITY(U,$J,.84,9114.01,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,9114.01,3,1,0)
 ;;=1^EARLIEST DATE
 ;;^UTILITY(U,$J,.84,9114.01,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9114.01,5,1,0)
 ;;=DIALOGZ
 ;;^UTILITY(U,$J,.84,9114.1,0)
 ;;=9114.1^3^y^2
 ;;^UTILITY(U,$J,.84,9114.1,2,0)
 ;;=^^1^1^2991028^^^
 ;;^UTILITY(U,$J,.84,9114.1,2,1,0)
 ;;=Response must not be previous to |1|
 ;;^UTILITY(U,$J,.84,9114.1,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,9114.1,3,1,0)
 ;;=1^EARLIEST DATE
 ;;^UTILITY(U,$J,.84,9114.1,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9114.1,5,1,0)
 ;;=DIR1^D+3
 ;;^UTILITY(U,$J,.84,9114.2,0)
 ;;=9114.2^3^y^2
 ;;^UTILITY(U,$J,.84,9114.2,2,0)
 ;;=^^1^1^2991028^^
 ;;^UTILITY(U,$J,.84,9114.2,2,1,0)
 ;;=Response must not be later than |1|
 ;;^UTILITY(U,$J,.84,9114.2,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,9114.2,3,1,0)
 ;;=1^LATEST DATE
 ;;^UTILITY(U,$J,.84,9114.2,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9114.2,5,1,0)
 ;;=DIR1^D+4

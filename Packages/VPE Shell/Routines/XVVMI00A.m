XVVMI00A ; ; 04-JAN-2004
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 Q:'DIFQR(19200.114)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,19200.114,14,"WP1",19,0)
 ;;=    Strictly numeric input differs from `-numeric input in that if no
 ;;^UTILITY(U,$J,19200.114,14,"WP1",20,0)
 ;;=    record corresponding to this IEN exists or is selectable, the Finder
 ;;^UTILITY(U,$J,19200.114,14,"WP1",21,0)
 ;;=    proceeds with a regular lookup, using the numeric value to find
 ;;^UTILITY(U,$J,19200.114,14,"WP1",22,0)
 ;;=    matches in the file's indexes. Even used this way, however, numeric
 ;;^UTILITY(U,$J,19200.114,14,"WP1",23,0)
 ;;=    input has the following special restrictions: it is not used as a
 ;;^UTILITY(U,$J,19200.114,14,"WP1",24,0)
 ;;=    lookup value in any indexed pointer or variable pointer field (unless
 ;;^UTILITY(U,$J,19200.114,14,"WP1",25,0)
 ;;=    the Q flag is passed).
 ;;^UTILITY(U,$J,19200.114,15,0)
 ;;=FLAGS
 ;;^UTILITY(U,$J,19200.114,15,"I")
 ;;=FIND^DIC
 ;;^UTILITY(U,$J,19200.114,15,"WP",0)
 ;;=^^5^5^2960521^^^
 ;;^UTILITY(U,$J,19200.114,15,"WP",1,0)
 ;;=--> H=Help
 ;;^UTILITY(U,$J,19200.114,15,"WP",2,0)
 ;;=A=Allow pure numeric input to always be tried as an IEN.
 ;;^UTILITY(U,$J,19200.114,15,"WP",3,0)
 ;;=M=Multiple index lookup allowed. Else only search "B" index.
 ;;^UTILITY(U,$J,19200.114,15,"WP",4,0)
 ;;=Q=Quick lookup. Finder assumes passed value is in internal format.
 ;;^UTILITY(U,$J,19200.114,15,"WP",5,0)
 ;;=O=Only find exact matches if possible.   X=Exact matches only.
 ;;^UTILITY(U,$J,19200.114,15,"WP1",0)
 ;;=^^17^17^2960521^^^^
 ;;^UTILITY(U,$J,19200.114,15,"WP1",1,0)
 ;;=A = Allow pure numeric input to always be tried as an IEN. Normally
 ;;^UTILITY(U,$J,19200.114,15,"WP1",2,0)
 ;;=    the Finder will only try pure numbers as IENs if: 1) the file has
 ;;^UTILITY(U,$J,19200.114,15,"WP1",3,0)
 ;;=    a .001 field, -or- 2) its .01 field is not numeric and the file has
 ;;^UTILITY(U,$J,19200.114,15,"WP1",4,0)
 ;;=    no lookup index.
 ;;^UTILITY(U,$J,19200.114,15,"WP1",5,0)
 ;;=M = Multiple index lookup allowed. If this flag is passed, the Finder
 ;;^UTILITY(U,$J,19200.114,15,"WP1",6,0)
 ;;=    searches all of the file's lookup indexes from B on. If FLAGS does
 ;;^UTILITY(U,$J,19200.114,15,"WP1",7,0)
 ;;=    not contain an M, the Finder only searches the B index.
 ;;^UTILITY(U,$J,19200.114,15,"WP1",8,0)
 ;;=O = Only find exact matches if possible. The Finder first searches for
 ;;^UTILITY(U,$J,19200.114,15,"WP1",9,0)
 ;;=    exact matches; if any are found, it returns all exact matches to the
 ;;^UTILITY(U,$J,19200.114,15,"WP1",10,0)
 ;;=    lookup value. Only if it finds none in the file does it search for
 ;;^UTILITY(U,$J,19200.114,15,"WP1",11,0)
 ;;=    partial matches, returning every partial match.
 ;;^UTILITY(U,$J,19200.114,15,"WP1",12,0)
 ;;=Q = Quick lookup. If this flag is passed, the Finder assumes the passed
 ;;^UTILITY(U,$J,19200.114,15,"WP1",13,0)
 ;;=    value is in internal format. The Finder performs NO transforms of
 ;;^UTILITY(U,$J,19200.114,15,"WP1",14,0)
 ;;=    the input value, but only tries to find the value in the specified
 ;;^UTILITY(U,$J,19200.114,15,"WP1",15,0)
 ;;=    lookup indexes. This lookup is much more efficient.
 ;;^UTILITY(U,$J,19200.114,15,"WP1",16,0)
 ;;=X = Exact matches only. The Finder returns every exact match to the
 ;;^UTILITY(U,$J,19200.114,15,"WP1",17,0)
 ;;=    lookup value. Any partial matches present in the file are ignored.
 ;;^UTILITY(U,$J,19200.114,16,0)
 ;;=NUMBER
 ;;^UTILITY(U,$J,19200.114,16,"I")
 ;;=FIND^DIC
 ;;^UTILITY(U,$J,19200.114,16,"WP",0)
 ;;=^^2^2^2960106^
 ;;^UTILITY(U,$J,19200.114,16,"WP",1,0)
 ;;=The maximum number of entries to find. A value of "*" designates all
 ;;^UTILITY(U,$J,19200.114,16,"WP",2,0)
 ;;=entries (the default).
 ;;^UTILITY(U,$J,19200.114,17,0)
 ;;=INDEXES
 ;;^UTILITY(U,$J,19200.114,17,"I")
 ;;=FIND^DIC
 ;;^UTILITY(U,$J,19200.114,17,"WP",0)
 ;;=^^2^2^2960106^
 ;;^UTILITY(U,$J,19200.114,17,"WP",1,0)
 ;;=The indexes the Finder should search for matches. A list of index
 ;;^UTILITY(U,$J,19200.114,17,"WP",2,0)
 ;;=names separated by "^" characters.
 ;;^UTILITY(U,$J,19200.114,18,0)
 ;;=SCREEN
 ;;^UTILITY(U,$J,19200.114,18,"WP",0)
 ;;=^^3^3^2960117^
 ;;^UTILITY(U,$J,19200.114,18,"WP",1,0)
 ;;=A string of MUMPS code that sets $T to 1 if record should be selected.
 ;;^UTILITY(U,$J,19200.114,18,"WP",2,0)
 ;;=   Naked indicator is set to record's 0-node
 ;;^UTILITY(U,$J,19200.114,18,"WP",3,0)
 ;;=   Y=IEN, Y1=IENS, and Y array=The DA array for this entry.
 ;;^UTILITY(U,$J,19200.114,19,0)
 ;;=IDENTIFIER
 ;;^UTILITY(U,$J,19200.114,19,"WP",0)
 ;;=^^5^5^2960117^
 ;;^UTILITY(U,$J,19200.114,19,"WP",1,0)
 ;;=Text to accompany each found entry to help identify it to end user. This

XVVMI00B ; ; 04-JAN-2004
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 Q:'DIFQR(19200.114)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,19200.114,19,"WP",2,0)
 ;;=should be set to MUMPS code that calls the EN^DDIOL utility to load
 ;;^UTILITY(U,$J,19200.114,19,"WP",3,0)
 ;;=identification text. This code relies upon the same input as the SCREEN
 ;;^UTILITY(U,$J,19200.114,19,"WP",4,0)
 ;;=(Y, Y1, and naked indicator). Returns string with each entry returned as
 ;;^UTILITY(U,$J,19200.114,19,"WP",5,0)
 ;;=a separate node under the "ID","WRITE" nodes of the output array.
 ;;^UTILITY(U,$J,19200.114,20,0)
 ;;=TARGET_ROOT
 ;;^UTILITY(U,$J,19200.114,20,"WP",0)
 ;;=^^4^4^2960614^^
 ;;^UTILITY(U,$J,19200.114,20,"WP",1,0)
 ;;=The array that should receive the output list of found entries. This
 ;;^UTILITY(U,$J,19200.114,20,"WP",2,0)
 ;;=must be a closed array reference and can be either local or global.
 ;;^UTILITY(U,$J,19200.114,20,"WP",3,0)
 ;;=If TARGET_ROOT is not passed, the list is returned descendent from
 ;;^UTILITY(U,$J,19200.114,20,"WP",4,0)
 ;;=^TMP("DILIST",$J).
 ;;^UTILITY(U,$J,19200.114,21,0)
 ;;=MSG_ROOT
 ;;^UTILITY(U,$J,19200.114,21,"WP",0)
 ;;=^^3^3^2960106^
 ;;^UTILITY(U,$J,19200.114,21,"WP",1,0)
 ;;=The array that should receive any error messages. Example: If
 ;;^UTILITY(U,$J,19200.114,21,"WP",2,0)
 ;;=MSG_ROOT="OUT(42)", any errors generated appear in OUT(42,"DIERR").
 ;;^UTILITY(U,$J,19200.114,21,"WP",3,0)
 ;;=Otherwise, errors are returned descendent from ^TMP("DIERR",$J).
 ;;^UTILITY(U,$J,19200.114,22,0)
 ;;=DA
 ;;^UTILITY(U,$J,19200.114,22,"WP",0)
 ;;=^^1^1^2960115^^
 ;;^UTILITY(U,$J,19200.114,22,"WP",1,0)
 ;;=The file entry's internal entry number.
 ;;^UTILITY(U,$J,19200.114,23,0)
 ;;=DA(1)
 ;;^UTILITY(U,$J,19200.114,23,"I")
 ;;=DIK
 ;;^UTILITY(U,$J,19200.114,23,"WP",0)
 ;;=^^2^2^2960115^^^^
 ;;^UTILITY(U,$J,19200.114,23,"WP",1,0)
 ;;=Needed when deleting at lower levels.
 ;;^UTILITY(U,$J,19200.114,23,"WP",2,0)
 ;;=Ex: S DA(1)=1,DA=2,DIK="^EMP("_DA(1)_",""SX"","
 ;;^UTILITY(U,$J,19200.114,24,0)
 ;;=DIK
 ;;^UTILITY(U,$J,19200.114,24,"WP",0)
 ;;=^^1^1^2960107^
 ;;^UTILITY(U,$J,19200.114,24,"WP",1,0)
 ;;=Global root.
 ;;^UTILITY(U,$J,19200.114,25,0)
 ;;=DIE
 ;;^UTILITY(U,$J,19200.114,25,"WP",0)
 ;;=^^1^1^2960115^
 ;;^UTILITY(U,$J,19200.114,25,"WP",1,0)
 ;;=File number or global root.
 ;;^UTILITY(U,$J,19200.114,26,0)
 ;;=DIDEL
 ;;^UTILITY(U,$J,19200.114,26,"WP",0)
 ;;=^^1^1^2960115^^
 ;;^UTILITY(U,$J,19200.114,26,"WP",1,0)
 ;;=Override delete access (Set DIDEL=FileNumber).
 ;;^UTILITY(U,$J,19200.114,27,0)
 ;;=Y
 ;;^UTILITY(U,$J,19200.114,27,"I")
 ;;=Y^DIQ
 ;;^UTILITY(U,$J,19200.114,27,"WP",0)
 ;;=^^1^1^2960108^
 ;;^UTILITY(U,$J,19200.114,27,"WP",1,0)
 ;;=The internal form of the value being converted.
 ;;^UTILITY(U,$J,19200.114,28,0)
 ;;=C
 ;;^UTILITY(U,$J,19200.114,28,"D")
 ;;=$P(^DD(?,?,0),U,2)
 ;;^UTILITY(U,$J,19200.114,28,"I")
 ;;=Y^DIQ
 ;;^UTILITY(U,$J,19200.114,28,"WP",0)
 ;;=^^3^3^2960108^^
 ;;^UTILITY(U,$J,19200.114,28,"WP",1,0)
 ;;=The 2nd piece of the zero node of the data dictionary which defines
 ;;^UTILITY(U,$J,19200.114,28,"WP",2,0)
 ;;=that element. To correctly set the naked global reference do:
 ;;^UTILITY(U,$J,19200.114,28,"WP",3,0)
 ;;=      S C=$P(^DD(File#,Field#,0),U,2)
 ;;^UTILITY(U,$J,19200.114,29,0)
 ;;=DIC
 ;;^UTILITY(U,$J,19200.114,29,"WP",0)
 ;;=^^1^1^2960114^^^
 ;;^UTILITY(U,$J,19200.114,29,"WP",1,0)
 ;;=The global root or file number.
 ;;^UTILITY(U,$J,19200.114,30,0)
 ;;=DR
 ;;^UTILITY(U,$J,19200.114,30,"I")
 ;;=DIQ
 ;;^UTILITY(U,$J,19200.114,30,"WP",0)
 ;;=^^4^4^2960115^^
 ;;^UTILITY(U,$J,19200.114,30,"WP",1,0)
 ;;=Names the global subscript(s) which are to be displayed. Enter ":" for
 ;;^UTILITY(U,$J,19200.114,30,"WP",2,0)
 ;;=a range of subscripts. All data fields stored within, and descendent from,
 ;;^UTILITY(U,$J,19200.114,30,"WP",3,0)
 ;;=the subscript(s) will be displayed. If DR is not defined, all fields are
 ;;^UTILITY(U,$J,19200.114,30,"WP",4,0)
 ;;=displayed.
 ;;^UTILITY(U,$J,19200.114,31,0)
 ;;=DIQ(0)
 ;;^UTILITY(U,$J,19200.114,31,"WP",0)
 ;;=^^3^3^2960108^
 ;;^UTILITY(U,$J,19200.114,31,"WP",1,0)
 ;;=C=Display computed fields
 ;;^UTILITY(U,$J,19200.114,31,"WP",2,0)
 ;;=A=Display audit records for the entry
 ;;^UTILITY(U,$J,19200.114,31,"WP",3,0)
 ;;=R=Display entry's IEN.
 ;;^UTILITY(U,$J,19200.114,32,0)
 ;;=VALUE
 ;;^UTILITY(U,$J,19200.114,32,"I")
 ;;=EN^DDIOL
 ;;^UTILITY(U,$J,19200.114,32,"WP",0)
 ;;=^^3^3^2960108^
 ;;^UTILITY(U,$J,19200.114,32,"WP",1,0)
 ;;=If just 1 line of text place here. It can be a string, numeric literal,
 ;;^UTILITY(U,$J,19200.114,32,"WP",2,0)
 ;;=or variable. If more than 1 line of text, enter .ARRAY, where text is

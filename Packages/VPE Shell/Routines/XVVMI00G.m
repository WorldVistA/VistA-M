XVVMI00G ; ; 04-JAN-2004
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 Q:'DIFQR(19200.114)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,19200.114,58,"WP1",17,0)
 ;;= 
 ;;^UTILITY(U,$J,19200.114,58,"WP1",18,0)
 ;;=S P E C I F I E R S
 ;;^UTILITY(U,$J,19200.114,58,"WP1",19,0)
 ;;=You can include specifiers in the DR string:
 ;;^UTILITY(U,$J,19200.114,58,"WP1",20,0)
 ;;=       T = Use Title of field rather than field label.
 ;;^UTILITY(U,$J,19200.114,58,"WP1",21,0)
 ;;=   "xxx" = Literal enclosed in quotes. Used as the prompt rather than
 ;;^UTILITY(U,$J,19200.114,58,"WP1",22,0)
 ;;=           field label.
 ;;^UTILITY(U,$J,19200.114,58,"WP1",23,0)
 ;;=     DUP = Duplicate the response to this field from entry to entry.
 ;;^UTILITY(U,$J,19200.114,58,"WP1",24,0)
 ;;=     REQ = Require an answer to the field.
 ;;^UTILITY(U,$J,19200.114,58,"WP1",25,0)
 ;;= 
 ;;^UTILITY(U,$J,19200.114,58,"WP1",26,0)
 ;;=Using field #3 as an example:
 ;;^UTILITY(U,$J,19200.114,58,"WP1",27,0)
 ;;=      3T = Title......The T immediately follows the field number.
 ;;^UTILITY(U,$J,19200.114,58,"WP1",28,0)
 ;;=    3xxx = Literal....No quotes.
 ;;^UTILITY(U,$J,19200.114,58,"WP1",29,0)
 ;;=      3d = Duplicate..Lowercase D.
 ;;^UTILITY(U,$J,19200.114,58,"WP1",30,0)
 ;;=      3R = Required...Uppercase R
 ;;^UTILITY(U,$J,19200.114,58,"WP1",31,0)
 ;;=You can combine specifiers by separating with a "~".
 ;;^UTILITY(U,$J,19200.114,58,"WP1",32,0)
 ;;= 
 ;;^UTILITY(U,$J,19200.114,58,"WP1",33,0)
 ;;=B R A N C H I N G   L O G I C
 ;;^UTILITY(U,$J,19200.114,58,"WP1",34,0)
 ;;=You can include branching logic within DR. This done by inserting an
 ;;^UTILITY(U,$J,19200.114,58,"WP1",35,0)
 ;;=executable MUMPS statement in one of the semicolon-pieces. This code will
 ;;^UTILITY(U,$J,19200.114,58,"WP1",36,0)
 ;;=be executed when this piece is encountered by the DIE routine. If the
 ;;^UTILITY(U,$J,19200.114,58,"WP1",37,0)
 ;;=MUMPS code sets the variable Y, DIE will jump to the field whose number
 ;;^UTILITY(U,$J,19200.114,58,"WP1",38,0)
 ;;=(or label) matches Y. The field must be specified elsewhere within the
 ;;^UTILITY(U,$J,19200.114,58,"WP1",39,0)
 ;;=DR variable. Y may look like a place holder, e.g. @1. If Y is set to zero
 ;;^UTILITY(U,$J,19200.114,58,"WP1",40,0)
 ;;=or null, DIE will exit. If Y is killed or never set, no branching will
 ;;^UTILITY(U,$J,19200.114,58,"WP1",41,0)
 ;;=occur. X will be equal to the internal value of the field previously
 ;;^UTILITY(U,$J,19200.114,58,"WP1",42,0)
 ;;=asked.
 ;;^UTILITY(U,$J,19200.114,58,"WP1",43,0)
 ;;=Example: S DR="4;I X=""YES"" S Y=10;.01;10:15"
 ;;^UTILITY(U,$J,19200.114,58,"WP1",44,0)
 ;;= 
 ;;^UTILITY(U,$J,19200.114,58,"WP1",45,0)
 ;;=S P E C I F I C   F I E L D S   I N   A   M U L T I P L E
 ;;^UTILITY(U,$J,19200.114,58,"WP1",46,0)
 ;;=If you want to edit only selected fields in a multiple, set DR normally
 ;;^UTILITY(U,$J,19200.114,58,"WP1",47,0)
 ;;=and then set a subscripted value of Dr equal to the sub-fields to edit.
 ;;^UTILITY(U,$J,19200.114,58,"WP1",48,0)
 ;;=Example: S DR="5",DR(2,16001.02)=".01;7"
 ;;^UTILITY(U,$J,19200.114,58,"WP1",49,0)
 ;;=         Where 2 means the 2nd level of the file, and the 2nd subscript
 ;;^UTILITY(U,$J,19200.114,58,"WP1",50,0)
 ;;=         is the subfile number of the multiple field (#5).
 ;;^UTILITY(U,$J,19200.114,58,"WP1",51,0)
 ;;= 
 ;;^UTILITY(U,$J,19200.114,58,"WP1",52,0)
 ;;=C O N T I N U E D   D R   S T R I N G S
 ;;^UTILITY(U,$J,19200.114,58,"WP1",53,0)
 ;;=If there is more than 245 characters in a DR-string, you can set
 ;;^UTILITY(U,$J,19200.114,58,"WP1",54,0)
 ;;=continuation strings by defining the DR-array at the 3rd subscript
 ;;^UTILITY(U,$J,19200.114,58,"WP1",55,0)
 ;;=level. These subscripts should be sequential integers starting at 1.
 ;;^UTILITY(U,$J,19200.114,58,"WP1",56,0)
 ;;=Example: The 1st continuation node of DR(2,16001.02) would be
 ;;^UTILITY(U,$J,19200.114,58,"WP1",57,0)
 ;;=         DR(2,160001.02,1).
 ;;^UTILITY(U,$J,19200.114,59,0)
 ;;=DIE('NO~')
 ;;^UTILITY(U,$J,19200.114,59,"I")
 ;;=DIE
 ;;^UTILITY(U,$J,19200.114,59,"WP",0)
 ;;=^^5^5^2960115^
 ;;^UTILITY(U,$J,19200.114,59,"WP",1,0)
 ;;=DIE("NO^") variable:
 ;;^UTILITY(U,$J,19200.114,59,"WP",2,0)
 ;;=   "OUTOK"          Exiting YES        Jumping NO
 ;;^UTILITY(U,$J,19200.114,59,"WP",3,0)
 ;;=   "BACK"           Exiting NO    Jumping back YES
 ;;^UTILITY(U,$J,19200.114,59,"WP",4,0)
 ;;=   "BACKOUTOK"      Exiting YES   Jumping back YES
 ;;^UTILITY(U,$J,19200.114,59,"WP",5,0)
 ;;=   "Other value"    Exiting NO         Jumping NO
 ;;^UTILITY(U,$J,19200.114,60,0)
 ;;=DA(1)
 ;;^UTILITY(U,$J,19200.114,60,"I")
 ;;=DIE
 ;;^UTILITY(U,$J,19200.114,60,"WP",0)
 ;;=^^2^2^2960115^

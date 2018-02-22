XVVMI00F ; ; 04-JAN-2004
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 Q:'DIFQR(19200.114)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,19200.114,53,0)
 ;;=DIC
 ;;^UTILITY(U,$J,19200.114,53,"I")
 ;;=FILE^DICN
 ;;^UTILITY(U,$J,19200.114,53,"WP",0)
 ;;=^^4^4^2960114^
 ;;^UTILITY(U,$J,19200.114,53,"WP",1,0)
 ;;=The global root or file number.
 ;;^UTILITY(U,$J,19200.114,53,"WP",2,0)
 ;;=You MUST kill DD variable PRIOR to calling FILE^DICN. If DO does not
 ;;^UTILITY(U,$J,19200.114,53,"WP",3,0)
 ;;=contain the characteristics of the file you are adding to, then DO
 ;;^UTILITY(U,$J,19200.114,53,"WP",4,0)
 ;;=should be killed also. NOTE: This variable is D with the letter O.
 ;;^UTILITY(U,$J,19200.114,54,0)
 ;;=%
 ;;^UTILITY(U,$J,19200.114,54,"I")
 ;;=YN^DICN
 ;;^UTILITY(U,$J,19200.114,54,"WP",0)
 ;;=^^4^4^2960517^^
 ;;^UTILITY(U,$J,19200.114,54,"WP",1,0)
 ;;=--> H=Help
 ;;^UTILITY(U,$J,19200.114,54,"WP",2,0)
 ;;=The default response:   %=0  No default
 ;;^UTILITY(U,$J,19200.114,54,"WP",3,0)
 ;;=                        %=1  YES
 ;;^UTILITY(U,$J,19200.114,54,"WP",4,0)
 ;;=                        %=2 (NO)
 ;;^UTILITY(U,$J,19200.114,54,"WP1",0)
 ;;=^^8^8^2960115^^^
 ;;^UTILITY(U,$J,19200.114,54,"WP1",1,0)
 ;;= Output Variables:
 ;;^UTILITY(U,$J,19200.114,54,"WP1",2,0)
 ;;=    %    %=-1  User entered "^"
 ;;^UTILITY(U,$J,19200.114,54,"WP1",3,0)
 ;;=         %=0   User entered <RET> when no default was presented
 ;;^UTILITY(U,$J,19200.114,54,"WP1",4,0)
 ;;=               User entered "?"
 ;;^UTILITY(U,$J,19200.114,54,"WP1",5,0)
 ;;=         %=1   User entered YES
 ;;^UTILITY(U,$J,19200.114,54,"WP1",6,0)
 ;;=         %=2   User entered NO
 ;;^UTILITY(U,$J,19200.114,54,"WP1",7,0)
 ;;= 
 ;;^UTILITY(U,$J,19200.114,54,"WP1",8,0)
 ;;=   %Y = The actual text that the user entered.
 ;;^UTILITY(U,$J,19200.114,55,0)
 ;;=D
 ;;^UTILITY(U,$J,19200.114,55,"D")
 ;;="B"
 ;;^UTILITY(U,$J,19200.114,55,"I")
 ;;=DQ^DICQ
 ;;^UTILITY(U,$J,19200.114,55,"WP",0)
 ;;=^^1^1^2960114^^
 ;;^UTILITY(U,$J,19200.114,55,"WP",1,0)
 ;;=Set to "B".
 ;;^UTILITY(U,$J,19200.114,56,0)
 ;;=DZ
 ;;^UTILITY(U,$J,19200.114,56,"D")
 ;;="??"
 ;;^UTILITY(U,$J,19200.114,56,"WP",0)
 ;;=^^2^2^2960114^
 ;;^UTILITY(U,$J,19200.114,56,"WP",1,0)
 ;;=Set to "??". This is set in order to prevent FM from issuing the
 ;;^UTILITY(U,$J,19200.114,56,"WP",2,0)
 ;;="DO YOU WANT TO SEE ALL nn ENTRIES?" prompt.
 ;;^UTILITY(U,$J,19200.114,57,0)
 ;;=DIFORMAT
 ;;^UTILITY(U,$J,19200.114,57,"WP",0)
 ;;=^^3^3^2960114^
 ;;^UTILITY(U,$J,19200.114,57,"WP",1,0)
 ;;=Equal to the desired data dictionary listing format:
 ;;^UTILITY(U,$J,19200.114,57,"WP",2,0)
 ;;=  STANDARD            BRIEF               MODIFIED STANDARD
 ;;^UTILITY(U,$J,19200.114,57,"WP",3,0)
 ;;=  TEMPLATES ONLY      GLOBAL MAP          CONDENSED
 ;;^UTILITY(U,$J,19200.114,58,0)
 ;;=DR
 ;;^UTILITY(U,$J,19200.114,58,"I")
 ;;=DIE
 ;;^UTILITY(U,$J,19200.114,58,"WP",0)
 ;;=^^2^2^2960115^^^
 ;;^UTILITY(U,$J,19200.114,58,"WP",1,0)
 ;;=--> H=Help
 ;;^UTILITY(U,$J,19200.114,58,"WP",2,0)
 ;;=A string specifying data fields to be asked.
 ;;^UTILITY(U,$J,19200.114,58,"WP1",0)
 ;;=^^57^57^2960115^
 ;;^UTILITY(U,$J,19200.114,58,"WP1",1,0)
 ;;=The DR string consists of the following:
 ;;^UTILITY(U,$J,19200.114,58,"WP1",2,0)
 ;;=  o  A single number corresponding to the IEN of a field in the file.
 ;;^UTILITY(U,$J,19200.114,58,"WP1",3,0)
 ;;=  o  A field number followed by "//" and a default prompt.
 ;;^UTILITY(U,$J,19200.114,58,"WP1",4,0)
 ;;=  o  A fild number followed by "///" and a value. The value should be
 ;;^UTILITY(U,$J,19200.114,58,"WP1",5,0)
 ;;=     in the external form of the field's value. The value will be
 ;;^UTILITY(U,$J,19200.114,58,"WP1",6,0)
 ;;=     automatically inserted into the data base after passing through the
 ;;^UTILITY(U,$J,19200.114,58,"WP1",7,0)
 ;;=     input transform. You may pass the value contained in a variable. In
 ;;^UTILITY(U,$J,19200.114,58,"WP1",8,0)
 ;;=     that case use: "S DR=27///^S X=VAR"
 ;;^UTILITY(U,$J,19200.114,58,"WP1",9,0)
 ;;=  o  A field followed by "////" and a value. The value will be inserted
 ;;^UTILITY(U,$J,19200.114,58,"WP1",10,0)
 ;;=     WITHOUT VALIDATION into the data base. The value should be in its
 ;;^UTILITY(U,$J,19200.114,58,"WP1",11,0)
 ;;=     internally stored form. Cannot be used for .01 fields.
 ;;^UTILITY(U,$J,19200.114,58,"WP1",12,0)
 ;;=  o  A range of field numbers, in the form M:N.
 ;;^UTILITY(U,$J,19200.114,58,"WP1",13,0)
 ;;=  o  A place-holder like @1.
 ;;^UTILITY(U,$J,19200.114,58,"WP1",14,0)
 ;;=  o  A line of MUMPS code.
 ;;^UTILITY(U,$J,19200.114,58,"WP1",15,0)
 ;;=  o  A sequence of any of the above, separated by ";".
 ;;^UTILITY(U,$J,19200.114,58,"WP1",16,0)
 ;;=  o  An input templete enclosed in "[]".

XVVMI00C ; ; 04-JAN-2004
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 Q:'DIFQR(19200.114)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,19200.114,32,"WP",3,0)
 ;;=stored in ARRAY(1),ARRAY(2), etc.
 ;;^UTILITY(U,$J,19200.114,33,0)
 ;;=GLOBAL ROOT
 ;;^UTILITY(U,$J,19200.114,33,"WP",0)
 ;;=^^5^5^2960108^
 ;;^UTILITY(U,$J,19200.114,33,"WP",1,0)
 ;;=An alternate way to pass text is in a global root. The VALUE parameter is
 ;;^UTILITY(U,$J,19200.114,33,"WP",2,0)
 ;;=null and GLOBAL ROOT contains the name of the global root that contains
 ;;^UTILITY(U,$J,19200.114,33,"WP",3,0)
 ;;=the text. Example: ^GLB(1)=Text,^GLB(2)=Text GLOBAL ROOT="^GLB"
 ;;^UTILITY(U,$J,19200.114,33,"WP",4,0)
 ;;=Put formatting instructions in "F" nodes descendent from the node
 ;;^UTILITY(U,$J,19200.114,33,"WP",5,0)
 ;;=containing text. Example: A(1)="Text", A(1,"F")="!?5"
 ;;^UTILITY(U,$J,19200.114,34,0)
 ;;=FORMAT
 ;;^UTILITY(U,$J,19200.114,34,"WP",0)
 ;;=^^2^2^2960108^
 ;;^UTILITY(U,$J,19200.114,34,"WP",1,0)
 ;;=Formatting instructions. Only use when VALUE parameter is used.
 ;;^UTILITY(U,$J,19200.114,34,"WP",2,0)
 ;;=Example: FORMAT="!!!?4"
 ;;^UTILITY(U,$J,19200.114,35,0)
 ;;=DIFILE
 ;;^UTILITY(U,$J,19200.114,35,"WP",0)
 ;;=^^1^1^2960108^
 ;;^UTILITY(U,$J,19200.114,35,"WP",1,0)
 ;;=The file number.
 ;;^UTILITY(U,$J,19200.114,36,0)
 ;;=DIAC
 ;;^UTILITY(U,$J,19200.114,36,"WP",0)
 ;;=^^4^4^2960115^^^
 ;;^UTILITY(U,$J,19200.114,36,"WP",1,0)
 ;;=Use one of the values listed below. Returns DIAC=0 or 1
 ;;^UTILITY(U,$J,19200.114,36,"WP",2,0)
 ;;=                  "RD"=Read         "WR"=Write
 ;;^UTILITY(U,$J,19200.114,36,"WP",3,0)
 ;;=               "AUDIT"=Audit        "DD"=Data Dictionary  
 ;;^UTILITY(U,$J,19200.114,36,"WP",4,0)
 ;;=                 "DEL"=Delete    "LAYGO"=Laygo
 ;;^UTILITY(U,$J,19200.114,37,0)
 ;;=DIC(0)
 ;;^UTILITY(U,$J,19200.114,37,"I")
 ;;=DIC
 ;;^UTILITY(U,$J,19200.114,37,"WP",0)
 ;;=^^2^2^2960115^
 ;;^UTILITY(U,$J,19200.114,37,"WP",1,0)
 ;;=--> H=HELP
 ;;^UTILITY(U,$J,19200.114,37,"WP",2,0)
 ;;=A string of alpha characters which alter how the program responds.
 ;;^UTILITY(U,$J,19200.114,37,"WP1",0)
 ;;=^^43^43^2960115^^^^
 ;;^UTILITY(U,$J,19200.114,37,"WP1",1,0)
 ;;=A = Ask the entry
 ;;^UTILITY(U,$J,19200.114,37,"WP1",2,0)
 ;;=    If DIC(0) does not contain A, the input to DIC is assumed to be in
 ;;^UTILITY(U,$J,19200.114,37,"WP1",3,0)
 ;;=    the variable X.
 ;;^UTILITY(U,$J,19200.114,37,"WP1",4,0)
 ;;=C = Xref suppression
 ;;^UTILITY(U,$J,19200.114,37,"WP1",5,0)
 ;;=    When DIC does a lookup and finds an entry that matches the input,
 ;;^UTILITY(U,$J,19200.114,37,"WP1",6,0)
 ;;=    that entry is presented to the user only once even if the entry
 ;;^UTILITY(U,$J,19200.114,37,"WP1",7,0)
 ;;=    appears in more than one cross reference. This is called cross
 ;;^UTILITY(U,$J,19200.114,37,"WP1",8,0)
 ;;=    reference suppression. It can be overridden by including a C in
 ;;^UTILITY(U,$J,19200.114,37,"WP1",9,0)
 ;;=    DIC(0).
 ;;^UTILITY(U,$J,19200.114,37,"WP1",10,0)
 ;;=E = Echo back information
 ;;^UTILITY(U,$J,19200.114,37,"WP1",11,0)
 ;;=    The file entry names that match the input will be echoed back to the
 ;;^UTILITY(U,$J,19200.114,37,"WP1",12,0)
 ;;=    terminal.
 ;;^UTILITY(U,$J,19200.114,37,"WP1",13,0)
 ;;=F = Forget lookup value.
 ;;^UTILITY(U,$J,19200.114,37,"WP1",14,0)
 ;;=    If an entry is found, the entry number gets saved in the ^DISV global.
 ;;^UTILITY(U,$J,19200.114,37,"WP1",15,0)
 ;;=    ^DISV(DUZ,DIC) is set equal to the entry number. This allows the user
 ;;^UTILITY(U,$J,19200.114,37,"WP1",16,0)
 ;;=    to do a subsequent lookup of the same entry by pressing <SPACE BAR>,
 ;;^UTILITY(U,$J,19200.114,37,"WP1",17,0)
 ;;=    <RET>. To suppress this, include F in DIC(0).
 ;;^UTILITY(U,$J,19200.114,37,"WP1",18,0)
 ;;=I = Ignore special lookup program
 ;;^UTILITY(U,$J,19200.114,37,"WP1",19,0)
 ;;=    Any special user written lookup program will be ignored and DIC will
 ;;^UTILITY(U,$J,19200.114,37,"WP1",20,0)
 ;;=    proceed with its normal lookup process.
 ;;^UTILITY(U,$J,19200.114,37,"WP1",21,0)
 ;;=L = LAYGO allowed
 ;;^UTILITY(U,$J,19200.114,37,"WP1",22,0)
 ;;=    Allow user to add a new entry to the file.
 ;;^UTILITY(U,$J,19200.114,37,"WP1",23,0)
 ;;=M = Multiple-index lookup allowed
 ;;^UTILITY(U,$J,19200.114,37,"WP1",24,0)
 ;;=N = IEN lookup allowed
 ;;^UTILITY(U,$J,19200.114,37,"WP1",25,0)
 ;;=O = Only find 1 entry if it matches exactly
 ;;^UTILITY(U,$J,19200.114,37,"WP1",26,0)
 ;;=    If there is an exact match for the lookup value, only the entry that
 ;;^UTILITY(U,$J,19200.114,37,"WP1",27,0)
 ;;=    matches exactly will be selected.
 ;;^UTILITY(U,$J,19200.114,37,"WP1",28,0)
 ;;=Q = Question erroneous input

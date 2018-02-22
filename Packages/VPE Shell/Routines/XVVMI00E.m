XVVMI00E ; ; 04-JAN-2004
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 Q:'DIFQR(19200.114)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,19200.114,43,"WP1",8,0)
 ;;=multiple field's definition in the DD.
 ;;^UTILITY(U,$J,19200.114,43,"WP1",9,0)
 ;;= 
 ;;^UTILITY(U,$J,19200.114,43,"WP1",10,0)
 ;;=Example:  S DIC("P")=$P(^DD(16150,9,0),"^",2)
 ;;^UTILITY(U,$J,19200.114,44,0)
 ;;=DIC('V')
 ;;^UTILITY(U,$J,19200.114,44,"WP",0)
 ;;=^^3^3^2960115^
 ;;^UTILITY(U,$J,19200.114,44,"WP",1,0)
 ;;=--> H=Help
 ;;^UTILITY(U,$J,19200.114,44,"WP",2,0)
 ;;=If .01 field is a variable pointer, you can restrict users from inputting
 ;;^UTILITY(U,$J,19200.114,44,"WP",3,0)
 ;;=entries from certain files by setting DIC("V").
 ;;^UTILITY(U,$J,19200.114,44,"WP1",0)
 ;;=^^7^7^2960115^^^
 ;;^UTILITY(U,$J,19200.114,44,"WP1",1,0)
 ;;=If the .01 field is a variable pointer, it can point to entries in more
 ;;^UTILITY(U,$J,19200.114,44,"WP1",2,0)
 ;;=than one file. You can restrict the user's ability to input entries from
 ;;^UTILITY(U,$J,19200.114,44,"WP1",3,0)
 ;;=certain files by using the DIC("V") variable. It is used to screen files
 ;;^UTILITY(U,$J,19200.114,44,"WP1",4,0)
 ;;=from the user. The variable is set equal to a line of MUMPS code that will
 ;;^UTILITY(U,$J,19200.114,44,"WP1",5,0)
 ;;=return a truth value when executed. The code is executed after someone
 ;;^UTILITY(U,$J,19200.114,44,"WP1",6,0)
 ;;=enters data into a variable pointer field. If the code tests false, the
 ;;^UTILITY(U,$J,19200.114,44,"WP1",7,0)
 ;;=user's input is rejected.
 ;;^UTILITY(U,$J,19200.114,45,0)
 ;;=DTIME
 ;;^UTILITY(U,$J,19200.114,45,"WP",0)
 ;;=^^1^1^2960113^
 ;;^UTILITY(U,$J,19200.114,45,"WP",1,0)
 ;;=Number of seconds for timeout. DTOUT=1 is returned.
 ;;^UTILITY(U,$J,19200.114,46,0)
 ;;=DLAYGO
 ;;^UTILITY(U,$J,19200.114,46,"WP",0)
 ;;=^^3^3^2960113^
 ;;^UTILITY(U,$J,19200.114,46,"WP",1,0)
 ;;=If set equal to file number, then user will be able to add a new entry
 ;;^UTILITY(U,$J,19200.114,46,"WP",2,0)
 ;;=to the file whether or not they have LAYGO access to the file. DIC(0)
 ;;^UTILITY(U,$J,19200.114,46,"WP",3,0)
 ;;=must also contain "L".
 ;;^UTILITY(U,$J,19200.114,47,0)
 ;;=X
 ;;^UTILITY(U,$J,19200.114,47,"I")
 ;;=DIC
 ;;^UTILITY(U,$J,19200.114,47,"WP",0)
 ;;=^^3^3^2960114^^
 ;;^UTILITY(U,$J,19200.114,47,"WP",1,0)
 ;;=If DIC(0) does not contain an A, then the variable X must be defined
 ;;^UTILITY(U,$J,19200.114,47,"WP",2,0)
 ;;=equal to the value you want to lookup. If the value in X has more than
 ;;^UTILITY(U,$J,19200.114,47,"WP",3,0)
 ;;=one match or partial match, the lookup fails and Y=-1 is returned.
 ;;^UTILITY(U,$J,19200.114,48,0)
 ;;=DA(1)
 ;;^UTILITY(U,$J,19200.114,48,"I")
 ;;=DIC
 ;;^UTILITY(U,$J,19200.114,48,"WP",0)
 ;;=^^5^5^2960113^
 ;;^UTILITY(U,$J,19200.114,48,"WP",1,0)
 ;;=Use to add new subentries to a multiple. DIC(0) would contain 'L'.
 ;;^UTILITY(U,$J,19200.114,48,"WP",2,0)
 ;;=DA(1)=IEN of the entry to which the subentry is to be added.
 ;;^UTILITY(U,$J,19200.114,48,"WP",3,0)
 ;;=  S DIC=DIC_DA(1)_",4," ;..............The root of the subfile
 ;;^UTILITY(U,$J,19200.114,48,"WP",4,0)
 ;;=  S DIC("P")=$P(^DD(16150,9,0),"^",2) ;Return subfile# & specifiers
 ;;^UTILITY(U,$J,19200.114,48,"WP",5,0)
 ;;=  D ^DIC
 ;;^UTILITY(U,$J,19200.114,49,0)
 ;;=D
 ;;^UTILITY(U,$J,19200.114,49,"WP",0)
 ;;=^^2^2^2960114^^
 ;;^UTILITY(U,$J,19200.114,49,"WP",1,0)
 ;;=List of xrefs to be searched (separated by "^").
 ;;^UTILITY(U,$J,19200.114,49,"WP",2,0)
 ;;=Example: D="B^SSN^C"
 ;;^UTILITY(U,$J,19200.114,50,0)
 ;;=X
 ;;^UTILITY(U,$J,19200.114,50,"I")
 ;;=FILE^DICN
 ;;^UTILITY(U,$J,19200.114,50,"WP",0)
 ;;=^^3^3^2960114^
 ;;^UTILITY(U,$J,19200.114,50,"WP",1,0)
 ;;=The value of the .01 field that is to be added to the file. The
 ;;^UTILITY(U,$J,19200.114,50,"WP",2,0)
 ;;=programmer has to ensure that the value meets all the criteria
 ;;^UTILITY(U,$J,19200.114,50,"WP",3,0)
 ;;=described in the input transform.
 ;;^UTILITY(U,$J,19200.114,51,0)
 ;;=DINUM
 ;;^UTILITY(U,$J,19200.114,51,"WP",0)
 ;;=^^2^2^2960114^
 ;;^UTILITY(U,$J,19200.114,51,"WP",1,0)
 ;;=The IEN of the new entry. Must be a canonic number and no data can
 ;;^UTILITY(U,$J,19200.114,51,"WP",2,0)
 ;;=exist in the global at this subscript location.
 ;;^UTILITY(U,$J,19200.114,52,0)
 ;;=DIC('DR')
 ;;^UTILITY(U,$J,19200.114,52,"I")
 ;;=FILE^DICN
 ;;^UTILITY(U,$J,19200.114,52,"WP",0)
 ;;=^^3^3^2960114^
 ;;^UTILITY(U,$J,19200.114,52,"WP",1,0)
 ;;=Used to input other data elements at the time of adding the entry.
 ;;^UTILITY(U,$J,19200.114,52,"WP",2,0)
 ;;=If the user does not enter these elements, the entry will not be
 ;;^UTILITY(U,$J,19200.114,52,"WP",3,0)
 ;;=added. The format is the same as DR when making a DIE call.

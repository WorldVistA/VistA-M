XVVMI00I ; ; 04-JAN-2004
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 Q:'DIFQR(19200.114)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,19200.114,65,"WP1",11,0)
 ;;=   and sets ORIEN(1)=1701, the Updater will try to assign record number
 ;;^UTILITY(U,$J,19200.114,65,"WP1",12,0)
 ;;=   1701 to the new record denoted by the "+1" value in the FDA subscripts.
 ;;^UTILITY(U,$J,19200.114,65,"WP1",13,0)
 ;;= 
 ;;^UTILITY(U,$J,19200.114,65,"WP1",14,0)
 ;;=   This feature also affects LAYGO Finding nodes. When these nodes result
 ;;^UTILITY(U,$J,19200.114,65,"WP1",15,0)
 ;;=   in adding a new record, the Updater will check the IEN Array to see if
 ;;^UTILITY(U,$J,19200.114,65,"WP1",16,0)
 ;;=   the application wants to place the new record at a specific record
 ;;^UTILITY(U,$J,19200.114,65,"WP1",17,0)
 ;;=   number. When LAYGO Finding nodes result in a successful lookup, the
 ;;^UTILITY(U,$J,19200.114,65,"WP1",18,0)
 ;;=   IEN Array node passed in by the application is changed to the record
 ;;^UTILITY(U,$J,19200.114,65,"WP1",19,0)
 ;;=   number of the record found.
 ;;^UTILITY(U,$J,19200.114,65,"WP1",20,0)
 ;;= 
 ;;^UTILITY(U,$J,19200.114,65,"WP1",21,0)
 ;;=   If the application sets an entry in the IEN Array for a Finding node,
 ;;^UTILITY(U,$J,19200.114,65,"WP1",22,0)
 ;;=   the Updater will ignore it (actually, it will overwrite it when it
 ;;^UTILITY(U,$J,19200.114,65,"WP1",23,0)
 ;;=   finds the record number for that node). This feature is meaningless
 ;;^UTILITY(U,$J,19200.114,65,"WP1",24,0)
 ;;=   for Filing nodes since they have no sequence numbers.
 ;;^UTILITY(U,$J,19200.114,65,"WP1",25,0)
 ;;= 
 ;;^UTILITY(U,$J,19200.114,65,"WP1",26,0)
 ;;=2. Locating Feedback on What the Update Did.
 ;;^UTILITY(U,$J,19200.114,65,"WP1",27,0)
 ;;=   As the Updater decodes and processes the sequence numbers, it
 ;;^UTILITY(U,$J,19200.114,65,"WP1",28,0)
 ;;=   gradually converts them into genuine record numbers. The IEN Array
 ;;^UTILITY(U,$J,19200.114,65,"WP1",29,0)
 ;;=   named by the IEN_ROOT parameter is where this feedback will be given.
 ;;^UTILITY(U,$J,19200.114,65,"WP1",30,0)
 ;;=   Those sequence numbers not already assigned by the application will
 ;;^UTILITY(U,$J,19200.114,65,"WP1",31,0)
 ;;=   be filled in by the Updater (or sometimes replaced, in the case of
 ;;^UTILITY(U,$J,19200.114,65,"WP1",32,0)
 ;;=   LAYGO Finding nodes).
 ;;^UTILITY(U,$J,19200.114,66,0)
 ;;=FLAGS
 ;;^UTILITY(U,$J,19200.114,66,"I")
 ;;=FILE^DIE
 ;;^UTILITY(U,$J,19200.114,66,"WP",0)
 ;;=^^3^3^2960526^
 ;;^UTILITY(U,$J,19200.114,66,"WP",1,0)
 ;;=K=Locking is done by Filer.
 ;;^UTILITY(U,$J,19200.114,66,"WP",2,0)
 ;;=S=Save FDA array.
 ;;^UTILITY(U,$J,19200.114,66,"WP",3,0)
 ;;=E=External values are processed.
 ;;^UTILITY(U,$J,19200.114,67,0)
 ;;=TARGET_ROOT
 ;;^UTILITY(U,$J,19200.114,67,"I")
 ;;=GETS^DIQ
 ;;^UTILITY(U,$J,19200.114,67,"WP",0)
 ;;=^^3^3^2960614^
 ;;^UTILITY(U,$J,19200.114,67,"WP",1,0)
 ;;=The array that should receive the output list of found entries. This
 ;;^UTILITY(U,$J,19200.114,67,"WP",2,0)
 ;;=must be a closed array reference and can be either local or global.
 ;;^UTILITY(U,$J,19200.114,67,"WP",3,0)
 ;;=This is a REQUIRED field.

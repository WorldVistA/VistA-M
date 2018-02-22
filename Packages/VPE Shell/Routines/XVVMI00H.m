XVVMI00H ; ; 04-JAN-2004
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 Q:'DIFQR(19200.114)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,19200.114,60,"WP",1,0)
 ;;=--> H=Help
 ;;^UTILITY(U,$J,19200.114,60,"WP",2,0)
 ;;=DIE can be called to directly edit an entry in a subfile.
 ;;^UTILITY(U,$J,19200.114,60,"WP1",0)
 ;;=^^8^8^2960115^
 ;;^UTILITY(U,$J,19200.114,60,"WP1",1,0)
 ;;=Suppose that the data in subfile 16000.02 is stored decendent from
 ;;^UTILITY(U,$J,19200.114,60,"WP1",2,0)
 ;;=subscript 20 and you are going to edit entry number 777, subentry
 ;;^UTILITY(U,$J,19200.114,60,"WP1",3,0)
 ;;=number 1:
 ;;^UTILITY(U,$J,19200.114,60,"WP1",4,0)
 ;;=   S DIE="^FILE(777,20,"
 ;;^UTILITY(U,$J,19200.114,60,"WP1",5,0)
 ;;=   S DA(1)=777
 ;;^UTILITY(U,$J,19200.114,60,"WP1",6,0)
 ;;=   S DA=1
 ;;^UTILITY(U,$J,19200.114,60,"WP1",7,0)
 ;;=   S DR="3;7"
 ;;^UTILITY(U,$J,19200.114,60,"WP1",8,0)
 ;;=   D ^DIE
 ;;^UTILITY(U,$J,19200.114,61,0)
 ;;=FLAGS
 ;;^UTILITY(U,$J,19200.114,61,"I")
 ;;=GETS^DIQ
 ;;^UTILITY(U,$J,19200.114,61,"WP",0)
 ;;=^^5^5^2960521^^
 ;;^UTILITY(U,$J,19200.114,61,"WP",1,0)
 ;;=E = Returns external values in nodes ending with "E".
 ;;^UTILITY(U,$J,19200.114,61,"WP",2,0)
 ;;=I = Returns internal values in nodes ending with "I".
 ;;^UTILITY(U,$J,19200.114,61,"WP",3,0)
 ;;=N = Does not return Null values.
 ;;^UTILITY(U,$J,19200.114,61,"WP",4,0)
 ;;=R = Resolves field numbers to field names in target array subscripts.
 ;;^UTILITY(U,$J,19200.114,61,"WP",5,0)
 ;;=Z = Word processing fields include Zero nodes.
 ;;^UTILITY(U,$J,19200.114,62,0)
 ;;=FIELDS
 ;;^UTILITY(U,$J,19200.114,62,"I")
 ;;=GETS^DIQ
 ;;^UTILITY(U,$J,19200.114,62,"WP",0)
 ;;=^^5^5^2960512^
 ;;^UTILITY(U,$J,19200.114,62,"WP",1,0)
 ;;=A single field number. A list of field numbers separated by semicolons.
 ;;^UTILITY(U,$J,19200.114,62,"WP",2,0)
 ;;=A range of field numbers, in the form M:N. * for all fields at the top
 ;;^UTILITY(U,$J,19200.114,62,"WP",3,0)
 ;;=level. ** for all fields including sub-multiple fields. Field number of
 ;;^UTILITY(U,$J,19200.114,62,"WP",4,0)
 ;;=a multiple followed by an * to indicate all fields and records in the
 ;;^UTILITY(U,$J,19200.114,62,"WP",5,0)
 ;;=submultiple for that field.
 ;;^UTILITY(U,$J,19200.114,63,0)
 ;;=FLAGS
 ;;^UTILITY(U,$J,19200.114,63,"I")
 ;;=UPDATE^DIE
 ;;^UTILITY(U,$J,19200.114,63,"WP",0)
 ;;=^^5^5^2960526^^
 ;;^UTILITY(U,$J,19200.114,63,"WP",1,0)
 ;;=E=External values are processed. Values in the FDA must be in the format
 ;;^UTILITY(U,$J,19200.114,63,"WP",2,0)
 ;;=  input by the user. Updater validates all values and converts them to
 ;;^UTILITY(U,$J,19200.114,63,"WP",3,0)
 ;;=  internal format. Invalid values cancel the entire transaction.
 ;;^UTILITY(U,$J,19200.114,63,"WP",4,0)
 ;;=  If flag is not set, values must be in internal format and valid.
 ;;^UTILITY(U,$J,19200.114,63,"WP",5,0)
 ;;=S=Updater Saves the FDA instead of killing it.
 ;;^UTILITY(U,$J,19200.114,64,0)
 ;;=FDA_ROOT
 ;;^UTILITY(U,$J,19200.114,64,"I")
 ;;=UPDATE^DIE
 ;;^UTILITY(U,$J,19200.114,64,"WP",0)
 ;;=^^3^3^2960521^
 ;;^UTILITY(U,$J,19200.114,64,"WP",1,0)
 ;;=The name of the root of a Fileman Data Array, which describes the
 ;;^UTILITY(U,$J,19200.114,64,"WP",2,0)
 ;;=entries to add to the database. The Updater accepts Adding Nodes,
 ;;^UTILITY(U,$J,19200.114,64,"WP",3,0)
 ;;=Filing Nodes, Finding Nodes, and LAYGO Finding Nodes in its FDAs.
 ;;^UTILITY(U,$J,19200.114,65,0)
 ;;=IEN_ROOT
 ;;^UTILITY(U,$J,19200.114,65,"I")
 ;;=UPDATE^DIE
 ;;^UTILITY(U,$J,19200.114,65,"WP",0)
 ;;=^^2^2^2960521^^
 ;;^UTILITY(U,$J,19200.114,65,"WP",1,0)
 ;;=--> Help Text
 ;;^UTILITY(U,$J,19200.114,65,"WP",2,0)
 ;;=The name of the IEN Array. This should be a closed root.
 ;;^UTILITY(U,$J,19200.114,65,"WP1",0)
 ;;=^^32^32^2960521^
 ;;^UTILITY(U,$J,19200.114,65,"WP1",1,0)
 ;;=The IEN Array has 2 functions:
 ;;^UTILITY(U,$J,19200.114,65,"WP1",2,0)
 ;;= 
 ;;^UTILITY(U,$J,19200.114,65,"WP1",3,0)
 ;;=1. Requesting Record Numbers for New Entries.
 ;;^UTILITY(U,$J,19200.114,65,"WP1",4,0)
 ;;=   The application can set nodes in the IEN Array to direct the Updater
 ;;^UTILITY(U,$J,19200.114,65,"WP1",5,0)
 ;;=   to use specific record numbers for specific new records. These nodes
 ;;^UTILITY(U,$J,19200.114,65,"WP1",6,0)
 ;;=   should have a single subscript equal to the sequence number in the
 ;;^UTILITY(U,$J,19200.114,65,"WP1",7,0)
 ;;=   IENS subscript of the FDA entry and a value equal to the desired record
 ;;^UTILITY(U,$J,19200.114,65,"WP1",8,0)
 ;;=   number.
 ;;^UTILITY(U,$J,19200.114,65,"WP1",9,0)
 ;;= 
 ;;^UTILITY(U,$J,19200.114,65,"WP1",10,0)
 ;;=   For example, if the application sets the IEN_ROOT parameter to ORIEN,

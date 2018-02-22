XVVMI008 ; ; 04-JAN-2004
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 Q:'DIFQR(19200.114)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,19200.114)
 ;;=^XVV(19200.114,
 ;;^UTILITY(U,$J,19200.114,0)
 ;;=VPE PROGRAMMER PARAMETER^19200.114I^67^67
 ;;^UTILITY(U,$J,19200.114,1,0)
 ;;=DIALOG#^n
 ;;^UTILITY(U,$J,19200.114,1,"WP",0)
 ;;=^^1^1^2960107^^^^
 ;;^UTILITY(U,$J,19200.114,1,"WP",1,0)
 ;;=Record number from DIALOG file ^DI(.84), for text to be returned.
 ;;^UTILITY(U,$J,19200.114,2,0)
 ;;=TEXT_PARAM
 ;;^UTILITY(U,$J,19200.114,2,"WP",0)
 ;;=^^3^3^2960106^
 ;;^UTILITY(U,$J,19200.114,2,"WP",1,0)
 ;;=Name of local array containing list of parameters to be incorporated
 ;;^UTILITY(U,$J,19200.114,2,"WP",2,0)
 ;;=into the text. External format. If only one param, it can be passed
 ;;^UTILITY(U,$J,19200.114,2,"WP",3,0)
 ;;=in a local variable or a literal.
 ;;^UTILITY(U,$J,19200.114,3,0)
 ;;=OUTPUT_PARAM
 ;;^UTILITY(U,$J,19200.114,3,"WP",0)
 ;;=^^2^2^2960106^^
 ;;^UTILITY(U,$J,19200.114,3,"WP",1,0)
 ;;=Used for ERROR dialogue only. Local array containing list of
 ;;^UTILITY(U,$J,19200.114,3,"WP",2,0)
 ;;=parameters to be passed to calling routine along with text.
 ;;^UTILITY(U,$J,19200.114,4,0)
 ;;=OUT_ARRAY
 ;;^UTILITY(U,$J,19200.114,4,"WP",0)
 ;;=^^1^1^2960106^^
 ;;^UTILITY(U,$J,19200.114,4,"WP",1,0)
 ;;=Text will be output to this array. If null, ^TMP is used.
 ;;^UTILITY(U,$J,19200.114,5,0)
 ;;=FLAGS
 ;;^UTILITY(U,$J,19200.114,5,"I")
 ;;=BLD^DIALOG
 ;;^UTILITY(U,$J,19200.114,5,"WP",0)
 ;;=^^2^2^2960521^^^^
 ;;^UTILITY(U,$J,19200.114,5,"WP",1,0)
 ;;=S=Suppress blank line normally inserted between text blocks.
 ;;^UTILITY(U,$J,19200.114,5,"WP",2,0)
 ;;=F=Formats local array similar to default output to ^TMP global.
 ;;^UTILITY(U,$J,19200.114,6,0)
 ;;=FLAGS
 ;;^UTILITY(U,$J,19200.114,6,"I")
 ;;=MSG^DIALOG
 ;;^UTILITY(U,$J,19200.114,6,"WP",0)
 ;;=^^4^4^2960521^^^
 ;;^UTILITY(U,$J,19200.114,6,"WP",1,0)
 ;;=A=Array specified by 2nd param receives the text.
 ;;^UTILITY(U,$J,19200.114,6,"WP",2,0)
 ;;=W=Write text to current device.
 ;;^UTILITY(U,$J,19200.114,6,"WP",3,0)
 ;;=S=Save ^TMP or designated array.
 ;;^UTILITY(U,$J,19200.114,6,"WP",4,0)
 ;;=E,H,M=Error,Help, or Message array text is processed.
 ;;^UTILITY(U,$J,19200.114,7,0)
 ;;=TEXT_WIDTH
 ;;^UTILITY(U,$J,19200.114,7,"WP",0)
 ;;=^^3^3^2960106^
 ;;^UTILITY(U,$J,19200.114,7,"WP",1,0)
 ;;=Maximum line length for formatting text. If sent, text is broken
 ;;^UTILITY(U,$J,19200.114,7,"WP",2,0)
 ;;=into lines of this length. Lines are not "joined" to fill out to
 ;;^UTILITY(U,$J,19200.114,7,"WP",3,0)
 ;;=this width. Default is IOM or 75.
 ;;^UTILITY(U,$J,19200.114,8,0)
 ;;=LEFT_MARGIN
 ;;^UTILITY(U,$J,19200.114,8,"WP",0)
 ;;=^^1^1^2960106^
 ;;^UTILITY(U,$J,19200.114,8,"WP",1,0)
 ;;=Left margin for writing text. Has no effect on text sent to an array.
 ;;^UTILITY(U,$J,19200.114,9,0)
 ;;=INPUT_ROOT
 ;;^UTILITY(U,$J,19200.114,9,"WP",0)
 ;;=^^3^3^2960106^
 ;;^UTILITY(U,$J,19200.114,9,"WP",1,0)
 ;;=Closed root of array in which text resides. If text resides in a
 ;;^UTILITY(U,$J,19200.114,9,"WP",2,0)
 ;;=local array, this parameter MUST be sent. The last subscript of the
 ;;^UTILITY(U,$J,19200.114,9,"WP",3,0)
 ;;=array must describe type of text ("DIERR", "DIHELP", or "DIMSG").
 ;;^UTILITY(U,$J,19200.114,10,0)
 ;;=FILE
 ;;^UTILITY(U,$J,19200.114,10,"WP",0)
 ;;=^^2^2^2960106^
 ;;^UTILITY(U,$J,19200.114,10,"WP",1,0)
 ;;=Number of file or subfile. If it is a subfile, it must be
 ;;^UTILITY(U,$J,19200.114,10,"WP",2,0)
 ;;=accompanied by the IENS parameter.
 ;;^UTILITY(U,$J,19200.114,11,0)
 ;;=IENS
 ;;^UTILITY(U,$J,19200.114,11,"I")
 ;;=EXTENDED
 ;;^UTILITY(U,$J,19200.114,11,"WP",0)
 ;;=^^4^4^2960106^^^^
 ;;^UTILITY(U,$J,19200.114,11,"WP",1,0)
 ;;=A comma-delimited list of internal entry numbers beginning with
 ;;^UTILITY(U,$J,19200.114,11,"WP",2,0)
 ;;=the lowest level subentry. A "," is appended to the end. A place-
 ;;^UTILITY(U,$J,19200.114,11,"WP",3,0)
 ;;=holder of 1 or 2 characters can be used. +=Add a new entry
 ;;^UTILITY(U,$J,19200.114,11,"WP",4,0)
 ;;=?=Find entry and use for filing  ?+=Find entry (LAYGO authorized)
 ;;^UTILITY(U,$J,19200.114,12,0)
 ;;=IENS
 ;;^UTILITY(U,$J,19200.114,12,"I")
 ;;=FIND^DIC
 ;;^UTILITY(U,$J,19200.114,12,"WP",0)
 ;;=^^5^5^2960117^
 ;;^UTILITY(U,$J,19200.114,12,"WP",1,0)
 ;;=--> H=Help
 ;;^UTILITY(U,$J,19200.114,12,"WP",2,0)
 ;;=If the FILE parameter equals a subfile number, the IENS parameter is
 ;;^UTILITY(U,$J,19200.114,12,"WP",3,0)
 ;;=needed to help identify which subfile. Since this parameter identifies
 ;;^UTILITY(U,$J,19200.114,12,"WP",4,0)
 ;;=the subfile under that record, and not the subrecord itself, the first

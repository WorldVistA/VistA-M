XVVMI009 ; ; 04-JAN-2004
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 Q:'DIFQR(19200.114)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,19200.114,12,"WP",5,0)
 ;;=comma-piece of the parameter should be empty.
 ;;^UTILITY(U,$J,19200.114,12,"WP1",0)
 ;;=^^15^15^2960117^^
 ;;^UTILITY(U,$J,19200.114,12,"WP1",1,0)
 ;;=If the FILE parameter equals a file number, the IENS parameter is ignored.
 ;;^UTILITY(U,$J,19200.114,12,"WP1",2,0)
 ;;=If the FILE parameter equals a subfile number, the IENS is needed to help
 ;;^UTILITY(U,$J,19200.114,12,"WP1",3,0)
 ;;=identify which subfile to list. In other words, files can be specified
 ;;^UTILITY(U,$J,19200.114,12,"WP1",4,0)
 ;;=with the FILE parameter alone, but subfiles require both the FILE and IENS
 ;;^UTILITY(U,$J,19200.114,12,"WP1",5,0)
 ;;=parameters.
 ;;^UTILITY(U,$J,19200.114,12,"WP1",6,0)
 ;;= 
 ;;^UTILITY(U,$J,19200.114,12,"WP1",7,0)
 ;;=When the IENS parameter is used, it must equal an IENS that identifies the
 ;;^UTILITY(U,$J,19200.114,12,"WP1",8,0)
 ;;=parent record of the exact subfile to list. Since this parameter
 ;;^UTILITY(U,$J,19200.114,12,"WP1",9,0)
 ;;=identifies the subfile under that record, and not the subrecord itself,
 ;;^UTILITY(U,$J,19200.114,12,"WP1",10,0)
 ;;=the first comma-piece of the parameter should be empty.
 ;;^UTILITY(U,$J,19200.114,12,"WP1",11,0)
 ;;= 
 ;;^UTILITY(U,$J,19200.114,12,"WP1",12,0)
 ;;=For example, to specify the Menu Item subfile under option number 67, you
 ;;^UTILITY(U,$J,19200.114,12,"WP1",13,0)
 ;;=must pass FILE=19.01 (the subfile number for the Menu subfile) and
 ;;^UTILITY(U,$J,19200.114,12,"WP1",14,0)
 ;;=IENS=",67," (showing that record number 67 holds the Menu subfile you want
 ;;^UTILITY(U,$J,19200.114,12,"WP1",15,0)
 ;;=to list).
 ;;^UTILITY(U,$J,19200.114,13,0)
 ;;=FIELDS
 ;;^UTILITY(U,$J,19200.114,13,"I")
 ;;=FIND^DIC
 ;;^UTILITY(U,$J,19200.114,13,"WP",0)
 ;;=^^4^4^2960512^
 ;;^UTILITY(U,$J,19200.114,13,"WP",1,0)
 ;;=The fields to return with each entry found, in addition to the .01
 ;;^UTILITY(U,$J,19200.114,13,"WP",2,0)
 ;;=field, IEN, and any MUMPS identifiers on the file. It should be set
 ;;^UTILITY(U,$J,19200.114,13,"WP",3,0)
 ;;=equal to the field numbers separated by ";" characters. Don't include
 ;;^UTILITY(U,$J,19200.114,13,"WP",4,0)
 ;;=computed, word processing, or multiple fields.
 ;;^UTILITY(U,$J,19200.114,14,0)
 ;;=VALUE
 ;;^UTILITY(U,$J,19200.114,14,"I")
 ;;=FIND^DIC
 ;;^UTILITY(U,$J,19200.114,14,"WP",0)
 ;;=^^2^2^2960117^^^
 ;;^UTILITY(U,$J,19200.114,14,"WP",1,0)
 ;;=The lookup value. The Finder searches the specified indexes of the file
 ;;^UTILITY(U,$J,19200.114,14,"WP",2,0)
 ;;=looking for values that match this value.
 ;;^UTILITY(U,$J,19200.114,14,"WP1",0)
 ;;=^^25^25^2960117^
 ;;^UTILITY(U,$J,19200.114,14,"WP1",1,0)
 ;;= Certain values generate special behavior by the Finder as follows:
 ;;^UTILITY(U,$J,19200.114,14,"WP1",2,0)
 ;;= 1. Control characters. Always results in no matches.
 ;;^UTILITY(U,$J,19200.114,14,"WP1",3,0)
 ;;= 2. ^ (shift 6). Always results in no matches. This signifies to FM
 ;;^UTILITY(U,$J,19200.114,14,"WP1",4,0)
 ;;=    that the current activity should be stopped.
 ;;^UTILITY(U,$J,19200.114,14,"WP1",5,0)
 ;;= 3. "" (the empty string). Always results in no matches.
 ;;^UTILITY(U,$J,19200.114,14,"WP1",6,0)
 ;;= 4. " " (the space character). This value indicates that the Finder
 ;;^UTILITY(U,$J,19200.114,14,"WP1",7,0)
 ;;=    should return the current user's previous selection from this file.
 ;;^UTILITY(U,$J,19200.114,14,"WP1",8,0)
 ;;=    If FM has no previous selection then the Finder returns no matches.
 ;;^UTILITY(U,$J,19200.114,14,"WP1",9,0)
 ;;=    The Finder itself never preserves its found values for this recall;
 ;;^UTILITY(U,$J,19200.114,14,"WP1",10,0)
 ;;=    applications wishing to preserve found values should call
 ;;^UTILITY(U,$J,19200.114,14,"WP1",11,0)
 ;;=    RECALL^DILFD.
 ;;^UTILITY(U,$J,19200.114,14,"WP1",12,0)
 ;;= 5. "`"-Number (accent-grave followed by a number). This indicates that
 ;;^UTILITY(U,$J,19200.114,14,"WP1",13,0)
 ;;=    the Finder should select the entry whose IEN equals the number
 ;;^UTILITY(U,$J,19200.114,14,"WP1",14,0)
 ;;=    following the accent-grave. This does not require the A flag.
 ;;^UTILITY(U,$J,19200.114,14,"WP1",15,0)
 ;;= 6. Numbers. The Finder tries strictly numeric input as an IEN under
 ;;^UTILITY(U,$J,19200.114,14,"WP1",16,0)
 ;;=    any for the following 3 conditions: 1) The caller uses the A flag,
 ;;^UTILITY(U,$J,19200.114,14,"WP1",17,0)
 ;;=    2) the file has a .001 field, or 3) the file's .01 field is not
 ;;^UTILITY(U,$J,19200.114,14,"WP1",18,0)
 ;;=    numeric and the file has no lookup index.

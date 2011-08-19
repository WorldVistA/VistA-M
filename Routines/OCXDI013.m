OCXDI013 ;SLC/RJS,CLA - OCX PACKAGE DIAGNOSTIC ROUTINES ;SEP 7,1999 at 10:29
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**32**;Dec 17,1997
 ;;  ;;ORDER CHECK EXPERT version 1.01 released OCT 29,1998
 ;
S ;
 ;
 D DOT^OCXDIAG
 ;
 ;
 K REMOTE,LOCAL,OPCODE,REF
 F LINE=1:1:500 S TEXT=$P($T(DATA+LINE),";",2,999) Q:TEXT  I $L(TEXT) D  Q:QUIT
 .S ^TMP("OCXDIAG",$J,$O(^TMP("OCXDIAG",$J,"A"),-1)+1)=TEXT
 ;
 G ^OCXDI014
 ;
 Q
 ;
DATA ;
 ;
 ;;D^ internal format.  This expression will foloow the 'Q' of an extrinsic
 ;;R^"863.8:",1,3
 ;;D^ function.
 ;;R^"863.8:","863.84:4",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:4",1,"E"
 ;;D^Enter input transform expression
 ;;R^"863.8:","863.84:5",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:5",1,"E"
 ;;D^LINE TAG
 ;;EOR^
 ;;KEY^863.8:^DIALOGUE OUTPUT TRANSFORM
 ;;R^"863.8:",.01,"E"
 ;;D^DIALOGUE OUTPUT TRANSFORM
 ;;R^"863.8:",.02,"E"
 ;;D^DT OT
 ;;R^"863.8:",1,1
 ;;D^M expression which transforms an internal value (stored in 'X') to an
 ;;R^"863.8:",1,2
 ;;D^external format.  This expression will follow the 'Q' in an extrinsic
 ;;R^"863.8:",1,3
 ;;D^function.
 ;;R^"863.8:","863.84:4",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:4",1,"E"
 ;;D^Enter output transform expression
 ;;R^"863.8:","863.84:5",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:5",1,"E"
 ;;D^LINE TAG
 ;;EOR^
 ;;KEY^863.8:^INPUT VALUE
 ;;R^"863.8:",.01,"E"
 ;;D^INPUT VALUE
 ;;R^"863.8:",.02,"E"
 ;;D^INVAL
 ;;R^"863.8:",1,1
 ;;D^Stores an input value for a function
 ;;R^"863.8:",2,"E"
 ;;D^ 
 ;;R^"863.8:","863.84:3",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:3",1,"E"
 ;;D^Enter a variable name
 ;;R^"863.8:","863.84:4",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:4",1,"E"
 ;;D^FREE TEXT
 ;;EOR^
 ;;KEY^863.8:^TERMINATOR
 ;;R^"863.8:",.01,"E"
 ;;D^TERMINATOR
 ;;R^"863.8:",.02,"E"
 ;;D^TERMINATOR
 ;;R^"863.8:",1,1
 ;;D^A text string terminator; e.g., '?', ': ', '=>'
 ;;R^"863.8:",2,"E"
 ;;D^:
 ;;R^"863.8:","863.84:4",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:4",1,"E"
 ;;D^Enter text string terminator
 ;;R^"863.8:","863.84:5",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:5",1,"E"
 ;;D^FREE TEXT
 ;;R^"863.8:","863.84:6",.01,"E"
 ;;D^FREE TEXT MAXIMUM LENGTH
 ;;R^"863.8:","863.84:6",1,"E"
 ;;D^9
 ;;EOR^
 ;;KEY^863.8:^ALL UPPERCASE
 ;;R^"863.8:",.01,"E"
 ;;D^ALL UPPERCASE
 ;;R^"863.8:",.02,"E"
 ;;D^ALL UC
 ;;R^"863.8:",1,1
 ;;D^If = '1' the the string must not contain any lowercase characters
 ;;R^"863.8:","863.84:1",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:1",1,"E"
 ;;D^SET OF CODES
 ;;R^"863.8:","863.84:2",.01,"E"
 ;;D^SET CODES
 ;;R^"863.8:","863.84:2",1,"E"
 ;;D^1:UPPER CASE ONLY;0:LOWER CASE ALLOWED
 ;;EOR^
 ;;KEY^863.8:^FREE TEXT MINMAX HELP
 ;;R^"863.8:",.01,"E"
 ;;D^FREE TEXT MINMAX HELP
 ;;R^"863.8:",.02,"E"
 ;;D^FTMM HELP
 ;;R^"863.8:",1,1
 ;;D^A'^' delimeted text string which contains user help re string length.
 ;;R^"863.8:",1,2
 ;;D^The 1st piece is used if only FMAX is defined.
 ;;R^"863.8:",1,3
 ;;D^The 2nd piece is used if only FMIN is defined.
 ;;R^"863.8:",1,4
 ;;D^The 3rd piece is used if both FMIN and FMAX are defined.
 ;;R^"863.8:",2,"E"
 ;;D^The maximum string length is |FMAX| characters.^The minimum string length is |FMIN| characters.^String length must be between |FMIN| and |FMAX| characters.
 ;;R^"863.8:","863.84:4",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:4",1,"E"
 ;;D^Enter MIN/MAX help message
 ;;R^"863.8:","863.84:5",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:5",1,"E"
 ;;D^FREE TEXT
 ;;EOR^
 ;;KEY^863.8:^NUMERIC MINMAX HELP
 ;;R^"863.8:",.01,"E"
 ;;D^NUMERIC MINMAX HELP
 ;;R^"863.8:",.02,"E"
 ;;D^NUMM HELP
 ;;R^"863.8:",1,1
 ;;D^'^' delimited text string containing min/max help messages for the numeric
 ;;R^"863.8:",1,2
 ;;D^data type
 ;;R^"863.8:",2,"E"
 ;;D^Not over |MAX|.^Not less than |MIN|.^Must be between |MIN| and |MAX|.^Pos. integer req'd.^Pos. number req'd.^Must be an integer.^No more than |DEC| decimal places allowed.^Neg. integer req'd.^Any number is OK.^Neg. number req'd.
 ;;R^"863.8:","863.84:1",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:1",1,"E"
 ;;D^FREE TEXT
 ;;R^"863.8:","863.84:2",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:2",1,"E"
 ;;D^Enter a message
 ;;EOR^
 ;;KEY^863.8:^POINTER HELP MESSAGE
 ;;R^"863.8:",.01,"E"
 ;;D^POINTER HELP MESSAGE
 ;;R^"863.8:",.02,"E"
 ;;D^PHELP
 ;;R^"863.8:",1,1
 ;;D^Pointer data type help messages in a '^' delimited string
 ;;R^"863.8:",2,"E"
 ;;D^Select from a list of |COUNT| entries...^Select a value from the following list =>
 ;;R^"863.8:","863.84:1",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:1",1,"E"
 ;;D^FREE TEXT
 ;;EOR^
 ;;KEY^863.8:^DIC
 ;;R^"863.8:",.01,"E"
 ;;D^DIC
 ;;R^"863.8:",.02,"E"
 ;;D^DIC
 ;;R^"863.8:",1,1
 ;;D^An open reference used to specify the file in a DIC lookup
 ;;R^"863.8:","863.84:1",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:1",1,"E"
 ;;D^POINTER TO A FILEMAN FILE
 ;;R^"863.8:","863.84:2",.01,"E"
 ;;D^DIC
 ;;R^"863.8:","863.84:2",1,"E"
 ;;D^1
 ;;R^"863.8:","863.84:3",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:3",1,"E"
 ;;D^Enter the name of the file you are pointing to
 ;;EOR^
 ;;KEY^863.8:^DIC SUB S
 ;;R^"863.8:",.01,"E"
 ;;D^DIC SUB S
 ;1;
 ;

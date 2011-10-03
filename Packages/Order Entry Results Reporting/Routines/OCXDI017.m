OCXDI017 ;SLC/RJS,CLA - OCX PACKAGE DIAGNOSTIC ROUTINES ;SEP 7,1999 at 10:30
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
 G ^OCXDI018
 ;
 Q
 ;
DATA ;
 ;
 ;;D^BRIEF NAME OK
 ;;R^"863.8:",.02,"E"
 ;;D^BRIEF
 ;;R^"863.8:",1,1
 ;;D^OK to use the brief name of an object
 ;;R^"863.8:","863.84:1",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:1",1,"E"
 ;;D^YES NO
 ;;R^"863.8:","863.84:2",.01,"E"
 ;;D^HELP MESSAGE
 ;;R^"863.8:","863.84:2",1,"E"
 ;;D^Answer yes if it is ok to use a brief name
 ;;R^"863.8:","863.84:3",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:3",1,"E"
 ;;D^OK to use brief name
 ;;EOR^
 ;;KEY^863.8:^PARAMETER QUERY
 ;;R^"863.8:",.01,"E"
 ;;D^PARAMETER QUERY
 ;;R^"863.8:",.02,"E"
 ;;D^PQUERY
 ;;R^"863.8:",1,1
 ;;D^A query which asks for a valid parameter value
 ;;R^"863.8:","863.84:1",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:1",1,"E"
 ;;D^FREE TEXT
 ;;R^"863.8:","863.84:2",.01,"E"
 ;;D^HELP MESSAGE
 ;;R^"863.8:","863.84:2",1,"E"
 ;;D^Enter the text which asks a user for a parameter query
 ;;R^"863.8:","863.84:3",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:3",1,"E"
 ;;D^Query
 ;;R^"863.8:","863.84:4",.01,"E"
 ;;D^FREE TEXT MAXIMUM LENGTH
 ;;R^"863.8:","863.84:4",1,"E"
 ;;D^240
 ;;EOR^
 ;;KEY^863.8:^DATA TYPE IEN
 ;;R^"863.8:",.01,"E"
 ;;D^DATA TYPE IEN
 ;;R^"863.8:",.02,"E"
 ;;D^DTIEN
 ;;R^"863.8:",1,1
 ;;D^The IEN of a data type in the DATA TYPE file.
 ;;R^"863.8:","863.84:1",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:1",1,"E"
 ;;D^POINTER TO A FILEMAN FILE
 ;;R^"863.8:","863.84:2",.01,"E"
 ;;D^HELP MESSAGE
 ;;R^"863.8:","863.84:2",1,"E"
 ;;D^Enter the data type name
 ;;R^"863.8:","863.84:3",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:3",1,"E"
 ;;D^Data type
 ;;R^"863.8:","863.84:4",.01,"E"
 ;;D^DIC
 ;;R^"863.8:","863.84:4",1,"E"
 ;;D^864.1
 ;;EOR^
 ;;KEY^863.8:^NO DISPLAY
 ;;R^"863.8:",.01,"E"
 ;;D^NO DISPLAY
 ;;R^"863.8:",.02,"E"
 ;;D^NO DISP
 ;;R^"863.8:",1,1
 ;;D^Supress the display of results
 ;;R^"863.8:","863.84:1",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:1",1,"E"
 ;;D^YES NO
 ;;R^"863.8:","863.84:2",.01,"E"
 ;;D^HELP MESSAGE
 ;;R^"863.8:","863.84:2",1,"E"
 ;;D^Answer 'YES' to supress the display
 ;;R^"863.8:","863.84:3",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:3",1,"E"
 ;;D^Supress display
 ;;EOR^
 ;;KEY^863.8:^OCXO VARIABLE NAME
 ;;R^"863.8:",.01,"E"
 ;;D^OCXO VARIABLE NAME
 ;;EOR^
 ;;KEY^863.8:^OCXO VT-BAR PIECE NUMBER
 ;;R^"863.8:",.01,"E"
 ;;D^OCXO VT-BAR PIECE NUMBER
 ;;EOR^
 ;;KEY^863.8:^OCXO UP-ARROW PIECE NUMBER
 ;;R^"863.8:",.01,"E"
 ;;D^OCXO UP-ARROW PIECE NUMBER
 ;;EOR^
 ;;KEY^863.8:^OCXO OPERATOR CODE TEMPLATE
 ;;R^"863.8:",.01,"E"
 ;;D^OCXO OPERATOR CODE TEMPLATE
 ;;EOR^
 ;;KEY^863.8:^OCXO HL7 SEGMENT ID
 ;;R^"863.8:",.01,"E"
 ;;D^OCXO HL7 SEGMENT ID
 ;;R^"863.8:",.02,"E"
 ;;D^HL7SEGID
 ;;EOR^
 ;;KEY^863.8:^OCXO UNARY OPERATOR FLAG
 ;;R^"863.8:",.01,"E"
 ;;D^OCXO UNARY OPERATOR FLAG
 ;;EOR^
 ;;KEY^863.8:^OCXO OPERATOR CODE ROUTINE
 ;;R^"863.8:",.01,"E"
 ;;D^OCXO OPERATOR CODE ROUTINE
 ;;R^"863.8:",.02,"E"
 ;;D^CODE RTN
 ;;EOR^
 ;;KEY^863.8:^OCXO GENERATE CODE FUNCTION
 ;;R^"863.8:",.01,"E"
 ;;D^OCXO GENERATE CODE FUNCTION
 ;;R^"863.8:",.02,"E"
 ;;D^GEN
 ;;EOR^
 ;;KEY^863.8:^PRIMARY DATA FIELD
 ;;R^"863.8:",.01,"E"
 ;;D^PRIMARY DATA FIELD
 ;;R^"863.8:",.02,"E"
 ;;D^PDFLD
 ;;R^"863.8:",1,1
 ;;D^ 
 ;;R^"863.8:",1,2
 ;;D^  Primary data field in a comparison expression that
 ;;R^"863.8:",1,3
 ;;D^ is to be tested.
 ;;R^"863.8:",1,4
 ;;D^ 
 ;;EOR^
 ;;KEY^863.8:^COMPARISON VALUE
 ;;R^"863.8:",.01,"E"
 ;;D^COMPARISON VALUE
 ;;R^"863.8:",.02,"E"
 ;;D^CVAL
 ;;R^"863.8:",1,1
 ;;D^ 
 ;;R^"863.8:",1,2
 ;;D^   This is a value to be compared with PRIMARY DATA FIELD
 ;;R^"863.8:",1,3
 ;;D^ in a truth conditional.
 ;;R^"863.8:",1,4
 ;;D^ 
 ;;EOR^
 ;;KEY^863.8:^COMPARISON LOW VALUE
 ;;R^"863.8:",.01,"E"
 ;;D^COMPARISON LOW VALUE
 ;;R^"863.8:",.02,"E"
 ;;D^CLVAL
 ;;R^"863.8:",1,1
 ;;D^ 
 ;;R^"863.8:",1,2
 ;;D^  This is the low value in a range that is compared
 ;;R^"863.8:",1,3
 ;;D^ to the PRIMARY DATA FIELD in a boolean expression.
 ;;R^"863.8:",1,4
 ;;D^ 
 ;;EOR^
 ;;KEY^863.8:^COMPARISON HIGH VALUE
 ;;R^"863.8:",.01,"E"
 ;;D^COMPARISON HIGH VALUE
 ;;R^"863.8:",.02,"E"
 ;;D^CHVAL
 ;;R^"863.8:",1,1
 ;;D^ 
 ;;R^"863.8:",1,2
 ;;D^  This is the high value in a range that is compared
 ;;R^"863.8:",1,3
 ;;D^ to the PRIMARY DATA FIELD in a boolean expression.
 ;;R^"863.8:",1,4
 ;;D^ 
 ;;EOR^
 ;;KEY^863.8:^OCXO NULL VALUE ALLOWED
 ;;R^"863.8:",.01,"E"
 ;;D^OCXO NULL VALUE ALLOWED
 ;;R^"863.8:",.02,"E"
 ;;D^NVAL
 ;;EOR^
 ;;KEY^863.8:^OCXO DATA DRIVE SOURCE
 ;;R^"863.8:",.01,"E"
 ;;D^OCXO DATA DRIVE SOURCE
 ;;EOR^
 ;;KEY^863.8:^REPEAT THE QUERY
 ;;R^"863.8:",.01,"E"
 ;;D^REPEAT THE QUERY
 ;;R^"863.8:",.02,"E"
 ;;D^LOOP
 ;;R^"863.8:",1,1
 ;;D^Set this = 1 to repetatively ask the user to enter a value
 ;;R^"863.8:","863.84:1",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:1",1,"E"
 ;;D^YES NO
 ;;R^"863.8:","863.84:2",.01,"E"
 ;;D^HELP MESSAGE
 ;;R^"863.8:","863.84:2",1,"E"
 ;;D^Answer 'YES' if you want the user to repetaively enter a value.
 ;1;
 ;

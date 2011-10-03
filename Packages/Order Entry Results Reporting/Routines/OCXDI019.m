OCXDI019 ;SLC/RJS,CLA - OCX PACKAGE DIAGNOSTIC ROUTINES ;SEP 7,1999 at 10:30
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
 G ^OCXDI01A
 ;
 Q
 ;
DATA ;
 ;
 ;;D^DIC
 ;;R^"864.1:","864.11:4",1,"E"
 ;;D^ 
 ;;R^"864.1:","864.11:5",.01,"E"
 ;;D^FAILED LOOKUP MESSAGE
 ;;R^"864.1:","864.11:6",.01,"E"
 ;;D^LOOP QUERY
 ;;R^"864.1:","864.11:6",1,"E"
 ;;D^Enter the name of another record in the file
 ;;R^"864.1:","864.11:7",.01,"E"
 ;;D^REPEAT THE QUERY
 ;;R^"864.1:","864.11:7",1,"E"
 ;;D^1
 ;;R^"864.1:","864.11:8",.01,"E"
 ;;D^FILEMAN FILE NUMBER
 ;;EOR^
 ;;KEY^864.1:^MUMPS CODE
 ;;R^"864.1:",.01,"E"
 ;;D^MUMPS CODE
 ;;R^"864.1:",.02,"E"
 ;;D^MCODE
 ;;R^"864.1:",2,"E"
 ;;D^FREE TEXT
 ;;R^"864.1:","864.11:3",.01,"E"
 ;;D^DIALOGUE VALIDATION CODE
 ;;R^"864.1:","864.11:3",1,"E"
 ;;D^MCODE^OCXFDFTE
 ;;R^"864.1:","864.11:5",.01,"E"
 ;;D^QUERY
 ;;R^"864.1:","864.11:5",1,"E"
 ;;D^Enter valid M code
 ;;R^"864.1:","864.11:6",.01,"E"
 ;;D^HELP MESSAGE
 ;;R^"864.1:","864.11:6",1,"E"
 ;;D^You must be able to successfully 'eXecute' the code you enter or it will be judged 'invalid'.
 ;;R^"864.1:","864.11:7",.01,"E"
 ;;D^VALUE CALL
 ;;R^"864.1:","864.11:7",1,"E"
 ;;D^FT^OCXFDFT
 ;;R^"864.1:","864.11:8",.01,"E"
 ;;D^LOOP QUERY
 ;;R^"864.1:","864.11:8",1,"E"
 ;;D^Enter another line of valid M code
 ;;R^"864.1:","864.11:9",.01,"E"
 ;;D^REPEAT THE QUERY
 ;;R^"864.1:","864.11:9",1,"E"
 ;;D^0
 ;;EOR^
 ;;KEY^864.1:^DATE/TIME
 ;;R^"864.1:",.01,"E"
 ;;D^DATE/TIME
 ;;R^"864.1:",.02,"E"
 ;;D^DATE
 ;;R^"864.1:",2,"E"
 ;;D^GENERIC
 ;;R^"864.1:","864.11:10",.01,"E"
 ;;D^DATE SPECIAL MASK
 ;;R^"864.1:","864.11:11",.01,"E"
 ;;D^VALUE CALL
 ;;R^"864.1:","864.11:11",1,"E"
 ;;D^DATE^OCXFDD
 ;;R^"864.1:","864.11:12",.01,"E"
 ;;D^CONDITION CALL
 ;;R^"864.1:","864.11:12",1,"E"
 ;;D^COND^OCXFDD1
 ;;R^"864.1:","864.11:13",.01,"E"
 ;;D^HELP FRAME MESSAGE
 ;;R^"864.1:","864.11:13",1,"E"
 ;;D^Want instructions for entering a valid date and time
 ;;R^"864.1:","864.11:14",.01,"E"
 ;;D^QUERY
 ;;R^"864.1:","864.11:14",1,"E"
 ;;D^Enter date/time
 ;;R^"864.1:","864.11:15",.01,"E"
 ;;D^LOOP QUERY
 ;;R^"864.1:","864.11:15",1,"E"
 ;;D^Enter another date/time
 ;;R^"864.1:","864.11:16",.01,"E"
 ;;D^REPEAT THE QUERY
 ;;R^"864.1:","864.11:16",1,"E"
 ;;D^0
 ;;R^"864.1:","864.11:2",.01,"E"
 ;;D^DATE EXACT
 ;;R^"864.1:","864.11:2",1,"E"
 ;;D^X
 ;;R^"864.1:","864.11:3",.01,"E"
 ;;D^DATE INPUT FORMAT
 ;;R^"864.1:","864.11:4",.01,"E"
 ;;D^DATE LIMIT
 ;;R^"864.1:","864.11:5",.01,"E"
 ;;D^DATE MAXIMUM
 ;;R^"864.1:","864.11:6",.01,"E"
 ;;D^DATE MINIMUM
 ;;R^"864.1:","864.11:7",.01,"E"
 ;;D^DATE SECONDS
 ;;R^"864.1:","864.11:8",.01,"E"
 ;;D^DATE SPECIAL OUTPUT FORMAT
 ;;R^"864.1:","864.11:9",.01,"E"
 ;;D^DATE TIME
 ;;EOR^
 ;;KEY^864.1:^YES NO
 ;;R^"864.1:",.01,"E"
 ;;D^YES NO
 ;;R^"864.1:",.02,"E"
 ;;D^YES NO
 ;;R^"864.1:",2,"E"
 ;;D^BINARY
 ;;R^"864.1:","864.11:1",.01,"E"
 ;;D^VALUE CALL
 ;;R^"864.1:","864.11:1",1,"E"
 ;;D^BI^OCXFDBI
 ;;R^"864.1:","864.11:3",.01,"E"
 ;;D^TERMINATOR
 ;;R^"864.1:","864.11:4",.01,"E"
 ;;D^SET CODES
 ;;R^"864.1:","864.11:4",1,"E"
 ;;D^1:YES;0:NO
 ;;R^"864.1:","864.11:5",.01,"E"
 ;;D^QUERY
 ;;R^"864.1:","864.11:5",1,"E"
 ;;D^OK
 ;;R^"864.1:","864.11:6",.01,"E"
 ;;D^REPEAT THE QUERY
 ;;R^"864.1:","864.11:6",1,"E"
 ;;D^0
 ;;EOR^
 ;;KEY^864.1:^GENERIC
 ;;R^"864.1:",.01,"E"
 ;;D^GENERIC
 ;;R^"864.1:",.02,"E"
 ;;D^GENERIC
 ;;R^"864.1:","864.11:11",.01,"E"
 ;;D^MANDATORY MESSAGE
 ;;R^"864.1:","864.11:11",1,"E"
 ;;D^This answer is mandatory.  Enter a response or press '^' to exit.
 ;;R^"864.1:","864.11:12",.01,"E"
 ;;D^TERMINATOR
 ;;R^"864.1:","864.11:12",1,"E"
 ;;D^:
 ;;R^"864.1:","864.11:13",.01,"E"
 ;;D^LOOP QUERY
 ;;R^"864.1:","864.11:13",1,"E"
 ;;D^Enter another value
 ;;R^"864.1:","864.11:7",.01,"E"
 ;;D^VALUE CALL
 ;;R^"864.1:","864.11:7",1,"E"
 ;;D^GEN^OCXFDMOM
 ;;R^"864.1:","864.11:8",.01,"E"
 ;;D^QUERY
 ;;R^"864.1:","864.11:8",1,"E"
 ;;D^Enter a value
 ;;R^"864.1:","864.11:9",.01,"E"
 ;;D^HELP MESSAGE
 ;;R^"864.1:","864.11:9",1,"E"
 ;;D^ 
 ;;EOR^
 ;;KEY^864.1:^BINARY
 ;;R^"864.1:",.01,"E"
 ;;D^BINARY
 ;;R^"864.1:",.02,"E"
 ;;D^BINARY
 ;;R^"864.1:",2,"E"
 ;;D^GENERIC
 ;;R^"864.1:","864.11:1",.01,"E"
 ;;D^VALUE CALL
 ;;R^"864.1:","864.11:1",1,"E"
 ;;D^BI^OCXFDBI
 ;;R^"864.1:","864.11:2",.01,"E"
 ;;D^QUERY
 ;;R^"864.1:","864.11:2",1,"E"
 ;;D^Enter a value
 ;;R^"864.1:","864.11:3",.01,"E"
 ;;D^REPEAT THE QUERY
 ;;R^"864.1:","864.11:3",1,"E"
 ;;D^0
 ;;EOR^
 ;;KEY^864.1:^MUMPS EXPRESSION
 ;;R^"864.1:",.01,"E"
 ;;D^MUMPS EXPRESSION
 ;;R^"864.1:",.02,"E"
 ;;D^MEXPR
 ;;R^"864.1:",2,"E"
 ;;D^FREE TEXT
 ;;R^"864.1:","864.11:1",.01,"E"
 ;;D^QUERY
 ;;R^"864.1:","864.11:1",1,"E"
 ;;D^Enter a valid M expression
 ;;R^"864.1:","864.11:4",.01,"E"
 ;;D^DIALOGUE VALIDATION CODE
 ;;R^"864.1:","864.11:4",1,"E"
 ;;D^MEXPR^OCXFDFTE
 ;;R^"864.1:","864.11:5",.01,"E"
 ;;D^HELP MESSAGE
 ;;R^"864.1:","864.11:5",1,"E"
 ;;D^A MUMPS expression has some value and can be successfully substituted for the term {expr} in the following piece of code: S X={expr}; e.g., X, $E(Y), "ABC", etc.
 ;1;
 ;

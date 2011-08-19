OCXDI01A ;SLC/RJS,CLA - OCX PACKAGE DIAGNOSTIC ROUTINES ;SEP 7,1999 at 10:30
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
 G ^OCXDI01B
 ;
 Q
 ;
DATA ;
 ;
 ;;EOR^
 ;;KEY^864.1:^LINE TAG
 ;;R^"864.1:",.01,"E"
 ;;D^LINE TAG
 ;;R^"864.1:",.02,"E"
 ;;D^TAG
 ;;R^"864.1:",2,"E"
 ;;D^FREE TEXT
 ;;R^"864.1:","864.11:1",.01,"E"
 ;;D^QUERY
 ;;R^"864.1:","864.11:1",1,"E"
 ;;D^Entry reference (e.g., TAG^ROUTINE)
 ;;R^"864.1:","864.11:3",.01,"E"
 ;;D^HELP MESSAGE
 ;;R^"864.1:","864.11:3",1,"E"
 ;;D^Must be a valid entry reference such as 'XXX^YYYY' or '^ZZZZ'.  Note that the routine name must always be specified.  This reference does not need to exist yet.
 ;;R^"864.1:","864.11:5",.01,"E"
 ;;D^DIALOGUE VALIDATION CODE
 ;;R^"864.1:","864.11:5",1,"E"
 ;;D^TAG^OCXFDFTE
 ;;R^"864.1:","864.11:6",.01,"E"
 ;;D^VALUE CALL
 ;;R^"864.1:","864.11:6",1,"E"
 ;;D^FT^OCXFDFT
 ;;R^"864.1:","864.11:7",.01,"E"
 ;;D^REPEAT THE QUERY
 ;;R^"864.1:","864.11:7",1,"E"
 ;;D^0
 ;;R^"864.1:","864.11:8",.01,"E"
 ;;D^LOOP QUERY
 ;;R^"864.1:","864.11:8",1,"E"
 ;;D^Enter another entry reference
 ;;EOR^
 ;;KEY^864.1:^ENTRY REFERENCE
 ;;R^"864.1:",.01,"E"
 ;;D^ENTRY REFERENCE
 ;;R^"864.1:",.02,"E"
 ;;D^ENT REF
 ;;R^"864.1:",2,"E"
 ;;D^FREE TEXT
 ;;R^"864.1:","864.11:1",.01,"E"
 ;;D^QUERY
 ;;R^"864.1:","864.11:1",1,"E"
 ;;D^Entry reference (e.g., TAG^ROUTINE)
 ;;R^"864.1:","864.11:2",.01,"E"
 ;;D^HELP MESSAGE
 ;;R^"864.1:","864.11:2",1,"E"
 ;;D^Must be a valid entry reference such as 'XXX^YYYY' or '^ZZZ'.  Note that the routine name must always be specified.  The reference must actually exist to be validated.
 ;;R^"864.1:","864.11:4",.01,"E"
 ;;D^DIALOGUE VALIDATION CODE
 ;;R^"864.1:","864.11:4",1,"E"
 ;;D^EREF^OCXFDFTE
 ;;EOR^
 ;;KEY^864.1:^CODE STRING
 ;;R^"864.1:",.01,"E"
 ;;D^CODE STRING
 ;;R^"864.1:",.02,"E"
 ;;D^CODE
 ;;R^"864.1:",2,"E"
 ;;D^FREE TEXT
 ;;R^"864.1:","864.11:1",.01,"E"
 ;;D^QUERY
 ;;R^"864.1:","864.11:1",1,"E"
 ;;D^Enter a "Set of Codes" string
 ;;R^"864.1:","864.11:2",.01,"E"
 ;;D^HELP MESSAGE
 ;;R^"864.1:","864.11:2",1,"E"
 ;;D^This must be a valid FileMan "Set of Codes" string using the ";" and ":" delimeters; e.g., "1:YES;0:NO".  The maximum string length is 240 characters.
 ;;R^"864.1:","864.11:5",.01,"E"
 ;;D^DIALOGUE VALIDATION CODE
 ;;R^"864.1:","864.11:5",1,"E"
 ;;D^SCODE^OCXFDFTE
 ;;R^"864.1:","864.11:6",.01,"E"
 ;;D^ERROR MESSAGE
 ;;R^"864.1:","864.11:6",1,"E"
 ;;D^This must be a valid FileMan "Set of Codes" string using the ";" and ":" delimiters; e.g., "1:YES;0:NO".  The maximum string length is 240 characters.
 ;;R^"864.1:","864.11:7",.01,"E"
 ;;D^VALUE CALL
 ;;R^"864.1:","864.11:7",1,"E"
 ;;D^CS^OCXFDCS
 ;;R^"864.1:","864.11:8",.01,"E"
 ;;D^REPEAT THE QUERY
 ;;R^"864.1:","864.11:8",1,"E"
 ;;D^0
 ;;EOR^
 ;;KEY^864.1:^OPEN REFERENCE
 ;;R^"864.1:",.01,"E"
 ;;D^OPEN REFERENCE
 ;;R^"864.1:",.02,"E"
 ;;D^OREF
 ;;R^"864.1:",2,"E"
 ;;D^FREE TEXT
 ;;R^"864.1:","864.11:1",.01,"E"
 ;;D^QUERY
 ;;R^"864.1:","864.11:1",1,"E"
 ;;D^Enter a valid open reference
 ;;R^"864.1:","864.11:2",.01,"E"
 ;;D^HELP MESSAGE
 ;;R^"864.1:","864.11:2",1,"E"
 ;;D^An open reference has the format ^X(3, or ^ZZZ( or the local variable equivalent
 ;;R^"864.1:","864.11:3",.01,"E"
 ;;D^DIALOGUE VALIDATION CODE
 ;;R^"864.1:","864.11:3",1,"E"
 ;;D^OREF^OCXFDFTE
 ;;EOR^
 ;;KEY^864.1:^CLOSED REFERENCE
 ;;R^"864.1:",.01,"E"
 ;;D^CLOSED REFERENCE
 ;;R^"864.1:",.02,"E"
 ;;D^CREF
 ;;R^"864.1:",2,"E"
 ;;D^FREE TEXT
 ;;R^"864.1:","864.11:1",.01,"E"
 ;;D^QUERY
 ;;R^"864.1:","864.11:1",1,"E"
 ;;D^Enter a local or global reference
 ;;R^"864.1:","864.11:2",.01,"E"
 ;;D^HELP MESSAGE
 ;;R^"864.1:","864.11:2",1,"E"
 ;;D^This is a full local or global reference; e.g., ^XXX(3,5) or ^XXX or VAR(4) or VAR.
 ;;R^"864.1:","864.11:4",.01,"E"
 ;;D^DIALOGUE VALIDATION CODE
 ;;R^"864.1:","864.11:4",1,"E"
 ;;D^CREF^OCXFDFTE
 ;;R^"864.1:","864.11:5",.01,"E"
 ;;D^VALUE CALL
 ;;R^"864.1:","864.11:5",1,"E"
 ;;D^FT^OCXFDFT
 ;;R^"864.1:","864.11:6",.01,"E"
 ;;D^REPEAT THE QUERY
 ;;R^"864.1:","864.11:6",1,"E"
 ;;D^0
 ;;R^"864.1:","864.11:7",.01,"E"
 ;;D^LOOP QUERY
 ;;R^"864.1:","864.11:7",1,"E"
 ;;D^Enter another closed reference
 ;;EOR^
 ;;KEY^864.1:^FILEMAN DD LOCATION
 ;;R^"864.1:",.01,"E"
 ;;D^FILEMAN DD LOCATION
 ;;R^"864.1:",.02,"E"
 ;;D^FM DD
 ;;R^"864.1:",2,"E"
 ;;D^FREE TEXT
 ;;R^"864.1:","864.11:1",.01,"E"
 ;;D^QUERY
 ;;R^"864.1:","864.11:1",1,"E"
 ;;D^Enter Data Dictionary location ("file#,field#")
 ;;R^"864.1:","864.11:2",.01,"E"
 ;;D^HELP MESSAGE
 ;;R^"864.1:","864.11:2",1,"E"
 ;;D^This text string must have the following format: a valid FileMan file number followed by a comma followed by a valid field number for the file.
 ;;R^"864.1:","864.11:5",.01,"E"
 ;;D^DIALOGUE VALIDATION CODE
 ;;R^"864.1:","864.11:5",1,"E"
 ;;D^FMDD^OCXFDFTE
 ;;EOR^
 ;;KEY^864.1:^POSITIVE INTEGER
 ;1;
 ;

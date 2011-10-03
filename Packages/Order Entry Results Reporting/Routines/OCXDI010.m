OCXDI010 ;SLC/RJS,CLA - OCX PACKAGE DIAGNOSTIC ROUTINES ;SEP 7,1999 at 10:29
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
 G ^OCXDI011
 ;
 Q
 ;
DATA ;
 ;
 ;;R^"863.8:",1,2
 ;;D^or current year "".
 ;;R^"863.8:","863.84:6",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:6",1,"E"
 ;;D^Default time frame
 ;;R^"863.8:","863.84:8",.01,"E"
 ;;D^SET CODES
 ;;R^"863.8:","863.84:8",1,"E"
 ;;D^P:PAST;F:FUTURE
 ;;R^"863.8:","863.84:9",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:9",1,"E"
 ;;D^SET OF CODES
 ;;EOR^
 ;;KEY^863.8:^ERROR MESSAGE VARIABLE
 ;;R^"863.8:",.01,"E"
 ;;D^ERROR MESSAGE VARIABLE
 ;;R^"863.8:",.02,"E"
 ;;D^MSG VAR
 ;;R^"863.8:",1,1
 ;;D^A local or global variable (closed root format) which contains an error message array.
 ;;R^"863.8:",2,"E"
 ;;D^Y("ERROR")
 ;;R^"863.8:","863.84:3",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:3",1,"E"
 ;;D^Enter the closed root ot the message array
 ;;R^"863.8:","863.84:4",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:4",1,"E"
 ;;D^CLOSED REFERENCE
 ;;EOR^
 ;;KEY^863.8:^FILE
 ;;R^"863.8:",.01,"E"
 ;;D^FILE
 ;;R^"863.8:",.02,"E"
 ;;D^FILE
 ;;R^"863.8:",1,1
 ;;D^The internal entry number of a file.
 ;;R^"863.8:","863.84:6",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:6",1,"E"
 ;;D^File
 ;;R^"863.8:","863.84:7",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:7",1,"E"
 ;;D^POINTER TO A FILEMAN FILE
 ;;R^"863.8:","863.84:8",.01,"E"
 ;;D^DIC
 ;;R^"863.8:","863.84:8",1,"E"
 ;;D^1
 ;;EOR^
 ;;KEY^863.8:^INTERNAL ENTRY NUMBER STRING
 ;;R^"863.8:",.01,"E"
 ;;D^INTERNAL ENTRY NUMBER STRING
 ;;R^"863.8:",.02,"E"
 ;;D^IENS
 ;;R^"863.8:",1,1
 ;;D^Internal entry number string must follow FileMan database server
 ;;R^"863.8:",1,2
 ;;D^conventions; i.e., a string of IENs starting with a ',' and using
 ;;R^"863.8:",1,3
 ;;D^',' as delimiters.  Must end with a comma; e.g., ',67,'
 ;;R^"863.8:","863.84:4",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:4",1,"E"
 ;;D^Enter EINS string
 ;;R^"863.8:","863.84:5",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:5",1,"E"
 ;;D^FREE TEXT
 ;;EOR^
 ;;KEY^863.8:^DR STRING
 ;;R^"863.8:",.01,"E"
 ;;D^DR STRING
 ;;R^"863.8:",.02,"E"
 ;;D^DR STRING
 ;;R^"863.8:",1,1
 ;;D^A string of field numbers following the convention of ^DIE's 'DR' string.
 ;;R^"863.8:","863.84:4",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:4",1,"E"
 ;;D^Enter a DR string
 ;;R^"863.8:","863.84:5",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:5",1,"E"
 ;;D^FREE TEXT
 ;;R^"863.8:","863.84:6",.01,"E"
 ;;D^HELP MESSAGE
 ;;R^"863.8:","863.84:6",1,"E"
 ;;D^Enter a valid DR string to be passed to DIE
 ;;EOR^
 ;;KEY^863.8:^INDEX
 ;;R^"863.8:",.01,"E"
 ;;D^INDEX
 ;;R^"863.8:",.02,"E"
 ;;D^INDEX
 ;;R^"863.8:",1,1
 ;;D^The name of a FileMan index; e.g., 'B'
 ;;R^"863.8:",2,"E"
 ;;D^B
 ;;R^"863.8:","863.84:4",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:4",1,"E"
 ;;D^Name of index
 ;;R^"863.8:","863.84:5",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:5",1,"E"
 ;;D^FREE TEXT
 ;;R^"863.8:","863.84:6",.01,"E"
 ;;D^FREE TEXT MAXIMUM LENGTH
 ;;R^"863.8:","863.84:6",1,"E"
 ;;D^8
 ;;EOR^
 ;;KEY^863.8:^FLI FLAGS
 ;;R^"863.8:",.01,"E"
 ;;D^FLI FLAGS
 ;;R^"863.8:",.02,"E"
 ;;D^FLI FLAGS
 ;;R^"863.8:",1,1
 ;;D^B=TRAVERSE BACKWARDS,I=RETURN INTERNAL FORMAT
 ;;R^"863.8:","863.84:4",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:4",1,"E"
 ;;D^Lister flags (B,I)
 ;;R^"863.8:","863.84:5",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:5",1,"E"
 ;;D^FREE TEXT
 ;;EOR^
 ;;KEY^863.8:^FLI NUMBER OF ENTRIES
 ;;R^"863.8:",.01,"E"
 ;;D^FLI NUMBER OF ENTRIES
 ;;R^"863.8:",.02,"E"
 ;;D^FLI NUMBER
 ;;R^"863.8:",1,1
 ;;D^Number of entries to return
 ;;R^"863.8:",2,"E"
 ;;D^20
 ;;R^"863.8:","863.84:3",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:3",1,"E"
 ;;D^Number of entries to return
 ;;R^"863.8:","863.84:4",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:4",1,"E"
 ;;D^POSITIVE INTEGER
 ;;EOR^
 ;;KEY^863.8:^FLI FROM
 ;;R^"863.8:",.01,"E"
 ;;D^FLI FROM
 ;;R^"863.8:",.02,"E"
 ;;D^FLI FROM
 ;;R^"863.8:",1,1
 ;;D^Index entry from which to begin the list
 ;;R^"863.8:","863.84:4",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:4",1,"E"
 ;;D^Start list after
 ;;R^"863.8:","863.84:5",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:5",1,"E"
 ;;D^FREE TEXT
 ;;EOR^
 ;;KEY^863.8:^FLI RESTRICT MATCH
 ;;R^"863.8:",.01,"E"
 ;;D^FLI RESTRICT MATCH
 ;;R^"863.8:",.02,"E"
 ;;D^FLI PART
 ;;R^"863.8:",1,1
 ;;D^Partial match restriction (to index value, not the external value)
 ;;R^"863.8:","863.84:4",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:4",1,"E"
 ;;D^Return internal values which start with
 ;;R^"863.8:","863.84:5",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:5",1,"E"
 ;;D^FREE TEXT
 ;;EOR^
 ;;KEY^863.8:^FLI IDENTIFIER
 ;;R^"863.8:",.01,"E"
 ;;D^FLI IDENTIFIER
 ;;R^"863.8:",.02,"E"
 ;;D^FLI ID
 ;;R^"863.8:",1,1
 ;;D^Text to accompany each member of the returned list.  M code that calls
 ;;R^"863.8:",1,2
 ;;D^EN^DDIOL.  ID text follows FM identifier.  M code should not issue any
 ;;R^"863.8:",1,3
 ;;D^read or write commands.
 ;1;
 ;

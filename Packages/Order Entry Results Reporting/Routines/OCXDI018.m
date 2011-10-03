OCXDI018 ;SLC/RJS,CLA - OCX PACKAGE DIAGNOSTIC ROUTINES ;SEP 7,1999 at 10:30
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
 G ^OCXDI019
 ;
 Q
 ;
DATA ;
 ;
 ;;R^"863.8:","863.84:3",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:3",1,"E"
 ;;D^Is the query repetative
 ;;EOR^
 ;;KEY^863.8:^LOOP QUERY
 ;;R^"863.8:",.01,"E"
 ;;D^LOOP QUERY
 ;;R^"863.8:",.02,"E"
 ;;D^LOOP QUERY
 ;;R^"863.8:",1,1
 ;;D^Alternate query used when repeated answers are required
 ;;R^"863.8:","863.84:1",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:1",1,"E"
 ;;D^FREE TEXT
 ;;R^"863.8:","863.84:2",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:2",1,"E"
 ;;D^Enter loop query text
 ;;R^"863.8:","863.84:3",.01,"E"
 ;;D^HELP MESSAGE
 ;;R^"863.8:","863.84:3",1,"E"
 ;;D^This is the query text for all entries after the first one
 ;;EOR^
 ;;KEY^863.8:^ERROR MESSAGE
 ;;R^"863.8:",.01,"E"
 ;;D^ERROR MESSAGE
 ;;R^"863.8:",.02,"E"
 ;;D^EMSG
 ;;R^"863.8:",1,1
 ;;D^Error message used by reader
 ;;R^"863.8:",2,"E"
 ;;D^Invalid entry
 ;;R^"863.8:","863.84:1",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:1",1,"E"
 ;;D^FREE TEXT
 ;;R^"863.8:","863.84:2",.01,"E"
 ;;D^HELP MESSAGE
 ;;R^"863.8:","863.84:2",1,"E"
 ;;D^This message tells the user there has been an error.
 ;;R^"863.8:","863.84:3",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:3",1,"E"
 ;;D^Enter error message
 ;;EOR^
 ;;KEY^863.8:^FM SCREEN CODE
 ;;R^"863.8:",.01,"E"
 ;;D^FM SCREEN CODE
 ;;R^"863.8:",.02,"E"
 ;;D^FMDICS
 ;;EOR^
 ;;KEY^863.8:^MULTI SELECT
 ;;R^"863.8:",.01,"E"
 ;;D^MULTI SELECT
 ;;R^"863.8:",.02,"E"
 ;;D^MSEL
 ;;R^"863.8:",1,1
 ;;D^ 
 ;;R^"863.8:",1,2
 ;;D^  This parameter names a variable that holds a list of elements.
 ;;R^"863.8:","863.84:1",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:1",1,"E"
 ;;D^FREE TEXT
 ;;EOR^
 ;;KEY^863.8:^OCXO FILE POINTER
 ;;R^"863.8:",.01,"E"
 ;;D^OCXO FILE POINTER
 ;;EOR^
 ;;KEY^863.8:^OCXO SEMI-COLON PIECE NUMBER
 ;;R^"863.8:",.01,"E"
 ;;D^OCXO SEMI-COLON PIECE NUMBER
 ;;EOR^
 ;;KEY^863.8:^OCXO EXTERNAL FUNCTION CALL
 ;;R^"863.8:",.01,"E"
 ;;D^OCXO EXTERNAL FUNCTION CALL
 ;;EOR^
 ;;EOF^OCXS(863.8)^1
 ;;SOF^864.1  OCX MDD DATATYPE
 ;;KEY^864.1:^NUMERIC
 ;;R^"864.1:",.01,"E"
 ;;D^NUMERIC
 ;;R^"864.1:",.02,"E"
 ;;D^NUMERIC
 ;;R^"864.1:",2,"E"
 ;;D^GENERIC
 ;;R^"864.1:","864.11:1",.01,"E"
 ;;D^VALUE CALL
 ;;R^"864.1:","864.11:1",1,"E"
 ;;D^NU^OCXFDNU
 ;;R^"864.1:","864.11:2",.01,"E"
 ;;D^QUERY
 ;;R^"864.1:","864.11:2",1,"E"
 ;;D^Enter a number
 ;;R^"864.1:","864.11:3",.01,"E"
 ;;D^LOOP QUERY
 ;;R^"864.1:","864.11:3",1,"E"
 ;;D^Enter another number
 ;;R^"864.1:","864.11:4",.01,"E"
 ;;D^REPEAT THE QUERY
 ;;R^"864.1:","864.11:4",1,"E"
 ;;D^0
 ;;EOR^
 ;;KEY^864.1:^SET OF CODES
 ;;R^"864.1:",.01,"E"
 ;;D^SET OF CODES
 ;;R^"864.1:",.02,"E"
 ;;D^CODES
 ;;R^"864.1:",2,"E"
 ;;D^GENERIC
 ;;R^"864.1:","864.11:10",.01,"E"
 ;;D^HELP MESSAGE
 ;;R^"864.1:","864.11:10",1,"E"
 ;;D^Enter a code or a value from the list shown above.  Partial codes/values are OK as long as they are unambiguous.
 ;;R^"864.1:","864.11:11",.01,"E"
 ;;D^REPEAT THE QUERY
 ;;R^"864.1:","864.11:11",1,"E"
 ;;D^0
 ;;R^"864.1:","864.11:5",.01,"E"
 ;;D^FM MASK
 ;;R^"864.1:","864.11:6",.01,"E"
 ;;D^VALUE CALL
 ;;R^"864.1:","864.11:6",1,"E"
 ;;D^SC^OCXFDSC
 ;;R^"864.1:","864.11:8",.01,"E"
 ;;D^QUERY
 ;;R^"864.1:","864.11:8",1,"E"
 ;;D^Select a code from the list
 ;;R^"864.1:","864.11:9",.01,"E"
 ;;D^PROMPT
 ;;R^"864.1:","864.11:9",1,"E"
 ;;D^Your choice
 ;;EOR^
 ;;KEY^864.1:^FREE TEXT
 ;;R^"864.1:",.01,"E"
 ;;D^FREE TEXT
 ;;R^"864.1:",.02,"E"
 ;;D^FT
 ;;R^"864.1:",2,"E"
 ;;D^GENERIC
 ;;R^"864.1:","864.11:1",.01,"E"
 ;;D^VALUE CALL
 ;;R^"864.1:","864.11:1",1,"E"
 ;;D^FT^OCXFDFT
 ;;R^"864.1:","864.11:2",.01,"E"
 ;;D^QUERY
 ;;R^"864.1:","864.11:2",1,"E"
 ;;D^Enter a free text string
 ;;R^"864.1:","864.11:3",.01,"E"
 ;;D^FREE TEXT MAXIMUM LENGTH
 ;;R^"864.1:","864.11:3",1,"E"
 ;;D^240
 ;;R^"864.1:","864.11:4",.01,"E"
 ;;D^HELP MESSAGE
 ;;R^"864.1:","864.11:4",1,"E"
 ;;D^Enter a free text string.  Do not use control characters.  |FTMM HELP|
 ;;R^"864.1:","864.11:5",.01,"E"
 ;;D^LOOP QUERY
 ;;R^"864.1:","864.11:5",1,"E"
 ;;D^Enter another free text string
 ;;R^"864.1:","864.11:6",.01,"E"
 ;;D^REPEAT THE QUERY
 ;;R^"864.1:","864.11:6",1,"E"
 ;;D^0
 ;;EOR^
 ;;KEY^864.1:^WORD-PROCESSING
 ;;R^"864.1:",.01,"E"
 ;;D^WORD-PROCESSING
 ;;EOR^
 ;;KEY^864.1:^COMPUTED
 ;;R^"864.1:",.01,"E"
 ;;D^COMPUTED
 ;;EOR^
 ;;KEY^864.1:^POINTER TO A FILEMAN FILE
 ;;R^"864.1:",.01,"E"
 ;;D^POINTER TO A FILEMAN FILE
 ;;R^"864.1:",.02,"E"
 ;;D^POINTER
 ;;R^"864.1:",2,"E"
 ;;D^GENERIC
 ;;R^"864.1:","864.11:1",.01,"E"
 ;;D^QUERY
 ;;R^"864.1:","864.11:1",1,"E"
 ;;D^Enter the name of a record in the file
 ;;R^"864.1:","864.11:2",.01,"E"
 ;;D^HELP MESSAGE
 ;;R^"864.1:","864.11:2",1,"E"
 ;;D^Select the name of a specific entry in the file.  Type '??' to view possible choices.
 ;;R^"864.1:","864.11:3",.01,"E"
 ;;D^VALUE CALL
 ;;R^"864.1:","864.11:3",1,"E"
 ;;D^PT^OCXFDPT
 ;;R^"864.1:","864.11:4",.01,"E"
 ;1;
 ;

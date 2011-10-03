OCXDI015 ;SLC/RJS,CLA - OCX PACKAGE DIAGNOSTIC ROUTINES ;SEP 7,1999 at 10:29
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
 G ^OCXDI016
 ;
 Q
 ;
DATA ;
 ;
 ;;D^HELP MESSAGE
 ;;R^"863.8:","863.84:3",1,"E"
 ;;D^This is a free text string which asks the user if it is OK to delete an entry
 ;;EOR^
 ;;KEY^863.8:^FREE TEXT STRING
 ;;R^"863.8:",.01,"E"
 ;;D^FREE TEXT STRING
 ;;R^"863.8:",1,1
 ;;D^Any free text string up to 240 characters
 ;;EOR^
 ;;KEY^863.8:^FAILED LOOKUP OK
 ;;R^"863.8:",.01,"E"
 ;;D^FAILED LOOKUP OK
 ;;R^"863.8:",.02,"E"
 ;;D^PASS ALL
 ;;R^"863.8:",1,1
 ;;D^If this param = 1, the POINTER data type reader will accept an
 ;;R^"863.8:",1,2
 ;;D^invalid lookup.
 ;;R^"863.8:",2,"E"
 ;;D^0
 ;;R^"863.8:","863.84:1",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:1",1,"E"
 ;;D^YES NO
 ;;R^"863.8:","863.84:2",.01,"E"
 ;;D^HELP MESSAGE
 ;;R^"863.8:","863.84:2",1,"E"
 ;;D^Answer YES if you want the reader to supress an error message on a failed lookup.
 ;;R^"863.8:","863.84:3",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:3",1,"E"
 ;;D^Failed lookup OK
 ;;EOR^
 ;;KEY^863.8:^OLD LOOKUP
 ;;R^"863.8:",.01,"E"
 ;;D^OLD LOOKUP
 ;;R^"863.8:",.02,"E"
 ;;D^OLD
 ;;R^"863.8:",1,1
 ;;D^If = 1, do "old style" DIC lookup where an exact match is always
 ;;R^"863.8:",1,2
 ;;D^considered unambiguous.
 ;;R^"863.8:",2,"E"
 ;;D^0
 ;;R^"863.8:","863.84:1",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:1",1,"E"
 ;;D^YES NO
 ;;R^"863.8:","863.84:2",.01,"E"
 ;;D^HELP MESSAGE
 ;;R^"863.8:","863.84:2",1,"E"
 ;;D^Enter 'YES' if an exact match is always considered unambiguous.
 ;;R^"863.8:","863.84:3",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:3",1,"E"
 ;;D^Old style DIC lookup
 ;;EOR^
 ;;KEY^863.8:^BEEP
 ;;R^"863.8:",.01,"E"
 ;;D^BEEP
 ;;R^"863.8:",.02,"E"
 ;;D^BEEP
 ;;R^"863.8:",1,1
 ;;D^BEEP when asking a question or printing a message.
 ;;R^"863.8:",2,"E"
 ;;D^0
 ;;R^"863.8:","863.84:1",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:1",1,"E"
 ;;D^YES NO
 ;;R^"863.8:","863.84:2",.01,"E"
 ;;D^HELP MESSAGE
 ;;R^"863.8:","863.84:2",1,"E"
 ;;D^Enter yes to make the BEEP sound
 ;;R^"863.8:","863.84:3",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:3",1,"E"
 ;;D^Beep
 ;;EOR^
 ;;KEY^863.8:^PRIMARY DELIMITER
 ;;R^"863.8:",.01,"E"
 ;;D^PRIMARY DELIMITER
 ;;R^"863.8:",.02,"E"
 ;;D^PDEL
 ;;R^"863.8:",1,1
 ;;D^Separates pieces in a string
 ;;R^"863.8:","863.84:1",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:1",1,"E"
 ;;D^FREE TEXT
 ;;R^"863.8:","863.84:2",.01,"E"
 ;;D^HELP MESSAGE
 ;;R^"863.8:","863.84:2",1,"E"
 ;;D^Separates pieces of a string
 ;;R^"863.8:","863.84:3",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:3",1,"E"
 ;;D^Primary delimiter
 ;;R^"863.8:","863.84:4",.01,"E"
 ;;D^FREE TEXT MINIMUM LENGTH
 ;;R^"863.8:","863.84:4",1,"E"
 ;;D^1
 ;;R^"863.8:","863.84:5",.01,"E"
 ;;D^FREE TEXT MAXIMUM LENGTH
 ;;R^"863.8:","863.84:5",1,"E"
 ;;D^1
 ;;EOR^
 ;;KEY^863.8:^SECONDARY DELIMITER
 ;;R^"863.8:",.01,"E"
 ;;D^SECONDARY DELIMITER
 ;;R^"863.8:",.02,"E"
 ;;D^SDEL
 ;;R^"863.8:",1,1
 ;;D^Breaks each piece into elements
 ;;R^"863.8:","863.84:1",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:1",1,"E"
 ;;D^FREE TEXT
 ;;R^"863.8:","863.84:2",.01,"E"
 ;;D^EDIT CALL
 ;;R^"863.8:","863.84:2",1,"E"
 ;;D^Separates elements of each delimited piece
 ;;R^"863.8:","863.84:3",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:3",1,"E"
 ;;D^Secondary
 ;;R^"863.8:","863.84:4",.01,"E"
 ;;D^FREE TEXT MINIMUM LENGTH
 ;;R^"863.8:","863.84:4",1,"E"
 ;;D^1
 ;;R^"863.8:","863.84:5",.01,"E"
 ;;D^FREE TEXT MAXIMUM LENGTH
 ;;R^"863.8:","863.84:5",1,"E"
 ;;D^1
 ;;EOR^
 ;;KEY^863.8:^START WITH
 ;;R^"863.8:",.01,"E"
 ;;D^START WITH
 ;;R^"863.8:",.02,"E"
 ;;D^START WITH
 ;;R^"863.8:",1,1
 ;;D^Free text string stating point for generating a list.
 ;;R^"863.8:","863.84:1",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:1",1,"E"
 ;;D^FREE TEXT
 ;;R^"863.8:","863.84:2",.01,"E"
 ;;D^HELP MESSAGE
 ;;R^"863.8:","863.84:2",1,"E"
 ;;D^A free text sting designating the inclusive starting point
 ;;R^"863.8:","863.84:3",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:3",1,"E"
 ;;D^Starting point for list/search
 ;;R^"863.8:","863.84:4",.01,"E"
 ;;D^FREE TEXT MINIMUM LENGTH
 ;;R^"863.8:","863.84:4",1,"E"
 ;;D^1
 ;;R^"863.8:","863.84:5",.01,"E"
 ;;D^FREE TEXT MAXIMUM LENGTH
 ;;R^"863.8:","863.84:5",1,"E"
 ;;D^32
 ;;EOR^
 ;;KEY^863.8:^END WITH
 ;;R^"863.8:",.01,"E"
 ;;D^END WITH
 ;;R^"863.8:",.02,"E"
 ;;D^END WITH
 ;;R^"863.8:",1,1
 ;;D^Ending point of a list or search
 ;;R^"863.8:","863.84:1",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:1",1,"E"
 ;;D^FREE TEXT
 ;;R^"863.8:","863.84:2",.01,"E"
 ;;D^HELP MESSAGE
 ;;R^"863.8:","863.84:2",1,"E"
 ;;D^Ending point of search/list
 ;;R^"863.8:","863.84:3",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:3",1,"E"
 ;;D^Ending point of list/search
 ;;R^"863.8:","863.84:4",.01,"E"
 ;;D^FREE TEXT MINIMUM LENGTH
 ;;R^"863.8:","863.84:4",1,"E"
 ;;D^1
 ;;R^"863.8:","863.84:5",.01,"E"
 ;;D^FREE TEXT MAXIMUM LENGTH
 ;;R^"863.8:","863.84:5",1,"E"
 ;1;
 ;

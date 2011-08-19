OCXDI014 ;SLC/RJS,CLA - OCX PACKAGE DIAGNOSTIC ROUTINES ;SEP 7,1999 at 10:29
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
 G ^OCXDI015
 ;
 Q
 ;
DATA ;
 ;
 ;;R^"863.8:",.02,"E"
 ;;D^DICS
 ;;R^"863.8:",1,1
 ;;D^Contains DIC("S") code for a DIC lookup
 ;;R^"863.8:","863.84:1",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:1",1,"E"
 ;;D^Enter M code to be used in DIC("S")
 ;;R^"863.8:","863.84:2",.01,"E"
 ;;D^HELP MESSAGE
 ;;R^"863.8:","863.84:2",1,"E"
 ;;D^This is valid M code which sets $T to 1 if the lookup passes the screen.
 ;;R^"863.8:","863.84:3",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:3",1,"E"
 ;;D^MUMPS CODE
 ;;EOR^
 ;;KEY^863.8:^DIC LOOKUP INDEX STRING
 ;;R^"863.8:",.01,"E"
 ;;D^DIC LOOKUP INDEX STRING
 ;;R^"863.8:",.02,"E"
 ;;D^DICIX
 ;;R^"863.8:",1,1
 ;;D^Contains the names of indices to be used in a DIC lookup in a comma
 ;;R^"863.8:",1,2
 ;;D^delimited string.
 ;;R^"863.8:","863.84:1",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:1",1,"E"
 ;;D^FREE TEXT
 ;;R^"863.8:","863.84:2",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:2",1,"E"
 ;;D^Enter a DIC lookup index string
 ;;R^"863.8:","863.84:3",.01,"E"
 ;;D^HELP MESSAGE
 ;;R^"863.8:","863.84:3",1,"E"
 ;;D^This is an '^' delimited string which contains the names of indices which are to be used in a DIC lookup; e.g., B^C^DOB.
 ;;EOR^
 ;;KEY^863.8:^FAILED LOOKUP MESSAGE
 ;;R^"863.8:",.01,"E"
 ;;D^FAILED LOOKUP MESSAGE
 ;;R^"863.8:",.02,"E"
 ;;D^FLK MSG
 ;;R^"863.8:",1,1
 ;;D^Pointer data type dialogue message to the end user that his entry failed
 ;;R^"863.8:",1,2
 ;;D^the lookup.
 ;;R^"863.8:",2,"E"
 ;;D^Sorry, there are no choices which match your entry...
 ;;R^"863.8:","863.84:1",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:1",1,"E"
 ;;D^FREE TEXT
 ;;R^"863.8:","863.84:2",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:2",1,"E"
 ;;D^Enter a free text message to let the user know that the lookup failed
 ;;EOR^
 ;;KEY^863.8:^HELP FRAME MESSAGE
 ;;R^"863.8:",.01,"E"
 ;;D^HELP FRAME MESSAGE
 ;;R^"863.8:",.02,"E"
 ;;D^HF MSG
 ;;R^"863.8:",1,1
 ;;D^Message to the user that, in addition to the normal help text, a help
 ;;R^"863.8:",1,2
 ;;D^frame is available.
 ;;R^"863.8:",2,"E"
 ;;D^Do you want to view a more detailed help message
 ;;R^"863.8:","863.84:1",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:1",1,"E"
 ;;D^FREE TEXT
 ;;R^"863.8:","863.84:2",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:2",1,"E"
 ;;D^Help frame request message
 ;;EOR^
 ;;KEY^863.8:^PAGE FEED
 ;;R^"863.8:",.01,"E"
 ;;D^PAGE FEED
 ;;R^"863.8:",.02,"E"
 ;;D^PAGE
 ;;R^"863.8:",1,1
 ;;D^Issue a page feed
 ;;R^"863.8:",2,"E"
 ;;D^0
 ;;R^"863.8:","863.84:1",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:1",1,"E"
 ;;D^YES NO
 ;;EOR^
 ;;KEY^863.8:^READER REDIRECTION
 ;;R^"863.8:",.01,"E"
 ;;D^READER REDIRECTION
 ;;R^"863.8:",.02,"E"
 ;;D^RED
 ;;R^"863.8:",1,1
 ;;D^If the READER method sees this variable, it will bypass asking the user for
 ;;R^"863.8:",1,2
 ;;D^a value and use the value stored in 'RED'
 ;;R^"863.8:","863.84:1",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:1",1,"E"
 ;;D^FREE TEXT
 ;;R^"863.8:","863.84:2",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:2",1,"E"
 ;;D^Enter a value to be sent to the reader
 ;;R^"863.8:","863.84:3",.01,"E"
 ;;D^HELP MESSAGE
 ;;R^"863.8:","863.84:3",1,"E"
 ;;D^When the READER method sees this value, it will bypass the user query and take this value instead
 ;;EOR^
 ;;KEY^863.8:^DICW
 ;;R^"863.8:",.01,"E"
 ;;D^DICW
 ;;R^"863.8:",.02,"E"
 ;;D^DICW
 ;;R^"863.8:",1,1
 ;;D^A M commmand string equivalent to DIC("W")
 ;;R^"863.8:","863.84:1",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:1",1,"E"
 ;;D^MUMPS CODE
 ;;R^"863.8:","863.84:2",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:2",1,"E"
 ;;D^Enter DIC('W') code
 ;;R^"863.8:","863.84:3",.01,"E"
 ;;D^HELP MESSAGE
 ;;R^"863.8:","863.84:3",1,"E"
 ;;D^M command code equivalent to DIC("W")
 ;;EOR^
 ;;KEY^863.8:^COUNT
 ;;R^"863.8:",.01,"E"
 ;;D^COUNT
 ;;R^"863.8:",.02,"E"
 ;;D^COUNT
 ;;R^"863.8:",1,1
 ;;D^This is the number of entries in a file
 ;;R^"863.8:","863.84:1",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:1",1,"E"
 ;;D^Enter the number of entries in the file
 ;;R^"863.8:","863.84:2",.01,"E"
 ;;D^HELP MESSAGE
 ;;R^"863.8:","863.84:2",1,"E"
 ;;D^This corresponds to the 4th piece of FileMan's dictionary node
 ;;R^"863.8:","863.84:3",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:3",1,"E"
 ;;D^POSITIVE INTEGER
 ;;EOR^
 ;;KEY^863.8:^VOID
 ;;R^"863.8:",.01,"E"
 ;;D^VOID
 ;;R^"863.8:",.02,"E"
 ;;D^VOID
 ;;R^"863.8:",1,1
 ;;D^If the user enters a "@" and this parameter '="", the user is asked if
 ;;R^"863.8:",1,2
 ;;D^he is sure that he wants to delete the value.
 ;;R^"863.8:",2,"E"
 ;;D^ 
 ;;R^"863.8:","863.84:1",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:1",1,"E"
 ;;D^FREE TEXT
 ;;R^"863.8:","863.84:2",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:2",1,"E"
 ;;D^Enter 'OK TO DELETE' message
 ;;R^"863.8:","863.84:3",.01,"E"
 ;1;
 ;

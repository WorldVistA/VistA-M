OCXDI016 ;SLC/RJS,CLA - OCX PACKAGE DIAGNOSTIC ROUTINES ;SEP 7,1999 at 10:30
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
 G ^OCXDI017
 ;
 Q
 ;
DATA ;
 ;
 ;;D^32
 ;;EOR^
 ;;KEY^863.8:^MESSAGE
 ;;R^"863.8:",.01,"E"
 ;;D^MESSAGE
 ;;R^"863.8:",.02,"E"
 ;;D^MESSAGE
 ;;R^"863.8:",1,1
 ;;D^Free text string
 ;;R^"863.8:","863.84:1",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:1",1,"E"
 ;;D^FREE TEXT
 ;;R^"863.8:","863.84:2",.01,"E"
 ;;D^HELP MESSAGE
 ;;R^"863.8:","863.84:2",1,"E"
 ;;D^This is a free text string which will be displayed for the user.
 ;;R^"863.8:","863.84:3",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:3",1,"E"
 ;;D^Message
 ;;EOR^
 ;;KEY^863.8:^POINTER REFERENCE
 ;;R^"863.8:",.01,"E"
 ;;D^POINTER REFERENCE
 ;;R^"863.8:",.02,"E"
 ;;D^POINTER
 ;;R^"863.8:",1,1
 ;;D^This is a closed global reference which contains the free text value of
 ;;R^"863.8:",1,2
 ;;D^a pointer as the 1st piece of the zero node.
 ;;R^"863.8:","863.84:1",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:1",1,"E"
 ;;D^FREE TEXT
 ;;R^"863.8:","863.84:2",.01,"E"
 ;;D^HELP MESSAGE
 ;;R^"863.8:","863.84:2",1,"E"
 ;;D^A closed global reference used for subscript indirection such that the 1st piece of the zero node contains the free text value of the pointer (e.g., '^DPT' is the closed reference for a patients name).
 ;;R^"863.8:","863.84:3",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:3",1,"E"
 ;;D^Pointer reference
 ;;EOR^
 ;;KEY^863.8:^LOOKUP VALUE
 ;;R^"863.8:",.01,"E"
 ;;D^LOOKUP VALUE
 ;;R^"863.8:",.02,"E"
 ;;D^LOOK
 ;;R^"863.8:",1,1
 ;;D^A free text string used as a DIC lookup value
 ;;R^"863.8:","863.84:1",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:1",1,"E"
 ;;D^FREE TEXT
 ;;R^"863.8:","863.84:2",.01,"E"
 ;;D^HELP MESSAGE
 ;;R^"863.8:","863.84:2",1,"E"
 ;;D^A free text string used as a valid DIC lookup value
 ;;R^"863.8:","863.84:3",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:3",1,"E"
 ;;D^Lookup value
 ;;R^"863.8:","863.84:4",.01,"E"
 ;;D^FREE TEXT MAXIMUM LENGTH
 ;;R^"863.8:","863.84:4",1,"E"
 ;;D^32
 ;;EOR^
 ;;KEY^863.8:^INDEX STRING
 ;;R^"863.8:",.01,"E"
 ;;D^INDEX STRING
 ;;R^"863.8:",.02,"E"
 ;;D^ISTRING
 ;;R^"863.8:",1,1
 ;;D^A string of indexes to be used by DIC in FileMan format; e.g.,
 ;;R^"863.8:",1,2
 ;;D^'B^C^ADOB'.  Lookup will follow the order of indexes specified in the string
 ;;R^"863.8:","863.84:1",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:1",1,"E"
 ;;D^FREE TEXT
 ;;R^"863.8:","863.84:2",.01,"E"
 ;;D^HELP MESSAGE
 ;;R^"863.8:","863.84:2",1,"E"
 ;;D^Enter string of index names separated by a '^' delimiter; e.g., 'B^C^ADOB'.  The order of indexes determines the order of the lookup. 
 ;;R^"863.8:","863.84:3",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:3",1,"E"
 ;;D^Index string
 ;;EOR^
 ;;KEY^863.8:^PARAMETER IEN
 ;;R^"863.8:",.01,"E"
 ;;D^PARAMETER IEN
 ;;R^"863.8:",.02,"E"
 ;;D^PIEN
 ;;R^"863.8:",1,1
 ;;D^A parameter internal entry number
 ;;R^"863.8:","863.84:1",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:1",1,"E"
 ;;D^POINTER TO A FILEMAN FILE
 ;;R^"863.8:","863.84:2",.01,"E"
 ;;D^HELP MESSAGE
 ;;R^"863.8:","863.84:2",1,"E"
 ;;D^Enter the name of a parameter
 ;;R^"863.8:","863.84:3",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:3",1,"E"
 ;;D^Parameter
 ;;R^"863.8:","863.84:4",.01,"E"
 ;;D^DIC
 ;;R^"863.8:","863.84:4",1,"E"
 ;;D^863.8
 ;;EOR^
 ;;KEY^863.8:^METHOD
 ;;R^"863.8:",.01,"E"
 ;;D^METHOD
 ;;R^"863.8:",.02,"E"
 ;;D^METHOD
 ;;R^"863.8:",1,1
 ;;D^The IEN of a method
 ;;R^"863.8:","863.84:1",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:1",1,"E"
 ;;D^POINTER TO A FILEMAN FILE
 ;;R^"863.8:","863.84:2",.01,"E"
 ;;D^HELP MESSAGE
 ;;R^"863.8:","863.84:2",1,"E"
 ;;D^Enter the name of a method
 ;;R^"863.8:","863.84:3",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:3",1,"E"
 ;;D^Method
 ;;R^"863.8:","863.84:4",.01,"E"
 ;;D^DIC
 ;;R^"863.8:","863.84:4",1,"E"
 ;;D^863.6
 ;;EOR^
 ;;KEY^863.8:^OVERRIDE ARRAY
 ;;R^"863.8:",.01,"E"
 ;;D^OVERRIDE ARRAY
 ;;R^"863.8:",.02,"E"
 ;;D^OVRAY
 ;;R^"863.8:",1,1
 ;;D^The closed reference for the ^OCXM override array
 ;;R^"863.8:",2,"E"
 ;;D^OCXM
 ;;R^"863.8:","863.84:1",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:1",1,"E"
 ;;D^CLOSED REFERENCE
 ;;R^"863.8:","863.84:2",.01,"E"
 ;;D^HELP MESSAGE
 ;;R^"863.8:","863.84:2",1,"E"
 ;;D^A variable name, usually 'OCXM'
 ;;R^"863.8:","863.84:3",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:3",1,"E"
 ;;D^Override array reference
 ;;EOR^
 ;;KEY^863.8:^TRANSFORM
 ;;R^"863.8:",.01,"E"
 ;;D^TRANSFORM
 ;;R^"863.8:",.02,"E"
 ;;D^TRANSFORM
 ;;R^"863.8:",1,1
 ;;D^If 'YES' do an output transform
 ;;R^"863.8:","863.84:1",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:1",1,"E"
 ;;D^YES NO
 ;;R^"863.8:","863.84:2",.01,"E"
 ;;D^HELP MESSAGE
 ;;R^"863.8:","863.84:2",1,"E"
 ;;D^Answer 'YES' to do an output transform
 ;;R^"863.8:","863.84:3",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:3",1,"E"
 ;;D^OK to do an output transform
 ;;EOR^
 ;;KEY^863.8:^BRIEF NAME OK
 ;;R^"863.8:",.01,"E"
 ;1;
 ;

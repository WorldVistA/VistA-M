OCXDI012 ;SLC/RJS,CLA - OCX PACKAGE DIAGNOSTIC ROUTINES ;SEP 7,1999 at 10:29
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
 G ^OCXDI013
 ;
 Q
 ;
DATA ;
 ;
 ;;D^MUMPS CODE
 ;;EOR^
 ;;KEY^863.8:^SCREEN LENGTH
 ;;R^"863.8:",.01,"E"
 ;;D^SCREEN LENGTH
 ;;R^"863.8:",.02,"E"
 ;;D^IOSL
 ;;R^"863.8:",1,1
 ;;D^Vertical screen size
 ;;R^"863.8:","863.84:3",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:3",1,"E"
 ;;D^POSITIVE INTEGER
 ;;R^"863.8:","863.84:4",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:4",1,"E"
 ;;D^Enter the number of lines on the display screen
 ;;EOR^
 ;;KEY^863.8:^LIST EMPTY MESSAGE
 ;;R^"863.8:",.01,"E"
 ;;D^LIST EMPTY MESSAGE
 ;;R^"863.8:",1,1
 ;;D^Message sent to user if he attempts to list an empty array
 ;;R^"863.8:","863.84:4",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:4",1,"E"
 ;;D^FREE TEXT
 ;;EOR^
 ;;KEY^863.8:^POINTER GLOBAL
 ;;R^"863.8:",.01,"E"
 ;;D^POINTER GLOBAL
 ;;R^"863.8:",1,1
 ;;D^Closed reference of a pointed to global
 ;;R^"863.8:","863.84:4",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:4",1,"E"
 ;;D^CLOSED REFERENCE
 ;;EOR^
 ;;KEY^863.8:^INTERNAL ENTRY NUMBER
 ;;R^"863.8:",.01,"E"
 ;;D^INTERNAL ENTRY NUMBER
 ;;R^"863.8:",.02,"E"
 ;;D^IEN
 ;;R^"863.8:",1,1
 ;;D^FileMan internal entry number
 ;;R^"863.8:","863.84:3",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:3",1,"E"
 ;;D^Enter IEN
 ;;R^"863.8:","863.84:4",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:4",1,"E"
 ;;D^NUMERIC
 ;;R^"863.8:","863.84:5",.01,"E"
 ;;D^NUMERIC DECIMAL PLACES
 ;;R^"863.8:","863.84:5",1,"E"
 ;;D^6
 ;;EOR^
 ;;KEY^863.8:^FIELD NAME
 ;;R^"863.8:",.01,"E"
 ;;D^FIELD NAME
 ;;R^"863.8:",1,1
 ;;D^The name of a FileMan field
 ;;R^"863.8:","863.84:4",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:4",1,"E"
 ;;D^FREE TEXT
 ;;R^"863.8:","863.84:5",.01,"E"
 ;;D^FREE TEXT MAXIMUM LENGTH
 ;;R^"863.8:","863.84:5",1,"E"
 ;;D^30
 ;;EOR^
 ;;KEY^863.8:^OBJECT NAME
 ;;R^"863.8:",.01,"E"
 ;;D^OBJECT NAME
 ;;R^"863.8:",1,1
 ;;D^The name of an object
 ;;R^"863.8:","863.84:4",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:4",1,"E"
 ;;D^FREE TEXT
 ;;R^"863.8:","863.84:5",.01,"E"
 ;;D^FREE TEXT MAXIMUM LENGTH
 ;;R^"863.8:","863.84:5",1,"E"
 ;;D^30
 ;;EOR^
 ;;KEY^863.8:^FORCE DELETION
 ;;R^"863.8:",.01,"E"
 ;;D^FORCE DELETION
 ;;R^"863.8:",1,1
 ;;D^If this param=1 deletion will be forced without getting confirmation from the user
 ;;R^"863.8:","863.84:7",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:7",1,"E"
 ;;D^SET OF CODES
 ;;R^"863.8:","863.84:8",.01,"E"
 ;;D^SET CODES
 ;;R^"863.8:","863.84:8",1,"E"
 ;;D^1:FORCE DELETION;0:ASK USER IF OK TO DELETE
 ;;EOR^
 ;;KEY^863.8:^BUILD CALL
 ;;R^"863.8:",.01,"E"
 ;;D^BUILD CALL
 ;;R^"863.8:",.02,"E"
 ;;D^BUILD CALL
 ;;R^"863.8:",1,1
 ;;D^Option to build the code of a method
 ;;R^"863.8:",2,"E"
 ;;D^BUILD^OCXCM1
 ;;R^"863.8:","863.84:3",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:3",1,"E"
 ;;D^Enter the TAG^ROUTINE of the CASE tool
 ;;R^"863.8:","863.84:4",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:4",1,"E"
 ;;D^LINE TAG
 ;;EOR^
 ;;KEY^863.8:^PRINT TEMPLATE
 ;;R^"863.8:",.01,"E"
 ;;D^PRINT TEMPLATE
 ;;R^"863.8:","863.84:6",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:6",1,"E"
 ;;D^Enter print template
 ;;R^"863.8:","863.84:7",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:7",1,"E"
 ;;D^POINTER TO A FILEMAN FILE
 ;;R^"863.8:","863.84:8",.01,"E"
 ;;D^DIC
 ;;R^"863.8:","863.84:8",1,"E"
 ;;D^.4
 ;;EOR^
 ;;KEY^863.8:^MANDATORY MESSAGE
 ;;R^"863.8:",.01,"E"
 ;;D^MANDATORY MESSAGE
 ;;R^"863.8:",.02,"E"
 ;;D^MAND MSG
 ;;R^"863.8:",1,1
 ;;D^Message sent to user teling him that his entry is mandatory
 ;;R^"863.8:",2,"E"
 ;;D^Mandatory answer.  You must enter a value or '^' to exit.
 ;;R^"863.8:","863.84:4",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:4",1,"E"
 ;;D^Enter message
 ;;R^"863.8:","863.84:5",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:5",1,"E"
 ;;D^FREE TEXT
 ;;EOR^
 ;;KEY^863.8:^DIALOGUE VALIDATION CODE
 ;;R^"863.8:",.01,"E"
 ;;D^DIALOGUE VALIDATION CODE
 ;;R^"863.8:",.02,"E"
 ;;D^DT VAL
 ;;R^"863.8:",1,1
 ;;D^M extrinsic function which sets $T to 1 if the internal value (stored in'X') is valid
 ;;R^"863.8:","863.84:3",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:3",1,"E"
 ;;D^Enter validation code
 ;;R^"863.8:","863.84:4",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:4",1,"E"
 ;;D^LINE TAG
 ;;EOR^
 ;;KEY^863.8:^DIALOGUE INPUT VALIDATION
 ;;R^"863.8:",.01,"E"
 ;;D^DIALOGUE INPUT VALIDATION
 ;;R^"863.8:",.02,"E"
 ;;D^DT IVAL
 ;;R^"863.8:",1,1
 ;;D^M code which set $T to 1 if the user input (stored in'X') is valid
 ;;R^"863.8:","863.84:3",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:3",1,"E"
 ;;D^Enter input validation code
 ;;R^"863.8:","863.84:4",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:4",1,"E"
 ;;D^LINE TAG
 ;;EOR^
 ;;KEY^863.8:^DIALOGUE INPUT TRANSFORM
 ;;R^"863.8:",.01,"E"
 ;;D^DIALOGUE INPUT TRANSFORM
 ;;R^"863.8:",.02,"E"
 ;;D^DT IT
 ;;R^"863.8:",1,1
 ;;D^M expression which transforms the external value (stored in 'X') to the
 ;;R^"863.8:",1,2
 ;1;
 ;

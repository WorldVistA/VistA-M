OCXDI01E ;SLC/RJS,CLA - OCX PACKAGE DIAGNOSTIC ROUTINES ;SEP 7,1999 at 10:30
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
 G ^OCXDI01F
 ;
 Q
 ;
DATA ;
 ;
 ;;R^"863.7:",.01,"E"
 ;;D^STUFF
 ;;R^"863.7:",.02,"E"
 ;;D^PARAMETERIZED SUBROUTINE
 ;;R^"863.7:",1,"E"
 ;;D^Stuff a value into a string "window"
 ;;R^"863.7:",2,1
 ;;D^Given the string X with vertical bar windows containing parameter names,
 ;;R^"863.7:",2,2
 ;;D^replace the window with the value of the specified parameters.
 ;;R^"863.7:",3,"E"
 ;;D^STUFF^OCXF
 ;;R^"863.7:","863.74:1",.01,"E"
 ;;D^CLOSED REFERENCE
 ;;R^"863.7:","863.74:1",1.1,"E"
 ;;D^2
 ;;R^"863.7:","863.74:1",1.2,"E"
 ;;D^Y
 ;;R^"863.7:","863.74:2",.01,"E"
 ;;D^TEXT STRING
 ;;R^"863.7:","863.74:2",1.1,"E"
 ;;D^1
 ;;R^"863.7:","863.74:2",1.2,"E"
 ;;D^X
 ;;EOR^
 ;;KEY^863.7:^OVERRIDE ARRAY STRING
 ;;R^"863.7:",.01,"E"
 ;;D^OVERRIDE ARRAY STRING
 ;;R^"863.7:",.02,"E"
 ;;D^PARAMETERIZED SUBROUTINE
 ;;R^"863.7:",1,"E"
 ;;D^Converts a delimited string to an array
 ;;R^"863.7:",2,1
 ;;D^Given string X and closed array reference V, the delimiter A marks the array
 ;;R^"863.7:",2,2
 ;;D^variable and the delimiter B marks the value.
 ;;R^"863.7:",3,"E"
 ;;D^ASTG^OCXF
 ;;R^"863.7:","863.74:1",.01,"E"
 ;;D^FREE TEXT STRING
 ;;R^"863.7:","863.74:1",1.1,"E"
 ;;D^1
 ;;R^"863.7:","863.74:1",1.2,"E"
 ;;D^X
 ;;R^"863.7:","863.74:2",.01,"E"
 ;;D^PRIMARY DELIMITER
 ;;R^"863.7:","863.74:2",1.1,"E"
 ;;D^2
 ;;R^"863.7:","863.74:2",1.2,"E"
 ;;D^V
 ;;R^"863.7:","863.74:3",.01,"E"
 ;;D^SECONDARY DELIMITER
 ;;R^"863.7:","863.74:3",1.1,"E"
 ;;D^3
 ;;R^"863.7:","863.74:3",1.2,"E"
 ;;D^A
 ;;R^"863.7:","863.74:4",.01,"E"
 ;;D^CLOSED REFERENCE
 ;;R^"863.7:","863.74:4",1.1,"E"
 ;;D^4
 ;;R^"863.7:","863.74:4",1.2,"E"
 ;;D^B
 ;;EOR^
 ;;KEY^863.7:^TEST
 ;;R^"863.7:",.01,"E"
 ;;D^TEST
 ;;R^"863.7:",.02,"E"
 ;;D^PARAMETERIZED SUBROUTINE
 ;;R^"863.7:",1,"E"
 ;;D^XXX
 ;;R^"863.7:",2,1
 ;;D^XXXXX
 ;;R^"863.7:",3,"E"
 ;;D^BRK^OCXF
 ;;R^"863.7:","863.74:1",.01,"E"
 ;;D^FREE TEXT MAXIMUM LENGTH
 ;;R^"863.7:","863.74:1",1.1,"E"
 ;;D^1
 ;;R^"863.7:","863.74:1",1.2,"E"
 ;;D^X
 ;;R^"863.7:","863.74:2",.01,"E"
 ;;D^CLOSED REFERENCE
 ;;R^"863.7:","863.74:2",1.1,"E"
 ;;D^2
 ;;R^"863.7:","863.74:2",1.2,"E"
 ;;D^Y
 ;;R^"863.7:","863.74:3",.01,"E"
 ;;D^FILE
 ;;R^"863.7:","863.74:3",1.1,"E"
 ;;D^3
 ;;R^"863.7:","863.74:3",1.2,"E"
 ;;D^T
 ;;R^"863.7:","863.74:4",.01,"E"
 ;;D^FIELD NAME
 ;;R^"863.7:","863.74:4",1.1,"E"
 ;;D^4
 ;;R^"863.7:","863.74:4",1.2,"E"
 ;;D^F
 ;;EOR^
 ;;KEY^863.7:^PAUSE
 ;;R^"863.7:",.01,"E"
 ;;D^PAUSE
 ;;R^"863.7:",.02,"E"
 ;;D^PARAMETERIZED SUBROUTINE
 ;;R^"863.7:",1,"E"
 ;;D^End of screen message: '<>'
 ;;R^"863.7:",2,1
 ;;D^'^' of '^^' or <RETURN>
 ;;R^"863.7:",3,"E"
 ;;D^PAUSE^OCXF
 ;;EOR^
 ;;KEY^863.7:^LIST
 ;;R^"863.7:",.01,"E"
 ;;D^LIST
 ;;R^"863.7:",.02,"E"
 ;;D^PARAMETERIZED SUBROUTINE
 ;;R^"863.7:",1,"E"
 ;;D^Manages the display of a list
 ;;R^"863.7:",2,1
 ;;D^Manages the display of a simple list on the screen (including pauses).
 ;;R^"863.7:",3,"E"
 ;;D^LIST^OCXF1
 ;;R^"863.7:","863.74:1",.01,"E"
 ;;D^CLOSED REFERENCE
 ;;R^"863.7:","863.74:1",1.1,"E"
 ;;D^1
 ;;R^"863.7:","863.74:1",1.2,"E"
 ;;D^G
 ;;R^"863.7:","863.74:2",.01,"E"
 ;;D^START WITH
 ;;R^"863.7:","863.74:2",1.1,"E"
 ;;D^2
 ;;R^"863.7:","863.74:2",1.2,"E"
 ;;D^S
 ;;R^"863.7:","863.74:3",.01,"E"
 ;;D^END WITH
 ;;R^"863.7:","863.74:3",1.1,"E"
 ;;D^3
 ;;R^"863.7:","863.74:3",1.2,"E"
 ;;D^E
 ;;R^"863.7:","863.74:4",.01,"E"
 ;;D^OUTPUT TRANSFORM
 ;;R^"863.7:","863.74:4",1.1,"E"
 ;;D^4
 ;;R^"863.7:","863.74:4",1.2,"E"
 ;;D^O
 ;;R^"863.7:","863.74:5",.01,"E"
 ;;D^SCREEN LENGTH
 ;;R^"863.7:","863.74:5",1.1,"E"
 ;;D^5
 ;;R^"863.7:","863.74:5",1.2,"E"
 ;;D^L
 ;;R^"863.7:","863.74:6",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.7:","863.74:6",1.1,"E"
 ;;D^6
 ;;R^"863.7:","863.74:6",1.2,"E"
 ;;D^T
 ;;R^"863.7:","863.74:7",.01,"E"
 ;;D^MESSAGE
 ;;R^"863.7:","863.74:7",1.1,"E"
 ;;D^7
 ;;R^"863.7:","863.74:7",1.2,"E"
 ;;D^M
 ;;R^"863.7:","863.74:8",.01,"E"
 ;;D^POINTER REFERENCE
 ;;R^"863.7:","863.74:8",1.1,"E"
 ;;D^8
 ;;R^"863.7:","863.74:8",1.2,"E"
 ;;D^R
 ;;EOR^
 ;;KEY^863.7:^QLIST
 ;;R^"863.7:",.01,"E"
 ;;D^QLIST
 ;;R^"863.7:",.02,"E"
 ;;D^PARAMETERIZED SUBROUTINE
 ;;R^"863.7:",1,"E"
 ;;D^Quick list
 ;;R^"863.7:",2,1
 ;;D^A "lite" form of LIST^OCXF1.  Only require 2 variables: the source global
 ;;R^"863.7:",2,2
 ;;D^and the TAB
 ;;R^"863.7:",3,"E"
 ;;D^QLIST^OCXF1
 ;;R^"863.7:","863.74:1",.01,"E"
 ;;D^CLOSED REFERENCE
 ;;R^"863.7:","863.74:1",1.1,"E"
 ;;D^1
 ;;R^"863.7:","863.74:1",1.2,"E"
 ;;D^OCXCREF
 ;;R^"863.7:","863.74:2",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.7:","863.74:2",1.1,"E"
 ;;D^2
 ;;R^"863.7:","863.74:2",1.2,"E"
 ;;D^T
 ;;EOR^
 ;;KEY^863.7:^FORMATTED LIST
 ;;R^"863.7:",.01,"E"
 ;;D^FORMATTED LIST
 ;;R^"863.7:",.02,"E"
 ;;D^PARAMETERIZED SUBROUTINE
 ;;R^"863.7:",1,"E"
 ;;D^Formats a list into a multi-columnar display
 ;;R^"863.7:",2,1
 ;;D^Formats a list in to a multi columnar diaplay.  No. of items less than
 ;;R^"863.7:",2,2
 ;;D^8 or greater than 66 = 1 column; less than 33 = 2 columns ; less than
 ;1;
 ;

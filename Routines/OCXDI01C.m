OCXDI01C ;SLC/RJS,CLA - OCX PACKAGE DIAGNOSTIC ROUTINES ;SEP 7,1999 at 10:30
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
 G ^OCXDI01D
 ;
 Q
 ;
DATA ;
 ;
 ;;R^"863.7:",3,"E"
 ;;D^HDR^OCXF
 ;;R^"863.7:","863.74:1",.01,"E"
 ;;D^TEXT STRING
 ;;R^"863.7:","863.74:1",1.1,"E"
 ;;D^1
 ;;R^"863.7:","863.74:1",1.2,"E"
 ;;D^X
 ;;EOR^
 ;;KEY^863.7:^SUBFILE NODE
 ;;R^"863.7:",.01,"E"
 ;;D^SUBFILE NODE
 ;;R^"863.7:",.02,"E"
 ;;D^EXTRINSIC FUNCTION
 ;;R^"863.7:",1,"E"
 ;;D^Given a closed class file reference, this extrinsic function returns the subfile node for the parameter multiple
 ;;R^"863.7:",3,"E"
 ;;D^DICP^OCXF
 ;;R^"863.7:","863.74:1",.01,"E"
 ;;D^CLOSED REFERENCE
 ;;R^"863.7:","863.74:1",1.1,"E"
 ;;D^1
 ;;R^"863.7:","863.74:1",1.2,"E"
 ;;D^R
 ;;R^"863.7:","863.74:2",.01,"E"
 ;;D^FIELD NAME
 ;;R^"863.7:","863.74:2",1.1,"E"
 ;;D^2
 ;;R^"863.7:","863.74:2",1.2,"E"
 ;;D^F
 ;;EOR^
 ;;KEY^863.7:^CODE AND DECODE
 ;;R^"863.7:",.01,"E"
 ;;D^CODE AND DECODE
 ;;R^"863.7:",.02,"E"
 ;;D^EXTRINSIC FUNCTION
 ;;R^"863.7:",1,"E"
 ;;D^Given a set of codes string, this function codes or decodes a value
 ;;R^"863.7:",2,1
 ;;D^Given a set of codes string (FileMan format) it converts a code to an
 ;;R^"863.7:",2,2
 ;;D^external value or an external value (or a unique partial value) to a code.
 ;;R^"863.7:",3,"E"
 ;;D^SET^OCXF
 ;;R^"863.7:","863.74:1",.01,"E"
 ;;D^SET CODES
 ;;R^"863.7:","863.74:1",1.1,"E"
 ;;D^1
 ;;R^"863.7:","863.74:1",1.2,"E"
 ;;D^C
 ;;R^"863.7:","863.74:2",.01,"E"
 ;;D^CODE OR VALUE
 ;;R^"863.7:","863.74:2",1.1,"E"
 ;;D^2
 ;;R^"863.7:","863.74:2",1.2,"E"
 ;;D^X
 ;;R^"863.7:","863.74:3",.01,"E"
 ;;D^CODE OR DECODE
 ;;R^"863.7:","863.74:3",1.1,"E"
 ;;D^3
 ;;R^"863.7:","863.74:3",1.2,"E"
 ;;D^T
 ;;EOR^
 ;;KEY^863.7:^RETURN A SET OF CODES
 ;;R^"863.7:",.01,"E"
 ;;D^RETURN A SET OF CODES
 ;;R^"863.7:",.02,"E"
 ;;D^EXTRINSIC FUNCTION
 ;;R^"863.7:",1,"E"
 ;;D^Make a set of codes
 ;;R^"863.7:",3,"E"
 ;;D^SC^OCXF
 ;;R^"863.7:","863.74:1",.01,"E"
 ;;D^SET CODES
 ;;R^"863.7:","863.74:1",1.1,"E"
 ;;D^1
 ;;R^"863.7:","863.74:1",1.2,"E"
 ;;D^Z
 ;;EOR^
 ;;KEY^863.7:^BREAK A STRING
 ;;R^"863.7:",.01,"E"
 ;;D^BREAK A STRING
 ;;R^"863.7:",.02,"E"
 ;;D^PARAMETERIZED SUBROUTINE
 ;;R^"863.7:",1,"E"
 ;;D^Break a long text string and format according to tab stop and max line length
 ;;R^"863.7:",2,1
 ;;D^Formats a long text string by breaking it in to pieces and printing the
 ;;R^"863.7:",2,2
 ;;D^pieces within a pre-determined format (max line length, tab ofset, 1st line
 ;;R^"863.7:",2,3
 ;;D^tab offset).
 ;;R^"863.7:",3,"E"
 ;;D^BRK^OCXF
 ;;R^"863.7:","863.74:1",.01,"E"
 ;;D^TAB OFFSET
 ;;R^"863.7:","863.74:1",1.1,"E"
 ;;D^3
 ;;R^"863.7:","863.74:1",1.2,"E"
 ;;D^T
 ;;R^"863.7:","863.74:2",.01,"E"
 ;;D^FREE TEXT MAXIMUM LENGTH
 ;;R^"863.7:","863.74:2",1.1,"E"
 ;;D^2
 ;;R^"863.7:","863.74:2",1.2,"E"
 ;;D^Y
 ;;R^"863.7:","863.74:3",.01,"E"
 ;;D^TEXT STRING
 ;;R^"863.7:","863.74:3",1.1,"E"
 ;;D^1
 ;;R^"863.7:","863.74:3",1.2,"E"
 ;;D^X
 ;;R^"863.7:","863.74:4",.01,"E"
 ;;D^FIRST LINE TAB
 ;;R^"863.7:","863.74:4",1.1,"E"
 ;;D^4
 ;;R^"863.7:","863.74:4",1.2,"E"
 ;;D^F
 ;;EOR^
 ;;KEY^863.7:^CLASS REFERENCE
 ;;R^"863.7:",.01,"E"
 ;;D^CLASS REFERENCE
 ;;R^"863.7:",.02,"E"
 ;;D^EXTRINSIC FUNCTION
 ;;R^"863.7:",1,"E"
 ;;D^Returns an open or closed reference for a class file
 ;;R^"863.7:",3,"E"
 ;;D^REF^OCXF
 ;;R^"863.7:","863.74:1",.01,"E"
 ;;D^CLOSED REFERENCE
 ;;R^"863.7:","863.74:1",1.1,"E"
 ;;D^1
 ;;R^"863.7:","863.74:1",1.2,"E"
 ;;D^G
 ;;R^"863.7:","863.74:2",.01,"E"
 ;;D^CLASS NAME
 ;;R^"863.7:","863.74:2",1.1,"E"
 ;;D^2
 ;;R^"863.7:","863.74:2",1.2,"E"
 ;;D^M
 ;;R^"863.7:","863.74:3",.01,"E"
 ;;D^CLOSED OR OPEN
 ;;R^"863.7:","863.74:3",1.1,"E"
 ;;D^3
 ;;R^"863.7:","863.74:3",1.2,"E"
 ;;D^T
 ;;EOR^
 ;;KEY^863.7:^CLOSED REFERENCE
 ;;R^"863.7:",.01,"E"
 ;;D^CLOSED REFERENCE
 ;;R^"863.7:",.02,"E"
 ;;D^EXTRINSIC FUNCTION
 ;;R^"863.7:",1,"E"
 ;;D^Convert an open reference to a closed global reference
 ;;R^"863.7:",3,"E"
 ;;D^CREF^OCXF
 ;;R^"863.7:","863.74:1",.01,"E"
 ;;D^OPEN REFERENCE
 ;;R^"863.7:","863.74:1",1.1,"E"
 ;;D^1
 ;;R^"863.7:","863.74:1",1.2,"E"
 ;;D^%
 ;;EOR^
 ;;KEY^863.7:^OPEN REFERENCE
 ;;R^"863.7:",.01,"E"
 ;;D^OPEN REFERENCE
 ;;R^"863.7:",.02,"E"
 ;;D^EXTRINSIC FUNCTION
 ;;R^"863.7:",1,"E"
 ;;D^Convert a closed global reference to an open reference
 ;;R^"863.7:",3,"E"
 ;;D^OREF^OCXF
 ;;R^"863.7:","863.74:1",.01,"E"
 ;;D^CLOSED REFERENCE
 ;;R^"863.7:","863.74:1",1.1,"E"
 ;;D^1
 ;;R^"863.7:","863.74:1",1.2,"E"
 ;;D^%
 ;;EOR^
 ;;KEY^863.7:^YES NO
 ;;R^"863.7:",.01,"E"
 ;;D^YES NO
 ;;R^"863.7:",.02,"E"
 ;;D^EXTRINSIC FUNCTION
 ;;R^"863.7:",1,"E"
 ;;D^Gets a YES/NO response from the user
 ;;R^"863.7:",2,1
 ;;D^Extrinsic function equivalent of YN^DICN: 1-YES,2=NO, if Q=1 the question
 ;;R^"863.7:",2,2
 ;;D^mark is suppressed and if N=1 "NULL" is allowed.
 ;;R^"863.7:",3,"E"
 ;;D^YN^OCXF1
 ;;R^"863.7:","863.74:5",.01,"E"
 ;;D^NULL ALLOWED
 ;;R^"863.7:","863.74:5",1.1,"E"
 ;1;
 ;

OCXDI01D ;SLC/RJS,CLA - OCX PACKAGE DIAGNOSTIC ROUTINES ;SEP 7,1999 at 10:30
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
 G ^OCXDI01E
 ;
 Q
 ;
DATA ;
 ;
 ;;D^3
 ;;R^"863.7:","863.74:5",1.2,"E"
 ;;D^N
 ;;EOR^
 ;;KEY^863.7:^EXIT TEXT
 ;;R^"863.7:",.01,"E"
 ;;D^EXIT TEXT
 ;;R^"863.7:",.02,"E"
 ;;D^EXTRINSIC FUNCTION
 ;;R^"863.7:",1,"E"
 ;;D^User edits a text string
 ;;R^"863.7:",2,1
 ;;D^Extrinsic function equivalent to FileMan's text editor
 ;;R^"863.7:",3,"E"
 ;;D^RW^OCXF1
 ;;R^"863.7:","863.74:1",.01,"E"
 ;;D^TEXT STRING
 ;;R^"863.7:","863.74:1",1.1,"E"
 ;;D^1
 ;;R^"863.7:","863.74:1",1.2,"E"
 ;;D^OCXDY
 ;;EOR^
 ;;KEY^863.7:^LIST AN ARRAY
 ;;R^"863.7:",.01,"E"
 ;;D^LIST AN ARRAY
 ;;R^"863.7:",.02,"E"
 ;;D^PARAMETERIZED SUBROUTINE
 ;;R^"863.7:",1,"E"
 ;;D^List an array on a screen.  Scroll and do output transform.
 ;;R^"863.7:",2,1
 ;;D^This function lists the contents of an array on the screen.  If the array
 ;;R^"863.7:",2,2
 ;;D^won't fit on one screen, scroll mode is invoked.  Parameters specify the
 ;;R^"863.7:",2,3
 ;;D^output transfrom as well as start and stop marker and the empty array
 ;;R^"863.7:",2,4
 ;;D^message.
 ;;R^"863.7:",3,"E"
 ;;D^LIST^OCXF1
 ;;R^"863.7:","863.74:1",.01,"E"
 ;;D^TAB OFFSET
 ;;R^"863.7:","863.74:1",1.1,"E"
 ;;D^7
 ;;R^"863.7:","863.74:1",1.2,"E"
 ;;D^T
 ;;R^"863.7:","863.74:2",.01,"E"
 ;;D^INDEX
 ;;R^"863.7:","863.74:2",1.1,"E"
 ;;D^4
 ;;R^"863.7:","863.74:2",1.2,"E"
 ;;D^I
 ;;R^"863.7:","863.74:3",.01,"E"
 ;;D^CLOSED REFERENCE
 ;;R^"863.7:","863.74:3",1.1,"E"
 ;;D^1
 ;;R^"863.7:","863.74:3",1.2,"E"
 ;;D^G
 ;;R^"863.7:","863.74:4",.01,"E"
 ;;D^LIST START
 ;;R^"863.7:","863.74:4",1.1,"E"
 ;;D^2
 ;;R^"863.7:","863.74:4",1.2,"E"
 ;;D^S
 ;;R^"863.7:","863.74:5",.01,"E"
 ;;D^LIST END
 ;;R^"863.7:","863.74:5",1.1,"E"
 ;;D^3
 ;;R^"863.7:","863.74:5",1.2,"E"
 ;;D^E
 ;;R^"863.7:","863.74:6",.01,"E"
 ;;D^OUTPUT TRANSFORM
 ;;R^"863.7:","863.74:6",1.1,"E"
 ;;D^5
 ;;R^"863.7:","863.74:6",1.2,"E"
 ;;D^O
 ;;R^"863.7:","863.74:7",.01,"E"
 ;;D^SCREEN LENGTH
 ;;R^"863.7:","863.74:7",1.1,"E"
 ;;D^6
 ;;R^"863.7:","863.74:7",1.2,"E"
 ;;D^L
 ;;R^"863.7:","863.74:8",.01,"E"
 ;;D^LIST EMPTY MESSAGE
 ;;R^"863.7:","863.74:8",1.1,"E"
 ;;D^8
 ;;R^"863.7:","863.74:8",1.2,"E"
 ;;D^M
 ;;R^"863.7:","863.74:9",.01,"E"
 ;;D^POINTER GLOBAL
 ;;R^"863.7:","863.74:9",1.1,"E"
 ;;D^9
 ;;R^"863.7:","863.74:9",1.2,"E"
 ;;D^R
 ;;EOR^
 ;;KEY^863.7:^HELP FRAME
 ;;R^"863.7:",.01,"E"
 ;;D^HELP FRAME
 ;;R^"863.7:",.02,"E"
 ;;D^PARAMETERIZED SUBROUTINE
 ;;R^"863.7:",1,"E"
 ;;D^Encapsulated help frame call
 ;;R^"863.7:",2,1
 ;;D^Given a help frame IEN, display the help frame
 ;;R^"863.7:",3,"E"
 ;;D^HF^OCXF1
 ;;R^"863.7:","863.74:1",.01,"E"
 ;;D^HELP FRAME
 ;;R^"863.7:","863.74:1",1.1,"E"
 ;;D^1
 ;;R^"863.7:","863.74:1",1.2,"E"
 ;;D^XQH
 ;;EOR^
 ;;KEY^863.7:^OBJECT VIEW
 ;;R^"863.7:",.01,"E"
 ;;D^OBJECT VIEW
 ;;R^"863.7:",.02,"E"
 ;;D^PARAMETERIZED SUBROUTINE
 ;;R^"863.7:",1,"E"
 ;;D^View an object
 ;;R^"863.7:",3,"E"
 ;;D^VIEW^OCXFMGR
 ;;R^"863.7:","863.74:1",.01,"E"
 ;;D^OPEN REFERENCE
 ;;R^"863.7:","863.74:1",1.1,"E"
 ;;D^1
 ;;R^"863.7:","863.74:1",1.2,"E"
 ;;D^OCXOREF
 ;;R^"863.7:","863.74:2",.01,"E"
 ;;D^INTERNAL ENTRY NUMBER
 ;;R^"863.7:","863.74:2",1.1,"E"
 ;;D^2
 ;;R^"863.7:","863.74:2",1.2,"E"
 ;;D^OCXREC
 ;;EOR^
 ;;KEY^863.7:^OBJECT DELETE
 ;;R^"863.7:",.01,"E"
 ;;D^OBJECT DELETE
 ;;R^"863.7:",.02,"E"
 ;;D^PARAMETERIZED SUBROUTINE
 ;;R^"863.7:",1,"E"
 ;;D^Delete an object
 ;;R^"863.7:",3,"E"
 ;;D^DEL^OCXFMGR
 ;;R^"863.7:","863.74:1",.01,"E"
 ;;D^CLOSED REFERENCE
 ;;R^"863.7:","863.74:1",1.1,"E"
 ;;D^1
 ;;R^"863.7:","863.74:1",1.2,"E"
 ;;D^OCXCREF
 ;;R^"863.7:","863.74:2",.01,"E"
 ;;D^INTERNAL ENTRY NUMBER
 ;;R^"863.7:","863.74:2",1.1,"E"
 ;;D^2
 ;;R^"863.7:","863.74:2",1.2,"E"
 ;;D^OCXREC
 ;;R^"863.7:","863.74:3",.01,"E"
 ;;D^OBJECT NAME
 ;;R^"863.7:","863.74:3",1.1,"E"
 ;;D^3
 ;;R^"863.7:","863.74:3",1.2,"E"
 ;;D^OCXNAME
 ;;R^"863.7:","863.74:4",.01,"E"
 ;;D^FORCE DELETION
 ;;R^"863.7:","863.74:4",1.1,"E"
 ;;D^4
 ;;R^"863.7:","863.74:4",1.2,"E"
 ;;D^OCXFORCE
 ;;EOR^
 ;;KEY^863.7:^MOM
 ;;R^"863.7:",.01,"E"
 ;;D^MOM
 ;;R^"863.7:",.02,"E"
 ;;D^EXTRINSIC FUNCTION
 ;;R^"863.7:",1,"E"
 ;;D^Returns CLASS file closed ref
 ;;R^"863.7:",2,1
 ;;D^Returns the closed reference for the primary file in the class library:
 ;;R^"863.7:",2,2
 ;;D^the CLASS file.
 ;;R^"863.7:",3,"E"
 ;;D^MOM^OCXF
 ;;EOR^
 ;;KEY^863.7:^DICP
 ;;R^"863.7:",.01,"E"
 ;;D^DICP
 ;;R^"863.7:",.02,"E"
 ;;D^EXTRINSIC FUNCTION
 ;;R^"863.7:",1,"E"
 ;;D^Returns the DIC("P") string
 ;;R^"863.7:",2,1
 ;;D^Given a closed file reference and field name (defaults to "PARAMETER"),
 ;;R^"863.7:",2,2
 ;;D^it returns the DIC("P") string.
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
 ;;KEY^863.7:^STUFF
 ;1;
 ;

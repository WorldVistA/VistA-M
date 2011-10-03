OCXDI01F ;SLC/RJS,CLA - OCX PACKAGE DIAGNOSTIC ROUTINES ;SEP 7,1999 at 10:30
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
 G ^OCXDI01G
 ;
 Q
 ;
DATA ;
 ;
 ;;R^"863.7:",2,3
 ;;D^66 = 3 columns
 ;;R^"863.7:",3,"E"
 ;;D^FLIST^OCXF1
 ;;R^"863.7:","863.74:1",.01,"E"
 ;;D^CLOSED REFERENCE
 ;;R^"863.7:","863.74:1",1.1,"E"
 ;;D^1
 ;;R^"863.7:","863.74:1",1.2,"E"
 ;;D^OCXCREF
 ;;EOR^
 ;;KEY^863.7:^FAST LOOKUP
 ;;R^"863.7:",.01,"E"
 ;;D^FAST LOOKUP
 ;;R^"863.7:",.02,"E"
 ;;D^EXTRINSIC FUNCTION
 ;;R^"863.7:",1,"E"
 ;;D^Fast alternative to a silent DIC lookup
 ;;R^"863.7:",2,1
 ;;D^Fast alternative to a silent DIC lookup.  Does not support identifires,
 ;;R^"863.7:",2,2
 ;;D^DIC("S"),DIC("W") etc.
 ;;R^"863.7:",3,"E"
 ;;D^FAST^OCXF2
 ;;R^"863.7:","863.74:1",.01,"E"
 ;;D^CLOSED REFERENCE
 ;;R^"863.7:","863.74:1",1.1,"E"
 ;;D^1
 ;;R^"863.7:","863.74:1",1.2,"E"
 ;;D^G
 ;;R^"863.7:","863.74:2",.01,"E"
 ;;D^LOOKUP VALUE
 ;;R^"863.7:","863.74:2",1.1,"E"
 ;;D^2
 ;;R^"863.7:","863.74:2",1.2,"E"
 ;;D^X
 ;;R^"863.7:","863.74:3",.01,"E"
 ;;D^INDEX STRING
 ;;R^"863.7:","863.74:3",1.1,"E"
 ;;D^3
 ;;R^"863.7:","863.74:3",1.2,"E"
 ;;D^C
 ;;EOR^
 ;;KEY^863.7:^PARAMETER DT ACTION
 ;;R^"863.7:",.01,"E"
 ;;D^PARAMETER DT ACTION
 ;;R^"863.7:",.02,"E"
 ;;D^PARAMETERIZED SUBROUTINE
 ;;R^"863.7:",1,"E"
 ;;D^Collect, validate, transform a parameter value
 ;;R^"863.7:",2,1
 ;;D^Given a parameter, a data type action (e.g., 'READ', 'VALIDATE', etc.),
 ;;R^"863.7:",2,2
 ;;D^and an override array, do what is requested.
 ;;R^"863.7:",3,"E"
 ;;D^PDT^OCXF3
 ;;R^"863.7:","863.74:1",.01,"E"
 ;;D^PARAMETER IEN
 ;;R^"863.7:","863.74:1",1.1,"E"
 ;;D^1
 ;;R^"863.7:","863.74:1",1.2,"E"
 ;;D^OCXPAR
 ;;R^"863.7:","863.74:2",.01,"E"
 ;;D^METHOD
 ;;R^"863.7:","863.74:2",1.1,"E"
 ;;D^2
 ;;R^"863.7:","863.74:2",1.2,"E"
 ;;D^OCXMSG
 ;;R^"863.7:","863.74:3",.01,"E"
 ;;D^OVERRIDE ARRAY
 ;;R^"863.7:","863.74:3",1.1,"E"
 ;;D^3
 ;;R^"863.7:","863.74:3",1.2,"E"
 ;;D^OCXM
 ;;EOR^
 ;;KEY^863.7:^PARAMETER SUBFILE IEN
 ;;R^"863.7:",.01,"E"
 ;;D^PARAMETER SUBFILE IEN
 ;;R^"863.7:",.02,"E"
 ;;D^EXTRINSIC FUNCTION
 ;;R^"863.7:",1,"E"
 ;;D^Given an object and a parameter, return the subfile IEN
 ;;R^"863.7:",2,1
 ;;D^Given a CLASS, INSTSANCE, and 
 ;;R^"863.7:",2,2
 ;;D^PARAMETER (IEN), return the subfile IEN
 ;;R^"863.7:",3,"E"
 ;;D^PENT^OCXF4
 ;;R^"863.7:","863.74:1",.01,"E"
 ;;D^CLASS NUMBER
 ;;R^"863.7:","863.74:1",1.1,"E"
 ;;D^1
 ;;R^"863.7:","863.74:1",1.2,"E"
 ;;D^OCXCLS
 ;;R^"863.7:","863.74:2",.01,"E"
 ;;D^INTERNAL ENTRY NUMBER
 ;;R^"863.7:","863.74:2",1.1,"E"
 ;;D^2
 ;;R^"863.7:","863.74:2",1.2,"E"
 ;;D^OCXOBJ
 ;;R^"863.7:","863.74:3",.01,"E"
 ;;D^PARAMETER IEN
 ;;R^"863.7:","863.74:3",1.1,"E"
 ;;D^3
 ;;R^"863.7:","863.74:3",1.2,"E"
 ;;D^OCXPIEN
 ;;EOR^
 ;;KEY^863.7:^PARAMETER OUTPUT TRANSFORM
 ;;R^"863.7:",.01,"E"
 ;;D^PARAMETER OUTPUT TRANSFORM
 ;;R^"863.7:",.02,"E"
 ;;D^EXTRINSIC FUNCTION
 ;;R^"863.7:",1,"E"
 ;;D^Do an output transform on a parameter value
 ;;R^"863.7:",2,1
 ;;D^Given a parameter IEN and an input value, return the external value.
 ;;R^"863.7:",3,"E"
 ;;D^POT^OCXF4
 ;;R^"863.7:","863.74:1",.01,"E"
 ;;D^INPUT VALUE
 ;;R^"863.7:","863.74:1",1.1,"E"
 ;;D^1
 ;;R^"863.7:","863.74:1",1.2,"E"
 ;;D^OCXVAL
 ;;R^"863.7:","863.74:2",.01,"E"
 ;;D^PARAMETER IEN
 ;;R^"863.7:","863.74:2",1.1,"E"
 ;;D^2
 ;;R^"863.7:","863.74:2",1.2,"E"
 ;;D^OCXDA
 ;;EOR^
 ;;KEY^863.7:^SETPARAM
 ;;R^"863.7:",.01,"E"
 ;;D^SETPARAM
 ;;R^"863.7:",.02,"E"
 ;;D^PARAMETERIZED SUBROUTINE
 ;;R^"863.7:",1,"E"
 ;;D^Given an object, return all of its parameter values in an array
 ;;R^"863.7:",2,1
 ;;D^Given a class and instance, return all parameter values inthe specified
 ;;R^"863.7:",2,2
 ;;D^array.  Array subscripts can be the full or brief name.
 ;;R^"863.7:",3,"E"
 ;;D^SETPARAM^OCXF4
 ;;R^"863.7:","863.74:1",.01,"E"
 ;;D^CLASS NAME
 ;;R^"863.7:","863.74:1",1.1,"E"
 ;;D^1
 ;;R^"863.7:","863.74:1",1.2,"E"
 ;;D^OCXCLASS
 ;;R^"863.7:","863.74:2",.01,"E"
 ;;D^INTERNAL ENTRY NUMBER
 ;;R^"863.7:","863.74:2",1.1,"E"
 ;;D^2
 ;;R^"863.7:","863.74:2",1.2,"E"
 ;;D^OCXINST
 ;;R^"863.7:","863.74:3",.01,"E"
 ;;D^CLOSED REFERENCE
 ;;R^"863.7:","863.74:3",1.1,"E"
 ;;D^3
 ;;R^"863.7:","863.74:3",1.2,"E"
 ;;D^OCXA
 ;;R^"863.7:","863.74:4",.01,"E"
 ;;D^BRIEF NAME OK
 ;;R^"863.7:","863.74:4",1.1,"E"
 ;;D^4
 ;;R^"863.7:","863.74:4",1.2,"E"
 ;;D^OCXBRF
 ;;EOR^
 ;;KEY^863.7:^PARAMETER VALUE
 ;;R^"863.7:",.01,"E"
 ;;D^PARAMETER VALUE
 ;;R^"863.7:",.02,"E"
 ;;D^EXTRINSIC FUNCTION
 ;;R^"863.7:",1,"E"
 ;;D^Get a valid parameter value from the user
 ;;R^"863.7:",2,1
 ;;D^Given a PARAMETER IEN, get a valid param value from the user.
 ;;R^"863.7:",3,"E"
 ;;D^VAL^OCXF4
 ;;R^"863.7:","863.74:1",.01,"E"
 ;;D^PARAMETER IEN
 ;;R^"863.7:","863.74:1",1.1,"E"
 ;;D^1
 ;;R^"863.7:","863.74:1",1.2,"E"
 ;;D^OCXINST
 ;;R^"863.7:","863.74:2",.01,"E"
 ;;D^DEFAULT VALUE
 ;;R^"863.7:","863.74:2",1.1,"E"
 ;;D^2
 ;;R^"863.7:","863.74:2",1.2,"E"
 ;;D^D
 ;;R^"863.7:","863.74:3",.01,"E"
 ;1;
 ;

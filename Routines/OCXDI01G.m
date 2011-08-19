OCXDI01G ;SLC/RJS,CLA - OCX PACKAGE DIAGNOSTIC ROUTINES ;SEP 7,1999 at 10:30
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
 G ^OCXDI01H
 ;
 Q
 ;
DATA ;
 ;
 ;;D^DATA TYPE
 ;;R^"863.7:","863.74:3",1.1,"E"
 ;;D^3
 ;;R^"863.7:","863.74:3",1.2,"E"
 ;;D^T
 ;;R^"863.7:","863.74:4",.01,"E"
 ;;D^PARAMETER QUERY
 ;;R^"863.7:","863.74:4",1.1,"E"
 ;;D^4
 ;;R^"863.7:","863.74:4",1.2,"E"
 ;;D^Q
 ;;R^"863.7:","863.74:5",.01,"E"
 ;;D^VOID
 ;;R^"863.7:","863.74:5",1.1,"E"
 ;;D^5
 ;;R^"863.7:","863.74:5",1.2,"E"
 ;;D^V
 ;;EOR^
 ;;KEY^863.7:^PARAMETER DATA TYPE
 ;;R^"863.7:",.01,"E"
 ;;D^PARAMETER DATA TYPE
 ;;R^"863.7:",.02,"E"
 ;;D^EXTRINSIC FUNCTION
 ;;R^"863.7:",1,"E"
 ;;D^Returns the data type of a parameter
 ;;R^"863.7:",2,1
 ;;D^Given a parameter (name or ien), return its data type.
 ;;R^"863.7:",3,"E"
 ;;D^PARDT^OCXF4
 ;;R^"863.7:","863.74:1",.01,"E"
 ;;D^PARAMETER IEN
 ;;R^"863.7:","863.74:1",1.1,"E"
 ;;D^1
 ;;R^"863.7:","863.74:1",1.2,"E"
 ;;D^OCXPIEN
 ;;EOR^
 ;;KEY^863.7:^DATA TYPE TAG
 ;;R^"863.7:",.01,"E"
 ;;D^DATA TYPE TAG
 ;;R^"863.7:",.02,"E"
 ;;D^EXTRINSIC FUNCTION
 ;;R^"863.7:",1,"E"
 ;;D^Returns the line reference for a DATA TYPE's method
 ;;R^"863.7:",2,1
 ;;D^Given a DATA TYPE's name or IEN, return the TAG^ROUTINE of its method.
 ;;R^"863.7:",3,"E"
 ;;D^DTAG^OCXF5
 ;;R^"863.7:","863.74:1",.01,"E"
 ;;D^DATA TYPE IEN
 ;;R^"863.7:","863.74:1",1.1,"E"
 ;;D^1
 ;;R^"863.7:","863.74:1",1.2,"E"
 ;;D^OCXDT
 ;;EOR^
 ;;KEY^863.7:^DATA TYPE PARENT
 ;;R^"863.7:",.01,"E"
 ;;D^DATA TYPE PARENT
 ;;R^"863.7:",.02,"E"
 ;;D^EXTRINSIC FUNCTION
 ;;R^"863.7:",1,"E"
 ;;D^Get a DATA TYPE'S parent
 ;;R^"863.7:",2,1
 ;;D^Given a data type's name or IEN, return the IEN or name of its parent
 ;;R^"863.7:",3,"E"
 ;;D^PARENT^OCXF5
 ;;R^"863.7:","863.74:1",.01,"E"
 ;;D^DATA TYPE IEN
 ;;R^"863.7:","863.74:1",1.1,"E"
 ;;D^1
 ;;R^"863.7:","863.74:1",1.2,"E"
 ;;D^OCXDT
 ;;R^"863.7:","863.74:2",.01,"E"
 ;;D^TRANSFORM
 ;;R^"863.7:","863.74:2",1.1,"E"
 ;;D^2
 ;;R^"863.7:","863.74:2",1.2,"E"
 ;;D^OCXOT
 ;;EOR^
 ;;KEY^863.7:^LIST PARAMETERS
 ;;R^"863.7:",.01,"E"
 ;;D^LIST PARAMETERS
 ;;R^"863.7:",.02,"E"
 ;;D^PARAMETERIZED SUBROUTINE
 ;;R^"863.7:",1,"E"
 ;;D^List all parameters for an object
 ;;R^"863.7:",2,1
 ;;D^Given a class and instance, list all parameters and values
 ;;R^"863.7:",3,"E"
 ;;D^PLIST^OCXFMGR
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
 ;;EOR^
 ;;KEY^863.7:^OBJECT EDIT
 ;;R^"863.7:",.01,"E"
 ;;D^OBJECT EDIT
 ;;R^"863.7:",.02,"E"
 ;;D^PARAMETERIZED SUBROUTINE
 ;;R^"863.7:",1,"E"
 ;;D^Edit an object
 ;;R^"863.7:",2,1
 ;;D^Given a class, instance and class name, edit the object.
 ;;R^"863.7:",3,"E"
 ;;D^EDIT^OCXFMGR1
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
 ;;R^"863.7:","863.74:3",.01,"E"
 ;;D^CLASS NAME
 ;;R^"863.7:","863.74:3",1.1,"E"
 ;;D^3
 ;;R^"863.7:","863.74:3",1.2,"E"
 ;;D^OCXUCLS
 ;;EOR^
 ;;KEY^863.7:^OBJECT ADD
 ;;R^"863.7:",.01,"E"
 ;;D^OBJECT ADD
 ;;R^"863.7:",.02,"E"
 ;;D^PARAMETERIZED SUBROUTINE
 ;;R^"863.7:",1,"E"
 ;;D^Add an object
 ;;R^"863.7:",2,1
 ;;D^Given an open reference for a class and the class name, enter a new object.
 ;;R^"863.7:",3,"E"
 ;;D^ADD^OCXFMGR1
 ;;R^"863.7:","863.74:1",.01,"E"
 ;;D^OPEN REFERENCE
 ;;R^"863.7:","863.74:1",1.1,"E"
 ;;D^1
 ;;R^"863.7:","863.74:1",1.2,"E"
 ;;D^OCXOREF
 ;;R^"863.7:","863.74:2",.01,"E"
 ;;D^CLASS NAME
 ;;R^"863.7:","863.74:2",1.1,"E"
 ;;D^2
 ;;R^"863.7:","863.74:2",1.2,"E"
 ;;D^OCXNAME
 ;;EOR^
 ;;KEY^863.7:^SELECT OBJECT PARAMETERS
 ;;R^"863.7:",.01,"E"
 ;;D^SELECT OBJECT PARAMETERS
 ;;R^"863.7:",.02,"E"
 ;;D^PARAMETERIZED SUBROUTINE
 ;;R^"863.7:",1,"E"
 ;;D^Select parameter for an object
 ;;R^"863.7:",2,1
 ;;D^Given a class, instance, class name, and output array closed reference,
 ;;R^"863.7:",2,2
 ;;D^allow user to assign parameters to the object from a set consisting of
 ;;R^"863.7:",2,3
 ;;D^all parameters assigned to the methods of the class.
 ;;R^"863.7:",3,"E"
 ;;D^PICK^OCXFMGR1
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
 ;;D^OCXDA
 ;;R^"863.7:","863.74:3",.01,"E"
 ;;D^CLASS NAME
 ;;R^"863.7:","863.74:3",1.1,"E"
 ;;D^3
 ;;R^"863.7:","863.74:3",1.2,"E"
 ;;D^OCXUCLS
 ;;R^"863.7:","863.74:4",.01,"E"
 ;;D^OUTPUT VARIABLE
 ;;R^"863.7:","863.74:4",1.1,"E"
 ;;D^4
 ;;R^"863.7:","863.74:4",1.2,"E"
 ;1;
 ;

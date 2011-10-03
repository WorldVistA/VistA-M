OCXDI02B ;SLC/RJS,CLA - OCX PACKAGE DIAGNOSTIC ROUTINES ;SEP 7,1999 at 10:30
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
 G ^OCXDI02C
 ;
 Q
 ;
DATA ;
 ;
 ;;D^ADD CALL
 ;;R^"863:","863.01:1",1,"E"
 ;;D^ADD^OCXMGRU
 ;;R^"863:","863.01:2",.01,"E"
 ;;D^DEL CALL
 ;;R^"863:","863.01:2",1,"E"
 ;;D^DEL^OCXMGRU
 ;;R^"863:","863.01:3",.01,"E"
 ;;D^EDIT CALL
 ;;R^"863:","863.01:3",1,"E"
 ;;D^EDIT^OCXMGRU
 ;;R^"863:","863.01:4",.01,"E"
 ;;D^VIEW CALL
 ;;R^"863:","863.01:4",1,"E"
 ;;D^VIEW^OCXMGRU
 ;;EOR^
 ;;KEY^863:^METHOD
 ;;R^"863:",.01,"E"
 ;;D^METHOD
 ;;R^"863:",.02,"E"
 ;;D^863.6
 ;;R^"863:",2,1
 ;;D^The member function of the object.
 ;;R^"863:","863.01:1",.01,"E"
 ;;D^ADD CALL
 ;;R^"863:","863.01:1",1,"E"
 ;;D^ADD^OCXMGRME
 ;;R^"863:","863.01:2",.01,"E"
 ;;D^DEL CALL
 ;;R^"863:","863.01:2",1,"E"
 ;;D^DEL^OCXMGRME
 ;;R^"863:","863.01:3",.01,"E"
 ;;D^EDIT CALL
 ;;R^"863:","863.01:3",1,"E"
 ;;D^EDIT^OCXMGRME
 ;;R^"863:","863.01:4",.01,"E"
 ;;D^VIEW CALL
 ;;R^"863:","863.01:4",1,"E"
 ;;D^VIEW^OCXMGRME
 ;;R^"863:","863.01:5",.01,"E"
 ;;D^PRINT TEMPLATE
 ;;R^"863:","863.01:5",1,"E"
 ;;D^687
 ;;EOR^
 ;;KEY^863:^PARAMETER
 ;;R^"863:",.01,"E"
 ;;D^PARAMETER
 ;;R^"863:",.02,"E"
 ;;D^863.8
 ;;R^"863:",2,1
 ;;D^The data members of class instances (objects) and parameters of methods.
 ;;R^"863:","863.01:1",.01,"E"
 ;;D^ADD CALL
 ;;R^"863:","863.01:1",1,"E"
 ;;D^ADD^OCXMGRPA
 ;;R^"863:","863.01:2",.01,"E"
 ;;D^DEL CALL
 ;;R^"863:","863.01:2",1,"E"
 ;;D^DEL^OCXMGRPA
 ;;R^"863:","863.01:3",.01,"E"
 ;;D^EDIT CALL
 ;;R^"863:","863.01:3",1,"E"
 ;;D^EDIT^OCXMGRPA
 ;;R^"863:","863.01:4",.01,"E"
 ;;D^VIEW CALL
 ;;R^"863:","863.01:4",1,"E"
 ;;D^VIEW^OCXMGRPA
 ;;EOR^
 ;;KEY^863:^CONDITION
 ;;R^"863:",.01,"E"
 ;;D^CONDITION
 ;;R^"863:",.02,"E"
 ;;D^863.9
 ;;R^"863:",2,1
 ;;D^The Boolean operators and functions (multiples only) which apply to
 ;;R^"863:",2,2
 ;;D^a specific data type.
 ;;R^"863:","863.01:1",.01,"E"
 ;;D^ADD CALL
 ;;R^"863:","863.01:1",1,"E"
 ;;D^ADD^OCXMGRU
 ;;R^"863:","863.01:2",.01,"E"
 ;;D^DEL CALL
 ;;R^"863:","863.01:2",1,"E"
 ;;D^DEL^OCXMGRU
 ;;R^"863:","863.01:3",.01,"E"
 ;;D^EDIT CALL
 ;;R^"863:","863.01:3",1,"E"
 ;;D^EDIT^OCXMGRU
 ;;R^"863:","863.01:4",.01,"E"
 ;;D^VIEW CALL
 ;;R^"863:","863.01:4",1,"E"
 ;;D^VIEW^OCXMGRU
 ;;EOR^
 ;;KEY^863:^DATA TYPE
 ;;R^"863:",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863:",.02,"E"
 ;;D^864.1
 ;;R^"863:",2,1
 ;;D^An abstract data type which is a distinguishing characteristic of an
 ;;R^"863:",2,2
 ;;D^"ATTRIBUTE" or a parameter.
 ;;R^"863:","863.01:1",.01,"E"
 ;;D^ADD CALL
 ;;R^"863:","863.01:1",1,"E"
 ;;D^ADD^OCXMGRU
 ;;R^"863:","863.01:2",.01,"E"
 ;;D^DEL CALL
 ;;R^"863:","863.01:2",1,"E"
 ;;D^DEL^OCXMGRU
 ;;R^"863:","863.01:3",.01,"E"
 ;;D^EDIT CALL
 ;;R^"863:","863.01:3",1,"E"
 ;;D^EDIT^OCXMGRU
 ;;R^"863:","863.01:4",.01,"E"
 ;;D^VIEW CALL
 ;;R^"863:","863.01:4",1,"E"
 ;;D^VIEW^OCXMGRU
 ;;EOR^
 ;;KEY^863:^CLASS
 ;;R^"863:",.01,"E"
 ;;D^CLASS
 ;;R^"863:",.02,"E"
 ;;D^863
 ;;R^"863:",.04,"E"
 ;;D^CL
 ;;R^"863:",2,1
 ;;D^This file holds all the elements of the metadictionary.  Each element is a
 ;;R^"863:",2,2
 ;;D^class.  Each class has instances called objects.  Each class has one or
 ;;R^"863:",2,3
 ;;D^more methods as well as data members used by the methods.
 ;;R^"863:","863.01:3",.01,"E"
 ;;D^ADD CALL
 ;;R^"863:","863.01:3",1,"E"
 ;;D^ADD^OCXMGRU
 ;;R^"863:","863.01:4",.01,"E"
 ;;D^DEL CALL
 ;;R^"863:","863.01:4",1,"E"
 ;;D^DEL^OCXMGRU
 ;;R^"863:","863.01:5",.01,"E"
 ;;D^EDIT CALL
 ;;R^"863:","863.01:5",1,"E"
 ;;D^EDIT^OCXMGRU
 ;;R^"863:","863.01:6",.01,"E"
 ;;D^VIEW CALL
 ;;R^"863:","863.01:6",1,"E"
 ;;D^VIEW^OCXMGRU
 ;;EOR^
 ;;KEY^863:^PUBLIC FUNCTION
 ;;R^"863:",.01,"E"
 ;;D^PUBLIC FUNCTION
 ;;R^"863:",.02,"E"
 ;;D^863.7
 ;;R^"863:",2,1
 ;;D^Public functions with defined parameters.
 ;;R^"863:","863.01:1",.01,"E"
 ;;D^ADD CALL
 ;;R^"863:","863.01:1",1,"E"
 ;;D^ADD^OCXMGRFU
 ;;R^"863:","863.01:2",.01,"E"
 ;;D^DEL CALL
 ;;R^"863:","863.01:2",1,"E"
 ;;D^DEL^OCXMGRFU
 ;;R^"863:","863.01:3",.01,"E"
 ;;D^EDIT CALL
 ;;R^"863:","863.01:3",1,"E"
 ;;D^EDIT^OCXMGRFU
 ;;R^"863:","863.01:4",.01,"E"
 ;;D^VIEW CALL
 ;;R^"863:","863.01:4",1,"E"
 ;;D^VIEW^OCXMGRFU
 ;;R^"863:","863.01:5",.01,"E"
 ;;D^PRINT TEMPLATE
 ;;R^"863:","863.01:5",1,"E"
 ;;D^686
 ;;EOR^
 ;;KEY^863:^ORDER CHECK DATA FIELD
 ;;R^"863:",.01,"E"
 ;;D^ORDER CHECK DATA FIELD
 ;;R^"863:",.02,"E"
 ;;D^860.4
 ;;R^"863:",.04,"E"
 ;;D^FLD
 ;;EOR^
 ;;KEY^863:^ORDER CHECK DATA SOURCE
 ;;R^"863:",.01,"E"
 ;;D^ORDER CHECK DATA SOURCE
 ;;R^"863:",.02,"E"
 ;;D^860.5
 ;;R^"863:",.04,"E"
 ;;D^SRC
 ;;EOR^
 ;;KEY^863:^ORDER CHECK ELEMENT
 ;;R^"863:",.01,"E"
 ;;D^ORDER CHECK ELEMENT
 ;;R^"863:",.02,"E"
 ;;D^860.3
 ;;R^"863:",.04,"E"
 ;;D^ELE
 ;;EOR^
 ;;KEY^863:^ORDER CHECK RULE
 ;;R^"863:",.01,"E"
 ;;D^ORDER CHECK RULE
 ;;R^"863:",.02,"E"
 ;;D^860.2
 ;;R^"863:",.04,"E"
 ;;D^RUL
 ;;EOR^
 ;;KEY^863:^ORDER CHECK COMPILER FUNCTIONS
 ;;R^"863:",.01,"E"
 ;;D^ORDER CHECK COMPILER FUNCTIONS
 ;;R^"863:",.02,"E"
 ;;D^860.8
 ;;EOR^
 ;;KEY^863:^ORDER CHECK DATA CONTEXT
 ;;R^"863:",.01,"E"
 ;1;
 ;

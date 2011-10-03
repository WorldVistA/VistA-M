OCXDI01O ;SLC/RJS,CLA - OCX PACKAGE DIAGNOSTIC ROUTINES ;SEP 7,1999 at 10:30
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
 G ^OCXDI01P
 ;
 Q
 ;
DATA ;
 ;
 ;;R^"863.9:",.04,"E"
 ;;D^IS FALSE
 ;;R^"863.9:","863.91:1",.01,"E"
 ;;D^OCXO GENERATE CODE FUNCTION
 ;;R^"863.9:","863.91:1",1,"E"
 ;;D^GCC BOOLEAN LOGICAL FALSE
 ;;R^"863.9:","863.92:1",.01,"E"
 ;;D^FALSE
 ;;EOR^
 ;;KEY^863.9:^EQUALS ELEMENT IN SET
 ;;R^"863.9:",.01,"E"
 ;;D^EQUALS ELEMENT IN SET
 ;;R^"863.9:",.02,"E"
 ;;D^FREE TEXT
 ;;R^"863.9:",.04,"E"
 ;;D^EQUALS AN ELEMENT IN THE SET
 ;;R^"863.9:","863.91:1",.01,"E"
 ;;D^OCXO GENERATE CODE FUNCTION
 ;;R^"863.9:","863.91:1",1,"E"
 ;;D^GCC FREE TEXT EQUALS ELEMENT IN SET
 ;;EOR^
 ;;KEY^863.9:^CONTAINS ELEMENT IN SET
 ;;R^"863.9:",.01,"E"
 ;;D^CONTAINS ELEMENT IN SET
 ;;R^"863.9:",.02,"E"
 ;;D^FREE TEXT
 ;;R^"863.9:",.04,"E"
 ;;D^CONTAINS AN ELEMENT IN THE SET
 ;;R^"863.9:","863.91:1",.01,"E"
 ;;D^OCXO GENERATE CODE FUNCTION
 ;;R^"863.9:","863.91:1",1,"E"
 ;;D^GCC FREE TEXT CONTAINS ELEMENT IN SET
 ;;EOR^
 ;;KEY^863.9:^EQ FREE TEXT LOCAL TERM
 ;;R^"863.9:",.01,"E"
 ;;D^EQ FREE TEXT LOCAL TERM
 ;;R^"863.9:",.02,"E"
 ;;D^FREE TEXT
 ;;R^"863.9:",.04,"E"
 ;;D^IS EQUAL TO
 ;;R^"863.9:","863.91:3",.01,"E"
 ;;D^OCXO GENERATE CODE FUNCTION
 ;;R^"863.9:","863.91:3",1,"E"
 ;;D^GCC FREE TEXT TERM EQUALS
 ;;R^"863.9:","863.92:1",.01,"E"
 ;;D^EQUALS
 ;;EOR^
 ;;EOF^OCXS(863.9)^1
 ;;SOF^863.6  OCX MDD METHOD
 ;;KEY^863.6:^RETURN FIELD NAVIGATION CODE FOR FILEMAN FILE
 ;;R^"863.6:",.01,"E"
 ;;D^RETURN FIELD NAVIGATION CODE FOR FILEMAN FILE
 ;;R^"863.6:",.02,"E"
 ;;D^GET FILEMAN NAVIGATION CODE
 ;;R^"863.6:",.03,"E"
 ;;D^LINK
 ;;R^"863.6:",.04,"E"
 ;;D^ROUTINE
 ;;R^"863.6:",1,1
 ;;D^This method returns a navigation string in the form of a value that can
 ;;R^"863.6:",1,2
 ;;D^ be used to build a FLDS or BY string that DIP uses to generate a report.
 ;;R^"863.6:",1,3
 ;;D^This value is returned in the variable OCXFC
 ;;R^"863.6:",2,"E"
 ;;D^FMCODE^OCXRPG
 ;;R^"863.6:","863.63:1",.01,"E"
 ;;D^FM NAVIGATION CODE
 ;;EOR^
 ;;KEY^863.6:^GET A VALUE DIALOGUE
 ;;R^"863.6:",.01,"E"
 ;;D^GET A VALUE DIALOGUE
 ;;R^"863.6:",.02,"E"
 ;;D^READER
 ;;R^"863.6:",.03,"E"
 ;;D^ATTRIBUTE
 ;;R^"863.6:",.04,"E"
 ;;D^ROUTINE
 ;;R^"863.6:",1,1
 ;;D^Each attribute in the OCX MDD ATTRIBUTE file has a data type.  This method
 ;;R^"863.6:",1,2
 ;;D^prompts the user for a valid value based on this data type.
 ;;R^"863.6:",2,"E"
 ;;D^GETVAL^OCXFD
 ;;EOR^
 ;;KEY^863.6:^ADD A NEW RECORD
 ;;R^"863.6:",.01,"E"
 ;;D^ADD A NEW RECORD
 ;;R^"863.6:",.02,"E"
 ;;D^ADD REC
 ;;R^"863.6:",.03,"E"
 ;;D^CLASS
 ;;R^"863.6:",.04,"E"
 ;;D^ROUTINE
 ;;R^"863.6:",1,1
 ;;D^Adds a new record to an MDD file
 ;;R^"863.6:",2,"E"
 ;;D^ADD^OCXFMGR3
 ;;EOR^
 ;;KEY^863.6:^DELETE A RECORD
 ;;R^"863.6:",.01,"E"
 ;;D^DELETE A RECORD
 ;;R^"863.6:",.02,"E"
 ;;D^DEL REC
 ;;R^"863.6:",.03,"E"
 ;;D^CLASS
 ;;R^"863.6:",.04,"E"
 ;;D^ROUTINE
 ;;R^"863.6:",1,1
 ;;D^Deletes a record from an MDD file.
 ;;R^"863.6:",2,"E"
 ;;D^DEL^OCXFMGR3
 ;;EOR^
 ;;KEY^863.6:^EDIT A RECORD
 ;;R^"863.6:",.01,"E"
 ;;D^EDIT A RECORD
 ;;R^"863.6:",.02,"E"
 ;;D^EDIT REC
 ;;R^"863.6:",.03,"E"
 ;;D^CLASS
 ;;R^"863.6:",.04,"E"
 ;;D^ROUTINE
 ;;R^"863.6:",1,1
 ;;D^Edits an existing record from an MDD file.
 ;;R^"863.6:",2,"E"
 ;;D^EDIT^OCXFMGR3
 ;;EOR^
 ;;KEY^863.6:^VIEW A RECORD
 ;;R^"863.6:",.01,"E"
 ;;D^VIEW A RECORD
 ;;R^"863.6:",.02,"E"
 ;;D^VIEW REC
 ;;R^"863.6:",.03,"E"
 ;;D^CLASS
 ;;R^"863.6:",.04,"E"
 ;;D^ROUTINE
 ;;R^"863.6:",1,1
 ;;D^View an existing record in an MDD file.
 ;;R^"863.6:",2,"E"
 ;;D^VIEW^OCXFMGR3
 ;;EOR^
 ;;KEY^863.6:^DIALOGUE READER
 ;;R^"863.6:",.01,"E"
 ;;D^DIALOGUE READER
 ;;R^"863.6:",.02,"E"
 ;;D^READER
 ;;R^"863.6:",.03,"E"
 ;;D^DATA TYPE
 ;;R^"863.6:",.04,"E"
 ;;D^ROUTINE
 ;;R^"863.6:",1,1
 ;;D^Manages dialogue for user to return a value.  Similar to GET A VALUE
 ;;R^"863.6:",1,2
 ;;D^DIALOGUE but not coupled to an attribute.
 ;;R^"863.6:",2,"E"
 ;;D^VAL^OCXFD
 ;;R^"863.6:","863.63:1",.01,"E"
 ;;D^LINE FEED
 ;;R^"863.6:","863.63:1",1,"E"
 ;;D^1
 ;;R^"863.6:","863.63:2",.01,"E"
 ;;D^TAB OFFSET
 ;;R^"863.6:","863.63:2",1,"E"
 ;;D^0
 ;;R^"863.6:","863.63:3",.01,"E"
 ;;D^MAND
 ;;R^"863.6:","863.63:3",1,"E"
 ;;D^0
 ;;EOR^
 ;;KEY^863.6:^VIEW PARAMETER USAGE
 ;;R^"863.6:",.01,"E"
 ;;D^VIEW PARAMETER USAGE
 ;;R^"863.6:",.02,"E"
 ;;D^PAR VIEW
 ;;R^"863.6:",.03,"E"
 ;;D^PARAMETER
 ;;R^"863.6:",.04,"E"
 ;;D^ROUTINE
 ;;R^"863.6:",1,1
 ;;D^Displays all classes and methods which currently use this parameter.
 ;;R^"863.6:",1,2
 ;;D^Also determines if a parameter is a fundamental "data definition" param.
 ;;R^"863.6:",2,"E"
 ;;D^VIEW^OCXF3
 ;;EOR^
 ;;KEY^863.6:^RETURN ORPHANED PARAMETERS
 ;;R^"863.6:",.01,"E"
 ;;D^RETURN ORPHANED PARAMETERS
 ;;R^"863.6:",.02,"E"
 ;;D^ORPH
 ;;R^"863.6:",.03,"E"
 ;;D^PARAMETER
 ;;R^"863.6:",.04,"E"
 ;;D^ROUTINE
 ;;R^"863.6:",1,1
 ;;D^Finds parameters which are "orphaned" when an object is deleted.
 ;;R^"863.6:",2,"E"
 ;1;
 ;

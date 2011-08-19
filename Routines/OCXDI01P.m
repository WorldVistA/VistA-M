OCXDI01P ;SLC/RJS,CLA - OCX PACKAGE DIAGNOSTIC ROUTINES ;SEP 7,1999 at 10:30
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
 G ^OCXDI01Q
 ;
 Q
 ;
DATA ;
 ;
 ;;D^ORPHAN^OCXFMGR2
 ;;R^"863.6:","863.63:1",.01,"E"
 ;;D^OUTPUT VARIABLE
 ;;R^"863.6:","863.63:1",1,"E"
 ;;D^Y
 ;;R^"863.6:","863.63:2",.01,"E"
 ;;D^ORPHAN DELETE CLASS
 ;;R^"863.6:","863.63:3",.01,"E"
 ;;D^ORPHAN DELETE OBJECT
 ;;R^"863.6:","863.63:4",.01,"E"
 ;;D^ORPHAN ALL
 ;;R^"863.6:","863.63:4",1,"E"
 ;;D^2
 ;;EOR^
 ;;KEY^863.6:^CASE TOOL
 ;;R^"863.6:",.01,"E"
 ;;D^CASE TOOL
 ;;R^"863.6:",.02,"E"
 ;;D^BUILD REC
 ;;R^"863.6:",.03,"E"
 ;;D^CLASS
 ;;R^"863.6:",.04,"E"
 ;;D^ROUTINE
 ;;R^"863.6:",1,1
 ;;D^Call to build a method subroutine
 ;;R^"863.6:",2,"E"
 ;;D^BUILD^OCXMGRM1
 ;;R^"863.6:","863.63:1",.01,"E"
 ;;D^BUILD CALL
 ;;EOR^
 ;;KEY^863.6:^LIST PUBLIC FUNCTIONS
 ;;R^"863.6:",.01,"E"
 ;;D^LIST PUBLIC FUNCTIONS
 ;;R^"863.6:",.02,"E"
 ;;D^LIST PF REC
 ;;R^"863.6:",.03,"E"
 ;;D^CLASS
 ;;R^"863.6:",.04,"E"
 ;;D^ROUTINE
 ;;R^"863.6:",1,1
 ;;D^Summary list of all public functions
 ;;R^"863.6:",2,"E"
 ;;D^FLIST^OCXFMGR3
 ;;EOR^
 ;;KEY^863.6:^DIALOGUE OUTPUT TRANSFORM
 ;;R^"863.6:",.01,"E"
 ;;D^DIALOGUE OUTPUT TRANSFORM
 ;;R^"863.6:",.02,"E"
 ;;D^DT OT
 ;;R^"863.6:",.03,"E"
 ;;D^DATA TYPE
 ;;R^"863.6:",.04,"E"
 ;;D^ROUTINE
 ;;R^"863.6:",1,1
 ;;D^For a specific data type, this method translates the internal format
 ;;R^"863.6:",1,2
 ;;D^to the external format
 ;;R^"863.6:",2,"E"
 ;;D^VAL^OCXFD
 ;;R^"863.6:","863.63:1",.01,"E"
 ;;D^INPUT VALUE
 ;;R^"863.6:","863.63:1",.02,"E"
 ;;D^INPUT
 ;;R^"863.6:","863.63:1",1,"E"
 ;;D^ 
 ;;EOR^
 ;;KEY^863.6:^DIALOGUE INPUT TRANSFORM
 ;;R^"863.6:",.01,"E"
 ;;D^DIALOGUE INPUT TRANSFORM
 ;;R^"863.6:",.02,"E"
 ;;D^DT IT
 ;;R^"863.6:",.03,"E"
 ;;D^DATA TYPE
 ;;R^"863.6:",.04,"E"
 ;;D^ROUTINE
 ;;R^"863.6:",1,1
 ;;D^This method converts an external format value stored in 'INVAL' to
 ;;R^"863.6:",1,2
 ;;D^the internal format
 ;;R^"863.6:",2,"E"
 ;;D^VAL^OCXFD
 ;;R^"863.6:","863.63:1",.01,"E"
 ;;D^INPUT VALUE
 ;;R^"863.6:","863.63:1",.02,"E"
 ;;D^INPUT
 ;;EOR^
 ;;KEY^863.6:^DIALOGUE INPUT VALIDATION
 ;;R^"863.6:",.01,"E"
 ;;D^DIALOGUE INPUT VALIDATION
 ;;R^"863.6:",.02,"E"
 ;;D^DT IVAL
 ;;R^"863.6:",.03,"E"
 ;;D^DATA TYPE
 ;;R^"863.6:",.04,"E"
 ;;D^ROUTINE
 ;;R^"863.6:",1,1
 ;;D^Validates the user input.
 ;;R^"863.6:",2,"E"
 ;;D^VAL^OCXFD
 ;;R^"863.6:","863.63:1",.01,"E"
 ;;D^INPUT VALUE
 ;;R^"863.6:","863.63:1",.02,"E"
 ;;D^INPUT
 ;;EOR^
 ;;KEY^863.6:^DIALOGUE VALIDATE STORED VALUE
 ;;R^"863.6:",.01,"E"
 ;;D^DIALOGUE VALIDATE STORED VALUE
 ;;R^"863.6:",.02,"E"
 ;;D^DT VAL
 ;;R^"863.6:",.03,"E"
 ;;D^DATA TYPE
 ;;R^"863.6:",.04,"E"
 ;;D^ROUTINE
 ;;R^"863.6:",1,1
 ;;D^Validates the value stored in INVAL
 ;;R^"863.6:",2,"E"
 ;;D^VAL^OCXFD
 ;;R^"863.6:","863.63:1",.01,"E"
 ;;D^INPUT VALUE
 ;;R^"863.6:","863.63:1",.02,"E"
 ;;D^INPUT
 ;;EOR^
 ;;KEY^863.6:^PARAMETER VALUE DIALOGUE
 ;;R^"863.6:",.01,"E"
 ;;D^PARAMETER VALUE DIALOGUE
 ;;R^"863.6:",.02,"E"
 ;;D^READER
 ;;R^"863.6:",.03,"E"
 ;;D^PARAMETER
 ;;R^"863.6:",.04,"E"
 ;;D^ROUTINE
 ;;R^"863.6:",1,1
 ;;D^Every parameter has a data type.  This data type determines the
 ;;R^"863.6:",1,2
 ;;D^dialogue, transforms and validations related to each parameter
 ;;R^"863.6:",1,3
 ;;D^value.
 ;;R^"863.6:",2,"E"
 ;;D^GETVAL^OCXFD
 ;;EOR^
 ;;KEY^863.6:^TEST
 ;;R^"863.6:",.01,"E"
 ;;D^TEST
 ;;R^"863.6:",.02,"E"
 ;;D^TEST
 ;;R^"863.6:",.03,"E"
 ;;D^DATA TYPE
 ;;R^"863.6:",.04,"E"
 ;;D^ROUTINE
 ;;R^"863.6:",1,1
 ;;D^XXXXXXX
 ;;R^"863.6:",2,"E"
 ;;D^GEN^OCXFDMOM
 ;;R^"863.6:","863.63:1",.01,"E"
 ;;D^LINE FEED
 ;;R^"863.6:","863.63:1",1,"E"
 ;;D^5
 ;;R^"863.6:","863.63:2",.01,"E"
 ;;D^TAB OFFSET
 ;;R^"863.6:","863.63:2",1,"E"
 ;;D^5
 ;;EOR^
 ;;KEY^863.6:^LIST ENTRIES
 ;;R^"863.6:",.01,"E"
 ;;D^LIST ENTRIES
 ;;EOR^
 ;;KEY^863.6:^USER CLASS LOOKUP
 ;;R^"863.6:",.01,"E"
 ;;D^USER CLASS LOOKUP
 ;;R^"863.6:",.02,"E"
 ;;D^USER CLASS LOOKUP
 ;;R^"863.6:",.03,"E"
 ;;D^CLASS
 ;;R^"863.6:",.04,"E"
 ;;D^ROUTINE
 ;;R^"863.6:",1,1
 ;;D^ 
 ;;R^"863.6:",1,2
 ;;D^  Returns an object identifier
 ;;R^"863.6:",1,3
 ;;D^ 
 ;;R^"863.6:",2,"E"
 ;;D^GETINST^OCXFLK
 ;;R^"863.6:","863.63:1",.01,"E"
 ;;D^TAB OFFSET
 ;;R^"863.6:","863.63:1",.02,"E"
 ;;D^INPUT
 ;;R^"863.6:","863.63:10",.01,"E"
 ;;D^MULTI SELECT
 ;;R^"863.6:","863.63:10",.02,"E"
 ;;D^INPUT
 ;;R^"863.6:","863.63:2",.01,"E"
 ;;D^LINE FEED
 ;;R^"863.6:","863.63:2",.02,"E"
 ;;D^INPUT
 ;;R^"863.6:","863.63:3",.01,"E"
 ;;D^OUTPUT VARIABLE
 ;;R^"863.6:","863.63:3",.02,"E"
 ;;D^INPUT
 ;;R^"863.6:","863.63:4",.01,"E"
 ;;D^QUERY
 ;;R^"863.6:","863.63:5",.01,"E"
 ;;D^DEFAULT VALUE
 ;;R^"863.6:","863.63:6",.01,"E"
 ;;D^SILENT CALL
 ;;R^"863.6:","863.63:7",.01,"E"
 ;;D^FM SCREEN CODE
 ;;R^"863.6:","863.63:8",.01,"E"
 ;;D^HELP EXECUTABLE
 ;;R^"863.6:","863.63:9",.01,"E"
 ;;D^FM CROSS REFERENCE LIST
 ;;EOR^
 ;;EOF^OCXS(863.6)^1
 ;;SOF^863.4  OCX MDD ATTRIBUTE
 ;;KEY^863.4:^NAME OF PATIENT
 ;;R^"863.4:",.01,"E"
 ;;D^NAME OF PATIENT
 ;;EOR^
 ;;KEY^863.4:^SEX OF PATIENT
 ;;R^"863.4:",.01,"E"
 ;;D^SEX OF PATIENT
 ;;EOR^
 ;1;
 ;

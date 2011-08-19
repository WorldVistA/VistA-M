OCXDI03B ;SLC/RJS,CLA - OCX PACKAGE DIAGNOSTIC ROUTINES ;SEP 7,1999 at 10:30
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
 ;
 ;
 Q
 ;
DATA ;
 ;
 ;;D^Procedure uses non-barium contrast media and patient is taking glucophage.
 ;;EOR^
 ;;KEY^860.2:^POLYPHARMACY
 ;;R^"860.2:",.01,"E"
 ;;D^POLYPHARMACY
 ;;R^"860.2:","860.21:1",.01,"E"
 ;;D^POLYPHARMACY
 ;;R^"860.2:","860.21:1",.02,"E"
 ;;D^SIMPLE DEFINITION
 ;;R^"860.2:","860.21:1",1,"E"
 ;;D^POLYPHARMACY
 ;;R^"860.2:","860.22:1",.01,"E"
 ;;D^1
 ;;R^"860.2:","860.22:1",1,"E"
 ;;D^POLYPHARMACY
 ;;R^"860.2:","860.22:1",2,"E"
 ;;D^POLYPHARMACY
 ;;R^"860.2:","860.22:1",6,"E"
 ;;D^Potential polypharmacy - patient currently receiving |NUMBER OF MEDS| medications.
 ;;EOR^
 ;;KEY^860.2:^LAB RESULTS
 ;;R^"860.2:",.01,"E"
 ;;D^LAB RESULTS
 ;;R^"860.2:","860.21:1",.01,"E"
 ;;D^HL7 LAB RESULTS
 ;;R^"860.2:","860.21:1",.02,"E"
 ;;D^SIMPLE DEFINITION
 ;;R^"860.2:","860.21:1",1,"E"
 ;;D^HL7 FINAL LAB RESULT
 ;;R^"860.2:","860.22:1",.01,"E"
 ;;D^1
 ;;R^"860.2:","860.22:1",1,"E"
 ;;D^HL7 LAB RESULTS
 ;;R^"860.2:","860.22:1",3,"E"
 ;;D^LAB RESULTS
 ;;R^"860.2:","860.22:1",5,"E"
 ;;D^Labs resulted - [|ORDERABLE ITEM NAME|]
 ;;EOR^
 ;;EOF^OCXS(860.2)^1
 ;1;
 ;

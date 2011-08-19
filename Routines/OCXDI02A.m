OCXDI02A ;SLC/RJS,CLA - OCX PACKAGE DIAGNOSTIC ROUTINES ;SEP 7,1999 at 10:30
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
 G ^OCXDI02B
 ;
 Q
 ;
DATA ;
 ;
 ;;R^"863.3:",.01,"E"
 ;;D^PATIENT.WBC_W/IN_7_DAYS_FLAG
 ;;R^"863.3:",.02,"E"
 ;;D^PATIENT
 ;;R^"863.3:",.05,"E"
 ;;D^WBC W/IN 7 DAYS
 ;;R^"863.3:",.06,"E"
 ;;D^999
 ;;R^"863.3:","863.32:1",.01,"E"
 ;;D^OCXO EXTERNAL FUNCTION CALL
 ;;R^"863.3:","863.32:1",1,"E"
 ;;D^RECWBC(|PATIENT IEN|,7)
 ;;R^"863.3:","863.32:2",.01,"E"
 ;;D^OCXO UP-ARROW PIECE NUMBER
 ;;R^"863.3:","863.32:2",1,"E"
 ;;D^1
 ;;EOR^
 ;;KEY^863.3:^QUERY.DATA
 ;;R^"863.3:",.01,"E"
 ;;D^QUERY.DATA
 ;;R^"863.3:",.02,"E"
 ;;D^PATIENT
 ;;R^"863.3:",.05,"E"
 ;;D^QUERY DATA
 ;;R^"863.3:","863.32:1",.01,"E"
 ;;D^OCXO VARIABLE NAME
 ;;R^"863.3:","863.32:1",1,"E"
 ;;D^OCXGND
 ;;EOR^
 ;;KEY^863.3:^PATIENT.CLOZ_ANC_W/IN_7_FLAG
 ;;R^"863.3:",.01,"E"
 ;;D^PATIENT.CLOZ_ANC_W/IN_7_FLAG
 ;;R^"863.3:",.02,"E"
 ;;D^PATIENT
 ;;R^"863.3:",.05,"E"
 ;;D^CLOZAPINE ANC W/IN 7 FLAG
 ;;R^"863.3:","863.32:1",.01,"E"
 ;;D^OCXO EXTERNAL FUNCTION CALL
 ;;R^"863.3:","863.32:1",1,"E"
 ;;D^CLOZLABS^ORKLR(|PATIENT IEN|,7,|DISP DRUG IEN|)
 ;;R^"863.3:","863.32:2",.01,"E"
 ;;D^OCXO UP-ARROW PIECE NUMBER
 ;;R^"863.3:","863.32:2",1,"E"
 ;;D^3
 ;;R^"863.3:","863.32:3",.01,"E"
 ;;D^OCXO SEMI-COLON PIECE NUMBER
 ;;R^"863.3:","863.32:3",1,"E"
 ;;D^1
 ;;EOR^
 ;;KEY^863.3:^PATIENT.CLOZ_ANC_W/IN_7_RSLT
 ;;R^"863.3:",.01,"E"
 ;;D^PATIENT.CLOZ_ANC_W/IN_7_RSLT
 ;;R^"863.3:",.02,"E"
 ;;D^PATIENT
 ;;R^"863.3:",.05,"E"
 ;;D^CLOZAPINE ANC W/IN 7 RESULT
 ;;R^"863.3:","863.32:1",.01,"E"
 ;;D^OCXO EXTERNAL FUNCTION CALL
 ;;R^"863.3:","863.32:1",1,"E"
 ;;D^CLOZLABS^ORKLR(|PATIENT IEN|,7,|DISP DRUG IEN|)
 ;;R^"863.3:","863.32:2",.01,"E"
 ;;D^OCXO UP-ARROW PIECE NUMBER
 ;;R^"863.3:","863.32:2",1,"E"
 ;;D^3
 ;;R^"863.3:","863.32:3",.01,"E"
 ;;D^OCXO SEMI-COLON PIECE NUMBER
 ;;R^"863.3:","863.32:3",1,"E"
 ;;D^2
 ;;EOR^
 ;;KEY^863.3:^PATIENT.CLOZ_WBC_W/IN_7_FLAG
 ;;R^"863.3:",.01,"E"
 ;;D^PATIENT.CLOZ_WBC_W/IN_7_FLAG
 ;;R^"863.3:",.02,"E"
 ;;D^PATIENT
 ;;R^"863.3:",.05,"E"
 ;;D^CLOZAPINE WBC W/IN 7 FLAG
 ;;R^"863.3:",.06,"E"
 ;;D^999
 ;;R^"863.3:","863.32:1",.01,"E"
 ;;D^OCXO EXTERNAL FUNCTION CALL
 ;;R^"863.3:","863.32:1",1,"E"
 ;;D^CLOZLABS^ORKLR(|PATIENT IEN|,7,|DISP DRUG IEN|)
 ;;R^"863.3:","863.32:2",.01,"E"
 ;;D^OCXO UP-ARROW PIECE NUMBER
 ;;R^"863.3:","863.32:2",1,"E"
 ;;D^2
 ;;R^"863.3:","863.32:3",.01,"E"
 ;;D^OCXO SEMI-COLON PIECE NUMBER
 ;;R^"863.3:","863.32:3",1,"E"
 ;;D^1
 ;;EOR^
 ;;KEY^863.3:^PATIENT.CLOZ_WBC_W/IN_7_RSLT
 ;;R^"863.3:",.01,"E"
 ;;D^PATIENT.CLOZ_WBC_W/IN_7_RSLT
 ;;R^"863.3:",.02,"E"
 ;;D^PATIENT
 ;;R^"863.3:",.05,"E"
 ;;D^CLOZAPINE WBC W/IN 7 RESULT
 ;;R^"863.3:","863.32:1",.01,"E"
 ;;D^OCXO EXTERNAL FUNCTION CALL
 ;;R^"863.3:","863.32:1",1,"E"
 ;;D^CLOZLABS^ORKLR(|PATIENT IEN|,7,|DISP DRUG IEN|)
 ;;R^"863.3:","863.32:2",.01,"E"
 ;;D^OCXO UP-ARROW PIECE NUMBER
 ;;R^"863.3:","863.32:2",1,"E"
 ;;D^2
 ;;R^"863.3:","863.32:3",.01,"E"
 ;;D^OCXO SEMI-COLON PIECE NUMBER
 ;;R^"863.3:","863.32:3",1,"E"
 ;;D^2
 ;;EOR^
 ;;EOF^OCXS(863.3)^1
 ;;SOF^863  OCX MDD CLASS
 ;;KEY^863:^APPLICATION
 ;;R^"863:",.01,"E"
 ;;D^APPLICATION
 ;;R^"863:",.02,"E"
 ;;D^863.1
 ;;R^"863:",2,1
 ;;D^The "application" determines what subjects are available to the end user.
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
 ;;KEY^863:^SUBJECT
 ;;R^"863:",.01,"E"
 ;;D^SUBJECT
 ;;R^"863:",.02,"E"
 ;;D^863.2
 ;;R^"863:",2,1
 ;;D^The view. What you are looking for; e.g., patients , providers, etc.
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
 ;;KEY^863:^LINK
 ;;R^"863:",.01,"E"
 ;;D^LINK
 ;;R^"863:",.02,"E"
 ;;D^863.3
 ;;R^"863:",2,1
 ;;D^The pathway between a subject and atrribute.
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
 ;;KEY^863:^ATTRIBUTE
 ;;R^"863:",.01,"E"
 ;;D^ATTRIBUTE
 ;;R^"863:",.02,"E"
 ;;D^863.4
 ;;R^"863:",2,1
 ;;D^Some destinguishing characteristic of the subject; e.g., sex, DOB, etc.
 ;;R^"863:","863.01:1",.01,"E"
 ;1;
 ;

IBCNRE4 ;DAOU/DMK - Edit PLAN APPLICATION Sub-file ;23-DEC-2003
 ;;2.0;INTEGRATED BILLING;**251**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; Specific to E-PHARM APPLICATION Entry
 ; Edit LOCAL ACTIVE? Field
 ;
 ; 366.033 PLAN APPLICATION
 ;    .01  APPLICATION
 ;    .03  LOCAL ACTIVE?
 ;
1000 ; Control processing
 N ANAME,APIEN,FIELDNO,FILENO,FILENO1,QUIT
 N DISYS
 ;
 D INIT1
 D HEADING
 F  D 2000 Q:QUIT
 Q
 ;
2000 ; Control processing
 N CONTINUE,IEN,IENS,IENS1,KEY
 ;
 S QUIT=0
 ;
 ; Control file entry selection and subfile entry validation
 D IEN
 I IEN=-1 S QUIT=1 Q
 I APIEN=-1 Q
 ;
 ; Control file entry printing
 D PRINT1
 ;
 ; Control pause
 D CONTINUE
 ;
 ; Control subfile entry printing
 D PRINT2
 ;
 ; Control subfile entry editing
 D EDIT
 Q
 ;
CONTINUE ; Pause until user ready to continue
 N CONTINUE
 R !,"Press Enter / Return to continue: ",CONTINUE:$S($D(DTIME):DTIME,1:300)
 W !
 Q
 ;
EDIT ; Edit subfile entry data
 ; 366.033 PLAN APPLICATION Subfile
 ;
 N DA,DIDEL,DIC,DIE,DLAYGO,DR,DTOUT,X,Y
 N %,A,D,D0,DDER,DI,DISYS,DQ,OLD
 ;
 S DA=APIEN,DA(1)=IEN
 S DIE=$$ROOT^DILFD(FILENO1,","_IEN_",")
 ;
 ; .03  LOCAL ACTIVE
 S DR=".03R"_"~"_KEY_" - Local Active?"
 ;
 ; Quit if value unchanged
 ; OLD = old value
 ;   X = new value
 S OLD=$$GET1^DIQ(FILENO1,IENS1,.03,"I")
 S DR=DR_";"_"S:OLD=X Y="""""
 ;
 ; .04  USER EDITED LOCAL
 S DR=DR_";"_".04////"_DUZ
 ;
 ; .05  DATE/TIME LOCAL EDITED
 S DR=DR_";"_".05////"_$$NOW^XLFDT()
 ;
 D ^DIE
 ;
 W !
 Q
 ;
HEADING ; Print heading
 W @IOF
 W "PLAN File Inquiry and Edit (E-PHARM)",!
 Q
 ;
IEN ; Select file entry
 N I
 ;
 S IEN=$$SELECT1^IBCNRFM1(FILENO,"Select Plan ID: ")
 I IEN=-1 Q
 S IENS=IEN_","
 ;
 ; E-PHARM APPLICATION Defined?
 S APIEN=$$LOOKUP2^IBCNRFM1(FILENO,IEN,FIELDNO,ANAME)
 I APIEN=-1 W " E-PHARM APPLICATION not defined" Q
 S IENS1=APIEN_","_IEN_","
 Q
 ;
INIT1 ; Initialize variables
 S ANAME="E-PHARM"
 S FIELDNO=3
 S FILENO=366.03
 S FILENO1=FILENO_FIELDNO
 I '$D(IOF) D HOME^%ZIS
 Q
 ;
PRINT1 ; Print file entry data
 ; 366.03 PLAN File
 ;
 N A
 ;
 W !!
 ;
 D GETS^DIQ(FILENO,IENS,"*","","A")
 ;
 ; .01 ID
 S KEY=A(FILENO,IENS,.01)
 W $J("Plan ID: ",40),$G(A(FILENO,IENS,.01)),!
 ;
 ; .07 DATE/TIME CREATED
 W $J("Date/Time Created: ",40),$G(A(FILENO,IENS,.07)),!
 ;
 ; .02 NAME
 W $J("Plan Name: ",40),$G(A(FILENO,IENS,.02)),!
 ;
 ; .04 NAME - SHORT
 W $J("Plan Name - Short: ",40),$G(A(FILENO,IENS,.04)),!
 ;
 ; .03 PAYER NAME
 W $J("Payer Name: ",40),$G(A(FILENO,IENS,.03)),!
 ;
 ; .05 TYPE
 W $J("Type: ",40),$G(A(FILENO,IENS,.05)),!
 ;
 ; .06 REGION
 W $J("Region: ",40),$G(A(FILENO,IENS,.06)),!
 ;
 ; 10.01 PHARMACY BENEFITS MANAGER NAME
 W $J("Pharmacy Benefits Manager (PBM) Name: ",40),$G(A(FILENO,IENS,10.01)),!
 ;
 ; 10.02 BANKING IDENTIFICATION NUMBER
 W $J("Banking Identification Number (BIN): ",40),$G(A(FILENO,IENS,10.02)),!
 ;
 ; 10.03 PROCESSOR CONTROL NUMBER (PCN)
 W $J("Processor Control Number (PCN): ",40),$G(A(FILENO,IENS,10.03)),!
 ;
 ; 10.04 NCPDP PROCESSOR NAME
 W $J("NCPDP Processor Name: ",40),$G(A(FILENO,IENS,10.04)),!
 ;
 ; 10.05 ENABLED?
 W $J("Enabled?: ",40),$G(A(FILENO,IENS,10.05)),!
 ;
 ; 10.06 SOFTWARE VENDOR ID
 W $J("Software Vendor ID: ",40),$G(A(FILENO,IENS,10.06)),!
 ;
 ; 10.07 BILLING PAYER SHEET NAME
 W $J("Billing Payer Sheet Name: ",40),$G(A(FILENO,IENS,10.07)),!
 ;
 ; 10.08 REVERSAL PAYER SHEET NAME
 W $J("Reversal Payer Sheet Name: ",40),$G(A(FILENO,IENS,10.08)),!
 ;
 ; 10.09 REBILL PAYER SHEET NAME
 W $J("Rebill Payer Sheet Name: ",40),$G(A(FILENO,IENS,10.09)),!
 ;
 ; 10.1 MAXIMUM NCPDP TRANSACTIONS
 W $J("Maximum NCPDP Transactions: ",40),$G(A(FILENO,IENS,10.1)),!
 ;
 ; 10.11 TEST BILLING PAYER SHEET NAME
 W $J("Test Billing Payer Sheet Name: ",40),$G(A(FILENO,IENS,10.11)),!
 ;
 ; 10.12 TEST REVERSAL PAYER SHEET NAME
 W $J("Test Reversal Payer Sheet Name: ",40),$G(A(FILENO,IENS,10.12)),!
 ;
 ; 10.13 TEST REBILL PAYER SHEET NAME
 W $J("Test Rebill Payer Sheet Name: ",40),$G(A(FILENO,IENS,10.13)),!
 Q
 ;
PRINT2 ; Print subfile entry data
 ; 366.033 PLAN APPLICATION Subfile
 ;
 N A
 ;
 W !
 ;
 D GETS^DIQ(FILENO1,IENS1,"*","","A")
 ;
 ; .01 APPLICATION
 W $J("Application: ",40),$G(A(FILENO1,IENS1,.01)),!
 ;
 ; .13 DATE/TIME CREATED
 W $J("Date/Time Created: ",40),$G(A(FILENO1,IENS1,.13)),!
 ;
 ; .11 DEACTIVATED
 W $J("Deactivated? ",40),$G(A(FILENO1,IENS1,.11)),!
 ;
 ; .12 DATE/TIME DEACTIVATED
 W $J("Date/Time Deactivated: ",40),$G(A(FILENO1,IENS1,.12)),!
 ;
 ; .02 NATIONAL ACTIVE
 W $J("National Active? ",40),$G(A(FILENO1,IENS1,.02)),!
 ;
 ; .06 DATE/TIME NATIONAL EDITED
 W $J("Date/Time National Edited: ",40),$G(A(FILENO1,IENS1,.06)),!
 ;
 ; .03 LOCAL ACTIVE
 W $J("Local Active? ",40),$G(A(FILENO1,IENS1,.03)),!
 ;
 ; .05 DATE/TIME LOCAL EDITED
 W $J("Date/Time Local Edited: ",40),$G(A(FILENO1,IENS1,.05)),!
 ;
 ; .04 USER EDITED LOCAL
 W $J("User Edited Local: ",40),$G(A(FILENO1,IENS1,.04)),!
 Q

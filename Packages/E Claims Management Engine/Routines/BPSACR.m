BPSACR ;AITC/PD - Auto Close Reject Code Enter/Edit ;11/12/2024
 ;;1.0;E CLAIMS MGMT ENGINE;**39**;JUN 2004;Build 14
 ;;Per VA Directive 6402, this routine should not be modified.
 ;;
 ;
EN ; Main entry point for BPS AUTO CLOSE REJECTS
 ;
 N BPSDUZ
 ;
 ; User must hold BPS SUPERVISOR key to use this option.
 ;
 I '$D(^XUSEC("BPS SUPERVISOR",DUZ)) D  Q
 . W !,$C(7),"Requires the BPS SUPERVISOR key"
 ;
 D EN^VALM("BPS AUTO CLOSE REJECTS")
 ;
 Q
 ;
HDR ; Header
 ;
 S VALMHDR(1)=""
 S VALMHDR(2)="Reject Codes - Auto Close Claims"
 Q
 ;
INIT ; Initialize
 ;
 ; Populate the list view with entries from the BPS AUTO CLOSE REJECT CODES
 ; file (#9002313.94).  The "C" index of ^BPSACR sorts the reject codes in
 ; ascending order by the external value of the reject code.  Codes will 
 ; display in the list view in ascending order.
 ;
 ; Capture DUZ(0) to ensure it is set correctly upon exiting option.
 S BPSDUZ=DUZ(0)
 ; Set DUZ(0)=@ to allow supervisor to perform deletions of file entries.
 S DUZ(0)="@"
 ;
 N ACRIEN,LINE,REJCD,REJCDE,REJIEN,RNB,STR,STR1,THRS
 ;
 K ^TMP("BPSACR",$J)
 S VALMCNT=1
 ;
 S LINE=0
 S REJCD=""
 F  S REJCD=$O(^BPSACR("C",REJCD)) Q:REJCD=""  D
 . S REJIEN=$O(^BPSACR("C",REJCD,""))
 . S ACRIEN=$O(^BPSACR("C",REJCD,REJIEN,""))
 . S REJCDE=$$GET1^DIQ(9002313.93,REJIEN,.02)
 . I $L(REJCDE)>61 S REJCDE=$E(REJCDE,1,58)_"..."
 . S RNB=$$GET1^DIQ(9002313.94,ACRIEN,.02)
 . I $L(RNB)>63 S RNB=$E(RNB,1,60)_"..."
 . S THRS=$$GET1^DIQ(9002313.94,ACRIEN,.03)
 . S STR="",STR1=""
 . S $E(STR,2)=$J(REJCD,4)
 . S $E(STR,8)=$E(REJCDE,1,61)
 . S $E(STR,71)="$"_$J(THRS,8)
 . S $E(STR1,12)="RNB: "_$E(RNB,1,63)
 . D LINE(STR)
 . D LINE(STR1)
 Q
 ; 
LINE(STR) ; Set Line into List View
 ;
 S LINE=LINE+1
 D SET^VALM10(LINE,STR)
 S VALMCNT=LINE
 Q
 ;
HELP ; Help code
 ;
 S X="?" D DISP^XQORM1 W !!
 K X
 ;
 Q
 ;
EC ; EC Action
 ;
 ; Edit Auto Close Reject 
 ; Allow user to enter a new Auto Close Reject code or edit an existing.
 ; The specific entry will be locked to prevent another user from editing
 ; the same code at the same time.
 ;
 N ACIEN,BPSFDA,DA,DAX,DAX1,DIE,DIC,DR,DTOUT,DUOUT,IEN,INCOMPLETE,QUIT,REJCDX,REJCIEN,REJCTXT,REJEXT,REJIEN
 ;
 D FULL^VALM1
 ;
 ; Display informational message to user upon initially executing the action.
 ;
 W !
 W !,"When a pharmacist ignores a reject defined as an auto close reject and the"
 W !,"specified parameter criteria is met, the system will automatically close the"
 W !,"claim with the specified Claims Tracking Non-Billable Reason."
 W !
 W !,"The auto close functionality does not apply for claims with coordination "
 W !,"of benefits."
 W !
 W !,"The auto close functionality does not apply for claims with more than one"
 W !,"reject code."
 ;
EC1 ; Reentry point when entering multiple reject codes
 ;
 ; EC1 is a reentry point to allow user to enter multiple reject codes without the
 ; informational message displaying each time.
 ;
 ; Initial Auto Close Claim Reject Code prompt.  This lookup uses the BPS NCPDP
 ; REJECT CODES file (#9002313.93).
 ;
 W !
 N DIC
 S DIC="^BPSF(9002313.93,"
 S DIC(0)="AEMNQ"
 S DIC("A")="Auto Close Claim Reject Code: "
 S DIC("S")="I ($P(^(0),U)'=""eC""),($P(^(0),U)'=""eT"")"
 D ^DIC
 ;
 ; User entered ^ or timed out.  Return to list view display.
 ;
 I (Y=-1)!$D(DUOUT)!$D(DTOUT) S VALMBCK="R",DUZ(0)=BPSDUZ D INIT Q
 ;
 ; REJIEN = IEN from #9002313.93
 ; REJEXT = External value of the reject code
 ; 
 S REJIEN=$P(Y,"^")
 S REJEXT=$P(Y,"^",2)
 ;
 K X,DIC,Y
 ;
 ; Using the external value of the reject code, and the "B" index, determine if
 ; the reject code exists in the BPS AUTO CLOSE REJECTS file.  If the reject code;
 ; does not exist, create a new entry in the file and set DOLLAR THRESHOLD to 0.
 ; For newly added reject codes, RNB PTR will not be defined at this point.
 ;
 ; Display a message to the user indicating if the reject code is new, and being added,
 ; or existing, and being edited.
 ;
 S ADD=0
 I '$D(^BPSACR("B",REJIEN)) D
 . W !!,"You are entering a new Auto Close Claim Reject Code - "_REJEXT,!
 . S ADD=1
 . ;
 . ; Create a new entry in file 90023123.94, setting the External Reject Code
 . ; entered by the user, and default the dollar threshold to 0.
 . ;
 . S BPSFDA(9002313.94,"+1,",.01)=REJIEN
 . S BPSFDA(9002313.94,"+1,",.03)=100
 . D UPDATE^DIE(,"BPSFDA")
 E  W !!,"You are editing an existing Auto Close Claim Reject Code - "_REJEXT,!
 ;
EC2 ;
 ;
 ; EC2 is reentry point if a specific reject code does not have all required
 ; values set.  
 ;
 ; Edit REJECT CODE (#.01), RNB (#.02), and THRESHOLD (#.03)
 ;
 S IEN=$O(^BPSACR("B",REJIEN,""))
 S DA=IEN
 S DIE=9002313.94
 S DR=".01Auto Close Claim Reject Code"
 S DR=DR_";.02Claims Tracking Non-Billable Reason"
 S DR=DR_";.03Dollar Threshold"
 ;
 ; Check if selected reject code is currently being edited by another user.
 ; If so, display a message to the user.  User will be returned to initial 
 ; prompt to select another Auto Close Claim Reject Code.
 ;
 L +^BPSACR(IEN):0 I $T D ^DIE L -^BPSACR(IEN)
 I '$T D  Q
 . W !?5,"*** Another user is editing this entry. ***"
 . S VALMBCK="R"
 . D WAIT^VALM1
 . D INIT
 ;
 ; All entries must include AUTO CLOSE REJECT CODE (field #.01) and
 ; RNB PTR (field #.02).  DOLLAR THRESHOLD (field #.03) will initially
 ; default to 0.  The system will not allow this field to be deleted.
 ; At a minimum, the value must be 0.  The range is 0-99999.
 ;
 ; The following check ensures fields .01 and .02 are defined.  If not, 
 ; the user will be prompted to input a value for each field.
 ;
 ; INCOMPLETE = 0 indicates the entry has both values defined.  If 
 ; either value is not defined, INCOMPLETE will be set to 1.
 ;
 ; QUIT is used in case user enters ^ to exit.  If the reject code
 ; being edited is complete, and the system detects the user entered ^
 ; at any of the prompts, the user will be returned to the list view.
 ; $D(Y) indicates user entered ^ during call to ^DIE.
 ; 
 S INCOMPLETE=0,QUIT=0
 I $D(Y) D
 . I $$GET1^DIQ(9002313.94,IEN,.01)="" S INCOMPLETE=1
 . I $$GET1^DIQ(9002313.94,IEN,.02)="" S INCOMPLETE=1
 . I INCOMPLETE=0 S QUIT=1
 ;
 I INCOMPLETE=1 S DR=".01///@" D ^DIE
 ;
 ; Make sure "C" index is in sync with "B" index.
 ;
 S REJCIEN=""
 F  S REJCIEN=$O(^BPSACR("C",REJCIEN)) Q:REJCIEN=""  D
 . S REJCTXT=$O(^BPSACR("C",REJCIEN,""))
 . I '$D(^BPSACR("B",REJCTXT)) K ^BPSACR("C",REJCIEN)
 ;
 ; Loop through entries and make sure there are no duplicates
 S REJIEN=""
 F  S REJIEN=$O(^BPSACR("B",REJIEN)) Q:REJIEN=""  D
 . S ACIEN=""
 . S CNT=""
 . F  S ACIEN=$O(^BPSACR("B",REJIEN,ACIEN),-1) Q:ACIEN=""  D
 . . S CNT=CNT+1
 . . I CNT>1 D
 . . . S DA=ACIEN
 . . . S DIE=9002313.94
 . . . S DR=".01///@"
 . . . D ^DIE
 ;
 ; User entered ^ at one of the prompts and the entry is complete.  Return user
 ; to list view.
 ;
 I QUIT S VALMBCK="R",DUZ(0)=BPSDUZ D INIT Q
 ;
 ; At this point, adding/editing of the reject code is complete. Go to entry point
 ; EC1 to prompt user for another reject code to add or edit without having the
 ; initial informational message display.
 ;
 G EC1
 ;
 Q
 ;
EXIT ; Exit Option
 ;
 ; Reesatablish scrolling mode and delete the temporary global used by the list
 ; view before exiting option.
 ;
 D FULL^VALM1
 K ^TMP("BPSACR",$J)
 S DUZ(0)=BPSDUZ
 ;
 Q

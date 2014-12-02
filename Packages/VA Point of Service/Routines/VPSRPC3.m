VPSRPC3 ;DALOI/KML - VPS Pre-registration RPC ;4/26/2012
 ;;1.0;VA POINT OF SERVICE (KIOSKS);**2**;Oct 21, 2011;Build 41
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ; the procedures for this RPC were taken from the routine that supports the DGPRE PRE-REGISTER OPTION
 ; to update the various files when a Vetlink Kiosk Preregister event occurs
PREREG(RESULT,DFN,PRESTAT) ; Pre-Register a patient
 ; RPC=VPS PATIENT PRE-REGISTRATION
 ; input variables
 ; DFN - patient IEN, required
 ; PRESTAT - code for the call such as 'C' = 'CONTACTED' or
 ; 'X' = 'CHANGE INFORMATION', required
 ; output variable
 ; RESULT - variable that returns the result of the RPC, includes a
 ; a number (1 or 0) followed by a short message
 N VALID
 K RESULT
 ; check for required parameters coming in
 I $G(DFN)="" S RESULT="0,DFN not sent." Q
 I +DFN=0 S RESULT="0,invalid DFN." Q
 I '$D(^DPT(DFN,0)) S RESULT="0,Patient not found." Q
 ; validate code for call status
 I $G(PRESTAT)="" S RESULT="0,call STATUS code not sent." Q
 S VALID=$$CHKST(PRESTAT) I 'VALID S RESULT="0,Invalid code for call status." Q
 N PIEN,PDIV,PIDX,NEW,LOCK
 S (PIDX,LOCK)=0,NEW=1
 ; PREREGISTRATION Nightly BACKGROUND JOB (SCHEDULED TASK) adds new entries to 41.42.  
 ; VistA preregistration option allows processing to continue if there isn't a patient entry in 41.42.  
 I $D(^DGS(41.42,"B",DFN)) D  ; ICR 5817
 . S NEW=0
 . S PIDX=$O(^DGS(41.42,"B",DFN,PIDX))
 . S PDIV=$P($G(^DGS(41.42,PIDX,0)),U,2)
 . I PIDX]"" L +^DGS(41.42,PIDX):2 I $T S LOCK=1
 I 'LOCK&('NEW) S RESULT="0,Another user is editing this patient. Preregistration cannot be performed at this time." Q
 I $G(PDIV)']"" S PDIV=$$PRIM^VASITE  ; ICR#10112 - $$PRIM^VASITE
 D UPDLOG(DFN,PRESTAT,PDIV)
 ; update pre-registration audit log   
 ; need to include ICR #
 N TMSTMP S TMSTMP=$$NOW^XLFDT   ; ICR 10103
 ; add an entry to PRE-REGISTRATION AUDIT file
 ; ICR # 5797
 S DIC="^DGS(41.41,",DIC(0)="L",X=DFN
 S DIC("DR")="1///^S X=TMSTMP;2////^S X=DUZ"
 D FILE^DICN
 ; need to update the PRE-REGISTRATION CALL LIST file
 I 'NEW,PIDX D
 . K DA,DIE,DR
 . S DA=PIDX,DIE="^DGS(41.42,"
 . S DR="4///Y" S DR=DR_";3///^S X=TMSTMP"
 . D ^DIE
 . L -^DGS(41.42,PIDX)
 S RESULT="1,Pre-Registration completed."
 ;
 Q
UPDLOG(DFN,STATUS,DIVIEN) ;  Update PRE-REGISTRATION CALL File, #41.43
 ; ICR # 5798 - allows VPS package to add and edit an entry in the PRE-REGISTRATION CALL file
 ; Input:
 ;   DFN   - The IEN of the patient being called
 ;   STATUS  - Status of the call attempt
 ;   DIVIEN - Division IEN (used for sorting)
 ;
 N DIC,X,Y,DIE,DR,DA,DIK
 S DIC="^DGS(41.43,"
 S DIC(0)="L"
 S X=$$NOW^XLFDT
 D FILE^DICN
 Q:Y<0   ; VistA option notifies user when an entry cannot be added to 41.43, but continues with processing the preregistration session.
 S DA=+Y
 L +^DGS(41.43,+Y):2 I '$T S DIK="^DGS(41.43," D ^DIK K DIK Q  ; remove stub entry if entry cannot be locked
 S DIE="^DGS(41.43,"
 S DR="1////^S X=DFN;2////^S X=DUZ;3///^S X=STATUS;5////^S X=$S(+DIVIEN>0:DIVIEN,1:"""")"
 D ^DIE K DIE
 L -^DGS(41.43,DA)
 Q
 ;
CHKST(CODE) ;  determine if status code is valid
 ; input - 
 ; CODE = status of pre-registration call - this code is sent to the RPC from the Vetlink Kiosk
 ; output -
 ; FOUND = result of the validation which determines if the incoming kiosk code was matched against one of the valid VistA codes
 N LIST,VALUE,FOUND
 S VALUE="",FOUND=0
 D BLDCODES(.LIST)
 F  S VALUE=$O(LIST(VALUE)) Q:VALUE=""  Q:FOUND  I VALUE=CODE S FOUND=1
 Q FOUND
 ;
BLDCODES(ARRAY) ;build array of valid statuses that represent the outcome of the call to the patient
 ; valid codes can be located at the STATUS field of the PRE-REGISTRATION CALL LOG (#41.43,3).
 ;input/output - ARRAY passed in by reference
 N LN,LINE,STRING
 F LN=1:1 S LINE=$T(CODELST+LN),STRING=$P(LINE,";;",2) Q:STRING=""  S ARRAY($P(STRING,U))=""
 Q
 ;
CODELST ; list of codes
 ;;B^BUSY
 ;;C^CONNECTED
 ;;D^DEATH
 ;;K^CALL BACK
 ;;M^LEFT CALLBACK MESSAGE
 ;;N^NO ANSWER
 ;;P^NO PHONE
 ;;T^DON'T CALL
 ;;U^UNCOOPERATIVE
 ;;V^PREVIOUSLY UPDATED
 ;;W^WRONG NUMBER
 ;;X^CHANGE INFORMATION
 ;;

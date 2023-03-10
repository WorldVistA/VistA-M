PSOBPSS2 ;AITC/MRD - ePharmacy Site Parameters Definition Cont. ;02/24/2021
 ;;7.0;OUTPATIENT PHARMACY;**562**;DEC 1997;Build 19
 ;
EDITALL ; Action for EA Edit All Parameters
 ;
 ; Local variable
 ; RET - for control after return from call - if "^" then call RBUILD and quit
 N RET S RET=""
 ;
 ; Call to General Parameter Edit
 D EDITGEN(.RET)
 I RET=U D RBUILD^PSOBPSSP Q
 ;
 ; Call to Transfer Reject Code Edit
 D EDITTRC(.RET)
 I RET=U D RBUILD^PSOBPSSP Q
 ;
 ; Call to Reject Resolution Required Code Edit
 D EDITRRRC
 ;
 D RBUILD^PSOBPSSP
 Q
 ;
EDITGEN(RETURN) ; Action for EG Edit General Parameters
 ;
 ; Input Parameter
 ; RETURN - Null if normal exit, "^" if timeout or "^" entered
 ;
 ; Variables used by DIE
 N DIE,DA,DIC,DUOUT,DTOUT,DEF
 ;
 ; Set Full Screen mode
 D FULL^VALM1
 ;
 ; Get worklist days & update the record
 S DIE="^PS(52.86,",DA=PSOBPSDV,DR="4" D ^DIE
 ; CHECK FOR TIMEOUT OR ^
 I $G(DTOUT)!$D(Y) S RETURN="^"
 ;
 ; Update EPHARMACY RESPONSE PAUSE
 K DTOUT,DUOUT
 S DEF=$$GET1^DIQ(52.86,PSOBPSDV_",",6,"I")
 I DEF="" S DEF=2
 S DIE="^PS(52.86,",DA=PSOBPSDV,DR="6//"_DEF D ^DIE
 ; CHECK FOR TIMEOUT OR ^
 I $G(DTOUT)!$D(Y) S RETURN="^"
 ;
 ; Get IGNORE THRESHOLD & update the record
 S DIE="^PS(52.86,",DA=PSOBPSDV,DR="7" D ^DIE
 ; CHECK FOR TIMEOUT OR ^
 I $G(DTOUT)!$D(Y) S RETURN="^"
 D RBUILD^PSOBPSSP
 Q
 ;
EDITTRC(RETURN)  ; Action for ET Edit Transfer Reject Code
 ;
 ; Input Parameter
 ; RETURN - Null if normal exit, "^" if timeout or "^" entered
 ;
 ; From EN
 ; PSOBPSDV - current division declared in EN
 ;
 ; Local Variables
 ; PASS1 - used to indicate first pass through edit loop for controlling reject prompt
 ; QT - indicates the loop processing can quit
 ;
 ; Set Full Screen mode
 D FULL^VALM1
 ;
 N QT,PASS1
 S QT=0,PASS1=1
 ;
 ; Informational message
 D TRCMSG^PSOBPSSL
 ;
 ; Loop through Reject Code edits
 F  Q:QT  D
 . ; DIE,DA,DIC,DUOUT,DTOUT,DIR,DIC,X,Y - Used by FileMan
 . N DIE,DR,DA,DUOUT,DTOUT,DIR,DIC,Y,X
 . ; Variables local to this loop
 . ; REJCODE - External Reject code - .01 field from 9002312.93
 . ; REJIEN - Reject code IEN from 9002312.93
 . ; ADD - Flag indicating a new code was selected
 . ; NEWCDPTR - IEN of the Reject Code in 9002313.92 when the user changed the Reject Code
 . ;
 . N REJCODE,REJIEN,ADD,NEWCDPTR
 . ;
 . ; Set up and call Lookup (^DIC)
 . S DIC("A")=$S(PASS1:"",1:"ANOTHER ")_"TRANSFER REJECT CODE: ",PASS1=0
 . S DIC=9002313.93
 . S DIC(0)="QEAZ"
 . S DIC("S")="I '$F("".79.88.943."","".""_$P($G(^(0)),U,1)_""."")"
 . W ! D ^DIC
 . ;
 . ; Check responses to the lookup
 . I $G(DUOUT)!($G(DTOUT)) S RETURN=U,QT=1 Q  ; user entered a ^, or timed out
 . I Y'>0 S QT=1 Q  ; user entered a blank to get out
 . ;
 . S REJIEN=+Y,REJCODE=$P(Y,U,2)
 . S ADD=0
 . ;
 . ; if new code, set up new node
 . I '$D(^PS(52.86,PSOBPSDV,1,"B",REJIEN)) D
 . . ; TRCFDA - FDA structure used by UPDATE^DIE
 . . N TRCFDA
 . . S ADD=1
 . . ;
 . . ;Set up FDA and File the data 
 . . S TRCFDA(52.8651,"+1,"_PSOBPSDV_",",.01)=REJIEN
 . . S TRCFDA(52.8651,"+1,"_PSOBPSDV_",",1)=0 ; Default AUTO SEND
 . . D UPDATE^DIE(,"TRCFDA")
 . . Q
 . ;
 . ; Edit the transfer reject code entry
 . S DA=$O(^PS(52.86,PSOBPSDV,1,"B",REJIEN,0)) Q:'DA
 . S DA(1)=PSOBPSDV
 . S DIE="^PS(52.86,"_DA(1)_",1,"
 . S DR=".01"
 . I ADD W !!?3,"You are entering a new transfer reject code - "_REJCODE_"."
 . E  W !!?3,"You are editing an existing transfer reject code - "_REJCODE_"."
 . D ^DIE
 . ;
 . I '$G(DA) Q  ; user deleted it so we're done
 . I $G(DTOUT) S RETURN=U,QT=1 Q  ; timeout - exit loop
 . I $D(Y) S RETURN=U,QT=1 Q  ; user entered a ^ to exit loop
 . ;
 . ; If the user changed the reject code, check for duplicate OR 79/88/943
 . ; Get the current pointer filed by DIE and compare it to the original pointer
 . S DA=+$G(DA),NEWCDPTR=$P($G(^PS(52.86,PSOBPSDV,1,DA,0)),U,1)
 . I NEWCDPTR'=REJIEN D
 . . ; CTR - used in duplicate check. # of records with same code value
 . . ; IEN - used when checking the "B" index for duplicates using $ORDER
 . . N CTR,IEN
 . . ; NEWCDPTR - holds the new reject code after the user changes it
 . . S (CTR,IEN)=0
 . . F  S IEN=$O(^PS(52.86,PSOBPSDV,1,"B",NEWCDPTR,IEN)) Q:'IEN  S CTR=CTR+1
 . . I CTR>1 D  Q
 . . . S DR=".01////"_REJIEN D ^DIE   ; restore the code pointer
 . . . W !!?3,"You selected a duplicate reject code.  Code '"_REJCODE_"' has been restored."
 . . . S NEWCDPTR=0 ; Clear the new pointer if it is no longer valid
 . . . Q
 . . I $$GET1^DIQ(9002313.93,NEWCDPTR_",",.01)=79 D  Q
 . . . S DR=".01////"_REJIEN D ^DIE   ; restore the code pointer
 . . . W !!?3,"Code '79/RTS' is not valid here.  Code '"_REJCODE_"' has been restored."
 . . . S NEWCDPTR=0 ; Clear the new pointer if it is no longer valid
 . . . Q
 . . I $$GET1^DIQ(9002313.93,NEWCDPTR_",",.01)=88 D  Q
 . . . S DR=".01////"_REJIEN D ^DIE   ; restore the code pointer
 . . . W !!?3,"Reject code '88/DUR' is not valid here. Code '"_REJCODE_"' has been restored."
 . . . S NEWCDPTR=0 ; Clear the new pointer if it is no longer valid
 . . . Q
 . . I $$GET1^DIQ(9002313.93,NEWCDPTR_",",.01)=943 D  Q
 . . . S DR=".01////"_REJIEN D ^DIE   ; restore the code pointer
 . . . W !!?3,"Reject code '943/DUR' is not valid here. Code '"_REJCODE_"' has been restored."
 . . . S NEWCDPTR=0 ; Clear the new pointer if it is no longer valid
 . . . Q
 . . Q
 . ; NEWCDPTR will be 0 if the user tried to enter an invalid or duplicate reject code
 . Q:'NEWCDPTR
 . ;
 . ; Now edit the AUTO SAVE parameter
 . S DA(1)=PSOBPSDV
 . S DIE="^PS(52.86,"_DA(1)_",1,"
 . S DR="1"
 . D ^DIE
 . ;
 . I $G(DTOUT) S RETURN=U,QT=1 Q  ; timeout - exit loop
 . I $D(Y) S RETURN=U,QT=1 Q  ; user entered a ^ to exit loop
 . Q
 . ;
 S VALMBG=1
 D RBUILD^PSOBPSSP
 Q
 ;
EDITRRRC ; Action for ER Edit Reject Resolution Required Code
 ;
 ; Input Parameter
 ; RETURN - Null if normal exit, "^" if timeout or "^" entered
 ;
 ; From EN
 ; PSOBPSDV - current division declared in EN
 ;
 ; Local Variables
 ; PASS1 - used to indicate first pass through edit loop for controlling reject prompt
 ; QT - indicates the loop processing can quit
 ;
 ; Set Full Screen mode
 D FULL^VALM1
 ;
 N QT,PASS1
 S QT=0,PASS1=1
 ;
 ; Informational message
 D RRRMSG^PSOBPSSL
 ;
 ; Loop through Reject Code edits
 F  Q:QT  D
 . ; DIE,DA,DIC,DUOUT,DTOUT,DIR,DIC,X,Y - Used by FileMan
 . N DIE,DR,DA,DUOUT,DTOUT,DIR,DIC,Y,X
 . ; Variables local to this loop
 . ; REJCODE - External Reject code - .01 field from 9002312.93
 . ; REJIEN - Reject code IEN from 9002312.93
 . ; ADD - Flag indicating a new code was selected
 . ; NEWCDPTR - IEN of the Reject Code in 9002313.92 when the user changed the Reject Code
 . ;
 . N REJCODE,REJIEN,ADD,NEWCDPTR
 . ;
 . ; Set up and call Lookup (^DIC)
 . S DIC("A")=$S(PASS1:"",1:"ANOTHER ")_"REJECT RESOLUTION REQUIRED CODE: ",PASS1=0
 . S DIC=9002313.93
 . S DIC(0)="QEAZ"
 . S DIC("S")="I '$F("".79.88.943."","".""_$P($G(^(0)),U,1)_""."")"
 . W ! D ^DIC
 . ;
 . ; Check responses to the lookup
 . I $G(DUOUT)!($G(DTOUT)) S RETURN=U,QT=1 Q  ; user entered a ^, or timed out
 . I Y'>0 S QT=1 Q  ; user entered a blank to get out
 . ;
 . S REJIEN=+Y,REJCODE=$P(Y,U,2)
 . S ADD=0
 . ;
 . ; if new code, set up new node
 . I '$D(^PS(52.86,PSOBPSDV,5,"B",REJIEN)) D
 . . ; RRRCFDA - FDA structure used by UPDATE^DIE
 . . N RRRCFDA
 . . S ADD=1
 . . ;
 . . ;Set up FDA and File the data 
 . . S RRRCFDA(52.865,"+1,"_PSOBPSDV_",",.01)=REJIEN
 . . S RRRCFDA(52.865,"+1,"_PSOBPSDV_",",.02)=0 ; Default DOLLAR THRESHOLD
 . . D UPDATE^DIE(,"RRRCFDA")
 . . Q
 . ;
 . ; Edit the transfer reject code entry
 . S DA=$O(^PS(52.86,PSOBPSDV,5,"B",REJIEN,0)) Q:'DA
 . S DA(1)=PSOBPSDV
 . S DIE="^PS(52.86,"_DA(1)_",5,"
 . S DR=".01REJECT RESOLUTION REQUIRED CODE"
 . I ADD W !!?3,"You are entering a new reject resolution required code - "_REJCODE_"."
 . E  W !!?3,"You are editing an existing reject resolution required code - "_REJCODE_"."
 . D ^DIE
 . ;
 . I '$G(DA) Q  ; user deleted it so we're done
 . I $G(DTOUT) S RETURN=U,QT=1 Q  ; timeout - exit loop
 . I $D(Y) S RETURN=U,QT=1 Q  ; user entered a ^ to exit loop
 . ;
 . ; If the user changed the reject code, check for duplicate OR 79/88/943
 . ; Get the current pointer filed by DIE and compare it to the original pointer
 . S DA=+$G(DA),NEWCDPTR=$P($G(^PS(52.86,PSOBPSDV,5,DA,0)),U,1)
 . I NEWCDPTR'=REJIEN D
 . . ; CTR - used in duplicate check. # of records with same code value
 . . ; IEN - used when checking the "B" index for duplicates using $ORDER
 . . N CTR,IEN
 . . ; NEWCDPTR - holds the new reject code after the user changes it
 . . S (CTR,IEN)=0
 . . F  S IEN=$O(^PS(52.86,PSOBPSDV,5,"B",NEWCDPTR,IEN)) Q:'IEN  S CTR=CTR+1
 . . I CTR>1 D  Q
 . . . S DR=".01////"_REJIEN D ^DIE   ; restore the code pointer
 . . . W !!?3,"You selected a duplicate reject code.  Code '"_REJCODE_"' has been restored."
 . . . S NEWCDPTR=0 ; Clear the new pointer if it is no longer valid
 . . . Q
 . . I $$GET1^DIQ(9002313.93,NEWCDPTR_",",.01)=79 D  Q
 . . . S DR=".01////"_REJIEN D ^DIE   ; restore the code pointer
 . . . W !!?3,"Code '79/RTS' is not valid here.  Code '"_REJCODE_"' has been restored."
 . . . S NEWCDPTR=0 ; Clear the new pointer if it is no longer valid
 . . . Q
 . . I $$GET1^DIQ(9002313.93,NEWCDPTR_",",.01)=88 D  Q
 . . . S DR=".01////"_REJIEN D ^DIE   ; restore the code pointer
 . . . W !!?3,"Reject code '88/DUR' is not valid here. Code '"_REJCODE_"' has been restored."
 . . . S NEWCDPTR=0 ; Clear the new pointer if it is no longer valid
 . . . Q
 . . I $$GET1^DIQ(9002313.93,NEWCDPTR_",",.01)=943 D  Q
 . . . S DR=".01////"_REJIEN D ^DIE   ; restore the code pointer
 . . . W !!?3,"Reject code '943/DUR' is not valid here. Code '"_REJCODE_"' has been restored."
 . . . S NEWCDPTR=0 ; Clear the new pointer if it is no longer valid
 . . . Q
 . . Q
 . ; NEWCDPTR will be 0 if the user tried to enter an invalid or duplicate reject code
 . Q:'NEWCDPTR
 . ;
 . ; Now edit the DOLLAR THRESHOLD parameter
 . S DA(1)=PSOBPSDV
 . S DIE="^PS(52.86,"_DA(1)_",5,"
 . S DR=".02"
 . D ^DIE
 . ; Make sure stored value is not null
 . I '$G(DTOUT),$G(^PS(52.86,PSOBPSDV,5,DA,0)) D
 . . S $P(^PS(52.86,PSOBPSDV,5,DA,0),U,2)=+$P(^PS(52.86,PSOBPSDV,5,DA,0),U,2)
 . ;
 . I $G(DTOUT) S RETURN=U,QT=1 Q  ; timeout - exit loop
 . I $D(Y) S RETURN=U,QT=1 Q  ; user entered a ^ to exit loop
 . Q
 . ;
 S VALMBG=1
 D RBUILD^PSOBPSSP
 Q
 ;

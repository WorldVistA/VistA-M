IBCNBLA2 ;DAOU/ESG - Ins Buffer, Multiple Selection ;09-SEP-2002
 ;;2.0;INTEGRATED BILLING;**184**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; Can't be called from the top
 Q
 ;
 ;
MULSEL(TMPARR,IBCNELST,GCNT) ; Multiple entry selection
 ; This procedure is responsible for receiving multiple buffer entries
 ; from the user.  It also validates and locks the selected buffer
 ; entries.  It also reports any buffer entries that could not be
 ; allocated and the reason why not.
 ;
 ; Parameters:
 ;   TMPARR - scratch global input parameter
 ; IBCNELST - output array of entries
 ;            IBCNELST(entry#) = (OK? 0/1)^(error reason)^(buffer ien)
 ;     GCNT - output; number of buffer entries the user got OK
 ;
 NEW OK,ERR,VALMY,IBSELN,IBBUFDA,IBY,TCNT
 NEW DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 KILL IBCNELST
 S (TCNT,GCNT)=0
 I $G(TMPARR)="" G MULSELX
 D EN^VALM2($G(XQORNOD(0)),"O")     ; ListMan generic selector
 I '$D(VALMY) G MULSELX
 S IBSELN=0
 F  S IBSELN=$O(VALMY(IBSELN)) Q:'IBSELN  D  S IBCNELST(IBSELN)=OK_U_ERR_U_IBBUFDA
 . S TCNT=TCNT+1
 . S OK=0,ERR="This entry is not valid or available."
 . S IBBUFDA=$P($G(^TMP(TMPARR,$J,IBSELN)),U,2,99) Q:'IBBUFDA
 . S IBY=$P($G(^IBA(355.33,IBBUFDA,0)),U,4)    ; buffer status
 . ;
 . ; make sure buffer entry is still in an entered status
 . I IBY'="E" S ERR="This entry has a status of "_$S(IBY="A":"ACCEPTED",IBY="R":"REJECTED",1:"UNKNOWN")_" and cannot be modified." Q
 . ;
 . ; attempt to lock the buffer entry
 . I '$$LOCK^IBCNBU1(IBBUFDA,0,0) S ERR="Another user is currently editing this entry." Q
 . ;
 . ; at this point this entry is OK for processing
 . S OK=1,ERR="",GCNT=GCNT+1
 . Q
 ;
 ; Exit procedure if the user was able to get all entries
 ; total requested = total allocated
 I TCNT=GCNT G MULSELX
 ;
 ; At this point, some or all of the user selected entries are not
 ; available; build and display a message.
 W !!?3,$$MSG(TCNT,GCNT)
 W !?3,"available for editing at this time:"
 S IBSELN=0
 F  S IBSELN=$O(IBCNELST(IBSELN)) Q:'IBSELN  I 'IBCNELST(IBSELN) D
 . W !?6,"Entry ",IBSELN,": ",$P(IBCNELST(IBSELN),U,2)
 . Q
 ;
 ; If the user was not able to get any entries, then kill the array
 ; and get out
 I 'GCNT KILL IBCNELST D PAUSE^VALM1 G MULSELX
 ;
 ; Ask the user if they want to continue
 W !
 S DIR(0)="Y",DIR("A")="   Do you want to continue anyway",DIR("B")="NO"
 D ^DIR K DIR
 I Y G MULSELX     ; user said Yes to continue so get out
 ;
 ; At this point the user doesn't want to continue, so we need to 
 ; unlock any buffer entries that may have been locked and then kill
 ; the array so no further processing happens
 S IBSELN=0
 F  S IBSELN=$O(IBCNELST(IBSELN)) Q:'IBSELN  D
 . I 'IBCNELST(IBSELN) Q               ; user could not get this one
 . S IBBUFDA=$P(IBCNELST(IBSELN),U,3)  ; buffer ien
 . D UNLOCK^IBCNBU1(IBBUFDA)           ; unlock it
 . Q
 KILL IBCNELST                         ; remove the array
 ;
MULSELX ;
 Q
 ;
 ;
MSG(TCNT,GCNT) ; build test message
 ; This function builds the first line of the message when not all 
 ; selected buffer entries are available.
 ; TCNT - total number selected
 ; GCNT - total number allocated to user successfully
 NEW BCNT,MSG
 S BCNT=TCNT-GCNT     ; number not available to the user
 I TCNT=1,GCNT=0 S MSG="You selected one buffer entry, but it is not" G MSGX
 I TCNT>1,GCNT=0 S MSG="You selected "_TCNT_" buffer entries, but none of them are" G MSGX
 I BCNT=1 S MSG="You selected "_TCNT_" buffer entries, but one of them is not" G MSGX
 S MSG="You selected "_TCNT_" buffer entries, but "_BCNT_" of them are not"
MSGX ;
 Q MSG
 ;

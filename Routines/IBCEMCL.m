IBCEMCL ;ALB/ESG - Multiple CSA Message Management ;20-SEP-2005
 ;;2.0;INTEGRATED BILLING;**320**;21-MAR-1994
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 Q
EN ; -- main entry point
 L +^IBM("MCS"):0 I '$T D  Q    ; option level lock
 . W !!?2,"Sorry, another user is currently using the MCS option."
 . W !?2,"Please try again later."
 . D PAUSE^VALM1
 . Q
 ;
 K ^TMP($J,"IBCEMCA"),^TMP($J,"IBCEMCL")
 D EN^VALM("IBCEMC MCS MESSAGE LIST")
 L -^IBM("MCS")                            ; option level unlock
 Q
 ;
HDR ; -- header code
 NEW Z,NUMSEL,TOT
 S NUMSEL=+$G(^TMP($J,"IBCEMCL",4))      ; number selected
 S TOT=+$O(^TMP($J,"IBCEMCL",3,""),-1)   ; total number in list
 S Z="Number of Claims Selected: "
 S Z=Z_$$FO^IBCNEUT1(NUMSEL,8)
 S Z=Z_$$FO^IBCNEUT1(" ",10)
 S Z=Z_"Total Number in this List: "
 S Z=Z_$$FO^IBCNEUT1(TOT,8)
 S VALMHDR(1)=Z
 Q
 ;
INIT ; -- init variables and list array
 NEW A,CLAIM,DATA,EDI,IB,IB0,IB361,IB364,IBCNT,IBCURBAL,IBDA,IBDATE
 NEW IBDIV,IBIFN,IBPAT,IBREV,IBSSN,IBSTSMSG,IBSVC,IBU1,INCLUDE,INS
 NEW INSTID,PAYER,PROFID,SELTXT,TXT,X
 W !!,"Compiling MCS Data ... "
 KILL ^TMP($J,"IBCEMCL")     ; List related scratch global
 S IBREV=""
 F  S IBREV=$O(^IBM(361,"ACSA","R",IBREV)) Q:IBREV=""  I IBREV<2 S IBDA=0 F  S IBDA=$O(^IBM(361,"ACSA","R",IBREV,IBDA)) Q:'IBDA  D
 . S IB361=$G(^IBM(361,IBDA,0)),IBIFN=+IB361
 . S IB0=$G(^DGCR(399,IBIFN,0))
 . ;
 . ; no cancelled claims
 . I $P(IB0,U,13)=7 D UPDEDI^IBCEM(+$P(IB361,U,11),"C") Q
 . ;
 . ; automatically review this message if the claim was last printed on
 . ; or after the MCS - 'Resubmit by Print' date
 . I $P(IB361,U,16),($P($G(^DGCR(399,IBIFN,"S")),U,14)\1)'<$P(IB361,U,16) D UPDEDI^IBCEM(+$P(IB361,U,11),"P") Q
 . ;
 . ; payer
 . S INS=+$P($G(^DGCR(399,IBIFN,"MP")),U,1)
 . I 'INS S INS=+$$CURR^IBCEF2(IBIFN)
 . I INS S PAYER=$P($G(^DIC(36,INS,0)),U,1)
 . I 'INS S PAYER="~unknown payer"
 . ;
 . ; screen for user selected payers
 . I $D(^TMP($J,"IBCEMCA","INS")) D  Q:'INCLUDE
 .. S INCLUDE=0
 .. I 'INS Q     ; don't include if the payer can't be found
 .. I $D(^TMP($J,"IBCEMCA","INS",1,INS)) S INCLUDE=1 Q
 .. I '$D(^TMP($J,"IBCEMCA","INS",2)) Q
 .. S EDI=$$UP^XLFSTR($G(^DIC(36,INS,3)))
 .. S PROFID=$P(EDI,U,2),INSTID=$P(EDI,U,4)
 .. I PROFID'="",$D(^TMP($J,"IBCEMCA","INS",2,PROFID)) S INCLUDE=1 Q
 .. I INSTID'="",$D(^TMP($J,"IBCEMCA","INS",2,INSTID)) S INCLUDE=1 Q
 .. Q
 . ;
 . ; screen for user selected divisions
 . I $D(^TMP($J,"IBCEMCA","DIV")) D  Q:'INCLUDE
 .. S INCLUDE=0
 .. S IBDIV=+$P(IB0,U,22) I 'IBDIV Q
 .. I $D(^TMP($J,"IBCEMCA","DIV",IBDIV)) S INCLUDE=1 Q
 .. Q
 . ;
 . S IBSTSMSG=$$TXT^IBCECSA1(IBDA,300)           ; status message text
 . I IBSTSMSG="" S IBSTSMSG="~no error text"
 . ;
 . ; screen for user selected error message text
 . I $D(^TMP($J,"IBCEMCA","TEXT")) D  Q:'INCLUDE
 .. S INCLUDE=0
 .. S SELTXT="" F  S SELTXT=$O(^TMP($J,"IBCEMCA","TEXT",SELTXT)) Q:SELTXT=""  I IBSTSMSG[SELTXT S INCLUDE=1 Q
 .. Q
 . ;
 . ; screen for user selected date range
 . I $D(^TMP($J,"IBCEMCA","DATE")) D  Q:'INCLUDE
 .. S INCLUDE=0,A=^TMP($J,"IBCEMCA","DATE")
 .. S IBDATE=$P(IB361,U,2)    ; date message received
 .. I ($P(A,U,1)'>IBDATE),(IBDATE'>$P(A,U,2)) S INCLUDE=1 Q
 .. Q
 . ;
 . ; patient and ssn
 . S IBPAT=$G(^DPT(+$P(IB0,U,2),0))
 . S IBSSN=$E($P(IBPAT,U,9),6,9)
 . S IBPAT=$P(IBPAT,U,1)
 . ;
 . S IBSVC=$P($G(^DGCR(399,IBIFN,"U")),U,1)  ; statement covers from
 . S IB364=$P(IB361,U,11)                    ; transmission file entry
 . S IBU1=$G(^DGCR(399,IBIFN,"U1"))
 . S IBCURBAL=$P(IBU1,U,1)-$P(IBU1,U,2)      ; current balance
 . S CLAIM=$P(IB0,U,1)                       ; external bill#
 . ;
 . S DATA=IBIFN_U_IB364_U_CLAIM_U_PAYER_U_IBPAT_U_IBSSN_U_IBSVC_U_IBCURBAL
 . S ^TMP($J,"IBCEMCL",1,$E(IBSTSMSG,1,80),IBDA)=DATA
 . Q
 ;
 I '$D(^TMP($J,"IBCEMCL",1)) D  G INITX
 . S VALMCNT=2
 . S ^TMP($J,"IBCEMCL",2,1,0)=""
 . S ^TMP($J,"IBCEMCL",2,2,0)="  No Status Message Data to Display"
 . Q
 ;
BLD ; Build the display area of the list
 ;
 W !,"Building the MCS list display ... "
 S TXT="",IBCNT=0,VALMCNT=0
 F  S TXT=$O(^TMP($J,"IBCEMCL",1,TXT)) Q:TXT=""  D
 . D SET("")
 . D SET(TXT)
 . S IBDA=0
 . F  S IBDA=$O(^TMP($J,"IBCEMCL",1,TXT,IBDA)) Q:'IBDA  D
 .. S IB=$G(^TMP($J,"IBCEMCL",1,TXT,IBDA)),IBIFN=+IB,IB364=$P(IB,U,2)
 .. S IBCNT=IBCNT+1,DATA=IBIFN_U_IBDA_U_IB364
 .. S X=$$SETFLD^VALM1($J(IBCNT,3),"","NUMBER")
 .. S X=$$SETFLD^VALM1($P(IB,U,3),X,"BILL")
 .. S X=$$SETFLD^VALM1($P(IB,U,4),X,"PAYER")
 .. S X=$$SETFLD^VALM1($P(IB,U,5),X,"PATIENT")
 .. S X=$$SETFLD^VALM1($P(IB,U,6),X,"SSN")
 .. S X=$$SETFLD^VALM1($$FMTE^XLFDT($P(IB,U,7),"2Z"),X,"SERVICE")
 .. S X=$$SETFLD^VALM1($J("$"_$FN($P(IB,U,8),"",2),10),X,"CURBAL")
 .. D SET(X,IBCNT,DATA)
 .. Q
 . Q
 ;
INITX ;
 Q
 ;
SET(X,CNT,DATA) ; Set an entry into the display array and scratch global
 ; X - visual line to display
 ; CNT - current record counter
 ; DATA - 3 piece string IBIFN^IBDA^IB364 (optional)
 I X="",'VALMCNT G SETX    ; don't start list with a blank line
 S VALMCNT=VALMCNT+1
 I '$G(CNT) S CNT=$G(IBCNT)+1
 S ^TMP($J,"IBCEMCL",2,VALMCNT,0)=X
 S ^TMP($J,"IBCEMCL",2,"IDX",VALMCNT,CNT)=""
 I $G(DATA)="" G SETX
 ;
 S ^TMP($J,"IBCEMCL",3,CNT)=DATA_U_VALMCNT
 ;
 ; When building the list and the ^TMP($J,"IBCEMCA") area is defined,
 ; then automatically pre-select all entries in the list.
 I $D(^TMP($J,"IBCEMCA")) D MARK(+$P(DATA,U,2),+DATA,VALMCNT,CNT)
SETX ;
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 D UNLOCK
 KILL ^TMP($J,"IBCEMCL"),^TMP($J,"IBCEMCA")
 Q
 ;
UNLOCK ; unlock any entries that may still be selected
 N IBDA S IBDA=0
 F  S IBDA=$O(^TMP($J,"IBCEMCL",4,1,IBDA)) Q:'IBDA  L -^IBM(361,IBDA)
UNLOCKX ;
 Q
 ;
MARK(IBDA,IBIFN,VALMCNT,INDEX,RESULT) ; Select/De-select Entry in List.
 ; This procedure toggles the selection of a status message either
 ; ON or OFF.  It also adds or removes the "*" to the list display.
 ; If a selection can't be locked, then it will not be selected.
 ; VALMHDR is killed so ListManager will invoke the header code.
 ;
 ; RESULT is returned if passed by reference
 ;   "D" message was de-selected and unlocked
 ;   "S" message was selected and locked
 ;   "L" message could not be locked nor selected
 ;
 I $D(^TMP($J,"IBCEMCL",4,1,IBDA)) D  G MARKX   ; already selected
 . ;
 . ; de-select action
 . KILL ^TMP($J,"IBCEMCL",4,1,IBDA)
 . KILL ^TMP($J,"IBCEMCL",4,2,IBIFN,IBDA)
 . S ^TMP($J,"IBCEMCL",4)=$G(^TMP($J,"IBCEMCL",4))-1
 . S $E(^TMP($J,"IBCEMCL",2,VALMCNT,0),6)=" "
 . KILL VALMHDR
 . L -^IBM(361,IBDA)    ; unlock
 . S RESULT="D"
 . Q
 ;
 ; lock attempt prior to selection
 L +^IBM(361,IBDA):0 I '$T D  G MARKX
 . S RESULT="L"
 . Q
 ;
 ; select action
 S ^TMP($J,"IBCEMCL",4,1,IBDA)=IBIFN_U_VALMCNT_U_INDEX
 S ^TMP($J,"IBCEMCL",4,2,IBIFN,IBDA)=""
 S ^TMP($J,"IBCEMCL",4)=$G(^TMP($J,"IBCEMCL",4))+1
 S $E(^TMP($J,"IBCEMCL",2,VALMCNT,0),6)="*"
 KILL VALMHDR
 S RESULT="S"
MARKX ;
 Q
 ;

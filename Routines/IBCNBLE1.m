IBCNBLE1 ;DAOU/ESG - Ins Buffer, Expand Entry, con't ;25-JUN-2002
 ;;2.0;INTEGRATED BILLING;**184,271,416**;21-MAR-94;Build 58
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; Can't be called from the top
 Q
 ;
BLD ; Continuation of Expand Entry list build procedure
 ; --- Called by IBCNBLE
 ;
 NEW ERR,MSG,IBL,IBY,IBLINE,IBER,IBLN,EDITED,ORIGSYME,ORIGSYMI,EEUPDATE
 NEW ORIGSYMS
 ;
 ; save the external and internal IIV status values
 S ORIGSYMS=$$SYMBOL^IBCNBLL(IBBUFDA)
 S ORIGSYME=$$GET1^DIQ(355.33,IBBUFDA,.12,"E")
 S ORIGSYMI=$P(IB0,U,12)
 ;
 ; Determine if Expand Entry is allowed to update the IIV Status
 S EEUPDATE=1    ; default Expand Entry update flag to true
 I ORIGSYMI,'$P($G(^IBE(365.15,ORIGSYMI,0)),U,3) S EEUPDATE=0
 ;
 ; Do not update the IIV status if manually verified
 I ORIGSYMS="*" S EEUPDATE=0
 ;
 ; If the current IIV Status allows updates by Expand Entry, then
 ; invoke the function that trys to find a valid payer
 I EEUPDATE D
 . S ERR=$$INSERROR^IBCNEUT3("B",IBBUFDA,1,.MSG)
 . ; If no errors, then remove the IIV Status
 . I 'ERR S ERR=$$SIDERR(IBBUFDA,$P(ERR,U,2))
 . I 'ERR D CLEAR^IBCNEUT4(IBBUFDA,.EDITED)
 . ; If errors found, then update with the new IIV Status
 . I ERR D BUFF^IBCNEUT2(IBBUFDA,$P(ERR,U,1)) S EDITED=1
 . ; refresh the IB0 variable for the possible symbol change
 . S $P(IB0,U,12)=$P($G(^IBA(355.33,IBBUFDA,0)),U,12)
 . Q
 ;
 ; Possibly display information if the OVERRIDE FRESHNESS FLAG is on
 I $P(IB0,U,13) D
 . S IBL="User Requested Inquiry?: ",IBY="YES"
 . S IBLINE=$$SETL^IBCNBLE("",IBY,IBL,18,3)
 . D SET^IBCNBLE(IBLINE) S IBLINE=""
 . Q
 ;
 ; Display the Current Status line
 S IBL="Current eIV Status: "
 S IBY=$$GET1^DIQ(355.33,IBBUFDA,.12,"E")
 I IBY="",$$SYMBOL^IBCNBLL(IBBUFDA)'="*" S IBY="No problems identified, Awaiting electronic processing"
 I $$SYMBOL^IBCNBLL(IBBUFDA)="*" S IBY="Manually verified, No eIV activity at this time"
 S IBLINE=$$SETL^IBCNBLE("",IBY,IBL,18,80)
 D SET^IBCNBLE(IBLINE) S IBLINE=""
 ;
 ; Display any text returned by the payer function
 F IBER=1:1:$G(MSG) D SET^IBCNBLE(" ") F IBLN=1:1:$P($G(MSG(IBER)),U,2) D SET^IBCNBLE("  "_$G(MSG(IBER,IBLN)))
 ;
 ; Display the current IIV Status generic description
 D SYMTXT($P(IB0,U,12),1)
 D SYMTXT($P(IB0,U,12),2)
 ;
 ; If the IIV Status ien changed from what it once was, then display the
 ; Prior Status line
 I ORIGSYMI'=$P(IB0,U,12) D
 . I $P(IB0,U,12) D SET^IBCNBLE(" ")
 . S IBL="Prior Status: "
 . S IBY=ORIGSYME
 . I IBY="",ORIGSYMS'="*" S IBY="No problems identified, Awaiting electronic processing"
 . I ORIGSYMS="*" S IBY="Manually verified, No eIV activity at this time"
 . S IBLINE=$$SETL^IBCNBLE("",IBY,IBL,18,80)
 . D SET^IBCNBLE(IBLINE) S IBLINE=""
 . D SYMTXT(ORIGSYMI,1)
 . Q
 ;
 ; Display any existing EC errors
 D ECERR
 ;D SET^IBCNBLE(" ")
 ;
 ; If the IIV Status was modified then refresh the visual display
 I $G(EDITED) D UPDLN^IBCNBLL(IBBUFDA,"EDITED")
BLDX ;
 Q
 ;
SYMTXT(IEN,TYPE) ; Display the text from the IIV symbol file for this entry
 ; TYPE=1 - Display Description from IIV Status Table file
 ; TYPE=2 - Display Corrective Action from IIV Status Table file
 NEW IBJ
 I '$G(IEN) G SYMX
 I '$P($G(^IBE(365.15,IEN,TYPE,0)),U,4) G SYMX
 D SET^IBCNBLE(" ")
 S IBJ=0
 F  S IBJ=$O(^IBE(365.15,IEN,TYPE,IBJ)) Q:'IBJ  D SET^IBCNBLE("  "_$G(^IBE(365.15,IEN,TYPE,IBJ,0)))
SYMX ;
 Q
 ;
ECERR ; Display the Eligibility Communicator Error data from the
 ; response file if it exists
 ;
 NEW RESP,RESPDATA,ERRTXT,IBY,IBLINE,ERRDATA,FUTDT,TQIEN,IBERR,IBCT
 S RESP=$O(^IBCN(365,"AF",IBBUFDA,""),-1)
 I 'RESP G ECERRX
 S RESPDATA=$G(^IBCN(365,RESP,1))
 S ERRTXT=$P($G(^IBCN(365,RESP,4)),U,1)
 S TQIEN=+$P($G(^IBCN(365,RESP,0)),U,5)    ; Trans Queue file ien
 S FUTDT=$P($G(^IBCN(365.1,TQIEN,0)),U,9)  ; Future date to transmit
 I '$P(RESPDATA,U,14),'$P(RESPDATA,U,15),ERRTXT="",'FUTDT G ECERRX
 ;
 ; At this point, we know there's something to get displayed
 ;
 ; Display section header
 D SET^IBCNBLE(" ")
 S IBY=$J("",19)_"Eligibility Communicator Error Information"
 D SET^IBCNBLE(IBY,"B") S IBLINE=""
 ;
 ; Display Error Condition data - field# 1.14
 I $P(RESPDATA,U,14) D
 . S ERRDATA=$G(^IBE(365.017,$P(RESPDATA,U,14),0))
 . K IBERR
 . S IBERR(1)=$P(ERRDATA,U,2)_" (Error Condition '"_$P(ERRDATA,U,1)_"')"
 . D TXT^IBCNEUT7("IBERR")
 . F IBCT=1:1:$O(IBERR(""),-1) D SET^IBCNBLE(IBERR(IBCT))
 . Q
 ;
 ; Display Error Action data - field# 1.15
 I $P(RESPDATA,U,15) D
 . S ERRDATA=$G(^IBE(365.018,$P(RESPDATA,U,15),0))
 . K IBERR
 . S IBERR(1)=$P(ERRDATA,U,2)_" (Error Action '"_$P(ERRDATA,U,1)_"')"
 . D TXT^IBCNEUT7("IBERR")
 . F IBCT=1:1:$O(IBERR(""),-1) D SET^IBCNBLE(IBERR(IBCT))
 . Q
 ;
 ; Display Error Text data - field# 4.01
 I ERRTXT'="" D SET^IBCNBLE(ERRTXT)
 ;
 ; Display Date of Future Transmission - field# .09 in file 365.1
 I FUTDT D
 . S FUTDT=$$FMTE^XLFDT(FUTDT,"5Z")
 . D SET^IBCNBLE(" ")
 . S IBLINE="     Date of Future Transmission:  "_FUTDT
 . D SET^IBCNBLE(IBLINE) S IBLINE=""
 . Q
ECERRX ;
 Q
 ;
SIDERR(BUF,PIEN) ;
 ; If Subscriber ID is required and SSN cannot be substituted
 ; and buffer does not have a sub id -> return error
 ; BUF = buffer IEN
 ; PIEN = payer IEN
 ;
 N ERR,SID,APPIEN,SIDSTR,SIDREQ,SIDSSN
 S ERR=""
 S SID=$P($G(^IBA(355.33,BUF,60)),U,4)
 I SID]"" G SIDX ; Subscriber id is populated, further checking is moot
 S APPIEN=$$PYRAPP^IBCNEUT5("IIV",PIEN)
 S SIDSTR=$G(^IBE(365.12,PIEN,1,APPIEN,0))
 S SIDREQ=$P(SIDSTR,U,8) I 'SIDREQ G SIDX ; if sub id is not req'd - ok
 S SIDSSN=$P(SIDSTR,U,9)
 I 'SIDSSN S ERR=18 ; if ssn cannot be used -> B15 status (IEN = 18)
SIDX Q ERR
 ;

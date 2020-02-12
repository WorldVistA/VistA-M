IBCEST ;ALB/TMP - 837 EDI STATUS MESSAGE PROCESSING ;17-APR-96
 ;;2.0;INTEGRATED BILLING;**137,189,197,135,283,320,368,397,407,577,592,623**;21-MAR-94;Build 70
 ;;Per VA Directive 6402, this routine should not be modified.
 ; IA 4043 for call to AUDITX^PRCAUDT
 Q
 ;
UPD361(IBTDA) ; Update IB BILL STATUS MESSAGES file
 ; IBTDA = ien of return message in file 364.2
 ;
 N IB,IB0,IBSEQ,IB00,IBBILL,IBBTCH,IBMNUM,IBDATE,IBTYP
 ;
 I '$$LOCK^IBCEM(IBTDA) G UPDQ ;Lock message in file 364.2
 ;
 S IB0=$G(^IBA(364.2,IBTDA,0))
 S IBMNUM=$P(IB0,U) ; Message number
 S IB00=$G(^IBA(364,+$P(IB0,U,5),0)) ; Transmit bill entry
 S IBBILL=+IB00 ; Actual bill ien in file 399
 S IBBTCH=$P(IB0,U,4) ; Batch #
 ;
 ; Auto-audit bills based on status code on '10' record of status msg
 ; flat file
 I IBBILL,$P($T(PRCAUDT+1^PRCAUDT),"**",2)[",173" D
 . N Z,Z0,Z1,OK
 . Q:+$$STA^PRCAFN(IBBILL)'=104
 . S (Z,OK)=0
 . F  S Z=$O(^IBA(364.2,IBTDA,2,Z)) Q:'Z  S Z0=$P($G(^(Z,0)),"##RAW DATA: ",2) I +Z0=10 S Z0=$P(Z0,U,5) D  Q:OK
 .. ; Strip leading spaces
 .. S Z0=$$TRIM^XLFSTR(Z0)
 .. Q:Z0=""
 .. I $$SCODE^IBCEST1(Z0),$P($G(^DGCR(399.3,+$P($G(^DGCR(399,IBBILL,0)),U,7),0)),U,11) D AUDITX^PRCAUDT(IBBILL) S OK=1 ; IA 4043
 ;
 I $S(IBMNUM="":1,1:'IBBILL&(IBBTCH="")) D DELMSG^IBCESRV2(IBTDA) G UPDQ
 ;
 ; Individual bill   ; KDM US129 IB*2*577 rework Individual vs. Batch to Correct Storage of Payer ID
 I IBBILL D UPDTBILL() G UPDQ
 ;
 ; Batch - update each bill separately
 S IBBILL=""
 F  S IBBILL=$O(^IBA(364,"ABABI",+IBBTCH,IBBILL)) Q:'IBBILL  D
 . Q:$D(^TMP("IBCONF",$J,IBBILL))  ;Bill was rejected
 . S IB=$O(^IBA(364,"ABABI",+IBBTCH,IBBILL,0))
 . Q:'IB
 . D UPDTBILL()     ;KDM US129 IB*2*577 Correct Storage of PAYER ID
 ;
 Q
 ;
UPDTBILL()     ;KDM US129 IB*2*577 New section to Correct Storage of PAYER ID
 N IBA1,IBMSG0,IBPID
 S IBPID="",IBA1=0
 ;
 F  S IBA1=$O(^IBA(364.2,IBTDA,2,IBA1)) Q:'IBA1  D  Q:IBPID]""
 . S IBMSG0=$P($G(^(IBA1,0)),"##RAW DATA: ",2)
 . I +IBMSG0=277,$P(IBMSG0,U,5)="N" S IBPID=$P(IBMSG0,U,11)
 ;
 S IBSEQ=$P(IB00,U,8) S:IBSEQ="" IBSEQ="P"
 D STORE(IB0,IBBTCH,IBMNUM,IBTDA,IBBILL,IBSEQ,IBPID,1)
 Q
 ;
STORE(IB0,IBBTCH,IBMNUM,IBTDA,IBBILL,IBSEQ,IBPID,IB1) ;
 ;
 ; IB0 = 0-node of message in file 364.2
 ; IBBTCH = ien of batch in file 364.1
 ; IBMNUM = actual message number
 ; IBTDA = ien of message in file 364.2
 ; IBBILL = ien of bill in 399
 ; IBSEQ = P/S/T/ for COB sequence related to message
 ; IBPID = the payer id returned from clearinghouse for the claim
 ; IB1 = flag that says if the message was for a single bill or a batch.
 ;       Batch statuses have an additional standard text entry.
 ;       1 = single bill 0 = batch
 ; 
 N DA,DIK,DIE,DIC,X,Y,DR,DO,DD,DLAYGO,Z,Z0,Z1,Z2,Z3,IBT,IBDUP,IBFLDS,IBY,IBAUTO,IBLN
 ;
 S X=IBBILL,IBDUP=0
 ;
 S IBFLDS=".02////"_$P(IB0,U,3)
 S IBFLDS=IBFLDS_";.03////"_$S($$EXTERNAL^DILFD(364.2,.02,"U",$P(IB0,U,2))["REJ":"R",1:"I")_";.05////"_IBBTCH_";.06////"_IBMNUM_";.04////"_+$P(IB0,U,8)_";.07////"_IBSEQ_$S($P(IB0,U,5):";.11////"_$P(IB0,U,5),1:"")
 S IBFLDS=IBFLDS_";.12////"_$P(IB0,U,10)_";.09////0"
 S IBFLDS=IBFLDS_";.15////"_$$CHKSUM^IBCEST1("^IBA(364.2,"_IBTDA_",2)")
 I IBPID'="" D
 . ;JWS;IB*2.0*592;Dental Form 7
 . S IBPID("TYPE")=$S($$FT^IBCEF(IBBILL)=2:"P",$$FT^IBCEF(IBBILL)=7:"D",1:"I")
 . D UPDINS(.IBPID,$$POLICY^IBCEF(IBBILL,1,$TR(IBSEQ,"PST","123")),IBBILL,IBTDA)      ;KDM US129 IB*2*577
 ;
 I IBDUP D  I $D(Y) G UPDQ
 . ; Stuff fields into existing entry
 . ; (may be needed for reprocessing of aborted updates)
 . S DIE="^IBM(361,",DA=IBDUP,DR=IBFLDS_";1///@"
 . D ^DIE
 . I $D(Y) S IBY=-1 Q  ;Update not successful
 . S IBY=IBDUP
 ;
 K IBT
 I 'IBDUP D  ; Create new entry and stuff fields
 . S DIC(0)="L",DIC="^IBM(361,",DLAYGO=361
 . S DIC("DR")=IBFLDS
 . D FILE^DICN
 . K DO,DD,DLAYGO,DIC
 . S IBY=+Y
 . Q:IBY'>0
 . ;
 . ; IB*2*320 - Check for duplicate status message
 . NEW IBNEW,IBOLD,PCE,Z,DIK,DA
 . S IBNEW=""
 . F PCE=3,4,5,7,8,11,15 S IBNEW=IBNEW_$P($G(^IBM(361,IBY,0)),U,PCE)_U
 . S Z=0
 . F  S Z=$O(^IBM(361,"B",IBBILL,Z)) Q:'Z  I Z'=IBY D  Q:IBY'>0
 .. S IBOLD=""
 .. F PCE=3,4,5,7,8,11,15 S IBOLD=IBOLD_$P($G(^IBM(361,Z,0)),U,PCE)_U
 .. I IBNEW'=IBOLD Q   ; no duplicate so get the next one
 .. S DIK="^IBM(361,",DA=IBY,IBY=-1 D ^DIK D DELMSG^IBCESRV2(IBTDA)
 .. Q
 . Q
 ;
 I IBY>0 D  ;Move text over
 . K IBT
 . ;
 . D BLDMSG(IB1,IBTDA,.IBT,.IBAUTO)
 . ;
 . ; IB*2*368 - ymg - 2Q,RE,RP messages will be filed as informational
 . ; Z0 is the flag for 2Q code
 . ; Z1 is the flag for RE code
 . ; Z2 is the flag for RP code
 . ; Z3 is the flag for autofiling the message
 . I $P($G(^IBM(361,+IBY,0)),U,3)="R" D
 .. S Z="",(Z0,Z1,Z2,Z3)=0 F  S Z=$O(IBT(Z)) Q:Z=""!(Z3=1)  D
 ... S IBLN=$$UP^XLFSTR($G(IBT(Z)))
 ... I (Z0!Z1!Z2)=0 D
 .... S:IBLN?.E1"CODE:".P1"2Q".E Z0=1
 .... S:IBLN?.E1"CODE:".P1"RE".E Z1=1
 .... S:IBLN?.E1"CODE:".P1"RP".E Z2=1
 ... I Z0=1 S:IBLN?.P1"CLAIM".P1"REJECTED".P1"BY".P1"CLEARINGHOUSE".E Z3=1
 ... I Z1=1 S:IBLN?.P1"ELECTRONIC".P1"CLAIM".P1"REJECTED".P1"BY".P1"EMDEON".E Z3=1
 ... I Z2=1 S:IBLN?.P1"PAPER".P1"CLAIM".P1"REJECTED".P1"BY".P1"EMDEON".E Z3=1
 .. I Z3=1 S IBAUTO=1,DIE=361,DA=+IBY,DR=".03////I" D ^DIE
 .. Q
 . ;
 . ; if info msg, ck for no review needed based on first line of text
 . I $G(IBAUTO),$P($G(^IBM(361,+IBY,0)),U,3)="I" D
 .. S DIE="^IBM(361,",DR=".09////2;.14////1;.1////F",DA=+IBY D ^DIE
 .. I IB1,$P($G(^IBM(361,+IBY,0)),U,11) S Z="",Z0=0 F  S Z=$O(IBT(Z)) Q:Z=""!(Z0=1)  D
 ... S Z0=$$PRINTUPD^IBCEU0($$UP^XLFSTR($G(IBT(Z))),$P($G(^IBM(361,+IBY,0)),U,11))
 . ;
 . D MSGLNSZ(.IBT) ; Convert Message Lines in IBT to be no longer than 70 chars
 . D WP^DIE(361,+IBY_",",1,"A","IBT")    ; file message text
 . ;
 . ; Delete message after it successfully updates the database.
 . D DELMSG^IBCESRV2(IBTDA)
 . Q
 ;
UPDQ L -^IBA(364.2,IBTDA,0)
 Q
 ;
BLDMSG(IB1,IBTDA,IBT,IBAUTO) ; Builds message text
 ; IB1 = flag for batch message
 ; IBTDA = ien of entry in file 364.2
 ; IBT = array returned with message text
 ; IBAUTO = if passed by reference, returns 1 if text indicates review
 ;          not needed
 N IBDATA,IBCK,IBZ,IBZ0,IBZ1,Z
 S (IBZ,IBZ0,IBDATA,IBAUTO,IBCK)=0
 I 'IB1 S IBT(1)="Status message received for batch "_$P($G(^IBA(364.1,IBBTCH,0)),U)_" dated "_$$FMTE^XLFDT($P($G(^IBA(364.2,IBTDA,0)),U,10),2),IBZ0=1
 ; Don't move the raw data over, just move the text of the message
 F  S IBZ=$O(^IBA(364.2,IBTDA,2,IBZ)) Q:'IBZ  S IBZ1=$G(^(IBZ,0)) S IBDATA=($E(IBZ1,1,2)="##") Q:IBDATA  S IBZ0=IBZ0+1,IBT(IBZ0)=IBZ1 I 'IBCK S Z=$$CKREVU^IBCEM4(IBZ1,,,.IBCK),IBAUTO=$S(IBCK:0,Z:1,1:IBAUTO)
 Q
 ;
UPDINS(IBPID,IBINS,IBIFN,IBTDA)     ;KDM US129 IB*2*577
 ; Update the insurance id or the bill printed at
 ;    the EDI contractor's print shop and mailed to the ins co.
 ; IBPID = the id returned from the EDI contractor for the ins co
 ;      ("TYPE") = P if professional id or I if institutional id or D if Dental
 ; IBINS = the ien of the insurance co it was sent to (file 36)
 ; IBIFN = the ien of the claim (file 399)
 ; IBTDA = ien of entry in file 364.2     ;KDM US129 IB*2*577
 ;
 ;N IBID,IBIDFLD,IBPRT,IBLOOK,DA,DR,DIE,X,Y,Z,UPD     ;KDM US129 IB*2*577
 N DA,DIE,DONE,DR,HAVONE,IBHOLD,IBID,IBIDFLD,IBIDQ,IBPRT,IBLOOK,IBPID69,IBQUAL,IBSID,II,UPDATE,X,Y,Z   ; vd US3994 - IB*2*623
 ;
 Q:'$G(IBINS)!($G(IBPID)="")
 ;
 ; Strip spaces off the end of data
 S IBLOOK=""
 ;I $L(IBPID) F Z=$L(IBPID):-1:1 I $E(IBPID,Z)'=" " S IBLOOK=$E(IBPID,1,Z) Q
 ;
 ;S IBPRT=($E(IBLOOK,2,5)="PRNT")
 I $L(IBPID) F Z=$L(IBPID):-1:1 I $E(IBPID,Z)'=" " S IBHOLD=$E(IBPID,1,Z) Q   ; vd US3994 - IB*2*623
 ;
 S IBPRT=($E(IBHOLD,2,5)="PRNT")  ; vd US3994 - IB*2*623
 I IBPRT D  ; Set printed via EDI field on bill
 . S DA=IBIFN,DIE="^DGCR(399,",DR="26////1" D ^DIE
 ;
 ; KDM US129 IB*2*577  correct payer ID storage
 ;S IBLOOK=$E($S('IBPRT:$P(IBLOOK,"PAYID=",2),1:""),1,5)
 ;Q:IBLOOK=""!($E(IBLOOK,2,5)="PRNT")
 I IBPRT Q
 I IBHOLD'["PAYID=",IBHOLD'["COBID=" Q     ; vd US3994 IB*2*623
 S IBLOOK=$E($P(IBHOLD,"ID=",2),1,5)     ; vd US3994 IB*2*623
 Q:IBLOOK=""
 ;
 ;/vd IB*2*623 (US3994) - Beginning
 S IBDATE=DT,IBTYP=$G(IBPID("TYPE")),IBPID69=$E(IBPID,6,9),UPDATE=1
 S (IBID,IBIDQ)=""
 I "^I^P^"[(U_IBTYP_U),IBHOLD["COBID=",IBPID69'="0000" D   ; Update the CLM-OFC-IDs for I & P only with valid Secondary Payer IDs.
 . S IBQUAL(1)=$S(IBTYP="I":6.01,1:6.05),IBQUAL(2)=$S(IBTYP="I":6.03,1:6.07)  ; Get appropriate Qualifier field numbers.
 . S IBSID(1)=$S(IBTYP="I":6.02,1:6.06),IBSID(2)=$S(IBTYP="I":6.04,1:6.08)   ; Get appropriate Current Secondary Payer IDs.
 . S (DONE,HAVONE)=0
 . F II=1,2 D  Q:((+DONE)!(+HAVONE))   ; PROCESS THRU BOTH SECONDARY PAYER IDS OR UNTIL WE PERFORMED AN UPDATE.
 . . S IBIDQ=$$GET1^DIQ(36,+IBINS,IBQUAL(II),"I")  ; Get the current qualifier value
 . . S IBID=$$GET1^DIQ(36,+IBINS,IBSID(II),"I")    ; Get the current id value
 . . I IBIDQ="FY" S HAVONE=1 Q   ; Already have a Claim Office ID.
 . . I IBIDQ="" D  Q      ; Current value doesn't exists.okay to update.
 . . . S DIE="^DIC(36,",DR=IBSID(II)_"////"_IBPID69_";"_IBQUAL(II)_"////FY",DA=IBINS D ^DIE  ; Update the CLM-OFC-ID and Qualifier fields.
 . . . D UPDLOG(1,IBDATE,IBINS,IBPID69,IBTYP_"2",IBID) ; Log the CLM-OFC-ID "UPDATE".
 . . . S DONE=1      ; Success. Updated one so we can quit out.
 . . . Q
 . ; Should only get to the following line if no update was accomplished because there was no available room to add an "FY".
 . I '+DONE D UPDLOG(0,IBDATE,IBINS,IBPID69,IBTYP_"2",$S(+HAVONE:IBID,1:"*N/A FULL")) ; Log the CLM-OFC-ID "ATTEMPT"
 . Q
 ;/vd IB*2*623 (US3994) - End
 ;
 S IBIDFLD="3.0"_$S($G(IBPID("TYPE"))="I":4,1:2)
 ;JWS;IB*2.0*592;Dental
 I $G(IBPID("TYPE"))="D" S IBIDFLD=3.15
 S IBID=$P($G(^DIC(36,+IBINS,3)),U,IBIDFLD*100#100)
 Q:IBID=IBLOOK
 ;/vd IB*2*623 (US3994) Moved the following line up prior to some new lines of code.
 ; S IBDATE=DT,IBTYP=$G(IBPID("TYPE"))     ;KDM  US129 IB*2*577
 I IBID="" D  G UPDINSQ ; Update insurance co electronic id # if blank
 . S DIE="^DIC(36,",DR=IBIDFLD_"////"_IBLOOK,DA=IBINS D ^DIE
 . D UPDLOG(1,IBDATE,IBINS,IBLOOK,IBTYP,IBID)     ;KDM US129 IB*2*577
 I IBID'="",IBLOOK'="" D  ; Bulletin that the id on file and id returned
 . ; are different
 . N XMTO,XMDUZ,XMBODY,IBXM,XMSUBJ,XMZ
 . S XMTO("I:G.IB EDI")=""
 . S XMDUZ="",XMBODY="IBXM",XMSUBJ="PAYER ID RETURNED IS DIFFERENT THAN PAYER ID ON FILE"
 . S IBXM(1)="BILL #     : "_$P($G(^DGCR(399,IBIFN,0)),U)
 . S IBXM(2)="PAYER      : "_$P($G(^DIC(36,+IBINS,0)),U)
 . ;JWS;IB*2.0*592;Dental
 . S IBXM(3)="BILL TYPE  : "_$S($G(IBPID("TYPE"))="I":"INSTITUTIONAL",$G(IBPID("TYPE"))="D":"DENTAL",1:"PROFESSIONAL")
 . S IBXM(4)="ID ON FILE : "_IBID
 . S IBXM(5)="ID RETURNED: "_IBLOOK
 . S IBXM(6)=" ",IBXM(7)="   Please determine which id number is correct and correct the id in the",IBXM(8)="insurance file for this payer, if needed"
 . D SENDMSG^XMXAPI(XMDUZ,XMSUBJ,XMBODY,.XMTO,,.XMZ)
 . D UPDLOG(0,IBDATE,IBINS,IBLOOK,IBTYP,IBID)     ;KDM US129, US976 IB*2*577
 ;
UPDINSQ Q
 ;
UPDLOG(UPD,IBDATE,IBINS,IBLOOK,IBTYP,IBID)    ;KDM US129, US976 IB*2*577 New section for New Payer Report 
 ; store flds for reporting purposes when updating or attempting to update Payer information (US129)
 ; ^DIC(36 -17.0 277EDI ID Number
 ;          17.01 277EDI ID Number
 ;          17.02 277Date EDI ID Number
 ;          17.03 277EDI Type (P)ROF or (I)nst or (D)ental
 ;          17.04 277EDI ID NUMBER ON FILE ;if blank it was an update otherwise it was an attempted update. 
 ;
 Q:(($D(^DIC(36,"AEDIX",IBDATE,IBINS,IBLOOK,IBTYP)))&(UPD=0))     ;store only one attempt a day
 N ERROR,IBFDA,LEV
 S LEV="+2,"_IBINS_","
 S IBFDA(36.017,LEV,.01)=IBLOOK     ;New Value from 277STAT
 S IBFDA(36.017,LEV,.02)=IBDATE     ;Date transaction is processed
 S IBFDA(36.017,LEV,.03)=IBTYP      ;"P" or "I" for "EDI-PayerID, or "P2" or "I2" for CLM-OFC-ID
 S IBFDA(36.017,LEV,.04)=$G(IBID)   ;Value already on file- if blank it was an update, otherwise attempted update
 D UPDATE^DIE("","IBFDA","","ERROR")
 Q
 ;
MSGLNSZ(MSG) ; Change Input Message Lines to be no more than 70 characters long each
 ;
 ; Input/Output:   MSG  - array of Input Message Lines; this is also the Output Message
 ; which is an array of Converted Message Lines (with lines no more than 70 chars each)
 ;
 N LN,XARY,XARYLN,CNT,OUTMSG,TMPMSG,LDNGSP,LDNGSPN
 S LN="",CNT=0 F  S LN=$O(MSG(LN)) Q:LN=""  D  ;
 . ; Find any leading spaces in original message line, 
 . ; to be used if line got split below
 . S TMPMSG=$$TRIM^XLFSTR(MSG(LN),"L"," ")  ;Trim Leading Spaces
 . S LDNGSP=$P(MSG(LN),TMPMSG,1)  ;get leading spaces if any
 . S LDNGSPN=$L(LDNGSP) S:LDNGSPN>30 LDNGSP=$E(LDNGSP,1,30) ;make sure there are no more than 30 leading spaces 
 . ; Converts a single line to multiple lines with a maximum width of 70 each
 . ; If line is 70 chars or less, this call returns the exact line
 . K XARY D FSTRNG^IBJU1(TMPMSG,70-LDNGSPN,.XARY)
 . ; Scan lines and merge them into the final output array (OUTMSG)
 . ; On lines 2 and higher, add Leading Spaces found above, if any.
 . S XARYLN="" F  S XARYLN=$O(XARY(XARYLN)) Q:XARYLN=""  S CNT=CNT+1,OUTMSG(CNT)=LDNGSP_XARY(XARYLN)
 ;
 ; Move the final Message Lines (OUTMSG) into MSG array to be returned
 K MSG M MSG=OUTMSG
 Q
 ;

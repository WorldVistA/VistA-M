IBECEA4 ;ALB/CPM - Cancel/Edit/Add... Cancel a Charge ;11-MAR-93
 ;;2.0;INTEGRATED BILLING;**27,52,150,240,663,671,669,678,682**;21-MAR-94;Build 15
 ;;Per VHA Directive 6402, this routine should not be modified.
 ;
ONE ; Cancel a single charge.
 D:'+$G(IBAPI) HDR^IBECEAU("C A N C E L")
 ;
 ; - perform up-front edits
 D CED^IBECEAU4(IBN) G:IBY<0 ONEQ
 I IBXA=6!(IBXA=7) D  G ONEQ:$G(IBCC),REAS
 .I IBCANTR!($P(IBND,"^",5)=10) S IBCC=1 W !,"This transaction has already been cancelled.",!
 I IBCANTR!($P(IBND,"^",5)=10) W !,$S(IBH:"Please note that this cancellation action has not yet been passed to AR.",1:"This transaction has already been cancelled."),! G ONEQ:'IBH,REAS
 I 'IBH,IBIL="" S IBY="-1^IB024" G ONEQ
 ;
REAS ; - ask for the cancellation reason
 N IBSVIEN  ; IB*2.0*682
 ;
 D REAS^IBECEAU2("C")
 ;IB*2.0*678 - Correct error or no reason functionality
 I IBCRES<0 D  G ONEQ
 . S IBY=-1
 ;
 ;IB*2.0*669
 ; Temporary inactive flag check until IB*2.0*653 is released.  Then need to move the inactive check to
 ; the DIC("S") variable in REAS^IBECEAU2.
 ; cHECK INACTIVE FLAG
 ; If Cancel reason is inactive, the post message to user and try again.
 I $$GET1^DIQ(350.3,IBCRES_",",.06,"I") D  G:IBY<0 REAS
 . S IBY=-1
 . W !!,"The selected cancellation reason is inactive."
 . W !,"Please select another cancellation reason.",!!
 ;
 ;Check to see if it is an Urgent Care
 I ('$$GET1^DIQ(350.3,IBCRES_",",.04,"I")),($$GET1^DIQ(350.1,$P(IBND,U,3)_",",.01,"E")["URGENT CARE") D  G:IBY<0 ONEQ
 . S IBY=-1
 . W !!,"This is an Urgent Care Copayment. Please use an Urgent Care cancellation reason.",!,"This transaction cannot be completed.",!
 ;
 ; - okay to proceed?
 D PROC^IBECEAU4("cancel") G:IBY<0 ONEQ
 ;
 ;If Copay being cancelled is CC URGENT CARE check to see if it can be cancelled and do the processing.
 I $$GET1^DIQ(350.1,$P(IBND,U,3)_",",.01,"E")["URGENT CARE" D UCVSTDB G:IBY<0 ONEQ
 ;
 ; - handle CHAMPVA/TRICARE charges
 I IBXA=6!(IBXA=7) D CANC^IBECEAU4(IBN,IBCRES,1) G ONEQ
 ;
 ; - handle cancellation transactions
 I IBCANTR D  G ONEQ
 .I IBN=IBPARNT D UPSTAT^IBECEAU4(IBN,1) Q
 .I 'IBIL S IBIL=$P($G(^IB(IBPARNT,0)),"^",11) I 'IBIL W !!,"There is no bill number associated with this charge.",!,"The charge cannot be cancelled." Q
 .S DIE="^IB(",DA=IBN,DR=".1////"_IBCRES_";.11////"_IBIL D ^DIE,PASS K DIE,DA,DR
 ;
 ; - update 354.71 and 354.7 (cap info)
 I $P(IBND,"^",19) S IBAMC=$$CANCEL^IBARXMN(DFN,$P(IBND,"^",19),.IBY) G:IBY<1 ONEQ I IBAMC D FOUND^IBARXMA(.IBY,IBAMC)
 ;
 S IBSVIEN=IBN  ; save off file 350 ien, because in some cases it gets overwritten in the cancellation code  IB*2.0*682
 ; - handle incomplete and regular transactions
 D CANC^IBECEAU4(IBN,IBCRES,1) G:IBY<1 ONEQ
 ;
 ; - handle updating of clock
 ;I "^1^2^3^"'[("^"_IBXA_"^") G ONEQ
 ;I 'IBCHG G ONEQ
 ;D CLSTR^IBECEAU1(DFN,IBFR) I 'IBCLDA W !!,"Please note that there is no billing clock which would cover this charge.",!,"Be sure that this patient's billing clock is correct." G ONEQ
 ;D CLOCK^IBECEAU(-IBCHG,+$P(IBCLST,"^",9),-IBUNIT)
 I "^1^2^3^"[(U_IBXA_U),IBCHG D  ; IB*2.0*682
 .D CLSTR^IBECEAU1(DFN,IBFR) I 'IBCLDA W !!,"Please note that there is no billing clock which would cover this charge.",!,"Be sure that this patient's billing clock is correct." Q
 .D CLOCK^IBECEAU(-IBCHG,+$P(IBCLST,"^",9),-IBUNIT)
 .Q
 ; re-bill previous charge
 I IBSVIEN,'$G(IBAPI) D REBILL(DFN,$P(^IB(IBSVIEN,0),U,17),IBSVIEN)  ; IB*2.0*682
 ;
ONEQ ;Exit utility
 I $G(IBAPI) S IBCNRSLT=IBY
 D ERR^IBECEAU4:IBY<0,PAUSE^IBECEAU
 K IBCHG,IBCRES,IBDESC,IBIL,IBND,IBSEQNO,IBTOTL,IBUNIT,IBATYP,IBIDX,IBCC
 K IBN,IBREB,IBY,IBEVDA,IBPARNT,IBH,IBCANTR,IBXA,IBSL,IBFR,IBTO,IBNOS,IBCANC,IBAMC
 Q
 ;
PASS ; Pass the action to Accounts Receivable.
 N IBSERV
 W !,"Passing the cancellation action to AR... "
 S IBNOS=IBN D ^IBR S IBY=Y W:Y>0 "done."
 Q
 ;
UPDVST(IBCAN) ; update the Visit Tracking file
 ;
 ;INPUT - IBCAN - Type of Update to perform
 ;             1 - Remove with Entered in Error Message
 ;             2 - Visit Only Update
 ;             3 - Free (if free not used) or Visit Only
 ;             4 - Remove with Duplicate Error message
 ;
 N IBBLNO,IBSTAT,IBVSTIEN,IBREAS,IBRTN,IBERROR,IBSTAT
 S IBERROR=""
 ;Locate the IEN in the file using the Bill Number
 S IBBLNO=$$GET1^DIQ(350,IBN_",",.11,"E")
 S:$E(IBBLNO,1)="K" IBBLNO=IBSITE_"-"_IBBLNO
 S IBSTAT=$$GET1^DIQ(350,IBN_",",.05,"I")
 S:IBSTAT=8 IBBLNO="ON HOLD"
 S IBVSTIEN=$$FNDVST(IBBLNO,$$GET1^DIQ(350,IBN_",",.14,"I"),$$GET1^DIQ(350,IBN_",",.02,"I"))
 I +IBVSTIEN=0 D  Q
 . W !!,"Unable to locate the bill in the Urgent Care Visit Tracking Database"
 . W !,"for this veteran.  Please review and update the Urgent Care Visit "
 . W !,"Tracking Maintenance Utility.",!
 ;
 ;Set Status and Reason based on update type.
 S:IBCAN=1 IBREAS=3,IBSTAT=3   ;Visits Removed
 S:IBCAN=2 IBREAS=5,IBSTAT=4   ;Visit set to Visit Only
 S:IBCAN=3 IBREAS=1,IBSTAT=1   ;Free visit
 S:IBCAN=4 IBREAS=4,IBSTAT=3   ;Duplicate Visit
 ;
 S IBRTN=$$UPDATE^IBECEA38(IBVSTIEN,IBSTAT,"",IBREAS,1,IBERROR)
 ;
 Q
 ;
FNDVST(IBBLNO,IBVSTDT,IBN) ; Locate the Visit IEN
 ;
 N IBVSTIEN,IBVSTD,IBFOUND
 S IBVSTIEN=0,IBFOUND=0
 F  S IBVSTIEN=$O(^IBUC(351.82,"C",IBBLNO,IBVSTIEN)) Q:IBVSTIEN=""  D  Q:IBFOUND=1
 . S IBVSTD=$G(^IBUC(351.82,IBVSTIEN,0))
 . I (IBVSTDT=$P(IBVSTD,U,3)),(IBN=$P(IBVSTD,U)) S IBFOUND=1
 Q +IBVSTIEN
 ;
UCVSTDB ; Update the UC Visit Tracking DB if the Cancellation Reason is usable on UC copays
 ;
 N IBUCBH,IBELIG,IBNOFRVS
 I +$$GET1^DIQ(350.3,IBCRES_",",.04,"I")=0 D  Q
 . S IBY=-1
 . W !!,"The selected Cancellation Reason cannot be used when cancelling"
 . W !,"an Urgent Care Copay."
 ;
 S IBUCBH=$$GET1^DIQ(350.3,IBCRES_",",.05,"I")
 ;
 ;For those cancellation reasons deemed to be data entry errors
 I IBUCBH=1 D UPDVST(1) Q
 ;
 ;For those cancellation reasons deemed to be duplicate visits
 I IBUCBH=4 D UPDVST(4) Q
 ;
 ;For those cancellation reasons that need to keep the visit as visit only....
 I IBUCBH=2 D UPDVST(2) Q
 ;
 ;For other valid UC cancellation reasons, assuming that they are 3's (need free visit check)
 S IBELIG=$$GETELGP^IBECEA36($P(IBND,U,2),$P(IBND,U,14))
 I IBELIG=6 D  Q
 . D UPDVST(2)
 . W !!,"Patient is in Enrollment Group 6 on the day of this visit."
 . W !,"Urgent Care Visit Tracking for this visit is set to Visit Only."
 . W !,"If this needs to be a free visit, please update the visit using"
 . W !,"the Urgent Care Visit Tracking Maintenance Option after RUR review."
 ;
 ;If still PG 7 or 8 update to Visit Only and quit.
 I IBELIG>6 D UPDVST(2) Q
 ;
 ;Retrieve # visits
 S IBNOFRVS=$P($$GETVST^IBECEA36($P(IBND,U,2),$P(IBND,U,14)),U,2)
 ;
 ;If free visit remain, convert visit to Free Visit
 I IBNOFRVS<3 D UPDVST(3) Q
 ;
 ;Otherwise, visit only.
 D UPDVST(2)
 ;
 Q
 ;IB*2.0*678 - Create API entry point for cancelling a copay
CANCAPI(IBN) ;Cancel a copay given a Copay IEN.
 ;
 ;INPUT - IEN of the copay to cancel
 ;OUTPUT -
 ;        -1 - Error (Error handled within cancel but still part of the return) 
 ;         0 - Not cancelled
 ;         1 - Cancelled
 ;
 N IBND,IBPARNT,IBCANC,IBH,IBCANTR,IBXA,IBATYP,IBSEQNO,IBIL,IBUNIT,IBCHG,IBFR,IBJOB,IBCRES
 N IBDESC,IBIL,IBSEQNO,IBTOTL,IBIDX,IBCC,IBREB,IBY,IBEVDA,IBPARNT,IBH,IBSL,IBTO,IBNOS,IBCANC,IBAMC
 N IBAPI,IBCNRSLT
 ;
 ;Initialize the job type.
 S IBJOB=4,IBAPI=1,IBY=""
 ;
 D ONE
 Q IBCNRSLT
 ;
REBILL(IBDFN,IBEVDT,IBCRNT) ; Re-bill one of cancelled charges on a given date  IB*2.0*682
 ;
 ; IBDFN - patient's DFN
 ; IBEVDT - event date (350/.17)
 ; IBCRNT - current charge (the one being cancelled) to be excluded from the list (file 350 ien)
 ;
 N IB0,IBACT,IBCNT,IBDASH,IBDT,IBEDT,IBHASUC,IBIENS,IBINPT,IBLINES,IBREBILL,IBSDT,IBUC0,IBUCFLG,IBUCIEN,IBUCSKIP,IBZ
 ; get cancelled charges
 S IBHASUC=0 ; set to 1 below if there's at least one cancelled UC charge
 S (IBUCSKIP,IBCNT)=0
 S IBACT=+$P($G(IBND),U,3)
 I $$ISRX(IBACT) Q  ; don't re-bill if cancelling an RX charge
 S IBINPT=$$ISINPT(IBACT)  ; 1 if inpatient charge
 S IBUCFLG=$S($$GET1^DIQ(350,IBCRNT_",",.03)["URGENT CARE":1,1:0)  ; 1 if UC charge
 S IBSDT=$S(IBINPT:$P(IBND,U,14),1:IBEVDT)
 S IBEDT=$S(IBINPT:$P(IBND,U,15),1:IBEVDT)
 I IBSDT,IBEDT F IBDT=IBSDT:1:IBEDT D
 .S IBZ=0 F  S IBZ=$O(^IB("AFDT",IBDFN,-IBDT,IBZ)) Q:'IBZ  D
 ..S IBIENS=IBZ_","
 ..I $$GET1^DIQ(350,IBIENS,.05)'="CANCELLED" Q  ; only include cancelled charges
 ..I IBZ=IBCRNT Q  ; don't include the charge currently being cancelled
 ..S IB0=$G(^IB(IBZ,0)) I $$ISRX(+$P(IB0,U,3)) Q  ; don't include RX charges
 ..S IBCNT=IBCNT+1
 ..; IBLINES(n) = string formatted for display
 ..; IBLINES(n,"IEN") = corresponding file 350 ien
 ..; IBLINES(n,"UC") = corresponding file 351.82 ien (for "visit only" UC entries)
 ..S IBLINES(IBCNT)=$$FMTE^XLFDT($P(IB0,U,14),"2DZ")             ; bill from (350/.14)
 ..S $P(IBLINES(IBCNT),U,2)=$$FMTE^XLFDT($P(IB0,U,15),"2DZ")     ; bill to (350/.15)
 ..S $P(IBLINES(IBCNT),U,3)=$$GET1^DIQ(350,IBIENS,.03)           ; charge type (350/.03)
 ..I $P(IBLINES(IBCNT),U,3)["URGENT CARE" S IBHASUC=1
 ..S $P(IBLINES(IBCNT),U,4)=$P($P(IB0,U,11),"-",2)               ; bill # (350/.11)
 ..S $P(IBLINES(IBCNT),U,5)=$$GET1^DIQ(350,IBIENS,.1)            ; cancel reason (350/.1)
 ..S $P(IBLINES(IBCNT),U,6)=$P(IB0,U,7)                          ; charge amount (350/.07)
 ..S $P(IBLINES(IBCNT),U,7)=$$GET1^DIQ(350,IBIENS,.2)            ; clinic stop code (350/.2)
 ..S IBLINES(IBCNT,"IEN")=IBZ
 ..S IBUCIEN=$$FNDUCV(IBDFN,IBEVDT,$S($G(IBFAC)>0:IBFAC,1:+$$SITE^VASITE())) ; IBFAC is defined elsewhere, comes from a call to SITE^IBAUTL
 ..I IBUCIEN S IBLINES(IBCNT,"UC")=IBUCIEN
 ..Q
 .; get UC "visit only" entries
 .I 'IBHASUC S IBZ=0 F  S IBZ=$O(^IBUC(351.82,"B",IBDFN,IBZ)) Q:'IBZ  D
 ..S IBUC0=$G(^IBUC(351.82,IBZ,0))
 ..I $P(IBUC0,U,3)'=IBDT Q   ; wrong event date, skip
 ..I $P(IBUC0,U,4)'=4 Q      ; status is not "visit only", skip
 ..I $P(IBUC0,U,2)'=IBFAC Q  ; wrong site, skip
 ..; if UC charge is being cancelled, corresponding 351.82 entry is converted to "visit only", so one of "visit only" entries
 ..; needs to be excluded
 ..I IBUCFLG,'IBUCSKIP S IBUCSKIP=1 Q
 ..S IBCNT=IBCNT+1
 ..S (IBLINES(IBCNT),$P(IBLINES(IBCNT),U,2))=$$FMTE^XLFDT($P(IBUC0,U,3),"2DZ")  ; bill from / to contain visit date (351.82/.03)
 ..S $P(IBLINES(IBCNT),U,3)="Urgent Care"    ; no charge for UC Visit Only entries
 ..S $P(IBLINES(IBCNT),U,5)="Visit Only"
 ..S IBLINES(IBCNT,"UC")=IBZ
 ..Q
 .Q
 I IBCNT'>0 Q  ; nothing to display
 ; display charges
 S $P(IBDASH,"-",81)=""
 W !!,"The following copay charges from the same date may be re-billed:"
 W !!,"   Bill From Bill To  Charge Type      Bill #    Cancel Reason    Stop    Charge"
 W !,IBDASH
 F IBZ=1:1:IBCNT D
 .W !,$$RJ^XLFSTR(IBZ,2),?3,$P(IBLINES(IBZ),U),?13,$P(IBLINES(IBZ),U,2),?22,$E($P(IBLINES(IBZ),U,3),1,16)
 .W ?39,$P(IBLINES(IBZ),U,4),?49,$E($P(IBLINES(IBZ),U,5),1,16),?66,$P(IBLINES(IBZ),U,7)
 .W ?74,$S(+$P(IBLINES(IBZ),U,6)>0:$$RJ^XLFSTR("$"_$P(IBLINES(IBZ),U,6),6),1:"")
 .Q
 W !
 ; If cancelling an inpatient charge, just display message and quit
 I IBINPT W !,"Please review this patient's copayments during this period for potential re-billing." Q
 ; Check for IB EDIT key
 I '$D(^XUSEC("IB EDIT",DUZ)) D  Q
 .W !!,"IB EDIT Key required to Add a Charge."
 .W !!,"Please notify 1st party billing for review and potential re-bill of the above copayment(s), if needed."
 .Q
 ; prompt for a charge to re-bill
 S IBZ=$$ASKRB(IBCNT) I 'IBZ Q
 ; re-bill selected charge
 ; UC Visit Only
 I $G(IBLINES(IBZ,"IEN"))'>0 D  Q
 .S (IBREBILL("EVDT"),IBREBILL("BILLFR"),IBREBILL("BILLTO"))=$P(^IBUC(351.82,IBLINES(IBZ,"UC"),0),U,3)
 .S IBREBILL("CHRGTYPE")="CC URGENT CARE"
 .S IBREBILL("UC")=IBLINES(IBZ,"UC")
 .D ADD^IBECEA3
 .Q
 ; regular charge
 S IBIENS=IBLINES(IBZ,"IEN")_","
 ; populate array of default values to pass to ^IBECEA3 (Add charge)
 S IBREBILL("EVDT")=$P(^IB(IBLINES(IBZ,"IEN"),0),U,17)
 S IBREBILL("BILLFR")=$P(^IB(IBLINES(IBZ,"IEN"),0),U,14)
 S IBREBILL("BILLTO")=$P(^IB(IBLINES(IBZ,"IEN"),0),U,15)
 S IBREBILL("CHRGTYPE")=$$GET1^DIQ(350.1,$P(^IB(IBLINES(IBZ,"IEN"),0),U,3),.08)
 S IBREBILL("CHRGAMT")=$$GET1^DIQ(350,IBIENS,.07)
 I $G(IBLINES(IBZ,"UC")) S IBREBILL("UC")=IBLINES(IBZ,"UC")
 D ADD^IBECEA3
 Q
 ;
ASKRB(IBNUM) ; Prompt for re-billing of a cancelled charge  IB*2.0*682
 ;
 ; IBNUM - number of entries in the list
 ;
 N DIR,DIRUT,DIROUT,DTOUT,DUOUT,RES,X,Y
 S DIR(0)="FA^1:"_IBNUM_"^I +X<1!(+X>"_IBNUM_") K X"
 S DIR("A",1)="Please review the above list of potentially (re)billable items."
 S DIR("A")="Select charge to re-bill (1 - "_IBNUM_") or type '^' to skip this step: "
 S DIR("?")="Select a charge to re-bill from the list above (1 - "_IBNUM_"), or type '^' to skip re-billing."
 D ^DIR
 Q +Y
 ;
ISINPT(IBACT) ; check if given charge is an inpatient charge
 ;
 ; IBACT - ien in file 350.1 for the charge in question
 ;
 ; returns 1 if inpatient charge, 0 otherwise
 ;
 N RES
 S RES=0
 I IBACT,"^1^2^3^9^"[(U_$P($G(^IBE(350.1,IBACT,0)),U,11)_U) S RES=1
 Q RES
 ;
ISRX(IBACT) ; check if given charge is an RX charge
 ;
 ; IBACT - ien in file 350.1 for the charge in question
 ;
 ; returns 1 if RX charge, 0 otherwise
 ;
 N RES
 S RES=0
 I IBACT,$P($G(^IBE(350.1,IBACT,0)),U,11)=5 S RES=1
 Q RES
 ;
FNDUCV(IBDFN,IBEVDT,IBSITE) ; find "visit only" entry in file 351.82
 ;
 ; IBDFN - patient's DFN
 ; IBEVDT - event date (350/.17)
 ; IBSITE - local facility (file 4 ien)
 ;
 ; Returns ien in file 351.82 if an entry was found, 0 otherwise
 ;
 N IBFOUND,IBRES,IBUC0,IBZ
 S IBRES=0
 I IBDFN'>0!(IBEVDT'>0)!(IBSITE'>0) Q IBRES
 S (IBFOUND,IBZ)=0 F  S IBZ=$O(^IBUC(351.82,"VD",IBEVDT,IBZ)) Q:'IBZ  D  Q:IBFOUND
 .S IBUC0=^IBUC(351.82,IBZ,0)
 .I $P(IBUC0,U)'=IBDFN Q     ; wrong patient
 .I $P(IBUC0,U,4)'=4 Q       ; status is not "visit only"
 .I $P(IBUC0,U,2)'=IBSITE Q  ; wrong site
 .S IBFOUND=1,IBRES=IBZ
 .Q
 Q IBRES

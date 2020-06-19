IBECEA4 ;ALB/CPM - Cancel/Edit/Add... Cancel a Charge ;11-MAR-93
 ;;2.0;INTEGRATED BILLING;**27,52,150,240,663,671,669**;21-MAR-94;Build 20
 ;;Per VHA Directive 6402, this routine should not be modified.
 ;
ONE ; Cancel a single charge.
 D HDR^IBECEAU("C A N C E L")
 ;
 ; - perform up-front edits
 D CED^IBECEAU4(IBN) G:IBY<0 ONEQ
 I IBXA=6!(IBXA=7) D  G ONEQ:$G(IBCC),REAS
 .I IBCANTR!($P(IBND,"^",5)=10) S IBCC=1 W !,"This transaction has already been cancelled.",!
 I IBCANTR!($P(IBND,"^",5)=10) W !,$S(IBH:"Please note that this cancellation action has not yet been passed to AR.",1:"This transaction has already been cancelled."),! G ONEQ:'IBH,REAS
 I 'IBH,IBIL="" S IBY="-1^IB024" G ONEQ
 ;
REAS ; - ask for the cancellation reason
 ;
 D REAS^IBECEAU2("C") G:IBCRES<0 ONEQ
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
 ; - handle incomplete and regular transactions
 D CANC^IBECEAU4(IBN,IBCRES,1) G:IBY<1 ONEQ
 ;
 ; - handle updating of clock
 I "^1^2^3^"'[("^"_IBXA_"^") G ONEQ
 I 'IBCHG G ONEQ
 D CLSTR^IBECEAU1(DFN,IBFR) I 'IBCLDA W !!,"Please note that there is no billing clock which would cover this charge.",!,"Be sure that this patient's billing clock is correct." G ONEQ
 D CLOCK^IBECEAU(-IBCHG,+$P(IBCLST,"^",9),-IBUNIT)
 ;
ONEQ D ERR^IBECEAU4:IBY<0,PAUSE^IBECEAU
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

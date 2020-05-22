IBECEA4 ;ALB/CPM - Cancel/Edit/Add... Cancel a Charge ;11-MAR-93
 ;;2.0;INTEGRATED BILLING;**27,52,150,240,663,671**;21-MAR-94;Build 13
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
 N IBUCR1,IBUCR2,IBUCDV
 ;
 D REAS^IBECEAU2("C") G:IBCRES<0 ONEQ
 ;
 ; - okay to proceed?
 D PROC^IBECEAU4("cancel") G:IBY<0 ONEQ
 ;
 ; update Visit Tracking file if UC visit entered in error, UC Duplicate Visit,
 ;   or Patient Deceased (#350.3, iens 11, 51, and 53 only)
 S IBUCR1=$O(^IBE(350.3,"B","UC - ENTERED IN ERROR",""))
 S IBUCDV=$O(^IBE(350.3,"B","UC - DUPLICATE VISIT",""))
 S IBUCR2=$O(^IBE(350.3,"B","PATIENT DECEASED",""))
 I (IBCRES=IBUCR1)!(IBCRES=IBUCR2)!(IBCRES=IBUCDV) D UPDVST(1)
 ;
 ; Update visit tracking file (351.82) for visit to Visit Only if Cancelling a UC Copay with
 ;   Received Inpatient Care, or Billed at Higher Tier Rate,
 S IBUCR1=$O(^IBE(350.3,"B","RECD INPATIENT CARE",""))
 S IBUCR2=$O(^IBE(350.3,"B","BILLED AT HIGHER TIER RATE",""))
 I (IBCRES=IBUCR1)!(IBCRES=IBUCR2) D UPDVST(2)
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
 ;             1 - Remove update
 ;             2 - Visit Only Update
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
 S:IBCAN=1 IBREAS=$S(IBCRES=IBUCDV:4,1:3),IBSTAT=3
 S:IBCAN=2 IBREAS=5,IBSTAT=4
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

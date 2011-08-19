IBECEA4 ;ALB/CPM - Cancel/Edit/Add... Cancel a Charge ;11-MAR-93
 ;;2.0;INTEGRATED BILLING;**27,52,150,240**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
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
 D REAS^IBECEAU2("C") G:IBCRES<0 ONEQ
 ;
 ; - okay to proceed?
 D PROC^IBECEAU4("cancel") G:IBY<0 ONEQ
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

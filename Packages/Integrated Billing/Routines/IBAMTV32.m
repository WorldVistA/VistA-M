IBAMTV32 ;ALB/CPM - RELEASE PENDING CHARGES ACTIONS ; 03-JUN-94
 ;;Version 2.0 ; INTEGRATED BILLING ;**15**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
PC ; 'Pass Charges' entry action.
 N IBCOMMIT,IBNBR,IBY,IBMSG,IBNOS,IBNOSX,IBND,IBY,IBMSG,IBDUZ,IBSTAT
 N IBAFY,IBATYP,IBARTYP,IBN,IBSEQNO,IBSERV,IBTOTL,IBTRAN,IBIL,IBBG
 S IBCOMMIT=0 D EN^VALM2($G(XQORNOD(0))) I '$O(VALMY(0)) G PCQ
 S IBNBR="" F  S IBNBR=$O(VALMY(IBNBR)) Q:'IBNBR  D  D MSG
 .S (IBNOS,IBNOSX)=^TMP("IBAMTV31",$J,"IDX",IBNBR,IBNBR)
 .S IBND=$G(^IB(IBNOS,0)),IBY=1,IBMSG="",IBDUZ=DUZ
 .I 'IBND S IBMSG="was not passed - record missing the zeroth node" Q
 .I $P(IBND,"^",12) S IBMSG="was not passed - the charge already has an AR Transaction Number" Q
 .S IBSTAT=+$P(IBND,"^",5) I $P($G(^IBE(350.21,IBSTAT,0)),"^",4) S IBMSG="was not passed - the status indicates that the charge is billed" Q
 .I $P(IBND,"^",7)'>0 S IBMSG="was not passed - there is no charge amount" Q
 .S IBSEQNO=$P($G(^IBE(350.1,+$P(IBND,"^",3),0)),"^",5) I 'IBSEQNO S IBMSG="was not passed (Bulletin will be generated)",IBY="-1^IB023" Q
 .;
 .; - okay to pass charge?
 .D PROC^IBECEAU4("pass") I IBY<0 S IBY=1 Q
 .;
 .; - pass charge to AR and update list
 .D ^IBR S IBY=$G(Y)
 .S IBND=$G(^IB(IBNOSX,0)),IBCOMMIT=1
 .S IBMSG=$S(IBY<0:"was not passed - see error message (bulletin).",$P(IBND,"^",5)=8:"has now been placed ON HOLD (patient has active insurance).",1:"has been passed to Accounts Receivable.")
 .;
 .; - update IVM
 .D IVM(IBND)
 ;
PCQ D PAUSE^VALM1
 S VALMBCK=$S(IBCOMMIT:"R",1:"")
 I IBCOMMIT S IBBG=VALMBG D INIT^IBAMTV31 S VALMBG=IBBG
 Q
 ;
 ;
CC ; 'Cancel Charges' entry action.
 N IBCHG,IBCRES,IBIL,IBND,IBSEQNO,IBUNIT,IBATYP,IBDUZ,IBBG
 N IBN,IBY,IBPARNT,IBH,IBCANTR,IBXA,IBFR,IBCANC,IBCOMMIT,IBNBR
 D FULL^VALM1
 S IBCOMMIT=0 D EN^VALM2($G(XQORNOD(0))) I '$O(VALMY(0)) G CCQ
 S IBNBR="" F  S IBNBR=$O(VALMY(IBNBR)) Q:'IBNBR  D
 .S IBN=^TMP("IBAMTV31",$J,"IDX",IBNBR,IBNBR),IBDUZ=DUZ,IBY=0 Q:'IBN
 .;
 .; - perform up-front edits
 .D CED^IBECEAU4(IBN) Q:IBY<0
 .I 'IBH,IBIL="" S IBY="-1^IB024" Q
 .;
 .; - ask for the cancellation reason
 .D REAS^IBECEAU2("C") Q:IBCRES<0
 .;
 .; - okay to proceed?
 .D PROC^IBECEAU4("cancel") I IBY<0 S IBY=1 Q
 .;
 .; - handle incomplete and regular transactions
 .D CANC^IBECEAU4(IBN,IBCRES,1) Q:IBY<0
 .;
 .S IBCOMMIT=1,IBMSG="has been cancelled." D MSG
 .;
 .; - handle the clock
 .D CLSTR^IBECEAU1(DFN,$P(IBND,"^",14))
 .I 'IBCLDA W !!,"Please note that there is no billing clock which would cover this charge.",!,"Be sure that this patient's billing clock is correct." Q
 .D CLDSP^IBECEAU1(IBCLST,$$PT^IBEFUNC(DFN))
 .W !!,"Since the billing clock was updated when the charge was originally built,"
 .W !,"you may now need to update this clock since the charge has been cancelled."
 ;
CCQ D PAUSE^VALM1
 S VALMBCK="R"
 I IBCOMMIT S IBBG=VALMBG D INIT^IBAMTV31 S VALMBG=IBBG
 Q
 ;
 ;
MSG ; Display results message.
 I IBMSG]"" W !,"Charge #"_IBNBR_" "_IBMSG I +IBY=-1 D ^IBAERR1
 Q
 ;
 ;
IVM(IBND) ; Pass billing information to the IVM package.
 ;         This tag is also called by IBECEA1 (Pass a Charge)
 ;
 ; Input:  IBND  --  Zeroth node of IB action in file #350
 ;
 Q:'$G(IBND)
 D REV^IVMUFNC3(+IBND,+$P(IBND,"^",2),$S($P(IBND,"^",8)["OPT COPAY":2,1:1),$S($P($G(^IBE(350.1,+$P(IBND,"^",3),0)),"^")["PER DIEM":3,1:2),$P(IBND,"^",14),$P(IBND,"^",15),$P(IBND,"^",7),$P(IBND,"^",5)=8)
 Q

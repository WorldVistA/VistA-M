IBCD1 ;ALB/ARH - AUTOMATED BILLER ; 8/6/93
 ;;2.0; INTEGRATED BILLING ;**55,81**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
SETB ;set up bills  (sort by event date required by types where multiple events can be on one bill)
 S IBDFN=0 F  S IBDFN=$O(^TMP("IBCAB",$J,IBDFN)) Q:'IBDFN  D
 . S IBTYP=0 F  S IBTYP=$O(^TMP("IBCAB",$J,IBDFN,IBTYP)) Q:'IBTYP  S IBS="IBC"_IBTYP D
 .. S IBEVDT=0 F  S IBEVDT=$O(^TMP("IBCAB",$J,IBDFN,IBTYP,IBEVDT)) Q:'IBEVDT  D
 ... S IBTRN=0 F  S IBTRN=$O(^TMP("IBCAB",$J,IBDFN,IBTYP,IBEVDT,IBTRN)) Q:'IBTRN  D
 .... S IBX=$P($G(^IBE(356.6,+IBTYP,0)),U,1)
 .... I IBX="INPATIENT ADMISSION" D INP^IBCD5 Q
 .... I IBX="PRESCRIPTION REFILL" D RXRF Q
 .... I IBX="OUTPATIENT VISIT" D OUTP Q
 .... D TEABD(IBTRN,0),TERR(IBTRN,0,"Event type can not be auto billed.")
 K IBDFN,IBTYP,IBEVDT,IBTRN,IBS,IBX,IBSTDT,IBTF
 D NABOUTP
 D ^IBCD2
 Q
 ;
OUTP ;Outpatient Bills   (IBTRN,IBTYP,IBDFN,IBEVDT)
 ;get statement from and to dates, based on event date and billing cycle of event type then try to match event to an existing bill cycle, check that event is not already billed and that BC+DD is greater than current date
 ;^TMP("IBC2",$J, PATIENT , START DT ^ TO DT , EVENT IFN)= TIMEFRAME
 S IBSTDT=(IBEVDT\1)_"^"_$$BCDT^IBCU8(IBEVDT,IBTYP)
 S IBX=0 F  S IBX=$O(^TMP(IBS,$J,IBDFN,IBX)) Q:IBX=""!(+IBSTDT<+IBX)  I +IBSTDT'>$P(IBX,U,2) S IBSTDT=IBX Q
 S IBX=$$DUPCHK^IBCU41(IBEVDT,0,0,IBDFN,0) I +IBX D TEABD(IBTRN,0),TERR(IBTRN,0,$P(IBX,U,2)) G OUTPQ
 S IBX=$$EABD^IBCU81(IBTYP,$P(IBSTDT,U,2)) I +IBX>DT N IBXX S IBXX=$S(+$P($G(^IBT(356,IBTRN,1)),U,1)]"":+$P(^IBT(356,IBTRN,1),U,1)\1,1:$P(IBSTDT,U,1)),IBXX=$$EABD^IBCU81(IBTYP,IBXX) D TEABD(IBTRN,+IBXX) G OUTPQ
 I $$NABSCT^IBCU81(IBTRN) S ^TMP("IBNAB",$J,IBS,IBDFN,(IBEVDT\1),IBTRN)="" G OUTPQ
 S ^TMP(IBS,$J,IBDFN,IBSTDT,IBTRN)=1,^TMP("IBNAB1",$J,IBS,IBDFN,(IBEVDT\1))=IBSTDT
OUTPQ K IBSTDT,IBX
 Q
RXRF ;RX Refill (Outpatient) Bills   (IBTRN,IBTYP,IBDFN,IBEVDT)
 ;get statement from and to dates, based on event date and billing cycle of event type then try to match event to an existing bill cycle, check that event is not already billed and that BC+DD is greater than current date
 ;^TMP("IBC4",$J, PATIENT , START DT ^ TO DT , EVENT IFN)= TIMEFRAME
 S IBRXRF=$$RXRF^IBCU81(IBTRN) I IBRXRF="" D TEABD(IBTRN,0),TERR(IBTRN,0,"Can not find rx refill in Pharmacy.") G RXRFQ
 S IBSTDT=($P(IBRXRF,U,2)\1)_"^"_$$BCDT^IBCU8(+$P(IBRXRF,U,2),IBTYP)
 S IBX=0 F  S IBX=$O(^TMP(IBS,$J,IBDFN,IBX)) Q:IBX=""!(+IBSTDT<+IBX)  I +IBSTDT'>$P(IBX,U,2) S IBSTDT=IBX Q
 S IBX=$$RXDUP^IBCU3($P(IBRXRF,U,1),+$P(IBRXRF,U,2),0,0,IBDFN,0) I +IBX D TEABD(IBTRN,0),TERR(IBTRN,0,$P(IBX,U,2)) G RXRFQ
 S IBX=$$EABD^IBCU81(IBTYP,$P(IBSTDT,U,2)) I +IBX>DT N IBXX S IBXX=$S(+$P($G(^IBT(356,IBTRN,1)),U,1)]"":+$P(^IBT(356,IBTRN,1),U,1)\1,1:$P(IBSTDT,U,1)),IBXX=$$EABD^IBCU81(IBTYP,IBXX) D TEABD(IBTRN,+IBXX) G RXRFQ
 S ^TMP(IBS,$J,IBDFN,IBSTDT,IBTRN)=1
RXRFQ K IBSTDT,IBX,IBRXRF
 Q
 ;
NABOUTP ; add opt visits that should not be auto billed but date has been billed
 N IBDFN,IBS,IBEVDT,IBSTDT,IBTRN S IBS=$O(^TMP("IBNAB",$J,0))
 I IBS'="" S IBDFN=0 F  S IBDFN=$O(^TMP("IBNAB",$J,IBS,IBDFN)) Q:'IBDFN  D
 . S IBEVDT=0 F  S IBEVDT=$O(^TMP("IBNAB",$J,IBS,IBDFN,IBEVDT)) Q:'IBEVDT  D
 .. S IBSTDT=$G(^TMP("IBNAB1",$J,IBS,IBDFN,IBEVDT))
 .. S IBTRN=0 F  S IBTRN=$O(^TMP("IBNAB",$J,IBS,IBDFN,IBEVDT,IBTRN)) Q:'IBTRN  D
 ... I IBSTDT'?7N1"^"7N D TEABD(IBTRN,0) Q
 ... S ^TMP(IBS,$J,IBDFN,IBSTDT,IBTRN)=1
 K ^TMP("IBNAB",$J),^TMP("IBNAB1",$J)
 Q
 ;
TEABD(TRN,IBDT) ;array contains the list of claims tracking events that need EABD updated, and the new date
 S IBDT=+$G(IBDT),^TMP("IBEABD",$J,TRN,+IBDT)=""
 Q
TERR(TRN,IFN,ER) ;array contains events or bills that need entries created in the comments file, and the comment
 N X S TRN=+$G(TRN),IFN=+$G(IFN),X=+$G(^TMP("IBCE",$J,DT,TRN,IFN))+1
 S ^TMP("IBCE",$J,DT,TRN,IFN,X)=$G(ER),^TMP("IBCE",$J,DT,TRN,IFN)=X
 Q
TBILL(TRN,IFN) ;array contains list of events and bills to be inserted into 356.399
 I '$D(^IBT(356,+$G(TRN),0))!('$D(^DGCR(399,+$G(IFN),0))) Q
 S ^TMP("IBILL",$J,TRN,IFN)=""
 Q

IBCD5 ;ALB/ARH - AUTOMATED BILLER (INPT DT RANGE) ;8/6/93
 ;;2.0;INTEGRATED BILLING;**14,31,106,51,137**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ; DBIA REFERENCE TO ^DGPM("ATID1") = DBIA419
 ;
 ;continuation of IBCD1
INP ;Inpatient Admissions   (IBTRN,IBTYP,IBDFN,IBEVDT)
 ;get statement from and to dates based on previous non-final bills or event date and billing cycle, check that range is within admit-discharge, not previously billed, and BC + DD is not greater than current date, PTF status
 ;^TMP("IBC1",$J, PATIENT , START DT ^ TO DT , EVENT IFN)= TIMEFRAME
 ;
 S IBX=$P($G(^IBT(356,IBTRN,0)),U,5),IBAD=$$AD^IBCU64(IBX),IBDIS=+$P(IBAD,U,2)\1 I 'IBAD!('$P(IBAD,U,4))  D  G INPQ
 . I 'IBAD D TERR(IBTRN,0,"Patient Admission Movement Data not found.")
 . D TERR(IBTRN,0,"Admission movement missing PTF number.")
 ;
 S IBX=$G(^DGPT(+$P(IBAD,U,4),0)) I 'IBX D TERR(IBTRN,0,"PTF record for Admission movement was not found.") G INPQ
 I '$P(IBX,U,6)!(+$P(IBPAR7,U,3)>+$P(IBX,U,6)) G INPQ ; check PTF status, PTF record must be at least closed or status entered by site before and auto bill can be created
 ;
 ; find latest bill dates for record, if a final bill or a non reimb. ins bill exit 
 S IBLBDT=$$BILLED^IBCU3($P(IBAD,U,4)) I +IBLBDT,('$P(IBLBDT,U,2)!($P(IBLBDT,U,3)'=8)) D  G INPQ
 . S IBX=$P($G(^DGCR(399,+IBLBDT,0)),U,1)
 . I '$P(IBLBDT,U,2) D TBILL(IBTRN,+IBLBDT),TERR(IBTRN,0,"Event already has a final bill ("_IBX_").")
 . I $P(IBLBDT,U,3)'=8 S IBX=$P($G(^DGCR(399.3,+$P(IBLBDT,U,3),0)),U,1) D TERR(IBTRN,0,"May not be Reimbursable Ins.: A "_IBX_" bill already exists for this event.")
 ;
 ; begin calculation of bill dates, begin date based on end of last bill, otherwise event date (admission dt)
 S IBSTDT=$P(IBLBDT,U,2)\1,IBTF=3 I +IBSTDT S IBSTDT=$$FMADD^XLFDT(+IBSTDT,1)
 I 'IBSTDT S IBSTDT=IBEVDT\1,IBTF=2
 S $P(IBSTDT,U,2)=$$BCDT^IBCU8(+IBSTDT,IBTYP) ; end date based on pre^defined length of bill cycle
 ;
 ; force date range to within admit-discharge dates
 S:+IBSTDT<+IBAD $P(IBSTDT,U,1)=+IBAD\1 I +IBDIS,$P(IBSTDT,U,2)>+IBDIS S $P(IBSTDT,U,2)=+IBDIS
 I $P(IBSTDT,U,2)=IBDIS S IBTF=4 I +IBSTDT=(+IBAD\1) S IBTF=1
 ;
 I IBTF=4,+IBSTDT=+$P(IBSTDT,U,2) D TEABD(IBTRN,0),TERR(IBTRN,0,"Interim  - Last bill not created:  Only day not already billed is the discharge date, which is not billable.") G INPQ
 ;
 S IBX=$$DUPCHKI^IBCU64(+IBSTDT,$P(IBSTDT,U,2),$P(IBAD,U,4),0,0) I +IBX D TEABD(IBTRN,0),TERR(IBTRN,0,$P(IBX,U,2)) G INPQ
 S IBX=$$EABD^IBCU81(IBTYP,$P(IBSTDT,U,2)) I +IBX>DT D TEABD(IBTRN,+IBX) G INPQ
 S ^TMP(IBS,$J,IBDFN,IBSTDT,IBTRN)=IBTF
INPQ K IBSTDT,IBAD,IBLBDT,IBDIS,IBX,IBTF
 Q
 ;
INPT ;
 N PTF,IBDTS
 S IBADMT=$P(IBTRND,U,5),IBAD=$$AD^IBCU64(IBADMT),IB(.03)=+IBAD,IB(.05)=1
 ;check ptf movements for service connected care, see enddis^ibca0
 S IB(.08)=$P(IBAD,U,4),PTF=IB(.08)
 ;S IB(.04)=1,IBX=$P($G(^DIC(45.7,+$P(IBAD,U,5),0)),U,2) I $P($G(^DIC(42.4,+IBX,0)),U,3)="NH" S IB(.04)=2 ; treating specialty NHCU
 S IB(.04)=1 N VAIN,VAINDT,VAERR S VAINDT=+IBAD D INP^VADPT I +VAIN(3),$P($G(^DIC(42.4,+$P($G(^DIC(45.7,+VAIN(3),0)),U,2),0)),U,3)="NH" S IB(.04)=2 ; treating specialty NHCU
 ; Attending physician
 I $G(VAIN(11)) S IB("PRV",.02)=+VAIN(11)_";VA(200,",IB("PRV",.01)=4
 S IBDISDT=$P(IBAD,U,2) ; discharge date
 S IB(151)=+IBSTDT,IB(152)=$P(IBSTDT,U,2)
 S IBIDS(.08)=IB(.08) D SPEC^IBCU4 S IB(161)=$G(IBIDS(161)) K IBIDS ; discharge bedsection
 I +IBDISDT,'IB(161) D TERR(IBTRN,IBIFN,"Non-Billable Discharge Bedsection.")
 S IB(165)=$$LOS^IBCU64(IB(151),IB(152),IB(.06),IBADMT) I IB(165)'>0 D TERR(IBTRN,IBIFN,"No billable Days.")
 ;
 S DFN=IBDFN,IB(217)=$$NONCOV^IBCU64(IB(151),IB(152),IBADMT,.IBDTS),IB(216)=+IB(165)
 I IB(217) D  ;Stuff occurrence span codes (74) for dates of leave/pass
 . N IBOC,IBC,IBD,IBX
 . S (IBOC,IBC)=0
 . F  S IBOC=$O(^DGCR(399.1,"C1",74,IBOC)) Q:'IBOC  I $P($G(^DGCR(399.1,IBOC,0)),U,10) S IB("OC")=IBOC Q  ;Get ien for occ span code 74
 . Q:'IBOC
 . S IBX=0 F  S IBX=$O(IBDTS(IBX)) Q:'IBX  S IBD=$G(IBDTS(IBX)) I $P(IBD,U,3)>0 D
 .. S IBC=IBC+1,IB("OC",IBC,.02)=$P(IBD,U),IB("OC",IBC,.04)=$P(IBD,U,2)
 S IB(.09)=9 D IDX^IBCD4(+IB(.08),+IB(151),+IB(152)) I $D(IBMSG)>2 D
 . S IBX=0 F  S IBX=$O(IBMSG(IBX)) Q:'IBX  D TERR(IBTRN,IBIFN,IBMSG(IBX))
 I +$$BILLRATE^IBCRU3(+$G(IB(.07)),IB(.05),IB(.03),"RC") S IB(.27)=1 ; reasonable charges institutional bill
 ; Calculate coinsurance days if MEDICARE
 I $$MCRPT^IBCEU2(IBIFN,IBADMT) D  ; GET # MCR CO-INSURANCE DAYS
 . N IBI,IBTOT,DGPMCA,IBPTF,IBD1,IBD2,IBTYPA,IBTYP
 .; SNF coinsurance is from days 21-100, non SNF is 61-90 per benefit pd
 .; Benefit period starts on admission to a hospital or SNF and ends
 .;  when 60 consecutive days have elapsed as an outpatient
 .; COUNT THE # OF DAYS IN ALL THE ADMISSIONS FROM THIS DISCHARGE OR
 .;   (if none) FROM 60 DAYS AGO THRU THE ADMISSION DATE BEING BILLED
 . S IBTYPA=$S(IB(.04)'=2:"HOS",1:"SNF")
 . S IBTOT=IB(165)
 . S IBI=$$INV(IBADMT),IBD1=IBADMT\1
 . F  S IBI=$O(^DGPM("ATID1",IBDFN,IBI)) Q:'IBI!(IBTOT>$S(IBTYPA="HOS":90,1:100))  S DGPMCA=0 F  S DGPMCA=$O(^DGPM("ATID1",IBDFN,IBI,DGPMCA)) Q:'DGPMCA  D
 .. S IBPTF=+$P($G(^DGPM(DGPMCA,0)),U,16),IBD2=$G(^DGPT(IBPTF,70))\1
 .. Q:'IBD2
 .. I $$FMDIFF^XLFDT(IBD2,IBD1,1)>60 Q  ; at least 60 days out of hosp
 .. S IBTYP=$S($P($G(^DIC(42.4,+$P($G(^DIC(45.7,+$P(^DGPM(DGPMCA,0),U,9),0)),U,2),0)),U,3)'="NH":"HOS",1:"SNF")
 .. I IBTYP=IBTYPA S IBTOT=IBTOT+$$LOS^IBCU64(IBPTF,$$INV(IBI),IBD2,"",DGPMCA) ;Only tally the same type of care (HOS/SNF) for the benefit pd
 .. S IBD1=$$INV(IBI)\1
 .; IF TOTAL # OF PREVIOUS DAYS + TOTAL # DAYS IN THIS ADMISSION
 .;    EXCEEDS MCR LIMITS, WE HAVE CO-INSURANCE DAYS
 .; CALCULATE THE DAYS BY SUBTRACTING 60/20 FROM THE TOTAL # OF DAYS OR
 .;    90/100, WHICHEVER IS LESS, STORE THIS # IN FIELD #221
 . I IBTYPA="HOS" S:IBTOT>60 IB(221)=$S(IBTOT<90:IBTOT-60,1:30)
 . I IBTYPA="SNF" S:IBTOT>20 IB(221)=$S(IBTOT<100:IBTOT-20,1:80)
INPTE K IBADMT,IBADMTD,IBDISDT,IBLBDT,IBSCM,IBM,IBAD,IBX
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
INV(X) ; Returns inverted date in X
 Q (9999999.9999999-X)
 ;

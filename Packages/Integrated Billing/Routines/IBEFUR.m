IBEFUR ;ALB/ARH - UTILITY: FIND RELATED FIRST AND THIRD PARTY BILLS ; 3/7/00
 ;;2.0;INTEGRATED BILLING;**130**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ; 
 ; Called by Accounts Receivable report option
 ;
 ; for a specific Third Party bill, return all related Third Party bills
 ; matchs with the selected bill are based on:   (selected bill is included in list returned)
 ; 1)  Event Date (399,.03), returns all bills with same Event Date
 ; 
 ; 2)  PTF # (399,.08), returns all bills with the same PTF number
 ; 3)  PTF # (399,.08), returns all bills with Outpatient Visit Dates (399,43) within the admission date range
 ; 
 ; 4)  Opt Visit Dates (399,43), returns all bills with one or more matching Opt Visit Dates
 ; 5)  Opt Visit Dates (399,43), returns all bills for any PTF (399,.08) stay covering any of the Opt Visit Dates
 ;
 ; 6)  Prescriptions (362.4): returns all bills with one or more matching Rx # and fill date
 ;
 ; ^TMP("IBRBT", $J, selected bill ifn) = PATIENT HAS ANY RX COVERAGE ON FROM DATE OF BILL (0/1)
 ; ^TMP("IBRBT", $J, selected bill ifn, matching bill ifn) = 
 ;                                        BILL FROM ^ BILL TO ^ CANCELLED (0/1) ^ AR BILL NUMBER ^ 
 ;                                        PAYER SEQUENCE ^ PAYER IS MEDICARE SUPPLEMENTAL (0/1) ^ PAYER NAME
 ;
TPTP(IBIFN) ; given a specific Third Party bill, find all related Third Party Bills
 N IB0,DFN,IBEVDT,IBPTF,IBADM,IBDIS,IBOPV,IBPTF1,IBXRF,IBRXN,IBRXDT,IBX Q:'$G(IBIFN)
 S IB0=$G(^DGCR(399,+IBIFN,0)) Q:IB0=""  S DFN=$P(IB0,U,2),IBEVDT=$P(IB0,U,3),IBPTF=$P(IB0,U,8)
 ;
 K ^TMP("IBRBT",$J,IBIFN) S IBX=$$LN1^IBEFURT(IBIFN) D SAVELN1^IBEFURT(IBIFN,IBX)
 ;
 I +IBEVDT D TPEVDT^IBEFURT(DFN,IBEVDT,IBIFN) ; find all bills with the same Event Date (399,.03)
 ;
IT I +IBPTF D TPPTF^IBEFURT(IBPTF,IBIFN) ; find all bills with the same PTF number  (399,.08)
 ;
 ; find any bills with Outpatient Visit Dates within the date range of the admission (PTF)
 I +IBPTF S IBADM=$P($G(^DGPT(+IBPTF,0)),U,2),IBDIS=+$G(^DGPT(+IBPTF,70)) S:'IBDIS IBDIS=DT D
 . D TPOPV^IBEFURT(DFN,IBADM,IBDIS,IBIFN)
 ;
OT ; find all bills that have one or more of the same Opt Visit Dates (399,43)
 S IBX=0 F  S IBX=$O(^DGCR(399,+IBIFN,"OP",IBX)) Q:'IBX  S IBOPV=+$G(^DGCR(399,+IBIFN,"OP",IBX,0)) D
 . D TPOPV^IBEFURT(DFN,IBOPV,IBOPV,IBIFN)
 ;
 ; find any bills for inpatient admissions whose date range includes one or more of the Opt Visit Dates
 S IBX=0 F  S IBX=$O(^DGCR(399,+IBIFN,"OP",IBX)) Q:'IBX  S IBOPV=+$G(^DGCR(399,+IBIFN,"OP",IBX,0)) D
 . S IBADM=$$ADM^IBCU64(DFN,IBOPV) I +IBADM S IBPTF1=$P(IBADM,U,4) I +IBPTF1 D
 .. D TPPTF^IBEFURT(IBPTF1,IBIFN)
 ;
RT ; find all bills that have one or more of the same Prescription: same Rx number and fill date (362.4,.01,.03)
 S IBXRF="AIFN"_IBIFN,IBRXN="" F  S IBRXN=$O(^IBA(362.4,IBXRF,IBRXN))  Q:'IBRXN  D
 . S IBX=0 F  S IBX=$O(^IBA(362.4,IBXRF,IBRXN,IBX)) Q:'IBX  S IBRXDT=$P($G(^IBA(362.4,IBX,0)),U,3) D
 .. D TPRX^IBEFURT(DFN,IBRXN,IBRXDT,IBIFN)
 Q
 ;
 ; ==============================================================================================================
 ;
 ; Called by Accounts Receivable report option
 ;
 ; for a specific Third Party bill, return all related First Party Charges
 ; only a single record of a charge event is returned, defining the charges current status, although there may 
 ; have been cancellations or updates to the original charge
 ;    o Inpatient Events may have multiple charge events (Copay and Per Diem)
 ;    o Opt and Rx Events have only a single charge event (Copay)
 ; 
 ; matchs with the selected bill are based on:
 ; 1) Event Date (399,.03), returns Inpatient charges whose Parent Event (350,.16) has that Event Date (350,.17)
 ; 2) PTF # (399,.08), returns Outpatient charge for Opt Visits Dates within timeframe of admission
 ; 
 ; 3) Opt Visit Date (399,43), returns the Outpatient charge for that Event Date (350,.17)
 ; 4) Opt Visit Date (399,43), returns Inpatient charges for any admission that includes that Opt Visit Date
 ; 
 ; 5) Rx Record (362.4,.05) and Rx Date (362.4,.03) and Outpatient Pharmacy, returns the Rx charge for the fill
 ; 6) Opt Visit Date (399,43) and Outpatient Pharmacy, returns any First Party Rx charge on one of the 
 ;    selected bills Opt Visit Dates that is not billed on any Third Party bill
 ;
 ; ^TMP("IBRBF", $J , selected bill ifn ) = ""
 ; ^TMP("IBRBF", $J , selected bill ifn , charge ifn) = 
 ; BILL FROM ^ BILL TO ^ CANCELLED? (1/0)^ AR BILL NUMBER ^ TOTAL CHARGE ^ ACTION TYPE (SHORT) ^ # DAYS ON HOLD
 ;
TPFP(IBIFN) ; given a specific Third Party Bill, find all related First Party Bills
 N IBX,IBY,IB0,DFN,IBEVDT,IBPTF,IBADM,IBOPV,IBXRF,IBRXN,IBRXIFN,IBRXDT,IBFROM,IBTO Q:'$G(IBIFN)
 S IB0=$G(^DGCR(399,+IBIFN,0)) Q:IB0=""  S DFN=$P(IB0,U,2),IBEVDT=$P(IB0,U,3)
 ;
 K ^TMP("IBRBF",$J,IBIFN) D SAVELN1^IBEFURF(IBIFN)
 ;
IF ; find all First Party charges for the Inpatient Event Date (Admission Date) on the Third Party bill
 D FPINPT^IBEFURF(DFN,IBEVDT,IBIFN)
 ;
 ; find any First Party Outpatient charges for Visit Dates within the date range of the admission (PTF)
 S IBPTF=$P(IB0,U,8) I +IBPTF S IBADM=$$PTFADM^IBCU64(+IBPTF) I +IBADM S IBADM=$$AD^IBCU64(IBADM) D
 . S IBX=$P(IBADM,U,2)\1 I 'IBX S IBX=DT
 . D FPOPV^IBEFURF(DFN,+IBADM\1,IBX,IBIFN)
 ;
OF ; find First Party charges for the Opt Visit Dates on the Third Party Bill
 S IBX=0 F  S IBX=$O(^DGCR(399,+IBIFN,"OP",IBX)) Q:'IBX  S IBOPV=+$G(^DGCR(399,+IBIFN,"OP",IBX,0)) D
 . D FPOPV^IBEFURF(DFN,IBOPV,IBOPV,IBIFN)
 ;
 ; find any charges for inpatient admissions whose date range includes one or more of the Opt Visit Dates
 S IBX=0 F  S IBX=$O(^DGCR(399,+IBIFN,"OP",IBX)) Q:'IBX  S IBOPV=+$G(^DGCR(399,+IBIFN,"OP",IBX,0)) D
 . S IBADM=$$ADM^IBCU64(DFN,IBOPV) I 'IBADM Q
 . D FPINPT^IBEFURF(DFN,+IBADM,IBIFN)
 ;
RF ; find First Party charges for any Rx's on the selected Third Party bill
 ; based on Rx IFN (52) and fill date (362.4,.05,.03)
 S IBXRF="AIFN"_IBIFN,IBRXN="" F  S IBRXN=$O(^IBA(362.4,IBXRF,IBRXN))  Q:'IBRXN  D
 . S IBX=0 F  S IBX=$O(^IBA(362.4,IBXRF,IBRXN,IBX)) Q:'IBX  D
 .. S IBY=$G(^IBA(362.4,IBX,0)),IBRXIFN=$P(IBY,U,5),IBRXDT=$P(IBY,U,3) Q:'IBRXIFN
 .. D FPRX^IBEFURF(IBRXIFN,IBRXDT,IBIFN)
 ;
 ; find First Party Charges for any RX filled on one of the Third Party bill's Opt Visit Dates
 ; that is not billed on any Third Party bill
 S IBFROM=$G(^DGCR(399,IBIFN,"U")),IBTO=$P(IBFROM,U,2),IBFROM=+IBFROM K IBX
 D RXDISP^IBCSC5C(DFN,IBFROM,IBTO,.IBX,"","",1,1) ; get all Rx's for patient in date range
 S IBRXN="" F  S IBRXN=$O(IBX(IBRXN)) Q:IBRXN=""  S IBRXDT=0 F  S IBRXDT=$O(IBX(IBRXN,IBRXDT)) Q:'IBRXDT  D
 . I '$D(^DGCR(399,"AOPV",DFN,IBRXDT,IBIFN)) Q  ; rx not on bills opt visit date
 . I +$$RXTP^IBEFURT(DFN,IBRXN,IBRXDT) Q  ; rx billed on a third party bill
 . S IBRXIFN=$P(IBX(IBRXN,IBRXDT),U,1)
 . D FPRX^IBEFURF(IBRXIFN,IBRXDT,IBIFN)
 Q

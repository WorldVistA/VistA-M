IBCBB14 ;ALB/WCJ - CONTINUATION OF EDIT CHECK ROUTINE FOR EPHARM ;15 Mar 2018  9:50 PM
 ;;2.0;INTEGRATED BILLING;**591,592,624**;21-MAR-94;Build 10
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
VALNDC(IBIFN,IBDFN) ; IB*2*363 - validate NDC# between PRESCRIPTION file (#52)
 ; and IB BILL/CLAIMS PRESCRIPTION REFILL file (#362.4)
 ; input - IBIFN = internal entry number of the billing record in the BILL/CLAIMS file (#399)
 ;         IBDFN = internal entry number of patient record in the PATIENT file (#2)
 N IBX,IBRXCOL
 ; call program that determines if NDC differences exist
 D VALNDC^IBEFUNC3(IBIFN,IBDFN,.IBRXCOL)
 Q:'$D(IBRXCOL)
 ; at least one RX on the IB record has an NDC discrepancy 
 S IBX=0 F  S IBX=$O(IBRXCOL(IBX)) Q:'IBX  D WARN^IBCBB11("NDC# on Bill does not equal the NDC# on Rx "_IBRXCOL(IBX))
 Q
 ;
RXNPI(IBIFN) ; check for multiple pharmacy npi's on the same bill
 N IBORG,IBRXNPI,IBX,IBY
 S IBORG=$$RXSITE^IBCEF73A(IBIFN,.IBORG)
 S IBX=0 F  S IBX=$O(IBORG(IBX)) Q:'IBX  S IBY=0 F  S IBY=$O(IBORG(IBX,IBY)) Q:'IBY  S IBRXNPI(+IBORG(IBX,IBY))=""
 S (IBX,IBY)=0 F  S IBX=$O(IBRXNPI(IBX)) Q:'IBX  S IBY=IBY+1
 I IBY>1 D WARN^IBCBB11("Bill has prescriptions resulting from "_IBY_" different NPI locations")
 Q
 ;
ROICHK(IBIFN,IBDFN,IBINS) ; ROI Check
 ; Verify that an ROI is on file if the drug is flagged as sensitive.
 ; No ROI is required if the Date of Service is on or after the
 ; Mission Act Implementation Date (1/28/2019).
 ; input - IBIFN = IEN of the Bill/Claims file (#399)
 ;         IBDFN = IEN of the patient
 ;         IBINS = IEN of the payer insurance company (#36)
 ; OUTPUT - 0 = no error        
 ;          1 = a prescription is sensitive and there is no ROI on file
 ;
 N IBX,IBY0,IBRXIEN,IBDT,IBDRUG,ROIQ
 S ROIQ=0
 S IBX=0 F  S IBX=$O(^IBA(362.4,"C",IBIFN,IBX)) Q:'IBX  D
 .S IBY0=^IBA(362.4,IBX,0),IBRXIEN=$P(IBY0,U,5) I 'IBRXIEN Q
 .S IBDT=$P(IBY0,U,3),IBDRUG=$P(IBY0,U,4)
 .D ZERO^IBRXUTL(IBDRUG)
 .I $$SENS^IBNCPDR(IBDRUG) D  ; Sensitive Diagnosis Drug - check for ROI
 .. ; Skip ROI check if the DOS is on or after the Mission Act date.
 .. I $$MACHK^IBNCPDR4(IBDT) Q
 .. I $$ROI^IBNCPDR4(IBDFN,IBDRUG,IBINS,IBDT) Q  ;ROI is on file
 .. D WARN^IBCBB11("ROI not on file for prescription "_$$RXAPI1^IBNCPUT1(IBRXIEN,.01,"E"))
 .. S ROIQ=1
ROICHKQ ;
 K ^TMP($J,"IBDRUG")
 Q ROIQ
 ;

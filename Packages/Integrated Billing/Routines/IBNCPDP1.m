IBNCPDP1 ;OAK/ELZ - IB BILLING DETERMINATION PROCESSING FOR NEW RX REQUESTS ;5/22/08
 ;;2.0;INTEGRATED BILLING;**223,276,339,363,383,405,384,411,434,437,435,455,452,473,494,534,550**;21-MAR-94;Build 25
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Reference to CL^SDCO21 supported by IA# 406
 ; Reference to IN5^VADPT supported by IA# 10061
 ; Reference to $$MWC^PSOBPSU2 supported by IA# 4970
 ;
RX(DFN,IBD) ; pharmacy package call, passing in IBD by ref
 ; this is called by PSO for all prescriptions issued, return is
 ; a response to bill ECME or not with array for billing data elements
 ;
 ;warning: back-billing flag:
 ;if passed IBSCRES(IBRXN,IBFIL)=1
 ; - then the SC Determination is just done by the IB clerk (billable)
 ; - set by routine IBNCPBB
 ;
 ; IBD("PLAN") - is specified only if RX API is called for billing determination for 2ndary claim.
 ;
 ;clean up the list of non-answered SC/Env.indicators questions and INS
 K IBD("SC/EI NO ANSW"),IBD("INS")
 ;
 N IBTRKR,IBARR,IBADT,IBRXN,IBFIL,IBTRKRN,IBRMARK,IBANY,IBX,IBT,IBINS,IBSAVE,IBPRDATA,IBDISPFEE,IBADMINFEE
 N IBFEE,IBBI,IBIT,IBPRICE,IBRS,IBRT,IBTRN,IBCHG,IBRES,IBNEEDS,IBELIG,IBDEA,IBPTYP,IBACDUTY,IBINSXRES
 ;
 ; eligibility verification request flag - esg 9/9/10 IB*2*435
 S IBELIG=($G(IBD("RX ACTION"))="ELIG")
 ;
 I '$G(DFN) S IBRES="0^No DFN" G RXQ
 ;
 S IBRES="0^Error"
 S IBADT=+$G(IBD("DOS"),DT)      ; date of service (default to today)
 ;
 ; -- gather all active pharmacy insurance policies for patient on date of service
 D RXINS^IBNCPDPU(DFN,IBADT,.IBINS)
 ;
 ; -- determine rate type
 S IBRT=$$RT^IBNCPDPU(DFN,IBADT,.IBINS,.IBPTYP)
 ;
 ; If the rate type was selected by the user for manual primary or secondary claims processing, then update IBRT
 I $G(IBD("RTYPE")),$G(IBD("PLAN")) D
 . S $P(IBRT,U,1)=+IBD("RTYPE")                              ; overwrite the rate type ien [1]
 . S $P(IBRT,U,2)=$$COSTTYP^IBNCPUT3(+IBD("RTYPE"),IBADT)    ; overwrite the basis of cost determination [2]
 . I $P(IBRT,U,3)="" S $P(IBRT,U,3)=IBPTYP                   ; overwrite eligibility if null [3]
 . Q
 ;
 ; -- Process an eligibility verification request
 I IBELIG D  G RXQ
 . S IBRES=1
 . D SETINSUR(IBADT,IBRT,IBELIG,.IBINS,.IBD,.IBRES)
 . Q
 ;
 ; additional data integrity checks
 S IBRXN=+$G(IBD("IEN")) I 'IBRXN S IBRES="0^No Rx IEN" G RXQ
 S IBFIL=+$G(IBD("FILL NUMBER"),-1) I IBFIL<0 S IBRES="0^No fill number" G RXQ
 S IBD("QTY")=+$G(IBD("QTY")) I 'IBD("QTY") S IBRES="0^No Quantity" G RXQ
 ;
 ; -- Gather claims tracking information if it exists
 S IBTRKR=$G(^IBE(350.9,1,6))
 ; date can't be before parameters
 S $P(IBTRKR,U)=$S('$P(IBTRKR,U,4):0,+IBTRKR&(IBADT<+IBTRKR):0,1:IBADT)
 ; already in claims tracking
 S IBTRKRN=+$O(^IBT(356,"ARXFL",IBRXN,IBFIL,0))
 ;
 ; Gather and store insurance information in the IBD("INS") insurance array
 D SETINSUR(IBADT,IBRT,IBELIG,.IBINS,.IBD,.IBRES)
 I $G(IBD("NO ECME INSURANCE")) S IBINSXRES=$G(IBRES)      ; save IBRES when there are insurance errors
 ;
 ;for secondary billing - skip claim tracking functionality
 G:$G(IBD("RXCOB"))>1 GETINS
 ;
 ; -- claims tracking info
 I IBTRKRN,$$PAPERBIL^IBNCPNB(IBTRKRN) S IBRES="0^Existing IB Bill in CT",IBD("NO ECME INSURANCE")=1 G RXQ
 ;
 ; -- no pharmacy coverage, update ct if applicable, quit
 I '$$PTCOV^IBCNSU3(DFN,IBADT,"PHARMACY",.IBANY) S IBRMARK=$S($G(IBANY):"SERVICE NOT COVERED",1:"NOT INSURED") D:$P(IBTRKR,U,4)=2 CT S IBRES="0^"_IBRMARK,IBD("NO ECME INSURANCE")=1 G RXQ
 ;
 ; Environmental Indicators Validation
 ; Find out if the patient is Active Duty - IB*2*534
 S IBACDUTY=$P(IBRT,U,3)="T"&$$ACDUTY^IBNCPDPU(DFN)
 ; Retrieve indicators from file #52 and overwrite the indicators in IBD array
 D GETINDIC^IBNCPUT2(+IBD("IEN"),.IBD)
 ; Process patient exemptions if any and if not already resolved
 S IBNEEDS=0 ;flag will be set to 1 if at least one of the questions wasn't answered
 I $G(IBD("SC/EI OVR"))'=1,'IBACDUTY D
 . D CL^SDCO21(DFN,IBADT,"",.IBARR)
 . I $D(IBARR)>9 F IBX=2:1 S IBT=$P($T(EXEMPT+IBX),";;",2) Q:IBT=""  D:$D(IBARR(+IBT))
 . . I $G(IBD($P(IBT,U,2)))=0 Q
 . . I $G(IBD($P(IBT,U,2))) S IBRMARK=$P(IBT,U,3) Q
 . . I '$G(IBSCRES(IBRXN,IBFIL)) S IBNEEDS=1 D
 . . . S IBD("SC/EI NO ANSW")=$S($G(IBD("SC/EI NO ANSW"))="":$P(IBT,U,2),1:$G(IBD("SC/EI NO ANSW"))_","_$P(IBT,U,2))
 I '$D(IBRMARK),IBNEEDS=1 S IBRMARK="NEEDS SC DETERMINATION"
 I $D(IBRMARK) D CT S IBRES="0^"_IBRMARK G RXQ
 ;
 ;  -- check for drug billable
 I '$$BILLABLE^IBNCPDP($G(IBD("DRUG")),$P(IBRT,U,3),.IBRMARK,.IBD) S IBRES="0^"_IBRMARK D CT G RXQ
 ;
 ; -- check for sensitive diagnosis drug and ROI on file
 I $$SENS^IBNCPDR($G(IBD("DRUG")),.IBD),$D(IBD("INS",1,3)) D
 . I '$$ROI^IBNCPDR4(DFN,$G(IBD("DRUG")),+$P($G(IBD("INS",1,3)),U,5),IBADT) D  Q
 .. ;
 .. ; no active ROI found for patient/drug/insurance/DOS
 .. S IBRMARK="ROI NOT OBTAINED"
 .. S IBRES="0^NO ACTIVE/VALID ROI FOR DRUG OR INSURANCE"      ; PSO routine PSOREJU3 contains this text
 .. Q
 . ;
 . ; active ROI found, clear out RNB from Claims Tracking and variable IBRMARK
 . D ROICLN^IBNCPDR4(IBTRKRN,IBRXN,IBFIL)
 . I $G(IBRMARK)["ROI" K IBRMARK
 . Q
 I $D(IBRMARK) D CT G RXQ
 ;
 ; Clean-up the NEEDS SC DETERMINATION record if resolved
 ; And check if it is non-billable in CT
 I IBTRKRN D
 . N IBNBR,IBNBRT
 . S IBNBR=$P($G(^IBT(356,+IBTRKRN,0)),U,19) Q:'IBNBR
 . S IBNBRT=$P($G(^IBE(356.8,IBNBR,0)),U) Q:IBNBRT=""
 . ;
 . ; if refill was deleted (not RX) and now the refill is re-entered
 . ;use $$RXSTATUS^IBNCPRR instead of $G(^PSRX(IBRXN,"STA"))
 . I IBNBRT="PRESCRIPTION DELETED",$$RXSTATUS^IBNCPRR(DFN,IBRXN)'=13 D  Q
 . . N DIE,DA,DR
 . . ; clean up REASON NOT BILLABLE and ADDITIONAL COMMENT
 . . S DIE="^IBT(356,",DA=+IBTRKRN,DR=".19////@;1.08////@" D ^DIE
 . ;
 . ; Clean up NBR if released
 . I IBNBRT="PRESCRIPTION NOT RELEASED" D:$G(IBD("RELEASE DATE"))  Q
 . . N DIE,DA,DR
 . . S DIE="^IBT(356,",DA=+IBTRKRN,DR=".19////@" D ^DIE
 . ;
 . ; Clean up 'Needs SC determ'
 . I IBNBRT="NEEDS SC DETERMINATION" D  Q
 . . N DIE,DA,DR
 . . S DIE="^IBT(356,",DA=+IBTRKRN,DR=".19////@" D ^DIE
 . ;
 . ; Clean up 'DRUG NOT BILLABLE' since we made it through the $$BILLABLE function above - IB*2*550
 . I IBNBRT="DRUG NOT BILLABLE" D  Q
 .. N DIE,DA,DR
 .. S DIE="^IBT(356,",DA=+IBTRKRN,DR=".19////@;1.08////@" D ^DIE
 .. Q
 . ;
 . S IBRMARK=IBNBRT
 I $D(IBRMARK) S IBRES="0^Non-Billable in CT: "_IBRMARK G RXQ
 ;
GETINS ; -- examine the insurance data for a patient
 ;
 ; if insurance errors were detected earlier, then restore IBRES and get out
 I $G(IBD("NO ECME INSURANCE")) S IBRES=$G(IBINSXRES) G RXQ
 ;
RATEPRIC ; determine rates/prices to use
 ;
 I 'IBRT D CT S IBRES="0^Cannot determine Rate type" G RXQ
 S IBBI=$$EVNTITM^IBCRU3(+IBRT,3,"PRESCRIPTION FILL",IBADT,.IBRS)
 I 'IBBI,$P(IBBI,";")'="VA COST" D CT S IBRES="0^Cannot find Billable Item" G RXQ
 ;
 ; Check for missing NDC
 I $G(IBD("NDC"))="" D CT S IBRES="0^Missing NDC" G RXQ
 ;
 ;1;BEDSECTION;1^
 ;IBRS(1,18,5)=
 S IBRS=+$O(IBRS($P(IBBI,";"),0))
 S IBIT=$$ITPTR^IBCRU2($P(IBBI,";"),$S($P(IBRT,U,2)="A":$$NDC^IBNCPNB($G(IBD("NDC"))),1:"PRESCRIPTION"))
 I 'IBIT,$P(IBRT,U,2)'="C" D CT S IBRES="0^Cannot find Item Pointer" G RXQ
 ;8
 S IBPRICE=+$$BICOST^IBCRCI(+IBRT,3,IBADT,"PRESCRIPTION FILL",+IBIT,,,$S($P(IBRT,U,2)="A":IBD("QTY"),1:1))
 ;36^2991001
 ;
 ; return the true value of drug cost for 3rd party bill if it is zero
 I IBD("COST")=0,$P($G(^DGCR(399.3,+$P(IBRT,U,1),0)),U,5) S IBD("COST")=$$RXPCT(.IBD,.BWHERE)
 ;
 ; get fees if any, ignore return, don't care about price, just need fees
 S IBCHG=$$RATECHG^IBCRCC(+IBRS,$S($P(IBRT,U,2)'="C":1,1:IBD("QTY")*IBD("COST")),IBADT,.IBFEE)
 I $P(IBRT,U,2)="C" S IBPRICE=+IBCHG
 ;
 S IBDISPFEE=+$P($G(IBFEE),U,1)     ; dispensing fee
 S IBADMINFEE=+$P($G(IBFEE),U,2)    ; administrative fee
 ;
 I 'IBPRICE D CT S IBRES="0^Cannot find price for Item" G RXQ
 ;
 ; build pricing data string
 S IBPRDATA=""
 S $P(IBPRDATA,U,1)=IBDISPFEE                     ; dispensing fee
 S $P(IBPRDATA,U,2)=$S($P(IBRT,U,2)="A":"01",$P(IBRT,U,2)="C":"05",1:"07")   ; basis of cost determination
 S $P(IBPRDATA,U,3)=$S($P(IBRT,U,2)="C":IBD("QTY")*IBD("COST")+IBDISPFEE,$P(IBRT,U,2)="A":IBPRICE-IBDISPFEE-IBADMINFEE,1:IBPRICE)   ; basis of cost amount
 S $P(IBPRDATA,U,4)=IBPRICE                       ; gross amount due
 S $P(IBPRDATA,U,5)=IBADMINFEE                    ; administrative fee
 S $P(IBPRDATA,U,6)=IBD("QTY")*IBD("COST")        ; ingredient cost
 S $P(IBPRDATA,U,7)=IBPRICE-IBADMINFEE            ; usual & customary charge (U&C)
 ;
 ; store the pricing data string on each node 2 that may exist
 S IBX=0 F  S IBX=$O(IBD("INS",IBX)) Q:'IBX  S IBD("INS",IBX,2)=IBPRDATA
 ;
 S IBRES=$S($D(IBRMARK):"0^"_IBRMARK,1:1)
 I IBRES,'$G(IBD("RELEASE DATE")) S IBRMARK="PRESCRIPTION NOT RELEASED"
 ;
 D CT
 ;
RXQ ; final processing
 ; set the 3rd piece of IBRES (default Vet)
 S $P(IBRES,U,3)=$S($L($P($G(IBRT),U,3)):$P(IBRT,U,3),1:"V")
 ;
 ; possibly add entries to files 366.14 and 366.15 (not for eligibility verification requests)
 I 'IBELIG D
 . I IBRES D START^IBNCPDP6(IBRXN_";"_IBFIL,$P(IBRES,U,3),+IBRT)
 . D LOG^IBNCPDP2("BILLABLE STATUS CHECK",IBRES)
 . Q
 ;
 Q IBRES
 ;
 ;
CT ; files in claims tracking
 Q:$G(IBD("RXCOB"))>1  ;Claim Tracking is updated only for the primary payer (payer sequence =1)
 ;If null then the payer sequence = Primary is assumed
 I IBTRKR D CT^IBNCPDPU(DFN,IBRXN,IBFIL,IBADT,$G(IBRMARK))
 Q
 ;
SETINSUR(IBADT,IBRT,IBELIG,IBINS,IBD,IBRES) ; build insurance data array
 ; Input variables:
 ;    IBADT - date of service/identify insurance as of this date
 ;     IBRT - rate type variable - [1] rate type ien, [2] type (A/C/T), [3] eligibility (V/T/C)
 ;   IBELIG - eligibility request flag (1/0)
 ;    IBINS - insurance array as returned by RXINS^IBNCPDPU
 ;      IBD - input/output - array entries passed in and certain array entries returned
 ; Output variable:
 ;    IBRES - only returned if insurance errors
 ;
 ; Note: if more than one insurance with the same COB then the latest insurance occurrence overrides the first one(s)
 ; Example:
 ; IBINS("S",1,1)=""
 ; IBINS("S",1,3)="" <<--- this will be primary
 ;
 K IBD("INS"),IBD("NO ECME INSURANCE")
 ;
 N IBCNT,IBERMSG,IBRXPOL,IBT,IBX
 ; IBERMSG - error message array
 ; IBRXPOL - array of Rx policies found
 ;
 S IBX=0 F  S IBX=$O(IBINS("S",IBX)) Q:'IBX  D
 . S IBT=0 F  S IBT=$O(IBINS("S",IBX,IBT)) Q:'IBT  D
 .. N IBDAT,IBPL,IBINSN,IBPIEN,IBY,IBZ,IBCHNM,IBREL,IBPLNTYP
 .. S IBZ=$G(IBINS(IBT,0)) Q:IBZ=""
 .. S IBPL=$P(IBZ,U,18) ; plan
 .. Q:'IBPL
 .. Q:'$$PLCOV^IBCNSU3(IBPL,IBADT,3)           ; not a pharmacy plan
 .. I $G(IBD("PLAN")) Q:IBPL'=$G(IBD("PLAN"))  ; skip other plans if we call RX API for a specific plan (IBD("PLAN"))
 .. ;
 .. ; at this point we have found an Rx policy.  We'll count these up later by IBX.
 .. S IBRXPOL(IBX,IBT)=""
 .. ;
 .. S IBPLNTYP=$P($G(^IBE(355.1,+$P($G(IBINS(IBT,355.3)),U,9),0)),U,1)   ; type of plan name, insurance plan type
 .. I '$G(IBD("PLAN")) I '$D(IBD("INS",IBX)),$P(IBRT,U,3)="V",(IBPLNTYP["TRICARE"!(IBPLNTYP="CHAMPVA")) S IBERMSG(IBX)=IBPLNTYP_" coverage for a Veteran" Q
 .. ;
 .. S IBPIEN=+$G(^IBA(355.3,+IBPL,6))
 .. I 'IBPIEN S IBERMSG(IBX)="Plan not linked to the Payer" Q  ; Not linked
 .. ;
 .. K IBY D STCHK^IBCNRU1(IBPIEN,.IBY,IBELIG)
 .. I $E($G(IBY(1)))'="A" S IBERMSG(IBX)=$$ERMSG^IBNCPNB($G(IBY(6))) Q  ; not active
 .. ;
 .. ; at this point we have a valid policy for this IBX
 .. S IBERMSG(IBX)=""          ; no error message
 .. S IBINSN=$P($G(^DIC(36,+$G(^IBA(355.3,+IBPL,0)),0)),U) ; ins name
 .. S IBCHNM=$$NAME^IBCEFG1($P(IBZ,U,17))   ; standardize subscriber/cardholder name
 .. S IBREL=+$P($G(IBINS(IBT,4)),U,5)       ; pointer to pharmacy relationship code file
 .. ; use the #4.05 field if it exists, otherwise use the old pt relationship field #16
 .. S IBREL=$S(IBREL:$$EXTERNAL^DILFD(2.312,4.05,,IBREL),1:$P(IBZ,U,16))
 .. ;
 .. S IBDAT=""
 .. S $P(IBDAT,U,1)=IBPL       ; Plan IEN
 .. S $P(IBDAT,U,2)=$G(IBY(2)) ; BIN
 .. S $P(IBDAT,U,3)=$G(IBY(3)) ; PCN
 .. S $P(IBDAT,U,4)=$P($G(^BPSF(9002313.92,+$P($G(IBY(5)),",",1),0)),U) ; Payer Sheet B1 name
 .. S $P(IBDAT,U,5)=$P($G(IBINS(IBT,355.3)),U,4) ; Group ID
 .. S $P(IBDAT,U,6)=$P(IBZ,U,2)     ; Cardholder ID
 .. S $P(IBDAT,U,7)=IBREL           ; Patient Relationship Code
 .. S $P(IBDAT,U,8)=$P(IBCHNM,U,2)  ; Cardholder First Name
 .. S $P(IBDAT,U,9)=$P(IBCHNM,U,1)  ; Cardholder Last Name
 .. S $P(IBDAT,U,10)=$P($G(^DIC(36,+IBZ,.11)),U,5) ; State
 .. S $P(IBDAT,U,11)=$P($G(^BPSF(9002313.92,+$P($G(IBY(5)),",",2),0)),U) ; Payer Sheet B2 name
 .. S $P(IBDAT,U,12)=$P($G(^BPSF(9002313.92,+$P($G(IBY(5)),",",3),0)),U) ; Payer Sheet B3 name
 .. S $P(IBDAT,U,13)=$G(IBY(4)) ; Software/Vendor Cert ID
 .. S $P(IBDAT,U,14)=IBINSN ; Ins Name
 .. S $P(IBDAT,U,15)=$P($G(^BPSF(9002313.92,+$P($G(IBY(5)),",",4),0)),U) ; Payer Sheet E1 name
 .. S $P(IBDAT,U,16)=+$P($G(IBY(5)),",",1)     ; Payer Sheet B1 ien
 .. S $P(IBDAT,U,17)=+$P($G(IBY(5)),",",2)     ; Payer Sheet B2 ien
 .. S $P(IBDAT,U,18)=+$P($G(IBY(5)),",",3)     ; Payer Sheet B3 ien
 .. S $P(IBDAT,U,19)=+$P($G(IBY(5)),",",4)     ; Payer Sheet E1 ien
 .. S $P(IBDAT,U,20)=$P($G(IBINS(IBT,4)),U,6)  ; Pharmacy Person Code
 .. S IBD("INS",IBX,1)=IBDAT
 .. ;
 .. S IBDAT=""
 .. S $P(IBDAT,U,1)=$P($G(IBINS(IBT,355.3)),U,3) ;group name
 .. S $P(IBDAT,U,2)=$$PHONE^IBNCPDP6(+IBZ) ;ins co ph 3
 .. S $P(IBDAT,U,3)=$$GET1^DIQ(366.03,IBPIEN_",",.01) ;plan ID
 .. S $P(IBDAT,U,4)=$S(IBPLNTYP="TRICARE":"T",IBPLNTYP="CHAMPVA":"C",1:"V") ; plan type
 .. S $P(IBDAT,U,5)=+$G(^IBA(355.3,+IBPL,0)) ; insurance co ien
 .. S $P(IBDAT,U,6)=$P(IBZ,U,20) ;(#.2) COB field of the (#.3121) insurance Type multiple of the Patient file (#2)
 .. S $P(IBDAT,U,7)=IBT  ; 2.312 subfile ien
 .. S $P(IBDAT,U,8)=$$GET1^DIQ(366.03,IBPIEN_",",10.1) ; maximum ncpdp transactions
 .. S IBD("INS",IBX,3)=IBDAT
 .. Q
 . Q
 ;
 ; Count the number of pharmacy insurance policies by IBX found up above
 S IBX=0 F IBCNT=0:1 S IBX=$O(IBRXPOL(IBX)) Q:'IBX
 ;
 ; Determine the value of the IBX variable here.  This is basically the COB sequence# to be used.
 ; If there is only 1 pharmacy policy or no pharmacy policies, then set IBX in this manner
 I IBCNT'>1 D
 . I $D(IBD("INS")) S IBX=+$O(IBD("INS",0))     ; use the only one in this array
 . I '$D(IBD("INS")) S IBX=+$O(IBERMSG(0))      ; the only one here (or 0)
 . Q
 ;
 ; If there are multiple pharmacy policies on file, then the COB field in the pt. policy must be used correctly
 ;   and primary insurance must be at #1
 I IBCNT>1 S IBX=1
 ;
 ; In all cases, if this variable is set, then use it
 I $G(IBD("RXCOB"))>1 S IBX=$G(IBD("RXCOB"))
 ;
 ; Check insurance at IBX
 I '$D(IBD("INS",IBX)),$G(IBERMSG(IBX))'="" S IBRES="0^Not ECME billable: "_IBERMSG(IBX),IBD("NO ECME INSURANCE")=1 G SETINX
 I '$D(IBD("INS",IBX)) S IBRES="0^No Insurance ECME billable",IBD("NO ECME INSURANCE")=1
SETINX ;
 Q
 ;
RXPCT(IBD,BWHERE) ; Penny drug cost calculation
 ; Input-IBD array, BWHERE
 ; Output-return quotient of drug true value with 4 decimal places, or 0
 N IBDIEN,IBDRX,IBNDC,IBFRM,IBDRFL,IBUNIT,IBSYN,IBQUO,IBDQUO,IBPSUF,IBPORD,IBPDISP,IBDRUG
 S IBDIEN=IBD("IEN"),IBNDC=IBD("NDC"),IBDRX=IBD("DRUG"),IBDRFL=IBD("FILL NUMBER")
 S IBFRM=$G(BWHERE),IBQUO=0
 G:'IBDRX RXPCTQ
 ; default unit price from (50-13/15)
 D GETS^DIQ(50,IBDRX,".01;13;15","I","IBUNIT")
 S IBPORD=$G(IBUNIT(50,IBDRX_",",13,"I"))
 S IBPDISP=$G(IBUNIT(50,IBDRX_",",15,"I"))
 S (IBDQUO,IBQUO)=$S(IBPORD&IBPDISP:(IBPORD/IBPDISP),1:0)
 ;
 ; unit price from (50.1-402/403) if NDC exists in the SYNONYM subfile
 D DATA^IBRXUTL(IBDRX)
 S IBSYN=0 F  S IBSYN=$O(^TMP($J,"IBDRUG",IBDRX,"SYN",IBSYN)) Q:'IBSYN  D
 . I IBNDC'="",$G(^TMP($J,"IBDRUG",IBDRX,"SYN",IBSYN,2))=IBNDC D
 .. S IBPSUF=IBSYN_","_IBDRX_","
 .. D GETS^DIQ(50.1,IBPSUF,".01;402;403","I","IBUNIT")
 .. S IBPORD=$G(IBUNIT(50.1,IBPSUF,402,"I"))
 .. S IBPDISP=$G(IBUNIT(50.1,IBPSUF,403,"I"))
 .. S IBQUO=$S(IBPORD&IBPDISP:(IBPORD/IBPDISP),1:0)
 ;
 ; API #4970 - use the default unit price for CMOP
 I $$MWC^PSOBPSU2(IBDIEN,IBDRFL)="C" D
 . Q:(IBFRM="PE")!(IBFRM="PP")
 . S IBQUO=IBDQUO
 ; set the lowest value 0.0001 with 4 decimal if less than 0.00005
 I IBQUO S IBQUO=$J(IBQUO,1,4),IBQUO=$S(IBQUO>0:IBQUO,1:"0.0001")
 K ^TMP($J,"IBDRUG")
RXPCTQ ;
 Q IBQUO
 ;
EXEMPT ; exemption reasons
 ; variable from SD call ^ variable from PSO ^ reason not billable
 ;;1^AO^AGENT ORANGE
 ;;2^IR^IONIZING RADIATION
 ;;3^SC^SC TREATMENT
 ;;4^SWA^SOUTHWEST ASIA
 ;;5^MST^MILITARY SEXUAL TRAUMA
 ;;6^HNC^HEAD/NECK CANCER
 ;;7^CV^COMBAT VETERAN
 ;;8^SHAD^PROJECT 112/SHAD
 ;;
 ;

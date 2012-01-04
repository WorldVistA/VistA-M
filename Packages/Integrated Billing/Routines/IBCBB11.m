IBCBB11 ;ALB/AAS/OIFO-BP/PIJ - CONTINUATION OF EDIT CHECK ROUTINE ;12 Jun 2006  3:45 PM
 ;;2.0;INTEGRATED BILLING;**51,343,363,371,395,392,401,384,400,436,432**;21-MAR-94;Build 192
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
WARN(IBDISP) ; Set warning in global
 ; DISP = warning text to display
 ;
 N Z
 S Z=+$O(^TMP($J,"BILL-WARN",""),-1)
 I Z=0 S ^TMP($J,"BILL-WARN",1)=$J("",5)_"**Warnings**:",Z=1
 S Z=Z+1,^TMP($J,"BILL-WARN",Z)=$J("",5)_IBDISP
 Q
 ;
MULTDIV(IBIFN,IBND0) ; Check for multiple divisions on a bill ien IBIFN
 ; IBND0 = 0-node of bill
 ;
 ;  Function returns 1 if more than 1 division found on bill
 N Z,Z0,Z1,MULT
 S MULT=0,Z1=$P(IBND0,U,22)
 I Z1 D
 . S Z=0 F  S Z=$O(^DGCR(399,IBIFN,"RC",Z)) Q:'Z  S Z0=$P(^(Z,0),U,7) I Z0,Z0'=Z1 S MULT=1 Q
 . S Z=0 F  S Z=$O(^DGCR(399,IBIFN,"CP",Z)) Q:'Z  S Z0=$P(^(Z,0),U,6) I Z0,Z0'=Z1 S MULT=2 Q
 I 'Z1 S MULT=3
 Q MULT
 ;
 ;; PREGNANCY DX CODES: V22**-V24**, V27**-V28**, 630**-677**
 ;; FLU SHOTS PROCEDURE CODES: 90724, G0008, 90732, G0009
 ;
NPICHK ; Check for required NPIs
 N IBNPIS,IBNONPI,IBNPIREQ,Z,IBNFI,IBTF,IBWC,IBXSAVE,IBPRV,IBLINE
 ;*** pij start IB*20*436 ***
 N IBRATYPE,IBLEGAL
 S (IBRATYPE,IBLEGAL)=""
 S IBRATYPE=$P($G(^DGCR(399,IBIFN,0)),U,7)
 ; Legal types for this use.
 ;  7=NO FAULT INS.
 ; 10=TORT FEASOR
 ; 11=WORKERS' COMP.
 S IBNFI=$O(^DGCR(399.3,"B","NO FAULT INS.",0)) S:'IBNFI IBNFI=7
 S IBTF=$O(^DGCR(399.3,"B","TORT FEASOR",0)) S:'IBTF IBTF=10
 S IBWC=$O(^DGCR(399.3,"B","WORKERS' COMP.",0)) S:'IBWC IBWC=11
 ;
 I IBRATYPE=IBNFI!(IBRATYPE=IBTF)!(IBRATYPE=IBWC) D
 . ; One of the legal types - force local print
 . S IBLEGAL=1
 ;*** pij end ***
 S IBNPIREQ=$$NPIREQ^IBCEP81(DT)  ; Check if NPI is required
 ; Check providers
 ; IB*2.0*432 changed the NPI check to the new Provider Array
 ;S IBNPIS=$$PROVNPI^IBCEF73A(IBIFN,.IBNONPI)
 D ALLIDS^IBCEFP(IBIFN,.IBXSAVE,1)
 S IBPRV=""
 F  S IBPRV=$O(IBXSAVE("PROVINF",IBIFN,"C",1,IBPRV)) Q:'IBPRV  D
 . I $P($G(IBXSAVE("PROVINF",IBIFN,"C",1,IBPRV,0)),U,4)="" S IBNONPI(IBPRV)=""
 S IBLINE=""
 F  S IBLINE=$O(IBXSAVE("L-PROV",IBIFN,IBLINE)) Q:'IBLINE  D
 . S IBPRV=""
 . F  S IBPRV=$O(IBXSAVE("L-PROV",IBIFN,IBLINE,"C",1,IBPRV)) Q:IBPRV=""  D
 .. I $P($G(IBXSAVE("L-PROV",IBIFN,IBLINE,"C",1,IBPRV,0)),U,4)="" S IBNONPI(IBPRV)=""
 I $D(IBNONPI) S IBPRV="" F  S IBPRV=$O(IBNONPI(IBPRV)) Q:'IBPRV  D
 . ;*** pij start IB*20*436 ***
 . ;I IBNPIREQ S IBER=IBER_"IB"_(140+$P(IBNONPI,U,Z))_";" Q  ; If required, set error
 . I IBNPIREQ,IBLEGAL="" S IBER=IBER_"IB"_(140+IBPRV)_";" Q  ; If required, set error
 . ; ;*** pij end ***
 . D WARN("NPI for the "_$P("referring^operating^rendering^attending^supervising^^^^other",U,IBPRV)_" provider has no value")  ; Else, set warning
 ; Check organizations
 S IBNONPI=""
 S IBNPIS=$$ORGNPI^IBCEF73A(IBIFN,.IBNONPI)
 I $L(IBNONPI) F Z=1:1:$L(IBNONPI,U) D
 . ; Turn IB161, IB162 to a warning
 . ;*** pij start IB*20*436 ***
 . ;I IBNPIREQ,$P(IBNONPI,U,Z)=3 S IBER=IBER_"IB163;" Q
 . I IBNPIREQ,$P(IBNONPI,U,Z)=3,IBLEGAL="" S IBER=IBER_"IB163;" Q
 . ;*** pij end ***
 . ; PRXM/KJH - Changed descriptions.
 . D WARN("NPI for the "_$P("Service Facility^Non-VA Service Facility^Billing Provider",U,$P(IBNONPI,U,Z))_" has no value")  ; Else, set warning
 . ;S IBER=IBER_$P("IB339;^IB340;^IB341;",U,$P(IBNONPI,U,Z))  ; DEM;432 Added NPI errors.
 . ;IB*2.0*432/TAZ - Removed fatal error for Non-VA Service Facility NPI.
 . S IBER=IBER_$P("IB339;^^IB341;",U,$P(IBNONPI,U,Z))
 . Q
 Q
 ;
TAXCHK ; Check for required taxonomies
 N IBTAXS,IBNOTAX,IBTAXREQ,Z,IBXSAVE,IBLINE,IBPRV
 S IBTAXREQ=$$TAXREQ^IBCEP81(DT)  ; Check if taxonomy is required
 ; Check providers
 ; IB*2.0*432 changed the Taxonomy check to the new Provider Array
 ;S IBTAXS=$$PROVTAX^IBCEF73A(IBIFN,.IBNOTAX)
 D ALLIDS^IBCEFP(IBIFN,.IBXSAVE,1)
 S IBPRV=""
 F  S IBPRV=$O(IBXSAVE("PROVINF",IBIFN,"C",1,IBPRV)) Q:'IBPRV  D
 . I $G(IBXSAVE("PROVINF",IBIFN,"C",1,IBPRV,"TAXONOMY"))="" S IBNOTAX(IBPRV)=""
 S IBLINE=""
 F  S IBLINE=$O(IBXSAVE("L-PROV",IBIFN,IBLINE)) Q:'IBLINE  D
 . S IBPRV=""
 . F  S IBPRV=$O(IBXSAVE("L-PROV",IBIFN,IBLINE,"C",1,IBPRV)) Q:IBPRV=""  D
 .. I $G(IBXSAVE("L-PROV",IBIFN,IBLINE,"C",1,IBPRV,"TAXONOMY"))="" S IBNOTAX(IBPRV)=""
 I $D(IBNOTAX) S IBPRV="" F  S IBPRV=$O(IBNOTAX(IBPRV)) Q:'IBPRV  D
 . ; Only Referring, Rendering and Attending are currently sent to the payer
 . I IBTAXREQ,"134"[IBPRV S IBER=IBER_"IB"_(250+IBPRV)_";" Q  ; If required, set error
 . D WARN("Taxonomy for the "_$P("referring^operating^rendering^attending^supervising^^^^other",U,IBPRV)_" provider has no value")  ; Else, set warning
 ; Check organizations
 S IBNOTAX=""
 S IBTAXS=$$ORGTAX^IBCEF73A(IBIFN,.IBNOTAX)
 I $L(IBNOTAX) F Z=1:1:$L(IBNOTAX,U) D
 . ; Turn IB165, IB166 to a warning
 . I IBTAXREQ,$P(IBNOTAX,U,Z)=3 S IBER=IBER_"IB167;" Q
 . ; PRXM/KJH - Changed descriptions.
 . D WARN("Taxonomy for the "_$P("Service Facility^Non-VA Service Facility^Billing Provider",U,$P(IBNOTAX,U,Z))_" has no value")  ; Else, set warning
 Q
 ;
VALNDC(IBIFN,IBDFN) ; IB*2*363 - validate NDC# between PRESCRIPTION file (#52)
 ; and IB BILL/CLAIMS PRESCRIPTION REFILL file (#362.4)
 ; input - IBIFN = internal entry number of the billing record in the BILL/CLAIMS file (#399)
 ;         IBDFN = internal entry number of patient record in the PATIENT file (#2)
 N IBX,IBRXCOL
 ; call program that determines if NDC differences exist
 D VALNDC^IBEFUNC3(IBIFN,IBDFN,.IBRXCOL)
 Q:'$D(IBRXCOL)
 ; at least one RX on the IB record has an NDC discrepancy 
 S IBX=0 F  S IBX=$O(IBRXCOL(IBX)) Q:'IBX  D WARN("NDC# on Bill does not equal the NDC# on Rx "_IBRXCOL(IBX))
 Q
 ;
PRIIDCHK ; Check for required Pimarary ID (SSN/EIN)
 ; If the provider is on the claim, he must have one
 ; 
 N IBI,IBZ
 I $$TXMT^IBCEF4(IBIFN) D
 . D F^IBCEF("N-ALL ATT/REND PROV SSN/EI","IBZ",,IBIFN)
 . S IBI="" F  S IBI=$O(^DGCR(399,IBIFN,"PRV","B",IBI)) Q:IBI=""  D
 .. I $P(IBZ,U,IBI)="" S IBER=IBER_$S(IBI=1:"IB151;",IBI=2:"IB152;",IBI=3!(IBI=4):"IB321;",IBI=5:"IB153;",IBI=9:"IB154;",1:"")
 Q
 ;
RXNPI(IBIFN) ; check for multiple pharmacy npi's on the same bill
 N IBORG,IBRXNPI,IBX,IBY
 S IBORG=$$RXSITE^IBCEF73A(IBIFN,.IBORG)
 S IBX=0 F  S IBX=$O(IBORG(IBX)) Q:'IBX  S IBY=0 F  S IBY=$O(IBORG(IBX,IBY)) Q:'IBY  S IBRXNPI(+IBORG(IBX,IBY))=""
 S (IBX,IBY)=0 F  S IBX=$O(IBRXNPI(IBX)) Q:'IBX  S IBY=IBY+1
 I IBY>1 D WARN("Bill has prescriptions resulting from "_IBY_" different NPI locations")
 Q
 ;
ROICHK(IBIFN,IBDFN,IBINS) ; IB*2.0*384 - check prescriptions that contain the
 ; special handling code U against the Claims Tracking ROI file (#356.25)
 ; to see if an ROI is on file
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
 .I ^TMP($J,"IBDRUG",IBDRUG,3)["U" D
 .. I $$ROI^IBNCPDR4(IBDFN,IBDRUG,IBINS,IBDT) Q  ;ROI is on file
 .. D WARN("ROI not on file for prescription "_$$RXAPI1^IBNCPUT1(IBRXIEN,.01,"E"))
 .. S ROIQ=1
ROICHKQ ;
 K ^TMP($J,"IBDRUG")
 Q ROIQ
 ;
AMBCK(IBIFN)    ; IB*2.0*432 - if ambulance location defined, address must be defined
 ; if there is anything entered in any of the address fields (either p/up or drop/off fields), than there needs to be: 
 ; Address 1, State and ZIP unless the State is not a US state or possession, then zip code is not needed (CMS1500 only)
 ; input - IBIFN = IEN of the Bill/Claims file (#399)
 ; OUTPUT - 0 = no error        
 ;          1 = Error
 ;
 N IBPAMB,IBDAMB,IBAMBR,IBCK
 S IBAMBR=0
 Q:$$INSPRF^IBCEF(IBIFN)'=0 IBAMBR
 S IBPAMB=$G(^DGCR(399,IBIFN,"U5")),IBDAMB=$G(^DGCR(399,IBIFN,"U6"))
 S IBCK(5)=$$NOPUNCT^IBCEF($P(IBPAMB,U,2,6),1),IBCK(6)=$$NOPUNCT^IBCEF($P(IBDAMB,U,1,6),1)
 I IBCK(5)="",IBCK(6)="" Q IBAMBR
 ; at this point we know that at least one ambulance field has data, so check to see if all have data
 I IBCK(5)'="" F I=2,4,5 I $P(IBPAMB,U,I)="" S IBAMBR=1
 I IBCK(6)'="" F I=1,2,4,5 I $P(IBDAMB,U,I)="" S IBAMBR=1
 Q:IBAMBR=1 IBAMBR
 ; now check zip code.  OK to be null if state is not a US Posession
 F I="IBPAMB","IBDAMB" I $P(I,U,5)'="",$P($G(^DIC(5,$P(I,U,5),0)),U,6)=1,$P(I,U,6)="" S IBAMBR=1
 Q IBAMBR
 ;
COBAMT(IBIFN)   ; IB*2.0*432 - IF there is a COB amt. it must equal the Total Claim Charge Amount
 ; input - IBIFN = IEN of the Bill/Claims file (#399)
 ; OUTPUT - 0 = no error        
 ;          1 = Error
 ;
 Q:IBIFN="" 0
 Q:$P($G(^DGCR(399,IBIFN,"U4")),U)="" 0
 Q:+$P($G(^DGCR(399,IBIFN,"U1")),U)'=+$P($G(^DGCR(399,IBIFN,"U4")),U) 1
 Q 0
 ;
COBMRA(IBIFN)   ; IB*2.0*432 - If there is a 'COB total non-covered amount' (File#399, Field#260), 
 ; Primary Insurance must be Medicare that never went to Medicare, and this must be a 2ndary or tertiary claim
 ; input - IBIFN = IEN of the Bill/Claims file (#399)
 ; OUTPUT - 0 = no error        
 ;          1 = Error
 ;
 N IBP
 Q:IBIFN="" 0
 Q:$P($G(^DGCR(399,IBIFN,"U4")),U)="" 0
 S IBP=$P($G(^DGCR(399,IBIFN,"M1")),U,5) S:IBP="" IBP=IBIFN
 I $$WNRBILL^IBEFUNC(IBIFN,1),$P($G(^DGCR(399,IBP,"S")),U,7)="",$$COBN^IBCEF(IBIFN)>1 Q 0
 Q 1
 ;
COBSEC(IBIFN)   ; IB*2.0*432 - If there is NOT a 'COB total non-covered amount' (File#399, Field#260), 
 ; and Primary Insurance is Medicare that never went to Medicare, 2ndary or tertiary claim cannot be set to transmit
 ; input - IBIFN = IEN of the Bill/Claims file (#399)
 ; OUTPUT - 0 = no error        
 ;          1 = Error
 ;
 N IBP
 Q:IBIFN="" 0
 Q:$P($G(^DGCR(399,IBIFN,"U4")),U)'="" 0
 Q:$$COBN^IBCEF(IBIFN)<2 0
 S IBP=$P($G(^DGCR(399,IBIFN,"M1")),U,5) S:IBP="" IBP=IBIFN
 I $$WNRBILL^IBEFUNC(IBIFN,1),$P($G(^DGCR(399,IBP,"S")),U,7)="",$P($G(^DGCR(399,IBIFN,"TX")),U,8)'=1 Q 1
 Q 0
 ;
TMCK(IBIFN) ;  IB*2.0*432 - Attachment Control Number - REQUIRED when Transmission Method = BM, EL, EM, or FT
 ; input - IBIFN = IEN of the Bill/Claims file (#399)
 ; OUTPUT - 0 = no error        
 ;          1 = Error
 ;
 N IBAC
 Q:IBIFN="" 0
 F I=1,3 S IBAC(I)=$P($G(^DGCR(399,IBIFN,"U8")),U,I)
 Q:IBAC(3)="" 0
 Q:IBAC(1)'="" 0
 Q:IBAC(3)="AA" 0
 Q 1
 ;
ACCK(IBIFN) ; IB*2.0*432 If any of the loop info is present, then Report Type & Transmission Method req'd
 ; input - IBIFN = IEN of the Bill/Claims file (#399)
 ; OUTPUT - 0 = no error        
 ;          1 = Error
 ;
 N IBAC
 Q:IBIFN="" 0
 F I=1:1:3 S IBAC(I)=$P($G(^DGCR(399,IBIFN,"U8")),U,I)
 ; All fields null, no error
 I IBAC(1)="",IBAC(2)="",IBAC(3)="" Q 0
 ; Both required fields complete, no error
 I IBAC(2)'="",IBAC(3)'="" Q 0
 ; At this point, one of the 2 required fields has data and one does not, so error
 Q 1
 ;
LNTMCK(IBIFN) ;  DEM;IB*2.0*432 - (Line Level) Attachment Control Number - REQUIRED when Transmission Method = BM, EL, EM, or FT
 ; input - IBIFN = IEN of the Bill/Claims file (#399)
 ; OUTPUT - IBLNERR = 0 = no error        
 ;          IBLNERR = 1 = Error
 ;
 N IBAC,IBPROCP,I,IBLNERR
 S IBLNERR=0  ; DEM;432 - Initialize error flag IBLNERR to '0' for no errors.
 Q:IBIFN="" IBLNERR
 S IBPROCP=0 F  S IBPROCP=$O(^DGCR(399,IBIFN,"CP",IBPROCP)) Q:'IBPROCP  D  Q:IBLNERR
 . Q:'($D(^DGCR(399,IBIFN,"CP",IBPROCP,0))#10)  ; DEM;432 - Node '0' is procedure node.
 . Q:'($D(^DGCR(399,IBIFN,"CP",IBPROCP,1))#10)  ; DEM;432 - Node '1' is line level Attachment Control fields.
 . F I=1,3 S IBAC(I)=$P(^DGCR(399,IBIFN,"CP",IBPROCP,1),U,I)
 . I IBAC(3)="" S IBLNERR=0 Q
 . I IBAC(1)'="" S IBLNERR=0 Q
 . I (IBAC(3)="AA") S IBLNERR=0 Q
 . S IBLNERR=1
 . Q
 ;
 Q IBLNERR
 ;
LNACCK(IBIFN) ; DEM;IB*2.0*432 (Line Level) If any of the loop info is present, then Report Type & Transmission Method req'd
 ; input - IBIFN = IEN of the Bill/Claims file (#399)
 ; OUTPUT - IBLNERR = 0 = no error        
 ;          IBLNERR = 1 = Error
 ;
 N IBAC,IBPROCP,I,IBLNERR
 S IBLNERR=0  ; DEM;432 - Initialize error flag IBLNERR to '0' for no errors.
 Q:IBIFN="" IBLNERR
 S IBPROCP=0 F  S IBPROCP=$O(^DGCR(399,IBIFN,"CP",IBPROCP)) Q:'IBPROCP  D  Q:IBLNERR
 . Q:'($D(^DGCR(399,IBIFN,"CP",IBPROCP,0))#10)  ; DEM;432 - Node '0' is procedure node.
 . Q:'($D(^DGCR(399,IBIFN,"CP",IBPROCP,1))#10)  ; DEM;432 - Node '1' is line level Attachment Control fields.
 . F I=1:1:3 S IBAC(I)=$P(^DGCR(399,IBIFN,"CP",IBPROCP,1),U,I)
 . ; All fields null, no error
 . I IBAC(1)="",IBAC(2)="",IBAC(3)="" S IBLNERR=0 Q
 . ; Both required fields complete, no error
 . I IBAC(2)'="",IBAC(3)'="" S IBLNERR=0 Q
 . ; At this point, one of the 2 required fields has data and one does not, so error
 . S IBLNERR=1
 . Q
 ;
 Q IBLNERR

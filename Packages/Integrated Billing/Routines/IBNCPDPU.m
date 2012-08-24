IBNCPDPU ;OAK/ELZ - UTILITIES FOR NCPCP ;5/22/08  15:24
 ;;2.0;INTEGRATED BILLING;**223,276,347,383,405,384,437,435,452**;21-MAR-94;Build 26
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;Reference to ECMEACT^PSOBPSU1 supported by IA# 4702
 ;Reference to $$EN^BPSNCPDP supported by IA# 4415
 ;Reference to $$NABP^BPSBUTL supported by IA# 4719
 ;
 ;
CT(DFN,IBRXN,IBFIL,IBADT,IBRMARK) ; files in claims tracking
 ; Input:
 ;  DFN - Patient IEN
 ;  IBRXN - Rx IEN
 ;  IBFIL - Fill#
 ;  IBADT - Date of Service
 ;  IBRMARK - Non-billable Reason (.01 from 356.8)
 ;
 N DIE,DR,DA,IBRXTYP,IBEABD
 ; Check that the Date of Service is current
 I IBTRKRN,$G(IBADT),($G(IBADT)'=$P(^IBT(356,IBTRKRN,0),U,6)) D
 . S DIE="^IBT(356,",DA=IBTRKRN,DR=".06////"_IBADT D ^DIE
 I IBTRKRN D:$D(IBRMARK)  Q
 . S DIE="^IBT(356,",DA=IBTRKRN,DR=".19///"_IBRMARK
 . D ^DIE
 ; event type pointer for rx billing
 S IBRXTYP=$O(^IBE(356.6,"AC",4,0))
 ; earliest auto-billing date
 S IBEABD=$$EABD^IBTUTL(IBRXTYP,$$FMADD^XLFDT(IBADT,60))
 ; space out earliest auto bill date
 ;
 ; ROI check
 N IBSCROI,IBDRUG,IBDEA,IBRXDATA
 S IBRXDATA=$$RXZERO^IBRXUTL(DFN,IBRXN)
 S IBDRUG=$P(IBRXDATA,U,6)
 D ZERO^IBRXUTL(IBDRUG)
 S IBDEA=$G(^TMP($J,"IBDRUG",+IBDRUG,3))
 K ^TMP($J,"IBDRUG")
 I $G(IBDEA)["U" D
 . N IBINS,IBFLG,IBINSP
 . D ALL^IBCNS1(DFN,"IBINS",1,IBADT,1)
 . S IBINSP=$O(IBINS("S",1,99),-1) Q:IBINSP=""
 . S IBFLG=$$ROI^IBNCPDR4(DFN,$G(IBDRUG),+$G(IBINS(IBINSP,"0")),$G(IBADT))
 . I 'IBFLG,$G(IBRMARK)="" S IBRMARK="REFUSES TO SIGN RELEASE (ROI)"
 . I 'IBFLG S IBSCROI=3
 . I IBFLG S IBSCROI=2
 ;
 D REFILL^IBTUTL1(DFN,IBRXTYP,IBADT,IBRXN,IBFIL,$G(IBRMARK),IBEABD,$G(IBSCROI))
 Q
 ;
 ;NDC relocated to IBNCPNB
 ;
FILL(X,LEN) ; Zero-fill, right justified.
 N Y
 S:'$G(LEN) LEN=1
 S Y=$E($G(X),1,LEN)
 F  Q:$L(Y)>(LEN-1)  S Y="0"_Y
 Q Y
 ;
PLANN(DFN,IBX,IBADT) ; returns the ien in the insurance multiple for the given plan/patient provided
 ;   Output:  insurance co ien^2.312 subfile ien
 N IBPOL,IBY,IBR
 S IBR=""
 D ALL^IBCNS1(DFN,"IBPOL",1,IBADT)
 S IBY=0 F  S IBY=$O(IBPOL(IBY)) Q:'IBY!IBR  I $P($G(IBPOL(IBY,0)),U,18)=IBX S IBR=$P(IBPOL(IBY,0),U,1)_U_IBY Q
 Q IBR
 ;
PLANEPS(IBPL) ; returns the ePharmacy payer sheets for a group plan 
 ; IBPL = IEN to GROUP INSURANCE PLAN file #355.3
 ; Returns: Payer Sheets. (B1,B2,B3,E1) (comma separated string)
 ;   Successful:   1^B1,B2,B3,E1
 ;   Unsuccessful: 0
 N PIEN,IBR,PLN10,B1,B2,B3,E1
 S IBR=0
 I '$G(IBPL) Q IBR
 ; Get ePharmacy plan IEN
 S PIEN=+$P($G(^IBA(355.3,IBPL,6)),U,1)
 I 'PIEN Q IBR
 S PLN10=$G(^IBCNR(366.03,PIEN,10))
 ; check for test/production sheets
 ; get the test payer sheet first.  If nil, then get the regular payer sheet
 S (B1,B2,B3,E1)=""
 S B1=$P(PLN10,U,11),B2=$P(PLN10,U,12),B3=$P(PLN10,U,13),E1=$P(PLN10,U,14)
 I 'B1 S B1=$P(PLN10,U,7)         ; billing
 I 'B2 S B2=$P(PLN10,U,8)         ; reversal
 I 'B3 S B3=$P(PLN10,U,9)         ; rebill (not currently validated)
 I 'E1 S E1=$P(PLN10,U,15)        ; eligibility
 S IBR="1^"_B1_","_B2_","_B3_","_E1
 Q IBR
 ;
RT(DFN,IBDT,IBINS,IBPTYP) ; returns rate type to use for bill
 ; Input:
 ;    DFN - patient ien
 ;   IBDT - date of service
 ;  IBINS - insurance array (pass by reference)
 ;
 ; Output:
 ;  3 piece string in the following format
 ;     [1] rate type ien
 ;     [2] Rate Type (Tort or Awp or Cost)
 ;     [3] Eligibility Basis (V=VETERAN, T=TRICARE, C=CHAMPVA)
 ;
 ; IBPTYP - patient type - optional output parameter (pass by reference)
 ;        - this is only used by the PRO option (see IBNCPDP1)
 ;        - (V=VETERAN, T=TRICARE, C=CHAMPVA)
 ;        - NOT the same thing as [3] of this function
 ;
 N VAEL,VAERR,IBPT,IBRT,IBX,IBE,IBI,IBRET,IBRS
 S IBPTYP=""
 D ELIG^VADPT
 ;
 ; if primary elig is vet type, use reimbursable
 S IBPT=$P($G(^DIC(8,+VAEL(1),0)),U,5) ; = N:NON-VETERAN;Y:VETERAN
 I IBPT="Y" D  Q IBRT_U_$S($G(IBRET)="VA COST":"C^V",1:"T^V")    ; IB*2*437 modifications
 . S IBRT=$O(^DGCR(399.3,"B","REIMBURSABLE INS.",0))
 . S IBRT=$S(IBRT:IBRT,1:8)
 . I $G(IBDT) S IBRET=$P($$EVNTITM^IBCRU3(IBRT,3,"PRESCRIPTION FILL",IBDT,.IBRS),";",1)
 . Q
 ;
 ; ia #'s 427 & 2516 for references to ^DIC(8 and ^DIC(8.1
 ;
 ;  -  determine eligibilities - build the IBE array
 S IBE=$P($G(^DIC(8.1,+$P($G(^DIC(8,+VAEL(1),0)),U,9),0)),U,1),IBE($S(IBE="TRICARE"!(IBE="SHARING AGREEMENT"):"T",IBE="CHAMPVA":"C",1:"O"))=""     ; primary pt eligibility
 ; IB*2*452 - for CHAMPVA, CHAMPVA must be primary eligibility only - not among secondary eligibilities
 S IBX=0 F  S IBX=$O(VAEL(1,IBX)) Q:'IBX  S IBE=$P($G(^DIC(8.1,+$P($G(^DIC(8,+VAEL(1,IBX),0)),U,9),0)),U,1) S IBE($S(IBE="TRICARE"!(IBE="SHARING AGREEMENT"):"T",1:"O"))=""    ; secondary pt eligibilities
 ;
 ; set patient type parameter
 I $G(VAEL(4)) S IBPTYP="V"   ; veteran without any pt. eligibilities defined
 I $D(IBE("T")) S IBPTYP="T"  ; TRICARE
 I $D(IBE("C")) S IBPTYP="C"  ; CHAMPVA
 ;
 ;  -  determine insurance policies - build the IBI array
 S IBX=0 F  S IBX=$O(IBINS(IBX)) Q:'IBX  S IBI=$P($G(^IBE(355.1,+$P($G(IBINS(IBX,355.3)),U,9),0)),U,1) S IBI($S(IBI="TRICARE":"T",IBI="CHAMPVA":"C",1:"O"))=""
 ;
 ;  -  if patient is only TRICARE elig and only TRICARE ins bill for TRICARE
 I $D(IBE("T")),'$D(IBE("O")),'$D(IBE("C")),$D(IBI("T")),'$D(IBI("O")),'$D(IBI("C")) S IBRT=$O(^DGCR(399.3,"B","TRICARE",0)) Q:IBRT IBRT_"^C^T"
 ;
 ; IB*2*452 - check for CHAMPVA
 I $D(IBE("C")),$D(IBI("C")) S IBRT=$O(^DGCR(399.3,"B","CHAMPVA",0)) Q:IBRT IBRT_"^C^C"
 ;
 Q $S($D(IBRT):IBRT,1:"0^unable to determine rate type")
 ;
 ;
BS() ; returns the mccr utility to use
 N IBX
 S IBX=0 F  S IBX=$O(^DGCR(399.1,"B","PRESCRIPTION",IBX)) Q:IBX<1  I $P($G(^DGCR(399.1,+$G(IBX),0)),U,5) Q
 Q IBX
 ;
RXBIL(IBINP,IBERR) ; Matching NCPDP payments
 ; Find IB Bill by the 7 or 12 digit ECME number and the Rx fill date
 ; This function is called by AR routine $$BILL^RCDPESR1 (DBIA 4435).
 ;Input:
 ;   IBINP("ECME") - the 7 or 12 digit ECME number (Reference Number)
 ;   IBINP("FILLDT")  - the Rx fill date, YYYYMMDD or FileMan format
 ;   IBINP("PNM") (optional) - the patient's last name
 ;Returns:
 ;   IBERR (by ref) - the error code, or null string if found
 ;   $$RXBIL - IB Bill IEN, or 0 if not matched
 N IBKEY,IBECME,BILLDA,IBFOUND,IBMATCH,IBDAT,IBPNAME,ECMELEN,ECMENUM
 S IBERR=""
 S IBECME=$G(IBINP("ECME"))
 I IBECME'?1.12N S IBERR="Invalid ECME number" Q 0
 S IBDAT=$G(IBINP("FILLDT")) ; Rx fill date
 I IBDAT?8N S IBDAT=($E(IBDAT,1,4)-1700)_$E(IBDAT,5,8) ; conv date to FM format
 I IBDAT'?7N Q $$RXBILND(IBECME)  ; date is not correct or null
 S IBPNAME=$G(IBINP("PNM")) ; patient's name (optional)
 ;
 ; Attempt ECME# look up with either 7 digit or 12 digit number  (IB*2*435)
 S IBFOUND=0,IBMATCH=0
 F ECMELEN=12,7 D  Q:IBFOUND
 . I $L(+IBECME)>ECMELEN Q   ; Quit if too large
 . S ECMENUM=$$RJ^XLFSTR(+IBECME,ECMELEN,0)  ; build ECME#
 . S IBKEY=ECMENUM_";"_IBDAT ; The ECME Number (BC ID) for the "AG" xref
 . S BILLDA=""
 . ; Search Backward
 . F  S BILLDA=$O(^DGCR(399,"AG",IBKEY,BILLDA),-1) Q:BILLDA=""  D  Q:IBFOUND
 .. I 'BILLDA Q  ; IEN must be numeric
 .. I '$D(^DGCR(399,BILLDA,0)) Q  ; Corrupted index
 .. S IBMATCH=1
 .. I IBPNAME'="" I '$$TXMATCH($P(IBPNAME,","),$P($G(^DPT(+$P(^DGCR(399,BILLDA,0),U,2),0)),","),8) Q  ; Patient name doesn't match
 .. S IBFOUND=1
 .. Q
 . Q
 ;
 I 'BILLDA S IBERR=$S(IBMATCH:"Patient's name does not match",1:"Matching bill not found") ; not matched
 Q +BILLDA
 ;
RXBILND(IBECME) ;Match the bill with no date
 N IBKEY,IBBC,BILLDA,IBY,IBCUT,ECMELEN,ECMENUM
 S IBCUT=$$FMADD^XLFDT(DT,-180) ; only 180 days in the past for cut-off date
 ;
 ; Search ECME# 7/12 digits forward looking for PRNT/TX claims   (IB*2*435)
 S BILLDA=0
 F ECMELEN=12,7 D  Q:BILLDA
 . I $L(+IBECME)>ECMELEN Q   ; Quit if too large
 . S ECMENUM=$$RJ^XLFSTR(+IBECME,ECMELEN,0)   ; build ECME#
 . S IBKEY=ECMENUM_";"
 . S IBBC=IBKEY_IBCUT
 . F  S IBBC=$O(^DGCR(399,"AG",IBBC)) Q:IBBC'[IBKEY  D  Q:BILLDA
 .. S IBY="" F  S IBY=$O(^DGCR(399,"AG",IBBC,IBY)) Q:'IBY  D  Q:BILLDA
 ... I $P($G(^DGCR(399,+IBY,0)),U,13)'=4 Q  ; not PRNT/TX
 ... S BILLDA=+IBY
 ... Q
 .. Q
 . Q
 I BILLDA Q BILLDA
 ;
 ; Search ECME# 7/12 digits backwards looking for ANY claims within cut-off date  (IB*2*435)
 S BILLDA=0
 F ECMELEN=12,7 D  Q:BILLDA
 . I $L(+IBECME)>ECMELEN Q   ; Quit if too large
 . S ECMENUM=$$RJ^XLFSTR(+IBECME,ECMELEN,0)   ; build ECME#
 . S IBKEY=ECMENUM_";"
 . S IBBC=IBKEY_"8000000"
 . F  S IBBC=$O(^DGCR(399,"AG",IBBC),-1) Q:IBBC'[IBKEY  Q:$P(IBBC,";",2)<IBCUT  D  Q:BILLDA
 .. S IBY="" F  S IBY=$O(^DGCR(399,"AG",IBBC,IBY),-1) Q:IBY=""  D  Q:BILLDA
 ... S BILLDA=+IBY
 ... Q
 .. Q
 . Q
 Q BILLDA
 ;
 ;Check matching of two strings - case insensitive, no spaces etc.
TXMATCH(IBTXT1,IBTXT2,IBMAX) ;
 N IBTR1,IBTR2,IBT1,IBT2
 ;Checking only first IBMAX characters (long names may be trancated
 S IBTR1="ABCDEFGHIJKLMNOPQRSTUVWXYZ:;"",'._()<>/\|@#$%&*-=!`~ "
 S IBTR2="abcdefghijklmnopqrstuvwxyz"
 S IBT1=$E($TR(IBTXT1,IBTR1,IBTR2),1,IBMAX)
 S IBT2=$E($TR(IBTXT2,IBTR1,IBTR2),1,IBMAX)
 Q IBT1=IBT2
 ;
ECMEBIL(DFN,IBADT) ; Is the pat ECME Billable (pharmacy coverage only)
 ; DFN - ptr to the patient
 ; IBADT  - the date
 N IBANY,IBERMSG,IBX,IBINS,IBT,IBZ,IBRES,IBCAT,IBCOV,IBPCOV
 S IBRES=0 ; Not ECME Billable by default
 S (IBCOV,IBPCOV)=0
 ; -- look up ins with Rx
 D ALL^IBCNS1(DFN,"IBINS",1,IBADT,1)
 S IBERMSG="" ; Error message
 S IBCAT=$O(^IBE(355.31,"B","PHARMACY",0))
 S IBX=0 F  S IBX=$O(IBINS("S",IBX)) Q:'IBX  D  Q:IBRES
 . S IBT=0 F  S IBT=$O(IBINS("S",IBX,IBT)) Q:'IBT  D  Q:IBRES
 . . N IBZ,IBPIEN,IBY,IBPL
 . . S IBZ=$G(IBINS(IBT,0))
 . . S IBPL=+$P(IBZ,U,18) Q:'IBPL
 . . S IBCOV=1 ; covered
 . . I '$$PLCOV^IBCNSU3(IBPL,IBADT,IBCAT) Q
 . . S IBPCOV=1
 . . S IBPIEN=+$G(^IBA(355.3,IBPL,6))
 . . I 'IBPIEN S IBERMSG="Plan not linked to the Payer" Q  ; Not linked
 . . D STCHK^IBCNRU1(IBPIEN,.IBY)
 . . I $E($G(IBY(1)))'="A" S:IBERMSG="" IBERMSG=$$ERMSG^IBNCPNB($P($G(IBY(6)),",")) Q
 . . S IBRES=1
 I 'IBCOV Q "0^Not Insured"
 I 'IBPCOV Q "0^No Pharmacy Coverage"
 I 'IBRES,IBERMSG'="" Q "0^"_IBERMSG
 I 'IBRES Q "0^No Insurance ECME billable"
 ;
 Q IBRES
 ;
SUBMIT(IBRX,IBFIL,IBDELAY) ; Submit the Rx claim through ECME
 ; IBDELAY - Delay Reason Code, passed as the 18th parameter - IB*2.0*435
 ; IBRX - RX ien in file #52
 ; IBFIL - Fill No (0 for orig fill)
 N IBDT,IBNDC,IBX
 I '$G(IBRX)!('$D(IBFIL)) Q "0^Invalid parameters."
 S IBDT=$S('IBFIL:$$FILE^IBRXUTL(IBRX,22),1:$$SUBFILE^IBRXUTL(IBRX,IBFIL,52,.01))
 S IBX=$$EN^BPSNCPDP(+IBRX,+IBFIL,IBDT,"BB",,,,,,,,,,,,,,+$G(IBDELAY))
 I +IBX=0 D ECMEACT^PSOBPSU1(+IBRX,+IBFIL,"Claim submitted to 3rd party payer: IB BACK BILLING")
 Q IBX
 ;
REASON(IBX,EXACT) ; Close Claim Reasons
 Q $P($G(^IBE(356.8,+IBX,0)),U) ; non-billable reason
 ;
NABP(IBIFN) ;NABP Number
 N IBY,IBTRKN,IBRX,IBFIL,IBZ,IBNABP
 S IBY=+$O(^IBT(356.399,"C",IBIFN,0)) I 'IBY Q ""
 S IBTRKN=$P($G(^IBT(356.399,IBY,0)),U) I 'IBTRKN Q ""
 S IBZ=$G(^IBT(356,IBTRKN,0)) I IBZ="" Q ""
 S IBRX=$P(IBZ,U,8)
 S IBFIL=$P(IBZ,U,10)
 S IBNABP=$$NABP^BPSBUTL(IBRX,IBFIL)
 Q $S(IBNABP=0:"",1:IBNABP)
 ;
 ; Get the K-bill# from CT
BILL(IBRX,IBFIL) ;
 N IBTRKN,IBIFN
 S IBTRKN=+$O(^IBT(356,"ARXFL",+$G(IBRX),+$G(IBFIL),""))
 S IBIFN=+$P($G(^IBT(356,IBTRKN,0)),U,11)
 Q $P($G(^DGCR(399,IBIFN,0)),U)
 ;
REJECT(IBECME,IBDATE) ; Is the e-claim rejected?
 N IBTRKRN,IBY,ECMELEN
 I IBECME'?1.12N Q 0
 S IBTRKRN=0
 F ECMELEN=12,7 D  Q:IBTRKRN
 . I $L(+IBECME)>ECMELEN Q
 . S IBECME=$$RJ^XLFSTR(+IBECME,ECMELEN,0)    ; build ECME# with leading zeros
 . S IBTRKRN=+$O(^IBT(356,"AE",IBECME,0))
 . Q
 I 'IBTRKRN Q 0
 S IBY=$G(^IBT(356,IBTRKRN,1))
 I $P(IBY,U,11)>0 Q 1  ; Rejected or closed
 Q 0
 ;
RXINS(DFN,IBADT,IBINS) ; Return an array of pharmacy insurance policies by COB order
 ;  Input:
 ;      DFN - Patient ien (required)
 ;    IBADT - Date of Service (fileman format, optional defaults to today)
 ; Output:
 ;    IBINS - Name of destination array (pass by reference)
 ;
 N CT,COB,IEN,IBPL
 K IBINS
 S DFN=+$G(DFN)
 S IBADT=+$G(IBADT,DT)
 D ALL^IBCNS1(DFN,"IBINS",1,IBADT,1)   ; gather all insurance policies in COB order
 ;
 S CT=0   ; count up Rx policies found
 S COB="" F  S COB=$O(IBINS("S",COB)) Q:COB=""  S IEN=0 F  S IEN=$O(IBINS("S",COB,IEN)) Q:'IEN  D
 . S IBPL=+$P($G(IBINS(IEN,0)),U,18)  ; plan ien
 . I 'IBPL K IBINS(IEN),IBINS("S",COB,IEN) Q   ; no plan
 . I '$$PLCOV^IBCNSU3(IBPL,IBADT,3) K IBINS(IEN),IBINS("S",COB,IEN) Q    ; not a pharmacy plan
 . S CT=CT+1
 . Q
 ;
 S IBINS=CT    ; store total number found at the top level
 ;
RXINSX ;
 Q
 ;
 ;IBNCPDPU

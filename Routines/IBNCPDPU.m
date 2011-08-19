IBNCPDPU ;OAK/ELZ - UTILITIES FOR NCPCP ;5/22/08  15:24
 ;;2.0;INTEGRATED BILLING;**223,276,347,383,405,384,437**;21-MAR-94;Build 11
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;IA 4702
 ;
 ;
CT(DFN,IBRXN,IBFIL,IBADT,IBRMARK) ; files in claims tracking
 ; Input:
 ;  DFN - Patient IEN
 ;  IBRXN - Rx IEN
 ;  IBFIL - Fill#
 ;  IBADT - Fill Date
 ;  IBRMARK - Non-billable Reason (.01 from 356.8)
 ;
 N DIE,DR,DA,IBRXTYP,IBEABD
  ; Check that the Fill Date is current
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
 S IBDRUG=$P(IBRXDATA,"^",6)
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
PLANN(DFN,IBX,IBADT) ; returns the ien in the insurance multiple for the given plan
 ; /patient privided.
 ;   ien in multiple^insurance co ien
 N IBPOL,IBY,IBR
 S IBR=""
 D ALL^IBCNS1(DFN,"IBPOL",3,IBADT)
 S IBY=0 F  S IBY=$O(IBPOL(IBY)) Q:IBY<1!(IBR)  I $P(IBPOL(IBY,0),"^",18)=IBX S IBR=$P(IBPOL(IBY,0),"^")_"^"_IBY
 Q IBR
 ;
RT(DFN,IBDT,IBINS,IBN) ; returns rate type to use for bill
 ; pass in insurance by ref and which insurance entry to use
 ; if '$d(ibn) then it loops through to find the first one
 ; format is RT (ien) ^ Rate Type (Tort or Awp or Cost) ^ Eligibility Basis (V=vet, T=tricare)
 N VAEL,VAERR,IBPT,IBRT,IBX,IBE,IBI,IBRET,IBRS
 D ELIG^VADPT
 ;
 ; if primary elig is vet type, use reimbursable
 S IBPT=$P($G(^DIC(8,+VAEL(1),0)),"^",5) ; = N:NON-VETERAN;Y:VETERAN
 I IBPT="Y" D  Q IBRT_U_$S($G(IBRET)="VA COST":"C^V",1:"T^V")
 .   S IBRT=$O(^DGCR(399.3,"B","REIMBURSABLE INS.",0))
 .   S IBRT=$S(IBRT:IBRT,1:8)
 .   I $G(IBDT) S IBRET=$P($$EVNTITM^IBCRU3(IBRT,3,"PRESCRIPTION FILL",IBDT,.IBRS),";",1)
 ;
 ; if patient is only Tricare elig and only Tricare ins bill for Tricare
 ; ia #'s 427 & 2516
 ;  -  determine eligibilities
 S IBE=$P($G(^DIC(8.1,+$P($G(^DIC(8,+VAEL(1),0)),"^",9),0)),"^"),IBE($S(IBE="TRICARE"!(IBE="SHARING AGREEMENT"):"T",IBE="CHAMPVA":"C",1:"O"))=""
 S IBX=0 F  S IBX=$O(VAEL(1,IBX)) Q:'IBX  S IBE=$P($G(^DIC(8.1,+$P($G(^DIC(8,+VAEL(1,IBX),0)),"^",9),0)),"^") S IBE($S(IBE="TRICARE"!(IBE="SHARING AGREEMENT"):"T",IBE="CHAMPVA":"C",1:"O"))=""
 ;  -  determine insurance policies
 S IBX=0 F  S IBX=$O(IBINS(IBX)) Q:'IBX  S IBI=$P($G(^IBE(355.1,+$P($G(IBINS(IBX,355.3)),"^",9),0)),"^") S IBI($S(IBI="TRICARE":"T",IBI="CHAMPVA":"C",1:"O"))=""
 ;  -  tricare?
 I $D(IBE("T")),'$D(IBE("O")),'$D(IBE("C")),$D(IBI("T")),'$D(IBI("O")),'$D(IBI("C")) S IBRT=$O(^DGCR(399.3,"B","TRICARE",0)) Q:IBRT IBRT_"^C^T"
 ;
 Q $S($D(IBRT):IBRT,1:"0^unable to determine rate type")
 ;
 ;
 ; ********* temp code for tricare/champus ************** not currently used
 ; if primary elig is TRICARE/CHAMPUS use one of the champus', depending
 ; on insurance coverage
 I $P($G(^DIC(8.1,+$P($G(^DIC(8,+VAEL(3),0)),"^",9),0)),"^")="TRICARE/CHAMPUS" S IBRT=$$UINS("CHAMPUS",.IBINS,.IBN)
 ;
 ; if primary elig is CHAMPVA use one of the champva's, depending
 ; on insurance coverage
 I $P($G(^DIC(8.1,+$P($G(^DIC(8,+VAEL(3),0)),"^",9),0)),"^")="CHAMPVA" S IBRT=$$UINS("CHAMPVA",.IBINS,.IBN)
 ;
 Q $S($D(IBRT):IBRT,1:"0^unable to determine rate type")
 ;
 ;
UINS(IBT,IBINS,IBN) ; in the case of tricare or champva you may have to use
 ; insurance different rate types insted of the actual tricare or champva
 N IBRT
 S IBN=+$G(IBN,$O(IBINS("S",+$O(IBINS("S",0)),0)))
 I $P($G(^IBE(355.1,+$P($G(IBINS(IBN,355.3)),"^",9),0)),"^")=IBT S IBRT=$O(^DGCR(399.3,"B",IBT,0)),IBRT=$S(IBRT:IBRT_"^"_$S(IBT="CHAMPUS":"A",1:"C"),1:"0^"_IBT_" Rate type not found")
 I '$D(IBRT) S IBRT=$O(^DGCR(399.3,"B",IBT_" REIMB. INS.",0)),IBRT=$S(IBRT:IBRT_"^"_$S(IBT="CHAMPUS":"A",1:"C"),1:"0^"_IBT_" REIMB. INS. Rate type not found")
 Q IBRT
 ;
BS() ; returns the mccr utility to use
 N IBX
 S IBX=0 F  S IBX=$O(^DGCR(399.1,"B","PRESCRIPTION",IBX)) Q:IBX<1  I $P($G(^DGCR(399.1,+$G(IBX),0)),U,5) Q
 Q IBX
 ;
 ; Match IB Bill by the 7-digit ECME number
RXBIL(IBINP,IBERR) ; Matching NCPDP payments
 ;Input:
 ;   IBINP("ECME") - the 7-digit ECME number (Reference Number)
 ;   IBINP("FILLDT")  - the Rx fill date, YYYYMMDD or FileMan format
 ;   IBINP("PNM") (optional) - the patient's last name
 ;Returns:
 ;   IBERR (by ref) - the error code, or null string if found
 ;   $$RXBIL - IB Bill IEN, or 0 if not matched
 N IBKEY,IBECME,BILLDA,IBFOUND,IBMATCH,IBDAT,IBPNAME
 S IBERR=""
 S IBECME=$G(IBINP("ECME"))
 I IBECME'?1.7N S IBERR="Invalid ECME number" Q 0
 S IBDAT=$G(IBINP("FILLDT")) ; Rx fill date
 I IBDAT?8N S IBDAT=($E(IBDAT,1,4)-1700)_$E(IBDAT,5,8) ; conv date to FM format
 I IBDAT'?7N Q $$RXBILND(IBECME)  ; date is not correct or null
 S IBPNAME=$G(IBINP("PNM")) ; patient's name (optional)
 S IBKEY=+IBECME_";"_IBDAT ; The ECME Number (BC ID)
 S BILLDA="",IBFOUND=0,IBMATCH=0
 ; Search backward
 F  S BILLDA=$O(^DGCR(399,"AG",IBKEY,BILLDA),-1) Q:BILLDA=""  D  Q:IBFOUND
 . I 'BILLDA Q  ; IEN must be numeric
 . I '$D(^DGCR(399,BILLDA,0)) Q  ; Corrupted index
 . S IBMATCH=1
 . I IBPNAME'="" I '$$TXMATCH($P(IBPNAME,","),$P($G(^DPT(+$P(^DGCR(399,BILLDA,0),U,2),0)),","),8) Q  ; Patient name doesn't match
 . S IBFOUND=1
 I 'BILLDA S IBERR=$S(IBMATCH:"Patient's name does not match",1:"Matching bill not found") ; not matched
 Q +BILLDA
 ;
RXBILND(IBECME) ;Match the bill with no date
 N IBKEY,IBBC,BILLDA,IBY,IBCUT
 S IBKEY=+IBECME_";"
 S IBCUT=$$FMADD^XLFDT(DT,-180) ; only 180 days in the past
 S BILLDA=0
 ; Search PRNT/TX forward
 S IBBC=IBKEY_IBCUT
 F  S IBBC=$O(^DGCR(399,"AG",IBBC)) Q:IBBC'[IBKEY  D  Q:BILLDA
 . S IBY="" F  S IBY=$O(^DGCR(399,"AG",IBBC,IBY)) Q:'IBY  D  Q:BILLDA
 .. I $P($G(^DGCR(399,+IBY,0)),U,13)'=4 Q  ; not PRNT/TX
 .. S BILLDA=+IBY
 I BILLDA Q BILLDA
 ; Search ANY backward
 S IBBC=IBKEY_"8000000"
 F  S IBBC=$O(^DGCR(399,"AG",IBBC),-1) Q:IBBC'[IBKEY  Q:$P(IBBC,";",2)<IBCUT  D  Q:BILLDA
 . S IBY="" F  S IBY=$O(^DGCR(399,"AG",IBBC,IBY),-1) Q:IBY=""  D  Q:BILLDA
 .. ;I $P($G(^DGCR(399,+IBY,0)),U,13)'=7 Q  ; not CANCELLED
 .. S BILLDA=+IBY
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
SUBMIT(IBRX,IBFIL) ; Submit the Rx claim through ECME
 ; IBRX - RX ien in file #52
 ; IBFIL - Fill No (0 for orig fill)
 N IBDT,IBNDC,IBX
 I '$G(IBRX)!('$D(IBFIL)) Q "0^Invalid parameters."
 S IBDT=$S('IBFIL:$$FILE^IBRXUTL(IBRX,22),1:$$SUBFILE^IBRXUTL(IBRX,IBFIL,52,.01))
 S IBX=$$EN^BPSNCPDP(+IBRX,+IBFIL,IBDT,"BB")
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
 N IBINP,IBTRKRN,IBY
 I IBECME'?1.7N Q 0
 ;S IBINP("ECME")=IBECME
 ;S IBINP("FILLDT")=IBDATE
 ;I $$RXBIL(.IBINP) Q 0  ; bill exists
 S IBTRKRN=+$O(^IBT(356,"AE",IBECME,0)) I 'IBTRKRN Q 0
 S IBY=$G(^IBT(356,IBTRKRN,1))
 I $P(IBY,U,11)>0 Q 1  ; Rejected or closed
 Q 0
 ;
 ;
 ;IBNCPDPU

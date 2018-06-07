IBJDB21 ;ALB/RB - REASONS NOT BILLABLE REPORT (COMPILE) ;19-JUN-00
 ;;2.0;INTEGRATED BILLING;**123,159,185,399,437,458,568**;21-MAR-94;Build 40
 ;;Per VA Directive 6402, this routine should not be modified.
 ;;
EN ; - Entry point from IBJDB2.
 K ^TMP("IBJDB2",$J),IB,IBE,ENCTYP,EPIEN,IBADMDT,RELBILL
 I '$G(IBXTRACT) D
 . F X=1:1:4 I IBSEL[X S IBE(X)=IBEPS(X) ; Set episodes for report.
 ;
 ; - Print the header line for the Excel spreadsheet
 I $G(IBEXCEL) D PHDL
 ;
 ; - Compile reason not billable (RNB) data for episode.
 S IBRNB=0 F  S IBRNB=$S(IBSRNB'="A":$O(IBSRNB(IBRNB)),1:$O(^IBE(356.8,IBRNB))) Q:'IBRNB  D
 .S IB0=0 F  S IB0=$O(^IBT(356,"AR",IBRNB,IB0)) Q:'IB0  D
 ..S IBN0=$G(^IBT(356,IB0,0)),IBN1=$G(^IBT(356,IB0,1)) Q:'IBN0!('IBN1)
 ..S IBEP=+$P(IBN0,U,18) I IBSEL'[IBEP Q  ; Get episode.
 ..S (IBRNB1,IBSORT1)=$P($G(^IBE(356.8,IBRNB,0)),U)
 ..;
 ..; - Get valid date entered/episode date and amount for report.
 ..S IBEPD=+$P(IBN0,U,6)\1,IBDEN=+IBN1\1
 ..S IBDT=$S($E(IBD)="D":IBDEN,1:IBEPD)
 ..Q:IBDT<IBBDT!(IBDT>IBEDT)
 ..S IBAMT=$$AMOUNT(IBEP,IB0)
 ..I IBAMT<0 Q  ;Quit if amount is -1 *568
 ..;
 ..; - Get division, if necessary.
 ..I IBSD D  Q:'VAUTD&('$D(VAUTD(IBDIV)))
 ...S IBDIV=$$DIV^IBJD1(IB0)
 ..E  S IBDIV=$S($G(IBEXCEL):+$$PRIM^VASITE(),1:0)
 ..;
 ..; - Provider & Specialty
 ..S (IBPRV,IBSPC)="",IBQT=0
 ..I IBEP=1!(IBEP=2) D  I IBQT Q
 ...S IBPRSP=$$PRVSPC(IBEP,IB0)
 ...I IBSPRV'="A",'$D(IBSPRV(+IBPRSP)) S IBQT=1 Q
 ...I IBEP=1,IBSISP'="A",'$D(IBSISP(+$P(IBPRSP,U,3))) S IBQT=1 Q
 ...I IBEP=2,IBSOSP'="A",'$D(IBSOSP(+$P(IBPRSP,U,3))) S IBQT=1 Q
 ...S IBPRV=$S($P(IBPRSP,U,2)'="":$P(IBPRSP,U,2),1:"** UNKNOWN **")
 ...S IBSPC=$S($P(IBPRSP,U,4)'="":$P(IBPRSP,U,4),1:"** UNKNOWN **")
 ..;
 ..; - Get remaining data for detailed report.
 ..S DFN=+$P(IBN0,U,2)
 ..D DEM^VADPT S IBPT=$E(VADM(1),1,25),IBSSN=$P(VADM(2),U)
 ..S DIC="^VA(200,",DA=+$P(IBN1,U,4),DR=".01",DIQ="IBCLK" D EN^DIQ1
 ..S IBCLK=$E($G(IBCLK(200,DA,.01)),1,20)
 ..I ($P(IBN0,U,18)=2)&($$EXTERNAL^DILFD(356,.19,"",$P(IBN0,U,19))["72 HOUR RULE") D
 ...S IBADMDT=$$ADMDT^IBTUTL5(DFN,$P(IBN0,U,6))
 ..E  S IBADMDT=""
 ..S ENCTYP=$P(^IBE(356.6,$P(IBN0,U,18),0),U,3) S EPDT=$E($P(IBN0,U,6),1,7)
 ..S EPIEN=$S(ENCTYP=3:$P(IBN0,U,8),ENCTYP=4:$P(IBN0,U,9),1:"")
 ..S RELBILL=$$RELBIL^IBTUTL5(EPIEN,EPDT,DFN,ENCTYP)
 ..;
 ..; - Get totals for summary.
 ..I '$D(IB(IBDIV,IBEP,IBRNB)) S IB(IBDIV,IBEP,IBRNB)="0^0"
 ..S $P(IB(IBDIV,IBEP,IBRNB),U)=$P(IB(IBDIV,IBEP,IBRNB),U)+1
 ..S $P(IB(IBDIV,IBEP,IBRNB),U,2)=$P(IB(IBDIV,IBEP,IBRNB),U,2)+IBAMT
 ..I IBRPT="S" Q
 ..;
 ..S IBSORT1=$S(IBSORT="P":IBPRV,IBSORT="S":IBSPC,1:IBSORT1)
 ..S:IBSORT1="" IBSORT1=" "
 ..;
 ..I $G(IBEXCEL) D  Q
 ...W !,$E($P($G(^DG(40.8,IBDIV,0)),U),1,25),U
 ...W $S(IBEP<4:$E(IBE(IBEP)),1:"H"),U,IBPT,U,$E(IBSSN,6,10),U
 ...W $E($$INS^IBJD1(+$P(IBN0,U,2),IBEPD),1,25),U
 ...W $$DT^IBJD(IBEPD,1),U,$$DT^IBJD(IBDEN,1),U
 ...W $$DT^IBJD($P(IBN1,U,3),1),U,IBCLK,U,IBADMDT,U,$E(IBRNB1,1,25),U
 ...W $E(IBPRV,1,25),U,$E(IBSPC,1,25),U,IBAMT,U
 ...I RELBILL>0 F X=2:1:$P(RELBILL,";",1)+1 W $P(RELBILL,";",X)_" "
 ...I RELBILL<0 W ""
 ...W U,$P(IBN1,U,8)
 ..;
 ..S X=IBEPD_U_IBDEN_U_$P(IBN1,U,3)_U_IBCLK_U_IBRNB1
 ..S X=X_U_IBPRV_U_IBSPC_U_IBAMT_U_$E($P(IBN1,U,8),1,50)_U_IBADMDT_U_RELBILL
 ..S ^TMP("IBJDB2",$J,IBDIV,IBEP,IBSORT1,IBPT_"@@"_$E(IBSSN,6,10))=$$INS^IBJD1(+$P(IBN0,U,2),IBEPD)
 ..S ^TMP("IBJDB2",$J,IBDIV,IBEP,IBSORT1,IBPT_"@@"_$E(IBSSN,6,10),+IBN0)=X
 ;
 I '$G(IBEXCEL) D EN^IBJDB22 ; Print report(s).
 ;
ENQ K ^TMP("IBJDB2")
 K DA,DIC,DIQ,DR,IB,IB0,IBAMT,IBCLK,IBDEN,IBDIV,IBDT,IBE,IBEP,IBEPD,IBI
 K IBN0,IBN1,IBN2,IBPRSP,IBPRV,IBPT,IBQT,IBRNB,IBRNB1,IBSORT1,IBSPC
 K IBSSN,VADM,X1,X2
 Q
 ;
AMOUNT(EPS,CLM) ; Return the Amount not billed 
 ; Input: EPS - Episode(1=Inpatient,2=Outpatient,3=Prosthet.,4=Prescr.)
 ;        CLM - Pointer to Claim Tracking File (#356)
 ;Output: AMOUNT not billed
 ;
 N ADM,ADMDT,AMOUNT,BLBS,BLDT,CPT,CPTLST,DA,DR,DCHD,DFN,DIC,DIQ,DIV,DRG,SPCLTY
 N IBRX,ENC,ENCDT,EPDT,PFT,PRST,PTF,RIMB,VCPT,TTCST,X
 ;
 S AMOUNT=0,X=$G(^IBT(356,CLM,0))
 S ENC=+$P(X,U,4)     ; Encounter    (Pointer to #409.68)
 S ADM=+$P(X,U,5)     ; Admission    (Pointer to #405)
 S PRST=+$P(X,U,9)    ; Prothetics   (Pointer to #660)
 S EPDT=$P(X,U,6)     ; Episode Date (FM format)
 S IBRX=+$P(X,U,8)
 ;
 ; - Assumes REIMBURSABLE INS. as the RATE TYPE
 S RIMB=$O(^DGCR(399.3,"B","REIMBURSABLE INS.",0)) I 'RIMB S RIMB=8
 ;
 G @("AMT"_EPS)
 ;
AMT1 ; - Inpatient Charges
 I 'ADM S AMOUNT=-1 G QAMT
 S X=$G(^DGPM(ADM,0)) I X="" S AMOUNT=-1 G QAMT
 S PTF=$P(X,U,16) I 'PTF S AMOUNT=-1 G QAMT
 S ADMDT=$P(X,U)\1,DFN=+$P(X,U,3)
 I $P(X,U,17) S DCHD=$P($G(^DGPM(+$P(X,U,17),0)),U)\1
 I '$G(DCHD) S DCHD=$$DT^XLFDT()
 ;
 K ^TMP($J,"IBCRC-PTF"),^TMP($J,"IBCRC-DIV"),^TMP($J,"IBCRC-INDT")
 D PTF^IBCRBG(PTF) I '$D(^TMP($J,"IBCRC-PTF")) S AMOUNT=-1 G QAMT  ;*568
 D PTFDV^IBCRBG(PTF) I '$D(^TMP($J,"IBCRC-DIV")) S AMOUNT=-1 G QAMT  ;*568
 D BSLOS^IBCRBG(ADMDT,DCHD,1,ADM,0) I '$D(^TMP($J,"IBCRC-INDT")) S AMOUNT=-1 G QAMT  ;*568
 ;
 S BLDT=""
 F  S BLDT=$O(^TMP($J,"IBCRC-INDT",BLDT)) Q:BLDT=""  D
 .S X=^TMP($J,"IBCRC-INDT",BLDT)
 .S BLBS=$P(X,U,2),DRG=$P(X,U,4),DIV=$P(X,U,5),SPCLTY=$P(X,U,6)
 .;
 .; - Tort Liable Charge (prior to 09/01/99)
 .I BLDT<2990901 D  Q
 ..S AMOUNT=AMOUNT+$$BICOST^IBCRCI(RIMB,1,BLDT,"INPATIENT BEDSECTION STAY",BLBS)
 .;
 .; - Reasonable Charges (on 09/01/99 or later)
 .I $$NODRG^IBCRBG2(SPCLTY)["Observation" Q
 .I $$NODRG^IBCRBG2(SPCLTY)["Nursing Home Care" D  Q
 ..S BLBS=$$MCCRUTL^IBCRU1("SKILLED NURSING CARE",25)
 ..S AMOUNT=AMOUNT+$$BICOST^IBCRCI(RIMB,1,BLDT,"INPATIENT BEDSECTION STAY",BLBS,"",DIV,"",1)
 .;
 .S BLBS=$$BSUPD^IBCRBG2(+SPCLTY,BLDT,1)
 .S AMOUNT=AMOUNT+$$BICOST^IBCRCI(RIMB,1,BLDT,"INPATIENT DRG",DRG,"",DIV,"",1,BLBS)
 ;
 ; - Add the Professional Average Amount per Episode (Reason.Chg only)
 I EPDT'<2990901 S AMOUNT=AMOUNT+$$AVG(EPDT)
 ;
 ; - Subtract the amount billed for this Episode
 S AMOUNT=AMOUNT-$$CLAMT(DFN,EPDT,1) I AMOUNT=0 S AMOUNT=-1  ;*568
 ;
 K ^TMP($J,"IBCRC-PTF"),^TMP($J,"IBCRC-DIV"),^TMP($J,"IBCRC-INDT")
 ;
 G QAMT
 ;
AMT2 ; - Outpatient Charges
 S X=$$GETOE^SDOE(ENC),ENCDT=+$P(X,U),DFN=+$P(X,U,2),DIV=$P(X,U,11)
 ;
 ; - Tort Liable Charge (prior to 09/01/99)
 I ENCDT<2990901 D  G QAMT
 . S AMOUNT=+$$BICOST^IBCRCI(RIMB,3,ENCDT,"OUTPATIENT VISIT DATE")
 ;
 S AMOUNT=$$OPT(ENC,EPDT)  ;*568
 G QAMT  ;*568
 ;
AMT3 ; Prosthetic Charges
 N NTBLD
 S NTBLD=$$PRSAMT^IBTUTL5(EPDT,PRST) I NTBLD=0 S AMOUNT=-1 G QAMT  ;*568
 S DIC="^RMPR(660,",DA=PRST,DR="14",DIQ="TTCST" D EN^DIQ1
 S AMOUNT=+$G(TTCST(660,DA,14))
 G QAMT
 ;
AMT4 ; - Prescription Charges 
 ;
 ; Protect Rx internal entry # before RXAMT call switches to RX number
 N IBRXIEN,NTBLD S IBRXIEN=IBRX
 ;
 ; - Tort Liable Charge & Reasonable Charge (same source)
 S NTBLD=$$RXAMT^IBTUTL5(EPDT,IBRX) I NTBLD=0 S AMOUNT=-1 G QAMT  ;*568
 ;
 ; Patch 437 update to call charge master with enough information
 ; to lookup actual cost of prescription 
 ;
 N IBBI,IBRSNEW
 ;
 ; check charge master for the type of billing--VA Cost or not
 S IBBI=$$EVNTITM^IBCRU3(+RIMB,3,"PRESCRIPTION FILL",EPDT,.IBRSNEW)
 ;
 S DFN=$$FILE^IBRXUTL(IBRXIEN,2)
 I $G(DFN)>0&(IBBI["VA COST") D
 .  N IBQTY,IBCOST,IBRFNUM,IBSUBND,IBFEE,IBRXNODE
 .;  if this is a refill look up the refill info for cost and quantity
 .  S IBRFNUM=$$RFLNUM^IBRXUTL(IBRXIEN,EPDT,"")
 .  I IBRFNUM>0 D
 ..    S IBSUBND=$$ZEROSUB^IBRXUTL(DFN,IBRXIEN,IBRFNUM)
 ..    S IBQTY=$P($G(IBSUBND),U,4)
 ..    S IBCOST=$P($G(IBSUBND),U,11)
 .;
 .;  if this was an original fill look up zero node for Rx info 
 .  E  D
 ..    S IBRXNODE=$$RXZERO^IBRXUTL(DFN,IBRXIEN)
 ..    S IBQTY=$P($G(IBRXNODE),U,7)
 ..    S IBCOST=$P($G(IBRXNODE),U,17)
 .;
 .  S IBRSNEW=+$O(IBRSNEW($P(IBBI,";"),0))
 .  S AMOUNT=$J(+$$RATECHG^IBCRCC(+IBRSNEW,IBQTY*IBCOST,EPDT,.IBFEE),0,2)
 E  D
 .  S AMOUNT=+$$BICOST^IBCRCI(RIMB,3,EPDT,"PRESCRIPTION FILL")
 ;
 ;
QAMT I AMOUNT=0 S AMOUNT=-1 ;*568
 Q AMOUNT
 ;
CLAMT(DFN,EPDT,PT) ; Returns the Total Amount of Claims for Patient/Episode
 ;
 ; Input:  DFN - Pointer to the Patient File #2
 ;        EPDT - Episode Date
 ;          PT - 0=Outpatient, 1=Inpatient
 ;
 N CLAMT,CLM,DAY,IBD,X
 S CLAMT=0,DAY=EPDT-1,CLM=""
 F  S CLM=$O(^DGCR(399,"C",DFN,CLM)) Q:'CLM  D
 .S X=$G(^DGCR(399,CLM,0))
 .I $P($P(X,U,3),".")=$P(EPDT,".") D
 ..S IBD=$$CKBIL^IBTUBOU(CLM,PT) Q:IBD=""
 ..I '$P(IBD,U,3) Q  ; Not authorized
 ..S CLAMT=CLAMT+$G(^DGCR(399,CLM,"U1"))
 ;
QCLAMT Q CLAMT
 ;
OPT(IBOE,IBDT) ; - Has the outpatient encounter been billed?
 ;   Input: IBOE=pointer to outpatient encounter in file #409.68
 ;          IBDT=event date CLAIMS TRACKING(#356)
 ;       
 ;   ;  *Pre-set variables: DFN=patient IEN, RIMB=bill rate
 ;                         
 ;
 I '$G(DFN)!('$G(IBDT))!('$G(RIMB))!('$G(IBOE)) S IBRTN=0 G OPTQ
 N IBCN,IBCPT,IBCT,IBDATA,IBDAY,IBDIV,IBXX,IBYD,IBYY,IBZ,IBMRA,IBCPTSUM,IBTCHRG,IBRTN,IBAUTH
 ; - Check to be sure the encounter is billable.
 I $$INPT^IBAMTS1(DFN,IBDT\1_.2359) S IBRTN=-1 G OPTQ ;  Became inpatient same day.
 I $$ENCL^IBAMTS2(IBOE)["1"  S IBRTN=-1 G OPTQ ; "ao^ir^sc^swa^mst^hnc^cv^shad" encounter.
 ;
 ;
 ; - Gather all procedures associated with the encounter.
 D GETCPT^SDOE(IBOE,"IBYY") I '$G(IBYY) S IBRTN=-1 G OPTQ ; Check CPT qty.
 ;
 ; - Determine the encounter division.
 S IBDIV=+$P($$GETOE^SDOE(IBOE),U,11) S:'IBDIV IBDIV=+$$PRIM^VASITE()
 ;
 ; - Build array of all billable encounter procedures.
 S IBXX=0 F  S IBXX=$O(IBYY(IBXX)) Q:'IBXX  D
 . ;
 . ; - Get procedure pointer and code.
 . S IBZ=+IBYY(IBXX),IBCN=$P($$CPT^ICPTCOD(IBZ),"^",2)
 . ;
 . ; - Ignore LAB services for vets with Medicare Supplemental coverage.
 . I IBCN>79999,IBCN<90000 Q
 . ;
 . ; - Get the institutional/professional charge components.
 . S IBCPT(IBZ,1)=+$$BICOST^IBCRCI(RIMB,3,IBDT,"PROCEDURE",IBZ,"",IBDIV,"",1)
 . S IBCPT(IBZ,2)=+$$BICOST^IBCRCI(RIMB,3,IBDT,"PROCEDURE",IBZ,"",IBDIV,"",2)
 . ;
 . ; - Eliminate components without a charge.
 . S IBCPTSUM(IBZ)=+$G(IBCPT(IBZ,1))+$G(IBCPT(IBZ,2))
 . I 'IBCPT(IBZ,1) K IBCPT(IBZ,1)
 . I 'IBCPT(IBZ,2) K IBCPT(IBZ,2)
 ;
 I '$D(IBCPT) S IBRTN=-1 G OPTQ ; Quit if no billable procedures remain.
 ;
 ; - Look at all of the vet's bills for the day and eliminate
 ;   from the array those procedures that have been billed.
 S IBXX=0 S IBDAY=$E(IBDT,1,7)
 F  S IBXX=$O(^DGCR(399,"AOPV",DFN,IBDAY,IBXX)) Q:'IBXX  D
 . ;
 . ; - Perform general checks on the claim.
 . S IBDATA=$$CKBIL^IBTUBOU(IBXX) Q:IBDATA=""
 . S IBAUTH=$P($G(IBDATA),U,2)
 . I $G(IBAUTH)<2&($G(IBAUTH)>5) Q
 . ; - The episode has been billed. Check the revenue code multiple for
 . ;   all procedures billed on the claim.
 . S IBYY=0
 . F  S IBYY=$O(^DGCR(399,IBXX,"RC",IBYY)) Q:'IBYY  S IBYD=^(IBYY,0) D
 . . ;
 . . ; - Get the procedure code,charge type and total charges for the revenue code.
 . . S IBZ=$P(IBYD,U,6)
 . . S IBCT=$S($P(IBYD,U,12):$P(IBYD,U,12),1:$P(IBDATA,U,4))
 . . S IBTCHRG=$P(IBYD,U,4)
 . . I 'IBZ!('IBCT) Q  ; Can't determine code/charge type for procedure.
 . . ; Delete procedure from unbilled procedures array.
 . . I $G(IBTCHRG)'<$G(IBCPTSUM(IBZ)) K IBCPT(IBZ)
 . . I $D(IBCPT(IBZ,IBCT)) K IBCPT(IBZ,IBCT)
 ;
 ; - Again, quit if no billable procedures remain.
 I '$D(IBCPT) S IBRTN=-1 G OPTQ
 ; - If there are billable procedures return TOTAL AMOUNT
 I $D(IBCPT) S (IBZ,IBCT,IBRTN)=0
 F  S IBZ=$O(IBCPT(IBZ)) Q:'IBZ  D
 .F  S IBCT=$O(IBCPT(IBZ,IBCT)) Q:'IBCT  D
 ..S IBRTN=IBRTN+IBCPT(IBZ,IBCT)
 I IBRTN=0 S IBRTN=-1
 ;
OPTQ K IBCPT Q IBRTN
 ;
AVG(EPDT) ; Returns the Average Amount of Inpatient Professional per
 ;         Number of Episodes for the previous 12 months
 N AVG,M,Z
 S AVG=0,M=EPDT\100*100
 I '$D(^IBE(356.19,M,1)) S M=$O(^IBE(356.19,M),-1) I 'M G QAVG
 S Z=$G(^IBE(356.19,M,1)) I $P(Z,U,12) S AVG=$P(Z,U,11)/$P(Z,U,12)
QAVG Q $J(AVG,0,2)
 ;
PRVSPC(EPS,CLM) ; Return the Provider and the Specialty
 ;  Input: EPS - Episode(1 = Inpatient OR 2 = Outpatient)
 ;         CLM - Pointer to Claim Tracking File (#356)
 ; Output: Provider Code (Pointer to #200) ^ Provider Name ^
 ;         Specialty Code (Pointer to #40.7 or #45.7) ^ Specialty Name
 ;
 N ADM,DFN,ENC,PRI,PRS,PRV,PRVLST,SPC,STP,X,VAIN,VAINDT
 ;
 S X=$G(^IBT(356,CLM,0))
 S DFN=$P(X,U,2),ENC=$P(X,U,4),ADM=$P(X,U,5),PRS=$P(X,U,8)
 ;
 S (PRV,SPC)="^"
 I EPS=1,ADM D  G QPS  ; Inpatient
 .S X=$G(^DGPM(ADM,0)),VAINDT=$P(X,U)\1 I 'VAINDT Q
 .D INP^VADPT S PRV=$G(VAIN(11)),SPC=$G(VAIN(3))
 .S:PRV="" PRV="^" S:SPC="" SPC="^"
 ;
 I EPS=2,ENC D  G QPS  ; Outpatient
 .D GETPRV^SDOE(ENC,"PRVLST")
 .S (X,PRI)=""
 .F  S X=$O(PRVLST(X),-1) Q:X=""!PRI  D
 ..N IBX S PRV=+PRVLST(X)
 ..I $P(PRVLST(X),U,4)="P" S PRI=1 ; Primary provider
 ..I PRV S PRV=PRV_U_$P($G(^VA(200,+PRV,0)),U)
 ..S IBX=$$GETOE^SDOE(ENC),STP=$P(IBX,U,3)
 ..I STP'="" S SPC=STP_U_$P($G(^DIC(40.7,STP,0)),U)
 ;
QPS Q (PRV_U_SPC)
 ;
PHDL ; - Print the header line for the Excel spreadsheet
 N X
 S X="Division^Svc^Patient^SSN^Insurance^Episode Dt^Dt Entered^Dt Lst Edit^"
 S X=X_"Lst Edited By^Next Admission^RNB Cat^Provider^Specialty^Entry Amt^Related Bills^Comments"
 W !,X
 Q

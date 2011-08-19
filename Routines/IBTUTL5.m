IBTUTL5 ;ALB/OEC - CLAIMS TRACKING UTILITY ROUTINE ;16-JAN-09
 ;;2.0;INTEGRATED BILLING;**399**;21-MAR-94;Build 8
 ;;Per VHA Directive 2004-038, this routine should not be modified.
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
 I $$INPT^IBAMTS1(DFN,IBDT\1_.2359) S IBRTN=0 G OPTQ ;  Became inpatient same day.
 I $$ENCL^IBAMTS2(IBOE)["1"  S IBRTN=0 G OPTQ ; "ao^ir^sc^swa^mst^hnc^cv^shad" encounter.
 ;
 ;
 ; - Gather all procedures associated with the encounter.
 D GETCPT^SDOE(IBOE,"IBYY") I '$G(IBYY) S IBRTN=0 G OPTQ ; Check CPT qty.
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
 I '$D(IBCPT) S IBRTN=0 G OPTQ ; Quit if no billable procedures remain.
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
 I '$D(IBCPT) S IBRTN=0 G OPTQ
 ; - If there are billable procedures return TOTAL AMOUNT
 I $D(IBCPT) S (IBZ,IBCT,IBRTN)=0
 F  S IBZ=$O(IBCPT(IBZ)) Q:'IBZ  D
 .F  S IBCT=$O(IBCPT(IBZ,IBCT)) Q:'IBCT  D
 ..S IBRTN=IBRTN+IBCPT(IBZ,IBCT)
 ;
OPTQ K IBCPT Q IBRTN
 ;
 ;
ADMDT(DFN,EPDT) ;
 ;
 ;Returns the next Admission dt for CLAIMS TRACKING entry with RNB 72 HR Rule
 ;      input : DFN (required) := Pointer to PATIENT file (#2)
 ;                                from CLAIMS TRACKING file (#356)
 ;              EPDT (required): = Episode dt field (.06) from
 ;                                 CLAIMS TRAKCING file (#356)
 ;
 ;      output : If patient has an admission after episode dt
 ;               IBADMDT := ADMISSION DT
 ;               IF NO ADMISSION DT IBADMDT := NULL
 ;
 K IBADMDT,ADMID,EPID,ADMIFN
 I '$G(DFN)!('$G(EPDT)) S IBADMDT="" G ADMDTQ
 I '$D(^DGPM("ATID1",DFN)) S IBADMDT="" G ADMDTQ ; REF DBIA419
 S ADMID=9999999.999999-EPDT,EPID=ADMID,ADMIFN=0,X=0
 F X=1:1:1 S ADMID=$O(^DGPM("ATID1",DFN,ADMID),-1) Q:'ADMID  D
 .S ADMIFN=+$O(^DGPM("ATID1",DFN,ADMID,0))
 .I $D(^DGPM(ADMIFN,0)) S IBADMDT=$E($P(^(0),U),1,7)
 ; 
 ;Format date for PRINTED and EXCEL RNB report
 ;
 I $G(IBEXCEL) S IBADMDT=$$DT^IBJD($G(IBADMDT),1)
 I '$G(IBEXCEL) S IBADMDT=$$DTE^IBJDB22($G(IBADMDT))
 ;
ADMDTQ ;
 ;
 S:'$D(IBADMDT) IBADMDT=""
 Q IBADMDT
 ;
 ;
RXAMT(EPDT,RXIEN) ;
 ;
 ; -- input epdt  := episode date from CLAIMS TRACKING(#356)
 ;          RXIEN  := RX field from CLAIMS TRACKING(#356)
 ;          
 ; -- output 0 if RX billed or -1 if RX not billed
 ; 
 I '$G(EPDT)!('$G(IBRX)) S IBRTN=-1 G RXAMTQ
 N IBRXCLM,IBCLM,IBRTN,IBAUTH,IBMRA
 S IBRX=$$FILE^IBRXUTL(RXIEN,.01)
 S IBRXCLM=0
 F  S IBRXCLM=$O(^IBA(362.4,"B",IBRX,IBRXCLM)) Q:'IBRXCLM  D
 .I $P(^IBA(362.4,IBRXCLM,0),U,3)=EPDT S IBCLM=$P(^(0),U,2)
 I '$G(IBCLM) S IBRTN=-1 G RXAMTQ
 I $G(IBCLM) S IBAUTH=$P($$CKBIL^IBTUBOU(IBCLM),U,2)
 I $G(IBAUTH)>2!($G(IBAUTH)<5) S IBRTN=0 G RXAMTQ
 E  S IBRTN=-1 G RXAMTQ
 ;
RXAMTQ Q IBRTN
 ;
 ;
PRSAMT(EPDT,PRST) ;
 ;
 ;    input epdt := episode date from CLAIMS TRACKING(#356)
 ;          prst := prosthetic item from CLAIMS TRACKING(#356)
 ;          
 ;    ouptut 0 if prosthetics item billed or -1 if item not billed
 ;
 I '$G(EPDT)!('$G(PRST)) S IBRTN=-1 G PRSAMTQ
 N IBPRCLM,IBCLM,IBRTN,IBAUTH,IBMRA
 S IBPRCLM=0
 F  S IBPRCLM=$O(^IBA(362.5,"AE",PRST,IBPRCLM)) Q:'IBPRCLM  D
 .S IBCLM=$P(^IBA(362.5,IBPRCLM,0),U,2)
 I '$G(IBCLM) S IBRTN=-1 G PRSAMTQ
 I $G(IBCLM) S IBAUTH=$P(^DGCR(399,IBCLM,0),U,13)
 I $G(IBAUTH)'<2&($G(IBAUTH)'>5) S IBRTN=0 G PRSAMTQ
 E  S IBRTN=-1 G PRSAMTQ
 ;
 ;
PRSAMTQ Q IBRTN
 ;
 ;
RELBIL(IEN,EPDT,DFN,ENCTYP) ;
 ;
 ; ---- Input IEN    := IEN of encounter
 ;            epdt   := Episode Date from CLAIMS TRACKING
 ;            DFN    := Patient file (#2) IEN
 ;            ENCTYP := Type of encounter 1=inpatient 2=Outpatient
 ;                      3=Prosthetics 4=Prescription
 ;                      
 ;      Output Related Bills IF NO RELATED BILL IBRTN=""
 ;                           IF RELATED BILLS 
 ;                           IBRTN= #OF RELATED BILLS;RELATED BILL
 ;      
 I '$G(EPDT)!('$G(DFN))!('$G(ENCTYP)) S IBRTN=-1 G RELBILQ
 ;
 I ENCTYP=1 S IBRTN=$$INPTREL(DFN,EPDT) G RELBILQ
 ;
 I ENCTYP=2 S IBRTN=$$OPTREL(DFN,EPDT) G RELBILQ
 ;
 I ENCTYP=3 S IBRTN=$$RXREL(IEN,EPDT) G RELBILQ
 ;
 I ENCTYP=4 S IBRTN=$$PROSREL(IEN,EPDT) G RELBILQ
 ;
RELBILQ Q IBRTN
 ;
 ;
INPTREL(DFN,EPDT) ;
 ;
 ;
 I '$G(DFN)!('$G(EPDT)) S IBRTN=-1 Q IBRTN
 N IBCLM,IBDATA,IBN0,IBCLM,IBCNT,IBRTN
 S (IBCLM,IBCNT,IBRTN)=0
 F  S IBCLM=$O(^DGCR(399,"C",DFN,IBCLM)) Q:'IBCLM  D
 .Q:$P($G(^DGCR(399,IBCLM,0)),U,5)'=1
 .Q:$E($P($G(^DGCR(399,IBCLM,0)),U,3),1,7)'=EPDT  S IBDATA=$$CKBIL^IBTUBOU(IBCLM,1) Q:'+IBDATA
 .S IBN0=^DGCR(399,IBCLM,0) Q:IBRTN[$P(^(0),U)
 .S IBCNT=IBCNT+1,$P(IBRTN,";",1)=IBCNT
 .S $P(IBRTN,";",IBCNT+1)=$P(IBN0,U)_$S($P(IBN0,U,27)=1:"i",$P(IBN0,U,27)=2:"p",1:"")
 I IBRTN=0 S IBRTN=-1
 Q IBRTN
 ;
 ;
OPTREL(DFN,EPDT) ;
 ;
 ;
 I '$G(DFN)!('$G(EPDT)) S IBRTN=-1 Q IBRTN
 N IBXX,IBCNT,IBN0,IBDATA,IBXX,IBCNT,IBRTN
 S (IBXX,IBCNT,IBRTN)=0
 F  S IBXX=$O(^DGCR(399,"AOPV",DFN,EPDT,IBXX)) Q:'IBXX  D
 .S IBDATA=$$CKBIL^IBTUBOU(IBXX) Q:'+IBDATA
 .S IBN0=^DGCR(399,IBXX,0)
 .Q:IBRTN[$P(^(0),U)
 .S IBCNT=IBCNT+1,$P(IBRTN,";",1)=IBCNT
 .S $P(IBRTN,";",IBCNT+1)=$P(IBN0,U)_$S($P(IBN0,U,27)=1:"i",$P(IBN0,U,27)=2:"p",1:"")
 I IBRTN=0 S IBRTN=-1
 Q IBRTN
 ;
 ;
PROSREL(IEN,EPDT) ;
 ;
 ;INPUT     IEN=POINTER TO FILE 660
 ;          EPDT=DATE PROS ITEM ISSUED
 ;
 ;OUTPUT    IBRTN=-1 IF NOT BILL FOUND OR
 ;                 # OF RELATED;RELATED BILLS
 ;
 N IBXX,IBCLM,IBYY,IBCNT,IBRTN,IBDATA,IBN0
 I '$G(IEN) S IBRTN=-1 Q IBRTN
 S (IBXX,IBYY,IBCNT,IBRTN)=0
 F  S IBXX=$O(^IBA(362.5,"AE",IEN,IBXX)) Q:'IBXX  D
 .S IBCLM=$P(^IBA(362.5,IBXX,0),U,2)
 .I '$D(^DGCR(399,IBCLM,0)) Q
 .S IBN0=^DGCR(399,IBCLM,0) Q:IBRTN[$P(^(0),U)
 .I $P(IBN0,U,13)<2!($P(IBN0,U,13)>5) Q
 .S IBCNT=IBCNT+1,$P(IBRTN,";",1)=IBCNT
 .S $P(IBRTN,";",IBCNT+1)=$P(IBN0,U)_$S($P(IBN0,U,27)=1:"i",$P(IBN0,U,27)=2:"p",1:"")
 I IBRTN=0 S IBRTN=-1
 Q IBRTN
 ;
 ;
RXREL(IEN,EPDT) ;
 ;
 ;
 N IBCLM,IBYY,IBRX,IBRTN,IBCNT
 I '$G(IEN) S IBRTN=-1 Q IBRTN
 S IBRX=$$FILE^IBRXUTL(IEN,.01)
 S (IBYY,IBCNT,IBRTN)=0
 F  S IBYY=$O(^IBA(362.4,"B",IBRX,IBYY)) Q:'IBYY  D
 .Q:$P(^IBA(362.4,IBYY,0),U,3)'=EPDT  S IBCLM=$P(^(0),U,2)
 .S IBDATA=$$CKBIL^IBTUBOU(IBCLM) Q:'+IBDATA
 .S IBN0=^DGCR(399,IBCLM,0) Q:IBRTN[$P(^(0),U)
 .S IBCNT=IBCNT+1,$P(IBRTN,";",1)=IBCNT
 .S $P(IBRTN,";",IBCNT+1)=$P(IBN0,U)_$S($P(IBN0,U,27)=1:"i",$P(IBN0,U,27)=2:"p",1:"")
 I IBRTN=0 S IBRTN=-1
 Q IBRTN
 ;
 ;

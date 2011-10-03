IBCRBG ;ALB/ARH - RATES: BILL SOURCE EVENTS (INPT) ; 21 MAY 96
 ;;2.0;INTEGRATED BILLING;**52,80,106,51,142,159,210,245,382,389**;21-MAR-94;Build 6
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
INPTPTF(IBIFN,CS) ; search PTF record for billable bedsections, transfer DRGs, and length of stay 
 ; - screens out days for pass, leave and SC treatment
 ; - adds charges for only one BS if the ins company does not allow multiple bedsections per bill (36,.06)
 ; Output: ^TMP($J,"IBCRC-INDT", BILLABLE DATE) = MOVE DT/TM ^ BILL BS ^ SC FLAG ^ DRG ^ DIV ^ SPECIALTY ^ MOVE #
 ;
 N IB0,DFN,PTF,IBU,IBBDT,IBEDT,IBTF,IBADM,IBX,IBINSMBS
 K ^TMP($J,"IBCRC-PTF"),^TMP($J,"IBCRC-DIV"),^TMP($J,"IBCRC-INDT")
 ;
 S IB0=$G(^DGCR(399,+$G(IBIFN),0)),DFN=$P(IB0,U,2) Q:'DFN
 S IBTF=$P(IB0,U,6),PTF="" S:$P(IB0,U,5)<3 PTF=$P(IB0,U,8) Q:'PTF
 S IBINSMBS=0,IBX=+$G(^DGCR(399,+IBIFN,"MP"))
 I 'IBX,$$MCRWNR^IBEFUNC($$CURR^IBCEF2(IBIFN)) S IBX=$$CURR^IBCEF2(IBIFN)
 I $P($G(^DIC(36,+IBX,0)),U,6)=0 S IBINSMBS=1 ; 1 bs per bill
 ;
 S IBU=$G(^DGCR(399,+IBIFN,"U")) Q:'IBU
 S IBBDT=+IBU,IBEDT=$P(IBU,U,2) Q:'IBEDT
 ;
 S IBADM=$O(^DGPM("APTF",PTF,0)) ; find corresponding admission
 ;
 D PTF(PTF) ; get movements and bedsections
 D PTFDV(PTF) ; reset movements and bedsections for ward/division
 D PTFFY(PTF,IBBDT,IBEDT) ; reset movements for FY DRG change
 ;
 D BSLOS(IBBDT,IBEDT,IBTF,IBADM,IBINSMBS) ; calculate days in bedsections within timeframe of the bill
 ;
 K ^TMP($J,"IBCRC-PTF"),^TMP($J,"IBCRC-DIV")
 ;
 D INPTRSET^IBCRBG2(IBIFN,$G(CS))
 Q
 ;
PTF(PTF) ; find all movements in PTF for the admission by date and billing bedsection (501 movement)
 ; the movement date is the date the patient left the bedsection
 ; Output: ^TMP($J,"IBCRC-PTF", MOVE DT/TM)=MOVE DT/TM ^ BILL BED ^ SC FLAG ^ TRANSFER DRG ^ ^ SPECIALTY ^ MOVE #
 ;
 N IBMOVE,IBMVLN,IBBILLBS,IBENDDT,IBMSC,IBMDRG S PTF=+$G(PTF)
 S IBMOVE=0 F  S IBMOVE=$O(^DGPT(PTF,"M",IBMOVE)) Q:'IBMOVE  D
 . S IBMVLN=^DGPT(PTF,"M",IBMOVE,0)
 . S IBBILLBS=+$$SPBB($P(IBMVLN,U,2)) ;                                 billable bedsection
 . S IBENDDT=+$P(IBMVLN,U,10) I 'IBENDDT S IBENDDT=DT ;                 movement date (last date in bedsection)
 . S IBMSC="" I +$P(IBMVLN,U,18)=1 S IBMSC=1 ;                          sc movement
 . S IBMDRG=$$MVDRG(PTF,IBMOVE) ;                                       movement DRG
 . S ^TMP($J,"IBCRC-PTF",IBENDDT)=IBENDDT_U_IBBILLBS_U_IBMSC_U_IBMDRG_U_U_+$P(IBMVLN,U,2)_U_IBMOVE
 Q
 ;
SPBB(SPCLTY) ; find the billable bedsection for a Specialty (42.4)
 ; returns billable bedsection IFN ^ billable bedsection name
 N IBX,IBY,IBZ S IBZ=0
 S IBX=$P($G(^DIC(42.4,+$G(SPCLTY),0)),U,5)
 I IBX'="" S IBY=$O(^DGCR(399.1,"B",IBX,0)) I +IBY S IBZ=IBY_U_IBX
 Q IBZ
 ;
BSLOS(IBBDT,IBEDT,IBTF,IBADM,IBINSMBS) ; from the array of PTF movments get all bedsections and their LOS covered by date range of the bill
 ; adds all days for first cronological bs if ins comp wants only a single bs per bill, even if not sequential
 ; the movement date is the date the patient left the bedsection, so admission date is not in PTF array
 ;
 ; Input:  ^TMP($J,"IBCRC-PTF", MOVE DT/TM) = MOVE DT/TM ^ BILL BS ^ SC FLAG ^ DRG ^ DIV ^ SPECIALTY ^ MOVE #
 ; Output: ^TMP($J,"IBCRC-INDT", BILLABLE DATE) = MOVE DT/TM ^ BILL BS ^ SC FLAG ^ DRG ^ DIV ^ SPECIALTY ^ MOVE #
 ;
 N IBSBDT,IBSEDT,IBS,IBLASTDT,IBX
 S IBSBDT=IBBDT+.3 ;                        discount any movements ending on or before the begin date
 S IBSEDT=IBEDT\1
 ; 
 I ",2,3,"'[IBTF S IBSEDT=IBSEDT-.01 ;      final bill, do not count last day
 ;
 I +$G(IBADM) S IBX=$$AD^IBCU64(IBADM) I +IBX,($P(IBX,U,1)\1)=($P(IBX,U,2)\1) S IBSBDT=IBBDT ; reset 1 day stays
 ;
 S IBS=IBSBDT-.01 F  S IBS=$O(^TMP($J,"IBCRC-PTF",IBS)) Q:'IBS  D SET S IBLASTDT=IBS Q:(IBLASTDT\1)>IBSEDT
 ;
 Q
 ;
SET ; checks a specific movement to determine if it should be billed and what the length of stay is
 ; setting of the movement date determines how many days are counted in the bedsection
 N IBMVLN,IBMBDT,IBMEDT,IBMTF,IBMLOS,IBI,IBCHGDT
 S IBMVLN=$G(^TMP($J,"IBCRC-PTF",IBS))
 I '$P(IBMVLN,U,2) Q  ;                                              non-billable bedsection
 I +$P(IBMVLN,U,3) Q  ;                                              sc movement
 I +IBINSMBS,+$G(IBLASTDT) Q  ;                                      ins does not allow multiple bs
 ;
 S IBMBDT=$S(IBBDT>$G(IBLASTDT):IBBDT,1:IBLASTDT),IBMBDT=IBMBDT\1 ;  start cnt on begin dt or last move dt
 S IBMEDT=$S(IBS<IBEDT:IBS,1:IBEDT),IBMEDT=IBMEDT\1 ;                end cnt on move dt or end dt
 S IBMTF=$S(IBEDT<(IBS\1):IBTF,1:1) ;                                last movement gets timeframe
 S IBMLOS=$$LOS^IBCU64(IBMBDT,IBMEDT,IBMTF,IBADM) Q:'IBMLOS  ;       calculate the LOS for the movement
 ;
 F IBI=1:1:IBMLOS S IBCHGDT=$$FMADD^XLFDT(IBMBDT,(IBI-1)),^TMP($J,"IBCRC-INDT",+IBCHGDT)=IBMVLN
 Q
 ;
BBS(X) ; returns true if pointer passed in is a billable bedsection ^ bedsection name
 N IBX,IBY S IBY=0,IBX=$G(^DGCR(399.1,+$G(X),0)) I +$P(IBX,U,5) S IBY=1_U_$P(IBX,U,1)
 Q IBY
 ;
 Q
 ;
PTFDV(PTF) ; find all ward/location transfers in PTF for the patient to determine the site/division the patient was in
 ; the division of the ward will be added to the PTF bedsection movements
 ; Input:  ^TMP($J,"IBCRC-PTF", move dt/tm) = move dt/tm ^ bill bs ^ sc flag ^ move drg ^ ^ specialty ^ move #
 ; Output: ^TMP($J,"IBCRC-PTF", move dt/tm) = move dt/tm ^ bill bs ^ sc flag ^ move drg ^ WARD DIV ^ spec ^ move#
 ;          ^TMP($J,"IBCRC-DIV", TRANSFER DATE/TIME) = WARD DIVISION
 N IBTRNSF,IBTRLN,IBENDDT,IBTRDV,IBMVDT,IBTRDT
 ;
 I '$O(^TMP($J,"IBCRC-PTF",0)) Q
 ;
 ; get all ward transfers
 S IBTRNSF=0 F  S IBTRNSF=$O(^DGPT(PTF,535,IBTRNSF)) Q:'IBTRNSF  D
 . S IBTRLN=$G(^DGPT(PTF,535,+IBTRNSF,0))
 . S IBENDDT=$P(IBTRLN,U,10) I 'IBENDDT S IBENDDT=DT ;                  transfer date (last date in ward)
 . S IBTRDV=$P($G(^DIC(42,+$P(IBTRLN,U,6),0)),U,11) Q:'IBTRDV  ;        losing ward division
 . S ^TMP($J,"IBCRC-DIV",IBENDDT)=IBTRDV
 ;
 ; if the ward transfer does not coincide with a specialty transfer add bedsection move on the transfer date
 S IBENDDT=0 F  S IBENDDT=$O(^TMP($J,"IBCRC-DIV",IBENDDT)) Q:'IBENDDT  D
 . S IBMVDT=$O(^TMP($J,"IBCRC-PTF",(IBENDDT-.0000001)))
 . I 'IBMVDT Q  ; - transfer movement dates after the discharge date in the PTF file (inconsistent)
 . I $P(IBENDDT,".")'=$P(IBMVDT,".") S ^TMP($J,"IBCRC-PTF",IBENDDT)=$G(^TMP($J,"IBCRC-PTF",IBMVDT))
 ;
 ; add the ward division to the bedsection/specialty
 S IBENDDT=0 F  S IBENDDT=$O(^TMP($J,"IBCRC-PTF",IBENDDT)) Q:'IBENDDT  D
 . S IBTRDT=$O(^TMP($J,"IBCRC-DIV",(IBENDDT-.0000001))) ;              ward transfer covering this bedsection
 . S IBTRDV=$G(^TMP($J,"IBCRC-DIV",+IBTRDT)) ;                         ward division
 . I +IBTRDV S $P(^TMP($J,"IBCRC-PTF",IBENDDT),U,5)=IBTRDV
 Q
 ;
PTFFY(PTF,BEGDT,ENDDT) ; add movement for FY (10/1) if date range covers FY and DRG changes
 ; the DRG may change on FY so check and if necessary add movement for pre-FY with old DRG
 ; Input:  ^TMP($J,"IBCRC-PTF", move dt/tm) = move dt/tm ^ bill bs ^ sc flag ^ move drg ^ ^ specialty ^ move #
 ; Output: ^TMP($J,"IBCRC-PTF", move dt/tm) = move dt/tm ^ bill bs ^ sc flag ^ MOVE DRG ^ ward div ^ spec ^ move#
 N IBBEGDT,IBENDDT,IBYRB,IBYRE,IBYR,IBFY,IBMVLN,IBMVDRG,IBMOVE,IBFYDRG Q:'$G(PTF)
 Q:'$G(BEGDT)  S IBFY=$E(BEGDT,1,3)_"1001"
 ;
 S IBBEGDT=BEGDT,IBENDDT=BEGDT\1 F  S IBENDDT=$O(^TMP($J,"IBCRC-PTF",IBENDDT)) Q:'IBENDDT  D  S IBBEGDT=IBENDDT
 . S IBYRB=$E(IBBEGDT,1,3),IBYRE=$E(IBENDDT,1,3) I (IBYRE-IBYRB)>10 Q
 . F IBYR=IBYRB:1:IBYRE S IBFY=IBYR_"1001" I IBBEGDT<IBFY,IBENDDT>IBFY D
 .. S IBMVLN=$G(^TMP($J,"IBCRC-PTF",IBENDDT)),IBMVDRG=$P(IBMVLN,U,4),IBMOVE=$P(IBMVLN,U,7)
 .. S IBFYDRG=$$MVDRG(PTF,IBMOVE,IBYR_"0930")
 .. I IBMVDRG'=IBFYDRG S $P(IBMVLN,U,4)=IBFYDRG S ^TMP($J,"IBCRC-PTF",IBFY)=IBMVLN
 Q
 ;
MVDRG(PTF,M,CDATE) ; Return the DRG for a specific PTF Movememt (M=move ifn)
 ; CDATE is optional, used if need to calculate DRG for some day within the move, not at the end date
 N DPT0,PTF0,PTFM0,PTF70,IBBEG,IBEND,IBDSST,IBDX,IBPRC0,IBPRC,IBDRG,IBI,IBJ,IBP
 N SEX,AGE,ICDDX,ICDPRC,ICDEXP,ICDDMS,ICDTRS,ICDDRG,ICDMDC,ICDRTC,ICDDATE
 S IBDRG=""
 ;
 S PTF0=$G(^DGPT(+$G(PTF),0)),DPT0=$G(^DPT(+$P(PTF0,U,1),0)) I DPT0="" G MVDRGQ
 S PTFM0=$G(^DGPT(+PTF,"M",+$G(M),0)) I 'PTFM0 G MVDRGQ
 S PTF70=$G(^DGPT(+PTF,70)),IBDSST=+$P(PTF70,U,3)
 ;
 S IBEND=+$P(PTFM0,U,10) I 'IBEND S IBEND=DT+.9
 S IBBEG=$O(^DGPT(+PTF,"M","AM",IBEND),-1) I 'IBBEG S IBBEG=$P(PTF0,U,2)
 ;
 S SEX=$P(DPT0,U,2)
 S AGE=$P(DPT0,U,3),AGE=$$FMDIFF^XLFDT(IBEND,AGE)\365.25
 ;
 S (ICDEXP,ICDDMS,ICDTRS)=0 I +PTF70,+PTF70=$P(PTFM0,U,10) D
 . I IBDSST>5 S ICDEXP=1 ;  patient expired
 . I IBDSST=4 S ICDDMS=1 ;  patient left against medical advice
 . I IBDSST=5,+$P(PTF70,U,13) S ICDTRS=1 ; patient transfered to another facility
 ;
 S IBJ=0 F IBI=5:1:9 S IBDX=$P(PTFM0,U,IBI) I +IBDX,($$ICD9^IBACSV(+IBDX)'="") S IBJ=IBJ+1,ICDDX(IBJ)=IBDX
 ;
 I '$O(ICDDX(0)) G MVDRGQ
 ;
 S IBJ=0
 S IBP=0 F  S IBP=$O(^DGPT(+PTF,"S",IBP)) Q:'IBP  D  ; surguries
 . S IBPRC0=$G(^DGPT(+PTF,"S",IBP,0)) Q:'IBPRC0
 . I +IBPRC0'<IBBEG,+IBPRC0'>IBEND D
 .. F IBI=8:1:12 S IBPRC=$P(IBPRC0,U,IBI) I +IBPRC,($$ICD0^IBACSV(+IBPRC)'="") S IBJ=IBJ+1,ICDPRC(IBJ)=+IBPRC
 ;
 S IBP=0 F  S IBP=$O(^DGPT(+PTF,"P",IBP)) Q:'IBP  D  ; procedures
 . S IBPRC0=$G(^DGPT(+PTF,"P",IBP,0)) Q:'IBPRC0
 . I +IBPRC0'<IBBEG,+IBPRC0'>IBEND D
 .. F IBI=5:1:9 S IBPRC=$P(IBPRC0,U,IBI) I +IBPRC,($$ICD0^IBACSV(+IBPRC)'="") S IBJ=IBJ+1,ICDPRC(IBJ)=+IBPRC
 ;
 S ICDDATE=$S(+$G(CDATE):CDATE,+$P(PTFM0,U,10):+$P(PTFM0,U,10),1:DT) ; date for the DRG Grouper versioning
 D ^ICDDRG S IBDRG=$G(ICDDRG)
 ;
MVDRGQ Q IBDRG

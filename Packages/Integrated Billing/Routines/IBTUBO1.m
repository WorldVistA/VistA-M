IBTUBO1 ;ALB/AAS - UNBILLED AMOUNTS - GENERATE UNBILLED REPORTS ;29-SEP-94
 ;;2.0;INTEGRATED BILLING;**19,31,32,91,123,159,247,155,277,339,399,516,547**;21-MAR-94;Build 119
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
OPT(IBOE,IBQUERY) ; - Has the outpatient encounter been billed?
 ;   Input: IBOE=pointer to outpatient encounter in file #409.68
 ;               (NOTE: this value may be null)
 ;          IBQUERY (Passed by reference)=flag that is incremented when
 ;                  the Scheduling query API is invoked
 ;  *Pre-set variables: DFN=patient IEN, IBDT=event date, IBRT=bill rate,
 ;                      IBEDT=End of reporting period date.
 ;                      IBX=ien of CLAIMS TRACKING entry file 356
 ;
 I '$G(DFN)!('$G(IBDT))!('$G(IBRT))!'$G(IBX) G OPTQ
 N IBCN,IBCPT,IBCPTSUM,IBCT,IBDATA,IBDAY,IBDIV,IBFL,IBNAME
 N IBQUIT,IBNCF,IBTCHRG,IBXX,IBYD,IBYY,IBZ,IBMRA
 ;
 ; - Check to be sure the encounter is billable.
 I $$INPT^IBAMTS1(DFN,IBDT\1_.2359) G OPTQ ;  Became inpatient same day.
 I $G(IBOE),$$ENCL^IBAMTS2(IBOE)["1" G OPTQ ; "ao^ir^sc^swa^mst^hnc^cv^shad" encounter.
 S IBDAY=$E(IBDT,1,7),IBNAME=$P($G(^DPT(DFN,0)),U),IBQUIT="",IBNCF=0
 ;
 ; - Determine the encounter division.
 S IBDIV=+$P($$GETOE^SDOE(IBOE),U,11) S:'IBDIV IBDIV=+$$PRIM^VASITE()
 ; IB*2.0*516 - Added ability to sort by Division.
 I $D(^TMP($J,"IBTUB-DIV")),'$D(^TMP($J,"IBTUB-DIV",IBDIV)) G OPTQ ; Not a selected Division
 ;
 ; - If no encounter, see if add/edits or registrations are not billable.
 I '$G(IBOE) D NOOE G:IBQUIT OPTQ
 ;
 ; - If encounter was dated prior to Reasonable Charges (9/1/99) and
 ;   the claim was not authorized before end of reporting period, add
 ;   encounter Tort Rate to Unbilled Outpatient Amount
 I IBDAY<2990901 D PRERC,SETUB:'IBQUIT G OPTQ
 I '$G(IBOE) G OPTQ ; If still no encounter, quit.
 ;
 ; - If encounter was made after start of Reasonable Charges (9/1/99)
 ;   and any of the encounter's procedure codes have no corresponding
 ;   inst. or prof. claims that were not authorized before end of the
 ;   reporting period, add the charges for the procedures to the
 ;   Unbilled Outpatient Amount.
 ;
 ; - Gather all procedures associated with the encounter.
 D GETCPT^SDOE(IBOE,"IBYY") G:'$G(IBYY) OPTQ ; Check CPT qty.
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
 . S IBCPT(IBZ,1)=+$$BICOST^IBCRCI(IBRT,3,IBDAY,"PROCEDURE",IBZ,"",IBDIV,"",1)
 . S IBCPT(IBZ,2)=+$$BICOST^IBCRCI(IBRT,3,IBDAY,"PROCEDURE",IBZ,"",IBDIV,"",2)
 . ;
 . ; - Eliminate components without a charge.
 . S IBCPTSUM(IBZ)=+$G(IBCPT(IBZ,1))+$G(IBCPT(IBZ,2))
 . I 'IBCPT(IBZ,1) K IBCPT(IBZ,1)
 . I 'IBCPT(IBZ,2) K IBCPT(IBZ,2)
 . Q
 ;
 I '$D(IBCPT) G OPTQ ; Quit if no billable procedures remain.
 ;
 ; - Look at all of the vet's bills for the day and eliminate
 ;   from the array those procedures that have been billed.
 S IBXX=0
 F  S IBXX=$O(^DGCR(399,"AOPV",DFN,IBDAY,IBXX)) Q:'IBXX  D
 . ;
 . ; - Perform general checks on the claim.
 . S IBDATA=$$CKBIL^IBTUBOU(IBXX) Q:IBDATA=""
 . I $P(IBDATA,U,2)=2 S IBMRA(IBXX)=IBDATA ; MRA request
 . S IBNCF=IBNCF+1
 . ;
 . ; If Compile/Store & Not authorized/MRA requested before reporting period - Quit.
 . I $G(IBCOMP),$S('$G(IBMRA(IBXX)):$P(IBDATA,U,3),1:$P(IBDATA,U,6))>IBEDT Q
 . ;
 . ; - The episode has been billed. Check the revenue code multiple for
 . ;   all procedures billed on the claim.
 . S IBYY=0
 . F  S IBYY=$O(^DGCR(399,IBXX,"RC",IBYY)) Q:'IBYY  S IBYD=^(IBYY,0) D
 . . ;
 . . ; - Get the procedure code and charge type for the revenue code.
 . . S IBZ=$P(IBYD,U,6)
 . . S IBCT=$S($P(IBYD,U,12):$P(IBYD,U,12),1:$P(IBDATA,U,4))
 . . S IBTCHRG=$P(IBYD,U,4)
 . . I 'IBZ!('IBCT) Q  ; Can't determine code/charge type for procedure.
 . . I $G(IBMRA(IBXX))'="" S:$D(IBCPT(IBZ)) IBCPT("MRA",IBZ,IBCT)=1 Q
 . . ; Delete procedure from unbilled procedures array.
 . . I $G(IBTCHRG)'<$G(IBCPTSUM(IBZ)) K IBCPT(IBZ) Q
 . . I $D(IBCPT(IBZ,IBCT)) K IBCPT(IBZ,IBCT) Q
 . . K IBCPT(IBZ)
 . . Q
 . Q
 ;
 ; - Again, quit if no billable procedures remain.
 I '$D(IBCPT) G OPTQ
 ;
 ; If the IBSBD flag is not set, then reset the Division to be
 ; 999999.  This data will still be included, but the report
 ; will not be sorted by Division.
 ;
 I '$G(IBSBD) S IBDIV=999999
 ;
 ; - The encounter has unbilled procedure codes. Increment the counters
 ;   as per the extract specification.
 ;
 ; - Count the encounter (element 37N).
 S IBMRA=$S($D(IBCPT("MRA")):1,1:0)
 I 'IBMRA D
 . S IBUNB(IBDIV,"ENCNTRS")=$G(IBUNB(IBDIV,"ENCNTRS"))+1
 . S IBUNB("ENCNTRS")=$G(IBUNB("ENCNTRS"))+1
 I $G(IBXTRACT) S IB(14)=IB(14)+1
 ;
 ; - Look at all the unbilled procedures.
 S IBZ=0 F  S IBZ=$O(IBCPT(IBZ)) Q:'IBZ  D
 . ;
 . S IBMRA=$S($D(IBCPT("MRA",IBZ)):1,1:0)
 . ; - Count the procedure (element 37M).
 . I $G(IBXTRACT) S IB(13)=IB(13)+1
 . ;
 . ; - Count the institutional component (element 37I) and its
 . ;   corresponding charge amount (element 37J).
 . I $G(IBCPT(IBZ,1)) D
 . . I IBMRA D
 . . . S IBUNB(IBDIV,"CPTMS-I-MRA")=$G(IBUNB(IBDIV,"CPTMS-I-MRA"))+1
 . . . S IBUNB("CPTMS-MRA")=$G(IBUNB("CPTMS-MRA"))+1
 . . . S IBUNB(IBDIV,"UNBILOP-MRA")=$G(IBUNB(IBDIV,"UNBILOP-MRA"))+IBCPT(IBZ,1)
 . . . S IBUNB("UNBILOP-MRA")=$G(IBUNB("UNBILOP-MRA"))+IBCPT(IBZ,1)
 . . . Q
 . . E  D
 . . . S IBUNB(IBDIV,"CPTMS-I")=$G(IBUNB(IBDIV,"CPTMS-I"))+1
 . . . S IBUNB("CPTMS")=$G(IBUNB("CPTMS"))+1
 . . . S IBUNB(IBDIV,"UNBILOP")=$G(IBUNB(IBDIV,"UNBILOP"))+IBCPT(IBZ,1)
 . . . S IBUNB("UNBILOP")=$G(IBUNB("UNBILOP"))+IBCPT(IBZ,1)
 . . . Q
 . . I $G(IBXTRACT) S IB(9)=IB(9)+1,IB(10)=IB(10)+IBCPT(IBZ,1)
 . . Q
 . ;
 . ; - Count the professional component (element 37K) and its
 . ;   corresponding charge amount (element 37L).
 . I $G(IBCPT(IBZ,2)) D
 . . I IBMRA D
 . . . S IBUNB(IBDIV,"CPTMS-P-MRA")=$G(IBUNB(IBDIV,"CPTMS-P-MRA"))+1
 . . . S IBUNB("CPTMS-MRA")=$G(IBUNB("CPTMS-MRA"))+1
 . . . S IBUNB(IBDIV,"UNBILOP-MRA")=$G(IBUNB(IBDIV,"UNBILOP-MRA"))+IBCPT(IBZ,2)
 . . . S IBUNB("UNBILOP-MRA")=$G(IBUNB("UNBILOP-MRA"))+IBCPT(IBZ,2)
 . . . Q
 . . E  D
 . . . S IBUNB(IBDIV,"CPTMS-P")=$G(IBUNB(IBDIV,"CPTMS-P"))+1
 . . . S IBUNB("CPTMS")=$G(IBUNB("CPTMS"))+1
 . . . S IBUNB(IBDIV,"UNBILOP")=$G(IBUNB(IBDIV,"UNBILOP"))+IBCPT(IBZ,2)
 . . . S IBUNB("UNBILOP")=$G(IBUNB("UNBILOP"))+IBCPT(IBZ,2)
 . . . Q
 . . I $G(IBXTRACT) S IB(11)=IB(11)+1,IB(12)=IB(12)+IBCPT(IBZ,2)
 . . Q
 . Q
 ;
 D SETUB
 ;
OPTQ Q
 ;
PRERC ; - Determine if a pre-9/1/99 visit has been billed.
 ;   Output: IBQUIT will be set to 1 if the visit has been billed.
 ;   *Pre-set variables DFN,IBDAY,IBDET,IBNAME,IBNCF,IBQUIT,IBRT,IBEDT
 ;    and IB/IBUNB arrays required.
 ; NO MRA Extract code needed for pre-RC processes
 ;
 S IBDIV=0
 F  S IBDIV=$O(^TMP($J,"IBTUB",IBDIV)) Q:'IBDIV  D  I IBQUIT Q
 . I $D(^TMP($J,"IBTUB",IBDIV,"OPT",IBNAME_"@@"_DFN,IBDAY)) S IBQUIT=1
 I IBQUIT G PRCQ
 ;
 ; - Check all outpatient claims on event date.
 N IBXX S IBXX=0
 F  S IBXX=$O(^DGCR(399,"AOPV",DFN,IBDAY,IBXX)) Q:'IBXX  D  Q:IBQUIT
 . ;
 . ; - Perform general checks on the claim.
 . S IBDATA=$$CKBIL^IBTUBOU(IBXX) Q:IBDATA=""  S IBNCF=IBNCF+1
 . I IBDIV="" S IBDIV=$$GET1^DIQ(399,IBXX_",",.22,"I")
 . ;
 . ; If Compile/Store & Not authorized before reporting period - Quit.
 . I $G(IBCOMP),$P(IBDATA,U,3)>IBEDT Q
 . ;
 . S IBQUIT=1 ; Episode has been billed-set flag.
 . Q
 ;
 I IBQUIT G PRCQ ; Episode was billed.
 I IBDIV="" S IBDIV=999999
 ;
 ; - The episode was not billed; determine the tort rate for a visit
 ;   and increment the number and amount of unbilled pre-9/1/99 visits.
 S IBXX=+$$BICOST^IBCRCI(IBRT,3,IBDAY,"OUTPATIENT VISIT DATE")
 S IBUNB(IBDIV,"UNBILOP")=$G(IBUNB(IBDIV,"UNBILOP"))+IBXX
 S IBUNB("UNBILOP")=$G(IBUNB("UNBILOP"))+IBXX
 S IBUNB(IBDIV,"ENCNTRS")=$G(IBUNB(IBDIV,"ENCNTRS"))+1
 S IBUNB("ENCNTRS")=$G(IBUNB("ENCNTRS"))+1
 ;
 I $G(IBXTRACT) S IB(7)=IB(7)+1,IB(8)=IB(8)+IBXX ; For DM extract.
 ;
PRCQ Q
 ;
NOOE ; - If there is no encounter, look for add/edits or registrations.
 ;   Output: IBQUIT will be set to 1 if the visit is non-billable.
 ;   *Pre-set variable IBQUIT required.
 N IBDATA,IBSC,IBSDV,IBXX,IBZERR
 ;
 ; - Check if for a visit at the visit date/time.
 S IBXX=$$EXOE^SDOE(DFN,IBDT,IBDT,"","IBZERR")
 I IBXX D CKENC^IBTUBOU(IBXX,"",.IBQUIT) G NOOEQ
 ;
 ; - Find next add/edit stop code encounter after IBDT.
 D SCAN^IBTUBOU(DFN,IBDT,.IBQUERY)
 ;
NOOEQ Q
 ;
SETUB ; Set array elements for the detail report.
 ; Array element format:
 ; NON-MRA:
 ;  ^TMP($J,"IBTUB",DIVISION,"OPT",NAME@@DFN,DATE,IBX)=bill status^claim type
 ;  ^TMP($J,"IBTUB",DIVISION,"OPT",NAME@@DFN,DATE,IBX,CPT no)=inst rate^prof rate
 ; MRA:
 ;  ^TMP($J,"IBTUB",DIVISION,"OPT_MRA",NAME@@DFN,DATE,IBX,CPT no)=1 if MRA req
 ;
 N IBCTF,IBCPTNM
 I $S($G(IBINMRA):1,1:'$O(IBCPT("MRA",""))) S ^TMP($J,"IBTUB",IBDIV,"OPT",IBNAME_"@@"_DFN,IBDAY,IBX)=IBNCF
 I $G(IBINMRA),$O(IBCPT("MRA","")) S ^TMP($J,"IBTUB",IBDIV,"OPT_MRA",IBNAME_"@@"_DFN,IBDAY,IBX)=1
 G:'IBDET SETUBQ
 I $D(IBCPT) S IBXX=0 F  S IBXX=$O(IBCPT(IBXX)) Q:'IBXX  D
 . S IBCPTNM=$$CODEC^ICPTCOD(IBXX) I IBCPTNM=-1 S IBCPTNM="UNK"
 . S IBCTF=$S($G(IBCPT(IBXX,1)):"I",1:"")
 . S IBCTF=$S($G(IBCPT(IBXX,2)):$S(IBCTF="I":"I,P",1:"P"),1:IBCTF)
 . I $S($G(IBINMRA):1,1:'$O(IBCPT("MRA",""))) S ^TMP($J,"IBTUB",IBDIV,"OPT",IBNAME_"@@"_DFN,IBDAY,IBX,IBCPTNM)=+$G(IBCPT(IBXX,1))_U_+$G(IBCPT(IBXX,2))_U_IBCTF
 . I $G(IBINMRA) S:$G(IBCPT("MRA",IBXX)) ^TMP($J,"IBTUB",IBDIV,"OPT_MRA",IBNAME_"@@"_DFN,IBDAY,IBX,IBCPTNM)=1
 . Q
 ;
SETUBQ Q

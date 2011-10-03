IBAMTV1 ;ALB/CPM - BUILD ARRAY OF BILLABLE EPISODES ; 31-MAY-94
 ;;2.0;INTEGRATED BILLING;**15,33,91,132,153,293**;21-MAR-94;Build 1
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
CARE ; Build an array of episodes to be back-billed.
 ;
 ; Input: IBSTART  --  First date that the patient is Means Test billable
 ;          IBEND  --  Last date that the patient is Means Test billable
 ;            DFN  --  Pointer to the patient in file #2
 ;
 ; Output:  ^TMP("IBAMTV",$J,episode date) = 1^2^3, where
 ;                         1 = adm date for inpatient care
 ;                             visit date for outpatient care
 ;                         2 = disch/last bill date for inpatient care
 ;                             null for outpatient care
 ;                         3 = null for inpatient care
 ;                             softlink for outpatient care
 ;
 K ^TMP("IBAMTV",$J)
 ;
 ; - inpatient at IBSTART?
 S VAINDT=IBSTART\1_.2359 D ADM^VADPT2
 I VADMVT D
 .S IBA=$$ORIG(VADMVT),IBADM=+$G(^DGPM(IBA,0))\1
 .Q:+$$MVT^DGPMOBS(IBA)
 .S IBDIS=+$G(^DGPM(+$P($G(^DGPM(IBA,0)),"^",17),0))\1
 .S:'IBDIS!(IBDIS>IBEND) IBDIS=$$FMADD^XLFDT(IBEND,1)
 .S ^TMP("IBAMTV",$J,IBADM)=(IBSTART\1)_"^"_IBDIS
 ;
 ; - get subsequent admissions
 S IBD="" F  S IBD=$O(^DGPM("ATID1",DFN,IBD)) Q:'IBD!((9999999.9999999-IBD)\1'>IBSTART)  S IBA=+$O(^(IBD,0)) D
 .S IBADM0=$G(^DGPM(IBA,0))
 .Q:+IBADM0>IBEND  ;           adm after end date for MT
 .Q:+$$MVT^DGPMOBS(IBA)  ;       adm for obs & examination
 .Q:$$ASIH^IBAUTL5(IBADM0)  ;  asih admission (catch it later)
 .;
 .S IBDIS=+$G(^DGPM(+$P($G(^DGPM(IBA,0)),"^",17),0))\1
 .S:'IBDIS!(IBDIS>IBEND) IBDIS=$$FMADD^XLFDT(IBEND,1)
 .S ^TMP("IBAMTV",$J,+IBADM0\1)=(+IBADM0\1)_"^"_IBDIS
 ;
 ; Outpatient encounters
 N IBVAL,IBCBK,IBFILTER,IBOE,IBOE0,IBCK,IBT,IBPB,Z
 S IBVAL("DFN")=DFN,IBVAL("BDT")=IBSTART,IBVAL("EDT")=IBEND
 ; Only parent encounters
 S IBFILTER=""
 S IBCBK="I '$P(Y0,U,6) S ^TMP(""IBOE"",$J,+$P(Y0,U,8),Y)=Y0"
 K ^TMP("IBOE",$J)
 D SCAN^IBSDU("PATIENT/DATE",.IBVAL,IBFILTER,IBCBK,1) K ^TMP("DIERR",$J)
 F Z=0:1:6,9,10,13 S IBCK(Z)=""
 S IBT=0 F  S IBT=$O(^TMP("IBOE",$J,IBT)) Q:'IBT  D
 . S IBOE=0 F  S IBOE=$O(^TMP("IBOE",$J,IBT,IBOE)) Q:'IBOE  S IBOE0=$G(^(IBOE)) D
 .. K IBPB
 .. I $$BILLCK^IBAMTEDU(IBOE,IBOE0,.IBCK,.IBPB) D
 ... S Z=$O(IBPB(0)) Q:'Z
 ...;
 ... ;Check any visits for that date for dispositions, add-edits
 ... I Z=3 Q:$D(^TMP("IBAMTV",$J,IBOE0\1))
 ... I Z=2 Q:$S($D(^TMP("IBAMTV",$J,IBOE0\1)):1,1:$$NBCSC^IBEFUNC($P(IBOE0,U,3),IBOE0\1))
 ...;
 ... S ^TMP("IBAMTV",$J,IBOE0\1)=IBOE0\1_U_U_IBOE
 K ^TMP("IBOE",$J)
 ;
 K IBA,IBADM,IBADM0,IBAD,IBD,IBDIS,IBDT,IBI,VAINDT,VADMVT
 ;
 Q
 ;
INP(DATE) ; Was the patient an inpatient on DATE?
 ;  Input:   DATE  --  Date of outpatient visit
 ;           array IBARR
 ; Output:      1  --  Patient was an inpatient on DATE
 ;              0  --  Patient was not
 N X,Y,Z S X=0
 I '$G(DATE) G INPQ
 S Y=0 F  S Y=$O(IBARR(Y)) Q:X!'Y!(Y>DATE)  D
 .S Z=0 F  S Z=$O(IBARR(Y,Z)) Q:'Z  S Z1=$G(IBARR(Y,Z)) I DATE'<+Z1,DATE'>$P(Z1,"^",2) S X=1 Q
INPQ Q X
 ;
ORIG(IBA) ; Find first admission pointer, considering ASIH movements
 ;  Input:  IBA  --  Pointer to admission in #405
 ; Output:    Z  --  Pointer to original admission in #405
 N X,Y,Z S Z=+$G(IBA)
 F  S X=$G(^DGPM(Z,0)),Z=$P(X,"^",14),Y=$P(X,"^",21) Q:Y=""  S Z=Y
 Q Z

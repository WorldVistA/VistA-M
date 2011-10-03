IBCU82 ;ALB/ARH - THIRD PARTY BILLING UTILITIES (AUTOMATED BILLER) ;02 JUL 93
 ;;2.0;INTEGRATED BILLING;**43,55,91,124,160,304,347**;21-MAR-94;Build 24
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;
EVNTCHK(IBTRN) ;special checks to determine if event should be auto billed
 ;checks for INS, non-veteran patient, possible workers comp and tort feasor, admitted for sc cond., outp dental stop, optv while inpt, category covered by ins, non-billable stop or clinic
 ;(assumes that Claims Tracking does the SC check for Outpatients)
 ;input: IBTRN - claims tracking event
 ;       DISP - if true then any error message will be displayed on exit.
 ;output: returns "1^error message" if one of the checks failed, 0 otherwise
 ;
 N X,IBX,IBY,IBZ,IBTRND,IBCAT,IBCOV,DFN,IBEVDT,VAEL,VADMVT,VAINDT S X=0,IBTRND=$G(^IBT(356,+$G(IBTRN),0)) G:IBTRND="" EVNTCQ
 I +$P(IBTRND,U,18)=1,'+$P(IBTRND,U,5) S X="1^Claims Tracking event does not have an associated Inpatient Admission." G EVNTCQ
 I +$P(IBTRND,U,18)=2,'+$P(IBTRND,U,4) S X="1^Claims Tracking event does not have an associated Outpatient Visit." G EVNTCQ
 I +$P(IBTRND,U,18)=4,'+$P(IBTRND,U,8) S X="1^Claims Tracking event does not have an associated prescription in Pharmacy." G EVNTCQ
 I +$P(IBTRND,U,18)=4,$P(IBTRND,U,10)="" S X="1^Claims Tracking event does not have an associated prescription refill in Pharmacy." G EVNTCQ
 ;
 S DFN=+$P(IBTRND,U,2),IBEVDT=$P(IBTRND,U,6) I '$$INSURED^IBCNS1(DFN,IBEVDT) S X="1^Patient not insured for event date." G EVNTCQ
 S IBCAT=$S($P(IBTRND,U,18)=1!($P(IBTRND,U,18)=5):"INPATIENT",$P(IBTRND,U,18)=2:"OUTPATIENT",$P(IBTRND,U,18)=4:"PHARMACY",1:"")
 I IBCAT'="",'$$PTCOV^IBCNSU3(DFN,IBEVDT,IBCAT) S X="1^Patient insurance does not cover "_IBCAT_"." G EVNTCQ
 D ELIG^VADPT S X=0 I 'VAEL(4) S X="1^Patient is not a veteran." G EVNTCQ
 ;
 ;check the last disposition before the episode to see if maybe workers comp or tort feasor
 S IBX=9999999-(IBEVDT\1+1),IBX=$O(^DPT(+DFN,"DIS",IBX)) I +IBX S IBY=$$DT(IBX),IBX=$G(^DPT(DFN,"DIS",IBX,2)) D  G:+X EVNTCQ
 . I $P(IBX,U,1)="Y" S X="1^Need may be related to occupation, check "_IBY_" disposition." Q
 . I $P(IBX,U,4)="Y" S X="1^Need may be related to an accident, check "_IBY_" disposition." Q
 ;
 I +$P(IBTRND,U,5) S IBX=$G(^DGPM(+$P(IBTRND,U,5),0)) D  G EVNTCQ ; inpatient specific
 . I IBX="" S X="1^Inpatient admission movement not found." Q
 . I +$P(IBX,U,11) S X="1^Admitted for an SC condition." Q
 ;
 I +$P(IBTRND,U,4) S IBX=$$SCE^IBSDU(+$P(IBTRND,U,4)) D  G EVNTCQ ; outpatient specific
 . I IBX="" S X="1^Outpatient Encounter not found." Q
 . S IBY=$$NBOE^IBCU81(+$P(IBTRND,U,4),IBX) I +IBY D  Q:+X
 .. ;I +IBY=1 S X="1^Service Connected visit." Q
 .. I +IBY=2 S X="1^Non-billable Stop Code." Q
 .. I +IBY=3 S X="1^Non-billable Clinic." Q
 .. I +IBY=4 S X="1^Non-billable Status: "_$P(IBY,U,2) Q
 . ; dental is generally billed differently
 . I $P($G(^DIC(40.7,+$P(IBX,U,3),0)),U,1)["DENTAL" S X="1^Outpatient visit contains a dental stop code." Q
 . ;outpatient visit was a disposition:  application without exam is not billable
 . I $P(IBX,U,8)=3 D  Q:X
 .. S IBY=$$DISND^IBSDU(+$P(IBTRND,U,4),IBX) ; 0-node of "DIS"
 .. I $P(IBY,U,2)=2 S X="1^Disposition was Application Without Exam." Q
 .. I $P($G(^DIC(37,+$P(IBY,U,7),0)),U,1)="CANCEL WITHOUT EXAM" S X="1^Disposition was Cancel Without Exam." Q
 . ;can not bill twice for same day so ignore outpatient visits if patient was an inpatient at end of day (this means that outpatient visits on the date of discharge will be billed)
 . I $$ADM^IBCU64(DFN,IBEVDT) S X="1^Not Billable: Patient was an inpatient on this visit date."
 ;
 I +$P(IBTRND,U,8) S IBX=$$RXZERO^IBRXUTL(+$P(IBTRND,U,2),+$P(IBTRND,U,8)) D  G EVNTCQ ; rx refills
 . I IBX="" S X="1^Prescription not found in Pharmacy." Q
 . I +$P(IBTRND,U,10)>0 S IBY=$$ZEROSUB^IBRXUTL(+$P(IBTRND,U,2),+$P(IBTRND,U,8),+$P(IBTRND,U,10)) I IBY="" S X="1^Prescription refill not found in Pharmacy." Q
 . S IBZ=$$DBLCHK^IBTRKR31(IBTRN) I 'IBZ S X="1^Can not auto bill this refill, check Claims Tracking." Q
EVNTCQ Q X
 ;
DT(X) ;convert disposition type date/time to external format (9999999-date)
 N Y S Y=0 I +X S Y=9999999-X X ^DD("DD")
 Q Y

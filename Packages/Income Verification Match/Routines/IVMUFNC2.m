IVMUFNC2 ;ALB/SEK - INPATIENT/OUTPATIENT CALCULATIONS (CON'T) ; 24-NOV-93
 ;;2.0;INCOME VERIFICATION MATCH ;**3,11**; 21-OCT-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN(IVMQUERY) ; Calculate number of outpatient days
 ; Input: IVMQUERY("OVIS") - the # of the QUERY this job has open for
 ;    searching for patient's outpatient visits.  If null, this QUERY has
 ;    yet been opened. (pass by reference)
 ;
 ; - find visits on or after IVMMTDT
 N IVMQ
 K ^TMP("DIERR",$J)
 S IVMQ=$G(IVMQUERY("OVIS"))
 I $G(IVMQ) D ACTIVE^SDQ(.IVMQ,"FALSE","SET") ;Reset from previous query
 ;
 I '$G(IVMQ) D
 . D OPEN^SDQ(.IVMQ) Q:'$G(IVMQ)
 . D INDEX^SDQ(.IVMQ,"PATIENT/DATE","SET")
 . D SCANCB^SDQ(.IVMQ,"I '$D(^TMP($J,""IVMUFNC1"",DFN,SDOE0\1)) D VALENC^IVMUFNC2(SDOE,SDOE0)","SET")
 . S IVMQUERY("OVIS")=IVMQ
 ;
 D PAT^SDQ(.IVMQ,DFN,"SET")
 D DATE^SDQ(.IVMQ,IVMMTDT\1,IVMENDT,"SET")
 D ACTIVE^SDQ(.IVMQ,"TRUE","SET")
 D SCAN^SDQ(.IVMQ,"FORWARD")
 K ^TMP("DIERR",$J)
 Q
 ;
VALENC(IVME,IVME0) ; Check for valid outpatient encounter
 ; Input: IVME = encounter ien
 ;        IVME0 = 0-node of encounter (optional)
 N IVMZ,IVMD
 ;
 I $G(IVME0)=""  K ^TMP("DIERR",$J) D GETGEN^SDOE(IVME,"IVMZ") S IVME0=$G(IVMZ(0)) I $D(^TMP("DIERR",$J)) K ^TMP("DIERR",$J) Q
 ;
 S IVMD=IVME0\1
 ;
 Q:$$IGN^IBEFUNC(+$P(IVME0,U,10),IVMD)  ; Not billable appt type
 Q:$P($G(^SC(+($P(IVME0,U,4)),0)),U,17)="Y"  ; non-count clinic
 Q:$$ENCL(IVME)[1  ; claim exposure
 S VAINDT=IVMD+.2359 D ADM^VADPT2 Q:VADMVT  ; was an inpatient
 ;
 S IVMOUT=IVMOUT+1,^TMP($J,"IVMUFNC1",DFN,IVMD)=""
 Q
 ;
ENCL(IVMIBOE) ; Return classification results for an encounter.
 ;  Input:    IVMIBOE  --  Pointer to outpatient encounter in file #409.68
 ;  Output:   ao^ir^sc^ec, where, for each piece,
 ;                      1 - care was related to condition, and
 ;                      0 (or null) - care not related to condition
 N CL,CLD,X,Y S Y=""
 S CL=0 F  S CL=$O(^SDD(409.42,"OE",+$G(IVMIBOE),CL)) Q:'CL  S CLD=$G(^SDD(409.42,CL,0)) I CLD S $P(Y,"^",+CLD)=+$P(CLD,"^",3)
 Q Y
 ;
 ;
END(DFN,IVMPMTD) ; return end date for calculating inpatient/
 ; outpatient days.  this date will be earliest of day before next means
 ; test and day before current date.
 ;  Input:  DFN -- pointer to patient in file #2
 ;          IVMPMTD -- previous means test date
 ;
 N X,IVMICY
 S IVMICY=$$LYR^DGMTSCU1(IVMPMTD)
 S X=$P($$LST^DGMTCOU1(DFN,($E(IVMICY,1,3)+2)_"1231.9999",3),"^",2)
 Q $$FMADD^XLFDT($S(X'>IVMPMTD:DT,X>DT:DT,1:X),-1)_.999999

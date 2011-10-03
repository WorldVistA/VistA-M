IBAMTEDU ;ALB/CPM - MEANS TEST BULLETIN UTILITIES ; 15-JUN-93
 ;;2.0;INTEGRATED BILLING;**15,91,153**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
CHG(IBDAT) ; Any charges billed on or after IBDAT?
 ;  Input:  IBDAT  --  Date on or after which charges have been billed
 ; Output:    0    --  No charges billed
 ;            1    --  Charges were billed; IBARR contains array
 ;                      of those charges
 N IBFND,IBD,IBN,IBX,IBJOB,IBWHER K IBARR
 ;
 ; - if the effective date of the test is today, cancel today's charges.
 I $P(IBDAT,".")=DT D CANC G CHGQ
 ;
 ; - find all charges which may need to be cancelled.
 S IBX="" F  S IBX=$O(^IB("AFDT",DFN,IBX)) Q:'IBX  S IBD=0 F  S IBD=$O(^IB("AFDT",DFN,IBX,IBD)) Q:'IBD  D
 .I $P($G(^IB(IBD,0)),"^",8)'["ADMISSION" D:-IBX'<IBDAT CHK(IBD) Q
 .S IBN=0 F  S IBN=$O(^IB("AF",IBD,IBN)) Q:'IBN  D CHK(IBN)
CHGQ Q +$G(IBFND)
 ;
CHK(IBN) ; Place charge into the array.
 ;  Input:  IBN   --  Charge to check
 N IBND,IBNDL,IBLAST
 S IBND=$G(^IB(IBN,0)) I $P(IBND,"^",15)<IBDAT G CHKQ
 S IBLAST=$$LAST^IBECEAU(+$P(IBND,"^",9)),IBNDL=$G(^IB(+IBLAST,0))
 I $P($G(^IBE(350.1,+$P(IBNDL,"^",3),0)),"^",5)'=2,"^1^2^3^4^8^20^21^"[("^"_$P(IBNDL,"^",5)_"^") S IBARR(+$P(IBNDL,"^",14),IBLAST)="",IBFND=1
CHKQ Q
 ;
CANC ; Cancel any charges for the patient for today.
 N IBD,IBN,IBCRES,IBFAC,IBSITE,IBSERV,IBDUZ
 Q:'$$CHECK^IBECEAU
 S IBCRES=+$O(^IBE(350.3,"B","MT STATUS CHANGED FROM YES",0))
 S:'IBCRES IBCRES=22 S IBJOB=7,IBWHER=30,IBDUZ=DUZ
 S IBD=0 F  S IBD=$O(^IB("AFDT",DFN,-DT,IBD)) Q:'IBD  D
 .I $P($G(^IB(IBD,0)),"^",8)'["ADMISSION" D CANCH^IBECEAU4(IBD,IBCRES,1) Q
 .S IBN=0 F  S IBN=$O(^IB("AF",IBD,IBN)) Q:'IBN  D CANCH^IBECEAU4(IBN,IBCRES,1)
 Q
 ;
 ;
EP(IBDAT) ; Any billable episodes of care since IBDAT?
 ;  Input:  IBDAT  --  Date on or after which patient received care
 ; Output:    0    --  No billable episodes found
 ;            1    --  Billable episodes were found; IBARR contains an
 ;                      array of those episodes
 ;
 N IBD,IBAD,IBNOW,IBEP,IBDT,IBI,IBPM,VA,VAIP,VAERR,IBVAL,IBCBK,IBZ,IBPB
 ;
 ; - quit if the effective date of the test is today
 I $P(IBDAT,".")=DT G EPQ
 ;
 ; - find scheduled visits, stand-alone encounters and dispositions
 ;   on or after IBDAT from the outpatient encounters file
 D NOW^%DTC S IBNOW=%
 K IBARR,^TMP("IBOE",$J)
 S IBVAL("DFN")=DFN,IBVAL("BDT")=IBDAT,IBVAL("EDT")=IBNOW
 ;Consider only parent encounters
 S IBFILTER=""
 S IBCBK="I '$P(Y0,U,6) S ^TMP(""IBOE"",$J,Y)=Y0"
 D SCAN^IBSDU("PATIENT/DATE",.IBVAL,IBFILTER,IBCBK,1) K ^TMP("DIERR",$J)
 F IBZ=0,1,2,9,13 S IBCK(IBZ)=""
 S IBOE=0 F  S IBOE=$O(^TMP("IBOE",$J,IBOE)) Q:'IBOE  S IBOE0=$G(^(IBOE)) D
 . K IBPB
 . S IBEP=$$BILLCK(IBOE,IBOE0,.IBCK,.IBPB)
 . S IBZ=0 F  S IBZ=$O(IBPB(IBZ)) Q:'IBZ  D
 .. I IBZ=1 S IBARR(+IBOE0,"APP")=$P(IBOE0,U,4)_U_$P(IBOE0,U,10)
 .. I IBZ=2 S IBARR(IBOE0\1,"SC"_IBOE)=$P(IBOE0,U,3)_U_$P(IBOE0,U,10)
 .. I IBZ=3 S IBARR(+IBOE0,"R")=$P(IBPB(3),U,7)
 K ^TMP("IBOE",$J)
 ;
 ; - find admissions since IBDAT
 S VAIP("D")=IBDAT D IN5^VADPT I VAIP(13) S IBPM=$G(^DGPM(+VAIP(13),0)),IBARR(+IBPM,"ADM")=$P(IBPM,"^",6),IBEP=1
 S IBD="" F  S IBD=$O(^DGPM("ATID1",DFN,IBD)) Q:'IBD!(9999999.999999-IBD<IBDAT)  S IBPM=$G(^DGPM(+$O(^(IBD,0)),0)),IBARR(+IBPM,"ADM")=$P(IBPM,"^",6),IBEP=1
 ;
EPQ Q +$G(IBEP)
 ;
BILLCK(IBOE,IBOE0,IBCK,IBPB) ; Check for potentially billable outpt enctr
 ; IBOE = encounter ien in file 409.68
 ; IBOE0 = encounter 0-node
 ; IBCK = array subscriptd by # that, if defined, specifies edit to check
 ;        and exclude if it doesn't pass it
 ;        (0) = check if pt claimed exposure
 ;        (1) = check if non-billable appt type for means test
 ;        (2) = check if non-count clinic
 ;        (3) = check if non-billable clinic
 ;        (4) = check if pt not Means Test copay pt
 ;        (5) = check if pt admitted by midnight same date
 ;        (6) = check if C&P exam same date
 ;        (7) = check if non-billable stop code (third party)
 ;        (8) = check if non-billable stop code (auto-biller)
 ;        (9) = check if disposition and application without exam
 ;       (10) = check if non-billable disposition
 ;       (11) = check if service connected (ck parent only)
 ;       (12) = check if non-billable clinic
 ;       (13) = check if appt status is set (cancelled/noshow/inpt/etc)
 ;       (13.1) = same as (13) except don't exclude if encounter status is non-count
 ;       (14) = check if non-billable appt type for report
 ; Returns IBPB = the # of the edit that failed
 ;         IBPB(1) = "" if valid appt
 ;         IBPB(2) = "" if valid add/edit stop code
 ;         IBPB(3) = 0-node of disposition file entry if valid disp
 ; Function returns true if potentially billable or false if not
 N DFN,IBAD,IBD,IBSRCE,QUIT
 S DFN=$P(IBOE0,U,2),IBSRCE=$P(IBOE0,U,8),IBD=IBOE0\1
 I $D(IBCK(0))!($D(IBCK(11))) S QUIT=0 D  G:QUIT BILLCKQ
 . N Z
 . I $D(IBCK(11)),$P(IBOE0,U,6) D  Q:QUIT  ;Check parent encounter
 .. S Z=$$ENCL^IBAMTS2($P(IBOE0,U,6))
 .. I $P(Z,U,3)=1 S QUIT=1,IBPB=11
 . S Z=$$ENCL^IBAMTS2(IBOE)
 . I $D(IBCK(0)),Z[1 S QUIT=1,IBPB=0 Q
 . I $D(IBCK(11)),'$P(IBOE0,U,6),$P(Z,U,3)=1 S QUIT=1,IBPB=11
 I $D(IBCK(4)),'$$BIL^DGMTUB(DFN,+IBOE0) S IBPB=4 G BILLCKQ
 I $D(IBCK(5)),$$INPT^IBAMTS1(DFN,IBD_.2359) S IBPB=5 G BILLCKQ
 I $D(IBCK(6)),$$CNP^IBECEAU(DFN,IBD) S IBPB=6 G BILLCKQ
 ;
 ; - Appointment or stop code
 I "12"[IBSRCE D  G BILLCKQ
 . I $D(IBCK(13))!($D(IBCK(13.1))),IBSRCE=1 D  Q:$G(IBPB)
 .. I '$$APPTCT^IBEFUNC(IBOE0),$S('$D(IBCK(13.1)):1,1:$P(IBOE0,U,12)'=12) S IBPB=13
 . I $D(IBCK(14)),$$RPT^IBEFUNC(+$P(IBOE0,U,10),IBD) S IBPB=14 Q
 . I $D(IBCK(1)),$$IGN^IBEFUNC(+$P(IBOE0,U,10),IBD) S IBPB=1 Q
 . I $D(IBCK(2)),$$NCTCL^IBEFUNC(IBOE) S IBPB=2 Q
 . I $D(IBCK(3)),$$NBCL^IBEFUNC(+$P(IBOE0,U,4),IBD) S IBPB=3 Q
 . I $D(IBCK(7)),$$NBST^IBEFUNC(+$P(IBOE0,U,3),IBD) S IBPB=7 Q
 . I $D(IBCK(8)),$$NBCSC^IBEFUNC(+$P(IBOE0,U,3),IBD) S IBPB=8 Q
 . I $D(IBCK(12)),$$NBCT^IBEFUNC(+$P(IBOE0,U,4),IBD) S IBPB=12 Q
 . ;
 . S IBPB(IBSRCE)=""
 ;
 ; - Disposition
 S IBAD=$$DISND^IBSDU(IBOE,IBOE0)
 I $D(IBCK(9)),'$$DISCT^IBEFUNC(IBOE,IBOE0) S IBPB=9 G BILLCKQ
 I $D(IBCK(10)),$$NBDIS^IBEFUNC(+$P(IBAD,U,7),IBD) S IBPB=10 G BILLCKQ
 S IBPB(3)=IBAD
 ;
BILLCKQ Q ($G(IBPB)="")
 ;

IBAMTV ;ALB/CPM - BACK-BILLING SUPPORT FOR IVM ; 31-MAY-94
 ;;2.0;INTEGRATED BILLING;**15,153**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; Input:     DFN  --  Pointer to the patient in file #2
 ;          DGMTP  --  Zeroth node of previous MT in file #408.31
 ;          DGMTA  --  Zeroth node of verified MT in file #408.31
 ;
 ; - begin back-billing from the original completed date.
 S IBSTART=$P(DGMTA,"^",7) G:'IBSTART!(IBSTART'<DT) END
 S IBEND=$$FMADD^XLFDT(IBSTART\1,364)
 S:IBEND'<DT IBEND=$$FMADD^XLFDT(DT,-1)
 ;
 ; - build array of episodes of care to be billed
 D CARE^IBAMTV1
 ;
 ; - analyze the array and build charges
 I $D(^TMP("IBAMTV",$J)) D BLD^IBAMTV2
 ;
 ; - send a message if any charges need to be reviewed
 I '$D(^IB("AJ",DFN)) G END
 ;
 K IBT S IBPT=$$PT^IBEFUNC(DFN)
 S XMSUB="BACK-BILLING OF MEANS TEST CHARGES"
 S IBT(1)="A verified Means Test has just been received from the IVM Center."
 S IBT(2)="Means Test charges have been back-billed for the following patient:"
 S IBT(3)=" " S IBC=3
 S IBDUZ=DUZ D PAT^IBAERR1
 S IBC=IBC+1,IBT(IBC)=" "
 S IBC=IBC+1,IBT(IBC)="Please note that these charges are on hold, pending a manual review before"
 S IBC=IBC+1,IBT(IBC)="being passed to Accounts Receivable.  Please use the option 'Release Charges"
 S IBC=IBC+1,IBT(IBC)="Pending Review' to review the charges and pass them to Accounts Receivable."
 D SEND^IBACVA2
 ;
END K IBDUZ,IBEND,IBSTART,^TMP("IBAMTV",$J)
 Q
 ;
 ;
CANC ; Cancel Means Test charges if an IVM-verified Means Test is deleted.
 ;  Input:    DFN  --  Pointer to the patient in file #2
 ;          DGMTP  --  Zeroth node of previous MT in file #408.31
 ;          DGMTA  --  Zeroth node of verified MT in file #408.31
 ;
 Q:'$$CHECK^IBECEAU
 S IBCRES=+$O(^IBE(350.3,"B","MT STATUS CHANGED FROM YES",0))
 S:'IBCRES IBCRES=22 S IBJOB=9,IBWHER=30,IBDUZ=DUZ,IBFOUND=0
 S IBST=+DGMTA,IBEND=$$FMADD^XLFDT(IBST,364) S:IBEND>DT IBEND=DT
 S IBZ="" F  S IBZ=$O(^IB("AFDT",DFN,IBZ)) Q:'IBZ  I -IBZ'>IBEND S IBZ1=0 F  S IBZ1=$O(^IB("AFDT",DFN,IBZ,IBZ1)) Q:'IBZ1  D
 .S IBDA=0 F  S IBDA=$O(^IB("AF",IBZ1,IBDA)) Q:'IBDA  D
 ..Q:'$D(^IB(IBDA,0))  S IBX=^(0)
 ..Q:$P(IBX,"^",8)["ADMISSION"  ; skip event records
 ..Q:$P(IBX,"^",9)'=IBDA  ; look only at original actions
 ..S (IBN,IBORIG)=$$LAST^IBECEAU(IBDA),IBND=$G(^IB(IBN,0)),IBND1=$G(^(1))
 ..I IBN=IBDA&($P(IBX,"^",5)=10)!($P($G(^IBE(350.1,+$P(IBND,"^",3),0)),"^",5)=2) Q  ; already cancelled
 ..I $P(IBND,"^",15)<IBST!($P(IBND,"^",14)>IBEND) Q  ; out of range
 ..Q:$$BIL^DGMTUB(DFN,$P(IBND,"^",14))  ; still Means Test billable
 ..D CANCH^IBECEAU4(IBN,IBCRES)
 ..S IBN=$$LAST^IBECEAU(IBDA),IBND=$G(^IB(IBN,0)),IBX=$G(^IB(IBORIG,0))
 ..I IBN=IBDA&($P(IBX,"^",5)=10)!($P($G(^IBE(350.1,+$P(IBND,"^",3),0)),"^",5)=2) S IBFOUND=1 D ADJCL
 ;
 I IBFOUND D CANBULL
 K IBCRES,IBST,IBEND,IBZ,IBZ1,IBDA,IBX,IBN,IBND,IBND1,IBJOB,IBWHER,IBDUZ,IBFOUND,IBORIG
 Q
 ;
CANBULL ; Generate the cancellation bulletin.
 K IBT S IBPT=$$PT^IBEFUNC(DFN)
 S XMSUB="CANCELLATION OF BACK-BILLED MEANS TEST CHARGES"
 S IBT(1)="An IVM-verified Means Test was just deleted for the following patient:"
 S IBT(2)=" " S IBC=2
 S IBDUZ=DUZ D PAT^IBAERR1
 S IBC=IBC+1,IBT(IBC)=" "
 S IBC=IBC+1,IBT(IBC)="All back-billed Means Test charges for this patient were cancelled."
 S IBC=IBC+1,IBT(IBC)="You should review this patient's Means Test billing history and billing"
 S IBC=IBC+1,IBT(IBC)="clock for accuracy, starting on "_$$DAT1^IBOUTL(+DGMTA)_"."
 D SEND^IBACVA2
 K IBDUZ
 Q
 ;
ADJCL ; Roll back the billing clock for cancelled charges.
 ;  Input:   IBX  --  Zeroth node of charge which has been cancelled.
 ;           DFN  --  Pointer to the patient in file #2
 ;
 N IBCL,IBCLD,IBUN,IBCLDAY,IBCHG,IBCLP,IBAP
 Q:$P(IBX,"^",8)["OPT COPAY"  ; no adjustments needed for opt copays
 S IBCL=$$OLDCL^IBAMTV2(DFN,$P(IBX,"^",14)) Q:'IBCL  ; no clock
 S IBCLD=$G(^IBE(351,IBCL,0)) Q:'IBCLD
 ;
 ; - handle per diem charges
 I $P($G(^IBE(350.1,+$P(IBX,"^",3),0)),"^",11)=3 D
 .S IBUN=$P(IBX,"^",6),IBCLDAY=$P(IBCLD,"^",9)
 .S $P(^IBE(351,IBCL,0),"^",9)=$S(IBCLDAY>IBUN:IBCLDAY-IBUN,1:0) D UPD
 ;
 ; - handle inpt copay charges
 I $P($G(^IBE(350.1,+$P(IBX,"^",3),0)),"^",11)=2 D
 .S IBCHG=$P(IBX,"^",7) Q:'IBCHG
 .F IBCLP=8:-1:5 S IBAP=$P(IBCLD,"^",IBCLP) D  Q:'IBCHG
 ..I IBCHG>IBAP S IBCHG=IBCHG-IBAP,$P(^IBE(351,IBCL,0),"^",IBCLP)=0 D UPD Q
 ..S $P(^IBE(351,IBCL,0),"^",IBCLP)=IBAP-IBCHG,IBCHG=0 D UPD
 ;
 Q
 ;
UPD ; Update user and edit date on the Billing Clock.
 D NOW^%DTC S $P(^IBE(351,IBCL,1),"^",3,4)=DUZ_"^"_%
 Q

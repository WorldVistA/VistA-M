IBOHCR ;ALB/ARH - RELEASE/UPDATE A PATIENTS CHARGES ON HOLD ; MAY 2 1997
 ;;2.0;INTEGRATED BILLING;**82**;21-MAR-94
 ;
PTHLD(DFN,IBACT,IBTALK) ; search for all charges on hold due to insurance for a specific patient then update the On Hold Date or release charges
 ;
 ;  Input:   DFN:    pointer to the patient in file #2
 ;           IBACT:  1 if ON HOLD DATE should be updated with todays date
 ;                   2 if charges should be immediately released
 ;           IBTALK: true if error message can be printed to screen
 ;
 ;  Returns: 1 if On Hold charges were found and processed
 ;
 N X,Y,IBPFN,IBX,IBRTN S IBRTN=""
 I '$G(DFN)!('$G(IBACT)) G EXIT
 ;
 ; find all charges on hold for patient then complete action
 S IBPFN=0 F  S IBPFN=$O(^IB("AH",DFN,IBPFN)) Q:'IBPFN  D
 . S IBX=$G(^IB(IBPFN,0)) I $P(IBX,U,5)'=8 Q
 . I IBACT=1 D HLDDT(IBPFN)
 . I IBACT=2 D RELEASE(IBPFN)
 . S IBRTN=1
 ;
EXIT Q IBRTN
 ;
HLDDT(IBPFN) ; update a charge's on hold date to today
 N IBX,IBY,IBERR
 S IBX=$G(^IB(IBPFN,0)) I $P(IBX,U,5)'=8 Q
 I $P($G(^IB(IBPFN,1)),U,6)>DT Q
 ;
 S IBY(350,IBPFN_",",16)=DT D FILE^DIE("K","IBY")
 Q
 ;
RELEASE(IBPFN) ; release a charge on hold
 N IBX,IBSEQNO,IBDUZ,IBNOS,DFN,Y
 S IBX=$G(^IB(IBPFN,0)) I $P(IBX,U,5)'=8 Q
 ;
 S IBSEQNO=1,IBDUZ=DUZ,IBNOS=IBPFN,DFN=+$P(IBX,U,2) D ^IBR
 I $G(Y)<1,+$G(IBTALK),'$D(ZTQUEUED) W !,?5,"Error encountered - a separate bulletin has been posted."
 Q

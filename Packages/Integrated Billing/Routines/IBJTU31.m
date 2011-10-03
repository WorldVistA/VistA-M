IBJTU31 ;ALB/ARH - TPI UTILITIES - INS ; 2/14/95
 ;;2.0;INTEGRATED BILLING;**39,61**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
BPP(IBIFN,ARRAY) ; returns array of patient policy info on all of a bill's carriers
 ; returns PPIFN ^ p/s/t ^ policy node from patient insurance record (2,.312), also adds correct group #/name
 N DFN,IBDM,IBI,IBDFN,IBCDFN,IBGRP K ARRAY S ARRAY=0
 S DFN=$P($G(^DGCR(399,+$G(IBIFN),0)),U,2) I 'DFN G BPPQ
 S IBDM=$G(^DGCR(399,IBIFN,"M")) I 'IBDM G BPPQ
 ;
 F IBI=1,2,3 S IBCDFN="" D  I +IBCDFN S ARRAY(IBI)=IBDFN_U_IBI_U_IBCDFN,ARRAY=IBI
 . S IBDFN=$P(IBDM,U,(IBI+11)) I 'IBDFN,+$P(IBDM,U,IBI) S IBDFN=$O(^DPT(DFN,.312,"B",+$P(IBDM,U,IBI),0))
 . Q:'IBDFN  S IBCDFN=$G(^DPT(DFN,.312,+IBDFN,0)) I 'IBCDFN Q
 . S IBGRP=$G(^IBA(355.3,+$P(IBCDFN,U,18),0)) S:IBGRP'="" $P(IBCDFN,U,3)=$P(IBGRP,U,4),$P(IBCDFN,U,15)=$P(IBGRP,U,3)
BPPQ Q
 ;
PST(IBIFN) ; called by insurance screens ACTION PROTOCOL ENTRY ACTION code, allow user to choose which policy
 ; to display ins screens for default will be either the primary or last viewed
 ; IBPOLICY used by this procedure to define last viewed, must be killed when exiting primary screen (CI)
 ;
 N IBY,IBX,X,Y S IBY=0
 D BPP(IBIFN,.IBX)
 I IBX<1 S IBY=-1 G PSTQ ; bill has no policies
 I IBX=1 S IBY=$O(IBX(0)),IBY=IBX(IBY) G PSTQ ; bill has only primary policy
 S IBPOLICY=$S($G(IBPOLICY):IBPOLICY,1:$O(IBX(0))) I 'IBPOLICY G PSTQ
 W ! D DBPOL(.IBX)
 S DIR("?")="Only policies associated with this bill may be chosen: Primary, Secondary, or Tertiary."
 S DIR(0)="SOB^P:Primary;S:Secondary;T:Tertiary",DIR(0)=$P(DIR(0),";",1,IBX)
 S DIR("A")="Select Policy",DIR("B")=$S(IBPOLICY=2:"S",IBPOLICY=3:"T",1:"P") D ^DIR K DIR
 I Y?1U S IBY=$S(Y="P":1,Y="S":2,Y="T":3,1:0),IBPOLICY=IBY,IBY=$G(IBX(IBY))
PSTQ Q IBY
 ;
DBPOL(IBINS) ; display patient policy info for all carriers of a bill, input array from BPP
 ;
 N IBI,IBCDFN,IBCNS0
 W !,?12,"Carrier",?39,"Subscriber ID",?62,"Group #",!,?12,"--------------------------------------------------------------------"
 ;
 S IBI=0 F  S IBI=$O(IBINS(IBI)) Q:'IBI  D
 . S IBCDFN=$P(IBINS(IBI),U,3,99),IBCNS0=$G(^DIC(36,+IBCDFN,0))
 . W !,$S(IBI=2:"Secondary",IBI=3:"Tertiary",1:"Primary")_": ",?12,$E($P(IBCNS0,U,1),1,25),?39,$P(IBCDFN,U,2),?62,$P(IBCDFN,U,3)
 W !
DBPOLQ Q
 ;
MINS(IBIFN) ;Called by IBJT LIST TEMPLATE screens and RCRC LIST TEMPLATES
 ; Return true if Bill has multiple Insurance Policies
 N IBDM,IBY S IBY=0
 S IBDM=$G(^DGCR(399,IBIFN,"M"))
 S IBY=$S(+$P(IBDM,U,13):1,+$P(IBDM,U,14):1,1:0)
MINSQ Q IBY
 ;
REF(IBIFN) ;Called by IBJT LIST TEMPLATE screens
 ;Return Referral Date if Bill is Referred
 N IBRDT,X
 S IBRDT="IBRDT"
 D DIQ^RCJIBFN2(IBIFN,64,.IBRDT)
REFQ Q +$G(IBRDT(430,IBIFN,64,"I"))
 ;IBJTU31

IBCNSC3 ;ALB/NLR - INACTIVATE AND REPOINT INS STUFF1 ; 20-APR-93
 ;;Version 2.0 ; INTEGRATED BILLING ;**28,46,68**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
RPTASK ; -- ask if user wishes to repoint patients to active insurance company
 ;
 S DIR(0)="YO",DIR("A")="DO YOU WISH TO REPOINT "_$S(IBC=1:"THIS PATIENT",1:"THESE PATIENTS")_" TO ANOTHER INSURANCE COMPANY",DIR("B")="No"
 W ! D ^DIR K DIR I 'Y!$D(DIRUT) D:$G(IBCOV) COVD G RPTASKQ
 ;
 ; - select company to which policies/plans should be repointed
 S DIC="^DIC(36,",DIC(0)="QEAZ",DIC("A")="REPOINT "_$S(IBC=1:"THIS PATIENT",1:"THESE PATIENTS")_" TO WHICH (ACTIVE) INSURANCE COMPANY: ",DIC("S")="I +$P(^(0),U,5)=0,+$P(^(0),U,16)'=Y,$G(IBCNS)'=Y",DIC("W")="D ID^IBCNSCD3"
 W ! D ^DIC K DIC S IBR=+Y I Y<1!$D(DIRUT) D:$G(IBCOV) COVD G RPTASKQ
 ;
 ; - save the new company in the inactivated company
 S DA=IBCNS,DR=".16////"_IBR,DIE="^DIC(36," D ^DIE K DIE,DA,DR
 ;
 ; - repoint patient policy information
 S DFN=0 F  S DFN=$O(^DPT("AB",IBCNS,DFN)) Q:'DFN  D
 .S IBD=0 F  S IBD=$O(^DPT("AB",IBCNS,DFN,IBD)) Q:'IBD  D
 ..;
 ..; - repoint the policy to the new company
 ..S IBXXX='$G(^DPT(DFN,.312,IBD,1))
 ..S DIE="^DPT(DFN,.312,",DA(1)=DFN,DA=IBD,DR=".01///`"_IBR_";1.05///NOW;1.06////"_DUZ D ^DIE K DIE,DA,DR
 ..I IBXXX S $P(^DPT(DFN,.312,IBD,1),"^",1,2)="^"
 ..;
 ..; - repoint Insurance Reviews to the new company
 ..S IBX=0 F  S IBX=$O(^IBT(356.2,"D",DFN,IBX)) Q:'IBX  I $P($G(^IBT(356.2,IBX,1)),"^",5)=IBD S DIE="^IBT(356.2,",DA=IBX,DR=".08////"_IBR D ^DIE K DIE,DA,DR
 .;
 .; - adjust 'Covered by Insurance' prompt
 .D COV^IBCNSJ(DFN)
 ;
 ; - repoint all plans
 S IBD=0 F  S IBD=$O(^IBA(355.3,"B",IBCNS,IBD)) Q:'IBD  D
 .S DIE="^IBA(355.3,",DA=IBD,DR=".01///`"_IBR D ^DIE K DIE,DA,DR
 ;
RPTASKQ K DIRUT,DTOUT,DUOUT,DIROUT,DFN,IBD,IBR,IBX,IBXXX
 Q
 ;
COVD ; Adjust 'Covered by Insurance' prompt for repointed patients
 S DFN=0 F  S DFN=$O(^DPT("AB",IBCNS,DFN)) Q:'DFN  D COV^IBCNSJ(DFN)
 Q
 ;
 ;
 ;
VERIFY ; -- allow user to change mind about inactivating company
 ;
 S DIR("B")="No",DIR(0)="YO",DIR("A")="ARE YOU REALLY SURE YOU WISH TO INACTIVATE "_IBN
 S DIR("?",1)="You are about to change "_IBN_" to inactive."
 S DIR("?",2)="This means you will no longer be able to bill "
 S DIR("?")=IBN_" for its patients' charges."
 W ! D ^DIR K DIR I $D(DIRUT) S IBQUIT=1
 S:Y IBV=1
 Q
 ;
HDR ; -- print header
 ;
 N X,TAB
 W:$E(IOST,1,2)["C-"!($G(IBPAG)) @IOF
 S IBPAG=$G(IBPAG)+1
 W !,?1,"PATIENTS WITH "_$S(+IBV=0:"ACTIVE",+IBV=1:"INACTIVATED")_" INSURANCE, "_$P(^DIC(36,IBCNS,0),U),?69,"PAGE ",IBPAG,?77,$$DAT1^IBOUTL(DT)
 ;
 ; - display Insurance Company name and address.
 S X=$G(^DIC(36,+IBCNS,.11)),TAB=$S('IBV:33,1:38)
 W:$P(X,"^")]"" !?TAB,$P(X,"^")
 W:$P(X,"^",2)]"" !?TAB,$P(X,"^",2)
 W:$P(X,"^",3)]"" !?TAB,$P(X,"^",3)
 W:$P(X,"^")]""!($P(X,"^",2)]"")!($P(X,"^",3)]"") !?TAB
 W $P(X,"^",4) W:$P(X,"^",4)]""&($P(X,"^",5)]"") ", "
 W $P($G(^DIC(5,+$P(X,"^",5),0)),"^")
 W:$P(X,"^",6)]""&($P(X,"^",4)]""!($P(X,"^",5)]"")) "   "
 W $E($P(X,"^",6),1,5),$S($E($P(X,"^",6),6,9)]"":"-"_$E($P(X,"^",6),6,9),1:"")
 ;
 W !?1,"PATIENT",?31,"PATIENT ID",?45,"IR?",?52,"EFF DATE",?63,"EXP DATE",?74,"SUBSCR ID",?95,"WHOSE INS",?106,"EMPLOYER",!
 W $TR($J(" ",IOM)," ","-")
 Q
 ;
BUILD ; -- set list of patients in ^tmp array
 ;
 K ^TMP($J,"IBCNSC2")
 S DFN=0 F  S DFN=$O(^DPT("AB",IBCNS,DFN)) Q:'DFN  D
 .D COV^IBCNSJ(DFN)
 .S X=$$PT^IBEFUNC(DFN),IBNA=$P(X,U,1),IBNO=$P(X,U,2)
 .S:IBNA="" IBNA="<Pt. "_DFN_" Name Missing>"
 .S IBD=0 F  S IBD=$O(^DPT("AB",IBCNS,DFN,IBD)) Q:'IBD  D
 ..S IBIND=$G(^DPT(DFN,.312,IBD,0))
 ..I IBCNS'=$P(+IBIND,U) Q  ;bad x-ref,maybe later take action
 ..D SET
 Q
 ;
SET ; -- store data to be printed in temp array
 ;
 ; ^tmp($j,"ibcnsc2",patient name,dfn,ien of policy) =
 ;    patient id^IR?^effective date^expiration date^subscriber id^whose insurance^employer
 ;
 S IBWI=$P(IBIND,"^",6)
 S VAOA("A")=$S(IBWI="v":5,IBWI="s":6,1:5)
 D OAD^VADPT
 S ^TMP($J,"IBCNSC2",IBNA,DFN,IBD)=IBNO_"^"_$S($$IR^IBCNSJ21(DFN,IBD):"Y",1:"N")_"^"_$P(IBIND,"^",8)_U_$P(IBIND,"^",4)_"^"_$P(IBIND,"^",2)_"^"_IBWI_"^"_VAOA(9)
 Q

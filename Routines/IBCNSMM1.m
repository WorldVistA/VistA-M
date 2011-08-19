IBCNSMM1 ;ALB/CMS -MEDICARE INSURANCE INTAKE (CONT) ; 11/8/06 9:32am
 ;;2.0;INTEGRATED BILLING;**103,359**;21-MAR-94;Build 9
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
SETP(IBP) ; -- Stuff data fields in patient policy
 ;  Required Input:
 ;  IBP =A for Part A, B for Part B
 ;  DFN =pt. ien
 ;  IBCDFN =patient policy ien
 ;  IBNAME =Name of Insured
 ;  IBHICN =Subscriber ID
 ;  IBAEFF =Effective Date of Plan A
 ;  IBBEFF =Effective Date of Plan B
 ;  IBCNSP =Medicare (WNR) ien ^Part A ien ^Part B ien
 ;  IBCOBI =Coordination of Benefits (Internal value)
 ;
 N D,DA,DIE,DR,IBBDA,X,Y
 I '$D(^DPT(DFN,.312,+IBCDFN,0)) G SETPQ
 ;
 ; -- Stuff the pt. policy fields
 ;   #2  *Group Number              #.18  Group Plan
 ;   #6  Whose Ins.                 #.2   COB
 ;   #8  Effective Date of Policy   #1    Sub. ID
 ;   #15 *Group Name                #17   Name of Insured
 ;   #16 Pt. Relationship to Insured
 ;
 S DIE="^DPT("_DFN_",.312,",DA=+IBCDFN,DA(1)=DFN
 S DR="2///"_$S(IBP="A":$P(IBCNSP,U,4),IBP="B":$P(IBCNSP,U,6),1:"")
 S DR=DR_";17///"_IBNAME_";1///"_IBHICN
 S DR=DR_";6///v;8///"_$S(IBP="A":$G(IBAEFF),IBP="B":$G(IBBEFF),1:"")
 S DR=DR_";.2////"_IBCOBI_";15///"_$S(IBP="A":"PART A",IBP="B":"PART B",1:"")
 S DR=DR_";16///01;.18////"_$S(IBP="A":+$P(IBCNSP,U,3),IBP="B":+$P(IBCNSP,U,5),1:"")
 D ^DIE
 ;
 ;  -- Update Insurance Event
 S IBCOVP=$P($G(^DPT(DFN,.31)),U,11)
 D BEFORE^IBCNSEVT S IBNEW=1
 ;
 ; -- Ask to Verify at this time
 K DIR S DIR("A")="Verify Medicare (WNR) Part "_IBP_" Coverage Now"
 S DIR("?")="Enter 'No' to not Verify Coverage at this time."
 W ! S IBOK=0 D OK I 'IBOK G SETEV
 ;
 ; -- Check to see if Pt. Name = name of Insured
 I IBNAME'=$P($G(^DPT(DFN,0)),U,1) D
 .W !!,"WARNING: Patient Name: '"_$P($G(^DPT(DFN,0)),U,1)_"'  DOES NOT MATCH"
 .W !,"      Name of Insured: '"_IBNAME_"'.",!
 ;
 ; -- verify policy
 S DIE="^DPT("_DFN_",.312,",DA=IBCDFN,DA(1)=DFN
 S DR="1.03///NOW;1.04////"_DUZ D ^DIE
 W !,"  PART "_IBP_" COVERAGE VERIFIED."
 ;
SETEV ; -- Update Insurance event
 N X,Y
 D COVERED^IBCNSM31(DFN,IBCOVP)
 I $G(IBCDFN)>0,IBNEW=1 D AFTER^IBCNSEVT,^IBCNSEVT
 ;
SETPQ Q
 ;
 ;
BUFF(IBP) ; -- Set IBBUF array with policy info for Buffer File
 ; Return: IBBUF array
 ;    IBBUF(355.33 field #s)=corresponding policy, plan and company data
 ;    i.e.  IBBUF(20.01)=Insurance Company Name
 ;          IBBUF(40.02)=Group Name
 ;          IBBUF(60.01)=DFN
 ;
 ; Input: DFN, IBCNSP, IBNAME, IBHICN, IBAEFF, IBBEFF, IBCOBI
 ;           
 ; Auto stuff other fields
 ;
 N IBP0 K IBBUF S IBBUF=""
 S IBBUF(.03)=$G(IBSOUR)
 S IBBUF(20.01)=$P(IBCNSP,U,2)
 S IBBUF(40.02)=$S(IBP="A":$P(IBCNSP,U,4),IBP="B":$P(IBCNSP,U,6),1:"")
 S IBBUF(40.03)=IBBUF(40.02)
 S IBBUF(60.01)=+DFN
 S IBBUF(60.02)=$S(IBP="A":IBAEFF,IBP="B":IBBEFF,1:"")
 S IBBUF(60.04)=IBHICN
 S IBBUF(60.05)="v"
 S IBBUF(60.06)="01"
 S IBBUF(60.07)=IBNAME
 S IBBUF(60.12)=IBCOBI
 S IBBDA=$$ADDSTF^IBCNBES(1,DFN,.IBBUF)
 I +IBBDA W !,?3,$P(IBCNSP,U,2)," PART "_IBP_" entry #"_+IBBDA_" added to Insurance Buffer File."
 I 'IBBDA W !,*7,?3,"Warning: Could not add new policy Part "_IBP_" in Buffer File.",!,?13,"("_$P(IBBDA,U,2)_")",!
 Q
 ;
OK ; -- ask okay
 N DTOUT,DIROUT,DIRUT,DUOUT,X,Y
 ; Returns:
 ; IBQUIT=1 Exit user timedout
 ;   IBOK=1 Yes
 ;   IBOK=0 No
 S IBQUIT=0,DIR(0)="Y",DIR("B")="YES" W !
 I $G(DIR("A"))="" S DIR("A")="Is this Data Correct"
 I $G(DIR("?"))="" S DIR("?")="Enter 'No' to edit Medicare Card information"
 D ^DIR K DIR
 I $D(DTOUT) S IBQUIT=1
 S IBOK=$G(Y) I IBOK["^" S IBQUIT=1
 Q
 ;
GETWNR() ; -- Find and return the MEDICARE (WNR) ien
 ;         -- Returns Error message or
 ;            DIC(36 IEN ^"MEDICARE (WNR)"^IBA(355.3 PART A IEN ^"PART A"^ IBA(355.3 PART B IEN ^"PART B"
 ;
 N IBWNR,IB0,IBP0,IBQ,IBPQ,IBPX,IBX,IBY,IBPGN
 S IBY="MEDICARE (WNR)",IBQ=0
 S IBX=0 F  S IBX=$O(^DIC(36,"B",IBY,IBX)) Q:('IBX)  D  Q:IBQ
 .S IB0=$G(^DIC(36,IBX,0))
 .K IBWNR("INS")
 .I $P(IB0,U,1)'=IBY Q  ;name
 .I $P(IB0,U,2)'="N" Q  ;Reimb?
 .;I '$P(IB0,U,3) Q  ;Sig Req.  --> removed edit, cm, 5/18/99
 .I $P(IB0,U,5) Q  ;Inactive
 .I $P($G(^IBE(355.2,+$P(IB0,U,13),0)),U)'="MEDICARE" Q  ;Major Cat.
 .S IBWNR("INS")=IBX_U_IBY
 .;
 .; -- Must have Active Group Plan Category Medicare Part A and B
 .;
 .K IBWNR("A"),IBWNR("B")
 .S IBPX=0 F  S IBPX=$O(^IBA(355.3,"B",IBX,IBPX)) Q:('IBPX)!(IBQ)  D
 ..S IBP0=$G(^IBA(355.3,IBPX,0))
 ..I $P(IBP0,U,11) Q  ;Inactive
 ..I $P(IBP0,U,14)'="A",$P(IBP0,U,14)'="B" Q  ;Not Plan Category Part A or B 
 ..S IBPGN=$TR($P(IBP0,U,3),"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ..I IBPGN'="PART A",IBPGN'="PART B" Q  ;excludes non PART A and PART B plans
 ..S IBWNR($P(IBP0,U,14))=IBPX_U_$P(IBP0,U,3)
 ..I $G(IBWNR("A")),$G(IBWNR("B")) S IBQ=1
 ;
 S IBX=$G(IBWNR("INS"))_U_$G(IBWNR("A"))_U_$G(IBWNR("B"))
 I 'IBX S IBX="Error: Standard Medicare (WNR) Insurance Company not setup properly." G GETWNRQ
 I '$P(IBX,U,3) S IBX="Error: Standard Medicare (WNR) plan PART A not setup properly." G GETWNRQ
 I '$G(IBWNR("B")) S IBX="Error: Standard Medicare (WNR) plan PART B not setup properly."
GETWNRQ Q IBX

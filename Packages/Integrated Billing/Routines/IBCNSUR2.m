IBCNSUR2 ;ALB/CPM/CMS - MOVE SUBSCRIBERS TO DIFFERENT PLAN (CON'T) ; 09-SEP-96
 ;;2.0;INTEGRATED BILLING;**103,238,399**;21-MAR-94;Build 8
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
PL ; Display old plan attributes; allow new plan to be edited
 N IBP0,DA
 W @IOF,!!,"Now you may edit specific Plan attributes and Coverage Limitations."
 W !,"(Plan 1 is the plan subscribers moved from.)"
 W !,"(Plan 2 is the plan subscribers moved to.)"
 W !,$TR($J("",71)," ","=")
 W !,"'Plan 1' Attributes for: ",IBC1N
 S IBP0=$G(^IBA(355.3,IBP1,0)),DA=+IBP1
 W !?9,"Plan Name: ",IBP1N,?43,"Plan Number: ",IBP1X
 W !,$TR($J("",71)," ","-")
 W !,?19,"TYPE OF PLAN:  ",$S($P(IBP0,"^",9):$P($G(^IBE(355.1,+$P(IBP0,"^",9),0)),"^"),1:"<Not Specified")
 W !,?11,"ELECTRONIC PLAN TYPE:  ",$$EXPAND^IBTRE(355.3,.15,$P(IBP0,U,15)) ; TJH *238
 I $P(IBP0,U,14)]"" W !,?18,"PLAN CATEGORY:  ",$$EXPAND^IBTRE(355.3,.14,$P(IBP0,U,14))
 W !,?9,"PLAN FILING TIME FRAME:  ",$P(IBP0,U,13) I +$P(IBP0,U,16) W "  (",$$FTFN^IBCNSU31(IBP1),")"
 W !," IS UTILIZATION REVIEW REQUIRED:  ",$$YN($P(IBP0,"^",5))
 W !,"  AMBULATORY CARE CERTIFICATION:  ",$$EXPAND^IBTRE(355.3,.12,$P(IBP0,U,12))
 W !,"  IS PRE-CERTIFICATION REQUIRED:  ",$$YN($P(IBP0,"^",6))
 W !,"EXCLUDE PRE-EXISTING CONDITIONS:  ",$$YN($P(IBP0,"^",7))
 W !?12,"BENEFITS ASSIGNABLE:  ",$$YN($P(IBP0,"^",8))
 W !,$TR($J("",71)," ","=")
 ;
 W !!,"Editing 'Plan 2' Attributes for: ",IBC2N
 S IBP0=$G(^IBA(355.3,IBP2,0))
 W !?9,"Plan Name: ",IBP2N,?43,"Plan Number: ",IBP2X,!
 ;
 S DIE="^IBA(355.3,",DA=IBP2
 S DR=".09;.15;I $P($G(^IBE(355.1,+$P($G(^IBA(355.3,DA,0)),U,9),0)),U,3)'=5 S Y=""@10"";.14;@10;.16;I '$$FTFV^IBCNSU31(X) S Y=""@13"";.17;@13;.13;.05;.12;.06:.08"
 D ^DIE K DA,DIE,DR
 ;
 Q
 ;
 ;
YN(X) ; Resolve the 'Yes/No' value.
 Q $S($G(X)="":"<Not Specified>",X:"YES",X=0:"NO",1:"<Not Specified>")
 ;
 ;
LIM ; Display/Edit Coverage Limitations.
 W @IOF,!,$TR($J("",71)," ","=")
 D LIMDSP(IBC1,IBP1,1)
 W !,$TR($J("",71)," ","-")
 D LIMDSP(IBC2,IBP2,2)
 W !,$TR($J("",71)," ","=")
 ;
 ; - does the user wish to edit the plan coverage limitations?
 S DIR(0)="Y",DIR("A")="Do you wish to edit the 'Plan 2' Coverage Limitations"
 S DIR("?")="If you wish to edit the coverage limitations for the new plan, enter 'Yes.'"
 D ^DIR K DIR,DIRUT,DIROUT,DUOUT,DTOUT I 'Y G LIMQ
 ;
 ; - allow the edit of coverage limitations for plan 2
 W !!,"Editing 'Plan 2' Coverage Limitations for: ",IBC2N
 S IBX=$G(^IBA(355.3,IBP2,0))
 W !?9,"Plan Name: ",IBP2N,?43,"Plan Number: ",IBP2X
 ;
 S IBCPOL=IBP2 D EDCOV^IBCNSJ51 K VALMBCK
 ; The call below is to clean up List Man variables from IBCNSJ51
 ; the call to FULL^VALM sets variables. Or modify IBCNSJ51
 S IBROU="IBCNSJ51",IBTOP="T" D EN^VALM(IBROU,IBTOP) K IBROU,IBTOP
 ;
LIMQ Q
 ;
 ;
LIMDSP(IBC,IBP,IBPNUM) ; Display coverage limitations for a company/plan.
 N IBCOV,IBCOVD,IBCOVFN,IBCNT,IBP0,IBLEDT,IBLIM,IBLINE,IBX,IB0,IBS
 W !!," 'Plan ",IBPNUM,"' Coverage Limitations for ",$S(IBPNUM=1:IBC1N,1:IBC2N)
 S IBP0=$G(^IBA(355.3,IBP,0))
 W !?9,"Plan Name: ",$S($P(IBP0,U,3)]"":$P(IBP0,U,3),1:"<Not Specified>")
 W ?43,"Plan Number: ",$S($P(IBP0,U,4)]"":$P(IBP0,U,4),1:"<Not Specified>")
 W !!,"  Coverage            Effective Date   Covered?       Limit Comments"
 W !,"  --------            --------------   --------       --------------"
 ;
 ; - display limitation for each type of coverage
 S IBLIM=0 F  S IBLIM=$O(^IBE(355.31,IBLIM)) Q:'IBLIM  S IBCOV=$P($G(^(IBLIM,0)),U) D
 .S IBCNT=0
 .S IBLEDT="" F  S IBLEDT=$O(^IBA(355.32,"APCD",IBP,IBLIM,IBLEDT)) Q:$S(IBLEDT="":IBCNT,1:0)  D  Q:IBLEDT=""
 ..S IBCOVFN=+$O(^IBA(355.32,"APCD",IBP,IBLIM,+IBLEDT,"")),IBCOVD=$G(^IBA(355.32,+IBCOVFN,0))
 ..S IBCNT=IBCNT+1
 ..I IBCOVD="" S IBW="  "_$E(IBCOV_$J("",18),1,18)_$J("",19)_"BY DEFAULT" W !,IBW Q
 ..S IBX="  "_$E($S(IBCNT=1:IBCOV,1:"")_$J("",18),1,18) ;Don't dup category
 ..S IBX=IBX_"  "_$E($$DAT1^IBOUTL($P(IBLEDT,"-",2))_$J("",8),1,8)_$J("",9)_$S($P(IBCOVD,U,4):$S($P(IBCOVD,U,4)<2:"YES"_$J("",8),$P(IBCOVD,U,4)=2:"CONDITIONAL",1:"UNKNOWN    "),1:"NO"_$J("",9))_$J("",4)
 ..W !,IBX
 ..S (IBS,IB0)=0 F  S IB0=$O(^IBA(355.32,IBCOVFN,2,IB0)) Q:'IB0  W:IBS ! W ?54,$G(^(IB0,0)) S IBS=1
 ;
 Q

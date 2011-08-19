IBCNSJ21 ;ALB/CPM - CHANGE POLICY PLAN (CON'T) ; 12-JAN-95
 ;;Version 2.0 ; INTEGRATED BILLING ;**28**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
NOTES ; Display any necessary notes to the user.
 N IBS S IBS=0
 S IBIP='$P(IBPLAND,"^",2) I IBIP S IBS=1 W !,"Please note that this is an Individual Plan."
 I $P(IBPLAND,"^",11) S IBS=1 W !,*7,"This plan is currently inactive."
 D BU I $O(IBBU(0)) S IBS=1 W !,*7,"There are Benefits Used associated with this plan!"
 I $O(^IBA(355.7,"APP",DFN,IBCDFN,0)) S IBS=1 W !,*7,"This patient has riders associated with this policy!"
 I $$IR(DFN,IBCDFN) S IBS=1 W !,*7,"There are insurance reviews associated with this policy."
 W:IBS !
 Q
 ;
BU ; Are there any benefits used for this plan and policy?
 ;  Input variables required:
 ;         DFN  --  ptr to patient in file #2
 ;      IBPLAN  --  ptr to policy plan in file #355.3
 ;      IBCDFN  --  ptr to policy in sub-file #2.312
 ;
 ;  Output variable array:
 ;   IBBU(X)=Y  --  array of benefits used associated with the policy,
 ;                  where X is the benefit year, and Y points to the bu
 ;                  in file #355.5
 N DATE,POL
 S DATE="" F  S DATE=$O(^IBA(355.5,"APPY",DFN,IBPLAN,DATE)) Q:DATE=""  D
 .S POL=0 F  S POL=$O(^IBA(355.5,"APPY",DFN,IBPLAN,DATE,POL)) Q:'POL  I POL=IBCDFN S IBBU(-DATE)=$O(^(POL,0))
 Q
 ;
AB ; Find all Annual Benefits associated with an Insurance Plan.
 ;  Input variables required:
 ;    IBCPOL  --  ptr to proposed plan in file #355.3
 ;
 ;  Output variable array:
 ;   IBAB(X)  --  array of annual benefits, where X is the benefit year
 ;
 N X S X=""
 F  S X=$O(^IBA(355.4,"APY",IBCPOL,X)) Q:X=""  S IBAB(-X)=""
 Q
 ;
IR(DFN,IBCDFN) ; Are there any Insurance reviews associated with the policy?
 ;  Input:     DFN  --  Pointer to the patient in file #2
 ;          IBCDFN  --  Pointer to the policy in file #2.312
 ; Output:       1  --  There are associated insurance reviews, or
 ;               0  --  there are not.
 N X,Y S X=0
 I $G(DFN),$G(IBCDFN) S Y=0 F  S Y=$O(^IBT(356.2,"D",DFN,Y)) Q:'Y  I $P($G(^IBT(356.2,Y,1)),"^",5)=IBCDFN S X=1 Q
 Q X
 ;
DMBU ; Display mergeable benefits used.
 N IBMRG
 S X=0 F  S X=$O(IBAB(X)) Q:'X  S IBMRG(X)=""
 S X=0 F  S X=$O(IBBU(X)) Q:'X  S IBMRG(X)=""
 W !!," Existing Benefit Used Yr",?31,"Annual Benefit for Proposed Plan",?66,"Merge BU?",!
 S X=0 F  S X=$O(IBMRG(X)) Q:'X  D
 .W ! W:$D(IBBU(X)) ?6,$$DAT2^IBOUTL(X) W:$D(IBAB(X)) ?40,$$DAT2^IBOUTL(X)
 .W ?69 I '$D(IBAB(X)) W "NO" S IBMRGN=1 Q
 .I '$D(IBBU(X)) W "-na-" Q
 .S IBMRGF(X)=IBBU(X) W "YES"
 Q
 ;
MD ; Merge/delete benefits used, if necessary.
 I $G(IBMERGE) D
 .W !,"Merging previous benefits used into the new plan... "
 .S IBX="" F  S IBX=$O(IBMRGF(IBX)) Q:IBX=""  D MERG^IBCNSJ13(IBCPOL,+IBMRGF(IBX)) K IBBU(IBX)
 .W "done."
 ;
 ; - delete any remaining benefits used
 I $O(IBBU(0)) D
 .W !,"Deleting previous benefits used... "
 .S IBX="" F  S IBX=$O(IBBU(IBX)) Q:IBX=""  D DBU^IBCNSJ(IBBU(IBX))
 .W "done."
MDQ Q
 ;
HLSW ; Reader help for switching plans.
 W !!,"If you wish to change the subscribed-to plan the newly-",$S($G(IBNEWP):"added",1:"selected")," plan,"
 W !,"enter 'YES'.  Otherwise, enter 'NO'."
 Q:'$O(IBBU(0))
 W !!,"If you change the plan for this policy, "
 I '$G(IBMERGE)!'$O(IBMRGF(0)) W "all existing benefits will be deleted." Q
 I '$G(IBMRGN) W "all existing benefits will be merged." Q
 W "all transferable benefits",!,"will be merged.  All others will be deleted."
 Q

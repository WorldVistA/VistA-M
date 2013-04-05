IB20P339 ;ALB/ARH - IB*2.0*339 POST INIT: IB SHAD/SWA SUPPORT ; 02-JAN-2006
 ;;2.0;INTEGRATED BILLING;**339**;21-MAR-94;Build 2
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
POST ;
 N IBA S IBA(1)="",IBA(2)="    IB Support for SHAD/SWA Post-Install .....",IBA(3)="" D MES^XPDUTL(.IBA) K IBA
 ;
 D ADDRNB ; Add PROJECT 112/SHAD Reason Not Billable (#356.8)
 D ADDCRR ; Add PROJECT 112/SHAD Charge Removal Reason (#350.3)
 ;
 D UPDRNB ; Replace ENV. CONTAM. with SOUTHWEST ASIA Reason Not Billable (#356.8)
 D UPDCRR ; Replace ENV CONTAMINANT RELATED with SOUTHWEST ASIA RELATED Charge Removal Reason (#350.3)
 ;
 S IBA(1)="",IBA(2)="    IB Support for SHAD/SWA Post-Install Complete",IBA(3)="" D MES^XPDUTL(.IBA) K IBA
 Q
 ;
 ;
ADDRNB ; Add Reason Not Billable of PROJECT 112/SHAD (#356.8)
 N IBA,IBJ,IBNX,IBRNB,DD,DO,DINUM,DLAYGO,DIC,DIE,DA,DR,X,Y
 ;
 S IBRNB="PROJECT 112/SHAD"
 ;
 I $O(^IBE(356.8,"B",IBRNB,0)) S IBA(1)="    >>> "_IBRNB_" Reason Not Billable (#356.8) exists, not re-added." G ADDRNBQ
 ;
 F IBJ=32:1 S IBNX=$G(^IBE(356.8,IBJ,0)) I IBNX="" S DINUM=IBJ Q  ; find next available ien, before 999
 ;
 K DD,DO S DLAYGO=356.8,DIC="^IBE(356.8,",DIC(0)="L",X=IBRNB D FILE^DICN K DIC
 I Y<1 S IBA(1)="    >>> Unable to add "_IBRNB_" Reason Not Billable (#356.8), contact Support." G ADDRNBQ
 ;
 S IBA(1)="    >>> "_IBRNB_" Reason Not Billable (#356.8) Added."
 ;
ADDRNBQ D MES^XPDUTL(.IBA)
 Q
 ;
 ;
ADDCRR ; Add Charge Removal Reason of PROJECT 112/SHAD (#350.3)
 N IBA,IBJ,IBNX,IBCRR,IBABBR,IBLMT,IBFN,DD,DO,DINUM,DLAYGO,DIC,DIE,DA,DR,X,Y
 ;
 S IBCRR="PROJECT 112/SHAD",IBABBR="SHAD",IBLMT="GENERIC"
 ;
 I $O(^IBE(350.3,"B",IBCRR,0)) S IBA(1)="    >>> "_IBCRR_" Charge Removal Reason (#350.3) exists, not re-added." G ADDCRRQ
 ;
 F IBJ=46:1 S IBNX=$G(^IBE(350.3,IBJ,0)) I IBNX="" S DINUM=IBJ Q  ; find next available ien
 ;
 K DD,DO S DLAYGO=350.3,DIC="^IBE(350.3,",DIC(0)="L",X=IBCRR D FILE^DICN S IBFN=+Y
 I Y<1 S IBA(1)="    >>> Unable to add "_IBCRR_" Charge Removal Reason (#350.3), contact Support." G ADDCRRQ
 ;
 S DIE="^IBE(350.3,",DA=+IBFN,DR=".02///"_IBABBR_";.03///"_IBLMT D ^DIE
 ;
 S IBA(1)="    >>> "_IBCRR_" Charge Removal Reason (#350.3) Added."
 ;
ADDCRRQ D MES^XPDUTL(.IBA)
 Q
 ;
 ;
UPDRNB ; Update Reason Not Billable of ENV. CONTAM. with SOUTHWEST ASIA (#356.8)
 N IBA,IBFN,IBRNBO,IBRNBN,DD,DO,DINUM,DLAYGO,DIC,DIE,DA,DR,X,Y
 ;
 S IBRNBO="ENV. CONTAM."
 S IBRNBN="SOUTHWEST ASIA"
 ;
 I $O(^IBE(356.8,"B",IBRNBN,0)) S IBA(1)="    >>> "_IBRNBN_" Reason Not Billable (#356.8) exists, not re-added." G UPDRNBQ
 ;
 S IBFN=$O(^IBE(356.8,"B",IBRNBO,0)) I 'IBFN S IBA(1)="    >>> ERROR: "_IBRNBO_" Reason Not Billable (#356.8) not found, could not be replaced, contact support." G UPDRNBQ
 ;
 S DIE="^IBE(356.8,",DA=+IBFN,DR=".01///"_IBRNBN D ^DIE
 ;
 S IBA(1)="    >>> "_IBRNBO_" Reason Not Billable (#356.8) Replaced with "_IBRNBN
 ;
UPDRNBQ D MES^XPDUTL(.IBA)
 Q
 ;
 ;
UPDCRR ; Update Charge Removal Reason of ENV CONTAMINANT RELATED with SOUTHWEST ASIA RELATED (#350.3)
 N IBA,IBFN,IBCRRO,IBCRRN,DD,DO,DINUM,DLAYGO,DIC,DIE,DA,DR,X,Y
 ;
 S IBCRRO="ENV CONTAMINANT RELATED"
 S IBCRRN="SOUTHWEST ASIA RELATED"
 ;
 I $O(^IBE(350.3,"B",IBCRRN,0)) S IBA(1)="    >>> "_IBCRRN_" Charge Removal Reason (#350.3) exists, not re-added." G UPDCRRQ
 ;
 S IBFN=$O(^IBE(350.3,"B",IBCRRO,0)) I 'IBFN S IBA(1)="    >>> ERROR: "_IBCRRO_" Charge Removal Reason (#350.3) not found, could not be replaced, contact support." G UPDCRRQ
 ;
 S DIE="^IBE(350.3,",DA=+IBFN,DR=".01///"_IBCRRN_";.02///SWA" D ^DIE
 ;
 S IBA(1)="    >>> "_IBCRRO_" Charge Removal Reason (#350.3) Replaced with "_IBCRRN
 ;
UPDCRRQ D MES^XPDUTL(.IBA)
 Q
 ;
 ;
MSG(X) ;
 N IBX S IBX=$O(IBA(999999),-1) S:'IBX IBX=1 S IBX=IBX+1
 S IBA(IBX)=$G(X)
 Q

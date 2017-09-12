IBYPSC ;ALB/ARH - IB*2.0*287 POST INIT: REASONABLE CHARGES V2.2 ; 12/01/04
 ;;2.0;INTEGRATED BILLING;**287**;21-MAR-94
 ; 
 Q
 ;
POST ; post-init routine for IB*2*287 Reasonable Charges v2.2
 N IBA
 S IBA(1)="",IBA(2)="    IB*2*287 Post-Install .....",IBA(3)="" D MES^XPDUTL(.IBA) K IBA
 ;
 D RVA ; activate Revenue Codes (399.2,2)
 ;
 D RVD^IBYPSC1 ; delete existing Revenue Code - CPT Links (#363.33)
 D RVL^IBYPSC1 ; add new/updated Revenue Code - CPT Links (#363.33)
 ;
 S IBA(1)="",IBA(2)="    IB*2*287 Post-Install Complete",IBA(3)="" D MES^XPDUTL(.IBA) K IBA
 Q
 ;
 ;
 ;
RVA ; activate Revenue Codes exported in RV-CPT links (399.2,2), if currently inactive
 N IBA,IBLN,IBI,IBRV,IBRVFN,IBRVLN,IBACT,IBCNT,IBJ,DD,DO,DIC,DIE,DA,DR,X,Y S IBCNT=0,IBACT=""
 ;
 S IBLN=$P($T(FRVA+1),";;",2)
 ;
 F IBI=1:1 S IBRV=$P(IBLN,",",IBI) Q:IBRV'?3N  D
 . ;
 . S IBRVFN=$O(^DGCR(399.2,"B",IBRV,0)) Q:'IBRVFN
 . S IBRVLN=$G(^DGCR(399.2,+IBRVFN,0)) Q:IBRVLN=""
 . I +$P(IBRVLN,U,3) Q
 . ;
 . S IBCNT=IBCNT+1,IBACT=IBACT_IBRV_","
 . S DR="2////1",DIE="^DGCR(399.2,",DA=+IBRVFN D ^DIE K DIE,DIC,DA,DR,X,Y
 ;
 I IBCNT>0 S IBJ=0 F IBI=1:15 S IBJ=IBJ+15 S IBLN=$P(IBACT,",",IBI,IBJ) Q:IBLN=""  D MSG("         "_IBLN)
 ;
RVAQ S IBA(1)="    >> "_IBCNT_" Revenue Codes activated (399.2)..." D MSG(" ")
 D MES^XPDUTL(.IBA)
 Q
 ;
 ;
MSG(X) ; 
 N IBX S IBX=$O(IBA(999999),-1) S:'IBX IBX=1 S IBX=IBX+1
 S IBA(IBX)=$G(X)
 Q
 ;
FRVA ;  Revenue Codes to Activate (399.2,2)
 ;;900,
 ;;

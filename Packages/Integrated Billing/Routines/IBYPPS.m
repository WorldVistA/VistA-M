IBYPPS ;ALB/ARH - IB*2*119 POST INIT: UPDATE REVENUE CODES AND LINKS ; 09/07/99
 ;;2.0;INTEGRATED BILLING;**119**;21-MAR-94
 ; 
 Q
POST ;
 N IBA
 S IBA(1)="",IBA(2)="    IB*2*119 Post-Install .....",IBA(3)="" D MES^XPDUTL(.IBA) K IBA
 ;
 D RVN ; new revenue codes, 38
 D RVU ; update revenue codes, 50
 D RVI ; inactivate revenue codes, 10
 D RVA ; activate revenue codes, 3
 D RVL ; add new revenue code - CPT links, 1
 ;
 S IBA(1)="",IBA(2)="    IB*2*119 Post-Install Complete",IBA(3)="" D MES^XPDUTL(.IBA) K IBA
 ;
 Q
 ;
RVA ; activate 3 Revenue Codes exported in RV-CPT links (399.2,2), if currently inactive
 ; (771 and 904 links exported with RC patch but rv not activated because was not defined)
 N IBA,IBLN,IBI,IBRV,IBRVFN,IBRVLN,IBCNG,IBCNT,IBJ,DD,DO,DIC,DIE,DA,DR,X,Y S IBCNT=0,IBCNG=""
 ;
 S IBLN=$P($T(FRVA+1^IBYPPS1),";;",2)
 ;
 F IBI=1:1 S IBRV=$P(IBLN,",",IBI) Q:IBRV'?3N  D
 . ;
 . S IBRVFN=$O(^DGCR(399.2,"B",IBRV,0)) Q:'IBRVFN
 . S IBRVLN=$G(^DGCR(399.2,+IBRVFN,0)) Q:IBRVLN=""
 . I +$P(IBRVLN,U,3) Q
 . ;
 . S IBCNT=IBCNT+1,IBCNG=IBCNG_IBRV_","
 . S DR="2////1",DIE="^DGCR(399.2,",DA=+IBRVFN D ^DIE K DIE,DIC,DA,DR,X,Y
 ;
 I IBCNT>0 S IBJ=0 F IBI=1:15 S IBJ=IBJ+15 S IBLN=$P(IBCNG,",",IBI,IBJ) Q:IBLN=""  D MSG("         "_IBLN)
 ;
RVAQ S IBA(1)="      >> "_IBCNT_" Revenue Codes activated (399.2)..." D MSG(" ")
 D MES^XPDUTL(.IBA)
 Q
 ;
RVI ; inactivate 10 Revenue Codes (399.2,2)
 ; (no longer valid revenue codes according to NUBC)
 N IBA,IBLN,IBI,IBRV,IBRVFN,IBRVLN,IBCNG,IBCNT,IBJ,DD,DO,DIC,DIE,DA,DR,X,Y S IBCNT=0,IBCNG=""
 ;
 F IBI=1:1 S IBLN=$P($T(FRVI+IBI^IBYPPS1),";;",2) Q:IBLN=""  D
 . ;
 . S IBRV=$P(IBLN,U,1) Q:IBRV'?3N
 . ;
 . S IBRVFN=$O(^DGCR(399.2,"B",IBRV,0)) Q:'IBRVFN
 . S IBRVLN=$G(^DGCR(399.2,+IBRVFN,0)) Q:IBRVLN=""
 . ;
 . S IBCNT=IBCNT+1,IBCNG=IBCNG_IBRV_","
 . S DR="2////0",DIE="^DGCR(399.2,",DA=+IBRVFN D ^DIE K DIE,DIC,DA,DR,X,Y
 ;
 I IBCNT>0 S IBJ=0 F IBI=1:15 S IBJ=IBJ+15 S IBLN=$P(IBCNG,",",IBI,IBJ) Q:IBLN=""  D MSG("         "_IBLN)
 ;
RVIQ S IBA(1)="      >> "_IBCNT_" Revenue Codes inactivated (399.2)..." D MSG(" ")
 D MES^XPDUTL(.IBA)
 Q
 ;
RVU ; update 50 Revenue Codes (399.2)
 ; (update abbreviation and description to match current NUBC, previously different definitions)
 N IBA,IBLN,IBI,IBRV,IBRVFN,IBCNG,IBCNT,IBJ,DD,DO,DIC,DIE,DA,DR,X,Y S IBCNT=0,IBCNG=""
 ;
 F IBI=1:1 S IBLN=$P($T(FRVU+IBI^IBYPPS1),";;",2,999) Q:IBLN=""  D
 . ;
 . S IBRV=$P(IBLN,U,1) Q:IBRV'?3N
 . S IBRVFN=$O(^DGCR(399.2,"B",IBRV,0)) Q:'IBRVFN
 . ;
 . S IBCNT=IBCNT+1,IBCNG=IBCNG_IBRV_","
 . S DR="1///"_$P(IBLN,U,2)_";3///"_$P(IBLN,U,3),DIE="^DGCR(399.2,",DA=+IBRVFN D ^DIE K DIE,DIC,DA,DR,X,Y
 ;
 I IBCNT>0 S IBJ=0 F IBI=1:15 S IBJ=IBJ+15 S IBLN=$P(IBCNG,",",IBI,IBJ) Q:IBLN=""  D MSG("         "_IBLN)
 ;
RVUQ S IBA(1)="      >> "_IBCNT_" Revenue Codes updated (399.2)..." D MSG(" ")
 D MES^XPDUTL(.IBA)
 Q
 ;
RVN ; add 38 new Revenue Codes (399.2)
 ; (update abbreviation and description to match current NUBC, previously all reserved)
 N IBA,IBLN,IBI,IBRV,IBRVFN,IBCNG,IBCNT,IBJ,DD,DO,DIC,DIE,DA,DR,X,Y S IBCNT=0,IBCNG=""
 ;
 F IBI=1:1 S IBLN=$P($T(FRVN+IBI^IBYPPS1),";;",2,999) Q:IBLN=""  D
 . ;
 . S IBRV=$P(IBLN,U,1) Q:IBRV'?3N
 . S IBRVFN=$O(^DGCR(399.2,"B",IBRV,0)) Q:'IBRVFN
 . ;
 . S IBCNT=IBCNT+1,IBCNG=IBCNG_IBRV_","
 . S DR="1///"_$P(IBLN,U,2)_";3///"_$P(IBLN,U,3),DIE="^DGCR(399.2,",DA=+IBRVFN D ^DIE K DIE,DIC,DA,DR,X,Y
 ;
 I IBCNT>0 S IBJ=0 F IBI=1:15 S IBJ=IBJ+15 S IBLN=$P(IBCNG,",",IBI,IBJ) Q:IBLN=""  D MSG("         "_IBLN)
 ;
RVNQ S IBA(1)="      >> "_IBCNT_" New Revenue Codes added (399.2)..." D MSG(" ")
 D MES^XPDUTL(.IBA)
 Q
 ;
RVL ; add 4 Revenue Codes - CPT links for observation care (363.33)
 N IBA,IBLN,IBI,IBSGFN,IBRV,IBRVFN,IBRVLN,IBLINK,IBP1,IBP2,IBCNT,DD,DO,DIC,DIE,DA,DR,X,Y,DLAYGO S IBCNT=0
 ;
 S IBSGFN=$O(^IBE(363.32,"B","STANDARD RVCD LINKS",0)) I 'IBSGFN D MSG("         ** STANDARD RVCD LINKS Special Group not found, no links added.")
 ;
 I +IBSGFN F IBI=1:1 S IBLN=$P($T(FRVL+IBI^IBYPPS1),";;",2,999) Q:IBLN=""  D
 . ;
 . S IBRV=$P(IBLN,U,1) Q:IBRV'?3N
 . S IBLINK=IBRV_": "_$P(IBLN,U,2)_$S($P(IBLN,U,3)'="":"-",1:"")_$P(IBLN,U,3)
 . ;
 . S IBRVFN=$O(^DGCR(399.2,"B",IBRV,0)) Q:'IBRVFN
 . S IBRVLN=$G(^DGCR(399.2,+IBRVFN,0)) Q:IBRVLN=""
 . I $P(IBRVLN,U,2)["*RESERVED" Q
 . ;
 . Q:$P(IBLN,U,2)=""
 . S IBP1=$O(^ICPT("B",$P(IBLN,U,2),0)) Q:'IBP1
 . S IBP2="" I $P(IBLN,U,3)'="" S IBP2=$O(^ICPT("B",$P(IBLN,U,3),0)) Q:'IBP2
 . ;
 . I $O(^IBE(363.33,"AGP",IBSGFN,IBP1,0)) D MSG("         ** "_IBLINK_", not added, a link already exists for "_$P(IBLN,U,2)) Q
 . ;
 . S IBCNT=IBCNT+1
 . S DIC("DR")=".02////"_+IBSGFN_";.03////"_+IBP1 I +IBP2 S DIC("DR")=DIC("DR")_";.04////"_+IBP2
 . K DD,DO S DLAYGO=363.33,DIC="^IBE(363.33,",DIC(0)="L",X=+IBRVFN D FILE^DICN K DIC,X,Y
 . ;
 . D MSG("         "_IBLINK_" added")
 ;
RVLQ S IBA(1)="      >> "_IBCNT_" New Revenue Code - CPT Links added (363.33)..." D MSG(" ")
 D MES^XPDUTL(.IBA)
 Q
 ;
 ;
MSG(X) ; 
 N IBX S IBX=$O(IBA(999999),-1) S:'IBX IBX=1 S IBX=IBX+1
 S IBA(IBX)=$G(X)
 Q

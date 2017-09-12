IBYPPT ;ALB/ARH - IB*2*134 POST INIT: UPDATE PROVIDER DISCOUNT AND REVENUE CODES AND CONDITION CODES ; 05/25/00
 ;;2.0;INTEGRATED BILLING;**134**;21-MAR-94
 ; 
 Q
POST ;
 N IBA
 S IBA(1)="",IBA(2)="    IB*2*134 Post-Install .....",IBA(3)="" D MES^XPDUTL(.IBA) K IBA
 ;
 D CCE ; update condition codes, 1
 D CCA ; add condition codes, 2
 D RVN ; add revenue codes, 2
 ;
 D PDDEL^IBYPPT1 ; delete all Provider Discount Sets and Links (363.34) for RC PROVIDER DISCOUNTS Special Group
 D PDADD^IBYPPT1 ; add new Provider Discount Sets and Links (363.34) for RC PROVIDER DISCOUNTS Special Group
 ;
 S IBA(1)="",IBA(2)="    IB*2*134 Post-Install Complete",IBA(3)="" D MES^XPDUTL(.IBA) K IBA
 ;
 Q
 ;
 ;
RVN ; add 2 new Revenue Codes (399.2)
 ; (update abbreviation and description to match current NUBC, previously all reserved)
 N IBA,IBLN,IBI,IBRV,IBRVFN,IBCNG,IBCNT,IBJ,DD,DO,DIC,DIE,DA,DR,X,Y S IBCNT=0,IBCNG=""
 ;
 F IBI=1:1 S IBLN=$P($T(FRVN+IBI),";;",2,999) Q:IBLN=""  D
 . ;
 . S IBRV=$P(IBLN,U,1) Q:IBRV'?3N
 . S IBRVFN=$O(^DGCR(399.2,"B",IBRV,0)) Q:'IBRVFN
 . ;
 . S IBCNT=IBCNT+1,IBCNG=IBCNG_IBRV_","
 . S DR="1///"_$P(IBLN,U,2)_";3///"_$P(IBLN,U,3),DIE="^DGCR(399.2,",DA=+IBRVFN D ^DIE K DIE,DIC,DA,DR,X,Y
 ;
 I IBCNT>0 S IBJ=0 F IBI=1:15 S IBJ=IBJ+15 S IBLN=$P(IBCNG,",",IBI,IBJ) Q:IBLN=""  D MSG("         "_IBLN)
 ;
RVNQ S IBA(1)="    >> "_IBCNT_" Revenue Codes added (399.2)..." D MSG(" ")
 D MES^XPDUTL(.IBA)
 Q
 ;
 ;
MSG(X) ; 
 N IBX S IBX=$O(IBA(999999),-1) S:'IBX IBX=1 S IBX=IBX+1
 S IBA(IBX)=$G(X)
 Q
 ;
 ;
FRVN ; New Revenue Codes
 ;;951^ATHLETIC TRAINING^ATHLETIC TRAINING
 ;;952^KINESIOTHERAPY^KINESIOTHERAPY
 ;;
 Q
 ;
MCCRUTL(X,P) ; returns IFN of item in 399.1 if Code is found and piece P is true
 ;
 N IBX,IBY S IBY=""
 I $G(X)'="" S IBX=0 F  S IBX=$O(^DGCR(399.1,"C",X,IBX)) Q:'IBX  I $P($G(^DGCR(399.1,IBX,0)),U,+$G(P)) S IBY=IBX
 Q IBY
 ;
CCE ; Edit Condition Codes in 399.1 (#.22 - p15)  update Name field (.01)
 N DINUM,DLAYGO,DIC,DIE,DD,DO,DA,DR,X,Y,IBA,IBI,IBLN,IBCNT,IBJ,IBFN,IBDNM S IBCNT=0
 ;
 F IBI=1:1 S IBLN=$P($T(FCCE+IBI),";;",2) Q:IBLN=""  I $E(IBLN,1)'=" " D
 . ;
 . S IBFN=$$MCCRUTL($P(IBLN,U,1),15) Q:'IBFN
 . ;
 . S DR=".01////"_$P(IBLN,U,2)
 . S DIE="^DGCR(399.1,",DA=+IBFN D ^DIE K DIE,DA,DR,X,Y S IBCNT=IBCNT+1
 ;
CCEQ S IBA(1)="    >> "_IBCNT_" Condition Codes updated (399.1)"
 D MES^XPDUTL(.IBA)
 Q
 ;
CCA ; Add Condition Codes to 399.1 (#.22 - p15)
 ; due to the conversion the condition codes must have IFNs greater than 79
 N DINUM,DLAYGO,DIC,DIE,DD,DO,DA,DR,X,Y,IBA,IBI,IBLN,IBCNT,IBJ,IBFN,IBDNM S IBCNT=0
 ;
 S IBDNM=$O(^DGCR(399.1,200),-1) I IBDNM'>79 S IBDNM=79
 ;
 F IBI=1:1 S IBLN=$P($T(FCCA+IBI),";;",2) Q:IBLN=""  I $E(IBLN,1)'=" " D
 . ;
 . I +$$MCCRUTL($P(IBLN,U,1),15) Q
 . ;
 . F IBJ=1:1 S IBDNM=IBDNM+1 Q:'$D(^DGCR(399.1,IBDNM,0))
 . ;
 . K DD,DO S DLAYGO=399.1,DINUM=IBDNM,DIC="^DGCR(399.1,",DIC(0)="L",X=$P(IBLN,U,2) D FILE^DICN K DIC I Y<1 K X,Y Q
 . S IBFN=+Y,IBCNT=IBCNT+1
 . ;
 . S DR=".02////"_$P(IBLN,U,1)_";.22////"_1
 . S DIE="^DGCR(399.1,",DA=+IBFN D ^DIE K DIE,DA,DR,X,Y
 ;
CCAQ S IBA(1)="    >> "_IBCNT_" Condition Codes added (399.1)"
 D MES^XPDUTL(.IBA)
 Q
 ;
FCCA ; add condition codes (399.1)
 ;; 
 ;;58^TERMINATED MEDICARE+CHOICE ORGANIZATION ENROLLEE
 ;;G0^DISTINCT MEDICAL VISIT
 ;;
FCCE ; edit condition codes (399.1)
 ;; 
 ;;72^SELF CARE IN UNIT
 ;;

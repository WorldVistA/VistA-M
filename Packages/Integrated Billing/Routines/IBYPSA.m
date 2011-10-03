IBYPSA ;ALB/ARH - IB*2.0*245 POST INIT: REASONABLE CHARGES V2.0 ; 10-OCT-2003
 ;;2.0;INTEGRATED BILLING;**245**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
 Q
 ;
POST ;
 N IBA
 S IBA(1)="",IBA(2)="    Reasonable Charges v2.0 Post-Install .....",IBA(3)="" D MES^XPDUTL(.IBA) K IBA
 ;
 D RSINDT ; add Rate Schedule Inactive dates (363, .06)
 ;
 D UPDBR ; update Billing Rate Names for v2.0 (363.3)
 ;
 D ADDRB^IBYPSA1 ; add Billable Service  (399.1, .2)
 D ADDBS^IBYPSA1 ; add Bedsections  (399.1,.12)
 D ADDBI^IBYPSA1 ; add Billable Items   (363.21)
 D ADDRS^IBYPSA1 ; add Rate Schedule   (363)
 D ADDBR^IBYPSA1 ; add Billing Rates   (363.3)
 ;
 D SGBR ; add Billing Rates to Special Groups  (363.32,11,.01)
 D RVACT ; activate 3 Revenue Codes (399.2,2)
 ;
 D CHGINA^IBYPSA2("") ; inactivate all RC charges in #363.2
 ;
 S IBA(1)="",IBA(2)="    Reasonable Charges v2.0 Post-Install Complete",IBA(3)="" D MES^XPDUTL(.IBA) K IBA
 ;
 Q
 ;
 ;
RSINDT ; add an inactive date to rate schedules if this is the first time the load is completed (363, .06)
 ; Reimbursable Ins, No Fault, and Workers Comp only
 ; if test account use 9/30/98, if production account use 8/31/99
 N IBA,IBRSFN,IBRS0,IBRSN,IBCNT,IBSTDT,DD,DO,DIC,DIE,DA,DR,X,Y S IBSTDT="",IBCNT=0
 ;
 I $O(^IBE(363.3,"B","RC PHYSICIAN MN",0)) G RSINQ
 ;
 S IBSTDT=$$VERSEDT^IBCRHBRV(1.4) ;I '$$PROD^IBCORC S IBSTDT=2980930
 ;
 S IBRSFN=0 F  S IBRSFN=$O(^IBE(363,IBRSFN)) Q:'IBRSFN  D
 . S IBRS0=$G(^IBE(363,IBRSFN,0)),IBRSN=$E(IBRS0,1,3)
 . I IBRSN'="RI-",IBRSN'="NF-",IBRSN'="WC-" Q
 . I $P(IBRS0,U,5)'<IBSTDT Q
 . I $P(IBRS0,U,6)'="" Q
 . ;
 . S IBCNT=IBCNT+1,DR=".06////"_IBSTDT,DIE="^IBE(363,",DA=+IBRSFN D ^DIE K DIE,DA,DR,X,Y
 ;
RSINQ S IBA(1)="      >> "_IBCNT_" Rate Schedules inactivated on "_$E(IBSTDT,4,5)_"/"_$E(IBSTDT,6,7)_"/"_$E(IBSTDT,2,3)_" (363)..."
 D MES^XPDUTL(.IBA)
 Q
 ;
UPDBR ; Update Billing Rate Names
 N IBA,IBDA,IBCNT,DD,DO,DINUM,DLAYGO,DIC,DIE,DA,DR,X,Y S IBCNT=0
 ;
 S DA=$O(^IBE(363.3,"B","RC OUTPATIENT FACILITY","")) I +DA D
 . S DR=".01///RC FACILITY PR;.02///RC F/PR" S DIE="^IBE(363.3," D ^DIE K DIE,DA,DR,X,Y
 . D MSG("             RC OUTPATIENT FACILITY to RC FACILITY PR") S IBCNT=IBCNT+1
 ;
 S DA=$O(^IBE(363.3,"B","RC PHYSICIAN","")) I +DA D
 . S DR=".01///RC PHYSICIAN PR;.02///RC P/PR" S DIE="^IBE(363.3," D ^DIE K DIE,DA,DR,X,Y
 . D MSG("             RC PHYSICIAN to RC PHYSICIAN PR") S IBCNT=IBCNT+1
 ;
 S IBA(1)="      >> "_IBCNT_" Billing Rate Names Updated (363.3)..."
 D MES^XPDUTL(.IBA)
 Q
 ;
SGBR ; add new Billing Rates to the Special Groups (363.32,11,.01)
 N IBA,IBSET,IBSG,IBSGFN,IBBR,IBBRFN,IBCNT,DINUM,DD,DO,DLAYGO,DIC,DIE,DA,DR,X,Y,IBBRNM S IBCNT=0
 ;
 F IBSET="STANDARD RVCD LINKS^RC FACILITY","STANDARD RVCD LINKS^RC PHYSICIAN","RC PROVIDER DISCOUNTS^RC PHYSICIAN" D
 . S IBSG=$P(IBSET,U,1) Q:IBSG=""  S IBSGFN=$O(^IBE(363.32,"B",IBSG,0)) Q:'IBSGFN
 . S IBBR=$P(IBSET,U,2) Q:IBBR=""
 . ;
 . S IBBRNM=IBBR F  S IBBRNM=$O(^IBE(363.3,"B",IBBRNM)) Q:IBBRNM'[IBBR  D
 .. ;
 .. S IBBRFN=$O(^IBE(363.3,"B",IBBRNM,0)) Q:'IBBRFN
 .. I +$P($G(^IBE(363.3,+IBBRFN,0)),U,4)'=2 Q  ; cpt charges only
 .. ;
 .. I $O(^IBE(363.32,+IBSGFN,11,"B",+IBBRFN,0)) Q
 .. ;
 .. S DLAYGO=363.32,DA(1)=+IBSGFN,DIC="^IBE(363.32,"_DA(1)_",11,",DIC(0)="L",X=IBBRNM,DIC("P")="363.3211PA" D ^DIC K DIC,DIE S IBCNT=IBCNT+1
 ;
SGBRQ S IBA(1)="      >> "_IBCNT_" Billing Rates added to Special Groups (363.32)..."
 D MES^XPDUTL(.IBA)
 Q
 ;
RVACT ; activate (3) Revenue Codes exported in as defaults for new Charge Sets (399.2,2)
 N IBA,IBLN,IBI,IBRVFN,IBACT,IBCNT,IBJ,DD,DO,DIC,DIE,DA,DR,X,Y S IBCNT=0,IBACT=""
 ;
 S IBLN=$P($T(RVF+1),";;",2)
 ;
 F IBI=1:1 S IBRVFN=$P(IBLN,",",IBI) Q:'IBRVFN  D
 . ;
 . I +$P($G(^DGCR(399.2,IBRVFN,0)),U,3) Q
 . ;
 . S IBACT=IBACT_IBRVFN_","
 . S IBCNT=IBCNT+1,DR="2////1",DIE="^DGCR(399.2,",DA=+IBRVFN D ^DIE K DIE,DA,DR,X,Y
 ;
 I IBCNT>0 S IBJ=0 F IBI=1:15 S IBJ=IBJ+15 S IBLN=$P(IBACT,",",IBI,IBJ) Q:IBLN=""  D MSG("             "_IBLN)
 ;
RVAQ S IBA(1)="      >> "_IBCNT_" Revenue Codes activated (399.2)..."
 D MES^XPDUTL(.IBA)
 Q
 ;
MCCRUTL(X,P) ; returns IFN of item in 399.1 if Name is found and piece P is true
 N IBX,IBY S IBY=""
 I $G(X)'="" S IBX=0 F  S IBX=$O(^DGCR(399.1,"B",X,IBX)) Q:'IBX  I $P($G(^DGCR(399.1,IBX,0)),U,+$G(P)) S IBY=IBX
 Q IBY
 ;
MSG(X) ;
 N IBX S IBX=$O(IBA(999999),-1) S:'IBX IBX=1 S IBX=IBX+1
 S IBA(IBX)=$G(X)
 Q
 ;
RVF ;  Revenue Codes to (3) Activate (399.2,2)
 ;;190,200,912,
 ;;

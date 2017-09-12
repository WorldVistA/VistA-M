IBYPPR ;ALB/ARH - IB*2.0*106 PRE/POST INIT:  REASONABLE CHARGES ; 10-OCT-1998
 ;;2.0;INTEGRATED BILLING;**106**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
 Q
PRE ; in 399, delete all xrefs for certain fields, these fields are all exported with this patch
 ; they must be deleted before the build inserts the updated fields because the xrefs have changed
 N IBX,X,Y,DIK,DA,IBFLD,IBXREF
 ;
 D BMES^XPDUTL("Pre-Installation Updates (Cross references will be updated during install)")
 ;
 F IBFLD=135,151 D
 . ;
 . S IBXREF=0 F  S IBXREF=$O(^DD(399,IBFLD,1,IBXREF)) Q:'IBXREF  D
 .. S DIK="^DD(399,"_IBFLD_",1,",DA(2)=399,DA(1)=IBFLD,DA=IBXREF
 .. D ^DIK K DIK,DA
 . S IBX="   >> ^DGCR(399,"_IBFLD_") cross references deleted." D MES^XPDUTL(IBX)
 ;
 F IBFLD=.01,1,5,6 D
 . ;
 . S IBXREF=0 F  S IBXREF=$O(^DD(399.0304,IBFLD,1,IBXREF)) Q:'IBXREF  D
 .. S DIK="^DD(399.0304,"_IBFLD_",1,",DA(2)=399.0304,DA(1)=IBFLD,DA=IBXREF
 .. D ^DIK K DIK,DA
 . S IBX="   >> ^DGCR(399,304,"_IBFLD_") cross references deleted." D MES^XPDUTL(IBX)
 ;
 ; Output Formatter Updates:  the Data Element (364.7,.03) of a field has changed, update this before the
 ; installation so the incoming field can match correctly with the existing field
 N OLD,NEW,DIC,DIE,DR,X,Y
 ;
 ; change ACCEPT ASSIGNMENT (BX-27) (357) from N-GET FROM PREVIOUS EXTRACT (5) to N-ASSIGN OF BENEFITS INDICATOR (24)
 ; 
 S DA=357
 S OLD=$O(^IBA(364.5,"B","N-GET FROM PREVIOUS EXTRACT",0))
 S NEW=$O(^IBA(364.5,"B","N-ASSIGN OF BENEFITS INDICATOR",0))
 I +OLD,+NEW,$P($G(^IBA(364.7,DA,0)),U,3)=OLD S DIE="^IBA(364.7,",DR=".03////"_NEW D ^DIE
 ;
 S IBX="   >> Output Formatter Fields Updated (#364.7,.03)." D MES^XPDUTL(IBX)
 ;
 D BMES^XPDUTL("Pre-Installation Updates Completed")
 Q
 ;
POST ;
 N IBA
 S IBA(1)="",IBA(2)="    Reasonable Charges Post-Install .....",IBA(3)="" D MES^XPDUTL(.IBA) K IBA
 ;
 D DELCT ; clear Charge Type field for all Charge Sets   (363.1, .04)
 D RSINDT ; add Rate Schedule Inactive dates (363, .06)
 ;
 D ADDBS^IBYPPR1 ; add Bedsections  (399.1,.12)
 D ADDBE^IBYPPR1 ; add Billable Events   (399.1, .21)
 D ADDBI^IBYPPR1 ; add Billable Items   (363.21)
 D ADDRS^IBYPPR1 ; add Rate Schedule   (363)
 D ADDBR^IBYPPR1 ; add Billing Rates   (363.3)
 ;
 D SGBR ; add Billing Rates to Special Groups  (363.32,11,.01)
 D RVACT ; activate 41 Revenue Codes (399.2,2)
 ;
 S IBA(1)="",IBA(2)="    Reasonable Charges Post-Install Complete",IBA(3)="" D MES^XPDUTL(.IBA) K IBA
 ;
 Q
 ;
DELCT ; Delete Charge Type from all Non-Reasonable Charges Charge Sets (363.1,.04)
 N IBA,IBCS,IBLN,IBBRN,DIC,DIE,DR,DA,X,Y
 ;
 S IBCS=0 F  S IBCS=$O(^IBE(363.1,IBCS)) Q:'IBCS  D
 . S IBLN=$G(^IBE(363.1,IBCS,0)) I '$P(IBLN,U,4) Q
 . S IBBRN=$P($G(^IBE(363.3,+$P(IBLN,U,2),0)),U,1) I $E(IBBRN,1,3)="RC " Q
 . ;
 . S DR=".04////@",DIE="^IBE(363.1,",DA=+IBCS D ^DIE K DIE,DA,DR,X,Y
 ;
DCQ S IBA(1)="      >> Removing Charge Types from non-RC Charge Sets (363.1)..."
 D MES^XPDUTL(.IBA)
 Q
 ;
RSINDT ; add an inactive date to rate schedules if this is the first time the load is completed (363, .06)
 ; Reimbursable Ins, No Fault, and Workers Comp only
 ; if test account use 9/30/98, if production account use 8/31/99
 N IBA,IBRSFN,IBRS0,IBRSN,IBCNT,IBSTDT,DD,DO,DIC,DIE,DA,DR,X,Y S IBSTDT="",IBCNT=0
 ;
 I $O(^IBE(363.3,"B","RC INPATIENT FACILITY",0)) G RSINQ
 ;
 S IBSTDT=2990831 I '$$PROD^IBCORC S IBSTDT=2980930
 ;
 S IBRSFN=0 F  S IBRSFN=$O(^IBE(363,IBRSFN)) Q:'IBRSFN  D
 . S IBRS0=$G(^IBE(363,IBRSFN,0)),IBRSN=$E(IBRS0,1,3)
 . I IBRSN'="RI-",IBRSN'="NF-",IBRSN'="WC-" Q
 . I ($P(IBRS0,U,5)'="")!($P(IBRS0,U,6)'="") Q
 . ;
 . S IBCNT=IBCNT+1,DR=".06////"_IBSTDT,DIE="^IBE(363,",DA=+IBRSFN D ^DIE K DIE,DA,DR,X,Y
 ;
RSINQ S IBA(1)="      >> "_IBCNT_" Rate Schedules inactivated on "_$E(IBSTDT,4,5)_"/"_$E(IBSTDT,6,7)_"/"_$E(IBSTDT,2,3)_" (363)..."
 D MES^XPDUTL(.IBA)
 Q
 ;
SGBR ; add Billing Rates to the Special Groups (363.32,11,.01)
 N IBA,IBSET,IBSG,IBSGFN,IBBR,IBBRFN,IBCNT,DINUM,DD,DO,DLAYGO,DIC,DIE,DA,DR,X,Y S IBCNT=0
 ;
 F IBSET="STANDARD RVCD LINKS^RC OUTPATIENT FACILITY","STANDARD RVCD LINKS^RC PHYSICIAN","RC PROVIDER DISCOUNTS^RC PHYSICIAN" D
 . S IBSG=$P(IBSET,U,1) Q:IBSG=""  S IBSGFN=$O(^IBE(363.32,"B",IBSG,0)) Q:'IBSGFN
 . S IBBR=$P(IBSET,U,2) Q:IBBR=""  S IBBRFN=$O(^IBE(363.3,"B",IBBR,0)) Q:'IBBRFN
 . ;
 . I $O(^IBE(363.32,+IBSGFN,11,"B",+IBBRFN,0)) Q
 . ;
 . S DLAYGO=363.32,DA(1)=+IBSGFN,DIC="^IBE(363.32,"_DA(1)_",11,",DIC(0)="L",X=IBBR,DIC("P")="363.3211PA" D ^DIC K DIC,DIE S IBCNT=IBCNT+1
 ;
SGBRQ S IBA(1)="      >> "_IBCNT_" Billing Rates added to Special Groups (363.32)..."
 D MES^XPDUTL(.IBA)
 Q
 ;
RVACT ; activate (30) Revenue Codes exported in RV-CPT links (399.2,2)
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
 I IBCNT>0 S IBJ=0 F IBI=1:15 S IBJ=IBJ+15 S IBLN=$P(IBACT,",",IBI,IBJ) Q:IBLN=""  D MSG("         "_IBLN)
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
RVF ;  Revenue Codes to (59) Activate (399.2,2)
 ;;301,302,305,306,307,309,310,311,312,320,322,323,324,333,341,342,351,352,359,360,362,370,401,402,403,404,410,413,420,430,440,441,450,460,470,471,480,481,482,610,636,730,731,740,750,761,901,910,914,915,916,918,920,921,922,924,943,
 ;;

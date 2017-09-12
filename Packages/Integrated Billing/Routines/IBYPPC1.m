IBYPPC1 ;ALB/ARH - IB*2*52 POST INIT:  CM POST INIT (CONT) ; 16-MAY-1996
 ;;Version 2.0 ; INTEGRATED BILLING ;**52,86**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
ADDBS ; Add Billable Service (399.1, .2=1)
 N IBA,IBCNT,IBI,IBLN,IBFN,IBX,DD,DO,DLAYGO,DIC,DIE,DA,DR,X,Y S IBCNT=0
 ;
 F IBI=1:1 S IBLN=$P($T(BSF+IBI^IBYPPC5),";;",2) Q:+IBLN!(IBLN="")  I $E(IBLN)?1A D
 . ;
 . I +$$MCCRUTL($P(IBLN,U,1),13) Q
 . ;
 . K DD,DO S DLAYGO=399.1,DIC="^DGCR(399.1,",DIC(0)="L",X=$P(IBLN,U,1) D FILE^DICN K DIC I Y<1 K X,Y Q
 . S IBFN=+Y,IBCNT=IBCNT+1
 . ;
 . S DR=".03////"_$P(IBLN,U,2)_";.2////"_1
 . S DIE="^DGCR(399.1,",DA=+IBFN D ^DIE K DIE,DA,DR,X,Y
 ;
BSQ S IBA(1)="      >> "_IBCNT_" Billable Services added (399.1)..."
 D MES^XPDUTL(.IBA)
 Q
 ;
ADDBE ; Add Billable Events (399.1, .21=1)
 N IBA,IBCNT,IBI,IBLN,IBFN,DD,DO,DLAYGO,DIC,DIE,DA,DR,X,Y S IBCNT=0
 ;
 F IBI=1:1 S IBLN=$P($T(BEF+IBI^IBYPPC5),";;",2) Q:+IBLN!(IBLN="")  I $E(IBLN)?1A D
 . ;
 . I +$$MCCRUTL($P(IBLN,U,1),14) Q
 . ;
 . K DD,DO S DLAYGO=399.1,DIC="^DGCR(399.1,",DIC(0)="L",X=$P(IBLN,U,1) D FILE^DICN K DIC I Y<1 K X,Y Q
 . S IBFN=+Y,IBCNT=IBCNT+1
 . ;
 . S DR=".03////"_$P(IBLN,U,2)_";.21////"_1
 . S DIE="^DGCR(399.1,",DA=+IBFN D ^DIE K DIE,DA,DR,X,Y
 ;
BEQ S IBA(1)="      >> "_IBCNT_" Billable Events added (399.1)..."
 D MES^XPDUTL(.IBA)
 Q
 ;
ADDBR ; Add Billing Rates (363.3)
 N IBA,IBCNT,IBI,IBLN,IBFN,DD,DO,DLAYGO,DIC,DIE,DA,DR,X,Y S IBCNT=0
 ;
 F IBI=1:1 S IBLN=$P($T(BRF+IBI^IBYPPC5),";;",2) Q:+IBLN!(IBLN="")  I $E(IBLN)?1A D
 . ;
 . I $O(^IBE(363.3,"B",$P(IBLN,U,1),0)) Q
 . ;
 . K DD,DO S DLAYGO=363.3,DIC="^IBE(363.3,",DIC(0)="L",X=$P(IBLN,U,1) D FILE^DICN K DIC I Y<1 K X,Y Q
 . S IBFN=+Y,IBCNT=IBCNT+1
 . ;
 . S DR=".02////"_$P(IBLN,U,2)_";.03////"_$P(IBLN,U,3)_";.04////"_$P(IBLN,U,4)_";.05////"_$P(IBLN,U,5)
 . S DIE="^IBE(363.3,",DA=+IBFN D ^DIE K DIE,DA,DR,X,Y
 ;
BRQ S IBA(1)="      >> "_IBCNT_" Billing Rates added (363.3)..."
 D MES^XPDUTL(.IBA)
 Q
 ;
ADDCS ; Add Charge Sets (363.1)
 N IBA,IBCNT,IBI,IBLN,IBFN,IBBR,IBBE,IBRVCD,DD,DO,DLAYGO,DIC,DIE,DA,DR,X,Y S IBCNT=0
 ;
 F IBI=1:1 S IBLN=$P($T(CSF+IBI^IBYPPC5),";;",2) Q:+IBLN!(IBLN="")  I $E(IBLN)?1A D
 . ;
 . I $O(^IBE(363.1,"B",$P(IBLN,U,1),0)) Q
 . S IBBR=$P(IBLN,U,2),IBBR=$O(^IBE(363.3,"B",IBBR,0)) I 'IBBR Q
 . S IBBE=$$MCCRUTL($P(IBLN,U,3),14) Q:'IBBE
 . S IBRVCD=$$RVCD($P(IBLN,U,5))
 . ;
 . K DD,DO S DLAYGO=363.1,DIC="^IBE(363.1,",DIC(0)="L",X=$P(IBLN,U,1) D FILE^DICN K DIC I Y<1 K X,Y Q
 . S IBFN=+Y,IBCNT=IBCNT+1
 . ;
 . S DR=".02////"_IBBR_";.03////"_IBBE
 . I +$P(IBLN,U,4) S DR=DR_";.04////"_$P(IBLN,U,4)
 . I +IBRVCD S DR=DR_";.05////"_IBRVCD
 . S DIE="^IBE(363.1,",DA=+IBFN D ^DIE K DIE,DA,DR,X,Y
 ;
CSQ S IBA(1)="      >> "_IBCNT_" Charge Sets added (363.1)..."
 D MES^XPDUTL(.IBA)
 Q
 ;
ADDCI ; Add Charge Items (363.2) needs Charge Sets
 N IBA,IBCNT,IBI,IBLN,IBFN,IBCS,IBCI,IBRVCD,DD,DO,DLAYGO,DIC,DIE,DA,DR,X,Y,IBX S IBCNT=0
 ;
 F IBI=1:1 S IBLN=$P($T(CIF+IBI^IBYPPC61),";;",2) Q:+IBLN!(IBLN="")  I $E(IBLN)?1A D SETCI
 F IBI=1:1 S IBLN=$P($T(CIF+IBI^IBYPPC6),";;",2) Q:+IBLN!(IBLN="")  I $E(IBLN)?1A D SETCI
 F IBI=1:1 S IBLN=$P($T(CIF+IBI^IBYPPC7),";;",2) Q:+IBLN!(IBLN="")  I $E(IBLN)?1A D SETCI
 ;
CIQ S IBA(1)="      >> "_IBCNT_" Charge Items added (363.2)..."
 D MES^XPDUTL(.IBA)
 Q
 ;
SETCI ; set Charge Item (duplicates based on item, CS, eff dt, rev cd)
 ;
 S IBCS=$P(IBLN,U,2),IBCS=+$O(^IBE(363.1,"B",IBCS,0)) I 'IBCS Q
 S IBCI=+$$MCCRUTL($P(IBLN,U,1),5) I 'IBCI Q
 S IBRVCD=$$RVCD($P(IBLN,U,4))
 S IBX=0 F  S IBX=$O(^IBA(363.2,"AIVDTS"_IBCS,IBCI,-$P(IBLN,U,3),IBX))  Q:'IBX  I $P(^IBA(363.2,IBX,0),U,6)=IBRVCD S IBCI=0
 Q:'IBCI
 ;
 K DD,DO S DLAYGO=363.2,DIC="^IBA(363.2,",DIC(0)="L",X=IBCI_";DGCR(399.1," D FILE^DICN K DIC I Y<1 K X,Y Q
 S IBFN=+Y,IBCNT=IBCNT+1
 ;
 S DR=".02////"_IBCS_";.03////"_$P(IBLN,U,3)_";.05////"_$P(IBLN,U,5)
 I +IBRVCD S DR=DR_";.06////"_IBRVCD
 S DIE="^IBA(363.2,",DA=+IBFN D ^DIE K DIE,DA,DR,X,Y
 Q
 ;
ADDRS ; add Rate Schedules (363)  (needs billable service and charge sets)
 N IBA,IBCNT,IBI,IBLN,IBFN,IBRT,IBBS,IBJ,IBLNCS,IBCS,IBCSFN,DD,DO,DLAYGO,DIC,DIE,DA,DR,X,Y S IBCNT=0
 ;
 F IBI=1:1 S IBLN=$P($T(RSF+IBI^IBYPPC5),";;",2) Q:+IBLN!(IBLN="")  I $E(IBLN)?1A D
 . ;
 . I $O(^IBE(363,"B",$P(IBLN,U,1),0)) Q
 . S IBBS=$P(IBLN,U,4) I IBBS'="" S IBBS=$$MCCRUTL(IBBS,13) Q:'IBBS
 . S IBRT=$P(IBLN,U,2),IBRT=$O(^DGCR(399.3,"B",IBRT,0)) D  Q:'IBRT
 .. I 'IBRT D MSG("         **** Rate Type "_$P(IBLN,U,2)_" not defined, RS "_$P(IBLN,U,1)_" not created")
 .. I +$P($G(^DGCR(399.3,+IBRT,0)),U,3) S IBRT=0 D MSG("         **** Rate Type "_$P(IBLN,U,2)_" not Active, RS "_$P(IBLN,U,1)_" not created")
 . ;
 . K DD,DO S DLAYGO=363,DIC="^IBE(363,",DIC(0)="L",X=$P(IBLN,U,1) D FILE^DICN K DIC,DINUM,DLAYGO I Y<1 K X,Y Q
 . S IBFN=+Y,IBCNT=IBCNT+1
 . ;
 . S DR=".02////"_IBRT_";.03////"_$P(IBLN,U,3) I +IBBS S DR=DR_";.04////"_IBBS
 . ;
 . S DIE="^IBE(363,",DA=+Y D ^DIE K DIE,DA,DR,X,Y
 . ;
 . ; charge sets (multiple)
 . S IBLNCS=$P(IBLN,":",2,999) F IBJ=1:1 S IBCS=$P(IBLNCS,":",IBJ) Q:IBCS=""  D
 .. S IBCSFN=$O(^IBE(363.1,"B",IBCS,0)) Q:'IBCSFN
 .. ;
 .. S DLAYGO=363,DA(1)=+IBFN,DIC="^IBE(363,"_DA(1)_",11,",DIC(0)="L",X=IBCS,DIC("DR")=".02////"_1,DIC("P")="363.0011P" D ^DIC K DIC,DIE
 ;
 ;
RSQ S IBA(1)="      >> "_IBCNT_" Rate Schedules added (363)..."
 D MES^XPDUTL(.IBA)
 Q
 ;
MCCRUTL(X,P) ; returns IFN of item in 399.1 if Name is found and piece P is true
 N IBX,IBY S IBY=""
 I $G(X)'="" S IBX=0 F  S IBX=$O(^DGCR(399.1,"B",X,IBX)) Q:'IBX  I $P($G(^DGCR(399.1,IBX,0)),U,+$G(P)) S IBY=IBX
 Q IBY
 ;
RVCD(RVCD) ; returns IFN if revenue code is valid and active
 N IBX,IBY S IBY=""
 I +$G(RVCD) S IBX=$G(^DGCR(399.2,+RVCD,0)) I +$P(IBX,U,3) S IBY=RVCD
 Q IBY
 ;
MSG(X) ;
 N IBX S IBX=$O(IBA(999999),-1) S:'IBX IBX=1 S IBX=IBX+1
 S IBA(IBX)=$G(X)
 Q

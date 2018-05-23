IB20P383 ;OAK/ELZ - IB*2.0*383 CHECK/POST INSTALL ;11/15/07  09:47
 ;;2.0;INTEGRATED BILLING;**383**;21-MAR-94;Build 11
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;
CHECK ; - pre-install check
 ;
 N IBI,IBLN,IBX,IBRT
 ;
 ; - check for rate types that must be defined
 ; get active list
 F IBI=1:1 S IBLN=$P($T(RTF+IBI),";;",2) Q:+IBLN!(IBLN="")  S IBX=$O(^DGCR(399.3,"B",IBLN,0)) I IBX,'$P($G(^DGCR(399.3,IBX,0)),"^",3) S IBRT(IBLN,+IBX)=""
 ;
 ; do i have what i need?
 F IBI=1:1 S IBLN=$P($T(RTF+IBI),";;",2) Q:+IBLN!(IBLN="")!($G(XPDABORT))  D
 . S IBX=$O(IBRT(IBLN,0))
 . I 'IBX W !,"    *** Rate Type ",IBLN," does not exist or is not active." S XPDABORT=1 Q
 . I $O(IBRT(IBLN,IBX)) W !,"    *** Rate Type ",IBLN," has an active duplicate." S XPDABORT=1
 I $G(XPDABORT) W !!,"The rate type(s) must exist and be active before you can install."
 ;
 Q
 ;
POST ; - post-install
 N IBA,IBCS,IBNCS,IBDT
 ;
 S IBDT=3060101
 ;
 S IBA(1)="",IBA(2)="    e-Pharmacy Tricare Support Post-Install .....",IBA(3)="" D MES^XPDUTL(.IBA) K IBA
 ;
 D CLEANCS(.IBCS) ; clean up local charge sets
 D ADDCS(.IBCS,.IBNCS) ; add charge sets
 D OLDRS($$FMADD^XLFDT(IBDT,-1),.IBNCS) ; inactivate old rate schedules
 D ADDRS(IBDT) ; add rate schedules
 ;
 S IBA(1)="",IBA(2)="    e-Pharmacy Tricare Support Post-Install Complete",IBA(3)="" D MES^XPDUTL(.IBA)
 ;
 Q
 ;
CLEANCS(IBCS) ; cleans up locally defined charge sets (if any) for VA Cost
 ; saves data in IBCS(billable event,old ien)=old revenue code
 ;
 N IBI,IBBR,IBZ,DIK,DA
 ;
 D MSG("   Cleaning up old local Charge Sets")
 S IBBR=$O(^IBE(363.3,"B","VA COST",0)) I 'IBBR D MSG("   *** Missing Billing Rate VA COST !!!") Q
 I '$O(^IBE(363.1,"C",IBBR,999)) D MSG("   - No Charge Sets to clean up...ok") Q
 S IBI=999 F  S IBI=$O(^IBE(363.1,"C",IBBR,IBI)) Q:'IBI  D
 . S IBZ=$G(^IBE(363.1,IBI,0))
 . D MSG("   - Deleting Charge Set "_$P(IBZ,"^")_"...ok")
 . I $P(IBZ,"^",3),$P(IBZ,"^",5) S IBCS($P(IBZ,"^",3),IBI)=$P(IBZ,"^",5)
 . S DIK="^IBE(363.1,",DA=IBI D ^DIK
 ;
 D MSG("   Done cleaning up old local Charge Sets")
 ;
 Q
 ;
 ;
ADDCS(IBCS,IBNCS) ; Add Charge Set (363.1)
 ; puts data in IBNCS(ien)="" for new charge sets added
 ;
 N IBCNT,IBI,IBLN,IBFN,IBBR,IBBE,IBRVCD,DD,DO,DLAYGO,DIC,DIE,DA,DR,X,Y,IBORVCD,IBY,IBZ,DINUM,IBJ
 S IBCNT=0
 ;
 D MSG("   Adding new National Charge Sets")
 F IBI=1:1 S IBLN=$P($T(CSF+IBI),";;",2) Q:+IBLN!(IBLN="")  I $E(IBLN)?1A D
 . ;
 . I $O(^IBE(363.1,"B",$P(IBLN,U,1),0)) Q
 . S IBBR=$P(IBLN,U,2),IBBR=$O(^IBE(363.3,"B",IBBR,0)) I 'IBBR Q
 . S IBBE=$$MCCRUTL($P(IBLN,U,3),14) Q:'IBBE
 . S IBORVCD=+$G(IBCS(IBBE,+$O(IBCS(IBBE,999))))
 . S IBRVCD=+$$RVCD($P(IBLN,U,5))
 . F IBJ=1:1 I $G(^IBE(363.1,IBJ,0))="" S DINUM=IBJ Q
 . ;
 . K DD,DO S DLAYGO=363.1,DIC="^IBE(363.1,",DIC(0)="L",X=$P(IBLN,U,1) D FILE^DICN K DIC,DINUM I Y<1 K X,Y Q
 . D MSG("   Charge Set "_$P(IBLN,U,1)_" added...ok")
 . S IBFN=+Y,IBCNT=IBCNT+1,IBNCS(IBFN)=""
 . ;
 . S DR=".02////"_IBBR_";.03////"_IBBE
 . I IBORVCD D MSG("   - Using old Revenue Code...ok")
 . I IBRVCD!(IBORVCD) S DR=DR_";.05////"_$S(IBORVCD:IBORVCD,1:IBRVCD)
 . D MSG("   - Assigning Bed Section...")
 . S DR=DR_";.06////"_$$MCCRUTL($P(IBLN,U,6),5)
 . S DIE="^IBE(363.1,",DA=+IBFN D ^DIE K DIE,DA,DR,X,Y
 . Q:'$O(IBCS(IBBE,999))
 . D MSG("   - Resetting pointers from old Charge Sets...ok")
 . S IBCS=0 F  S IBCS=$O(IBCS(IBBE,IBCS)) Q:'IBCS  D
 .. ; possible pointer stored in 350.9 for old RNA sites
 .. I $P($G(^IBE(350.9,1,9)),"^",12)=IBCS D  K DIE,DA,DR,X,Y
 ... S DIE="^IBE(350.9,",DA=1,DR="9.12////^S X=+IBFN" D ^DIE
 .. ; fix Rate Schedules with pointers
 .. S IBY=0 F  S IBY=$O(^IBE(363,"C",IBCS,IBY)) Q:'IBY  S IBZ=0 F  S IBZ=$O(^IBE(363,"C",IBCS,IBY,IBZ)) Q:'IBZ  D  K DIE,DA,DR,X,Y
 ... S DIE="^IBE(363,"_IBY_",11,",DA(1)=IBY,DA=IBZ,DR=".01////^S X=+IBFN" D ^DIE
 .. ; fix Billing Special Groups with pointers
 .. S IBZ=0 F  S IBZ=$O(^IBE(363.32,IBZ)) Q:'IBZ  S IBY=0 F  S IBY=$O(^IBE(363.32,IBZ,11,IBY)) Q:'IBY  I $P($G(^IBE(363.32,IBZ,11,IBY,0)),"^",2)=IBCS D  K DIE,DA,DR,X,Y
 ... S DIE="^IBE(363.32,"_IBZ_",11,",DA(1)=IBZ,DA=IBY,DR=".02////^S X=+IBFN" D ^DIE
 ;
CSQ ;
 D MSG("      >> "_IBCNT_" Charge Sets added (363.1)...")
 ;
 Q
 ;
OLDRS(IBDT,IBNCS) ; inactivate old rate schedules
 ;
 D MSG("   Inactivating old Rate Schedules")
 ;
 N IBY,IBX,IBZ,IBC,IBD,IBCNT,DA,DIE,DIK,DR,X,Y S IBCNT=0
 ;
 S IBNCS=0 F  S IBNCS=$O(IBNCS(IBNCS)) Q:'IBNCS  S IBY=0 F  S IBY=$O(^IBE(363,"C",IBNCS,IBY)) Q:'IBY  S IBZ=999 F  S IBZ=$O(^IBE(363,"C",IBNCS,IBY,IBZ)) Q:'IBZ  D
 . S IBD=$G(^IBE(363,IBY,0))
 . Q:$P(IBD,"^",6)
 . Q:$G(^DGCR(399.3,+$P(IBD,"^",2),0))'["TRICARE"
 . S (IBC,IBX)=0 F  S IBX=$O(^IBE(363,IBZ,11,IBX)) Q:'IBX  S IBC=IBC+1
 . I IBC>1 D  Q
 .. D MSG("   - Rate Schedule "_$P(IBD,"^")_" has multiple Charge Sets")
 .. D MSG("     removing "_$P($G(^IBE(363.1,IBNCS,0)),"^")_" Charge Set but leaving active.")
 .. S DIK="^IBE(363,"_IBY_",11,",DA(1)=IBY,DA=IBZ D ^DIK K DIK,DA
 . D MSG("   - Inactivating Rate Schedule "_$P(IBD,"^"))
 . S DIE="^IBE(363,",DA=IBY,DR=".06////^S X=IBDT" D ^DIE K DIE,DA,X,Y
 ;
 D MSG("   Done inactivating old Rate Schedules...")
 ;
 Q
 ;
ADDRS(IBDT) ; add Rate Schedule (363)  (needs billable service and charge sets)
 N IBX,IBCNT,IBI,IBLN,IBFN,IBRT,IBBS,IBJ,IBLNCS,IBCS,IBCSFN,DD,DO,DLAYGO,DIC,DIE,DA,DR,X,Y,IBAJ,DINUM S IBCNT=0
 ;
 D MSG("   Adding new National Rate Schedules")
 ;
 F IBI=1:1 S IBLN=$P($T(RSF+IBI),";",3),IBAJ=$P($T(RSF+IBI),";",4) Q:+IBLN!(IBLN="")  I $E(IBLN)?1A D
 . ;
 . I $O(^IBE(363,"B",$P(IBLN,U,1),0)) Q
 . S IBBS=$P(IBLN,U,4) I IBBS'="" S IBBS=$$MCCRUTL(IBBS,13) I 'IBBS D  Q
 .. D MSG("*** Billable Service "_$P(IBLN,U,4)_" NOT FOUND, Rate Schedule "_$P(IBLN,"^")_" not created!!!")
 . S IBRT=$P(IBLN,U,2),IBRT=$O(^DGCR(399.3,"B",IBRT,0)) D  Q:'IBRT
 .. I 'IBRT D MSG("**** Rate Type "_$P(IBLN,U,2)_" not defined, Rate Schedule "_$P(IBLN,U,1)_" NOT created!!!")
 .. I $P($G(^DGCR(399.3,+IBRT,0)),U,3) S (IBRT,IBX)=0 F  S IBX=$O(^DGCR(399.3,"B",$P(IBLN,U,2),IBX)) Q:'IBX  I '$P($G(^DGCR(399.3,+IBX,0)),U,3) S IBRT=+IBX Q
 .. I $P($G(^DGCR(399.3,+IBRT,0)),U,3) S IBRT=0 D MSG("**** Rate Type "_$P(IBLN,U,2)_" not Active, RS "_$P(IBLN,U,1)_" not created!!!")
 . F IBJ=1:1 I $G(^IBE(363,IBJ,0))="" S DINUM=IBJ Q
 . ;
 . K DD,DO S DLAYGO=363,DIC="^IBE(363,",DIC(0)="L",X=$P(IBLN,U,1) D FILE^DICN K DIC,DINUM,DLAYGO I Y<1 K X,Y Q
 . S IBFN=+Y,IBCNT=IBCNT+1
 . ;
 . S DR=".02////"_IBRT_";.03////"_$P(IBLN,U,3)_";.05////"_IBDT_";.04////"_IBBS
 . I $L(IBAJ) D
 .. F IBJ=1,2 S:$L($P(IBAJ,U,IBJ)) DR=DR_";1.0"_IBJ_"////"_$P(IBAJ,U,IBJ)
 .. I $L($P(IBAJ,U,3)) S DR=DR_";10////^S X=$P(IBAJ,U,3)"
 . ;
 . S DIE="^IBE(363,",DA=IBFN D ^DIE K DIE,DA,DR,X,Y
 . ;
 . ; charge sets (multiple)
 . S IBLNCS=$P(IBLN,":",2,999) F IBJ=1:1 S IBCS=$P(IBLNCS,":",IBJ) Q:IBCS=""  D
 .. S IBCSFN=$O(^IBE(363.1,"B",IBCS,0)) Q:'IBCSFN
 .. ;
 .. S DLAYGO=363,DA(1)=+IBFN,DIC="^IBE(363,"_DA(1)_",11,",DIC(0)="L",X=IBCS,DIC("DR")=".02////"_1,DIC("P")="363.0011P" D ^DIC K DIC,DIE
 ;
 ;
RSQ D MSG("      >> "_IBCNT_" Rate Schedules added (363)...")
 Q
 ;
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
 D MES^XPDUTL(X)
 Q
 ;
CSF ; Charge Set (363.1)
 ;;RX COST^VA COST^PRESCRIPTION FILL^^250^PRESCRIPTION
 ;;PI COST^VA COST^PROSTHETICS ITEM^^274^OUTPATIENT VISIT
 ;;1
 ;
RSF ; Rate Schedules (363)
 ;;TR-RX^TRICARE^3^PRESCRIPTION^^^:RX COST;8^^S X=X+8
 ;;TRRI-RX^TRICARE REIMB. INS.^3^PRESCRIPTION^^^:RX COST;8^^S X=X+8
 ;;1
 ;
RTF ; Rate Types (399.3) that must exist
 ;;TRICARE
 ;;TRICARE REIMB. INS.
 ;;1
 ;

IB20P191 ;ALB/ARH - IB*2*191 POST INIT: EDI UPDATES ; 08/12/02
 ;;2.0;INTEGRATED BILLING;**191**;21-MAR-94
 ; 
 ;
 Q
PRE ;
 N IBA
 S IBA(1)="",IBA(2)="    IB*2*191 Pre-Install .....",IBA(3)="" D MES^XPDUTL(.IBA) K IBA
 ;
 D INSXRF ; delete trigger cross references in 399
 ;
 S IBA(1)="",IBA(2)="    IB*2*191 Pre-Install Complete",IBA(3)="" D MES^XPDUTL(.IBA) K IBA
 Q
 ;
INSXRF ; PRE-INSTALL - delete trigger cross references
 N IBA
 ;
 D DELIX^DDMOD(399,24,2) S IBA(1)="    >> ^DD(399,24) cross-reference #2 deleted" D MES^XPDUTL(.IBA) K IBA
 ;
 D DELIX^DDMOD(399,24,3) S IBA(1)="    >> ^DD(399,24) cross-reference #3 deleted" D MES^XPDUTL(.IBA) K IBA
 ;
 D DELIX^DDMOD(399,101,1) S IBA(1)="    >> ^DD(399,101) cross-reference #1 deleted (re-installed)" D MES^XPDUTL(.IBA) K IBA
 ;
 D DELIX^DDMOD(399,102,2) S IBA(1)="    >> ^DD(399,102) cross-reference #2 deleted (re-installed)" D MES^XPDUTL(.IBA) K IBA
 ;
 D DELIX^DDMOD(399,103,2) S IBA(1)="    >> ^DD(399,103) cross-reference #2 deleted (re-installed)" D MES^XPDUTL(.IBA) K IBA
 Q
POST ;
 N IBA
 S IBA(1)="",IBA(2)="    IB*2*191 Post-Install .....",IBA(3)="" D MES^XPDUTL(.IBA) K IBA
 ;
 D CLEAN ; Delete incomplete hanging nodes in the EDI Message file (364.2)
 D STATUS ; Update the resubmitted bills' status and new batch pointer
 D INSPRV ; Copy Ins Hospital Provider Number to Professional Provider Number
 ;
 S IBA(1)="",IBA(2)="    IB*2*191 Post-Install Complete",IBA(3)="" D MES^XPDUTL(.IBA) K IBA
 Q
 ;
 ;
CLEAN ; Clean left over nodes from the EDI Message File (364.2) - any node where there is no .01 field defined
 N IBA,IBX,IBFN,IBCNT,DA,DIK,DIC,X,Y S IBCNT=0
 ;
 F IBX="ABA","ABI","AMAN","AMD","AMS","AMT","ARD","ASCD","B","C" K ^IBA(364.2,IBX)
 ;
 S IBFN=0 F  S IBFN=$O(^IBA(364.2,IBFN)) Q:'IBFN  D
 . I $P($G(^IBA(364.2,IBFN,0)),U,1)="" S DA=IBFN,DIK="^IBA(364.2," D ^DIK S IBCNT=IBCNT+1
 ;
 S DIK="^IBA(364.2," D IXALL^DIK
 ;
 S IBA(1)="    >> Cleaning the EDI Message File (364.2), deleting incomplete nodes. "_IBCNT D MES^XPDUTL(.IBA) K IBA
 Q
 ;
 ;
STATUS ;  Update the resubmitted bills' status and new batch pointer
 ;  Assume the bills are in the file in IEN order that corresponds to
 ;  the order in which they were transmitted.  Starting at the last one
 ;  transmitted (highest IEN), look at the entry just before it and
 ;  assume the earlier one was resubmitted in the later one's batch.
 ;  Update the status if it's one of the standard ones from the return
 ;  message (P, A0, A1, or A2).
 ;
 N IBA,IBO,IBO0,IBN,IBN0,IBZ,Z,DR,DA,DIE,DIC,X,Y
 S IBZ=0 F  S IBZ=$O(^IBA(364,"B",IBZ)) Q:'IBZ  S Z=$O(^IBA(364,"B",IBZ,0)) I $O(^IBA(364,"B",IBZ,Z)) D
 . S IBN="" F  S IBN=$O(^IBA(364,"B",IBZ,IBN),-1) Q:IBN=""  D  Q:'IBO
 .. S IBO=$O(^IBA(364,"B",IBZ,IBN),-1)
 .. Q:'IBO  ; No earlier transmit
 .. S IBO0=$G(^IBA(364,IBO,0)),IBN0=$G(^IBA(364,IBN,0))
 .. Q:$P(IBO0,U,6)  ; Already has a resubmitted batch #
 .. S DR=".06////"_$P(IBN0,U,2) ; Update new batch # into old record
 .. I "P A0 A1 A2"[$P(IBO0,U,3) S DR=DR_";.03////R" ;Update status of old
 .. S DIE="^IBA(364,",DA=IBO D ^DIE
 ;
 S IBA(1)="    >> Updating the resubmitted bills' status and new batch pointer" D MES^XPDUTL(.IBA) K IBA
 Q
 ;
 ;
INSPRV ; Copy Hospital Provider Number (36,.11) into new field Professional Provider Number (36,.17)
 N IBA,IBFN,IB0,IBHP,IBPP,DA,DR,DIC,DIE,X,Y,IBCNT S IBCNT=0
 ;
 S IBFN=0 F  S IBFN=$O(^DIC(36,IBFN)) Q:'IBFN  D
 . S IB0=$G(^DIC(36,IBFN,0))
 . S IBHP=$P(IB0,U,11) Q:IBHP=""
 . S IBPP=$P(IB0,U,17) Q:IBPP'=""
 . ;
 . S DIE="^DIC(36,",DA=IBFN,DR=".17////"_IBHP D ^DIE K DA,DR,DIC,DIE S IBCNT=IBCNT+1
 ;
 S IBA(1)="    >> Copy Ins Hospital Provider Number to Professional Provider Number "_IBCNT D MES^XPDUTL(.IBA) K IBA
 Q

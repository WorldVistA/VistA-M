IBYPPD ;ALB/ARH - IB*2*175 POST INIT: TORT/INTERAGENCY RATES JAN 2004 ; 03/06/02
 ;;2.0;INTEGRATED BILLING;**175**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ; 
 Q
POST ;
 N IBA,IBEFFDT
 S IBA(1)="",IBA(2)="    IB*2*175 Post-Install .....",IBA(3)="" D MES^XPDUTL(.IBA) K IBA
 ;
 S IBEFFDT=3040107 ;            effective date of Tort Jan 2004
 ;
 D ADDBS ;                      add Bedsection for PRRTP
 D ADDCI^IBYPPD2(IBEFFDT) ;     add new Tort Liable and Interagency charges
 ;
 ;
 D ADDRSI^IBYPPD1(IBEFFDT) ;    inactivate existing Tort Feasor Rate Schedules
 D ADDRS^IBYPPD1(IBEFFDT) ;     add new Rate Schedules linking Tort Feasor and Reasonable Charges
 ;
 S IBA(1)="",IBA(2)="    IB*2*175 Post-Install Complete",IBA(3)="" D MES^XPDUTL(.IBA) K IBA
 Q
 ;
 ;
ADDBS ; Add Bedsection (399.1, .12=1)
 N IBA,IBCNT,IBI,IBLN,IBFN,DD,DO,DLAYGO,DIC,DIE,DA,DR,X,Y S IBCNT=0
 ;
 F IBI=1:1 S IBLN=$P($T(BSF+IBI),";;",2) Q:+IBLN!(IBLN="")  I $E(IBLN)?1A D
 . ;
 . I +$$MCCRUTL($P(IBLN,U,1),5) D MSG("No Change, Bedsection PRRTP already exists") Q
 . ;
 . K DD,DO S DLAYGO=399.1,DIC="^DGCR(399.1,",DIC(0)="L",X=$P(IBLN,U,1) D FILE^DICN K DIC I Y<1 K X,Y Q
 . S IBFN=+Y,IBCNT=IBCNT+1
 . ;
 . S DR=".03////"_$P(IBLN,U,2)_";.12////"_1 S DIE="^DGCR(399.1,",DA=+IBFN D ^DIE K DIE,DA,DR,X,Y
 ;
BSQ S IBA(1)="      >> "_IBCNT_" Bedsection PRRTP added (399.1)" D MES^XPDUTL(.IBA) K IBA
 Q
 ;
 ;
 ;
MCCRUTL(X,P) ; returns IFN of item in 399.1 if Name is found and piece P is true
 N IBX,IBY S IBY=""
 I $G(X)'="" S IBX=0 F  S IBX=$O(^DGCR(399.1,"B",X,IBX)) Q:'IBX  I $P($G(^DGCR(399.1,IBX,0)),U,+$G(P)) S IBY=IBX
 Q IBY
 ;
 ;
MSG(X) ;
 N IBX S IBX=$O(IBA(999999),-1) S:'IBX IBX=1 S IBX=IBX+1
 S IBA(IBX)="         "_$G(X)
 Q
 ;
 ;
 ;
 ;
BSF ;  Bedsections (399.1,.12):  name ^ abbreviation
 ;;    
 ;;PRRTP^PRRTP
 ;;
 Q

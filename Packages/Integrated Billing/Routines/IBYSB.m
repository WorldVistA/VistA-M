IBYSB ;ALB/ARH - IB*2.0*124 PRE INIT:  UPDATE OF #364.6 ; 12/10/99
 ;;2.0;INTEGRATED BILLING;**124**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
 Q
PRE ;
 N IBA
 S IBA(1)="",IBA(2)="    IB*2*124 Pre-Install:",IBA(3)="" D MES^XPDUTL(.IBA) K IBA
 ;
 D U3646 ; update position/column and length for three fields
 ;
 S IBA(1)="",IBA(2)="    IB*2*124 Pre-Install Complete.",IBA(3)="" D MES^XPDUTL(.IBA) K IBA
 ;
 Q
 ;
U3646 ; OUTPUT FORMATTER:  UPDATE FILE 364.6
 N DA,DIE,DIC,DR,IBCNT,IBX,IBA S IBCNT=0
 ;
 S IBA(1)="       Update Output Formatter definition of three UB-92 fields (364.6)",IBA(2)=" "
 ;
 ; update length to accomodate all 3 fields
 S DA=+$O(^IBA(364.6,"ASEQ",3,1,3,78,0)) ; 618 - LOCATION OF CARE (FL-4,1)
 I +DA S DIE="^IBA(364.6,",DR=".09////4" D ^DIE S IBCNT=IBCNT+1 D MSG2(DA)
 ;
 ; update STARTING COLUMN OR PIECE (364.6,.08) and delete LENGTH (364.6,.09) for two fields
 ;
 S DA=+$O(^IBA(364.6,"ASEQ",3,1,3,79,0)) ; 763 - BILL CLASSIFICATION (FL-4,2)
 I +DA S DIE="^IBA(364.6,",DR=".08////77.5;.09////@" D ^DIE S IBCNT=IBCNT+1 D MSG2(DA)
 ;
 S DA=+$O(^IBA(364.6,"ASEQ",3,1,3,80,0)) ; 764 - TIMEFRAME OF BILL (FL-4,3)
 I +DA S DIE="^IBA(364.6,",DR=".08////77.6;.09////@" D ^DIE S IBCNT=IBCNT+1 D MSG2(DA)
 ;
 D MSG(" "),MSG("       "_IBCNT_" fields updated (364.6)")
 D MES^XPDUTL(.IBA)
 Q
 ;
MSG(X) ;
 N IBX S IBX=$O(IBA(999999),-1) S:'IBX IBX=1 S IBX=IBX+1
 S IBA(IBX)=$G(X)
 Q
MSG2(X) ; write message on field changed
 N Y I +$G(X) S Y=$P($G(^IBA(364.6,X,0)),U,10) D MSG("          "_X_" - "_Y)
 Q

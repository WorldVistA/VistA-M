IBYSA ;ALB/ARH - IB*2.0*122 POST INIT:  HCFA 1500 DATE LENGTHS ; 10-OCT-1998
 ;;2.0;INTEGRATED BILLING;**122**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
 Q
POST ;
 N IBA
 S IBA(1)="",IBA(2)="    IB*2*122 Post-Install:",IBA(3)="" D MES^XPDUTL(.IBA) K IBA
 ;
 D HDATES ; update width of HCFA 1500 date fields
 ;
 S IBA(1)="",IBA(2)="    IB*2*122 Post-Install Complete.",IBA(3)="" D MES^XPDUTL(.IBA) K IBA
 ;
 Q
 ;
HDATES ; update width of HCFA 1500 date fields to 10 characters to accomodate 4 digit years
 N DA,DIE,DIC,DR,IBCNT,IBX,IBA S IBCNT=0
 ;
 S IBA(1)="       Expand HCFA 1500 Date fields to 10 characters (364.6)",IBA(2)=" "
 ;
 S DA=+$O(^IBA(364.6,"ASEQ",2,1,11,31,0)) ; 497 - PATIENT DOB (BX-3/1)
 I +DA S DIE="^IBA(364.6,",DR=".09////10" D ^DIE S IBCNT=IBCNT+1 D MSG2(DA)
 ;
 S DA=+$O(^IBA(364.6,"ASEQ",2,1,21,54,0)) ; 520 - INSUREDS DOB (BX-11A/1)
 I +DA S DIE="^IBA(364.6,",DR=".09////10" D ^DIE S IBCNT=IBCNT+1 D MSG2(DA)
 ;
 S DA=+$O(^IBA(364.6,"ASEQ",2,1,23,2,0)) ; 523 - OTH INSURED DOB (BX-9B/1)
 I +DA S DIE="^IBA(364.6,",DR=".09////10" D ^DIE S IBCNT=IBCNT+1 D MSG2(DA)
 ;
 S DA=+$O(^IBA(364.6,"ASEQ",2,1,33,2,0)) ; 539 - DATE OF CURR ILLNESS (BX-14)
 I +DA S DIE="^IBA(364.6,",DR=".09////10" D ^DIE S IBCNT=IBCNT+1 D MSG2(DA)
 ;
 S DA=+$O(^IBA(364.6,"ASEQ",2,1,33,37,0)) ; 540 - DATE OF SIMLAR ILLNESS (BX-15)
 I +DA S DIE="^IBA(364.6,",DR=".09////10" D ^DIE S IBCNT=IBCNT+1 D MSG2(DA)
 ;
 S DA=+$O(^IBA(364.6,"ASEQ",2,1,33,54,0)) ; 541 - DT UNABLE TO WRK FR (BX-16/1)
 I +DA S DIE="^IBA(364.6,",DR=".09////10" D ^DIE S IBCNT=IBCNT+1 D MSG2(DA)
 ;
 S DA=+$O(^IBA(364.6,"ASEQ",2,1,33,68,0)) ; 542 - DT UNABLE TO WRK TO (BX-16/2)
 I +DA S DIE="^IBA(364.6,",DR=".09////10" D ^DIE S IBCNT=IBCNT+1 D MSG2(DA)
 ;
 S DA=+$O(^IBA(364.6,"ASEQ",2,1,35,54,0)) ; 543 - HOSP FROM DATE (BX-18/1)
 I +DA S DIE="^IBA(364.6,",DR=".09////10" D ^DIE S IBCNT=IBCNT+1 D MSG2(DA)
 ;
 S DA=+$O(^IBA(364.6,"ASEQ",2,1,35,68,0)) ; 544 - HOSP TO DATE (BX-18/2)
 I +DA S DIE="^IBA(364.6,",DR=".09////10" D ^DIE S IBCNT=IBCNT+1 D MSG2(DA)
 ;
 D MSG(" "),MSG("       "_IBCNT_" HCFA 1500 date fields updated (364.6)")
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

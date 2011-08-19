IBTUTL2 ;ALB/AAS - CLAIMS TRACKING UTILITY ROUTINE ; 21-JUN-93
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
ADDR(IBTRVDT,IBTRN) ; -- add new entry to reviews file, ibt(356.1
 ; -- Input  IBTRVDT :=  Review date (in internal fileman format)
 ;             IBTRN :=  pointer to tracking module
 ;
 N %DT,DD,DO,DIC,DR,DIE,DLAYGO
 S DIC="^IBT(356.1,",DIC(0)="L",DLAYGO=356.1
 S DIC("DR")=".02////"_IBTRN
 S X=IBTRVDT D FILE^DICN
 S IBTRV=+Y,IBNEW=1
ADDRQ Q
 ;
PRE(IBTRVDT,IBTRN,IBX) ; -- add a  review
 ; -- Input  IBTRVDT :=  Review date (in internal fileman format)
 ;             IBTRN :=  pointer to tracking module
 ;               IBX :=  code for review
 ;
 N X,Y,DA,DR,DIE,DIC,IBXIFN,IBNRVDT,IBDAYS
 D ADDR(IBTRVDT,IBTRN)
 I IBTRV<1 G PREQ
 ;
 ; -- don't differentiate between scheduled and unscheduled
 I IBX=10!(IBX=20) S IBX=15 ; just admission review
 ;
 S IBDAYS=$S(IBX=15:1,1:$$RDAY^IBTRV31(IBTRN))
 S:'$G(IBX) IBX=30 S IBXIFN=$O(^IBE(356.11,"ACODE",IBX,0))
 ;S X1=IBTRVDT,X2=$S(IBX=15:3,1:"") I X2 D C^%DTC S IBNRVDT=X
 S DA=IBTRV,DIE="^IBT(356.1,"
 L +^IBT(356.1,+IBTRV):10 I '$T G PREQ
 S DR=".19////1;.03////^S X=$G(IBDAYS);.2////^S X=$$NXTRVDT^IBTRV31(IBTRV);.21////1;.22////"_IBXIFN_";1.01///NOW;1.02////"_DUZ
 D ^DIE K DA,DR,DIE
 L -^IBT(356.1,+IBTRV)
PREQ Q
 ;
SCH(DFN,IBTDT,IBSCH) ; -- add scheduled admission entries
 ; -- input   dfn  := patient pointer to 2
 ;          ibtdt  := episode date
 ;
 N X,Y,DA,DR,DIE,DIC
 ;S IBETYP=+$O(^IBE(356.6,"B","SCHEDULED ADMISSION",0))
 S IBETYP=+$O(^IBE(356.6,"AC",5,0)) ;scheduled admission type
 S X=$O(^IBT(356,"APTY",DFN,IBETYP,IBTDT,0)) I X S IBTRN=X G SCHQ
 D ADDT^IBTUTL
 I IBTRN<1 G SCHQ
 S DA=IBTRN,DIE="^IBT(356,"
 I '$G(IBSCH) S X=0 F  S X=$O(^DGS(41.1,"B",DFN,X)) Q:'X  I $P(^DGS(41.1,+X,0),"^",2)=IBTDT S IBSCH=X Q
 L +^IBT(356,+IBTRN):5 I '$T G SCHQ
 S DR=$$ADMDR^IBTUTL(IBTDT,IBETYP,"",0)
 I $G(IBSCH) S DR=DR_";.32////"_IBSCH
 D ^DIE K DA,DR,DIE
 L -^IBT(356,+IBTRN)
 ;
 ; -- add required ins. action if insured
 I $P(^IBT(356,IBTRN,0),U,24) D COM^IBTUTL3(IBTDT,IBTRN,10)
SCHQ Q

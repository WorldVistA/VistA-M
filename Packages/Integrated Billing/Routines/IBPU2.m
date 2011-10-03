IBPU2 ;ALB/BGA - IB PURGE FILE CLEAN UP ; 17-FEB-94
 ;;Version 2.0 ; INTEGRATED BILLING ;**48**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; This routine requires IBN from routine IBPP
 ; and deletes entries in FILE #399
 ;
 ; The following procedures remove references which
 ; point to the IBN about to be deleted. This routine is 
 ; invoked by IBPU.
 ;
 Q:'$G(IBN)
 D CTARNB ;     adds a Reason Not Billable (.19) to 356:  PURGED
 D CLBCOM ;     deletes Rec from file 362.1
 D CLPSTE ;     deletes Rec from file 362.3,362.4,362.5
 D CLCTRK ;     deletes ptr from file 356  field .11
 D CLCTBI ;     deletes Rec from file 356.399
 D IBPBIL ;     sets the ptr in fld .17 to its self
 D IBCYTO ;     checks the ptr in fld .15
 Q
 ;
CTARNB ; add a RNB (356,.19) for every episode found on the bill, if none exists (non-cancelled bills)
 N ARRAY,IBA,IBX,DIE,DIC,DA,DR,IBRNB K ARRAY S IBRNB=$O(^IBE(356.8,"B","BILL PURGED",0)) Q:'IBRNB
 D IFNTRN^IBCU83(IBN,.ARRAY) S IBA=0 F  S IBA=$O(ARRAY(IBA)) Q:'IBA  I +ARRAY(IBA)'=5 S ^TMP($J,"IBPPTRN",IBA)=""
 I $P($G(^DGCR(399,+IBN,0)),U,13)'=7 S IBA=0 F  S IBA=$O(ARRAY(IBA)) Q:'IBA  S IBX=$G(^IBT(356,+IBA,0)) D
 . I +IBX,'$P(IBX,U,19),+ARRAY(IBA)'=5 S DIE="^IBT(356,",DA=IBA,DR=".19////"_IBRNB D ^DIE
 Q
CLBCOM ; uses "D" xref to find all recs to be deleted
 N IBA,DIK,DA
 S IBA="" F  S IBA=$O(^IBA(362.1,"D",IBN,IBA)) Q:'IBA  S DIK="^IBA(362.1,",DA=IBA D ^DIK
 Q
CLPSTE ; uses "AIFN_IBN" to find all recs pointing to the rec to be deleted
 N IBA,IBB,REF,DIK,DA
 S REF="AIFN"_IBN
 F IBI=362.5,362.3,362.4 S (IBA,IBB)="" F  S IBA=$O(^IBA(IBI,REF,IBA)) Q:'IBA  F  S IBB=$O(^IBA(IBI,REF,IBA,IBB)) Q:'IBB  S DIK="^IBA("_IBI_",",DA=IBB D ^DIK
 Q
CLCTBI ; uses "C" xref to find all recs pointing to 399 then deletes
 N IBA,IBB,DIK,DA
 S IBA="" F  S IBA=$O(^IBT(356.399,"C",IBN,IBA)) Q:'IBA  D
 . S IBB=$P($G(^IBT(356.399,IBA,0)),U,1) I +IBB S ^TMP($J,"IBPPTRN",+IBB)=""
 . S DIK="^IBT(356.399,",DA=IBA D ^DIK
 Q
CLCTRK ; uses "E" xref to find all recs ptr to 399 then sets them to null
 N IBA,DIE,DA,DR
 S IBA="" F  S IBA=$O(^IBT(356,"E",IBN,IBA)) Q:'IBA  S ^TMP($J,"IBPPTRN",+IBA)="",DIE="^IBT(356,",DA=IBA,DR=".11///@" D ^DIE
 Q
IBPBIL ; uses "AC" xref to find all recs ptr to 399 then sets to the bill #
 N IBA,DIE,DA,DR
 S IBA="" F  S IBA=$O(^DGCR(399,"AC",IBN,IBA)) Q:'IBA  I IBN'=IBA S DIE="^DGCR(399,",DA=IBA,DR=".17///"_IBA D ^DIE
 Q
IBCYTO ; uses "C" xref to find all recs ptr to 399 then sets the recs to null
 N IBA,IBB,DFN,DIE,DA,DR
 S (IBA,IBB)="",DFN=+$P($G(^DGCR(399,IBN,0)),U,2)
 F  S IBA=$O(^DGCR(399,"C",DFN,IBA)) Q:'IBA  I +$P($G(^DGCR(399,IBA,0)),U,15)=IBN S DIE="^DGCR(399,",DA=IBA,DR=".15///@"
 Q
 ;
 ;
PTCH48 ; CODE FOR PATCH IB*2*48 TO ADD NEW REASON NOT BILLABLE
 N IBI,DINUM,DIC,Y
 I $D(^IBE(356.8,"B","BILL PURGED")) W !!,"*** REASON NOT BILLABLE of 'BILL PURGED' already exists in FILE #356.8, new entry NOT added.",!! Q
 W !!,">>> Adding new REASON NOT BILLABLE of 'BILL PURGED' to FILE #356.8"
 F IBI=19:1:999 I '$D(^IBE(356.8,IBI,0)) D  Q
 . S DINUM=IBI I '$D(^IBE(356.8,DINUM,0)) K DD,DO S DIC="^IBE(356.8,",DIC(0)="L",X="BILL PURGED" D FILE^DICN
 I $G(Y)<1 W !!,"**** Unable to add new entry to FILE #356.8, contact Field Support ****",!!
 I $G(Y)>0 W !,"Done.",!!
 K DIC,DINUM,Y,DD,DO
 Q

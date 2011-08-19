IBCU73 ;ALB/ARH - ADD/DELETE MODIFIER 26 TO SPECIFIED CPTS ; 1-SEP-00
 ;;2.0;INTEGRATED BILLING;**138,51,148,169,245**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; Based on Reasonable Charges v1.1, certain CPT codes should be reported with a modifier 26, indicating the
 ; charge is only the professional portion of the charge for the procedure.
 ;
 ; Auto add/remove modifier 26 for specific CPT codes on a bill
 ; - must be a Reasonable Charges v1.1 bill or greater
 ; - the CPT must be part of a specific set of CPT's (MOD26)
 ; - there must be both institutional and professional RC charges for the CPT
 ; - if the bill is an institutional bill then modifier 26 is deleted, if it is defined for the CPT
 ; - if the bill is a professional bill then modifier 26 is added, if it is not already defined for the CPT
 ;
CPTMOD26(IBIFN) ; add/remove modifier 26 from specific CPT codes on Reasonable Charges bills
 N IB0,IBEVDT,IBBCT,IBCSI,IBCSP,IBBCPT,IBLN,IBMODS,IB26,IBX,IBCHANGE,IBBU,IBEND S IBCHANGE=0
 I '$O(^DGCR(399,+$G(IBIFN),"CP",0)) Q
 S IB0=$G(^DGCR(399,+IBIFN,0)) Q:IB0=""  S IBBCT=$P(IB0,U,27) Q:'IBBCT
 S IBBU=$G(^DGCR(399,+IBIFN,"U")),IBEND=$$VERSDT^IBCRU8(2)
 I 3001102>$P(IBBU,U,2) Q  ; starts with v1.1
 I +IBBU>IBEND Q  ; ends with v2
 I '$$BILLRATE^IBCRU3($P(IB0,U,7),$P(IB0,U,5),$P(IB0,U,3),"RC") Q
 ;
 S IBX=$O(^IBE(363.1,"B","RC-OPT FAC")),IBCSI=$O(^IBE(363.1,"B",IBX,0)) Q:'IBCSI  S IBCSI="AIVDTS"_IBCSI
 S IBX=$O(^IBE(363.1,"B","RC-PHYSICI")),IBCSP=$O(^IBE(363.1,"B",IBX,0)) Q:'IBCSP  S IBCSP="AIVDTS"_IBCSP
 ;
 S IBBCPT=0 F  S IBBCPT=$O(^DGCR(399,IBIFN,"CP",IBBCPT)) Q:'IBBCPT  D
 . S IBLN=$G(^DGCR(399,IBIFN,"CP",IBBCPT,0)),IBEVDT=$P(IBLN,U,2) Q:IBLN'[";ICPT("
 . I 3001102>IBEVDT Q
 . I IBEVDT'<IBEND Q
 . ;
 . I '$$MOD26(+IBLN,IBEVDT) Q
 . ;
 . S IBX=$O(^IBA(363.2,IBCSI,+IBLN,-IBEVDT)) Q:'IBX  I IBX'=$O(^IBA(363.2,IBCSP,+IBLN,-IBEVDT)) Q
 . ;
 . S IB26=",7,",IBMODS=","_$$GETMOD^IBEFUNC(IBIFN,IBBCPT)_","
 . ;
 . I IBBCT=1,IBMODS[IB26 D DELMOD(IBIFN,IBBCPT,7) S IBCHANGE=1
 . I IBBCT=2,IBMODS'[IB26 D ADDMOD(IBIFN,IBBCPT,7) S IBCHANGE=2
 ;
 I '$D(ZTQUEUED),'$G(IBAUTO),+IBCHANGE W !,"Modifier 26 "_$S(IBCHANGE=1:"Deleted from",1:"Added to")_" CPT procedures."
 Q
 ;
MOD26(CPT,IBDT) ; returns true if CPT should have a 26-modifier for professional bill
 ; 
 N IBX,IBCPTX S IBX=0,IBCPTX=","_$G(CPT)_",",IBDT=$S(+$G(IBDT):IBDT,1:DT) I '$G(CPT) G MOD26Q
 I CPT'<70000,CPT'>79999 S IBX=1
 I CPT'<90000,CPT'>99199 S IBX=1
 I CPT'<51725,CPT'>51797 S IBX=1
 I ",54240,54250,59020,59025,62252,62367,62368,"[IBCPTX S IBX=1
 ;
 I ",75952,75953,78990,90870,90871,91100,91105,92018,92019,92502,"[IBCPTX S IBX=0
 I ",92950,92953,92960,92961,93503,93536,93650,93651,93652,94660,94662,"[IBCPTX S IBX=0
 I ",96405,96406,96440,96445,96450,96542,96570,96571,96902,"[IBCPTX S IBX=0
 I CPT'<90918,CPT'>90997 S IBX=0
 ;
 I IBDT>3030428,",75952,75953,"[IBCPTX S IBX=1 ; should have modifier 26 in v1.4 but not v1.2
MOD26Q Q IBX
 ;
DELMOD(IBIFN,BCPT,MOD) ; delete the modifier from the CPT
 ; Input:  BCPT - the ifn of the CPT in the 304 multiple
 ;         MOD  - internal form of the modifier to delete
 N DA,DR,DIE,DIC,IBLN,X,Y Q:'$G(MOD)
 S IBLN=+$O(^DGCR(399,+$G(IBIFN),"CP",+$G(BCPT),"MOD","C",MOD,0)) Q:'IBLN
 ;
 S DA(2)=IBIFN,DA(1)=BCPT,DA=IBLN,DIE="^DGCR(399,"_DA(2)_",""CP"","_DA(1)_",""MOD"",",DR=".01///@" D ^DIE
 Q
 ;
ADDMOD(IBIFN,BCPT,MOD) ; add the modifier to the CPT
 ; Input:  BCPT - the ifn of the CPT in the 304 multiple
 ;         MOD  - internal form of the modifier to add
 N DA,DR,DIE,DINUM,DIC,IBLN,IBM,IBCPM,X,Y Q:'$G(MOD)
 S IBLN=+$O(^DGCR(399,+$G(IBIFN),"CP",+$G(BCPT),"MOD","C",MOD,0)) Q:IBLN
 ;I $$MODP^ICPTMOD(+$G(^DGCR(399,+$G(IBIFN),"CP",+$G(BCPT),0)),MOD,"I")<1 Q ; CPT 2001 too restrictive for RC
 ;
 I $D(^DGCR(399,IBIFN,"CP",BCPT,"MOD",1)) D  ;Move modifiers out of 1
 . S IBCPM="A"
 . F  S IBCPM=$O(^DGCR(399,IBIFN,"CP",BCPT,"MOD",IBCPM),-1) Q:'IBCPM  S IBM=$G(^(IBCPM,0)) I $P(IBM,U,2) D
 .. N DA,DO,DD,X,Y,DINUM
 .. S DA(2)=IBIFN,DA(1)=BCPT,DIC="^DGCR(399,"_DA(2)_",""CP"","_DA(1)_",""MOD"","
 .. S DINUM=IBCPM+1,X=IBM+1,DIC("DR")=".02////"_$P(IBM,U,2),DIC(0)="L" D FILE^DICN K DO,DD
 .. I Y>0 S DIE=DIC,DA(2)=IBIFN,DA(1)=BCPT,DA=IBCPM,DR=".01///@" D ^DIE
 S DINUM=1,DA(2)=IBIFN,DA(1)=BCPT,DIC="^DGCR(399,"_DA(2)_",""CP"","_DA(1)_",""MOD"",",DIC("DR")=".02////"_MOD,X=1,DIC(0)="L" D FILE^DICN
 Q

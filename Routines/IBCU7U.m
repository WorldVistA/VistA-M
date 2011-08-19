IBCU7U ;ALB/ARH - BILL PROCEDURE UTILITIES ; 10-OCT-03
 ;;2.0;INTEGRATED BILLING;**245**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; basic bill procedure utilities
 ;
DELCPT(IBIFN,OLDDA) ; delete a CPT code from a bill
 ; Input: OLDDA  = ifn of cpt in bill cpt multiple to be deleted
 N DA,DIK,DIC,DIE,X,Y,IBFND S IBFND=0,DA(1)=+$G(IBIFN),DA=+$G(OLDDA)
 I $D(^DGCR(399,DA(1),"CP",DA,0)) S DIK="^DGCR(399,"_DA(1)_",""CP""," D ^DIK S IBFND=1
 Q IBFND
 ;
EDITCPT(IBIFN,OLDDA,NEWCPT) ; replace a CPT code on the bill with another CPT code
 ; Input: OLDDA  = ifn of cpt in bill cpt multiple to be replaced
 ;        NEWCPT = ifn of cpt code to be added
 N DA,DR,DIE,DIC,IBFND,X,Y S IBFND=0,DA(1)=+$G(IBIFN),DA=+$G(OLDDA),NEWCPT=+$G(NEWCPT)
 I NEWCPT,$D(^DGCR(399,DA(1),"CP",DA,0)) S DIE="^DGCR(399,"_DA(1)_",""CP"",",DR=".01///`"_NEWCPT D ^DIE S IBFND=1
 Q IBFND
 ;
COPYCPT(IBIFN,OLDDA,NEWCPT) ; add a new CPT and populate date fields with data from an existing bill cpt
 ; Input: OLDDA  = ifn of cpt in bill cpt multiple to be copied
 ;        NEWCPT = ifn of cpt code to be added
 N DLAYGO,DIC,DIE,DA,DR,DD,DO,IBNEWDA,IBODA,IBNDA,IBXDA,IBSFILE,IBX,IBY,IBOLD,IBNEW,IBFND,X,Y S IBFND=0
 ;
 I '$D(^DGCR(399,+$G(IBIFN),"CP",+$G(OLDDA),0)) G COPYCPQ
 I '$G(NEWCPT) G COPYCPQ
 ;
 ; add new procedure entry to bill
 S DLAYGO=399,DA(1)=IBIFN,DIC="^DGCR(399,"_DA(1)_",""CP"",",DIC(0)="L",X=+NEWCPT_";ICPT(" K DD,DO D FILE^DICN K DO,DD,DIC,DIE
 S (DA,IBNEWDA,IBFND)=+Y I IBNEWDA<1 S IBFND=0 G COPYCPQ
 ;
 ; copy data from existing procedure to new procedure on bill
 S IBODA=OLDDA_","_IBIFN_","
 S IBNDA=IBNEWDA_","_IBIFN_","
 D GETS^DIQ(399.0304,IBODA,"*","IN","IBOLD")
 S IBSFILE=0 F  S IBSFILE=$O(IBOLD(IBSFILE)) Q:'IBSFILE  D
 . S IBXDA="" F  S IBXDA=$O(IBOLD(IBSFILE,IBXDA)) Q:IBXDA=""  D
 .. S IBX=0 F  S IBX=$O(IBOLD(IBSFILE,IBXDA,IBX)) Q:'IBX  D
 ... I IBXDA=IBODA,",.01,2,3,4,7,14,20,"[(","_IBX_",") Q
 ... S IBNEW(IBSFILE,IBNDA,IBX)=IBOLD(IBSFILE,IBXDA,IBX,"I")
 I $O(IBNEW(0)) D FILE^DIE("","IBNEW") K DA,DR,DA,DO,DIE,DIC
 ;
 ; copy modifiers from existing procedure to new procedure on bill
 S IBX=0 F  S IBX=$O(^DGCR(399,IBIFN,"CP",OLDDA,"MOD",IBX)) Q:'IBX  D
 . S IBY=$G(^DGCR(399,IBIFN,"CP",OLDDA,"MOD",IBX,0)) Q:IBY=""
 . S:'$D(^DGCR(399,IBIFN,"CP",IBNEWDA,"MOD")) DIC("P")=$$GETSPEC^IBEFUNC(399.0304,16)
 . S DIC(0)="L",DIC="^DGCR(399,"_IBIFN_",""CP"","_+IBNEWDA_",""MOD"",",DLAYGO=399.30416
 . S DA(2)=IBIFN,DA(1)=IBNEWDA,X=+IBY,DIC("DR")=".02////"_$P(IBY,U,2) D FILE^DICN K DIC,DO,DD
 ;
COPYCPQ Q IBFND
 ;
ADDCPT(IBIFN,SDLN) ; add a new CPT code to a bill and populate it's data based on clinical data
 ; Input: SDLN - data line from ^UTILITY($J,"CPT-CNT" created in VST^IBCCPT
 ; ^utility($j,cpt-cnt,count)=code^date^on bill^is BASC^divis^nb^nb mess^provider^clinic^mod,mod^Opt Enc Ptr
 N DLAYGO,DIC,DIE,DA,DR,DD,DO,DINUM,IBNEWDA,IBFND,X,Y S IBFND=0
 ;
 I '$D(^DGCR(399,+$G(IBIFN),0)) G ADDCPTQ
 I '$G(SDLN) G ADDCPTQ
 I +$P(SDLN,U,6) G ADDCPTQ
 ;
 I '$D(^DGCR(399,IBIFN,"CP")) S DIC("P")=$$GETSPEC^IBEFUNC(399,304)
 S DLAYGO=399,DA(1)=IBIFN,DIC="^DGCR(399,"_DA(1)_",""CP"",",DIC(0)="L",X=+SDLN_";ICPT(" K DD,DO D FILE^DICN K DO,DD,DIC("P")
 S (DA,IBNEWDA,IBFND)=+Y I IBNEWDA<1 S IBFND=0 G ADDCPTQ
 ;
 S DR="1////"_$P(SDLN,U,2)_$S(+$P(SDLN,U,8):";18////"_+$P(SDLN,U,8),1:"")
 S DR=DR_$S(+$P(SDLN,U,9):";6////"_+$P(SDLN,U,9),1:"")_$S(+$P(SDLN,U,5):";5////"_+$P(SDLN,U,5),1:"")
 S DR=DR_$S(+$P(SDLN,U,11):";20////"_+$P(SDLN,U,11),1:"")
 S DIE=DIC,DA=+IBNEWDA D ^DIE K DIE,DIC,DA,DINUM,DO,DD
 ;
 I $P(SDLN,U,10) D ADDMOD^IBCCPT(IBIFN,IBNEWDA,$P(SDLN,U,10)) ;Modifiers
 ;
ADDCPTQ Q IBFND
 ;
GETSD(IBIFN) ; get the procedures from the clinical data covered by the bill
 ; Output: ^UTILITY($J,"CPT-CNT",X)= ... (from VST^IBCCPT)
 ;         ^UTILITY($J,"CPT-CLN",CPT,EVDT)= ...
 N SDCNT,SDQDATA,SDQUERY,V,X,IBQUERY,IBOPV1,IBOPV2,DGCNT,DFN,IBX,IBY K ^UTILITY($J)
 S DFN=$P($G(^DGCR(399,+$G(IBIFN),0)),U,2) Q:'DFN
 D VST^IBCCPT(.IBQUERY)
 S IBX=0 F  S IBX=$O(^UTILITY($J,"CPT-CNT",IBX)) Q:'IBX  D
 . S IBY=^UTILITY($J,"CPT-CNT",IBX)
 . S ^UTILITY($J,"CPT-CLN",$P(IBY,U,1),$P(IBY,U,2))=IBY
 Q

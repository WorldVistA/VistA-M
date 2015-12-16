IBCD3 ;ALB/ARH - AUTOMATED BILLER (ADD NEW BILL - CREATE BILL ENTRY) ;9/5/93
 ;;2.0;INTEGRATED BILLING;**14,55,52,91,106,125,51,148,160,137,210,245,260,405,384,516,522**;21-MAR-94;Build 11
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;Called by IBCD2,IBACUS2
 ;
EN(IBQUERY) ;
 N IBI,IBX,IBY,I,X,X1,X2,IBAC,IBCPY K IBDR,IBDR222 S IBAC=1
 S X=$P($T(WHERE),";;",2),X2=$P($T(WHERE+1),";;",2) F I=0:0 S I=$O(IB(I)) Q:'I  S X1=$P($E(X,$F(X,I)+1,999),";",1) S:X1="" X1=$P($E(X2,$F(X2,I)+1,999),";",1) I $D(IB(I))=1 S $P(IBDR($P(X1,"^",1)),"^",$P(X1,"^",2))=IB(I)
 F I=0,"C","M","M1","S","U","U1","U2" I $D(IBDR(I)) S ^DGCR(399,IBIFN,I)=IBDR(I)
 S $P(^DGCR(399,0),"^",3)=IBIFN,$P(^(0),"^",4)=$P(^(0),"^",4)+1
 S DIK="^DGCR(399,",DA=IBIFN D IX1^DIK K DA,DIK ; set cross-references
 ;
 ; Set the attending/rendering provider into provider multiple
 I $G(IB("PRV",.01))'="" D
 . S DIC("DR")="",I=.01
 . N IBV
 . ; Only file if the provider has an NPI.  otherwise it's not billable and would have to be removed from the claim later
 . I $$GETNPI^IBCEF73A($G(IB("PRV",.02)))]"" F  S I=$O(IB("PRV",I)) Q:'I  D
 .. I IB("PRV",I)="" Q
 .. S IBV(I)=IB("PRV",I),DIC("DR")=DIC("DR")_$S(DIC("DR")="":"",1:";")_I_"////^S X=IBV("_I_")"
 . S DIC="^DGCR(399,"_IBIFN_",""PRV"",",DIC(0)="L",DLAYGO=399,DA(1)=IBIFN,X=IB("PRV",.01)
 . K DO,DD D FILE^DICN K DO,DD,DLAYGO,DA,DIC
 ;
 ; Set the occurrence span codes for leave/pass days
 I $O(IB("OC",0)) D
 . N I,I1
 . S I1=0 F  S I1=$O(IB("OC",I1)) Q:'I1  D
 .. S I=0,DIC("DR")=""
 .. F  S I=$O(IB("OC",I1,I)) Q:'I  S DIC("DR")=DIC("DR")_$S(DIC("DR")="":"",1:";")_I_"////"_IB("OC",I1,I)
 .. S DIC="^DGCR(399,"_IBIFN_",""OC"",",DIC(0)="L",DLAYGO=399,DA(1)=IBIFN,DIC("P")=$$GETSPEC^IBEFUNC(399,41),X=IB("OC")
 .. K DO,DD D FILE^DICN K DO,DD,DLAYGO,DA,DIC
 ;
 ; file rx refills, default CPT and Dx if defined
 I $D(IB(362.4))>2 D  G END
 . N IBZ
 . S IBRX=0 F  S IBRX=$O(IB(362.4,IBRX)) Q:'IBRX  S IBY="" F  S IBY=$O(IB(362.4,IBRX,IBY)) Q:IBY=""  D
 .. S IBX=IB(362.4,IBRX,IBY) Q:IBX=""
 .. S IBZ=$$ADD^IBCSC5A($P(IBX,U),IBIFN,$P(IBX,U,4),$P(IBX,U,2),+IBRX,$P(IBX,U,3)_U_$P(IBX,U,5)_U_$P(IBX,U,6),IBY)
 ;
 ;file outpatient visit dates and find/store outpatient procedures and dx
 ;NOTE: If IBQUERY is defined at this point, it will be used to perform
 ;       the scan for outpatient procedures
 I '$$INPAT^IBCEF(IBIFN) D  G END
 . I $D(IB(43))>2 D
 .. S ^DGCR(399,IBIFN,"OP",0)="^399.043DA^" S IBX=0 F  S IBX=$O(IB(43,IBX)) Q:'IBX  D
 ... S DIC="^DGCR(399,"_IBIFN_",""OP"",",DIC(0)="L",DA(1)=IBIFN,(DINUM,X)=IBX,DLAYGO=399.043 K DD,DO D FILE^DICN K DIC,DA,DINUM,DO,DD,DLAYGO
 . ;
 . D VST^IBCCPT(.IBQUERY) I $D(^UTILITY($J,"CPT-CNT")) D
 .. N IBPRX
 .. S DIC("P")=$$GETSPEC^IBEFUNC(399,304)
 .. S IBY=0 F  S IBY=$O(^UTILITY($J,"CPT-CNT",IBY)) Q:'IBY  S IBX=^(IBY) I '$P(IBX,U,6) D
 ... S IBPRX(+$P(IBX,U,8))=""
 ... S DIC="^DGCR(399,"_IBIFN_",""CP"",",DIC(0)="L",DA(1)=IBIFN,X=+IBX_";ICPT(",DLAYGO=399 K DD,DO D FILE^DICN K DO,DD,DLAYGO Q:Y'>0
 ... ;
 ... S IBCPY=+Y
 ... ;
 ... ; add dx to 362.3 for associations if they exist
 ... I $G(^UTILITY($J,"CPT-CNT",IBY,"DX")) D ADDDX^IBCCPT1(IBIFN,IBCPY,^("DX"),.IBDR) I $L($G(IBDR)) S IBDR=IBDR_";"
 ... ;
 ... ;
 ... S DR=$G(IBDR)_"1////"_$P(IBX,U,2)_$S(+$P(IBX,U,8):";18////"_+$P(IBX,U,8),1:"") K IBDR
 ... S DR=DR_$S(+$P(IBX,U,9):";6////"_+$P(IBX,U,9),1:"")_$S(+$P(IBX,U,5):";5////"_+$P(IBX,U,5),1:"")
 ... S DR=DR_$S(+$P(IBX,U,11):";20////"_+$P(IBX,U,11),1:"")
 ... S DIE=DIC,DA=+IBCPY D ^DIE K DIE,DIC,DA,DINUM,DO,DD
 ... I $P(IBX,U,10) D ADDMOD^IBCCPT(IBIFN,IBCPY,$P(IBX,U,10)) ;Modifiers
 .. I $O(IBPRX(""))=$O(IBPRX(""),-1),$O(IBPRX(0)) D
 ... ;If only 1 provider - make it the rendering
 ... S IB("PRV",.02)=+$O(IBPRX(0))_";VA(200,",IB("PRV",.01)=3
 . K DGCNT,V,IBOPV1,IBOPV2,I,DGDIV,I1,DGNOD,DGCPTS,I7,I2,DGCPT,^UTILITY($J,"CPT-CNT")
 . ;
 . D OPTDX^IBCSC4D(DFN,IB(151),IB(152),.IBDX) I +IBDX D  K IBDX
 .. S IBY=0 F  S IBY=$O(IBDX(IBY)) Q:IBY=""  S IBX=IBDX(IBY) I '$P(IBX,U,5) D
 ... I '$D(^DGCR(399,"AOPV",DFN,(+$P(IBX,U,4)\1),IBIFN)) Q
 ... S DIC("DR")=".02////"_IBIFN,DIC="^IBA(362.3,",DIC(0)="L",X=+IBX,DLAYGO=362.3 K DD,DO D FILE^DICN
 ... K DIE,DIC,DA,DLAYGO,DO,DD
 ;
 ;store inpatient diagnosis and procedures, default admit dx to first dx found
 I $$INPAT^IBCEF(IBIFN) D  G END
 . I $G(^TMP("IBDX",$J))=IB(.08) D  K ^TMP("IBDX",$J)
 .. N IBXDEF S IBXDEF=0
 .. S (IBI,IBX)="" F  S IBX=$O(^TMP("IBDX",$J,IBX)) Q:'IBX  S IBY=0 F  S IBY=$O(^TMP("IBDX",$J,IBX,IBY)) Q:'IBY  D
 ... S IBZ=^TMP("IBDX",$J,IBX,IBY) Q:($$ICD9^IBACSV(+IBZ)="")  S IBI=IBI+1
 ... S DIC("DR")=".02////"_IBIFN_";.03////"_IBI I $P(IBZ,U,3)'="" S DIC("DR")=DIC("DR")_";.04///"_$P(IBZ,U,3)
 ... S DIC="^IBA(362.3,",DIC(0)="L",X=+IBZ,DLAYGO=362.3 K DD,DO D FILE^DICN K DIE,DIC,DA,DLAYGO,DO,DD
 ... I Y>0,'IBXDEF S IBXDEF=1,DR="215////"_+IBZ,DIE="^DGCR(399,",DA=IBIFN D ^DIE
 . ;
 . D PTFPRDT^IBCSC4A(+IB(.08),IB(151),IB(152),9) I $D(^UTILITY($J,"IB")) D  K ^UTILITY($J,"IB")
 .. S ^DGCR(399,IBIFN,"CP",0)="^399.0304AVI^"
 .. S IBX=0 F  S IBX=$O(^UTILITY($J,"IB",IBX)) Q:'IBX  S IBY=0 F  S IBY=$O(^UTILITY($J,"IB",IBX,IBY)) Q:'IBY  D
 ... S IBZ=^UTILITY($J,"IB",IBX,IBY) Q:($$ICD0^IBACSV(+IBZ)="")  S IBI=$P(^UTILITY($J,"IB",IBX,1),U,2)
 ... S DIC="^DGCR(399,"_IBIFN_",""CP"",",DIC(0)="L",DA(1)=IBIFN,X=+IBZ_";ICD0(",DLAYGO=399.0304 K DD,DO D FILE^DICN
 ... I Y>0 S DIE=DIC,DA=+Y,DR="1////"_(IBI\1) D ^DIE K DIE,DIC,DA,DLAYGO,DO,DD
 ;
END S IBX="1^Billing Record #"_$P(^DGCR(399,+IBIFN,0),"^",1)_" established for "_$P($G(^DPT(IBDFN,0)),U,1)
 ;
 S IBAUTO=1,DGPTUPDT="" I '$G(IBCHTRN) D PROC^IBCU7A(IBIFN) D ^IBCU6 ; auto calculate/store revenue codes
 ;
Q K %,%DT,IBDR,X1,X2,X3,X4,Y,DGDIRA,DGDIRB,DGDIR0,DIR,DGRVRCAL,DIC,DA,DR,DINUM,DGPTUPDT,DGXRF1,IBCHK,IBINDT,IBIDS,DLAYGO
 Q
 ;
WHERE ;;.01^0^1;.02^0^2;.03^0^3;.04^0^4;.05^0^5;.06^0^6;.07^0^7;.08^0^8;.09^0^9;.11^0^11;.17^0^17;.16^0^16;.18^0^18;.19^0^19;.2^0^20;.22^0^22;.27^0^27;112^M^12;151^U^1;152^U^2;155^U^5;157^U^7;101^M^1;158^U^8;159^U^9;160^U^10;161^U^11;162^U^12;
 ;;217^U2^3;221^U2^7;

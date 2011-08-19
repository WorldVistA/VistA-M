IBCRBC3 ;ALB/ARH - RATES: BILL CALCULATION SORT/STORE ;22-MAY-1996
 ;;2.0;INTEGRATED BILLING;**52,106,138,51**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
SORTCI ; process charge array - create new array sorted by bedsection and revenue code
 ; if bs, rv cd, unit charge, cpt, div, item type, item ptr and component all match then charge is combined
 ; Input:  TMP($J,"IBCRCC",X) = ...  (from IBCRBC2)
 ; Output: TMP($J,"IBCRCS",BS,RV CD,Y) = 
 ;         RV CD PTR ^ BS PTR ^ UNIT $ ^ UNITS ^ CPT ^ DIV ^ ITEM TYPE ^ ITEM PTR ^ CHARGE COMPONENT
 ;
 N IBI,IBLN,IBRVCD,IBBS,IBUNITS,IBCHG,IBCPT,IBDV,IBIT,IBIP,IBCMPT,IBTUNITS,IBK,IBJ,IBX K ^TMP($J,"IBCRCS")
 ;
 S IBI=0 F  S IBI=$O(^TMP($J,"IBCRCC",IBI)) Q:'IBI  D
 . ;
 . S IBLN=^TMP($J,"IBCRCC",IBI)
 . S IBRVCD=$P(IBLN,U,6),IBBS=$P(IBLN,U,7),IBCHG=$P(IBLN,U,12),IBUNITS=$P(IBLN,U,13) Q:'IBCHG
 . S IBCPT=$P(IBLN,U,14),IBDV=$P(IBLN,U,15),IBIT=$P(IBLN,U,16),IBIP=$P(IBLN,U,17),IBCMPT=$P(IBLN,U,18)
 . ;
 . S (IBTUNITS,IBK)=0 ; combine like charges
 . S IBJ=0 F  S IBJ=$O(^TMP($J,"IBCRCS",+IBBS,+IBRVCD,IBJ)) Q:'IBJ  D  Q:+IBTUNITS
 .. S IBK=IBJ,IBX=$G(^TMP($J,"IBCRCS",+IBBS,+IBRVCD,IBJ))
 .. I IBCHG=$P(IBX,U,3),IBCPT=$P(IBX,U,5),IBDV=$P(IBX,U,6),IBIT=$P(IBX,U,7),IBIP=$P(IBX,U,8),IBCMPT=$P(IBX,U,9) D
 ... S IBTUNITS=$P(IBX,U,4)
 . ;
 . I 'IBTUNITS S IBK=IBK+1 ; no combination, new line item charge
 . S IBTUNITS=IBTUNITS+IBUNITS
 . ;
 . S ^TMP($J,"IBCRCS",+IBBS,+IBRVCD,IBK)=IBRVCD_U_+IBBS_U_IBCHG_U_IBTUNITS_U_IBCPT_U_IBDV_U_IBIT_U_IBIP_U_IBCMPT
 Q
 ;
 ;
ADDBCHGS(IBIFN) ; store all auto calculated charges: add charges to bill:  sets RC multiple
 ; Input: TMP($J,"IBCRCS",BS,RV CD,X) = ... (from SORTCI)
 ;
 N IBX,IBI,IBJ,IBK,IBLN,IBRVCD,IBBS,IBCHG,IBUNITS,IBAUTOAD,IBCPT,IBDIV,IBITYP,IBIPTR,IBCMPNT,IBRCFN,Z
 ;
 D DSPHDR
 ;
 S IBI=0 F  S IBI=$O(^TMP($J,"IBCRCS",IBI)) Q:'IBI  D
 . S IBJ=0 F  S IBJ=$O(^TMP($J,"IBCRCS",IBI,IBJ)) Q:'IBJ  D
 .. S IBK=0 F  S IBK=$O(^TMP($J,"IBCRCS",IBI,IBJ,IBK)) Q:'IBK  D
 ... S IBLN=$G(^TMP($J,"IBCRCS",IBI,IBJ,IBK)) Q:IBLN=""
 ... ;
 ... ; add charges to RC multiple
 ... S IBRVCD=$P(IBLN,U,1),IBBS=$P(IBLN,U,2),IBCHG=$P(IBLN,U,3),IBUNITS=$P(IBLN,U,4),IBAUTOAD=1
 ... S IBCPT=$P(IBLN,U,5),IBDIV=$P(IBLN,U,6),IBITYP=$P(IBLN,U,7),IBIPTR=$P(IBLN,U,8),IBCMPNT=$P(IBLN,U,9)
 ... ;
 ... S IBRCFN=$$ADDRC^IBCRBF(IBIFN,IBRVCD,IBBS,IBCHG,IBUNITS,IBCPT,IBDIV,IBAUTOAD,IBITYP,IBIPTR,IBCMPNT)
 ... ;
 ... I +IBRCFN D
 .... I IBITYP=3,IBIPTR'="" D DEFAULT^IBCSC5C(IBIFN,+IBRCFN)
 .... S IBX=IBRVCD_U_IBCHG_U_IBUNITS_U_IBBS_U_IBITYP_U_IBIPTR_U_IBCPT D DSPLN(IBX)
 ;
 D CLEANRX(IBIFN)
 Q
 ;
CLEANRX(IBIFN) ; Clean up any procedures left over from deleted Rx entries
 N Z,DA,DIK
 S Z=0 F  S Z=$O(^TMP("IBCRRX",$J,Z)) Q:'Z  S DA=0 F  S DA=$O(^TMP("IBCRRX",$J,Z,DA)) Q:'DA  S DA(1)=IBIFN,DIK="^DGCR(399,"_DA(1)_",""CP""," D ^DIK
 K ^TMP("IBCRRX",$J)
 Q
 ;
DSPDL ;
 I $D(ZTQUEUED)!(+$G(IBAUTO)) Q
 W !,"Removing old Revenue Codes and Rate Schedules..."
 Q
DSPHDR ;
 I $D(ZTQUEUED)!(+$G(IBAUTO)) Q
 W !,"Updating Revenue Codes and Charges"
 W !,?9,"Rev Code",?19,"Units",?31,"Charge",?41,"Bedsection"
 Q
DSPLN(LN) ;
 I $D(ZTQUEUED)!(+$G(IBAUTO)) Q
 N RVCD,BS,ITM S LN=$G(LN)
 S RVCD=$P($G(^DGCR(399.2,+LN,0)),U,1),BS=$$EMUTL^IBCRU1(+$P(LN,U,4)),ITM=$$NAME^IBCSC61($P(LN,U,5),$P(LN,U,6))
 I ITM="",$P(LN,U,7) S ITM=$P($$CPT^ICPTCOD(+$P(LN,U,7),DT),U,2)
 W !,"Adding",?11,RVCD,?19,$J($P(LN,U,3),3),?28,"$",$J($P(LN,U,2),8,2),?41,$E(BS,U,26),?69,$E(ITM,1,11)
 Q

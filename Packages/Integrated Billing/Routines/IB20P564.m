IB20P564 ;ALB/CXW - IB*2.0*564 POST INIT: TIMEFRAME OF BILL UPDATE ;06-19-2017
 ;;2.0;INTEGRATED BILLING;**564**;21-MAR-94;Build 25
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
POST ; replace 'O' with '0' for timeframe of bill in #.06/399 & #.26/399
TBU ; old data stores in XTMP for tracking for 30 days from install date
 N IBA,IBC,IBCNT,IBIFN,IBTF,IBTFUB,IBRCD,IB564,DA,DIE,DR,DT,X,X1,X2
 S (IBC,IBCNT)=0,IB564="IB20P564"
 K ^XTMP(IB564)
 S DT=$$DT^XLFDT,X1=DT,X2=30 D C^%DTC
 S ^XTMP(IB564,0)=X_U_DT_U_"IB*2.0*564 POST INIT"
 D MSG("    Timeframe of Bill Fix Post-Install .....")
 S IBIFN=0 F  S IBIFN=$O(^DGCR(399,IBIFN)) Q:'IBIFN  S DR="" D
 . S IBRCD=$G(^DGCR(399,IBIFN,0))
 . S IBTF=$P(IBRCD,U,6)
 . S IBTFUB=$P(IBRCD,U,26)
 . S IBC=IBC+1
 . I IBC#1000=0 W "."
 . I IBTF="O" S DR=".06///0"
 . I IBTFUB="O" S DR=DR_";.26///0"
 . I DR'="" D
 .. S DIE="^DGCR(399,",DA=IBIFN D ^DIE
 .. S IBCNT=IBCNT+1,^XTMP(IB564,IBIFN)=IBRCD
 S ^XTMP(IB564,0)=^XTMP(IB564,0)_U_IBCNT
 D MSG(">>>>Total "_IBCNT_" bill"_$S(IBCNT'=1:"s",1:"")_" updated in the Bill/Claims (#399) file")
 ;
RCP ; input template compilation for timeframe of bill
 N DMAX,IBN,IBX
 S DMAX=$$ROUSIZE^DILF
 F IBN=1:1 S IBX=$P($T(TMPL+IBN),";;",2) Q:IBX=""  D COMP(IBX,DMAX)
 D MSG("    Timeframe of Bill Fix Post-Install Complete")
 Q
 ;
COMP(IBX,DMAX) ;
 N IBIEN,IBRTN,X,Y
 S IBIEN=$O(^DIE("B",IBX,0)) Q:'IBIEN
 S IBRTN=$P($G(^DIE(IBIEN,"ROUOLD")),U) Q:IBRTN=""
 S X=IBRTN,Y=IBIEN
 D EN^DIEZ
 Q
TMPL ;
 ;;IB SCREEN6
 ;;IB SCREEN7
 ;;
MSG(IBA) ;
 D MES^XPDUTL(IBA)
 Q

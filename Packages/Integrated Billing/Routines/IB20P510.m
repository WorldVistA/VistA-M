IB20P510 ;ALB/CXW - IB*2.0*510 RATE SCHEDULE & NON-BILLABLE REASON ; 09/25/2013 
 ;;2.0;INTEGRATED BILLING;**510**;21-MAR-94;Build 26
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
POST ; Post-install of patch installation 
 D MES^XPDUTL("IB*2.0*510 Post-Install starts...")
 D ADM,RNB
 D MES^XPDUTL("IB*2.0*510 Post-Install is complete.")
 Q
 ;
ADM ; Update national rate schedules to file (#363)
 N IBADFE,IBADJUST,IBCT,IBDISP,IBEFFDT,IBNM,IBRATY,IBRTN,IBT,IBX,IBY
 S IBADFE="",IBCT=0
 D MES^XPDUTL("  Updating national rate Schedules with administrative fee:")
 F IBX=1:1 S IBT=$P($T(RSF+IBX),";",3) Q:'$L(IBT)  D
 . S IBNM=$P(IBT,U)
 . S IBRATY=$P(IBT,U,2)
 . S IBRTN=$O(^DGCR(399.3,"B",IBRATY,0))
 . S IBDISP=$P(IBT,U,3)
 . S IBADJUST=$P(IBT,U,4)
 . S IBEFFDT=$P(IBT,U,5)
 . I $$RSEXIST(IBEFFDT,IBNM) D MES^XPDUTL("    >>>"_IBNM_" for "_IBRATY_" already exists") Q
 . I 'IBRTN D MES^XPDUTL("    >>>"_IBRATY_" rate type not defined, "_IBNM_" rate schedule not created") Q
 . ; latest ien if rate type has multiple
 . I $P($G(^DGCR(399.3,+IBRTN,0)),U,3) S IBRTN=$O(^DGCR(399.3,"B",IBRATY,99999),-1)
 . I $P($G(^DGCR(399.3,+IBRTN,0)),U,3) D MES^XPDUTL("    >>>"_IBRATY_" rate type not active, "_IBNM_" not created") Q
 . ;
 . D ENT^IB3PSOU(IBRATY,IBEFFDT,IBADFE,IBDISP,IBADJUST)
 . ;
 . I $$RSEXIST(IBEFFDT,IBNM) S IBCT=IBCT+1 D MES^XPDUTL("    >>>"_IBNM_" for "_IBRATY_" rate schedule added")
 D MES^XPDUTL("  Total "_IBCT_$S(IBCT=1:" entry",1:" entries")_" updated in the file (#363)")
 D MES^XPDUTL(" ")
ADMQ Q
 ;
RSEXIST(IBEFFDT,IBNM) ; return RS IFN if Rate Schedule exists for Effective Date
 N IBX,IBRSFN,IBRS0 S IBX=0
 S IBRSFN=0 F  S IBRSFN=$O(^IBE(363,IBRSFN))  Q:'IBRSFN  D  I IBX Q
 . S IBRS0=$G(^IBE(363,IBRSFN,0))
 . I $P(IBRS0,U,1)=IBNM,$P(IBRS0,U,5)=IBEFFDT S IBX=IBRSFN
 Q IBX
 ;
RNB ; Inactivate existing standard RNB in file (#356.8)
 N X,Y,DA,DIE,DR,IBCONM,IBCT,IBNM,IBRNB,IBRNB0,IBT,IBX S IBCT=0
 D MES^XPDUTL("  Inactivating entries of Claims Tracking non-billable reasons:")
 F IBX=1:1 S IBT=$P($T(OCODE+IBX),";",3) Q:'$L(IBT)  D
 . S IBCONM=$P(IBT,U,1)_" for "_$P(IBT,U,2)
 . S IBNM=$P(IBT,U,2)
 . S IBRNB=$O(^IBE(356.8,"B",IBNM,0))
 . S IBRNB0=$G(^IBE(356.8,+IBRNB,0))
 . I 'IBRNB D MES^XPDUTL("    >>>"_IBCONM_" not found") Q
 . I +$P(IBRNB0,U,5) D MES^XPDUTL("    >>>"_IBCONM_" is already inactive") Q 
 . ; inactivate code and clean up ecme flags
 . S DIE="^IBE(356.8,",DA=+IBRNB,DR=".02///@;.03///@;.05///1" D ^DIE
 . S IBCT=IBCT+1 D MES^XPDUTL("    >>>"_IBCONM_" inactivated")
 D MES^XPDUTL("  Total "_IBCT_$S(IBCT=1:" entry",1:" entries")_" updated in the file (#356.8)")
RNBQ Q
 ;
RSF ; name^rate type^dispensing fee^adjustment^effective date
 ;;INELIG-RX^INELIGIBLE^13.18^S X=X+13.18^3130813
 ;;HMN-RX^HUMANITARIAN^13.18^S X=X+13.18^3130813
 ;
OCODE ; code^name^ecme flag^ecme paper flag
 ;;CV25^HDHP PLAN NOT BILLED^1^0
 ; 

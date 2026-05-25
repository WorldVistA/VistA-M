IB20P840 ;MNTVBB/DTA - UPDATE TRICARE RX ADMINISTRATIVE FEE FOR CY 2026 ; 11/19/2025
 ;;2.0;INTEGRATED BILLING;**840**;21-MAR-94;Build 5
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
POST ; 
 ; Update TRICARE pharmacy administrative fee for CY 2026 in Rate Schedule (#363) file
 N IBA
 D BMSG("IB*2.0*840 Post-Install starts.....")
 D TRXAF
 D BMSG("IB*2.0*840 Post-Install is complete.")
 Q
 ;
TRXAF ; Rate Schedule
 N IBCT,IBI,IBT,IBX,IBRS,IBRSIN,IBRATY,IBEFFDT,IBADFE,IBDISP,IBADJUST
 D BMSG("  >>>Effect. JAN 01, 2026 of RX Rate Schedule Adjustment for the Rate Type:")
 S IBADFE="",IBEFFDT="3260101",IBCT=0
 F IBX=1:1 S IBT=$P($T(RSF+IBX),";;",2) Q:IBT="Q"  D
 . S IBRATY=$P(IBT,U)
 . S IBRSIN=$O(^DGCR(399.3,"B",IBRATY,0))
 . I 'IBRSIN D MSG("       "_IBRATY_" not defined in the RATE TYPE (#399.3) file, not added") Q
 . ; latest entry
 . S IBRSIN=$O(^DGCR(399.3,"B",IBRATY,99999),-1)
 . I $P($G(^DGCR(399.3,+IBRSIN,0)),U,3) D MSG("       "_IBRATY_" inactivated in the RATE TYPE (#399.3) file, not added") Q
 . I $$RSEXIST(IBEFFDT,IBRSIN) D MSG("       "_IBRATY_" already exists") Q
 . S IBDISP=$P(IBT,U,2)
 . S IBADJUST=$P(IBT,U,3)
 . ; inactivate rx RS for cy 2025 and add new rx RS for cy 2026
 . D ENT^IB3PSOU(IBRATY,IBEFFDT,IBADFE,IBDISP,IBADJUST)
 . ; double check if no active RS
 . I '$$RSEXIST(IBEFFDT,IBRSIN) D MSG("       "_IBRATY_" not added, no active RX Rate Schedule found") Q
 . S IBCT=IBCT+1 D MSG("       "_IBRATY)
 D BMSG("     Total "_IBCT_$S(IBCT>1:" entries",1:" entry")_" added to the RATE SCHEDULE (#363) file")
 Q
 ;
RSEXIST(IBEFFDT,IBRSIN) ; return RS IFN if Rate Schedule exists for Effective Date
 N IBX,IBRSFN,IBRS0 S IBX=0
 S IBRSFN=0 F  S IBRSFN=$O(^IBE(363,IBRSFN))  Q:'IBRSFN  D  I IBX Q
 . S IBRS0=$G(^IBE(363,IBRSFN,0))
 . I $P(IBRS0,U,2)=IBRSIN,$P(IBRS0,U,5)=IBEFFDT S IBX=IBRSFN
 Q IBX
 ;
MSG(IBA) ;
 D MES^XPDUTL(IBA)
 Q
BMSG(IBA) ;
 D BMES^XPDUTL(IBA)
 Q
 ;
RSF ; 3 Rate types^dispensing fee^adjustment
 ;;TRICARE^13.16^S X=X+13.16
 ;;TRICARE PHARMACY^13.16^S X=X+13.16
 ;;TRICARE REIMB. INS.^13.16^S X=X+13.16
 ;;Q
 ;

IB20P684 ;ALB/CXW - UPDATE TRICARE RX ADMINISTRATIVE FEE FOR CY 2021 ; 9/8/2020
 ;;2.0;INTEGRATED BILLING;**684**;21-MAR-94;Build 6
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
POST ; 
 ; Update TRICARE pharmacy administrative fee for CY 2021 in Rate Schedule (#363) file
 N IBA,U S U="^"
 D BMSG("IB*2.0*684 Post-Install starts.....")
 D TRXAF
 D BMSG("IB*2.0*684 Post-Install is complete.")
 Q
 ;
TRXAF ; Rate Schedule
 N IBCT,IBI,IBT,IBX,IBRS,IBRSIN,IBRATY,IBEFFDT,IBADFE,IBDISP,IBADJUST
 D BMSG("  >>>Effect. JAN 01, 2021 of RX Rate Schedule Adjustment for the Rate Type:")
 S IBADFE="",IBEFFDT="3210101",IBCT=0
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
 . ; inactivate rx entry for cy 2020 and add new rx entry for cy 2021
 . D ENT^IB3PSOU(IBRATY,IBEFFDT,IBADFE,IBDISP,IBADJUST)
 . ; double check
 . I '$$RSEXIST(IBEFFDT,IBRSIN) D MSG("       "_IBRATY_" not added") Q
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
 ;;TRICARE^16.11^S X=X+16.11
 ;;TRICARE PHARMACY^16.11^S X=X+16.11
 ;;TRICARE REIMB. INS.^16.11^S X=X+16.11
 ;;Q
 ;

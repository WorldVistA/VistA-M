IB20P578 ;ALB/CXW - UPDATE RX ADMINISTRATIVE FEE FOR CY2017 ;11-01-2016
 ;;2.0;INTEGRATED BILLING;**578**;21-MAR-94;Build 3
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
POST ; 
 ; Update pharmacy administrative fee for CY17 in Rate Schedule file 363
 N IBA,U S U="^"
 D MSG("IB*2.0*578 Post-Install starts.....")
 D TRXAF
 D MSG("IB*2.0*578 Post-Install is complete.")
 Q
 ;
TRXAF ; Rate Schedule
 N IBCT,IBI,IBT,IBMSG,IBX,IBRS,IBRSIN,IBRATY,IBEFFDT,IBADFE,IBDISP,IBADJUST
 D MSG("")
 D MSG("  >>>Effect. JAN 01, 2017 of RX Rate Schedule Adjustment for the Rate Type:")
 S IBADFE="",IBEFFDT="3170101",IBCT=0
 F IBX=1:1 S IBT=$P($T(RSF+IBX),";;",2) Q:IBT="Q"  D
 . S IBRATY=$P(IBT,U)
 . S IBRSIN=$O(^DGCR(399.3,"B",IBRATY,0))
 . I 'IBRSIN D MSG("       "_IBRATY_" not defined in the Rate Type file (#399.3), not added") Q
 . ; latest entry
 . S IBRSIN=$O(^DGCR(399.3,"B",IBRATY,99999),-1)
 . I $P($G(^DGCR(399.3,+IBRSIN,0)),U,3) D MSG("       "_IBRATY_" inactivated in the Rate Type file (#399.3), not added") Q
 . I $$RSEXIST(IBEFFDT,IBRSIN) D MSG("       "_IBRATY_" already exists") Q
 . S IBDISP=$P(IBT,U,2)
 . S IBADJUST=$P(IBT,U,3)
 . ; inactivate rx entry for cy2016 and add new rx entry for cy2017
 . D ENT^IB3PSOU(IBRATY,IBEFFDT,IBADFE,IBDISP,IBADJUST)
 . ; double check
 . I '$$RSEXIST(IBEFFDT,IBRSIN) D MSG("       "_IBRATY_" not added") Q
 . S IBCT=IBCT+1 D MSG("       "_IBRATY_" added")
 D MSG("")
 D MSG("     Total "_IBCT_$S(IBCT>1:" entries",1:" entry")_" added to the Rate Schedule file (#363)")
 D MSG("")
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
 ;
RSF ; Rate type^dispensing fee^adjustment
 ;;HUMANITARIAN^16.36^S X=X+16.36
 ;;INELIGIBLE^16.36^S X=X+16.36
 ;;INTERAGENCY^16.36^S X=X+16.36
 ;;NO FAULT INS.^16.36^S X=X+16.36
 ;;REIMBURSABLE INS.^16.36^S X=X+16.36
 ;;TORT FEASOR^16.36^S X=X+16.36
 ;;WORKERS' COMP.^16.36^S X=X+16.36
 ;;TRICARE REIMB. INS.^13.72^S X=X+13.72
 ;;TRICARE^13.72^S X=X+13.72
 ;;Q
 ;

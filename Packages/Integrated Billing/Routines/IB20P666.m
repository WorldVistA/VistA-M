IB20P666 ;ALB/CXW - UPDATE RX ADMINISTRATIVE FEE FOR CY 2020;11/12/2019
 ;;2.0;INTEGRATED BILLING;**666**;21-MAR-94;Build 5
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
POST ; 
 ; Update pharmacy administrative fee for CY 2020 in Rate Schedule file 363
 N IBA,U S U="^"
 D MSG("IB*2.0*666 Post-Install starts.....")
 D TRXAF
 D MSG("IB*2.0*666 Post-Install is complete.")
 Q
 ;
TRXAF ; Rate Schedule
 N IBCT,IBI,IBT,IBX,IBRS,IBRSIN,IBRATY,IBEFFDT,IBADFE,IBDISP,IBADJUST
 D MSG("")
 D MSG("  >>>Effect. JAN 01, 2020 of RX Rate Schedule Adjustment for the Rate Type:"),MSG("")
 S IBADFE="",IBEFFDT="3200101",IBCT=0
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
 . ; inactivate rx entry for cy 2019 and add new rx entry for cy 2020
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
RSF ; 26 Rate types^dispensing fee^adjustment
 ;;CC MTF REIMB INS^18.38^S X=X+18.38
 ;;CC NO-FAULT AUTO^18.38^S X=X+18.38
 ;;CC REIMB INS^18.38^S X=X+18.38
 ;;CC TORT FEASOR^18.38^S X=X+18.38
 ;;CC WORKERS' COMP^18.38^S X=X+18.38
 ;;CCN NO-FAULT AUTO^18.38^S X=X+18.38
 ;;CCN REIMB INS^18.38^S X=X+18.38
 ;;CCN TORT FEASOR^18.38^S X=X+18.38
 ;;CCN WORKERS' COMP^18.38^S X=X+18.38
 ;;CHOICE NO-FAULT AUTO^18.38^S X=X+18.38
 ;;CHOICE REIMB INS^18.38^S X=X+18.38
 ;;CHOICE TORT FEASOR^18.38^S X=X+18.38
 ;;CHOICE WORKERS' COMP^18.38^S X=X+18.38
 ;;DENTAL REIMB. INS.^18.38^S X=X+18.38
 ;;HUMANITARIAN^18.38^S X=X+18.38
 ;;HUMANITARIAN REIMB. INS.^18.38^S X=X+18.38
 ;;INELIGIBLE^18.38^S X=X+18.38
 ;;INTERAGENCY^18.38^S X=X+18.38
 ;;INELIGIBLE REIMB. INS.^18.38^S X=X+18.38
 ;;NO FAULT INS.^18.38^S X=X+18.38
 ;;REIMBURSABLE INS.^18.38^S X=X+18.38
 ;;TORT FEASOR^18.38^S X=X+18.38
 ;;WORKERS' COMP.^18.38^S X=X+18.38
 ;;TRICARE^15.45^S X=X+15.45
 ;;TRICARE PHARMACY^15.45^S X=X+15.45
 ;;TRICARE REIMB. INS.^15.45^S X=X+15.45
 ;;Q
 ;

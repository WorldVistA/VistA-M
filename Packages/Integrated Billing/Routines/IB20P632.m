IB20P632 ;ALB/CXW - UPDATE RX ADMINISTRATIVE FEE FOR CY2019;09/03/2018
 ;;2.0;INTEGRATED BILLING;**632**;21-MAR-94;Build 2
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
POST ; 
 ; Update pharmacy administrative fee for CY19 in Rate Schedule file 363
 N IBA,U S U="^"
 D MSG("IB*2.0*632 Post-Install starts.....")
 D TRXAF
 D MSG("IB*2.0*632 Post-Install is complete.")
 Q
 ;
TRXAF ; Rate Schedule
 N IBCT,IBI,IBT,IBX,IBRS,IBRSIN,IBRATY,IBEFFDT,IBADFE,IBDISP,IBADJUST
 D MSG("")
 D MSG("  >>>Effect. JAN 01, 2019 of RX Rate Schedule Adjustment for the Rate Type:"),MSG("")
 S IBADFE="",IBEFFDT="3190101",IBDRX="DTR-RX",IBCT=0
 F IBX=1:1 S IBT=$P($T(RSF+IBX),";;",2) Q:IBT="Q"  D
 . S IBRATY=$P(IBT,U)
 . S IBRSIN=$O(^DGCR(399.3,"B",IBRATY,0))
 . I 'IBRSIN D MSG("       "_IBRATY_" not defined in the Rate Type file (#399.3), not added") Q
 . ; latest entry
 . S IBRSIN=$O(^DGCR(399.3,"B",IBRATY,99999),-1)
 . I $P($G(^DGCR(399.3,+IBRSIN,0)),U,3) D MSG("       "_IBRATY_" inactivated in the Rate Type file (#399.3), not added") Q
 . I $$RSEXIST(IBEFFDT,IBRSIN) D MSG("       "_IBRATY_" already exists") Q
 . I IBRATY="DENTAL REIMB. INS.",'$O(^IBE(363,"B",IBDRX,0)),'$$DENT(IBRSIN,IBDRX) D MSG("       "_IBRATY_" not added") Q
 . S IBDISP=$P(IBT,U,2)
 . S IBADJUST=$P(IBT,U,3)
 . ; inactivate rx entry for cy2018 and add new rx entry for cy2019
 . D ENT^IB3PSOU(IBRATY,IBEFFDT,IBADFE,IBDISP,IBADJUST)
 . ; double check
 . I '$$RSEXIST(IBEFFDT,IBRSIN) D MSG("       "_IBRATY_" not added") Q
 . S IBCT=IBCT+1 D MSG("       "_IBRATY_" added")
 D MSG("")
 D MSG("     Total "_IBCT_$S(IBCT>1:" entries",1:" entry")_" added to the Rate Schedule file (#363)")
 D MSG("")
 Q
DENT(IBRSIN,IBDRX) ; return 1 if initial cs added for dental reim. ins. 
 N IBCS,DA,DLAYGO,DIC,DIE,DR,X,Y
 S IBCS="RX COST"
 I '$O(^IBE(363.1,"B",IBCS,0)) Q 0
 S DLAYGO=363,(DIC,DIE)="^IBE(363,",DIC(0)="L",X=IBDRX D FILE^DICN
 I Y<1 Q 0
 S DA=+Y,DR=".02///"_IBRSIN_";.03///"_"OUTPATIENT"_";.05///3180101" D ^DIE
 ; charge set
 S DA(1)=DA,DIC="^IBE(363,"_DA(1)_",11,",X=IBCS,DIC(0)="L",DIC("P")="363.0011P",DIC("DR")=".02///"_1 D ^DIC
 Q 1
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
 ;;DENTAL REIMB. INS.^17.66^S X=X+17.66
 ;;HUMANITARIAN^17.66^S X=X+17.66
 ;;HUMANITARIAN REIMB. INS.^17.66^S X=X+17.66
 ;;INELIGIBLE^17.66^S X=X+17.66
 ;;INTERAGENCY^17.66^S X=X+17.66
 ;;INELIGIBLE REIMB. INS.^17.66^S X=X+17.66
 ;;NO FAULT INS.^17.66^S X=X+17.66
 ;;REIMBURSABLE INS.^17.66^S X=X+17.66
 ;;TORT FEASOR^17.66^S X=X+17.66
 ;;WORKERS' COMP.^17.66^S X=X+17.66
 ;;TRICARE^14.73^S X=X+14.73
 ;;TRICARE REIMB. INS.^14.73^S X=X+14.73
 ;;Q
 ;

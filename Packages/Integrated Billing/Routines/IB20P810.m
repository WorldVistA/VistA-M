IB20P810 ;MNTVBB/RXD - UPDATE RX ADMINISTRATIVE FEE FOR CY 2025 ; 11/22/2024
 ;;2.0;INTEGRATED BILLING;**810**;21-MAR-94;Build 3
 ;;Per VA Directive 6402, this routine should not be modified.
 ; Reference to MES^XPDUTL in ICR #10141
 Q
EN ; Backup 363 RATE SCHEDULE File
 N I810FILE,I810FILES,IBCNT
 S I810FILE=""
 S I810FILES="363"
 S IBCNT=0
 F IBCNT=1:1:$L(I810FILES,"^") D
 . S I810FILE=$P(I810FILES,"^",IBCNT)
 . D GLBBKUP
 . Q
 ; Begin Update
 D POST
 Q
 ;
POST ; Update pharmacy administrative fee for CY 2025 in Rate Schedule file 363
 N IBA,U S U="^"
 D MSG("IB*2.0*810 Post-Install starts.....")
 D RXUPD
 D MSG("IB*2.0*810 Post-Install is complete.")
 Q
 ;
RXUPD ; Rate Schedule
 N IBCT,IBI,IBT,IBX,IBRS,IBRSIN,IBRATY,IBEFFDT,IBADFE,IBDISP,IBADJUST
 D MSG("")
 D MSG("  >>>Effect. JAN 01, 2025 of RX Rate Schedule Adjustment for the Rate Type:"),MSG("")
 S IBADFE="",IBEFFDT="3250101",IBCT=0
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
 . ; inactivate rx entry for cy 2024 and add new rx entry for cy 2025
 . D ENT^IB3PSOU(IBRATY,IBEFFDT,IBADFE,IBDISP,IBADJUST)
 . ; double check if no active RS
 . I '$$RSEXIST(IBEFFDT,IBRSIN) D MSG("       "_IBRATY_" not added, no active RX Rate Schedule found") Q
 . S IBCT=IBCT+1 D MSG("       "_IBRATY)
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
GLBBKUP  ; XTMP Backup of file(s)
 N IBBKNDE
 S IBBKNDE="IB*2.0*810-RATE SCHEDULE file updates (#363)"
 S ^XTMP("IB810P",0)=$$FMADD^XLFDT(DT,120)_"^"_DT_"^"_IBBKNDE
 M ^XTMP("IB810P",I810FILE,$H)=^IBE(I810FILE)
 Q
 ;
RSF ; 23 Rate types^dispensing fee^adjustment
 ;;CC MTF REIMB INS^15.61^S X=X+15.61
 ;;CC NO-FAULT AUTO^15.61^S X=X+15.61
 ;;CC REIMB INS^15.61^S X=X+15.61
 ;;CC TORT FEASOR^15.61^S X=X+15.61
 ;;CC WORKERS' COMP^15.61^S X=X+15.61
 ;;CCN NO-FAULT AUTO^15.61^S X=X+15.61
 ;;CCN REIMB INS^15.61^S X=X+15.61
 ;;CCN TORT FEASOR^15.61^S X=X+15.61
 ;;CCN WORKERS' COMP^15.61^S X=X+15.61
 ;;CHOICE NO-FAULT AUTO^15.61^S X=X+15.61
 ;;CHOICE REIMB INS^15.61^S X=X+15.61
 ;;CHOICE TORT FEASOR^15.61^S X=X+15.61
 ;;CHOICE WORKERS' COMP^15.61^S X=X+15.61
 ;;DENTAL REIMB. INS.^15.61^S X=X+15.61
 ;;HUMANITARIAN^15.61^S X=X+15.61
 ;;HUMANITARIAN REIMB. INS.^15.61^S X=X+15.61
 ;;INELIGIBLE^15.61^S X=X+15.61
 ;;INTERAGENCY^15.61^S X=X+15.61
 ;;INELIGIBLE REIMB. INS.^15.61^S X=X+15.61
 ;;NO FAULT INS.^15.61^S X=X+15.61
 ;;REIMBURSABLE INS.^15.61^S X=X+15.61
 ;;TORT FEASOR^15.61^S X=X+15.61
 ;;WORKERS' COMP.^15.61^S X=X+15.61
 ;;Q
 ;

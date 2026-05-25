IB20P839 ;MNTVBB/JWB - UPDATE RX ADMINISTRATIVE FEE FOR CY 2026 ; 11/19/2025
 ;;2.0;INTEGRATED BILLING;**839**;21-MAR-94;Build 1
 ;;Per VA Directive 6402, this routine should not be modified.
 ; Reference to MES^XPDUTL in ICR #10141
 Q
EN ; Backup 363 RATE SCHEDULE File
 N I839FILE,I839FILES,IBCNT
 S I839FILE=""
 S I839FILES="363"
 S IBCNT=0
 F IBCNT=1:1:$L(I839FILES,"^") D
 . S I839FILE=$P(I839FILES,"^",IBCNT)
 . D GLBBKUP
 . Q
 ; Begin Update
 D POST
 Q
 ;
POST ; Update pharmacy administrative fee for CY 2026 in Rate Schedule file 
 N IBA,U S U="^"
 D MSG("IB*2.0*839 Post-Install starts.....")
 D RXUPD
 D MSG("IB*2.0*839 Post-Install is complete.")
 Q
 ;
RXUPD ; Rate Schedule
 N IBCT,IBI,IBT,IBX,IBRS,IBRSIN,IBRATY,IBEFFDT,IBADFE,IBDISP,IBADJUST
 D MSG("")
 D MSG("  >>>Effect. JAN 01, 2026 of RX Rate Schedule Adjustment for the Rate Type:"),MSG("")
 S IBADFE="",IBEFFDT="3260101",IBCT=0
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
 . ; inactivate rx entry for cy 2025 and add new rx entry for cy 2026
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
GLBBKUP ; XTMP Backup of file(s)
 N IBBKNDE
 S IBBKNDE="IB*2.0*839-RATE SCHEDULE file updates (#363)"
 S ^XTMP("IB839P",0)=$$FMADD^XLFDT(DT,120)_"^"_DT_"^"_IBBKNDE
 M ^XTMP("IB839P",I839FILE,$H)=^IBE(I839FILE)
 Q
 ;
RSF ; 23 Rate types^dispensing fee^adjustment
 ;;CC MTF REIMB INS^12.97^S X=X+12.97
 ;;CC NO-FAULT AUTO^12.97^S X=X+12.97
 ;;CC REIMB INS^12.97^S X=X+12.97
 ;;CC TORT FEASOR^12.97^S X=X+12.97
 ;;CC WORKERS' COMP^12.97^S X=X+12.97
 ;;CCN NO-FAULT AUTO^12.97^S X=X+12.97
 ;;CCN REIMB INS^12.97^S X=X+12.97
 ;;CCN TORT FEASOR^12.97^S X=X+12.97
 ;;CCN WORKERS' COMP^12.97^S X=X+12.97
 ;;CHOICE NO-FAULT AUTO^12.97^S X=X+12.97
 ;;CHOICE REIMB INS^12.97^S X=X+12.97
 ;;CHOICE TORT FEASOR^12.97^S X=X+12.97
 ;;CHOICE WORKERS' COMP^12.97^S X=X+12.97
 ;;DENTAL REIMB. INS.^12.97^S X=X+12.97
 ;;HUMANITARIAN^12.97^S X=X+12.97
 ;;HUMANITARIAN REIMB. INS.^12.97^S X=X+12.97
 ;;INELIGIBLE^12.97^S X=X+12.97
 ;;INTERAGENCY^12.97^S X=X+12.97
 ;;INELIGIBLE REIMB. INS.^12.97^S X=X+12.97
 ;;NO FAULT INS.^12.97^S X=X+12.97
 ;;REIMBURSABLE INS.^12.97^S X=X+12.97
 ;;TORT FEASOR^12.97^S X=X+12.97
 ;;WORKERS' COMP.^12.97^S X=X+12.97
 ;;Q
 ;

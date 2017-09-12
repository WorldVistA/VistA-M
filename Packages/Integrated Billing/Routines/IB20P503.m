IB20P503 ;ALB/CXW - IB*2.0*503 Post Init: Administrative Charge Update; 11-26-2013 
 ;;2.0;INTEGRATED BILLING;**503**;21-MAR-94;Build 15
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
 ;
POST ; post-install of patch installation
 ; use default rate types of rx 3rd party to update RS in #363
 ; ibraty=rate type names from file #399.3
 ; ibeffdt=effective external date (mm/dd/yyyy)
 ; ibadfe=administrative fee (dollar.cent)
 ; ibdisp=dispensing fee (dollar.cent)
 ; ibadjust=adjustment mumps code
 ;
 N IBCT,IBI,IBJ,IBT,IBMSG,IBX,IBRS,IBRSIN,IBRATY,IBEFFDT,IBADFE,IBDISP,IBADJUST
 D MES^XPDUTL("Patch IB*2.0*503 Post-Install starts...")
 S IBMSG="rate schedule with adjustments"
 S IBADFE="",IBEFFDT="3140101",IBCT=0
 F IBX=1:1 S IBT=$P($T(RSF+IBX),";",3) Q:'$L(IBT)  D
 . S IBRATY=$P(IBT,U),IBRATY=$TR(IBRATY,"/",U)
 . S IBRS=""
 . F IBI=1:1 S IBJ=$P(IBRATY,U,IBI) Q:IBJ=""  D
 .. S IBRSIN=$O(^DGCR(399.3,"B",IBJ,0))
 .. I 'IBRSIN D MES^XPDUTL("     >>>"_IBJ_" not defined, the "_IBMSG_" not added") Q
 .. I $P($G(^DGCR(399.3,+IBRSIN,0)),U,3) S IBRSIN=$O(^DGCR(399.3,"B",IBJ,99999),-1)
 .. I $P($G(^DGCR(399.3,+IBRSIN,0)),U,3) D MES^XPDUTL("    >>>"_IBJ_" not active, the "_IBMSG_" not added") Q
 .. I $$RSEXIST(IBEFFDT,IBRSIN) D MES^XPDUTL("    >>>"_IBJ_" "_IBMSG_" already exists") Q
 .. S IBRS=IBRS_U_IBJ
 . S IBRATY=$E(IBRS,2,$L(IBRS)) Q:IBRS=""
 . S IBDISP=$P(IBT,U,2)
 . S IBADJUST=$P(IBT,U,3)
 . D ENT^IB3PSOU(IBRATY,IBEFFDT,IBADFE,IBDISP,IBADJUST)
 . F IBI=1:1 S IBJ=$P(IBRATY,U,IBI) Q:IBJ=""  D
 .. S IBRSIN=$O(^DGCR(399.3,"B",IBJ,0))
 .. I $$RSEXIST(IBEFFDT,IBRSIN) S IBCT=IBCT+1 D MES^XPDUTL("    >>>"_IBJ_" "_IBMSG_" added")
 D MES^XPDUTL("  Total "_IBCT_$S(IBCT=1:" entry",1:" entries")_" updated in the Rate Schedule file (#363)")
 D MES^XPDUTL("Patch IB*2.0*503 Post-Install is complete.")
 Q
 ;
RSEXIST(IBEFFDT,IBRSIN) ; return RS IFN if Rate Schedule exists for Effective Date
 N IBX,IBRSFN,IBRS0 S IBX=0
 S IBRSFN=0 F  S IBRSFN=$O(^IBE(363,IBRSFN))  Q:'IBRSFN  D  I IBX Q
 . S IBRS0=$G(^IBE(363,IBRSFN,0))
 . I $P(IBRS0,U,2)=IBRSIN,$P(IBRS0,U,5)=IBEFFDT S IBX=IBRSFN
 Q IBX
 ;
RSF ; 8 rate types separated by '/'^dispensing fee^adjustment
 ;;REIMBURSABLE INS./NO FAULT INS./WORKERS' COMP./TORT FEASOR/INELIGIBLE/HUMANITARIAN^13.07^S X=X+13.07
 ;;TRICARE REIMB. INS./TRICARE^11.56^S X=X+11.56
 ;

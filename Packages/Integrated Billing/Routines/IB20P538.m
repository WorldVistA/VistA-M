IB20P538 ;ALB/CXW - IB*2.0*538 Post Init: Administrative Charge Update; 10-15-2014 
 ;;2.0;INTEGRATED BILLING;**538**;21-MAR-94;Build 29
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
POST ; post-install of patch installation
 ; use default rate types for rx 3rd party bill to update RS in #363
 ; ibraty=rate type name from file #399.3
 ; ibeffdt=effective fileman date 
 ; ibadfe=administrative fee (dollar.cent)
 ; ibdisp=dispensing fee (dollar.cent)
 ; ibadjust=adjustment mumps code
 ;
 N U,IBCT,IBI,IBJ,IBMG,IBT,IBX,IBY,IBRS,IBRSIN,IBRATY,IBEFFDT,IBADFE,IBDISP,IBADJUST,Y
 D MES^XPDUTL("Patch IB*2.0*538 Post-Install starts...")
 D MES^XPDUTL("")
 S IBADFE="",IBCT=0,IBMG="rate schedule adjustment",U="^"
 F IBX=1:1 S IBT=$P($T(RSF+IBX),";",3) Q:'$L(IBT)  D
 . S IBRS=""
 . S IBRATY=$P(IBT,U),IBRATY=$TR(IBRATY,"/",U)
 . S IBDISP=$P(IBT,U,2)
 . S IBADJUST=$P(IBT,U,3)
 . S (Y,IBEFFDT)=$P(IBT,U,4)
 . D DD^%DT S IBY=Y
 . F IBI=1:1 S IBJ=$P(IBRATY,U,IBI) Q:IBJ=""  D
 .. S IBRSIN=$O(^DGCR(399.3,"B",IBJ,0))
 .. I 'IBRSIN D MES^XPDUTL("     >>>"_IBJ_" not defined in the Rate Type file (#399.3), no "_IBMG_" added for "_IBY) Q
 .. ; find the latest ien if multiple
 .. I $P($G(^DGCR(399.3,+IBRSIN,0)),U,3) S IBRSIN=$O(^DGCR(399.3,"B",IBJ,999999),-1)
 .. I $P($G(^DGCR(399.3,+IBRSIN,0)),U,3) D MES^XPDUTL("    >>>"_IBJ_" not active in the Rate Type file (#399.3), no "_IBMG_" added for "_IBY) Q
 .. I $$RSEXIST(IBEFFDT,IBRSIN) D MES^XPDUTL("    >>>Effective date of "_IBY_" for "_IBJ_" "_IBMG_" already exists") Q
 .. S IBRS=IBRS_U_IBJ
 . S IBRATY=$E(IBRS,2,$L(IBRS)) Q:IBRS=""
 . D ENT^IB3PSOU(IBRATY,IBEFFDT,IBADFE,IBDISP,IBADJUST)
 . F IBI=1:1 S IBJ=$P(IBRATY,U,IBI) Q:IBJ=""  D
 .. S IBRSIN=$O(^DGCR(399.3,"B",IBJ,0))
 .. I $$RSEXIST(IBEFFDT,IBRSIN) S IBCT=IBCT+1 D MES^XPDUTL("    >>>Effective date of "_IBY_" for "_IBJ_" "_IBMG_" added")
 D MES^XPDUTL("  Total "_IBCT_$S(IBCT=1:" entry",1:" entries")_" added to the Rate Schedule file (#363)")
 D MES^XPDUTL("")
 D MES^XPDUTL("Patch IB*2.0*538 Post-Install is complete.")
 Q
 ;
RSEXIST(IBEFFDT,IBRSIN) ; return RS IFN if Rate Schedule exists for Effective Date
 N IBX,IBRSFN,IBRS0 S IBX=0
 S IBRSFN=0 F  S IBRSFN=$O(^IBE(363,IBRSFN))  Q:'IBRSFN  D  I IBX Q
 . S IBRS0=$G(^IBE(363,IBRSFN,0))
 . I $P(IBRS0,U,2)=IBRSIN,$P(IBRS0,U,5)=IBEFFDT S IBX=IBRSFN
 Q IBX
 ;
RSF ; rate type separated by '/'^dispensing fee^adjustment^effective date
 ;;INTERAGENCY^13.07^S X=X+13.07^3140101
 ;;REIMBURSABLE INS./NO FAULT INS./WORKERS' COMP./TORT FEASOR/INELIGIBLE/HUMANITARIAN/INTERAGENCY^13.10^S X=X+13.10^3150101
 ;

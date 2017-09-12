IB20P501 ;ALB/CXW - IB*2.0*501 Post Init: Administrative Charge Update; 04-23-2013 
 ;;2.0;INTEGRATED BILLING;**501**;21-MAR-94;Build 10
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
 ;
POST ; post-install of patch installation
 ; update the dispensing fee/adjustment for rx rate types in file #363
 ; default rate types for 3rd party pharmacy claims
 ; ibraty=rate type names from file #399.3
 ; ibeffdt=effective external date (mm/dd/yyyy)
 ; ibadfe=administrative fee (dollar.cent)
 ; ibdisp=dispensing fee (dollar.cent)
 ; ibadjust=adjustment mumps code (+ibadjust to screen out an zero cent)
 ;
 N IBI,IBJ,IBRATY,IBEFFDT,IBADFE,IBDISP,IBADJUST
 D MES^XPDUTL("Patch Post-Install starts...")
 S IBRATY="REIMBURSABLE INS.^NO FAULT INS.^WORKERS' COMP.^TORT FEASOR"
 S IBEFFDT="01/01/2013"
 S IBADFE=""
 S IBDISP="13.18"
 S IBADJUST="S X=X+"_(+IBDISP+IBADFE)
 F IBI=1:1 S IBJ=$P(IBRATY,U,IBI) Q:IBJ=""  I '$O(^DGCR(399.3,"B",IBJ,0)) D MES^XPDUTL("The Rate Type "_IBJ_" not defined, the rate schedule adjustments not updated")
 D ENT^IB3PSOU(IBRATY,IBEFFDT,IBADFE,IBDISP,IBADJUST)
 D MES^XPDUTL("Patch Post-Install is complete.")
 Q
 ;

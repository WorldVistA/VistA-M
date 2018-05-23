IB20P460 ;ALB/CXW - IB*2.0*460 Post Init: Administrative Charge Update; 08-01-2011 
 ;;2.0;INTEGRATED BILLING;**460**;21-MAR-94;Build 3
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
 ;
POST ; post-install of patch installation
 ; update out-patient pharmacy admini/disp fee & adj change in file #363
 ; default rate types for 3rd party pharmacy claims
 ; ibraty=rate type name1^rate type name2^rate type name3.in file #399.3
 ; ibeffdt=effective external date (mm/dd/yyyy)
 ; ibadfe=administrative fee (dollar.cent)
 ; ibdisp=dispensing fee (dollar.cent)
 ; ibadjust=adjustment mumps code
 ;
 N IBI,IBJ,IBRATY,IBEFFDT,IBADFE,IBDISP,IBADJUST
 D MES^XPDUTL("Patch Post-Install starts...")
 S IBRATY="REIMBURSABLE INS.^NO FAULT INS.^WORKERS' COMP.^TORT FEASOR"
 S IBEFFDT="01/01/2012"
 S IBADFE=""
 S IBDISP="12.39"
 S IBADJUST=""
 I IBADJUST="" S IBADJUST="S X=X+"_(+IBDISP+IBADFE)
 F IBI=1:1 S IBJ=$P(IBRATY,U,IBI) Q:IBJ=""  I '$O(^DGCR(399.3,"B",IBJ,0)) D MES^XPDUTL("The Rate Type "_IBJ_" not defined, the rate schedule adjustments not updated")
 D ENT^IB3PSOU(IBRATY,IBEFFDT,IBADFE,IBDISP,IBADJUST)
 D MES^XPDUTL("Patch Post-Install is complete.")
 Q
 ;

IBCEMPRG ;ALB/JEH - Purge Status Messages ;25-apr-01
 ;;2.0;INTEGRATED BILLING;**137**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;This routine will run as part of the EDI nightly background job.
 ;It will purge status messages in a Final Reveiw Status from
 ;file 361.  If the field, Days to Wait to Purge Msgs(#8.02),
 ;of the IB Site Parameters file (#350.9) has been populated,
 ;status messages with a final review date prior to the # days to wait
 ;to purge msgs will be deleted.
 ;
EN ; -- main entry point for purging status messages in final review status
 N IBDAYS,IBDT,IBDELDT,DIK,DA,X
 S IBDAYS=$P($G(^IBE(350.9,1,8)),U,2)
 Q:'IBDAYS
 S X1=DT,X2=-IBDAYS D C^%DTC S IBDELDT=X
 S DIK="^IBM(361,"
 S IBDT=0 F  S IBDT=$O(^IBM(361,"AFR",IBDT)) Q:'IBDT!(IBDT>IBDELDT)  S DA=0 F  S DA=$O(^IBM(361,"AFR",IBDT,DA)) Q:'DA  D ^DIK
 Q
 ;

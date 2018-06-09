IB20P597 ;ALB/CXW - IB*2.0*597 POST-INIT: THIRD PARTY FOLLOW-UP SUMMARY ;Feb 09, 2018@10:11:43
 ;;2.0;INTEGRATED BILLING;**597**;21-MAR-94;Build 11
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
POST ;update the data in the Value field (#.02) of the file/subfile (#351.7/#351.702)
 N IBA,U S U="^"
 D MSG("IB*2.0*597 Post-Install starts.....")
 D MSG(""),TPFUS,MSG("")
 D MSG("IB*2.0*597 Post-Install is complete.")
 Q
 ;
TPFUS ; fix value of input variable for 3rd Party Follow-Up Summary
 ; ibsel = 5 is for all types
 N IBDA,IBDM,IBSEL,IBNM,IBIVA,DA,DIE,DR,X,Y
 S IBSEL="5,"
 S IBDM="IB DM EXTRACT REPORTS"
 S IBNM="THIRD PARTY FOLLOW-UP SUMMARY"
 S IBDA=$O(^IBE(351.7,"B",IBNM,0))
 I 'IBDA D MSG("  >>> "_IBNM_" of "_IBDM_" not found") Q
 S IBIVA=$O(^IBE(351.7,IBDA,1,"B","IBSEL",0))
 I 'IBIVA D MSG("  >>> Input variable IBSEL of "_IBNM_" not found") Q
 I $P($G(^IBE(351.7,IBDA,1,IBIVA,0)),U,2)=IBSEL D  Q 
 . D MSG("  >>> Value of input variable IBSEL of "_IBNM_" already")
 . D MSG("      updated in the "_IBDM_" file (#351.7)")
 S DA(1)=IBDA,DA=IBIVA
 S DIE="^IBE(351.7,"_DA(1)_",1,",DR=".02////"_IBSEL D ^DIE
 D MSG("  >>> Updating value of input variable IBSEL of "_IBNM)
 D MSG("      in the "_IBDM_" file (#351.7)")
 Q
 ;
MSG(IBA) ;
 D MES^XPDUTL(IBA)
 Q

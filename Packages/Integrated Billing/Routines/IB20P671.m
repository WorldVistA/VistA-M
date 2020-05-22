IB20P671 ;/Albany - IB*2.0*671 POST INSTALL;02/04/20 2:10pm
 ;;2.0;Integrated Billing;**671**;Mar 20, 1995;Build 13
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
POSTINIT ;Post Install for IB*2.0*671
 D BMES^XPDUTL(" >>  Starting the Post-Initialization routine for IB*2.0*671")
 D TSKPUSH  ; add the nightly task
 D TPFUS    ; fix Third Party Follow-up summary report
 D BMES^XPDUTL(" >>  End of the Post-Initialization routine for IB*2.0*671")
 Q
 ;
TSKPUSH ; task the  routine as a Night Job using TaskMan.
 ;
 N DIC,DLAYGO,TSTAMP,X,Y
 D MES^XPDUTL("Tasking Nightly Copay Synch ... ")
 ;
 I $$FIND1^DIC(19.2,,"B","IBUC MULTI FAC COPAY SYNCH","B") D MES^XPDUTL(" Already scheduled") Q  ; don't overwrite existing schedule
 S (DLAYGO,DIC)=19.2,DIC(0)="L"
 S X="IBUC MULTI FAC COPAY SYNCH"
 S TSTAMP=$$FMADD^XLFDT($$NOW^XLFDT(),1),$P(TSTAMP,".",2)="0200"
 S DIC("DR")="2////"_TSTAMP_";6////D@2AM"
 D ^DIC
 Q
 ; Update the IBSEL parameter
TPFUS ; fix value of input variable for 3rd Party Follow-Up Summary
 ; ibsel = 5 is for all types
 N IBDA,IBDM,IBSEL,IBNM,IBIVA,DA,DIE,DR,X,Y
 S IBSEL="5,"
 S IBDM="IB DM EXTRACT REPORTS"
 S IBNM="THIRD PARTY FOLLOW-UP SUMMARY"
 S IBDA=$O(^IBE(351.7,"B",IBNM,0))
 I 'IBDA D MES^XPDUTL("  >>> "_IBNM_" of "_IBDM_" not found") Q
 S IBIVA=$O(^IBE(351.7,IBDA,1,"B","IBSEL",0))
 I 'IBIVA D MES^XPDUTL("  >>> Input variable IBSEL of "_IBNM_" not found") Q
 I $P($G(^IBE(351.7,IBDA,1,IBIVA,0)),U,2)=IBSEL D  Q 
 . D MES^XPDUTL("  >>> Value of input variable IBSEL of "_IBNM_" already")
 . D MES^XPDUTL("      updated in the "_IBDM_" file (#351.7)")
 S DA(1)=IBDA,DA=IBIVA
 S DIE="^IBE(351.7,"_DA(1)_",1,",DR=".02////"_IBSEL D ^DIE
 D MES^XPDUTL("  >>> Updating value of input variable IBSEL of "_IBNM)
 D MES^XPDUTL("      in the "_IBDM_" file (#351.7)")
 Q
 ;

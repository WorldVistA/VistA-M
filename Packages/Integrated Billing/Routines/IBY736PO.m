IBY736PO ;SAB/EDE - IB*2.0*736 POST INSTALL;03/10/20 2:10pm
 ;;2.0;Integrated Billing;**736**;21-Nov-22;Build 7
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
EN ;Post Install for IB*2.0*709
 D BMES^XPDUTL(" >>  Starting the Post-Initialization routine for IB*2.0*709")
 D SETPARAM
 D BMES^XPDUTL(" >>  End of the Post-Initialization routine for IB*2.0*709")
 Q
 ;
SETPARAM ; set default value for IB site parameter 350.9/71.02
 N DA,DIE,DR,X,Y
 D MES^XPDUTL("Setting default start date for COMPACT ACT Benefit in IB SITE PARAMETER file...")
 S DA=1,DIE=350.9,DR="71.02///^S X=3230117" D ^DIE
 D MES^XPDUTL("Done.")
 Q
 ;

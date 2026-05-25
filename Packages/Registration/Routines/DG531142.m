DG531142 ;ALB/RFS - REPLACE VERBIAGE IN THE DIALOG(#.84) FILE ; 01/23/2025
 ;;5.3;REGISTRATION;**1142**;Aug 13, 1993;Build 2
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
EN ; ENTRY POINT
 S DIE="^DI(.84,",DA=261124,DR="2///This error is reported when an attempt is made to update a patient's current record flag assignment having a STATUS of 'ACTIVE' with an assignment having an ACTION of 'Reactivate'."
 D ^DIE
 K DIE,DA,DR
 S DIE="^DI(.84,",DA=261124,DR="4///Unable to 'Reactivate' an 'Active' assignment"
 D ^DIE
 K DIE,DA,DR
 D BMES^XPDUTL("Verbiage for entry 261124 in the DIALOG(#.84) file has been updated.")
 Q
 ;

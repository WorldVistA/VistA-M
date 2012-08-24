SD53P519 ;ALB/JAM - POST-INSTALL FOR PATCH SD*5.3*519 ; 6/21/07 8:15am
 ;;5.3;Scheduling;**519**;Aug 13, 1993;Build 6
 Q
POST ;Post-Install
 D MES^XPDUTL("******                                                               ******")
 D BMES^XPDUTL("This installation will update the Combat Veteran DEFAULT field (#.04) value")
 D MES^XPDUTL("in the OUTPATIENT CLASSIFICATION TYPE file (#409.41) to 'YES'.")
 D MES^XPDUTL(" ")
 D POST1
 D BMES^XPDUTL("******                                                               ******")
 Q
POST1 ;Update OUTPATIENT CLASSIFICATION TYPE file #409.41, DEFAULT field #.04
 N X,Y,DIC,DIE,DA,DR
 S DIC(0)="MX",DIC="^SD(409.41,",X="COMBAT VETERAN" D ^DIC
 I +Y'>0 D  Q
 .D MES^XPDUTL("     COMBAT VETERAN record not found. No change done.")
 I +Y'=7 D  Q
 .D MES^XPDUTL("     COMBAT VETERAN record doesn't match nationally distributed entry number.")
 S DA=7
 I $$GET1^DIQ(409.41,DA,.04)="YES" D  Q
 .D MES^XPDUTL("     COMBAT VETERAN DEFAULT field (#.04) already updated to YES.")
 S DIE=DIC,DR=".04////"_"YES" D ^DIE
 I $D(DTOUT)!($D(Y)'=0) D  K DTOUT Q
 . D MES^XPDUTL("    COMBAT VETERAN record not updated.")
 D MES^XPDUTL("     COMBAT VETERAN DEFAULT field (#.04) updated successfully.")
 Q

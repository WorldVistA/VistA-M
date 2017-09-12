DG53132P ;ALB/MM - POST-INSTALL DG*5.3*132 - UPDATE POST-KOREAN DATES ; 6/26/98
 ;;5.3;Registration;**132**;Aug 13, 1993
 ;
EN ;
 D BMES^XPDUTL(">>Updating POST-KOREAN entry in PERIOD OF SERVICE file (#21).")
 D MES^XPDUTL("    END DATE field (#.05) changed from 8/4/1964 to 2/27/1961.")
 D MES^XPDUTL("    BRIEF DESCRIPTION field (#20) changed to 2/1/55-2/27/61.")
 N DA,DIC,DIE,DR,X,Y
 S (DIC,DIE)="^DIC(21,"
 S DIC(0)="X"
 S X="POST-KOREAN"
 D ^DIC
 I +Y'>0 D  Q
 .D BMES^XPDUTL(">>>POST-KOREAN Entry not found.  Cannot continue with installation.")
 .D MES^XPDUTL("   Please contact the PIMS National VISTA Support Team for assistance.")
 S DA=+Y
 S DR=".05////2610227;20////(2/1/55-2/27/61)"
 D ^DIE
 Q

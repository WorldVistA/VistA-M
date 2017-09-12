DG182PRE ;ALB/SEK - DG*5.3*182 Pre-Install Routine ; 14-AUGUST-1999
 ;;5.3;Registration;**182**;Aug 13, 1993
 ;
 ;
EN ; Description: This entry point will be used as a driver for
 ;  pre-installation updates.
 ;
 ; Delete the STATUS field (#.03) from the ANNUAL MEANS TEST file (#408.31) and not the data.
 D DELSTAT
 ;
 Q
 ;
 ;
DELSTAT ; This procedure will delete the STATUS field (#03) from the
 ; ANNUAL MEANS TEST file (#408.31) and not the data.
 ;
 D BMES^XPDUTL(">>> Deleting the STATUS field (#.03) of the")
 D MES^XPDUTL("    ANNUAL MEANS TEST file (#408.31)")
 D MES^XPDUTL("    The STATUS field will be re-installed")
 D MES^XPDUTL("    during the installation process.")
 N DA,DIK
 S DIK="^DD(408.31,",DA=.03,DA(1)=408.31
 D ^DIK
 D BMES^XPDUTL(">>> Completed.")
 Q

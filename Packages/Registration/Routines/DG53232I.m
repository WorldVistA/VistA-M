DG53232I ;ALB/KCL - DG*5.3*232 Pre-Install Routine ; 20-MAY-1999
 ;;5.3;Registration;**232**;Aug 13, 1993
 ;
 ;
EN ; Description: This entry point will be used as a driver for
 ;  pre-installation updates.
 ;
 ; - Delete the ENROLLMENT STATUS (#27.15) file and it's data
 D DELSTAT
 ;
 Q
 ;
 ;
DELSTAT ; This procedure will delete the ENROLLMENT STATUS (#27.15) file and
 ; it's data if the file exists on the system.
 ;
 I '$D(^DD(27.15)) Q
 ;
 D BMES^XPDUTL(">>> Deleting the ENROLLMENT STATUS (#27.15) file...")
 D MES^XPDUTL("    The ENROLLMENT STATUS (#27.15) file will be re-installed")
 D MES^XPDUTL("    during the installation process.")
 S DIU="^DGEN(27.15,",DIU(0)="D"
 D EN^DIU2
 K DIU
 D BMES^XPDUTL(">>> Completed.")
 Q

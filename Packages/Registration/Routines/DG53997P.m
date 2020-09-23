DG53997P ;ALB/JAM - DG*5.3*997 POST-INSTALL ROUTINE TO REMOVE 2 ITEMS FROM MENU PROTOCOL ;04/03/2020 3:21pm
 ;;5.3;Registration;**997**;Aug 13,1993;Build 42
 ;
 ; IAs:
 ;  DELETE^XPDPROT:  Supported by ICR 5567
 Q
EP ; Entry Point
 N DGRET
 S DGRET=1
 D BMES^XPDUTL(">>> Patch DG*5.3*997 - Post-install...")
 D MES^XPDUTL("    Remove 'DGMTH EDIT HARDSHIP' and 'DGMTH DELETE HARDSHIP' item protocols")
 D MES^XPDUTL("    from 'DGMTH HARDSHIP MENU' menu protocol...")
 S DGRET=$$DELETE^XPDPROT("DGMTH HARDSHIP MENU","DGMTH EDIT HARDSHIP")
 I DGRET=1 D MES^XPDUTL("    - 'DGMTH EDIT HARDSHIP' item protocol removed...")
 I DGRET'=1 D MES^XPDUTL("    - 'DGMTH EDIT HARDSHIP' item protocol already removed...")
 S DGRET=$$DELETE^XPDPROT("DGMTH HARDSHIP MENU","DGMTH DELETE HARDSHIP")
 I DGRET=1 D MES^XPDUTL("    - 'DGMTH DELETE HARDSHIP' item protocol removed...")
 I DGRET'=1 D MES^XPDUTL("    - 'DGMTH DELETE HARDSHIP' item protocol already removed...")
 D MES^XPDUTL(">>> Patch DG*5.3*997 - Post-install complete.")
 Q

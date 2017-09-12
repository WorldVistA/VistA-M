DG53181P ;ALB/MM Delete field #1819 from Ward Location file (#42) - ;5/19/98
 ;;5.3;Registration;**181**;Aug 13 1993
EN ;   
 D BMES^XPDUTL(">>>DG*5.3*181 will delete the *SCHEDULED ADMISSION PATIENT field (#1819)")
 D MES^XPDUTL("   subfile #42.182 from the WARD LOCATION File (#42).  The data dictionary")
 D MES^XPDUTL("   and data found on the ""RSV"" node will be deleted.  This field has been")
 D MES^XPDUTL("   starred for deletion.")
DEL ;
 I '$D(^DD(42.182)) D BMES^XPDUTL("   Data dictionary not found on your system.  No updating needed.") Q
 N DIU
 S DIU=42.182
 S DIU(0)="DS"
 D EN^DIU2
 K ^DIC(42,"ARSV")
 D BMES^XPDUTL("   Done.")
 Q

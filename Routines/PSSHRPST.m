PSSHRPST ;WOIFO/STEVE GORDON - PRE - Post-Init to load pharmacy classes ;08/26/08
 ;;1.0;PHARMACY DATA MANAGEMENT;**136**;9/30/97;Build 89
 ;
 QUIT
 ;
EN ;  -- main entry point for pharmacy post-init
 ;XML (PSSPRE_1_0.XML) must be in Kernel default directory
 ;
 ; -- delete all classes gov package
 DO DELETE()
 ;
 ; --
 ; 
 NEW PSSTAT
 SET PSSTAT=$$IMPORT^XOBWLIB1($$GETDIR(),$$SUPPORT())
 IF 'PSSTAT DO
 . DO BMES^XPDUTL("Error occurred during the importing of pharmacy classes file:")
 . DO MES^XPDUTL("  Directory: "_$$GETDIR())
 . DO MES^XPDUTL("  File Name: "_$$SUPPORT())
 . DO MES^XPDUTL("      Error: "_$PIECE(PSSTAT,"^",2))
 . DO MES^XPDUTL(" o  Pharmacy class not imported.")
 ELSE  DO
 . DO MES^XPDUTL(" o  Pharmacy classes imported successfully.")
 . DO MES^XPDUTL(" ")
 . DO MAILMSG
 ;
 QUIT
 ;
DELETE() ; -- delete classes for clean slate and remove previous releases
 NEW PSSTAT
 ; -- delete all classes in pharmacy package
 DO BMES^XPDUTL(" o  Deleting gov classes:")
 ;
 SET PSSTAT=$SYSTEM.OBJ.DeletePackage("gov")
 DO BMES^XPDUTL("       ...[gov] deletion "_$SELECT(PSSTAT:"finished successfully.",1:"failed."))
 DO MES^XPDUTL("")
 QUIT
 ;
 ;
SUPPORT() ;Returns the standard name of the XML file
 ;
 Q "PSSPRE_1_0.XML"
 ;
GETDIR() ; -- get directory where install files are located--default is in Kernel parameters.
 QUIT $$DEFDIR^%ZISH()
 ;
MAILMSG ;
 N XMDUZ,XMY,XMSUB,XMTEXT,XMZ,XMMG,DIFROM
 S XMDUZ="PACKAGE PSS*1.0*136 INSTALL"
 S XMTEXT="^TMP($J,""PSSHRPST"","
 S XMY(+DUZ)=""
 S XMY("G.PSS ORDER CHECKS")=""
 S XMSUB="PSS*1.0*136 Installation Complete"
 S ^TMP($J,"PSSHRPST",1)="Installation of Patch PSS*1.0*136 has been successfully completed!"
 D ^XMD
 Q
 ;

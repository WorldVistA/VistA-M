ORAMP489 ;HPS/DM - Post Installation Tasks ; 10/22/18 2:29pm
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**489**;Dec 17, 1997;Build 4
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; This routine uses the following IAs:
 ; #10141 - MES^XPDUTL Kernel (supported)
 ; #2263 - EN^XPAR Kernel (supported)
 ;
 Q
EN ;
 ; Installing commands in the command file...
 D MES^XPDUTL("OR*3.0*489 Post install starting....updating Parameters...")
 ;
 ; Update ORAM GUI VERSION with new build number for AntiCoagulate.exe.
 D EN^XPAR("SYS","ORAM GUI VERSION",,"1.0.489.2")
 ;
 D MES^XPDUTL(" OR*3.0*489 Post Init complete")
 ;
 Q
ROLLBACK ;
 D MES^XPDUTL("OR*3.0*489 Rollback starting....updating Parameters...")
 ;
 ; Revert ORAM GUI VERSION to previous build number for AntiCoagulate.exe.
 D EN^XPAR("SYS","ORAM GUI VERSION",,"@")
 D DEL^XPAR("SYS","ORAM GUI VERSION")
 ;
 D MES^XPDUTL(" OR*3.0*489 Rollback complete")
 ;
 Q

DVBC227P ;ALB/BG;PATCH 227 POST INSTALL ; 9/17/21 9:48am
 ;;2.7;AMIE;**227**;Apr 10, 1995;Build 21
 ;Per VHA Directive 6402 this routine should not be modified
 ;Updates Capri Minimum version
 Q
 ;
PMAIN ;-- update DVBAB CAPRI MINIMUM VERSION Parameter.
 ;
 N DVBERR
 W !!,"*************************************************"
 W !!,"Start DVBAB CAPRI Minimum Version Parameter Update"
 W !,"-------------------------",!
 S DVBERR=$$ENXPAR("PKG","DVBAB CAPRI MINIMUM VERSION","CAPRI GUI V2.7*227.2*1*A*3211230*1.3*1.3")
 D UPDMSG("CAPRI Minimum Version",DVBERR)
 ;
 W !!,"-------------------------"
 W !,"End DVBAB CAPRI Minimum Version Parameter Updates"
 W !,"****************************************************",!!
 ;
 D STATUS ;add reroute status
 D DIVUPD ;update capri division exam list (#396.15) file for ehrm 2507/7131 mod
 ;
 Q
ENXPAR(DVBENT,DVBPAR,DVBVAL) ;
 ;
 N DVBERR
 D EN^XPAR(DVBENT,DVBPAR,1,DVBVAL,.DVBERR)
 Q DVBERR
 ;
 ;
UPDMSG(DVBPAR,DVBERR) ;
 ;
 I DVBERR D
 . D MES^XPDUTL(DVBPAR_" update FAILURE.")
 . D MES^XPDUTL("  Failure reason: "_DVBERR)
 E  D
 . D MES^XPDUTL(DVBPAR_" Update Successful")
 Q
 ;
STATUS ;adding new reroute status
 N DVBFDA,DVBERR
 D BMES^XPDUTL("Updating the CAPRI 2507 STATUS (396.33) file...")
 S FIND="RE-ROUTED, PENDING AT TO SITE"
 D FIND^DIC(396.33,"",.01,"X",.FIND,"","","","","OUT")
 I $G(OUT("DILIST",2,1))'="" D BMES^XPDUTL("NEW RE-ROUTE STATUS HAS ALREADY ADDED") Q
 S DVBFDA(396.33,"+1,",.01)=FIND
 S DVBFDA(396.33,"+1,",.02)="RS"
 D UPDATE^DIE("","DVBFDA","","DVBERR")
 I $G(DVBERR)'="" D BMES^XPDUTL("NEW RE-ROUTE STATUS COULD NOT BE ADDED BY POST-INSTALL ROUTINE.")
 I $G(DVBERR)="" D BMES^XPDUTL("NEW RE-ROUTE STATUS HAS BEEN ADDED.")
 K DVBERR,DVBFDA
 Q
 ;
DIVUPD ;add values to the new fields in the capri division exam list (#396.15) file
 N DVBAIEN,DVBAVAL,DVBAFIVE,DVBASIX,DVBASEVN,DVBAFDA,DVBAERR
 S DVBAIEN=0
 D BMES^XPDUTL("Updating the CAPRI DIVISION EXAM LIST (396.15) file...")
 F  S DVBAIEN=$O(^DVB(396.15,DVBAIEN)) Q:'DVBAIEN  D
  .S DVBAVAL=^DVB(396.15,DVBAIEN,3)
  .I $P(DVBAVAL,U)="Y" S DVBAFIVE="Y"
  .E  S DVBAFIVE="N"
  .S (DVBASIX,DVBASEVN)="N"
  .S DVBAFDA(396.15,DVBAIEN_",",5)=DVBAFIVE
  .S DVBAFDA(396.15,DVBAIEN_",",6)=DVBASIX
  .S DVBAFDA(396.15,DVBAIEN_",",7)=DVBASEVN
  .K DVBAERR D FILE^DIE(,"DVBAFDA","DVBAERR")
  .I '$D(DVBAERR) D BMES^XPDUTL("  >>Division "_$$GET1^DIQ(396.15,DVBAIEN_",",.01)_" (IEN #"_DVBAIEN_") updated successfully")
  .I $D(DVBAERR) D BMES^XPDUTL(">>>....Error updating Division "_$$GET1^DIQ(396.15,DVBAIEN_",",.01)_" (IEN #"_DVBAIEN_")") D
  ..D MES^XPDUTL("   ERROR: "_DVBAERR("DIERR","1")) ;print error code to help identify filing issue
  ..D BMES^XPDUTL("   *** Please contact support for assistance. ***")
 D BMES^XPDUTL("...CAPRI DIVISION EXAM LIST (396.15) file updates complete.")
 Q

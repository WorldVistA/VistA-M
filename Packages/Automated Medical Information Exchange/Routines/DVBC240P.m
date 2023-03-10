DVBC240P ;ALB/BG;PATCH 240 POST INSTALL ; 1/26/22 8:16am
 ;;2.7;AMIE;**240**;Apr 10, 1995;Build 15
 ;Per VHA Directive 6402 this routine should not be modified
 ;Updates Capri Minimum version
 Q
 ;
PMAIN ;-- update DVBAB CAPRI MINIMUM VERSION Parameter.
 ;
 N DVBERR,DVBERR2
 D BMES^XPDUTL("*************************************************")
 D BMES^XPDUTL("Start DVBAB CAPRI Minimum Version Parameter Update")
 S DVBERR=$$ENXPAR("PKG","DVBAB CAPRI MINIMUM VERSION","CAPRI GUI V2.7*240.1*1*A*3220415*1.3*1.3")
 D UPDMSG("CAPRI Minimum Version",DVBERR)
 D BMES^XPDUTL("End DVBAB CAPRI Minimum Version Parameter Updates")
 D MES^XPDUTL("**************************************************")
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

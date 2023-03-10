DVBC224P ;ALB/BG;PATCH 224 POST INSTALL ; 12/2/20 12:48pm
 ;;2.7;AMIE;**224**;Apr 10, 1995 ;Build 12
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
 ;
 S DVBERR=$$ENXPAR("PKG","DVBAB CAPRI MINIMUM VERSION","CAPRI GUI V2.7*224.3*1*A*3210205*1.3*1.3")
 D UPDMSG("CAPRI Minimum Version",DVBERR)
 ;
 W !!,"-------------------------"
 W !,"End DVBAB CAPRI Minimum Version Parameter Updates"
 W !,"****************************************************",!!
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

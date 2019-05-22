DVBC209P ;ALB/BG;PATCH 209 POST INSTALL ; 2/25/19 6:01pm
 ;;2.7;AMIE;**209**;Apr 10, 1995 ;Build 17
 ;Per VHA Directive 6402 this routine should not be modified
 ;Converts Null values for file DVB(396.15)
 ;Updates Capri Minimum version
 Q
 ;
EN ;
 W !!,"****************************************************"
 N DVBCX
 S DVBCX=0
 F  S DVBCX=$O(^DVB(396.15,DVBCX)) Q:DVBCX=""  D
 .I $P($G(^DVB(396.15,DVBCX,3)),U)="" S $P(^DVB(396.15,DVBCX,3),U)="N"
 W !!,"File 396.15 Updated"
 W !!,"****************************************************"
 ;
 ;
 ;
PMAIN ;-- update DVBAB CAPRI MINIMUM VERSION Parameter.
 ;
 N DVBERR
 W !!,"*************************************************"
 W !!,"Start DVBAB CAPRI Minimum Version Parameter Update"
 W !,"-------------------------",!
 ;
 S DVBERR=$$ENXPAR("PKG","DVBAB CAPRI MINIMUM VERSION","CAPRI GUI V2.7*209.1*1*A*3190528")
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

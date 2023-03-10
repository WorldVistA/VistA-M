DVBC237P ;ALB/BG;PATCH 237 POST INSTALL ; 12/8/21 9:33am
 ;;2.7;AMIE;**237**;Apr 10, 1995;Build 11
 ;Per VHA Directive 6402 this routine should not be modified
 ;This routine uses the following IAs:
 ;2263 - ^XPAR                  (supported)
 ;Adds News Server to the PARAMETER File (#8989.5)
 ;Updates Capri Minimum version
 Q
 ;
PARM ; main entry point
 ;adding file to 8989.5
 W !!,"*************************************************"
 D BMES^XPDUTL("Updating PARAMETER (#8989.5) FILE")
 N DVBERR,DVB1,DVB2,DVB3
 S DVBADD=$$FIND1^DIC(8989.5,"","X","DVBAB CAPRI NEWS SERVER URL","B","","ERR")
 I DVBADD'=0 D BMES^XPDUTL("Entry already exists") Q
 S DVBNM="DVBAB CAPRI NEWS SERVER URL"
 S DVB4="https://dvagov.sharepoint.com/:t:/r/sites/OITEPMOCAPRICOMM/Shared%20Documents/CAPRI%20Announcements/"
 D ADD^XPAR("PKG.AUTOMATED MED INFO EXCHANGE",DVBNM,,DVB4,.DVBERR)
 I $G(DVBERR)'=0 D BMES^XPDUTL("DVBAB CAPRI NEWS SERVER URL update FAILURE. REASON:"_$G(DVBERR))
 I $G(DVBERR)=0 D BMES^XPDUTL("DVBAB CAPRI NEWS SERVER URL update SUCCESS.")
 Q
PMAIN ;-- update DVBAB CAPRI MINIMUM VERSION Parameter.
 ;
 D PARM
 ;
 N DVBERR
 W !!,"*************************************************"
 W !!,"Start DVBAB CAPRI Minimum Version Parameter Update"
 W !,"-------------------------",!
 S DVBERR=$$ENXPAR("PKG","DVBAB CAPRI MINIMUM VERSION","CAPRI GUI V2.7*237.3*1*A*3220330*1.3*1.3")
 D UPDMSG("CAPRI Minimum Version",DVBERR)
 ;
 W !!,"-------------------------"
 W !,"End DVBAB CAPRI Minimum Version Parameter Updates"
 W !,"****************************************************",!!
 ;
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

DVBC220P ;ALB/BG;PATCH 220 POST INSTALL ; 7/7/20 11:37am
 ;;2.7;AMIE;**220**;Apr 10, 1995 ;Build 9
 ;Per VHA Directive 6402 this routine should not be modified
 ;Updates Capri Minimum version
 Q
 ;
 ;special consideration adds
SCADD ;
 N DVBAI,DVBLINE,FIND,OUT
 F DVBAI=1:1 S DVBLINE=$P($T(SCNEW+DVBAI),";;",2) Q:DVBLINE="QUIT"  D
 .K FIND,OUT
 .S FIND=$TR(DVBLINE,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 .D FIND^DIC(396.25,"",.01,"X",.FIND,"","","","","OUT")
 .I $G(OUT("DILIST",2,1))'="" D BMES^XPDUTL("SPECIAL CONSIDERATION: "_FIND_" HAS ALREADY BEEN ADDED.") Q
 .K FDA,ERR
 .S DVBLINE=$TR(DVBLINE,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 .S FDA(396.25,"+1,",.01)=DVBLINE
 .D UPDATE^DIE("","FDA","","ERR")
 .I $G(ERR)'="" D BMES^XPDUTL("SPECIAL CONSIDERATION: "_DVBLINE_" COULD NOT BE ADDED BY POST-INSTALL ROUTINE.") Q
 .D BMES^XPDUTL("SPECIAL CONSIDERATION: "_DVBLINE_" HAS BEEN ADDED.") Q
 Q
SCNEW ;
 ;;PURPLE HEART RECIPIENT
 ;;INCARCERATED
 ;;QUIT
 Q
 ;
PMAIN ;-- update DVBAB CAPRI MINIMUM VERSION Parameter.
 ;
 D SCADD
 N DVBERR
 W !!,"*************************************************"
 W !!,"Start DVBAB CAPRI Minimum Version Parameter Update"
 W !,"-------------------------",!
 ;
 S DVBERR=$$ENXPAR("PKG","DVBAB CAPRI MINIMUM VERSION","CAPRI GUI V2.7*220.9*1*A*3200925")
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

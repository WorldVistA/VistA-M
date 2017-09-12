DVBA165P ;ALB/RPM - PATCH DVBA*2.7*165 POST-INSTALL ; 12/2/10 4:19pm
 ;;2.7;AMIE;**165**;Apr 10, 1995;Build 3
 ;
 Q  ;NO DIRECT ENTRY
 ;
POST ;Main entry point for Post-init items.
 ;
 N DVBERR
 D BMES^XPDUTL("*************************")
 D MES^XPDUTL("Start Parameter Updates")
 D MES^XPDUTL("*************************")
 ;
 S DVBERR=$$ENXPAR("PKG","DVBAB CAPRI ALLOW OLD VERSION","NO")
 D UPDMSG("DVBAB CAPRI ALLOW OLD VERSION",DVBERR)
 ;
 S DVBERR=$$ENXPAR("PKG","DVBAB CAPRI MINIMUM VERSION","CAPRI GUI V2.7*149*1*A")
 D UPDMSG("DVBAB CAPRI MINIMUM VERSION",DVBERR)
 ;
 D MES^XPDUTL("*************************")
 D MES^XPDUTL("End Parameter Updates")
 D MES^XPDUTL("*************************")
 Q
 ;
ENXPAR(DVBENT,DVBPAR,DVBVAL) ;Update Parameter values
 ;
 ;  Input:
 ;    DVBENT - Parameter Entity
 ;    DVBPAR - Parameter Name
 ;    DVBVAL - Parameter Value
 ;
 ;  Output:
 ;    Function value - returns "0" on success;
 ;                     otherwise returns error#^errortext
 ;
 N DVBERR
 D EN^XPAR(DVBENT,DVBPAR,1,DVBVAL,.DVBERR)
 Q DVBERR
 ;
UPDMSG(DVBPAR,DVBERR) ;display update message
 ;
 ;  Input:
 ;    DVBPAR - Parameter Name
 ;    DVBERR - Parameter Update result
 ;
 ;  Output: none
 ; 
 I DVBERR D
 . D MES^XPDUTL(DVBPAR_" update FAILURE.")
 . D MES^XPDUTL("  Failure reason: "_DVBERR)
 I 'DVBERR D
 . D MES^XPDUTL(DVBPAR_" update SUCCESS.")
 Q

DVBA205P ;ALB/RRA - PATCH DVBA*2.7*205 POST-INSTALL ;5/14/2012
 ;;2.7;AMIE;**205**;Apr 10, 1995;Build 1
 ;
 Q  ;NO DIRECT ENTRY
 ;
POST ; Main entry point for post-int item
 ; "DVBAB CAPRI JLV URL" parameters  
 ;
 N DVBERR
 S DVBERR=$$ENXPAR("PKG","DVBAB CAPRI JLV URL","https://jlv.domain.ext/JLV/Login/loginParam?loginSource=CAPRI")
 D UPDMSG("DVBAB CAPRI JLV URL",DVBERR)
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
 E  D
 . D MES^XPDUTL(DVBPAR_" update SUCCESS.")
 Q
 ;

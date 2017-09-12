DVBA192P ;ALB/RTW - DVBA CAPRI PATCH 192 POST INSTALL ROUTINE; 07/09/2015  12:13 PM
 ;;2.7;AMIE;**192**;Apr 10, 1995;Build 15
 ;This routine updates the AMIE 290 report parameters
 D PARAM,END
 Q
END ;
 K DVBENT,DVBERR,DVBAL
 Q
 ;
PARAM ; new URL http://vaww.demo.domain.ext/dmareports.asp
 S DVBERR=$$ENXPAR("PKG","DVBAB CAPRI VICAP URL","http://vaww.demo.domain.ext/dmareports.asp")
 D UPDMSG("DVBAB CAPRI VICAP URL",DVBERR)
 Q
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

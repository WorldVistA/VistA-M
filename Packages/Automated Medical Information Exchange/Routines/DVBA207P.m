DVBA207P ;ALB/JR - PARAMETERS (#8989.5) FILE UPDATE ;7/24/2018 1:00PM
 ;;2.7;AMIE;**207**;Apr 10, 1995;Build 4
 ;
 Q
 ; This routine uses the following IAs:
 ; 2263 - ^XPAR                  (supported)
 ;
 ; Update the PARAMETER (#8989.5) file to use new LCM URLs
 ;
POST  ; main entry point
 ; Announce my intentions
 D BMES^XPDUTL("Updating PARAMETER (#8989.5) FILE")
 ;
 N DVBERR
 ; Update PROD
 D EN^XPAR("PKG","DVBAB CAPRI VIRTUALVA PROD URL",1,"https://vbaphiprdwlsappa.vba.domain.ext:7002/VABFI/services/vva?wsdl",.DVBERR)
 I DVBERR D
 . D BMES^XPDUTL("DVBAB CAPRI VIRTUALVA PROD URL update FAILURE.")
 . D MES^XPDUTL("  Failure reason: "_DVBERR)
 E  D
 . D BMES^XPDUTL("DVBAB CAPRI VIRTUALVA PROD URL update SUCCESS.")
 ;
 ; Update TEST
 D EN^XPAR("PKG","DVBAB CAPRI VIRTUALVA TEST URL",1,"https://vbaphitstwlsappa.vba.domain.ext:7002/VABFI/services/vva",.DVBERR)
 I DVBERR D
 . D BMES^XPDUTL("DVBAB CAPRI VIRTUALVA TEST URL update FAILURE.")
 . D MES^XPDUTL("  Failure reason: "_DVBERR)
 E  D
 . D BMES^XPDUTL("DVBAB CAPRI VIRTUALVA TEST URL update SUCCESS.")
 ;
 Q

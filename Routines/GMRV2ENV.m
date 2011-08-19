GMRV2ENV ;HIRMFO/FT-Environment check for GMRV*4*1 ;6/5/97 13:13
 ;;4.0;Vitals/Measurements;**1,7**;Apr 25, 1997
EN1 ; check if v4.0 installed
 I +$$VERSION^XPDUTL("GMRV")'>3 S XPDABORT=1 D BMES^XPDUTL("GEN. MED. REC. - VITALS v4.0 must be installed first.")
 Q

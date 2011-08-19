ONCENV16 ;Hines CIOFO/WAA - Enviroment Check for Patch ONC*2.11*16;3/20/98
 ;;2.11;Oncology;**16**;Mar 07, 1995
EN1 ;Enviroment check routine
 ;
 I +$$PATCH^XPDUTL("ONC*2.11*15")=0 D BMES^XPDUTL("Please install ONC*2.11*15 first. Installation Halted.") S XPDABORT=2
 Q

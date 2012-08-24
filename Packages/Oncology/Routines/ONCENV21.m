ONCENV21 ;Hines CIOFO/WAA - Enviroment Check for Patch ONC*2.11*21;3/20/98
 ;;2.11;Oncology;**21**;Mar 07, 1995
EN1 ;Enviroment check routine
 ;
 N PATCH1,PATCH2
 S PATCH1=$$PATCH^XPDUTL("ONC*2.11*20")
 S PATCH2=$$PATCH^XPDUTL("ONCO*2.11*20") ; fix for package file 
 I 'PATCH1,'PATCH2 D BMES^XPDUTL("Please install ONC*2.11*20 first. Installation Halted.") S XPDABORT=2
 Q

VIABRPC5 ;BAY/PIJ - Create Application Proxy user for VIA team ;06-FEB-14 3:36pm
 ;;1.0;VISTA INTEGRATION ADAPTER;**1**;06-FEB-14;Build 25
 ;
 ; ICR #4677 = $$CREATE^XUSAP (API for Application Proxy)
 ; ICR #10141 = BMES^XPDUTL & MES^XPDUTL
 ; 
 ; Application Proxy name = "VIABAPPLICATIONPROXY,VIAB"
 ; Secondary Menu Option name = "VIAB WEB SERVICES OPTION"
 ;
RUNALL ; Entry point in the (Patch - VIAB*1.0*1 v2) to run ALL 2 steps
 D BMSG("Starting Post-Init")
 D PROXY
 D MSG("Post-Init Complete")
 Q
 ;
PROXY ; Create an Application Proxy for VIAB application
 N X
 S X=$$CREATE^XUSAP("VIABAPPLICATIONPROXY,VIAB","","VIAB WEB SERVICES OPTION")
 ;
 I +X=0 D  Q
 . D BMSG("   Application Proxy User - 'VIABAPPLICATIONPROXY,VIAB'")
 . D MSG("   already exists in the NEW PERSON file (#200)"),MSG("")
 ;
 I +X=-1 D  Q
 . D BMSG("   Application Proxy User - 'VIABAPPLICATIONPROXY,VIAB'")
 . D MSG("   Unsuccessful; could not create Application Proxy User")
 . D MSG("   OR error in call to UPDATE^DIE)"),MSG("")
 ;
 D BMSG("   ********************************************************************")
 D MSG("   ** Application Proxy User - 'VIABAPPLICATIONPROXY,VIAB' = created **")
 D MSG("   ** Secondary Menu Option - 'VIAB WEB SERVICES OPTION' = linked    **")
 D MSG("   **                         to the Application Proxy.              **")
 D MSG("   ********************************************************************")
 D MSG("")
 Q
 ;
 ; A message is also recorded in INSTALL file
 ; (#9.7) entry for the installation.
 ;
 ; Output a message.
MSG(MSG) ; Integration Agreement #10141
 D MES^XPDUTL(MSG)
 Q
 ;
 ; Output a message with a blank line added.
BMSG(MSG) ; Integration Agreement #10141
 D BMES^XPDUTL(MSG)
 Q

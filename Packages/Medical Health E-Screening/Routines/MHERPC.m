MHERPC ;OIT/RRP - Create Application Proxy user for Mental Health Escreening ;April 8,2021@17:09
 ;;1.0;MEDICAL HEALTH ESCREENING;**0**;08-APR-21;Build 7
 ;
 ; ICR #4677 = $$CREATE^XUSAP (API for Application Proxy)
 ; ICR #10141 = BMES^XPDUTL & MES^XPDUTL
 ; 
 ; Application Proxy name = "MHEAPPLICATIONPROXY,MHE"
 ; Secondary Menu Option name = "MHE RPCS CONTEXT"
 ;
RUNALL ; Entry point in the (Patch - MHE*1.0*0) to run ALL 2 steps
 D BMSG("Starting Post-Init")
 D PROXY
 D MSG("Post-Init Complete")
 Q
 ;
PROXY ; Create an Application Proxy for MHE application
 N X
 S X=$$CREATE^XUSAP("MHEAPPLICATIONPROXY,MHE","","MHE RPCS CONTEXT")
 ;
 I +X=0 D  Q
 . D BMSG("   Application Proxy User - 'MHEAPPLICATIONPROXY,MHE'")
 . D MSG("   already exists in the NEW PERSON file (#200)"),MSG("")
 ;
 I +X=-1 D  Q
 . D BMSG("   Application Proxy User - 'MHEAPPLICATIONPROXY,MHE'")
 . D MSG("   Unsuccessful; could not create Application Proxy User")
 . D MSG("   OR error in call to UPDATE^DIE)"),MSG("")
 ;
 D BMSG("   ********************************************************************")
 D MSG("   ** Application Proxy User - 'MHEAPPLICATIONPROXY,MHE' = created **")
 D MSG("   ** Secondary Menu Option - 'MHE RPCS CONTEXT' = linked    **")
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

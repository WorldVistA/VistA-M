PSO7P774 ;ALB/RBD - patch 774 post-install ; 1/7/2025 1:15pm
 ;;7.0;OUTPATIENT PHARMACY;**774**;DEC 1997;Build 15
 ;
 ; ICR #4677 = $$CREATE^XUSAP (API for Application Proxy)
 ; ICR #10141 = BMES^XPDUTL & MES^XPDUTL
 ;
 ; Application Proxy name = "PSOAUTORELEASE,PROXY USER"
 ;
 Q
 ;
EN ; Entry point in the (Patch - PSO*7.0*774)
 D BMSG("Starting Post-Install")
 D PROXY
 D MSG("Post-Install Complete")
 Q
 ;
PROXY ; Create an Application Proxy for PSO Auto Release Proxy User
 N X
 S X=$$CREATE^XUSAP("PSOAUTORELEASE,PROXY USER","",)   ; Integration Agreement #4677
 ;
 I +X=0 D  Q
 .D BMSG("   Application Proxy User - 'PSOAUTORELEASE,PROXY USER'")
 .D MSG("   already exists in the NEW PERSON file (#200)"),MSG("")
 ;
 I +X=-1 D  Q
 .D BMSG("   Application Proxy User - 'PSOAUTORELEASE,PROXY USER'")
 .D MSG("   Unsuccessful; could not create Application Proxy User")
 .D MSG("   OR error in call to UPDATE^DIE"),MSG("")
 ;
 D BMSG("   ********************************************************************")
 D MSG("   ** Application Proxy User - 'PSOAUTORELEASE,PROXY USER' = created **")
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
 ;

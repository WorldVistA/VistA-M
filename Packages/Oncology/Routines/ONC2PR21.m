ONC2PR21 ;HINES OIFO/RTK - Pre-Install Routine for Patch ONC*2.2*21 ;10/23/24
 ;;2.2;ONCOLOGY;**21**;Jul 31, 2013;Build 6
 ;
 ; ICRs:
 ; #10141 XPDUTL
 ; #10060 FILE 200 fields
 Q
START ;start pre-init changes
 K ^ONCO(160.16)  ;delete 160.16 and bring back in patch 21 build
 K ^ONCO(164)     ;delete 164 and bring back in patch 21 build
 K ^ONCO(164.44)  ;delete 164.44 and bring back in patch 21 build
 K ^ONCO(165.8)   ;delete 165.8 and bring back in patch 21 build
 K ^ONCO(165.9)   ;delete 165.9 and bring back in patch 21 build
 K ^ONCO(166)     ;delete 166 and bring back in patch 21 build
 K ^ONCO(167.1)   ;delete 167.1 and bring back in patch 21 build
 K ^ONCO(167.7)   ;delete 167.7 and bring back in patch 21 build
 K ^ONCO(169.3)   ;delete 169.3 and bring back in patch 21 build
 D INITIALS
 D USERV
 Q
 ;
INITIALS ;Check if Oncology Registrar has initials in FILE 200
 ;FILE 165.5 - ONCOLOGY PRIMARY
 ;FILE 200   - NEW PERSON
 D BMES^XPDUTL("Checking if Oncology Registrar has INITIAL (#1) value in the NEW PERSON file (#200)")
 N ONCDUZ,ONCIEN,ONCINITIALS,ONCLIST,ONCNODE,ONCUSER
 S ONCIEN=0
 F  S ONCIEN=$O(^ONCO(165.5,ONCIEN)) Q:'ONCIEN  D
 .S ONCNODE=$G(^ONCO(165.5,ONCIEN,7))
 .S ONCDUZ=$P(ONCNODE,U,3) ;(#92) ABSTRACTED BY - pointer to FILE 200
 .Q:ONCDUZ=""  ;field can be null if the case is not "Completed"
 .S ONCINITIALS=$$GET1^DIQ(200,ONCDUZ_",",1,,,"ONCMSG")
 .Q:ONCINITIALS'=""  ;there are user initials
 .S ONCUSER=$$GET1^DIQ(200,ONCDUZ_",",.01,,,"ONCMSG")
 .S ONCLIST(ONCDUZ)=ONCUSER
 I '$D(ONCLIST) D  Q
 .D BMES^XPDUTL("All Registrars have initials defined.")
 D BMES^XPDUTL("The following users do not have their Initials in FILE 200, Field #1.")
 S ONCDUZ=0
 F  S ONCDUZ=$O(ONCLIST(ONCDUZ)) Q:'ONCDUZ  D
 .S ONCUSER=ONCLIST(ONCDUZ)
 .D BMES^XPDUTL(ONCUSER)
 Q
USERV ;Update url to Production or Development server
 N ONCSYS
 S ONCSYS=$$PROD^XUPROD()
 S DA=$O(^XOB(18.12,"B","ONCO WEB SERVER",""))
 ;production url
 I ONCSYS D
 .S DIE="^XOB(18.12,",DR=".04///^S X=""va-reg-prod-apim.reg.vaec.domain.ext""" D ^DIE
 .W !,"Oncology Web Server is updated to Production url...",!
 ;development url
 I 'ONCSYS D
 .S DIE="^XOB(18.12,",DR=".04///^S X=""va-reg-preprod-apim.reg.vaec.domain.ext""" D ^DIE
 .W !,"Oncology Web Server is updated to Development url...",!
 Q

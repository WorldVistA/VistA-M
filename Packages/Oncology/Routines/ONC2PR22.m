ONC2PR22 ;HINES OIFO/RTK - Pre-Install Routine for Patch ONC*2.2*22 ;04/30/25
 ;;2.2;ONCOLOGY;**22**;Jul 31, 2013;Build 6
 ;
 K ^ONCO(160.16)  ;delete 160.16 and bring back in patch 22 build
 K ^ONCO(164.44)  ;delete 164.44 and bring back in patch 22 build
 K ^ONCO(165.8)  ;delete 165.8 and bring back in patch 22 build
 K ^ONCO(165.9)  ;delete 165.9 and bring back in patch 22 build
 ;
 D USERV
 Q
 ;
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
 .;S DIE="^XOB(18.12,",DR=".04///^S X=""va-reg-devtest-apim.reg.vaec.domain.ext""" D ^DIE
 .S DIE="^XOB(18.12,",DR=".04///^S X=""va-reg-preprod-apim.reg.vaec.domain.ext""" D ^DIE
 .W !,"Oncology Web Server is updated to Development/Pre-Prod url...",!
 Q

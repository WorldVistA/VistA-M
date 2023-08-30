ONC2PR17 ;HINES OIFO/RTK - Pre-Install Routine for Patch ONC*2.2*17 ;02/14/23
 ;;2.2;ONCOLOGY;**17**;Jul 31, 2013;Build 6
 ;
 K ^ONCO(160.16)  ;delete 160.16 and bring back in the patch 17 build
 K ^ONCO(164.44)  ;delete 164.44 and bring back in the patch 17 build
 K ^ONCO(164.46)  ;delete 164.46 and bring back in the patch 17 build
 K ^ONCO(165.8)  ;delete 165.8 and bring back in patch 17 build
 K ^ONCO(165.9)  ;delete 165.9 and bring back in patch 17 build
 K ^ONCO(169.3)  ;delete 169.3 and bring back in patch 17 build
 K ^ONCO(160.2)  ;delete 160.2 and bring back in patch 17 build
 ;
 D USERV ;update url (development or production)
 Q
 ;
USERV ;Update url to Production or Development server
 S DA=$O(^XOB(18.12,"B","ONCO WEB SERVER",""))
 ;production url
 S DIE="^XOB(18.12,",DR=".04///^S X=""vaww.vaccrb.registries.domain.ext""" D ^DIE
 W !,"Oncology Web Server is updated to Production url...",!
 ;development url
 ;S DIE="^XOB(18.12,",DR=".04///^S X=""vaww.dev.vaccrb.registries.domain.ext""" D ^DIE
 ;W !,"Oncology Web Server is updated to Development url...",!
 Q

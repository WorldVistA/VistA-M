ONC2PR16 ;ALBANY OIFO/RTK - Pre-Install Routine for Patch ONC*2.2*16 ;02/01/23
 ;;2.2;ONCOLOGY;**16**;Jul 31, 2013;Build 5
 ;
WSERV ; create web server and service
 N ONC,ONIEN,ONCSIEN,ONERVIEN,ONRVIEN
 ; QUIT if the web service already exists
 I $$FIND1^DIC(18.02,,"B","ONCO VACCR WEB SERVICE") D  Q
 .W !!,"ONCO VACCR WEB SERVICE already exists..."
 .D USERV
 .Q
 ; set up the web service
 S ONC(18.02,"+1,",.01)="ONCO VACCR WEB SERVICE"
 S ONC(18.02,"+1,",.02)=2
 D UPDATE^DIE("E","ONC","ONIEN") K ONC
 ;Create Web Server
WSERV1 S ONCSIEN=$O(ONIEN(0)),ONCSIEN=$G(ONIEN(ONCSIEN)) Q:'ONCSIEN
 S ONC(18.12,"+1,",.01)="ONCO WEB SERVER"
 S ONC(18.12,"+1,",.03)=443
 S ONC(18.12,"+1,",.04)="vaww.vaccra.registries.domain.ext"
 S ONC(18.12,"+1,",.06)=1
 S ONC(18.12,"+1,",.07)=30
 S ONC(18.12,"+1,",1.01)=0
 S ONC(18.12,"+1,",3.01)=1
 S ONC(18.12,"+1,",3.02)="encrypt_only_tlsv12"
 S ONC(18.12,"+1,",3.03)=443
 D UPDATE^DIE("E","ONC","ONRVIEN","ONCERR") K ONC
WSERV2 S IENROOT1=$O(ONRVIEN(0)) Q:'IENROOT1
 S IENROOT1=$G(ONRVIEN(1)),MULTIEN=0
 K IENROOT,MSGROOT,ONC
 S VICEIEN=0 F  S VICEIEN=$O(^XOB(18.12,IENROOT1,100,"B",VICEIEN)) Q:'VICEIEN  I $$GET1^DIQ(18.02,VICEIEN,.01)="ONCO VACCR WEB SERVICE" S MULTIEN=VICEIEN Q
 S MULTIEN=$S(MULTIEN:MULTIEN,1:"+1")
 S ONC(18.121,MULTIEN_","_IENROOT1_",",.01)="ONCO VACCR WEB SERVICE"
 S ONC(18.121,MULTIEN_","_IENROOT1_",",.06)="ENABLED"
 D UPDATE^DIE("E","ONC","IENROOT","MSGROOT")
 ;
 D UPDATE^DIE("E","ONC",,"ERR") K ONC
 W !,"Oncology web service and server is installed",!
 Q
 ;
USERV ;Update url to Production or Development server
 S DA=$O(^XOB(18.12,"B","ONCO WEB SERVER",""))
 ;production url
 S DIE="^XOB(18.12,",DR=".04///^S X=""vaww.vaccra.registries.domain.ext""" D ^DIE
 W !,"Oncology Web Server is updated to Production url...",!
 ;development url
 ;S DIE="^XOB(18.12,",DR=".04///^S X=""vaww.dev.vaccra.registries.domain.ext""" D ^DIE
 ;W !,"Oncology Web Server is updated to Development url...",!
 Q

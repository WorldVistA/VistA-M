EC2P152 ;ALB/CMD - Installation activities ;Oct 19, 2020@16:08:26
 ;;2.0;EVENT CAPTURE;**152**;8 May 96;Build 19
 ;
POST ;Post-install activities
 D INACTECS ;Inactivate EC Screens associated with Inactive DSS Units
 D ADDKEY("ECACCESS")
 Q
 ;
INACTECS ;Inactivate event code screens associated with inactive DSS Units and send email with results
 ;
 N LOC,DSSU,ECIEN,DA,DIE,DR,ECSCR,ECPTR,ECDATA,ECFILE,SCREEN
 S ECSCR=0
 F  S ECSCR=$O(^ECJ("B",ECSCR)) Q:+ECSCR=0  D
 .S ECPTR=$P(ECSCR,"-",4),ECIEN=$O(^ECJ("B",ECSCR,0))
 .S DSSU=$P(ECSCR,"-",2) ; Pointer to DSS Unit file #724
 .Q:DSSU=""  ;If no DSS unit, quit
 .Q:'$D(^ECJ(ECIEN,0))  ;Screen doesn't exist
 .Q:+$P(^ECJ(ECIEN,0),"^",2)  ;Skip if event code screen is already inactive
 .I $P(^ECD(DSSU,0),U,6),$P(^ECD(DSSU,0),U,8) D
 ..S SCREEN(DSSU,ECIEN)="" ;put on list to inactivate if not already inactive
 S DSSU=0 F  S DSSU=$O(SCREEN(DSSU)) Q:'+DSSU  S ECIEN=0 F  S ECIEN=$O(SCREEN(DSSU,ECIEN)) Q:'+ECIEN  D
 .S DA=ECIEN,DIE="^ECJ(",DR="1////"_$$DT^XLFDT D ^DIE ;Set inactivation date to today
 D MAIL(.SCREEN) ;
 Q
 ;
MAIL(SCREEN) ;Send email with results to holders of the ECMGR key
 N XMSUB,XMTEXT,XMDUZ,XMY,XMZ,CNT,DIFROM,ECTEXT,NUM,NAME
 N DSSU,ACLIN,CAT,CPT,ECIEN,LOC,PRO,PX
 S XMDUZ="PATCH EC*2*152 POST-INSTALL"
 D GETXMY("ECMGR",.XMY)
 S XMDUZ="Event Capture Package"
 S XMSUB="Inactivation of Event Code Screens from inactive DSS Units"
 S XMTEXT="ECTEXT("
 S CNT=1
 I '$D(SCREEN) D
 .S ECTEXT(CNT)="No Event Code Screens were inactivated, as no inactive",CNT=CNT+1,ECTEXT(CNT)="DSS Units were found in use.",CNT=CNT+1
 I $D(SCREEN) D
 .S ECTEXT(CNT)="The following Event Code Screens have been inactivated",CNT=CNT+1
 .S ECTEXT(CNT)="because these Event Code Screens were associated with inactive DSS Units.",CNT=CNT+1
 S ECTEXT(CNT)=" ",CNT=CNT+1
 S DSSU=0 F  S DSSU=$O(SCREEN(DSSU)) Q:'+DSSU  D
 .S ECTEXT(CNT)="DSS UNIT: "_$$GET1^DIQ(724,DSSU,.01,"E")_" ("_DSSU_")",CNT=CNT+1
 .S ECIEN=0 F  S ECIEN=$O(SCREEN(DSSU,ECIEN)) Q:'+ECIEN  D
 ..S LOC=$$GET1^DIQ(4,$P($P(^ECJ(ECIEN,0),U),"-"),.01,"E"),PRO=$G(^EC(725,+$P($P(^ECJ(ECIEN,0),U),"-",4),0)),PX=$P(PRO,U,2)_" "_$P(PRO,U)
 ..S ECTEXT(CNT)="  LOC: "_LOC_$$REPEAT^XLFSTR(" ",(27-$L(LOC)))_"PROC: "_PX,CNT=CNT+1
 ..S CAT=$P($P(^ECJ(ECIEN,0),U),"-",3),CAT=$S(CAT:$P($G(^EC(726,CAT,0)),U),1:""),CPT=$$GET1^DIQ(81,+$P(PRO,U,5),.01,"E")
 ..S ECTEXT(CNT)="  CAT: "_CAT_$$REPEAT^XLFSTR(" ",(27-$L(CAT)))_"CPT: "_CPT,CNT=CNT+1
 ..S ACLIN=$$GET1^DIQ(44,+$P(^ECJ(ECIEN,"PRO"),U,4),.01,"E"),ECTEXT(CNT)="  DEFAULT ASSOCIATED CLINIC: "_ACLIN,CNT=CNT+1
 ..S ECTEXT(CNT)=" ",CNT=CNT+1
 D ^XMD
 Q
 ;
GETXMY(KEY,XMY) ;Put holders of the KEY into the XMY array to be recipients of the email
 I $G(KEY)'="" M XMY=^XUSEC(KEY)
 S:$G(DUZ) XMY(DUZ)="" ;Make sure there's at least one recipient
 Q
 ;
ADDKEY(KEY) ;Add new key,ECACCSS,to security file #19.1
 N KEYIEN,ECXFDA,DESC
 S DESC(1)="This key will give Non-Manager users the right to grant or remove DSS Unit "
 S DESC(2)="access."
 I $$FIND1^DIC(19.1,"","X","ECACCESS") D  Q
 .D BMES^XPDUTL(">>>..."_KEY_" not added, entry already exists.")
 ;Setup field values of new entry
 S ECXFDA(19.1,"+1,",.01)=KEY
 ;-add new entry to file #19.1
 D UPDATE^DIE("","ECXFDA","KEYIEN","ECXERR")
 S KEYIEN=$G(KEYIEN(1))
 D WP^DIE(19.1,KEYIEN_","_1,"K","DESC","ECXERR")
 I '$D(ECXERR) D BMES^XPDUTL(">>>.... security key"_KEY_" added to file.")
 I $D(ECXERR) D BMES^XPDUTL(">>>....Unable to add security key"_KEY_" to file.")
 Q
 ;

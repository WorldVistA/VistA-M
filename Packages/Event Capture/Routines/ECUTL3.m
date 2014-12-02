ECUTL3 ;ALB/DAN - Event capture utilities (cont) ;2/6/14  10:06
 ;;2.0;EVENT CAPTURE;**122**;8 May 96;Build 2
INACTSCR(ACTION) ;Inactivate event code screens associated with inactive national procedure codes
 ;
 ;ACTION - optional
 ;         0 - Don't inactivate, test what would happen
 ;         1 - Inactivate identified event code screens
 ;
 N SCREEN,LOC,DSSU,ECIEN,DA,DIE,DR,ECSCR,ECPTR,ECDATA,ECFILE
 S:'$D(ACTION) ACTION=0 ;If not sent in, assume testing
 S ECSCR=0
 F  S ECSCR=$O(^ECJ("B",ECSCR)) Q:+ECSCR=0  D
 .S ECPTR=$P(ECSCR,"-",4),ECIEN=$O(^ECJ("B",ECSCR,0))
 .Q:'$D(^ECJ(ECIEN,0))  ;Screen doesn't exist
 .Q:+$P(^ECJ(ECIEN,0),"^",2)  ;Skip if event code screen is already inactive
 .S ECFILE=$P(ECPTR,";",2)
 .;ec screens pointing to file #725
 .I ECFILE["EC(725" S ECDATA=$G(^EC(725,$P(ECPTR,";",1),0)) D
 ..Q:$P(ECDATA,U,3)=""  ;Skip if national procedure code is active
 ..I $P(ECDATA,U,3)>DT,ACTION Q  ;If inactivation date is in the future and we're inactivating event code screens, skip it as we don't want to inactivate screen until procedure is inactive
 ..S DSSU=$P(ECSCR,"-",2) Q:DSSU=""  ;If no DSS unit, quit
 ..S SCREEN(DSSU,ECIEN)="" ;put on list to inactivate if not already inactive
 I $G(ACTION) S DSSU=0 F  S DSSU=$O(SCREEN(DSSU)) Q:'+DSSU  S ECIEN=0 F  S ECIEN=$O(SCREEN(DSSU,ECIEN)) Q:'+ECIEN  D
 .S DA=ECIEN,DIE="^ECJ(",DR="1////"_$$DT^XLFDT D ^DIE ;Set inactivation date to today
 ;
MAIL ;Send email to group showing action taken
 N XMSUB,ECTEXT,XMDUZ,XMY,XMZ,XMTEXT,KIEN,DIFROM,LOC,PRO,CNT,PX,CAT,CPT,ACLIN
 S XMDUZ="Event Capture Package"
 S XMY($G(DUZ,.5))="" ;Set recipient to installer or postmaster
 S KIEN=0 F  S KIEN=$O(^XUSEC("ECMGR",KIEN)) Q:'+KIEN  S XMY(KIEN)="" ;Holders of ECMGR included in email, XUSEC read allowed by DBIA #10076
 S XMSUB="Inactivation of Event Code Screens from inactive procedure codes"
 S XMTEXT="ECTEXT("
 S CNT=1
 I '$D(SCREEN) D
 .S ECTEXT(CNT)="No Event Code Screens were inactivated, as no inactive",CNT=CNT+1,ECTEXT(CNT)="EC Procedure Codes were found in use.",CNT=CNT+1
 I $D(SCREEN) D
 .S ECTEXT(CNT)="The following event code screens "_$S($G(ACTION):"",1:"would ")_"have been inactivated",CNT=CNT+1
 .S ECTEXT(CNT)="because these Event Code Screens were associated",CNT=CNT+1
 .S ECTEXT(CNT)="with inactive EC Procedure Codes.",CNT=CNT+1
 I '$G(ACTION),$D(SCREEN) S ECTEXT(CNT)=" ",CNT=CNT+1 D
 .S ECTEXT(CNT)="Inactivations have not yet occurred; this list represents event code",CNT=CNT+1,ECTEXT(CNT)="screens that will be inactivated automatically "_$S($G(DAYS):DAYS_" days ",1:"")_"in the future.",CNT=CNT+1
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
 D ^XMD ;Send email
 Q
 ;
QINACT ;Queue the inactivation of event code screens to happen
 ;in the background.  Comes from "AC" cross reference of the
 ;INACTIVE DATE (#2) field of file 725
 N ZTRTN,ZTDTH,ZTDESC,ZTIO,ZTSK
 S ZTRTN="INACTSCR^ECUTL3(1)",ZTDTH=$H,ZTDESC="Inactivate event code screens with inactive procedure codes",ZTIO="" D ^%ZTLOAD
 Q

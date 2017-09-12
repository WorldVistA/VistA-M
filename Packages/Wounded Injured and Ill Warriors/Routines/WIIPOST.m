WIIPOST ;VISN20/WHN/WDE POST INIT
 ;;1.0;Wounded Injured and Ill Warriors;**1**;06/12/2008;Build 28
 ;------------------------------------------------------------------------------------------------- ;
 ;This post init will be used to populate the WII PARM file with the mail group exported with this build.
 ;-------------------------------------------------------------------------------------------------
 ;
EN ;
 S WIIDA=0 F  S WIIDA=$O(^WII(987.6,WIIDA)) Q:(WIIDA="")!('+WIIDA)  D
 .S DIK="^WII(987.6,",DA=WIIDA D ^DIK
 .Q
 K DIK,WIIDA,DA
 S WIIMAIL="" S WIIMAIL=$O(^XMB(3.8,"B","WII ADT REVIEWER",WIIMAIL))  ;mail group sent out with the build
 I +WIIMAIL D
 .S DIC="^WII(987.6,"
 .S DIC(0)=""
 .S X=$P($G(^WII(987.6,0)),U,3) S:X="" X=0 S X=X+1
 .S DA=X
 .D FILE^DICN
 .S DIE=DIC
 .;S DR=".01///"_WIIMAIL_";1///S.WII ADT SERVER@TEST.VISN20.DOMAIN.EXT"  ;TEST repository
 .S DR=".01///"_WIIMAIL_";1///S.WII ADT SERVER@WHITE-CITY.DOMAIN.EXT"  ;LIVE REPOSITORY
 .D ^DIE
 .Q
 K DIC,DIE,X,WIIMAIL,DA,DR,Y
 Q

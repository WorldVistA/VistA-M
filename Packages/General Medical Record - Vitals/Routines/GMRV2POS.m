GMRV2POS ;HIRMFO/FT-Clean up old DD and data nodes in 120.5
 ;;4.0;Vitals/Measurements;**2**;Apr 25, 1997
EN1 ; delete old data dictionary nodes in DD(120.505
 ; and delete any data in those fields
 S X="ALERT^GMRV2POS",@^%ZOSF("TRAP")
 S DA=.01,DIK="^DD(120.505,",GMRVFLAG=0,DA(1)=120.505
 F  S DA=$O(^DD(120.505,DA)) Q:'DA  D
 .W:'$D(ZTQUEUED) !,"Deleting ^DD(120.505,",DA
 .D ^DIK S GMRVFLAG=1
 .Q
 I GMRVFLAG=1 S DA(1)=0 F  S DA(1)=$O(^GMR(120.5,DA(1))) Q:'DA(1)  S DA=0 F  S DA=$O(^GMR(120.5,DA(1),5,DA)) Q:'DA  D
 .S GMRVNODE=$G(^GMR(120.5,DA(1),5,DA,0))
 .Q:$G(GMRVNODE)=""
 .Q:($P(GMRVNODE,U,2)=""&($P(GMRVNODE,U,3)="")&($P(GMRVNODE,U,4)=""))
 .W:'$D(ZTQUEUED) !,"Fixing ^DD(120.5,"_DA(1)_",5,"_DA_",0)"
 .S GMRVPCE1=$P(GMRVNODE,U,1)
 .S ^GMR(120.5,DA(1),5,DA,0)=GMRVPCE1
 .Q
 K DA,DIK,GMRVFLAG,GMRVNODE,GMRVPCE1,X,Y
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
QUEUE ; queue clean up to run in the background
 S ZTDTH=$$HADD^XLFDT($H,"","","",60),ZTDESC="GMRV*4*2 DD/DATA CLEAN UP"
 S ZTRTN="EN1^GMRV2POS",(ZTIO,ZTSAVE("DUZ"))=""
 D ^%ZTLOAD
 Q
ALERT ; Set up ALERT variables if clean up bombs out
 S XQA(DUZ)="",XQAMSG="GMRV*4*2 DD/DATA CLEANUP HAS ABORTED"
 D SETUP^XQALERT
 Q

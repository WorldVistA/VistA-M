ORY141 ;SLC/REV/JLI -- postinit rtn for OR*3*141 ;12/13/01  06:25 [5/21/02 2:02pm]   6/7/02 1:33PM  [11/14/02 2:39pm]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**141**;Dec 17, 1997
 ;
 Q
 ;
PRE ; -- preinit
 D PRE^ORY141ED
 Q
 ;
POST ; -- postinit
 ;
 N VER
 ;
 S VER=$P($T(VERSION^ORY141),";",3)
 I +$$PATCH^XPDUTL("TIU*1.0*112") D SURGREG
 D POST^ORY141ED
 D POST^ORY141EC
 D CLNXPAR
 D CURCLT
 D MAIL
 ;
 Q
 ;
CLNXPAR ;Clear up the value of frmOrders.hdrOrders for 
 ;parameter ORWCH COLUMNS"
 N XPID,UID,COLID,DIK
 S UID=0
 S XPID=$O(^XTV(8989.51,"B","ORWCH COLUMNS",0))
 S DIK="^XTV(8989.5,"
 F  S UID=$O(^XTV(8989.5,"AC",XPID,UID)) Q:'+UID  D
 . I $D(^XTV(8989.5,"AC",XPID,UID,"frmOrders.hdrOrders")) D
 .. S COLID=0
 .. S COLID=$O(^XTV(8989.5,"AC",XPID,UID,"frmOrders.hdrOrders",0))
 .. I COLID S DA=COLID D ^DIK
 Q
 ;
CURCLT ; Only Current Client Allowed
 D EN^XPAR("SYS","ORWOR REQUIRE CURRENT CLIENT",1,1)
 Q
 ;
SURGREG ; Register TIU SURGERY RPCs if TIU*1.0*112 present
 N MENU,RPC
 S MENU="OR CPRS GUI CHART"
 F RPC="TIU IS THIS A SURGERY?","TIU IDENTIFY SURGERY CLASS","TIU LONG LIST SURGERY TITLES" D INSERT(MENU,RPC)
 Q
 ;
INSERT(OPTION,RPC)      ; Call FM Updater with each RPC
 ; Input  -- OPTION   Option file (#19) Name field (#.01)
 ;           RPC      RPC sub-file (#19.05) RPC field (#.01)
 ; Output -- None
 N FDA,FDAIEN,ERR,DIERR
 S FDA(19,"?1,",.01)=OPTION
 S FDA(19.05,"?+2,?1,",.01)=RPC
 D UPDATE^DIE("E","FDA","FDAIEN","ERR")
 Q
 ;
MAIL ; send bulletin of installation time
 N COUNT,DIFROM,I,START,TEXT,XMDUZ,XMSUB,XMTEXT,XMY
 S COUNT=0
 S XMSUB="Version "_$P($T(VERSION),";;",2)_" Installed"
 S XMDUZ="CPRS PACKAGE"
 F I="G.CPRS GUI INSTALL@ISC-SLC.DOMAIN.EXT",DUZ S XMY(I)=""
 S XMTEXT="TEXT("
 ;
 S X=$P($T(VERSION),";;",2)
 D LINE("Version "_X_" has been installed.")
 D LINE(" ")
 D LINE("Install complete:  "_$$FMTE^XLFDT($$NOW^XLFDT()))
 ;
 D ^XMD
 Q
 ;
LINE(DATA)      ; set text into array
 S COUNT=COUNT+1
 S TEXT(COUNT)=DATA
 Q
 ;
VERSION ;;20.21

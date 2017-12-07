VIAA1P3 ;ALB/CR - POST INIT FOR PATCH 3 OF RTLS ;5/4/16 9:55am
 ;;1.0;RTLS;**3**;April 22, 2013;Build 20
 Q
POST ; Add the TABLE of remote procedure calls to common RTLS menu in VistA.
 ; Check the setup for a server and service for RTLS. If they exist,
 ; get out and pass the information to the installation log.
 ; Otherwise add the web server and service to call Mule in RTLS.
 ; 
 D BMES^XPDUTL("  POST-INIT: Starting Post-Install of Patch VIAA*1.0*3...")
 D REGRPC
 D BMES^XPDUTL("  ...Menu option 'VIAA01 RTLS RPC MENU' is now set up with new entries.")
 ;
 D BMES^XPDUTL("")
 I $D(^XOB(18.02,"B","VIAA VISTA TRIGGER SERVICE")) D BMES^XPDUTL("  ...found a trigger service, checking for a trigger server....") D POST1 Q
 E  D BMES^XPDUTL("  Adding a new web service, please wait...")
 ;
 N CONTEXT,CURRDT,DA,DIC,DLAYGO,FDA
 N SVCNAME,SERVER,PORT,SSL,STATUS,TYPE,X,Y
 S CURRDT=$$NOW^XLFDT
 S DIC(0)="L",DLAYGO=18.02,DIC="^XOB(18.02,"
 S SVCNAME="VIAA VISTA TRIGGER SERVICE",TYPE=2
 S CONTEXT="esb/assettrax/services/vistatrigger"
 S X=SVCNAME
 D FILE^DICN
 S DA=+Y
 L +^XOB(18.02,DA):5 I '$T D BMES^XPDUTL("  ...cannot lock file #18.02 - try later.") Q
 S FDA(18.02,DA_",",.02)=TYPE
 S FDA(18.02,DA_",",200)=CONTEXT
 S FDA(18.02,DA_",",.03)=CURRDT
 D UPDATE^DIE("","FDA","ERR")
 L -^XOB(18.02,DA)
 D CLEAN^DILF
 D BMES^XPDUTL("  ...new web service "_SVCNAME_" added.")
 D POST1
 Q
 ;
POST1 ;
 I $D(^XOB(18.12,"B","VIAA VISTA TRIGGER SERVER")) D BMES^XPDUTL("  ...found a trigger server - nothing else to do, quitting!") Q
 N DEFHTTPT,LOGIN,MULT,SVCPTR,SSL,SSLCFIG
 D BMES^XPDUTL("  Adding a new web server, please wait...")
 S DIC(0)="L",DLAYGO=18.12,DIC="^XOB(18.12,"
 S SERVER="VIAA VISTA TRIGGER SERVER",PORT=443
 S SVCPTR=+$O(^XOB(18.02,"B","VIAA VISTA TRIGGER SERVICE","")) ; need pointer for later use
 S STATUS=1,SSL=1,LOGIN=1,SSLCFIG="RTLS_CLIENT"
 S DEFHTTPT=30  ; default http timeout
 S X=SERVER
 D FILE^DICN
 S DA=+Y
 L +^XOB(18.12,DA):5 I '$T D BMES^XPDUTL("  ...cannot lock file #18.12 - try later.") Q
 S FDA(18.12,DA_",",.03)=PORT
 S FDA(18.12,DA_",",.06)=STATUS
 S FDA(18.12,DA_",",.07)=DEFHTTPT
 S FDA(18.12,DA_",",1.01)=LOGIN
 S FDA(18.12,DA_",",3.01)=SSL
 S FDA(18.12,DA_",",3.02)=SSLCFIG
 S FDA(18.12,DA_",",3.03)=PORT
 D UPDATE^DIE("","FDA","")
 D CLEAN^DILF
 ; add to multiple 100
 S MULT(1,18.121,"+1,"_DA_",",.01)=SVCPTR
 S MULT(1,18.121,"+1,"_DA_",",.06)=STATUS
 D UPDATE^DIE("","MULT(1)","")
 L -^XOB(18.12,DA)
 D CLEAN^DILF
 D BMES^XPDUTL("  ...new web server "_SERVER_" added.")
 D BMES^XPDUTL("  Please note: the web server just added will need a ")
 D BMES^XPDUTL("  fully qualified domain name, username, and password.")
 D BMES^XPDUTL("  The information will be available via secure communication later on.")
 D BMES^XPDUTL("  Post-Install for Patch VIAA*1.0*3 Finished.")
 Q
 ;
REGRPC ; register RPC
 N I,J,X,Y,DIC,FDA,REGRPC,RPCIEN,OPTIEN,VIAAOPT
 S VIAAOPT="VIAA01 RTLS RPC MENU"
 F I=1:1 S J=$P($E($T(TABLE+I),2,40),";;",2),REGRPC=J D ADD Q:J=""
 Q
 ;
ADD ;
 S DIC(0)="I",X=REGRPC,DIC="^XWB(8994,"
 D ^DIC Q:'(Y>0)  S RPCIEN=+Y
 D CLEAN^DILF
 ;
 S DIC(0)="I",X=VIAAOPT,DIC="^DIC(19,"
 D ^DIC Q:'(Y>0)  S OPTIEN=+Y
 D CLEAN^DILF
 S FDA(19.05,"?+1,"_OPTIEN_",",.01)=RPCIEN
 D UPDATE^DIE("","FDA","")
 Q
 ;
TABLE ; list the RPCs to be added to the menu option
 ;;VIAA ENG ASSET MOVE
 ;;VIAA ENG GET CATEGORY
 ;;VIAA ENG GET DATA
 ;;VIAA ENG GET EQUIPMENT
 ;;VIAA ENG GET LOCATION
 ;;VIAA ENG GET PRIMARY STATION

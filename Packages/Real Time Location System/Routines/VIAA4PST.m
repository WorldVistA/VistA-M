VIAA4PST ;ALB/CR - RTLS Post Init for Patch 4 ;4/25/16 1:50 pm
 ;;1.0;RTLS;**4**;April 22, 2013;Build 21
 ;
 Q
POST ; entry point for post install
 D BMES^XPDUTL("  Starting Post-Install of VIAA*1.0*4...")
 D REGRPC
 D BMES^XPDUTL("  Menu Option 'VIAA01 RTLS RPC MENU' is now populated with new entries.")
 D BMES^XPDUTL("  Post-Install for Patch VIAA*1.0*4 Finished.")
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
 ;;VIAA GET CATHLAB PATCH STATUS
 ;;VIAA GET EMPLOYEE DATA
 ;;VIAA GET INVENTORY POINT ITEMS
 ;;VIAA GET ITEM MASTER UPDATE
 ;;VIAA GET PATIENT DATA
 ;;VIAA SET PAR LEVELS IN GIP
 ;;VIAA SET QUANTITY ON HAND
 ;;

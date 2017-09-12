ORY125 ;SLC/REV -- postinit rtn for OR*3*125 ;12/13/01  06:25 [12/21/01 10:46am]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**125**;Dec 17, 1997
 ;
PRE ; -- preinit
 Q
 ;
POST ; -- postinit
 N VER
 S VER=$P($T(VERSION^ORY125),";",3)
 I +$$PATCH^XPDUTL("TIU*1.0*109") D CPREG
 D MAIL
 Q
 ;
CPREG ; Register Clinical Procedures RPCs if TIU*1.0*109 present
 N MENU,RPC
 S MENU="OR CPRS GUI CHART"
 F RPC="TIU IS THIS A CLINPROC?","TIU IDENTIFY CLINPROC CLASS","TIU LONG LIST CLINPROC TITLES" D INSERT(MENU,RPC)
 Q
 ;
INSERT(OPTION,RPC) ; Call FM Updater with each RPC
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
VERSION ;;18.2

ORY173 ;SLC/PKS -- postinit rtn for OR*3*173 ;2/11/2004  06:25 [7/1/03 2:29pm]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**173**;Dec 17, 1997
 ;
 Q
 ;
PRE ; -- preinit
 ;
 Q
 ;
POST ; -- postinit
 ;
 N VER
 ;
 S VER=$P($T(VERSION^ORY173),";",3)
 I +$$PATCH^XPDUTL("TIU*1.0*112") D SURGREG
 D SETVAL
 D MAIL
 D SUPP
 ;
 Q
 ;
SURGREG ; Register TIU SURGERY RPCs if TIU*1.0*112 present
 N MENU,RPC
 S MENU="OR CPRS GUI CHART"
 F RPC="TIU IS THIS A SURGERY?","TIU IDENTIFY SURGERY CLASS","TIU LONG LIST SURGERY TITLES","TIU GET DOCUMENTS FOR REQUEST" D INSERT(MENU,RPC)
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
SENDPAR(ANAME) ; Return true if the current parameter should be sent.
 Q 0
 ;
SETVAL ;       Set package-level values for params
 N VAL S VAL=1
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
SUPP ;Convert all dialogs with checkbox suppressed to exclude from p/n
 ;
 ;E3R 15758  NOIS MAR-1201-20845
 ;DBIA 4097
 ;
 N DIEN,FIND,SUPPRESS
 S DIEN=0
 F  S DIEN=$O(^PXRMD(801.41,DIEN)) Q:'DIEN  D
 .S FIND=0
 .;Elements and groups only
 .I "EG"'[$P($G(^PXRMD(801.41,DIEN,0)),U,4) Q
 .;Check if checkbox suppressed
 .S SUPPRESS=$P($G(^PXRMD(801.41,DIEN,0)),U,11) Q:'SUPPRESS
 .I $P($G(^PXRMD(801.41,DIEN,1)),U,5)'="" S FIND=1
 .I FIND=1 Q
 .;Set exclude from p/n
 .I $P($G(^PXRMD(801.41,DIEN,2)),U,3)="" S $P(^PXRMD(801.41,DIEN,2),U,3)=1
 Q
 ;
VERSION ;;22.11

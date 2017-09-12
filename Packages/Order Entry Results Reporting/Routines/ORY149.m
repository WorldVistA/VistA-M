ORY149 ;SLC/PKS -- postinit rtn for OR*3*149 ;12/13/01  06:25 [7/1/03 2:29pm]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**149**;Dec 17, 1997
 ;
 I '$L($T(SETDTEXT^ORWOR1)) D
 . W !,"Please install patch OR*3.0*163v11 or later before proceeding with this install",!
 . S XPDQUIT=2
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
 S VER=$P($T(VERSION^ORY149),";",3)
 I +$$PATCH^XPDUTL("TIU*1.0*112") D SURGREG
 D SETVAL
 D MAIL
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
 I ANAME="ORWOR SHOW CONSULTS" Q 1
 I ANAME="ORWOR SPELL CHECK ENABLED?" Q 1
 Q 0
 ;
SETVAL ;       Set package-level values for params
 N VAL S VAL=1
 D PUT^XPAR("PKG","ORWOR SHOW CONSULTS",1,VAL)
 D PUT^XPAR("PKG","ORWOR SPELL CHECK ENABLED?",1,VAL)
 Q
 ;
SENDRPT(ANAME) ;Return true if the current report should be sent.
 I ANAME="ORRP IMAGING" Q 1
 Q 0
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
VERSION ;;21.18

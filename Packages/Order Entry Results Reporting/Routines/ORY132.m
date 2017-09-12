ORY132 ;SLC/REV -- postinit rtn for OR*3*132 ;12/13/01  06:25 [4/29/02 4:53pm]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**132**;Dec 17, 1997
 ;
 Q
 ;
PRE ; -- preinit
 Q
 ;
POST ; -- postinit
 N VER
 S VER=$P($T(VERSION^ORY132),";",3)
 I +$$PATCH^XPDUTL("TIU*1.0*109") D CPREG
 I +$$PATCH^XPDUTL("TIU*1.0*112") D SURGREG
 D SURGRPT
 D SETVAL
 D TASKJOB
 D MAIL
 ;
 Q
 ;
TASKJOB ; Queue background task to update Order file for Alert Results field.
 ;
 N ZTRTN,ZTDESC,ZTIO,ZTSAVE,ZTDTH,ZTSK
 ;
 S ZTRTN="FIXALERT^ORY132",ZTDESC="OR*3*132 Post Install",ZTIO="",ZTSAVE("DUZ")="",ZTDTH=$H
 D ^%ZTLOAD
 I $G(ZTSK) D MES^XPDUTL("Order file update for OR*3*132 queued as task number "_ZTSK_".")
 I '$G(ZTSK) D MES^XPDUTL("Order file update task did not queue")
 ;
 Q
 ;
SETVAL ;
 N ORP,ORT
 S ORP="ORWRP REPORT LIST",ORT=$O(^ORD(101.24,"B","ORRPW DOD",0))
 I ORT D PUT^XPAR("PKG",ORP,8,ORT)
 Q
CPREG ; Register TIU Clinical Procedures RPCs if TIU*1.0*109 present
 N MENU,RPC
 S MENU="OR CPRS GUI CHART"
 F RPC="TIU IS THIS A CLINPROC?","TIU IDENTIFY CLINPROC CLASS","TIU LONG LIST CLINPROC TITLES" D INSERT(MENU,RPC)
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
SURGRPT ; Add Surgery report to Reports tab
 N ORSURG,ORI,ORP,ORT,ORS,ORLST,ORERR,FOUND
 S ORP="ORWRP REPORT LIST",ORT=$O(^ORD(101.24,"B","ORRP SURGERIES",0))
 S ORSURG=$O(^ORD(101.24,"B","ORRP SURGERIES",0)),ORI=0,FOUND=0
 D GETLST^XPAR(.ORLST,"PKG","ORWRP REPORT LIST","Q",.ORERR)
 F  S ORI=$O(ORLST(ORI)) Q:+ORI=0!(FOUND)  D
 . I $P(ORLST(ORI),U,2)=ORSURG S FOUND=1
 Q:+FOUND
 S ORS=+ORLST(ORLST)+5
 D PUT^XPAR("PKG",ORP,ORS,ORT)
 Q
 ;
FIXALERT ; convert "1" in ALERT ON RESULTS field to Ordering Provider
 N ORX,ORDUZ,ORTEXT
 S ORX=0 F  S ORX=$O(^OR(100,ORX)) Q:+$G(ORX)<1  D
 .I $P($G(^OR(100,ORX,3)),U,10)=1 D
 ..S ORDUZ=$$ORDERER^ORQOR2(ORX)
 ..I +$G(ORDUZ)>1 S $P(^OR(100,ORX,3),U,10)=+$G(ORDUZ)
 S TEXT(1)="Background task for OR*3*132 has completed."
 ;
 ; Send message to user, postmaster:
 N XMSUB,XMTEXT,SMDUZ,SMY
 S XMSUB="Patch OR*3*132 Tasked Post-Install Complete"  ; Msg subject.
 S XMDUZ="Patch OR*3*132 Tasked Post Install"           ; Message "from."
 S XMY(.5)="" S:$G(DUZ) XMY(DUZ)=""              ; To user,postmaster.
 S XMTEXT="TEXT("
 D ^XMD
 ;
 Q
 ;
SENDPAR(ANAME) ; Return true if the current parameter should be sent
 I ANAME="ORCH INITIAL TAB" Q 1
 I ANAME="ORWOR SHOW SURGERY TAB" Q 1
 I ANAME="ORWOR PKI USE" Q 1
 Q 0
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
VERSION ;;19.7

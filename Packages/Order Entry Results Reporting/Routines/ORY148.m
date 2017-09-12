ORY148 ;SLC/PKS -- postinit rtn for OR*3*148 ;6/21/02  12:04 [7/23/02 2:15pm]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**148**;Dec 17, 1997
 ;
 Q
 ;
PRE ; -- preinit
 ;
 Q
 ;
POST ; -- postinit
 ;
 N VER,ORCOUNT
 ;
 S VER=$P($T(VERSION^ORY148),";",3)
 D USERSET
 D PAROUT
 I +$$PATCH^XPDUTL("TIU*1.0*109") D CPREG
 I +$$PATCH^XPDUTL("TIU*1.0*112") D SURGREG
 D MAIL
 ;
 Q
 ;
USERSET ; Queue background task to set user default settings.
 ;
 N ZTRTN,ZTDESC,ZTIO,ZTSAVE,ZTDTH,ZTSK
 ;
 S ZTRTN="DQSET^ORY148",ZTDESC="OR*3*148 Post Install",ZTIO="",ZTSAVE("DUZ")="",ZTDTH=$H
 D ^%ZTLOAD
 I $G(ZTSK) D MES^XPDUTL("User defaults for OR*3*148 queued as task number "_ZTSK_".")
 I '$G(ZTSK) D MES^XPDUTL("User defaults task did not queue")
 ;
 Q
 ;
DQSET ; Queue background task to set user default settings.
 ;
 S ORCOUNT=0
 S ^TMP("ORY148",$J,1)="Background task for OR*3*148 has completed."
 S ^TMP("ORY148",$J,2)=" "
 S ^TMP("ORY148",$J,3)="The following problems were encountered:"
 S ^TMP("ORY148",$J,4)=" "
 S ORCOUNT=4
 ;
 ; Set user default settings:
 D DEFTABS
 I ORCOUNT=4 S ^TMP("ORY148",$J,5)="No problems encountered."
 ;
 ; Send message with results to user, postmaster:
 N XMSUB,XMTEXT,SMDUZ,SMY
 S XMSUB="Patch OR*3*148 Post-Install Complete"  ; Message subject.
 S XMDUZ="Patch OR*3*148 Post Install"           ; Message "from."
 S XMY(.5)="" S:$G(DUZ) XMY(DUZ)=""              ; To user,postmaster.
 S XMTEXT="^TMP(""ORY148"",$J,"                  ; Text for message.
 D ^XMD
 K ^TMP("ORY148",$J)
 ;
 Q
 ;
DEFTABS ; Default tab, restricted patient list entries for GUI users.
 ;
 N ORZ,ORZZ,OROPT,ORUSER,DIE
 ;
 S OROPT="OR CPRS GUI CHART"
 S OROPT=$$OPTLK^XQCS(OROPT)
 S OROPT=+OROPT
 I OROPT<1  D  Q
 .W !,"No OR CPRS GUI CHART Option found!"
 ;
 ; Establish loop to order through users:
 S ORUSER=0
 F  S ORUSER=$O(^VA(200,ORUSER)) Q:'ORUSER>0  D
 .S ORZ=0
 .S ORZ=$$ACCESS^XQCHK(ORUSER,OROPT) ; Have OR CPRS GUI CHART option?
 .S ORZ=+ORZ
 .S ORZZ=$G(^VA(200,ORUSER,0))
 .S ORZZ=$P(ORZZ,U,4)
 .I ((ORZ>0)!(ORZZ["@"))  D
 ..;
 ..; Set default of "COR" for CPRS tabs multiple:
 ..N ORFDA,ORIEN,ORERR
 ..S ORIEN(1)=ORUSER
 ..S ORFDA(200.010113,"+2,"_ORUSER_",",.01)=1
 ..S ORFDA(200.010113,"+2,"_ORUSER_",",.02)=DT
 ..I ('$D(^VA(200,ORUSER,"ORD",0))) D UPDATE^DIE("","ORFDA","ORIEN","ORERR")
 ..I $D(ORERR)  D
 ...;
 ...; Send installation error message to run under Taskman:
 ...S ORCOUNT=ORCOUNT+1
 ...S ^TMP("ORY148",$J,ORCOUNT)="Could not create default COR Tab entry for user "_ORUSER_"."
 ..;
 ..; Set default of "N" for restricted patient list field:
 ..N ORFDA,ORIEN,ORERR
 ..S ORIEN(1)=ORUSER
 ..S ORFDA(200,ORUSER_",",101.01)=0
 ..I ('$D(^VA(200,ORUSER,101))) D UPDATE^DIE("","ORFDA","ORIEN","ORERR")
 ..I $D(ORERR)  D
 ...;
 ...; Send installation error message to run under Taskman:
 ...S ORCOUNT=ORCOUNT+1
 ...S ^TMP("ORY148",$J,ORCOUNT)="Could not make RPL default NO entry for user "_ORUSER_"."
 ..;
 ..D CLEAN^DILF ; Clean up after DB call.
 ;
 Q
 ;
CPREG ; Register TIU Clinical Procedures RPCs if TIU*1.0*109 present
 N MENU,RPC
 S MENU="OR CPRS GUI CHART"
 F RPC="TIU IS THIS A CLINPROC?","TIU IDENTIFY CLINPROC CLASS","TIU LONG LIST CLINPROC TITLES"  D INSERT(MENU,RPC)
 Q
 ;
SURGREG ; Register TIU SURGERY RPCs if TIU*1.0*112 present
 N MENU,RPC
 S MENU="OR CPRS GUI CHART"
 F RPC="TIU IS THIS A SURGERY?","TIU IDENTIFY SURGERY CLASS","TIU LONG LIST SURGERY TITLES" D INSERT(MENU,RPC)
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
PAROUT ; Remove entries, parameter "ORWT TOOLS RPT SETTINGS OFF" if found.
 ;
 ; Remove all instances of parameter:
 N DA,DIK,PAR,ENT,INST,DIRUT,DUOUT,DTOUT,ORIEN
 S PAR="ORWT TOOLS RPT SETTINGS OFF"
 ;
 S ORIEN=0
 S ORIEN=$O(^XTV(8989.51,"B",PAR,ORIEN))
 S ORIEN=+ORIEN
 I 'ORIEN Q
 ;
 S ENT=0
 F  S ENT=$O(^XTV(8989.5,"AC",ORIEN,ENT)) Q:'ENT  D
 .S INST=0
 .F  S INST=$O(^XTV(8989.5,"AC",ORIEN,ENT,INST)) Q:INST=""  D  Q
 ..D DEL^XPAR(ENT,ORIEN,INST)
 ;
 ; Remove parameter definition itself:
 S DIK="^XTV(8989.51,"
 S DA=ORIEN
 D ^DIK
 ;
 Q
 ;
LINE(DATA)      ; set text into array
 S COUNT=COUNT+1
 S TEXT(COUNT)=DATA
 Q
 ;
VERSION ;;19.15

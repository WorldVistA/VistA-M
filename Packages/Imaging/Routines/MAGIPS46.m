MAGIPS46 ;Post init routine to queue site activity at install. ; 09 May 2006  12:43 PM
 ;;3.0;IMAGING;**46**;16-February-2007;;Build 1023
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
 ;
PRE ;
 D  ; save filters to guard against deletion during installation
 . N FMDTNOW ; -- current date/time in Fileman format
 . N FMDTPRG ; -- date & time to purge (1 day from now)
 . N XTMP0 ; ---- header node of temporary save location - for purge
 . ;
 . U IO(0) W !,"Saving image filters..."
 . L +^XTMP("MAGIPS46"):1E9 K ^XTMP("MAGIPS46")
 . S FMDTNOW=$$NOW^XLFDT
 . S FMDTPRG=$$FMADD^XLFDT(FMDTNOW,1,0,0,0)
 . S ^XTMP("MAGIPS46",0)=FMDTPRG_"^"_FMDTNOW_"^MAG*3.0*46 FILTER SAVE"
 . M ^XTMP("MAGIPS46",1)=^MAG(2006.57)
 . L -^XTMP("MAGIPS46")
 . U IO(0) W "saved.",!
 . Q
 Q
POST ;
 ;
 D  ; restore filters
 . U IO(0) W !,"Restoring filters..."
 . L +^MAG(2006.57):1E9
 . M ^MAG(2006.57)=^XTMP("MAGIPS46",1)
 . L -^MAG(2006.57)
 . U IO(0) W "restored."
 . Q
 ;
 D DEFAULTS
 D XREF
 ;
 D REMTASK^MAGQE4
 D STTASK^MAGQE4
 ;
 D ADDRPC("MAG DICOM CON UNREADLIST LOCK","MAG WINDOWS")
 D ADDRPC("MAG DICOM CON UNREADLIST GET","MAG WINDOWS")
 D ADDRPC("MAG DICOM CON UNREAD ACQ SITES","MAG WINDOWS")
 D ADDRPC("MAG DICOM CON GET TELE READER","MAG WINDOWS")
 D ADDRPC("MAG DICOM CON SET TELE READER","MAG WINDOWS")
 ;
 D ADDRPC("MAG DICOM CON UNREADLIST LOCK","MAG DICOM GATEWAY FULL")
 D ADDRPC("MAG DICOM CON UNREADLIST GET","MAG DICOM GATEWAY FULL")
 D ADDRPC("MAG DICOM CON UNREAD ACQ SITES","MAG DICOM GATEWAY FULL")
 D ADDRPC("MAG DICOM CON GET TELE READER","MAG DICOM GATEWAY FULL")
 D ADDRPC("MAG DICOM CON SET TELE READER","MAG DICOM GATEWAY FULL")
 ;
 D ADDRPC("MAG DICOM CON UNREADLIST LOCK","MAG DICOM GATEWAY VIEW")
 D ADDRPC("MAG DICOM CON UNREADLIST GET","MAG DICOM GATEWAY VIEW")
 D ADDRPC("MAG DICOM CON UNREAD ACQ SITES","MAG DICOM GATEWAY VIEW")
 D ADDRPC("MAG DICOM CON GET TELE READER","MAG DICOM GATEWAY VIEW")
 D ADDRPC("MAG DICOM CON SET TELE READER","MAG DICOM GATEWAY VIEW")
 ;
 D  ;  Confirmation message
 . ;
 . NEW %,CT,CNT,D,D0,D1,D2,DDATE,DG,DIC,DICR,DIW,MAGMSG,ST,X,XMID,XMSUB,XMY,XMZ,Y
 . ;
 . D GETENV^%ZOSV
 . S CNT=0
 . S CNT=CNT+1,MAGMSG(CNT)="PACKAGE INSTALL"
 . S CNT=CNT+1,MAGMSG(CNT)="SITE: "_$$KSP^XUPARAM("WHERE")
 . S CNT=CNT+1,MAGMSG(CNT)="PACKAGE: "_XPDNM
 . S CNT=CNT+1,MAGMSG(CNT)="Version: "_$$VER^XPDUTL(XPDNM)
 . S ST=$$GET1^DIQ(9.7,XPDA,11,"I")
 . S CNT=CNT+1,MAGMSG(CNT)="Start time: "_$$FMTE^XLFDT(ST)
 . S CT=$$GET1^DIQ(9.7,XPDA,17,"I") S:+CT'=CT CT=$$NOW^XLFDT()
 . S CNT=CNT+1,MAGMSG(CNT)="Completion time: "_$$FMTE^XLFDT(CT)
 . S CNT=CNT+1,MAGMSG(CNT)="Run time: "_$$FMDIFF^XLFDT(CT,ST,3)
 . S CNT=CNT+1,MAGMSG(CNT)="Environment: "_Y
 . S CNT=CNT+1,MAGMSG(CNT)="FILE COMMENT: "_$$GET1^DIQ(9.7,XPDA,6,"I")
 . S CNT=CNT+1,MAGMSG(CNT)="DATE: "_$$NOW^XLFDT()
 . S CNT=CNT+1,MAGMSG(CNT)="Installed by: "_$$GET1^DIQ(9.7,XPDA,9,"E")
 . S CNT=CNT+1,MAGMSG(CNT)="Install Name: "_$$GET1^DIQ(9.7,XPDA,.01,"E")
 . S DDATE=$$GET1^DIQ(9.7,XPDA,51,"I")
 . S CNT=CNT+1,MAGMSG(CNT)="Distribution Date: "_$$FMTE^XLFDT(DDATE)
 . S:$G(CVT)'="" CNT=CNT+1,MAGMSG(CNT)="Conversion time: "_CVT
 . S XMSUB=XPDNM_" INSTALLATION"
 . S XMID=$G(DUZ) S:'XMID XMID=.5
 . S XMY(XMID)=""
 . S XMY("G.MAG SERVER")=""
 . S:$G(MAGDUZ) XMY(MAGDUZ)=""
 . S XMSUB=$E(XMSUB,1,63)
 . D SENDMSG^XMXAPI(XMID,XMSUB,"MAGMSG",.XMY,,.XMZ,)
 . I $G(XMERR) M XMERR=^TMP("XMERR",$J) S $EC=",U13-Cannot send MailMan message,"
 . Q
 Q
ADDRPC(RPCNAME,OPTNAME) ;
 ;
 NEW DA,DIC,I,X,Y
 ;
 S DIC="^DIC(19,",DIC(0)="",X=OPTNAME D ^DIC
 I Y<0 D  Q
 . W !,"Cannot add """_RPCNAME_""" to """_OPTNAME_"""."
 . W !,"Cannot find """_OPTNAME_"""."
 . Q
 S DA(1)=+Y
 S DIC=DIC_DA(1)_",""RPC"","
 S DIC(0)="L" ; LAYGO should be allowed here
 S X=RPCNAME
 D ^DIC
 I Y<0 D  Q
 . W !,"Cannot add """_RPCNAME_""" to """_OPTNAME_"""."
 . W !,"Cannot find """_RPCNAME_"""."
 . Q
 Q
DEFAULTS ;  Set default for location of TeleReader Timeout.
 ;
 NEW %,%H,D,D0,DA,DI,DIC,DIE,DQ,DR,X
 ;
 S X=0
 F  S X=$O(^MAG(2006.1,X)) Q:'+X  S DA=X,DIE="^MAG(2006.1,",DR="131///180" D ^DIE
 Q
XREF ;  Kill then Reset ALL xrefs for ALL entries.
 ;
 NEW DA,DIC,DIK,X
 ;
 Q:'$O(^MAG(2006.5849,0))
 ;
 S DIK="^MAG(2006.5849," D IXALL2^DIK  ;  KILL
 S DIK="^MAG(2006.5849," D IXALL^DIK   ;  SET
 Q

MAGIPS66 ;Post init routine to queue site activity at install. ; 04 Apr 2008 2:27 PM
 ;;3.0;IMAGING;**66**;Mar 19, 2002;Build 1836;Sep 02, 2010
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
PRE ;
 ; Kill File 2006.87 if it happens to exist.  This will only be the
 ; case at P66 test sites.
 N DIU
 S DIU="^MAG(2006.87,",DIU(0)="D" D EN^DIU2
 Q
 ;
POST ;
 N CT,CNT,D,D0,D1,D2,DDATE,DG,DIC,DICR,DIW,MAGMSG,OPT,ST,XMID,XMY
 ; 1. Add RPCs to secondary menus
 ; 2. Initialize DICOM root
 ; 3. Send confirmation message
 ;
 F OPT="MAG DICOM GATEWAY FULL","MAG DICOM GATEWAY VIEW","MAG DICOM QUERY RETRIEVE" D
 . D ADDRPC("MAG DICOM CHECK AE TITLE",OPT)
 . D ADDRPC("MAG DICOM VISTA AE TITLE",OPT)
 . D ADDRPC("MAG DICOM GET GATEWAY INFO",OPT)
 . D ADDRPC("MAG DICOM STORE GATEWAY INFO",OPT)
 . D ADDRPC("MAG CFIND QUERY",OPT)
 . D ADDRPC("MAG STUDY UID QUERY",OPT)
 . D ADDRPC("MAG IMAGE CURRENT INFO",OPT)
 . D ADDRPC("XUS INTRO MSG",OPT)
 . Q
 ;
 D INIT^MAGDRUID
 ;
 D GETENV^%ZOSV
 S CNT=0
 S CNT=CNT+1,MAGMSG(CNT)="PACKAGE INSTALL"
 S CNT=CNT+1,MAGMSG(CNT)="SITE: "_$$KSP^XUPARAM("WHERE")
 S CNT=CNT+1,MAGMSG(CNT)="PACKAGE: "_XPDNM
 S CNT=CNT+1,MAGMSG(CNT)="Version: "_$$VER^XPDUTL(XPDNM)
 S ST=$$GET1^DIQ(9.7,XPDA,11,"I")
 S CNT=CNT+1,MAGMSG(CNT)="Start time: "_$$FMTE^XLFDT(ST)
 S CT=$$GET1^DIQ(9.7,XPDA,17,"I") S:+CT'=CT CT=$$NOW^XLFDT()
 S CNT=CNT+1,MAGMSG(CNT)="Completion time: "_$$FMTE^XLFDT(CT)
 S CNT=CNT+1,MAGMSG(CNT)="Run time: "_$$FMDIFF^XLFDT(CT,ST,3)
 S CNT=CNT+1,MAGMSG(CNT)="Environment: "_Y
 S CNT=CNT+1,MAGMSG(CNT)="FILE COMMENT: "_$$GET1^DIQ(9.7,XPDA,6,"I")
 S CNT=CNT+1,MAGMSG(CNT)="DATE: "_$$NOW^XLFDT()
 S CNT=CNT+1,MAGMSG(CNT)="Installed by: "_$$GET1^DIQ(9.7,XPDA,9,"E")
 S CNT=CNT+1,MAGMSG(CNT)="Install Name: "_$$GET1^DIQ(9.7,XPDA,.01,"E")
 S DDATE=$$GET1^DIQ(9.7,XPDA,51,"I")
 S CNT=CNT+1,MAGMSG(CNT)="Distribution Date: "_$$FMTE^XLFDT(DDATE)
 S XMSUB=XPDNM_" INSTALLATION"
 S XMID=$G(DUZ) S:'XMID XMID=.5
 S XMY(XMID)=""
 S XMY("G.MAG SERVER")=""
 S:$G(MAGDUZ) XMY(MAGDUZ)=""
 S XMSUB=$E(XMSUB,1,63)
 D SENDMSG^XMXAPI(XMID,XMSUB,"MAGMSG",.XMY,,.XMZ,)
 I $G(XMERR) M XMERR=^TMP("XMERR",$J) S $EC=",U13-Cannot send MailMan message,"
 Q
 ;
ADDRPC(RPCNAME,OPTNAME) N DA,DIC
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
 ;

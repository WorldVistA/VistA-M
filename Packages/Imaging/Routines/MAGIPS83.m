MAGIPS83 ;WOIFO/EdM,MLH - Post init routine to queue site activity at install. ; 11 Jan 2010 8:41 AM
 ;;3.0;IMAGING;**83**;Mar 19, 2002;Build 1690;Mar 29, 2010
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
 ;
POST ;
 ;  1. Add RPCs to Secondary menu(s)
 ; last. Send confirmation message
 ;
 F OPT="MAG WINDOWS","MAG DICOM GATEWAY FULL","MAG DICOM GATEWAY VIEW" D
 . D ADDRPC("MAG NEW SOP INSTANCE UID",OPT)
 . D ADDRPC("MAG DICOM CHECK AE TITLE",OPT)
 . D ADDRPC("MAG DICOM GET GATEWAY INFO",OPT)
 . D ADDRPC("MAG DICOM STORE GATEWAY INFO",OPT)
 . D ADDRPC("MAG DICOM VISTA AE TITLE",OPT)
 . D ADDRPC("MAG DOD GET STUDIES IEN",OPT)
 . D ADDRPC("MAG DOD GET STUDIES UID",OPT)
 . D ADDRPC("MAG GET NETLOC",OPT)
 . D ADDRPC("MAG IMAGE CURRENT INFO",OPT)
 . D ADDRPC("MAG SCAN IMAGE TEXT FILES",OPT)
 . D ADDRPC("MAG STORE TEXT FILE DETAILS",OPT)
 . Q
 ;
 F OPT="MAGJ VISTARAD WINDOWS" D
 . D ADDRPC("MAG IMAGE CURRENT INFO",OPT)
 . D ADDRPC("MAG NEW SOP INSTANCE UID",OPT)
 . Q
 ;
 D ADDRPC("MAGGUSER2","MAG DICOM GATEWAY FULL")
 D ADDRPC("MAGG LOGOFF","MAG DICOM GATEWAY FULL")
 ;
 ; Send confirmation message
 ;
 D  ; Confirmation message
 . N CT,CNT,D,D0,D1,D2,DDATE,DG,DIC,DICR,DIW,MAGMSG,ST,XMID,XMY
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

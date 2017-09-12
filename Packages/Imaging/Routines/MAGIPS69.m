MAGIPS69 ;Post init routine to queue site activity at install. ; 01/06/2006  08:21
 ;;3.0;IMAGING;**69**;01-August-2007;;Build 1141
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
POST ;
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

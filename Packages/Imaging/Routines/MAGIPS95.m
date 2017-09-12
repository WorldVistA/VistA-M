MAGIPS95 ;Post init routine to queue site activity at install ; 16 Feb 2004  2:41 PM
 ;;3.0;IMAGING;**95**;August 7, 2008;Build 12
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
POST ;
 ; create and send the site installation message
 D VERCHKON ; Turn on Version Checking
 D REMTASK^MAGQE4
 D STTASK^MAGQE4
 D INS(XPDNM,DUZ,$$NOW^XLFDT,XPDA)
 Q
VERCHKON ; Turn on Version Checking at the Sites.
 ; We aren't forcing it to stay on, sites can turn it back off.
 N MAGIEN,MAGSITE,VERCHK,MSG
 S MAGIEN=0
 F  S MAGIEN=$O(^MAG(2006.1,MAGIEN)) Q:'MAGIEN  D
 . S MSG="is already ON, no action taken"
 . S MAGSITE=$P($G(^MAG(2006.1,MAGIEN,0)),"^",1)
 . S VERCHK=$P($G(^MAG(2006.1,MAGIEN,"KEYS")),"^",5)
 . I 'VERCHK S $P(^MAG(2006.1,MAGIEN,"KEYS"),"^",5)=1 S MSG="has been turned ON"
 . D MES^XPDUTL("Patch 95 is turning Version Checking ON...")
 . D MES^XPDUTL("Version Checking "_MSG_" for Site: "_MAGSITE)
 Q
INS(XP,DUZ,DATE,IDA) ;
 N CT,CNT,COM,D,D0,D1,D2,DDATE,DG,DIC,DICR,DIW,MAGMSG,ST,XMID,XMY
 D GETENV^%ZOSV
 S CNT=0
 S CNT=CNT+1,MAGMSG(CNT)="PACKAGE INSTALL"
 S CNT=CNT+1,MAGMSG(CNT)="SITE: "_$$KSP^XUPARAM("WHERE")
 S CNT=CNT+1,MAGMSG(CNT)="PACKAGE: "_XP
 S CNT=CNT+1,MAGMSG(CNT)="Version: "_$$VER^XPDUTL(XP)
 S ST=$$GET1^DIQ(9.7,IDA,11,"I")
 S CNT=CNT+1,MAGMSG(CNT)="Start time: "_$$FMTE^XLFDT(ST)
 S CT=$$GET1^DIQ(9.7,IDA,17,"I") S:+CT'=CT CT=$$NOW^XLFDT
 S CNT=CNT+1,MAGMSG(CNT)="Completion time: "_$$FMTE^XLFDT(CT)
 S CNT=CNT+1,MAGMSG(CNT)="Run time: "_$$FMDIFF^XLFDT(CT,ST,3)
 S CNT=CNT+1,MAGMSG(CNT)="Environment: "_Y
 S COM=$$GET1^DIQ(9.7,IDA,6,"I")
 S CNT=CNT+1,MAGMSG(CNT)="FILE COMMENT: "_COM
 S CNT=CNT+1,MAGMSG(CNT)="DATE: "_DATE
 S CNT=CNT+1,MAGMSG(CNT)="Installed by: "_$$GET1^DIQ(9.7,IDA,9,"E")
 S CNT=CNT+1,MAGMSG(CNT)="Install Name: "_$$GET1^DIQ(9.7,IDA,.01,"E")
 S DDATE=$$GET1^DIQ(9.7,IDA,51,"I")
 S CNT=CNT+1,MAGMSG(CNT)="Distribution Date: "_$$FMTE^XLFDT(DDATE)
 S XMSUB=XP_" INSTALLATION"
 S XMID=$G(DUZ) S:'XMID XMID=.5
 S XMY(XMID)=""
 S XMY("G.MAG SERVER")=""
 S:$G(MAGDUZ) XMY(MAGDUZ)=""
 S XMSUB=$E(XMSUB,1,63)
 D SENDMSG^XMXAPI(XMID,XMSUB,"MAGMSG",.XMY,,.XMZ,)
 I $G(XMERR) M XMERR=^TMP("XMERR",$J) S $EC=",U13-Cannot send MailMan message,"
 Q
MAGIPS77 ;WOIFO/MJK; P77 (Reports) Pre and Post Init ; 06 Jun 2006  7:50 AM
 ;;3.0;IMAGING;**77**;07-December-2006;;Build 982
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
POST ;
 ;
 ;  Create a Date cross reference from the 'Date/Time Image Saved' field #7
 ;
 D INDEX,MAIL
 D REMTASK^MAGQE4
 D STTASK^MAGQE4
 Q
INDEX ;  Index the Image Saved Date/Time in the 2005 and 2005.1 file
 ;
 NEW DATE,DATETIME,I,IMGFILE,IMGIEN
 ;
 F IMGFILE=2005,2005.1 D
 . ;
 . K ^MAG(IMGFILE,"AD")
 . ;
 . U IO(0) W !!,IMGFILE
 . ;
 . S IMGIEN=0
 . F I=1:1 S IMGIEN=$O(^MAG(IMGFILE,IMGIEN)) Q:'IMGIEN  D
 . . I I#1000=0 U IO(0) W "."
 . . S DATETIME=$P($G(^MAG(IMGFILE,IMGIEN,2)),"^")
 . . Q:DATETIME=""
 . . S DATE=$P(DATETIME,".")
 . . Q:DATE=""
 . . S ^MAG(IMGFILE,"AD",DATE,IMGIEN)=""
 . . Q
 . Q
 Q
MAIL ;  Send a mail message about the Patch
 ;
 NEW %,CT,CNT,D,D0,D1,D2,DDATE,DG,DIC,DICR,DIW,MAGDUZ,MAGMSG,ST,X,XMERR,XMID,XMSUB,XMY,XMZ,Y
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
 S:$G(CVT)'="" CNT=CNT+1,MAGMSG(CNT)="Conversion time: "_CVT
 S XMSUB=XPDNM_" INSTALLATION"
 S XMID=$G(DUZ) S:'XMID XMID=.5
 S XMY(XMID)=""
 S XMY("G.MAG SERVER")=""
 S:$G(MAGDUZ) XMY(MAGDUZ)=""
 S XMSUB=$E(XMSUB,1,63)
 D SENDMSG^XMXAPI(XMID,XMSUB,"MAGMSG",.XMY,,.XMZ,)
 I $G(XMERR) M XMERR=^TMP("XMERR",$J) S $EC=",U13-Cannot send MailMan message,"
 Q

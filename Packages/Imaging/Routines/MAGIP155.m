MAGIP155 ;WOIFO/JSL - MAG INDEX TERMS UPDATE Utilities for Imaging 3.0; 09/15/2014 10:15
 ;;3.0;IMAGING;**155**;;Build 16
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
PRE ;PRECHECK
 D GETENV^%ZOSV,KILL^XM ;Clean up
 N DIR,SUB,TKID,X,Y
 U IO(0) S DIR("A")="Update Imaging Index Terms with the latest Distribution (Y/N)",DIR("B")="Y",DIR(0)="Y"
 D ^DIR I '$G(Y) S XPDABORT=1 Q  ;User selected not to update
 S SUB="MAG INDEX TERMS UPDATE" K ^TMP(SUB,$J)
 S X="ERR^MAGIP144",@^%ZOSF("TRAP")
 S TKID=$H*86400+$P($H,",",2) D MAKEBKUP(TKID)  ;backup before loading M global
 U IO(0) W !,"Restore Code: "_TKID,!
 S ^TMP(SUB,$J,"TKID")=TKID
 Q
MAKEBKUP(TKID) ;make last known backup
 N IN,SUBJ,X,X0,X1
 S SUBJ="MAG INDEX TERMS BACKUP" U IO(0) W !,"backup"
 F IN=2005.82,2005.83,2005.84,2005.85 M ^XTMP(SUBJ,TKID,IN)=^MAG(IN) U IO(0) W "*"
 S X0=$$NOW^XLFDT()\1,X=$$FMADD^XLFDT(X0,180),^XTMP(SUBJ,0)=X_U_X0_U_SUBJ  ;keep 180 days
 U IO(0) W ! M ^TMP(SUB,$J,0)=^XTMP(SUBJ,TKID)
 Q
 ;
 ;;
POST ;POSTINSTALL
POS ;
 N CT,CNT,COM,D,D0,D1,D2,DG,DIC,DICR,DIR,DIW,IN,MAGMSG,ST,SUB,TKID,XMID,XMY,XMZ,XMSUB,XMERR,Y
 S SUB="MAG INDEX TERMS UPDATE" D CHKSTA ;Status active
 S TKID=$G(^TMP(SUB,$J,"TKID"))
 I $$ISIHS^MAGSPID() D  ;IHS has different terms
 . F IN=105,106,107,110 S:$D(^MAG(2005.83,IN,0)) $P(^(0),"^",3)="A"
 . ;IHS active  MARRIAGE LICENSE, BIRTH CERTIFICATE, CERTIFICATE OF INDIAN BLOOD, CCD-SUMMARY
 . F IN=7,46,47,48,49,51,53,57,70,86,87,88,95,98,102,104,108 S:$D(^MAG(2005.83,IN,0)) $P(^(0),"^",3)="I"
 . S ^MAG(2005.85,3,1,0)="^2005.852P^6^6",^MAG(2005.85,3,1,1,0)=2  ;EKG has more specialty
 . S ^MAG(2005.85,3,1,2,0)=39,^MAG(2005.85,3,1,3,0)=1
 . S ^MAG(2005.85,3,1,4,0)=87,^MAG(2005.85,3,1,5,0)=42
 . S ^MAG(2005.85,3,1,6,0)=52,^MAG(2005.85,3,1,"B",1,3)=""
 . S ^MAG(2005.85,3,1,"B",2,1)="",^MAG(2005.85,3,1,"B",39,2)=""
 . S ^MAG(2005.85,3,1,"B",42,5)="",^MAG(2005.85,3,1,"B",52,6)=""
 . S ^MAG(2005.85,3,1,"B",87,4)=""
 . S ^MAG(2005.85,210,0)="STATE AUTHORIZED PORTABLE ORDERS^7^I"  ;IHS has inactive SAPO
 . Q
 E  D  ;Send VA site feedback
 . D GETENV^%ZOSV
 . S CNT=1,MAGMSG(CNT)="MAG INDEX TERMS Update is completed"
 . S CNT=CNT+1,MAGMSG(CNT)="SITE: "_$$KSP^XUPARAM("WHERE")
 . S CNT=CNT+1,MAGMSG(CNT)="PACKAGE: "_$G(XPDNM,"MAG*3.0*144")
 . S CT=$$NOW^XLFDT  ;Current Time stamp
 . S CNT=CNT+1,MAGMSG(CNT)="Completion time: "_$$FMTE^XLFDT(CT)
 . S CNT=CNT+1,MAGMSG(CNT)="Environment: "_Y
 . S CNT=CNT+1,MAGMSG(CNT)="Restore Code: "_TKID
 . S CNT=CNT+1,MAGMSG(CNT)="Installed by: "_$$GET1^DIQ(200,DUZ,.01,"E")
 . S XMSUB="MAG INDEX TERMS UPDATE INSTALLATION"
 . S XMID=+$G(DUZ),XMY(XMID)=""
 . S XMY("G.MAG SERVER")=""
 . S:$G(MAGDUZ) XMY(MAGDUZ)=""
 . S XMSUB=$E(XMSUB,1,63)
 . D SENDMSG^XMXAPI(XMID,XMSUB,"MAGMSG",.XMY,,.XMZ,)
 . I $G(XMERR) M XMERR=^TMP("XMERR",$J) S $EC=",U13-Cannot send MailMan message,"
 . Q
 ;
 D BMES^XPDUTL("Post Install Mail Message: "_$$FMTE^XLFDT($$NOW^XLFDT))
 D INS^MAGQBUT4(XPDNM,DUZ,$$NOW^XLFDT,XPDA)
 K ^TMP(SUB,$J)
 Q
 ;
ERR ;error handler
 Q:'$G(DUZ)
 I $G(TKID) I $D(^XTMP("MAG INDEX TERMS BACKUP",TKID)) D RECOVER
 S XPDABORT=1
 D @^%ZOSF("ERRTN")
 Q
 ;
CHKSTA ;verify current site status w/ National
 N IN,IEN,STA,STO S IEN=0  ;only 2 terms can inactive by local site
 S IN=2005.84 F  S IEN=$O(^TMP(SUB,$J,0,IN,IEN)) Q:'IEN  D
 . S STO=$P(^TMP(SUB,$J,0,IN,IEN,0),U,4),STA=$P($G(^MAG(IN,IEN,0)),U,4)
 . I STA="I" Q  ;Apply inactive by VA national
 . I STO="I" S $P(^MAG(IN,IEN,0),U,4)=STO Q  ;keep site Option
 . Q
 S IN=2005.85 F  S IEN=$O(^TMP(SUB,$J,0,IN,IEN)) Q:'IEN  D
 . S STO=$P(^TMP(SUB,$J,0,IN,IEN,0),U,3),STA=$P($G(^MAG(IN,IEN,0)),U,3)
 . I STA="I" Q  ;Apply inactive by VA national
 . I STO="I" S $P(^MAG(IN,IEN,0),U,3)=STO Q  ;keep site Option
 . Q
 Q
 ;
RECOVER ;Call restore old value, in case of error
 Q:$G(TKID)=""
 N IN
 F IN=2005.82,2005.83,2005.84,2005.85 D  U IO(0) W ^MAG(IN,0),!
 . I $D(^MAG(IN))&$D(^XTMP("MAG INDEX TERMS BACKUP",TKID,IN)) D
 . . K ^MAG(IN) M ^MAG(IN)=^XTMP("MAG INDEX TERMS BACKUP",TKID,IN) ;recoverd
 . Q
 Q
 ;

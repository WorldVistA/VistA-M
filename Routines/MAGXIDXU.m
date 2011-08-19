MAGXIDXU ;WOIFO/JSL - MAG INDEX TERMS BUILD/UPDATE Utilities for Imaging Version 3.0; 06/29/2007 10:15
 ;;3.0;IMAGING;**61,54**;03-July-2009;;Build 1424
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
IDXUPDT ;API call - OPTION (MAG IMAGE INDEX TERMS UPDATE)
 N DATE,IDA,SUB,XP,EOF,IN,MAGMSG,INXMB,LINE,LN,NEWSN,START,TKID,X,Y,XMZ,XMER,DIR
 D GETENV^%ZOSV,KILL^XM
 I '$D(^XUSEC("MAG SYSTEM",+$G(DUZ))) U IO(0) W !,"Calling user does not have security key MAG SYSTEM" Q
 U IO(0) S DIR("A")="Update your local Index Terms with the latest Index Term Distribution (Y/N)",DIR("B")="Y",DIR(0)="Y" D ^DIR I '$G(Y) Q
 S SUB="MAG INDEX TERMS UPDATE" K ^TMP(SUB,$J)
 S TKID=$H*86400+$P($H,",",2)
 S X="ERR^MAGXIDXU",@^%ZOSF("TRAP")
 L +^XTMP(SUB):5 I '$T U IO(0) W !,"Some one is also updating Index Terms, ^XTMP("_SUB_") locked." H 5 Q
 S INXMB=$$INXMB^MAGXIDX0 I 'INXMB U IO(0) W !,"No updated distribution." H 2 Q  ;latest idx update
 U IO(0) W !
 ;;IA 1048 - $$READ^XMGAPI1 Get the next line of XMZ message text.
 S XMZ=INXMB F LN=1:1:256 S LINE=$$READ^XMGAPI1() Q:XMER=-1  I LINE[SUB Q
 S LINE=$$READ^XMGAPI1() Q:XMER=-1  Q:LINE=""  S NEWSN=+$P(LINE,"SERIAL#",2)  ;new serial#
 I +$G(^MAG(2005.82,"SERIAL#"))'<NEWSN U IO(0) W !,"The version is up-to-date." Q
 F LN=1:1 S LINE=$$READ^XMGAPI1() Q:XMER=-1  S ^TMP(SUB,$J,LN)=LINE
 I +$G(^MAG(2005.82,"SERIAL#"))<NEWSN D:$$PRECHK()
 . S START=$$NOW^XLFDT
 . F IN=2005.82,2005.83,2005.84,2005.85 I $D(^MAG(IN)) D
 . . M ^XTMP("MAG INDEX TERMS BACKUP",TKID,IN)=^MAG(IN)
 . . Q
 . D UPDATE I $G(EOF)'=1 D UFAIL U IO(0) D  Q
 . . W !,"The Update of Imaging Index Terms was Aborted.",!
 . . W "The entire Distribution Mail Message was not received at this Site.",!
 . . W "You need to call Imaging Support and have the Distribution Message Re-Sent to this site.",!
 . . Q
 . D INS("MAG INDEX TERMS UPDATE ",DUZ,START,""),MKBASE
 . Q
 L -^XTMP(SUB)
 Q
ERR ;error handler
 Q:'$G(DUZ)
 I $G(TKID) I $D(^XTMP("MAG INDEX TERMS BACKUP",TKID)) D RECOVER
 D @^%ZOSF("ERRTN")
 Q
UPDATE ;called by IDXUPDT
 NEW LN,MSG,Y,Y1,SCODE,SAVMAG,X
 S LN=0 F  S LN=$O(^TMP(SUB,$J,LN)) Q:'LN!$G(EOF)  S Y=$G(^(LN)) DO
 . I Y["Total Count:= " S EOF=1 U IO(0) W ! Q  ;EOF mark
 . I Y["INDEX TABLE GLOBAL"&(Y["MAG") D
 . . S SCODE="S ^TMP("""_SUB_""","_$J_",0,"_$P(Y,"^MAG(",2)_"="
 . . S LN=$O(^TMP(SUB,$J,LN)) Q:'LN  S Y1=$G(^(LN))
 . . S SCODE=SCODE_""""_Y1_""""
 . . X SCODE U IO(0) W "*"
 . . Q
 . Q
 I $G(EOF) U IO(0) W !,"Restore Code: "_TKID,! F IN=2005.82,2005.83,2005.84,2005.85 I $D(^TMP(SUB,$J,0,IN)) D
 . W !,$P(^MAG(IN,0),"^"),"(#",IN,") ...updated.",!
 . D CHKSTA
 . K ^MAG(IN) M ^MAG(IN)=^TMP(SUB,$J,0,IN) ;set value
 . S ^MAG(IN,"SERIAL#")=NEWSN
 . Q
 S Y=$$NOW^XLFDT()\1,X=$$FMADD^XLFDT(Y,7)
 S ^XTMP("MAG INDEX TERMS BACKUP",0)=X_U_Y_U_SUB
 Q
CHKSTA ;verify current status w/ National ^TMP
 N IEN,STA,STO S IEN=0
 I IN=2005.84 F  S IEN=$O(^TMP(SUB,$J,0,IN,IEN)) Q:'IEN  D
 . S STA=$P(^TMP(SUB,$J,0,IN,IEN,0),U,4),STO=$P($G(^MAG(IN,IEN,0)),U,4)
 . I STA="I" Q  ;disable by national
 . I STO="I" S $P(^TMP(SUB,$J,0,IN,IEN,0),U,4)=STO Q  ;kp site
 . Q
 I IN=2005.85 F  S IEN=$O(^TMP(SUB,$J,0,IN,IEN)) Q:'IEN  D
 . S STA=$P(^TMP(SUB,$J,0,IN,IEN,0),U,3),STO=$P($G(^MAG(IN,IEN,0)),U,3)
 . I STA="I" Q  ;disable by national
 . I STO="I" S $P(^TMP(SUB,$J,0,IN,IEN,0),U,3)=STO Q  ;kp site
 . Q
 Q
UFAIL ;UPDATE FAIL, no End Of File
 N CT,CNT,COM,D,D0,D1,D2,DDATE,DG,DIC,DICR,DIW,MAGMSG,ST,XMID,XMY,XMSUB,XMERR
 D GETENV^%ZOSV
 S CNT=1,MAGMSG(CNT)="MAG INDEX TERMS UPDATE FAILED"
 S CNT=CNT+1,MAGMSG(CNT)="SITE: "_$$KSP^XUPARAM("WHERE")
 S CNT=CNT+1,MAGMSG(CNT)="PACKAGE: MAG INDEX TERMS UPDATE"
 S CNT=CNT+1,MAGMSG(CNT)="Distribution: "_$G(NEWSN)
 S CNT=CNT+1,MAGMSG(CNT)="Installed by: "_$$GET1^DIQ(200,DUZ,.01,"E")
 S CNT=CNT+1,MAGMSG(CNT)="Did not receive whole package, there was no EOF mark"
 S CNT=CNT+1,MAGMSG(CNT)="Please re-send new Index Terms message."
 S XMSUB="MAG INDEX TERMS UPDATE #"_NEWSN_" Failed!"
 S XMID=+$G(DUZ),XMY(XMID)=""
 S XMY("G.MAG SERVER")=""
 S:$G(MAGDUZ) XMY(MAGDUZ)=""
 D SENDMSG^XMXAPI(XMID,XMSUB,"MAGMSG",.XMY,,.XMZ,)
 D RECOVER
 Q
INS(XP,DUZ,DATE,IDA) ;return msg
 N CT,CNT,COM,D,D0,D1,D2,DDATE,DG,DIC,DICR,DIW,MAGMSG,ST,XMID,XMY,XMSUB,XMERR
 D GETENV^%ZOSV
 S CNT=1,MAGMSG(CNT)="MAG INDEX TERMS Update is completed"
 S CNT=CNT+1,MAGMSG(CNT)="SITE: "_$$KSP^XUPARAM("WHERE")
 S CNT=CNT+1,MAGMSG(CNT)="PACKAGE: "_XP
 S CNT=CNT+1,MAGMSG(CNT)="Distribution: "_$G(NEWSN)
 S CNT=CNT+1,MAGMSG(CNT)="Start time: "_$$FMTE^XLFDT(DATE)
 S CT=$$NOW^XLFDT  ;Time stamp
 S CNT=CNT+1,MAGMSG(CNT)="Completion time: "_$$FMTE^XLFDT(CT)
 S CNT=CNT+1,MAGMSG(CNT)="Run time: "_$$FMDIFF^XLFDT(CT,DATE,3)
 S CNT=CNT+1,MAGMSG(CNT)="Environment: "_Y
 S CNT=CNT+1,MAGMSG(CNT)="Restore Code: "_TKID
 S CNT=CNT+1,MAGMSG(CNT)="DATE: "_$$FMTE^XLFDT(DATE)
 S CNT=CNT+1,MAGMSG(CNT)="Installed by: "_$$GET1^DIQ(200,DUZ,.01,"E")
 S CNT=CNT+1,MAGMSG(CNT)="Install Name: "_XP
 S XMSUB=XP_"#"_NEWSN_" INSTALLATION"
 S XMID=+$G(DUZ),XMY(XMID)=""
 S XMY("G.MAG SERVER")=""
 S:$G(MAGDUZ) XMY(MAGDUZ)=""
 S XMSUB=$E(XMSUB,1,63)
 D SENDMSG^XMXAPI(XMID,XMSUB,"MAGMSG",.XMY,,.XMZ,)
 I $G(XMERR) M XMERR=^TMP("XMERR",$J) S $EC=",U13-Cannot send MailMan message,"
 Q
RESTORE ;API call - MAG INDXE TERM RESTORE
 N ANS,IN,TKID,DIR,Y
 D GETENV^%ZOSV
 I '$D(^XUSEC("MAG SYSTEM",+$G(DUZ))) U IO(0) W !,"Calling user does not have security key MAG SYSTEM" Q
 F IN=1:1:5 U IO(0) D  Q:$D(^XTMP("MAG INDEX TERMS BACKUP",+$G(TKID)))!($G(TKID)="^")
 . W !,"To UnDo the Index Term updates and restore this site's Index Term files you need"
 . W !,"the Restore Code that was included in the last INDEX TERMS UPDATE #",$G(^MAG(2005.82,"SERIAL#"))
 . W !,"INSTALLATION message.",!
 . W ! R "Enter Restore Code: ",TKID:360 I $G(TKID)["?" W " Restore Code please!",! S TKID=-1 Q
 . W:'$D(^XTMP("MAG INDEX TERMS BACKUP",+$G(TKID))) !!,"Incorrect Restore Code, cannot restore the Index Term files."
 . Q
 Q:'$G(TKID)
 S DIR("A")="Continue to restore Index Terms",DIR("B")="N",DIR(0)="Y" D ^DIR
 I '$G(Y) U IO(0) W !,"Nothing done.",! Q 
 D RECOVER,MKBASE
 U IO(0) W !,"Done.",!
 Q
RECOVER ;Call by RESTORE
 Q:$G(TKID)=""
 F IN=2005.82,2005.83,2005.84,2005.85 D
 . I $D(^MAG(IN))&$D(^XTMP("MAG INDEX TERMS BACKUP",TKID,IN)) D
 . . K ^MAG(IN) M ^MAG(IN)=^XTMP("MAG INDEX TERMS BACKUP",TKID,IN) ;recoverd
 . Q
 Q
MKBASE ;make last known base
 N IN,SUBJ,X,X0,X1,X2 S SUBJ="MAG INDEX TERMS UPDATE"
 F IN=2005.82,2005.83,2005.84,2005.85 M ^XTMP(SUBJ,0,"BASE",IN)=^MAG(IN)
 S X0=$$NOW^XLFDT()\1,X=$$FMADD^XLFDT(X0,180),^XTMP(SUBJ,0)=X_U_X0_U_SUBJ
 S ^XTMP(SUBJ,0,"BASE")=X0+17000000  ;yyyymmdd.hhmmss
 Q
PRECHK() ;check to see if should overwrite old
 N X,Y,DIFF,DCNT  S (DIFF,DCNT)=0
 I '$D(^XTMP(SUB,0,"BASE")) Q 1  ;no base to check
 F IN="^MAG(2005.82","^MAG(2005.83" D  ;compare contain
 . S X=IN_")" F  S X=$Q(@X) Q:X'[IN  I X[",0)",$L(X,",")=3 D
 . . S Y="^XTMP("""_SUB_""","_0_",""BASE"","_$P(X,"^MAG(",2)
 . . I $G(@Y)="" S DCNT=DCNT+1,DIFF=1,DIFF(DCNT)="Addition: "_X_" := "_@X Q
 . . I $TR(@(X),U)'=$TR($G(@Y),U) D
 . . . S DCNT=DCNT+1,DIFF=1,DIFF(DCNT)="Changed :  "_X_" := "_@X
 . . . S DCNT=DCNT+1,DIFF=1,DIFF(DCNT)="Expected value:                "_$G(@Y)
 . . Q
 . Q
 F IN="^MAG(2005.84","^MAG(2005.85" D  ;compare contain but STATUS
 . S X=IN_")" F  S X=$Q(@X) Q:X'[IN  I X[",0)",$L(X,",")=3 D
 . . S Y="^XTMP("""_SUB_""","_0_",""BASE"","_$P(X,"^MAG(",2)
 . . I $TR(@(X),U)=$TR($G(@Y),U) Q
 . . I $G(@Y)="" S DCNT=DCNT+1,DIFF=1,DIFF(DCNT)="Addition: "_X_" := "_@X Q
 . . I IN["2005.84" I $TR($P(@X,U,1,3),U)=$TR($P($G(@Y),U,1,3),U) Q
 . . I $TR($P(@X,U,1,2),U)=$TR($P($G(@Y),U,1,2),U) Q
 . . S DCNT=DCNT+1,DIFF=1,DIFF(DCNT)="Changed :  "_X_" := "_@X
 . . S DCNT=DCNT+1,DIFF=1,DIFF(DCNT)="Expected value:                "_$G(@Y)
 . . Q
 . Q
 I DIFF S (DCNT,CNT)=0 D  ;find/report the difference
 . S CNT=CNT+1,MAGMSG(CNT)="MAG INDEX TERMS UPDATE - PRE_CHECK FAILED"
 . S CNT=CNT+1,MAGMSG(CNT)="SITE: "_$$KSP^XUPARAM("WHERE")
 . S CNT=CNT+1,MAGMSG(CNT)="PACKAGE: MAG INDEX TERMS UPDATE"
 . S CNT=CNT+1,MAGMSG(CNT)="Distribution: "_$G(NEWSN)
 . S CNT=CNT+1,MAGMSG(CNT)="Changes have been made to the Index Term files at your site."
 . S CNT=CNT+1,MAGMSG(CNT)="You must remove local Changes to these files before update can continue."
 . S CNT=CNT+1,MAGMSG(CNT)=" - - - - - "
 . S CNT=CNT+1,MAGMSG(CNT)="The Changes/Additions found were:"
 . F CNT=CNT:1 S DCNT=$O(DIFF(DCNT)) Q:'DCNT  S MAGMSG(CNT+1)=DIFF(DCNT)
 . S CNT=CNT+2 S MAGMSG(CNT)=" - - - - - "
 . S CNT=CNT+1 S MAGMSG(CNT)="Log a Remedy Ticket with VistA Imaging Support for help"
 . S XMSUB="MAG INDEX TERMS UPDATE #"_$G(NEWSN)_" update has Failed!"
 . S XMID=+$G(DUZ),XMY(XMID)=""
 . S XMY("G.MAG SERVER")=""
 . S:$G(MAGDUZ) XMY(MAGDUZ)=""
 . D WARNMSG^MAGXIDX0 F IN=1:1:CNT U IO(0) W !,$G(MAGMSG(IN)),!
 . D SENDMSG^XMXAPI(XMID,XMSUB,"MAGMSG",.XMY,,.XMZ,)
 . Q
 Q $S(DIFF:0,1:1)
 ;

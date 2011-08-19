GMRCYP69 ;SLC/WAT - Reformat long comments from Edit/Resubmit ;1/21/09
 ;;3.0;CONSULT/REQUEST TRACKING;**69**;DEC 27, 1997;Build 13
 ;;
 ;;ICR Invoked
 ;;10063, ^%ZTLOAD - $$S
 ;;10141, ^XPDUTL - BMES, PATCH
 ;;10103, ^XLFDT - $$FMADD, $$NOW, $$FMTH
 ;;10113, ^XMB(3.9
 ;;10066, XMZ^XMA2
 ;;10070, ^XMD - ENL,  ENT1
 ;;10011, ^DIWP, ^UTILITY($J
 ;;2053, WP^DIE
PRE ;sys check
 I $G(DUZ)="" D BMES^XPDUTL("Your DUZ is not defined. Install aborted. Transport global NOT deleted from system.") S XPDABORT=2 Q
 I '$$PATCH^XPDUTL("OR*3.0*296") S XPDABORT=2 D  Q 
 .D BMES^XPDUTL("*************")
 .D BMES^XPDUTL("OR*3.0*296 and the associated CPRS GUI exe must be installed first!")
 .D BMES^XPDUTL("Install aborted. Transport global NOT deleted from system.")
 Q
POST ;go
 D QUEUE
 Q
QUEUE ;task entry point
 N ZTRTN,ZTDESC,ZTIO,ZTDTH,ZTSK
      S ZTRTN="EN^GMRCYP69",ZTDESC="GMRC Reformat Long Comments from Edit/Resubmit Action",ZTIO="",ZTDTH=$H
 D ^%ZTLOAD I '$G(ZTSK) D BMES^XPDUTL("POST INSTALL NOT QUEUED - RUN EN^GMRCYP69 AFTER INSTALL FINISHES") Q 
 D BMES^XPDUTL("Post-install queued as task #"_$G(ZTSK))
 D BMES^XPDUTL("If any records are locked, task will re-run 5 minutes after completion.")
 Q
EN ;main
 S $P(^XTMP("GMRC_PRE69",0),U)=$$FMADD^XLFDT(DT,45),$P(^XTMP("GMRC_PRE69",0),U,2)=DT
 S $P(^XTMP("GMRC_PRE69",0),U,3)=DUZ_" Patch installer's DUZ, global contains comment data before reformat in GMRC*3.0*69"
 S ^XTMP("GMRC_PRE69","DUZ")=DUZ ;get user's DUZ for mail mesage
 D SRCH
 I $D(^XTMP("GMRC_PRE69","RECHECK")) D RECHECK S ZTREQ="@" Q  ;some are locked, run recheck, clean task and quit
 I $D(^XTMP("GMRC_PRE69","RECHECK"))=0 D MSG S ZTREQ="@" Q  ;If all are checked, send msg, clean task, and quit
 Q
RECHECK ;if locked records requeue and re-run until all are checked
 Q:'$D(ZTQUEUED)&($D(^XTMP("GMRC_PRE69","RECHECK"))=0)  ;abort if outside taskman and all records already checked.
 N RECLOCK,IEN,A,B,TOTAL,IDX S (IEN,TOTAL)=0,IDX=""
 F  S IEN=$O(^XTMP("GMRC_PRE69","RECHECK",IEN)) Q:IEN=""  D
 .S RECLOCK=$$LOCKREC^GMRCUTL1(IEN)
 .Q:$G(RECLOCK)'=1  ;if still locked, do nothing
 .F  S IDX=$O(^XTMP("GMRC_PRE69","RECHECK",IEN,IDX)) Q:IDX=""  D
 ..S A=$P(^XTMP("GMRC_PRE69","RECHECK",IEN,IDX),",",4),B=1
 ..D REFORMAT D UNLKREC^GMRCUTL1(IEN) S ^XTMP("GMRC_PRE69","TOTAL")=$G(^XTMP("GMRC_PRE69","TOTAL"))+1
 ..K ^XTMP("GMRC_PRE69","RECHECK",IEN,IDX)
 I $D(^XTMP("GMRC_PRE69","RECHECK"))=0 D MSG S:($D(ZTQUEUED)) ZTREQ="@" Q
 E  D
 .N ZTRTN,ZTDESC,ZTIO,ZTDTH,ZTSK,ZTSAVE
      .S ZTRTN="RECHECK^GMRCYP69",ZTDESC="GMRC Reformat Long Comments from Edit/Resubmit Action - RECHECK",ZTIO=""
      .S ZTDTH=$$FMTH^XLFDT($$FMADD^XLFDT($$NOW^XLFDT,,,5)) ;set to re-run in 5 minutes
      .D ^%ZTLOAD
      S ZTREQ="@"
 Q
SRCH ;search for long comments
 N IEN,A,B,C,TOTAL,FLG,LNCNT,RECLOCK,STPCHK,IDX S (IEN,TOTAL,RECLOCK,STPCHK,IDX)=0,LNCNT=1
 F  S IEN=$O(^GMR(123,IEN)) Q:+IEN=0!($G(ZTSTOP))  D
 .S A=0,STPCHK=STPCHK+1
 .I STPCHK>1000,$D(ZTQUEUED) S:$$S^%ZTLOAD ZTSTOP=1 Q:$G(ZTSTOP)  S STPCHK=0
 .F  S A=$O(^GMR(123,IEN,40,A)) Q:+A=0  D
 ..Q:$D(^GMR(123,IEN,40,A,0))<1
 ..Q:$P(^GMR(123,IEN,40,A,0),U,2)'=20  ;quit if action is not Add Comment
 ..;quit if next action not Edit/Resubmit, only get comments from Edit/Resubmit
 ..Q:$D(^GMR(123,IEN,40,A+1,0))<10&($P($G(^GMR(123,IEN,40,A+1,0)),U,2)'=11)
 ..S B=0
 ..F  S B=$O(^GMR(123,IEN,40,A,B)) Q:+B=0  D
 ...S C=0,FLG=0
 ...F  S C=$O(^GMR(123,IEN,40,A,B,C)) Q:+C=0  D  Q:FLG=1!($G(RECLOCK)=1)
 ....S FLG=0,RECLOCK=0 S:($L(^GMR(123,IEN,40,A,B,C,0))>80) FLG=1 Q:FLG'=1
 ....S RECLOCK=$$LOCKREC^GMRCUTL1(IEN)
 ....I $G(RECLOCK)'=1 S ^XTMP("GMRC_PRE69","RECHECK",IEN,IDX)=$NA(^GMR(123,IEN,40,A,B,C,0)),IDX=IDX+1
 ....S:$G(RECLOCK)=1 TOTAL=TOTAL+1,^XTMP("GMRC_PRE69","TOTAL")=$G(^XTMP("GMRC_PRE69","TOTAL"))+1
 ....D REFORMAT D:$G(RECLOCK)=1 UNLKREC^GMRCUTL1(IEN)
 Q
REFORMAT ;reformat data to 74 characters
 K ^UTILITY($J,"W")
 N INT,GMRC69,GMRCTMP,REF S INT=0,REF=A
 N X,DIWL,DIWR,DIWF
 S DIWL=1,DIWR=74,DIWF=""
 Q:$G(RECLOCK)'=1
 F  S INT=$O(^GMR(123,IEN,40,A,B,INT)) Q:+INT=0  D
 .S ^XTMP("GMRC_PRE69",IEN,40,A,B,INT,0)=^GMR(123,IEN,40,A,B,INT,0)
 .S X=^GMR(123,IEN,40,A,B,INT,0)
 .D ^DIWP
 .S:$G(RECLOCK)'=1 INT="A"
 D WP^DIE(123.02,REF_","_IEN_",","5","","^UTILITY($J,""W"",1)","^TMP($J,""ERR"")")
 Q
MSG ;create and send message
 N XMDUZ,XMSUB,XMZ,XMTEXT,XMY ;i/o args for XMZ^XMA2.
 N IEN,A,B,C,LNCNT S (IEN,A,B,C)=0,LNCNT=1
 S XMY(^XTMP("GMRC_PRE69","DUZ"))=""
 S XMDUZ="GMRC PACKAGE"
 S XMSUB="GMRC*3.0*69 COMMENTS BEFORE REFORMAT"
 D XMZ^XMA2 ; call Create Message Module
 I $G(^XTMP("GMRC_PRE69","TOTAL"))>0 F  S IEN=$O(^XTMP("GMRC_PRE69",IEN)) Q:+IEN=0  D
 .F  S A=$O(^XTMP("GMRC_PRE69",IEN,40,A)) Q:+A=0  D
 ..F  S B=$O(^XTMP("GMRC_PRE69",IEN,40,A,B)) Q:+B=0  D
 ...F  S C=$O(^XTMP("GMRC_PRE69",IEN,40,A,B,C)) Q:+C=0  D
 ....S ^XMB(3.9,XMZ,2,LNCNT,0)=$NA(^GMR(123,IEN,40,A,B,C,0))_U_^XTMP("GMRC_PRE69",IEN,40,A,B,C,0)
 ....S ^XMB(3.9,XMZ,2,0)="^3.92^"_LNCNT_"^"_LNCNT_"^"_DT ;define zero node per API
 ....S LNCNT=LNCNT+1
 I $G(^XTMP("GMRC_PRE69","TOTAL"))=0!($D(^XTMP("GMRC_PRE69","TOTAL"))=0) D
 .S XMTEXT="XMTEXT"
 .S XMTEXT(1)="No long comments found.  No records were modified in ^GMR(123."
 .D ENL^XMD
 D ENT1^XMD
 Q

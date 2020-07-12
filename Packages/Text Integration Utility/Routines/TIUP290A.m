TIUP290A ;ISP/JLC - POST FOR PATCH TIU*1.0*290 ;Apr 24, 2020@13:48
 ;;1.0;TEXT INTEGRATION UTILITIES;**290**;Jun 20, 1997;Build 548
 Q
EN ; Task off the Build of the Copy/Paste indices for file #8925
 N ZTDTH,ZTIO,ZTSK,ZTRTN,ZTDESC
 S ZTDTH=$$FMADD^XLFDT($$NOW^XLFDT,0,0,0,10)
 S ZTRTN="TASK^TIUP290A",ZTDESC="Build of Copy/Paste indices for files #8925 and #8925.95"
 S ZTIO=""
 D ^%ZTLOAD
 I +$G(ZTSK)=0 D
 . D BMES^XPDUTL("Unable to queue the Copy/Paste indices build, file a help desk ticket for assistance.")
 E  D
 . D BMES^XPDUTL("DONE - Task #"_ZTSK)
 Q
TASK ;
 N TIUIEN,I,J,STOP,A,TIU12,TIU13,TIUDOC
 S STOP=0
 K ^TIU(8925.95,"AC") ; Clean-up index due to falty cross-reference setup
 K DA,DIK,DIC
 S TIUDOC=""
 F  S TIUDOC=$O(^TIU(8925.95,TIUDOC)) Q:TIUDOC=""  D
 . I $P($G(^TIU(8925.95,TIUDOC,10)),U,1)'=1 Q
 . S DA=TIUDOC,DIK="^TIU(8925.95,",DIK(1)="10.1^AC"
 . D EN^DIK
 S TIUIEN=$G(^TIU(8925,"AADT",0)) I TIUIEN="" S TIUIEN=" "
 F I=1:1 D  Q:'TIUIEN  I STOP Q
 . S TIUIEN=$O(^TIU(8925,TIUIEN),-1) Q:'TIUIEN
 . S TIU12=$G(^TIU(8925,TIUIEN,12))
 . S TIU13=$G(^TIU(8925,TIUIEN,13))
 . S X(1)=$P(TIU12,"^",2),X(2)=$P(TIU13,"^",2),X(3)=$P(TIU13,"^")
 . S DA=TIUIEN
 . D KAADT^TIUDD01(.X)
 . D SAADT^TIUDD0(.X)
 . K DA,DIK,DIC
 . S DA=TIUIEN,DIK="^TIU(8925,",DIK(1)="1301^H"
 . D EN^DIK
 . S ^TIU(8925,"AADT",0)=TIUIEN
 . I '(I#100000) D  I STOP Q
 .. F J=1:1:300 H 1 I '(J#60) S STOP=$$REQ2STOP() I STOP Q
 . I '(I#500) S STOP=$$REQ2STOP() I STOP Q
 I STOP Q
 K ^TIU(8925,"AADT",0)
 D MSG
 Q
MSG ;
 N XMSUB,XMY,XMTEXT,XMDUZ,TIUTEXT,SITE,I,A
 S TIUTEXT(1)="Build of Copy/Paste indicess completed for "_$$SITE^VASITE()
 S TIUTEXT(2)=" "
 S XMDUZ=DUZ
 S XMSUB="Build of Copy/Paste indicess completed"
 S XMY("CRUMLEY.JAMIE@DOMAIN.REMOV")="",XMY("HAWSEY.JASON@DOMAIN.REMOV")=""
 S XMTEXT="TIUTEXT("
 D ^XMD
 Q
REQ2STOP() ;
 ; Check for task stop request
 ; Returns 1 if stop request made.
 N STATUS,X
 S STATUS=0
 I '$D(ZTQUEUED) Q 0
 S X=$$S^%ZTLOAD()
 I X D  ;
 . S STATUS=1
 . S X=$$S^%ZTLOAD("Received shutdown request")
 ;
 Q STATUS
TEMPLATE ;post-install to check line length in templates
 N ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTSK
 D BMES^XPDUTL("  Queueing the template checker task...")
 S ZTRTN="CHECK^TIUP290A",ZTDESC="TIU*1*290 TEMPLATE CHECKER"
 S ZTDTH=$$FMADD^XLFDT($$NOW^XLFDT,0,0,2),ZTIO=""
 D ^%ZTLOAD
 I +$G(ZTSK)>0 D MES^XPDUTL("    Successfully queued the task with task #"_ZTSK)
 I '+$G(ZTSK) D MES^XPDUTL("    Failed to queue the task"),CHECK
 Q
CHECK ;check the length of template text
 N ROOTIEN,LINE,NEXTSTOP,ROOT,OUTPUTHEADER,HEADER,PATH,OUTPUTPATH
 S LINE=0
 F ROOT="CONSULTS","PROCEDURES"  D
 .S ROOTIEN=+$O(^TIU(8927,"AROOT",ROOT,"")) Q:ROOTIEN=0
 .S OUTPUTHEADER=1,OUTPUTPATH=0,PATH=""
 .S HEADER=$P($G(^TIU(8927,ROOTIEN,0)),U,1) I HEADER="" S HEADER=ROOT
 .D CHILDREN(ROOTIEN,.NEXTSTOP,.ZTSTOP,.LINE,.OUTPUTHEADER,HEADER,.PATH,.OUTPUTPATH)
 K:+$G(ZTSTOP)=0 ZTSTOP
 I +$G(ZTSTOP)=1 D
 .S LINE=1,^TMP("TIU MSG",$J,LINE,0)="Task #"_$G(ZTSK)_" was stopped before it finished."
 .S LINE=LINE+1,^TMP("TIU MSG",$J,LINE,0)="Restart the task or execute D TEMPLATE^TIUP290A from the Programmer's"
 .S LINE=LINE+1,^TMP("TIU MSG",$J,LINE,0)="prompt to restart the template checker."
 I '+$G(LINE) D
 .K ^TMP("TIU MSG",$J)
 .S LINE=1,^TMP("TIU MSG",$J,LINE,0)="There are no templates containing text that is more than 74 characters in"
 .S LINE=LINE+1,^TMP("TIU MSG",$J,LINE,0)="length."
 N XMMG,XMDUZ,XMZ,XMERR,DIFROM,XMTEXT,XMSUB,XMY
 S XMDUZ="TIU TEMPLATE CHECKER",XMSUB="TIU*1*290 TEMPLATE CHECK RESULTS"
 S XMTEXT="^TMP(""TIU MSG"",$J,"
 S XMY(DUZ)="",XMY("G.OR CACS")=""
 D ^XMD
 I $D(XMMG)>0 D
 .M ^XTMP("TIU*1*290 TEMPLATE CHECK RESULTS")=^TMP("GMRA MSG",$J)
 .S ^XTMP("TIU*1*290 TEMPLATE CHECK RESULTS",0)=$$FMADD^XLFDT(DT,31)_U_DT_U_"PATCH TIU*1*290 TEMPLATE CHECK RESULTS"
 K ^TMP("TIU MSG",$J)
 I $D(ZTQUEUED),'$D(ZTSTOP) S ZTREQ="@"
 I '$D(ZTQUEUED) D MES^XPDUTL("    Template checker process has exited")
 Q
CHILDREN(ROOTIEN,NEXTSTOP,ZTSTOP,LINE,OUTPUTHEADER,HEADER,PATH,OUTPUTPATH) ;recursively search templates
 N ITEMIEN,IEN,NAME,G74,START,CNT,NODE
 S ITEMIEN=0 F  S ITEMIEN=$O(^TIU(8927,ROOTIEN,10,ITEMIEN)) Q:('+ITEMIEN)!($G(ZTSTOP))  D
 .I $G(NEXTSTOP)=""!($G(NEXTSTOP)=$H) D
 ..S ZTSTOP=$$S^%ZTLOAD Q:ZTSTOP
 ..S NEXTSTOP=$$HADD^XLFDT($H,0,0,0,30)
 .Q:ZTSTOP
 .S IEN=+$P($G(^TIU(8927,ROOTIEN,10,ITEMIEN,0)),U,2) Q:'IEN
 .S NODE=$G(^TIU(8927,IEN,0))
 .S NAME=$P(NODE,U,1) Q:NAME=""
 .I $P(NODE,U,3)="C" S PATH=$S($G(PATH)'="":PATH_" > ",1:"")_NAME,OUTPUTPATH=1
 .S G74=0,START=0
 .S CNT=0 F  S CNT=$O(^TIU(8927,IEN,2,CNT)) Q:(CNT'>0)!(G74=1)  D
 ..S NODE=$G(^TIU(8927,IEN,2,CNT,0))
 ..D STRIPFIELDS(.NODE,.START)
 ..I $L(NODE)>74 S G74=1
 .I G74 D ADDTEMPLATE(.LINE,.OUTPUTPATH,.PATH,NAME,.OUTPUTHEADER,HEADER)
 .I $D(^TIU(8927,IEN,10))>9 D CHILDREN(IEN,.NEXTSTOP,.ZTSTOP,.LINE,.OUTPUTHEADER,HEADER,.PATH,.OUTPUTPATH)
 Q
STRIPFIELDS(TEXT,START) ;remove template field(s) from text
 N INDEX,THIS,SPEC,SEARCH
 S THIS=0
 F INDEX=1:1  Q:INDEX>$L(TEXT)  D
 .I ($E(TEXT,INDEX,INDEX+4)="{FLD:")!(($E(TEXT,INDEX)="|")&(START=0)) S START=START+1,START(START)=INDEX,THIS=1 Q
 .I (($E(TEXT,INDEX)="}")!($E(TEXT,INDEX)="|"))&(+$G(START)>0) D
 ..S SEARCH=$E(TEXT,$S(THIS=1:START(START),1:1),INDEX),SPEC(SEARCH)=""
 ..S TEXT=$$REPLACE^XLFSTR(TEXT,.SPEC),INDEX=INDEX-$L(SEARCH)
 ..K SPEC,START(START)
 ..S START=START-1
 I START>0 D
 .I THIS S SPEC($E(TEXT,START(START),$L(TEXT)))="",TEXT=$$REPLACE^XLFSTR(TEXT,.SPEC)
 .E  S TEXT=""
 Q
ADDTEMPLATE(LINE,OUTPUTPATH,PATH,NAME,OUTPUTHEADER,HEADER) ;add a template to the message body
 I '+$G(LINE) D
 .K ^TMP("TIU MSG",$J)
 .S LINE=1,^TMP("TIU MSG",$J,LINE,0)="The following templates contain text that is more than 74 characters in"
 .S LINE=LINE+1,^TMP("TIU MSG",$J,LINE,0)="length. Please review each template in CPRS to ensure that the text is"
 .S LINE=LINE+1,^TMP("TIU MSG",$J,LINE,0)="wrapped correctly."
 .S LINE=LINE+1,^TMP("TIU MSG",$J,LINE,0)=""
 I OUTPUTHEADER D
 .I LINE>3 S LINE=LINE+1,^TMP("TIU MSG",$J,LINE,0)=""
 .S LINE=LINE+1,^TMP("TIU MSG",$J,LINE,0)=HEADER
 .S LINE=LINE+1,^TMP("TIU MSG",$J,LINE,0)=$$REPEAT^XLFSTR("-",$L(HEADER))
 .S OUTPUTHEADER=0
 I OUTPUTPATH S LINE=LINE+1,^TMP("TIU MSG",$J,LINE,0)=PATH,OUTPUTPATH=0
 I PATH'="" S NAME=" "_NAME
 S LINE=LINE+1,^TMP("TIU MSG",$J,LINE,0)=NAME
 Q

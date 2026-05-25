YTQRQAD8 ;BAL/KTL - RESTful Calls to set/get MHA Note ; 1/25/2017
 ;;5.01;MENTAL HEALTH;**199,207,202,204,208,250,236**;Dec 30, 1994;Build 25
 ;
 ; Reference to TIUCNSLT in ICR #5546
 ; Reference to TIUPUTU in ICR #3351
 ; Reference to TIUSRVA in ICR #5541
 ;
 Q
SAVPNOT(ASGN,ADMIN,CONSULT,COSIGNER,YS) ;Save Progress Note Text in XTMP until session complete
 N NOD,LN,CNT,ADMCNT
 S NOD="YTQASMT-SET-"_ASGN
 I '$D(^XTMP(NOD)) D SETERROR^YTQRUTL(400,"Assignment Not Found") Q
 S CNT=$O(^XTMP(NOD,2,"PNOTE","TXT",""),-1)
 S ADMCNT=$O(^XTMP(NOD,2,"PNOTE","ADMINS",""),-1)
 S ADMCNT=ADMCNT+1,^XTMP(NOD,2,"PNOTE","ADMINS",ADMCNT)=ADMIN_U_$G(CONSULT)_U_$G(COSIGNER)
 I CNT'="" S CNT=CNT+1,$P(^XTMP(NOD,2,"PNOTE","TXT",CNT),"_",75)="" ;Add Note Divider
 S LN=0 F  S LN=$O(YS(LN)) Q:+LN=0  D
 . S CNT=CNT+1,^XTMP(NOD,2,"PNOTE","TXT",CNT)=YS(LN)
 Q
FILPNOT(ASGN,ADMIN,CONSULT,DATA,TMPYS,FRMDEL) ;File the aggregate Progress Note
 ;FRMDEL = If invoked from delete the last instrument and Aggregate Progress Note exists
 N YSADMIN,YSCONSULT,YSCOSIGNER,NOD,REMAIN,I
 N CNT,LN,YS,YSDATA
 I +ASGN=0 S ASGN=$G(DATA("assignmentId"))
 I +ASGN=0 D SETERROR^YTQRUTL(400,"No Assignment") Q 0
 S COSIGNER=$G(DATA("cosigner"))
 S FRMDEL=$G(FRMDEL)
 S NOD="YTQASMT-SET-"_ASGN
 I COSIGNER="",(+$G(^XTMP(NOD,1,"cosigner"))'=0) S COSIGNER=^XTMP(NOD,1,"cosigner")
 ;I '$D(^XTMP(NOD)) D SETERROR^YTQRUTL(400,"Assignment Not Found") Q 1  ;If no ^XTMP, must be only instrument
 S YSADMIN=$G(^XTMP(NOD,2,"PNOTE","ADMINS",1))
 I +YSADMIN'=0 D  ;Previously filed first admin, override incoming parameters
 . S CONSULT=$P(YSADMIN,U,2),ADMIN=$P(YSADMIN,U)
 . I $P(YSADMIN,U,3)'="",(COSIGNER="") S COSIGNER=$P(YSADMIN,U,3)  ;Only use if main assignment cosigner not set
 I +ADMIN=0 D SETERROR^YTQRUTL(400,"No Admin for Note") Q 2
 S CNT=$O(^XTMP(NOD,2,"PNOTE","TXT",""),-1)
 M YS=^XTMP(NOD,2,"PNOTE","TXT")
 I $D(TMPYS) D  ;TMPYS is not sent if last action for Assignment was Save instrument Admin and not SAVE NOTE
 . I CNT'="" S CNT=CNT+1,$P(YS(CNT),"_",75)="" ;Add Note Divider
 . ; Add last instrument progress note text to previously saved Progress Note txt.
 . S LN=0 F  S LN=$O(TMPYS(LN)) Q:+LN=0  D
 .. S CNT=CNT+1,YS(CNT)=TMPYS(LN)
 I COSIGNER]"" S YS("COSIGNER")=COSIGNER
 S YS("AD")=ADMIN
 I CONSULT S YS("CON")=CONSULT D CCREATE^YTQCONS(.YSDATA,.YS) I 1
 E  D PCREATE^YTQTIU(.YSDATA,.YS)
 I YSDATA(1)'="[DATA]" D SETERROR^YTQRUTL(500,"Note not saved") Q 3
 ;Mark ADMINS that contributed to the PNOTE with PROGRESS NOTE GENERATED=1
 N ADMCNT,YSADD
 S ADMCNT=0 F  S ADMCNT=$O(^XTMP(NOD,2,"PNOTE","ADMINS",ADMCNT)) Q:ADMCNT=""  D
 . S YSADD=$P(^XTMP(NOD,2,"PNOTE","ADMINS",ADMCNT),U)
 . I $$ALWNOTE^YTQRQAD3(YSADD)="true" S $P(^YTT(601.84,YSADD,0),U,18)=1  ;PROGRESS NOTE GENERATED
 ;Saved progress note for all completed instruments. If last instrument, Delete Assignment
 K ^XTMP(NOD,2)  ;Kill Aggregate Progress Note
 S REMAIN=""
 S I=0 F  S I=$O(^XTMP(NOD,1,"instruments",I)) Q:'I  D
 . I $G(^XTMP(NOD,1,"instruments",I,"complete"))'="true" S REMAIN=1
 I 'REMAIN,(FRMDEL'=1),$D(^XTMP(NOD,0)) D DELASMT1^YTQRQAD1(ASGN)  ;Last instrument OK to Kill Assignment
 K ^XTMP(NOD,2)  ;KILL Filed progress note text
 Q $G(YSDATA(2))
 ;
WEBGUSRP(ARGS,RESULTS) ;Get DB Col Pref
 N YSWPARR,JSONOUT
 K ^TMP("YTQ-JSON",$J)
 D GETPARAM^YTQRQAD7("YSB USER COLUMN PREFERENCE","",.YSWPARR)
 I $G(YSWPARR(1,0))="" D
 . K YSWPARR D DFLTUP(JSONOUT)
 . D TOTMP^YSBRPC(.JSONOUT)
 I $D(YSWPARR) M ^TMP("YTQ-JSON",$J)=YSWPARR
 S RESULTS=$NA(^TMP("YTQ-JSON",$J))
 Q
WEBPUSRP(ARGS,DATA) ; Set DB Col Pref
 ;Requires HTTPREQ from YTQREST
 N YSRET
 S YSRET=$$SETPARAM^YTQRQAD7("YSB USER COLUMN PREFERENCE","/api/mha/dashboard/userpref/",.HTTPREQ,,"DASH COLS")
 Q YSRET
DFLTUP(XJSON)  ;
 N II,XDATA,XNAM,XJ,SPC,XCNT,XTABC
 S $P(SPC," ",10)=""
 S XCNT=1,XTABC=1,XJSON(XCNT)="{"
 D GETWDGT^YSBRPC(.XDATA)
 S II=0 F  S II=$O(XDATA("widgets",II)) Q:+II=0  D
 . S XNAM=$G(XDATA("widgets",II,"name"))
 . S XNAM=$S(XNAM="HIGH RISK":"highRisk",XNAM="MBC":"measurementBased",1:XNAM)
 . K XDATA("widgets",II,"instrumentList")
 . K XDATA("widgets",II,"name")
 . M XJ(XNAM)=XDATA("widgets",II)
 . S XJ(XNAM,"display")="true"
 . S XJ(XNAM,"filterList","name")="name"
 . S XJ(XNAM,"filterList","value")=""
 D ENCODE^YSBJSON("XJ","XJSON","ERRARY")
 Q

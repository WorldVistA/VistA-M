YTQRCDB3 ;BAL/KTL - MHA CLOUD DATABASE REPORT/NOTE RPC CALLS; 1/25/2017
 ;;5.01;MENTAL HEALTH;**239,224,236**;Dec 30, 1994;Build 25
 ;
 ; Reference to ^DPT in ICR #10035
 ;
 Q
PENOTE(ARGS,DATA) ;Patient Entry progress note
 N II,DFN,ADMERR,TXT,DARR,NOTERSL
 N TCNT,CCNT
 S DFN=$G(DATA("dfn")) I +DFN=0!'$D(^DPT(DFN)) D SETERROR^YTQRUTL(404,"Invalid patient ID: "_DFN) Q "/api/mha/cdb/instrument/note/0"
 S II=0 F  S II=$O(DATA("notes",II)) Q:II=""  D
 . S ADMIN=$G(DATA("notes",II,"adminId")) Q:+ADMIN=0
 . I $P($G(^YTT(601.84,ADMIN,0)),U,2)'=DFN S ADMERR=$G(ADMERR)_" : "_ADMIN K DATA("notes",II)  ;Admin does not match passed in patient
 I $G(ADMERR) D SETERROR^YTQRUTL(404,"Administration IDs do not match patient "_ADMERR) W !,ADMERR
 I '$D(DATA("notes")) Q "/api/mha/cdb/instrument/note/0"  ;No valid admins
 D PRSNOTE(.ARGS,.DATA,.TXT,"PE")
 S II=0 F  S II=$O(TXT(II)) Q:II=""  D
 . S TCNT=$G(TCNT)+1
 . I TCNT=1 S DARR("text")=TXT(II) Q
 . S CCNT=$G(CCNT)+1
 . S DARR("text","\",CCNT)=TXT(II)
 S II=$O(DATA("notes","")),DARR("adminId")=DATA("notes",II,"adminId")
 S NOTERSL=$$SETNOTE(.ARGS,.DARR)
 Q NOTERSL
 Q
SENOTE(ARGS,DATA) ;Staff Entry progress note
 Q
PRSNOTE(ARGS,DATA,TXT,YSTYPE) ;Parse the incoming note JSON and branch accordingly.
 N I,J,TXTARR,ADMIN,CONSULT,ALWNOTE,RESULTS,CNT
 N COSIGNER,HDR,NCNT
 S CNT=0
 S I=0 F  S I=$O(DATA("notes",I)) Q:+I=0  D
 . S ADMIN=$G(DATA("notes",I,"adminId"))
 . S COSIGNER=$G(DATA("notes",I,"cosigner"))
 . I +ADMIN=0 D SETERROR^YTQRUTL(404,"Admin not sent: "_ADMIN) Q
 . I '$D(^YTT(601.84,ADMIN,0)) D SETERROR^YTQRUTL(404,"Admin not found: "_ADMIN) Q
 . K RESULTS
 . I '$D(DATA("notes",I,"text"))!($G(DATA("notes",I,"text"))="null") D GETNOTE(ADMIN,COSIGNER,.RESULTS)  ;No text passed in, generate from VistA MH REPORT template
 . I $D(DATA("notes",I,"text")),(DATA("notes",I,"text")'="null") D  ;PE/SE and note body sent
 .. S NCNT=0
 .. I $G(YSTYPE)="PE" D  ;PE needs patient header added
 ... D BLDHDR^YTQRCDB4(.HDR,ADMIN,79)
 ... S J=0 F  S J=$O(HDR(J)) Q:J=""  D
 .... S NCNT=NCNT+1,RESULTS("text","\",NCNT)=HDR(J)
 .. S J=0 F  S J=$O(DATA("notes",I,"text",J)) Q:J=""  D
 ... S NCNT=NCNT+1,RESULTS("text","\",NCNT)=DATA("notes",I,"text",J)
 . I $G(RESULTS("text"))="null" Q
 . ;Now text is normalized in RESULTS whether sent in or generated through VistA.
 . I CNT'=0 D
 .. S CNT=CNT+1,$P(TXTARR(CNT),"_",75)="" ;Add Note Divider
 . S J=0 F  S J=$O(RESULTS("text","\",J)) Q:J=""  D  ;RESULTS format back into sequential TXTARR array
 .. S CNT=CNT+1,TXTARR(CNT)=RESULTS("text","\",J)
 ;At this point all Cloud generated and VistA generated PNOTE text in TXTARR
 M TXT=TXTARR
 Q
GETNOTE(ADMIN,COSIGNER,RESULTS) ; build note object based on ARGS("adminId")
 I '$D(^YTT(601.84,ADMIN,0)) D SETERROR^YTQRUTL(404,"Admin not found: "_ADMIN) QUIT
 N CONSULT S CONSULT=$P(^YTT(601.84,ADMIN,0),U,15)
 S RESULTS("adminId")=ADMIN
 S RESULTS("consultId")=$S(+CONSULT:CONSULT,1:"null")
 S RESULTS("allowNote")=$$ALWNOTE^YTQRQAD3(ADMIN)
 S RESULTS("requireCosigner")=$$REQCSGN^YTQRQAD3(ADMIN)
 S RESULTS("cosigner")=$S(COSIGNER'="":COSIGNER,1:"null")
 I RESULTS("allowNote")="true" D REPORT1^YTQRQAD3(ADMIN,.RESULTS,"NOTE") I 1  ;ADMIN=Administration IEN, RESULTS array for report, NOTE=PROGRESS NOTE
 E  S RESULTS("text")="null"
 D SPLTADM^YTQRCAT(ADMIN) ; separate out the admins if CAT
 Q
SETNOTE(ARGS,DATA) ; save note in DATA("text") using ARGS("adminId")
 ;Expects DATA to be in the format returned from BLDRPT^YTQRRPT
 ;All instrument progress notes should be in DATA("text"), even for multiple instrument assignments
 N YS,YSDATA,ADMIN,CONSULT,WRP,ASGN,LSTASGN,PNOT,AGPROG
 S ADMIN=$G(DATA("adminId"))
 S ASGN=$G(DATA("assignmentId"))
 I ADMIN="" D SETERROR^YTQRUTL(404,"Admin not sent: "_ADMIN) QUIT ""
 I '$D(^YTT(601.84,ADMIN,0)) D SETERROR^YTQRUTL(404,"Admin not found: "_ADMIN) QUIT ""
 S CONSULT=$P(^YTT(601.84,ADMIN,0),U,15)
 S PNOT=0
 I '$D(^YTT(601.84,ADMIN,0)) D SETERROR^YTQRUTL(404,"Admin not found: "_ADMIN) QUIT ""
 D TXT2LN(.DATA,.YS) ; parse by CRLF and set YS(#) to note text
 D WRAP(.YS,79)  ;reformat lines to 79 max chars
 S YS("AD")=ADMIN
 I $G(DATA("cosigner"))]"" S YS("COSIGNER")=DATA("cosigner")
 I CONSULT S YS("CON")=CONSULT D CCREATE^YTQCONS(.YSDATA,.YS) I 1
 E  D PCREATE^YTQTIU(.YSDATA,.YS)
 I YSDATA(1)'="[DATA]" D SETERROR^YTQRUTL(500,"Note not saved") Q ""
 N ADMCNT,YSADD,ADMLST
 S ADMCNT=0 F  S ADMCNT=$O(DATA("adminList",ADMCNT)) Q:ADMCNT=""  D
 . S YSADD=DATA("adminList",ADMCNT) Q:+YSADD=0  ;safety 
 . I $$ALWNOTE^YTQRQAD3(YSADD)="true" S $P(^YTT(601.84,YSADD,0),U,18)=1  ;PROGRESS NOTE GENERATED
 Q "/api/mha/cdb/instrument/note/"_$G(YSDATA(2))
 ;
TXT2LN(SRC,DEST) ; Move CRLF delimited text from .SRC into WP lines in .DEST
 N IDEST,CRLF,REMAIN
 S IDEST=0,CRLF=$C(10)
 S REMAIN=$$PARSLN(SRC("text"))
 I '$D(SRC("text","\",1)),$L(REMAIN) D  QUIT  ; done since no continue nodes
 . S IDEST=IDEST+1,DEST(IDEST)=REMAIN
 N J                                          ; handle continue nodes
 S J=0 F  S J=$O(SRC("text","\",J)) Q:'J  D
 . S REMAIN=$$PARSLN(REMAIN_SRC("text","\",J))
 I $L(REMAIN) S IDEST=IDEST+1,DEST(IDEST)=REMAIN
 Q
PARSLN(TXT) ; Return remainder after parsing text into lines
 ; expects: CRLF, DEST, IDEST
 N X S X=TXT
 I '$L(X) Q ""
 ; Break lines by CRLF. Depending on source line delim could be $c(13) or $c(13,10). CRLF=$c(10) so $TR $c(13) in case it is embedded
 F  S IDEST=IDEST+1,DEST(IDEST)=$P(X,CRLF),X=$P(X,CRLF,2,99999),DEST(IDEST)=$TR(DEST(IDEST),$C(13)) Q:X'[CRLF
 Q $TR(X,$C(13))
WRAP(OUT,MAX) ; Wrap text by space piece word MAX char width
 N TMP,STR,II,JJ,PCE,CNT
 I +$G(MAX)=0 S MAX=79
 M TMP=OUT Q:'$D(TMP)
 K OUT
 S (CNT,II)=0 F  S II=$O(TMP(II)) Q:II=""  D
 . S STR="" F JJ=1:1:$L(TMP(II)," ") D
 .. S PCE=$P(TMP(II)," ",JJ)
 .. I $L(STR_PCE_" ")>MAX D  Q
 ... S CNT=CNT+1,OUT(CNT)=$E(STR,1,$L(STR)-1),STR=PCE_" "
 .. S STR=STR_PCE_" "
 . I STR]"" S CNT=CNT+1,OUT(CNT)=$E(STR,1,$L(STR)-1)
 Q
 ;

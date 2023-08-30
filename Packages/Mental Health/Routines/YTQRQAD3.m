YTQRQAD3 ;SLC/KCM - RESTful Calls to set/get MHA administrations ; 1/25/2017
 ;;5.01;MENTAL HEALTH;**130,141,158,178,182,181,187,199,207,202,204,208**;Dec 30, 1994;Build 23
 ;
 ; Reference to ^VA(200) in ICR #10060
 ; Reference to DIQ in ICR #2056
 ; Reference to TIUCNSLT in ICR #5546
 ; Reference to TIUPUTU in ICR #3351
 ; Reference to TIUSRVA in ICR #5541
 ; Reference to XLFSTR in ICR #10104
 ;
REPORT(ARGS,RESULTS) ; build report object identified by ARGS("adminId")
 N ADMIN S ADMIN=+$G(ARGS("adminId"))
 I '$D(^YTT(601.84,ADMIN,0)) D SETERROR^YTQRUTL(404,"Admin not found: "_ADMIN) QUIT
 S RESULTS("adminId")=ADMIN
 D REPORT1(ADMIN,.RESULTS)
 Q
REPORT1(ADMIN,REPORT,TYPE) ; fill in the report text for ADMIN
 N I,REPORT,COMMS,II,CRLF,BCNT,BARR
 N RM
 S RM=79
 I $G(TYPE)'="NOTE" S RM=512
 S CRLF=$C(10)
 D BLDRPT^YTQRRPT(.REPORT,ADMIN,RM)
 S BCNT=0 K BARR
 S I=0 F  S I=$O(REPORT(I)) Q:+I=0  D
 . I $TR(REPORT(I)," ")'="" D  Q 
 .. S BCNT=0
 . S BCNT=BCNT+1
 . I BCNT>2 S BARR(I)=""
 I $D(BARR) D
 . S I="" F  S I=$O(BARR(I)) Q:I=""  D
 .. K REPORT(I)
 S RESULTS("text")=$G(REPORT(1))_CRLF
 D WRAPTLT^YTQRRPT(.REPORT,RM)  ;Added existing call so web Note display matches CPRS - WYSIWYG
 S I=1 F  S I=$O(REPORT(I)) Q:'I  S RESULTS("text","\",I-1)=REPORT(I)_CRLF
 D GETCOM(.COMMS,ADMIN)
 I $G(TYPE)'="NOTE",$D(COMMS) D
 . S I=$O(RESULTS("text","\",""),-1) I I="" S I=0
 . S I=I+1,RESULTS("text","\",I)="---Comments----------------------------------------------------------------"_CRLF  ;Add separator
 . S II="" F  S II=$O(COMMS(II)) Q:II=""  D
 .. S I=I+1,RESULTS("text","\",I)=COMMS(II)_CRLF
 Q
GETCOM(ARR,ADMIN) ;Get the COMMENTS from the Instrument Admin
 N WPARR,TMPAR,DELIM,YSIEN,II,JJ,CNT,STR,WRD
 S YSIEN=ADMIN_","
 S II=$$GET1^DIQ(601.84,YSIEN,10,,"WPARR")
 Q:II=""
 S CNT=0,STR=""
 S II=0 F  S II=$O(WPARR(II)) Q:II=""  D  ;Break up and put back together text by ~
 . I WPARR(II)'["~" S STR=STR_WPARR(II) Q
 . S STR=STR_$P(WPARR(II),"~"),CNT=CNT+1,TMPAR(CNT)=STR
 . F JJ=2:1:$L(WPARR(II),"~")-1  D
 .. S CNT=CNT+1,TMPAR(CNT)=$P(WPARR(II),"~",JJ)
 . S STR=$P(WPARR(II),"~",$L(WPARR(II),"~"))
 I STR]"" S CNT=CNT+1,TMPAR(CNT)=STR
 I TMPAR(CNT)="" K TMPAR(CNT)  ;remove trailing blank line if null
 M ARR=TMPAR
 Q
GETNOTE(ARGS,RESULTS) ; build note object based on ARGS("adminId")
 N ADMIN S ADMIN=$G(ARGS("adminId"))
 I ADMIN="" D SETERROR^YTQRUTL(404,"Admin not sent: "_ADMIN) QUIT
 I '$D(^YTT(601.84,ADMIN,0)) D SETERROR^YTQRUTL(404,"Admin not found: "_ADMIN) QUIT
 N CONSULT S CONSULT=$P(^YTT(601.84,ADMIN,0),U,15)
 S RESULTS("adminId")=ADMIN
 S RESULTS("consultId")=$S(+CONSULT:CONSULT,1:"null")
 S RESULTS("allowNote")=$$ALWNOTE(ADMIN)
 S RESULTS("requireCosigner")=$$REQCSGN(ADMIN)
 S RESULTS("cosigner")="null"
 I RESULTS("allowNote")="true" D REPORT1(ADMIN,.RESULTS,"NOTE") I 1
 E  S RESULTS("text")="null"
 D SPLTADM^YTQRCAT(ADMIN) ; separate out the admins if CAT
 Q
SETNOTE(ARGS,DATA) ; save note in DATA("text") using ARGS("adminId")
 ;Expects DATA to be in the format returned from BLDRPT^YTQRRPT - The RPC most likely does not do that.
 N YS,YSDATA,ADMIN,CONSULT,WRP,ASGN,LSTASGN,PNOT,AGPROG
 S ADMIN=$G(DATA("adminId"))
 S LSTASGN=$G(DATA("lastAssignment"))
 S ASGN=$G(DATA("assignmentId"))
 S AGPROG=$D(^XTMP("YTQASMT-SET-"_ASGN,2))
 I ADMIN="" D SETERROR^YTQRUTL(404,"Admin not sent: "_ADMIN) QUIT ""
 I '$D(^YTT(601.84,ADMIN,0)) D SETERROR^YTQRUTL(404,"Admin not found: "_ADMIN) QUIT ""
 S CONSULT=$P(^YTT(601.84,ADMIN,0),U,15)
 S PNOT=0
 I $$ALWNOTE(ADMIN)'="true" D  QUIT "/api/mha/instrument/note/"_PNOT
 . ;This is Restricted Instrument, check if lastAssignment=Yes and there is something in the aggregate progress note.
 . I +ASGN'=0,(LSTASGN="Yes"),AGPROG S PNOT=$$FILPNOT^YTQRQAD8(ASGN,ADMIN,CONSULT,.DATA,.YS)
 I '$D(^YTT(601.84,ADMIN,0)) D SETERROR^YTQRUTL(404,"Admin not found: "_ADMIN) QUIT ""
 D TXT2LN(.DATA,.YS) ; parse by CRLF and set YS(#) to note text
 D WRAP(.YS,79)  ;reformat lines to 79 max chars
 S YS("AD")=ADMIN
 ;D WRAPTLT^YTQRRPT(.YS,79)  ;Reformat lines in case user edited progress note
 I +$G(DATA("cosigner")) D  I $G(YTQRERRS) QUIT "/api/mha/instrument/note/0"
 . N YSCSGN S YSCSGN=DATA("cosigner")
 . S YS("COSIGNER")=YSCSGN
 . I $$REQCSGN(ADMIN,YSCSGN)="true" D  ; cosigner can't require cosigner
 . . S YSCSGN=$$GET1^DIQ(200,YSCSGN_",",.01)
 . . D SETERROR^YTQRUTL(403,YSCSGN_" not allowed to cosign.")
 ;assignmentID sent in, lastAssignment=Yes/No, $D of aggregate Progress Note
 I +ASGN'=0,(LSTASGN'="Yes") D SAVPNOT^YTQRQAD8(ASGN,ADMIN,CONSULT,$G(DATA("cosigner")),.YS) Q "/api/mha/instrument/note/1"  ;Dummy 1 instead of Note IEN
 I +ASGN'=0,(LSTASGN="Yes"),AGPROG S PNOT=$$FILPNOT^YTQRQAD8(ASGN,ADMIN,CONSULT,.DATA,.YS) Q "/api/mha/instrument/note/"_PNOT
 ;Either assignmentId not sent (older version of GUI) or single instrument=no aggregate progress note, file individual instrument progress note
 I CONSULT S YS("CON")=CONSULT D CCREATE^YTQCONS(.YSDATA,.YS) I 1
 E  D PCREATE^YTQTIU(.YSDATA,.YS)
 I YSDATA(1)'="[DATA]" D SETERROR^YTQRUTL(500,"Note not saved") Q ""
 Q "/api/mha/instrument/note/"_$G(YSDATA(2))
 ;
ALWNOTE(ADMIN) ; return "true" if note could/should be saved
 N TEST
 S TEST=$P(^YTT(601.84,ADMIN,0),U,3) Q:'TEST "false" ; missing test
 Q $$ALWN2(TEST,ADMIN)
 ;
ALWN2(TEST,ADMIN) ;Entry point if TEST is input
 ;ADMIN - If specific ADMIN is to be checked
 N TITLE,CONSULT,Y,YSISC,YSTITLE
 S ADMIN=+$G(ADMIN)
 I $L($P($G(^YTT(601.71,TEST,2)),U)) Q "false"       ; R PRIVILEGE
 I $P($G(^YTT(601.71,TEST,8)),U,8)'="Y" Q "false"    ; gen note
 S CONSULT=""
 I ADMIN'=0 S CONSULT=$P(^YTT(601.84,ADMIN,0),U,15)
 I CONSULT D  I 1
 . S YSTITLE=$$GET1^DIQ(601.71,TEST_",",30,"E")
 . S Y=$$WHATITLE^TIUPUTU(YSTITLE)
 . D ISCNSLT^TIUCNSLT(.YSISC,+Y)
 . I 'YSISC S YSTITLE="MHA CONSULT"
 E  S YSTITLE=$$GET1^DIQ(601.71,TEST_",",29,"E")
 I $$WHATITLE^TIUPUTU(YSTITLE)'>0 Q "false"          ; bad note title
 Q "true"
 ;
NOTE4PT(ADMIN,DATA) ; save progress note text in assignment for a patient-entered admin
 N CONSULT,YS,YSDATA,COSIGNER,ASMT,LSTASMT
 D BLDRPT^YTQRRPT(.YS,ADMIN,79)
 I $$ALWNOTE(ADMIN)'="true" QUIT
 S COSIGNER=$G(DATA("cosigner"))
 S CONSULT=$G(DATA("consult")) I CONSULT="" S CONSULT=$P(^YTT(601.84,ADMIN,0),U,15)
 S ASMT=+$G(DATA("assignmentId"))
 S LSTASMT=$G(DATA("lastAssignment"))
 D SPLTADM^YTQRCAT(ADMIN) ; separate out the admins if CAT
 ;S CONSULT=$P(^YTT(601.84,ADMIN,0),U,15)
 S YS("AD")=ADMIN
 S:COSIGNER]"" YS("COSIGNER")=COSIGNER
 ;Entry predicated on LSTASMT'=Yes. Therefore=No if updated PE, null if old PE.
 ;If LSTASMT=null, file progress note immediately
 I ASMT'=0,(LSTASMT="No") D SAVPNOT^YTQRQAD8(ASMT,ADMIN,CONSULT,COSIGNER,.YS) Q  ;Save in aggregate progress note XTMP instead
 ; If ASMT=0, file directly for backwards compatibility
 I CONSULT S YS("CON")=CONSULT D CCREATE^YTQCONS(.YSDATA,.YS) I 1
 E  D PCREATE^YTQTIU(.YSDATA,.YS)
 I YSDATA(1)'="[DATA]" D SETERROR^YTQRUTL(500,"Note not saved") Q
 Q
ALWCSGN(ARGS,RESULTS) ; GET /api/mha/permission/cosign/:adminId/:userId
 N ADMIN,COSIGNER,NEEDCSGN
 S ADMIN=$G(ARGS("adminId"))
 S COSIGNER=$G(ARGS("userId"))
 S NEEDCSGN=$$REQCSGN(ADMIN,COSIGNER)
 S RESULTS("userId")=COSIGNER
 S RESULTS("allowedToCosign")=$S(NEEDCSGN="true":"false",1:"true")
 Q
REQCSGN(ADMIN,COSIGNER) ; return "true" if this user requires a cosigner
 ; if cosigner is passed in, use that instead of orderedBy
 N TEST,YSCREQ,YSTITLE,YSPERSON,X0
 S X0=$G(^YTT(601.84,ADMIN,0))
 S YSPERSON=$G(COSIGNER,$P(X0,U,6)) ; either cosigner or orderedBy
 S TEST=$P(X0,U,3),CONSULT=$P(X0,U,15)
 ; TODO:  account for the MHA CONSULT title
 S YSTITLE=$S(CONSULT:$P($G(^YTT(601.71,TEST,8)),U,10),1:$P($G(^YTT(601.71,TEST,8)),U,9))
 D REQCOS^TIUSRVA(.YSCREQ,YSTITLE,"",YSPERSON,"")
 Q $S(YSCREQ:"true",1:"false")
 ;
NEEDCSGN(ARGS,RESULTS) ; GET /api/mha/permission/needcosign/:userId  208
 ; Returns "true" if userId requires a cosigner
 ; Returns "false" if userId does NOT require a cosigner
 N YSPERSON,YSTITLE,YSCREQ,INSTS,TEST,II,CONSULT,YSCREQ,CSLIST,INAM,CFLG
 S INSTS=$G(ARGS("instrumentList"))
 S YSPERSON=$G(ARGS("userId"))
 S CFLG="false"
 I INSTS="" D  Q
 . S YSTITLE=$$TITLE^YTQRQAD7()
 . D REQCOS^TIUSRVA(.YSCREQ,YSTITLE,"",YSPERSON,"")
 . S RESULTS("userId")=YSPERSON
 . S RESULTS("needCosigner")=$S(YSCREQ:"true",1:"false")
 . Q
 ;I INSTS="" D SETERROR^YTQRUTL(404,"Instrument List not sent. ") QUIT
 S CONSULT=$S($G(ARGS("consult"))]"":1,1:"")
 S CFLG="false"
 F II=1:1:$L(INSTS,",") D
 . S INAM=$P(INSTS,",",II) Q:INAM=""
 . S TEST=$O(^YTT(601.71,"B",INAM,"")) Q:+TEST=0
 . S YSTITLE=$S(CONSULT:$P($G(^YTT(601.71,TEST,8)),U,10),1:$P($G(^YTT(601.71,TEST,8)),U,9))
 . Q:YSTITLE=""
 . K YSCREQ
 . D REQCOS^TIUSRVA(.YSCREQ,YSTITLE,"",YSPERSON,"")
 . S CSLIST=$S($G(YSCREQ)=1:"true",1:"false")
 . I CSLIST="true" S CFLG="true"
 . S RESULTS("instrumentList",II,"instName")=INAM
 . S RESULTS("instrumentList",II,"needCosign")=CSLIST
 K RESULTS  ;
 S RESULTS("userId")=YSPERSON
 S RESULTS("needCosigner")=CFLG
 Q
 ;
SETCOM(ARGS,DATA) ; save comment in Instrument Admin (F601.84,f10) using ARGS("adminId")
 ;Expects DATA to contain individual lines of text for the comment. Need to retrieve existing and prepend new lines
 N YS,YSDATA,ADMIN,CONSULT,WRP
 N YSIEN,YSF,YSERR,N,YSFILEN,YSWP,STR,II,CNT,YSNOW,YST
 K ^TMP("YSMHI",$J)
 S ADMIN=$G(DATA("adminId"))
 I ADMIN="" D SETERROR^YTQRUTL(404,"Admin not sent: "_ADMIN) QUIT ""
 I '$D(^YTT(601.84,ADMIN,0)) D SETERROR^YTQRUTL(404,"Admin not found: "_ADMIN) QUIT ""
 D TXT2LN(.DATA,.YS) ; parse by CRLF and set YS(#) to note text
 D WRAP(.YS,79)  ;reformat lines to 79 max chars
 S YSNOW=$$HTE^XLFDT($H,"5ZP"),YSNOW=$$UP^XLFSTR(YSNOW)
 S YST="0"_$P(YSNOW," ",2,99),YST=$E(YST,$L(YST)-11,$L(YST)),YSNOW=$P(YSNOW," ")_" "_YST
 S N=0 F  S N=$O(YS(N)) Q:N=""  D
 . S YS(N)=YS(N)_"~"
 S STR="***  Comment Entered By:  "_$P($G(^VA(200,DUZ,0)),U)_"  Comment Date:  "_YSNOW_"~~",CNT=0
 S N=0 F  S N=$O(YS(N)) Q:N=""  D
 . F II=1:1:$L(YS(N)) D
 .. S STR=STR_$E(YS(N),II) I $L(STR)>198 S CNT=CNT+1,^TMP("YSMHI",$J,CNT)=STR,STR=""
 I STR]"" S CNT=CNT+1,^TMP("YSMHI",$J,CNT)=STR
 S YSIEN=ADMIN_","
 S YSFILEN=601.84
 S YSF=10
 ;==GET EXISTING COMMENT TEXT==
 D GET1^DIQ(YSFILEN,YSIEN,YSF,,"YSWP","YSERR")
 I '$D(YSERR) D
 . S N=0 F  S N=$O(YSWP(N)) Q:N=""  D
 .. S CNT=CNT+1,^TMP("YSMHI",$J,CNT)=YSWP(N)
 D WP^DIE(YSFILEN,YSIEN,YSF,,"^TMP(""YSMHI"",$J)","YSERR")
 K ^TMP("YSMHI",$J)
 I $D(YSERR) D SETERROR^YTQRUTL(500,"Comment not saved") Q "/api/mha/instrument/comment/Error saving comment" Q
 Q "/api/mha/instrument/comment/OK"
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

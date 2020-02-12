YTQRQAD3 ;SLC/KCM - RESTful Calls to set/get MHA administrations ; 1/25/2017
 ;;5.01;MENTAL HEALTH;**130**;Dec 30, 1994;Build 62
 ;
 ; External Reference    ICR#
 ; ------------------   -----
 ; ^VA(200)             10060
 ; DIQ                   2056
 ; TIUCNSLT              5546
 ; TIUPUTU               3351
 ; TIUSRVA               5541
 ;
REPORT(ARGS,RESULTS) ; build report object identifed by ARGS("adminId")
 N ADMIN S ADMIN=+$G(ARGS("adminId"))
 I '$D(^YTT(601.84,ADMIN,0)) D SETERROR^YTQRUTL(404,"Admin not found: "_ADMIN) QUIT
 S RESULTS("adminId")=ADMIN
 D REPORT1(ADMIN,.RESULTS)
 Q
REPORT1(ADMIN,REPORT) ; fill in the report text for ADMIN
 N I,REPORT
 D BLDRPT^YTQRRPT(.REPORT,ADMIN)
 S RESULTS("text")=$G(REPORT(1))_$C(13,10)
 S I=1 F  S I=$O(REPORT(I)) Q:'I  S RESULTS("text","\",I-1)=REPORT(I)_$C(13,10)
 Q
GETNOTE(ARGS,RESULTS) ; build note object based on ARGS("adminId")
 N ADMIN S ADMIN=$G(ARGS("adminId"))
 I '$D(^YTT(601.84,ADMIN,0)) D SETERROR^YTQRUTL(404,"Admin not found: "_ADMIN) QUIT
 N CONSULT S CONSULT=$P(^YTT(601.84,ADMIN,0),U,13)
 S RESULTS("adminId")=ADMIN
 S RESULTS("consultId")=$S(+CONSULT:CONSULT,1:"null")
 S RESULTS("allowNote")=$$ALWNOTE(ADMIN)
 S RESULTS("requireCosigner")=$$REQCSGN(ADMIN)
 S RESULTS("cosigner")="null"
 I RESULTS("allowNote")="true" D REPORT1(ADMIN,.RESULTS) I 1
 E  S RESULTS("text")="null"
 Q
SETNOTE(ARGS,DATA) ; save note in DATA("text") using ARGS("adminId")
 N YS,YSDATA,ADMIN,CONSULT
 S ADMIN=$G(DATA("adminId"))
 S CONSULT=$P(^YTT(601.84,ADMIN,0),U,13)
 I '$D(^YTT(601.84,ADMIN,0)) D SETERROR^YTQRUTL(404,"Admin not found: "_ADMIN) QUIT ""
 D TXT2LN(.DATA,.YS) ; parse by CRLF and set YS(#) to note text
 S YS("AD")=ADMIN
 I +$G(DATA("cosigner")) D  I $G(YTQRERRS) QUIT ""
 . N YSCSGN S YSCSGN=DATA("cosigner")
 . S YS("COSIGNER")=YSCSGN
 . I $$REQCSGN(ADMIN,YSCSGN)="true" D  ; cosigner can't require cosigner
 . . S YSCSGN=$$GET1^DIQ(200,YSCSGN_",",.01)
 . . D SETERROR^YTQRUTL(500,YSCSGN_" not allowed to cosign.")
 I CONSULT S YS("CON")=CONSULT D CCREATE^YTQCONS(.YSDATA,.YS) I 1
 E  D PCREATE^YTQTIU(.YSDATA,.YS)
 I YSDATA(1)'="[DATA]" D SETERROR^YTQRUTL(500,"Note not saved") Q ""
 Q "/api/mha/instrument/note/"_$G(YSDATA(2))
 ;
ALWNOTE(ADMIN) ; return "true" if note could/should be saved
 N TEST,TITLE,CONSULT,Y,YSISC,YSTITLE
 S TEST=$P(^YTT(601.84,ADMIN,0),U,3) Q:'TEST "false" ; missing test
 I $L($P($G(^YTT(601.71,TEST,2)),U)) Q "false"       ; R PRIVILEGE
 I $P($G(^YTT(601.71,TEST,8)),U,8)'="Y" Q "false"    ; gen note
 S CONSULT=$P(^YTT(601.84,ADMIN,0),U,13)
 I CONSULT D  I 1
 . S YSTITLE=$$GET1^DIQ(601.71,TEST_",",30,"E")
 . S Y=$$WHATITLE^TIUPUTU(YSTITLE)
 . D ISCNSLT^TIUCNSLT(.YSISC,+Y)
 . I 'YSISC S YSTITLE="MHA CONSULT"
 E  S YSTITLE=$$GET1^DIQ(601.71,TEST_",",29,"E")
 I $$WHATITLE^TIUPUTU(YSTITLE)'>0 Q "false"          ; bad note title
 Q "true"
 ;
NOTE4PT(ADMIN) ; create a progress note for a patient-entered admin
 N CONSULT,YS,YSDATA
 I $$ALWNOTE(ADMIN)'="true" QUIT
 D BLDRPT^YTQRRPT(.YS,ADMIN,79)
 S CONSULT=$P(^YTT(601.84,ADMIN,0),U,13)
 S YS("AD")=ADMIN
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
 S TEST=$P(X0,U,3),CONSULT=$P(X0,U,13)
 ; TODO:  account for the MHA CONSULT title
 S YSTITLE=$S(CONSULT:$P($G(^YTT(601.71,TEST,8)),U,10),1:$P($G(^YTT(601.71,TEST,8)),U,9))
 D REQCOS^TIUSRVA(.YSCREQ,YSTITLE,"",YSPERSON,"")
 Q $S(YSCREQ:"true",1:"false")
 ;
TXT2LN(SRC,DEST) ; Move CRLF delimited text from .SRC into WP lines in .DEST
 N IDEST,CRLF,REMAIN
 S IDEST=0,CRLF=$C(13,10)
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
 F  S IDEST=IDEST+1,DEST(IDEST)=$P(X,CRLF),X=$P(X,CRLF,2,99999) Q:X'[CRLF
 Q X
 ;

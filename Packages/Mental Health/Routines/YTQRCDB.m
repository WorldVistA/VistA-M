YTQRCDB ;BAL/KTL - MHA CLOUD DATABASE ADMIN RPC CALLS; 1/25/2017
 ;;5.01;MENTAL HEALTH;**239,224,249,250,236**;Dec 30, 1994;Build 25
 ;
 ;
 ; Reference to FILE^DIE in ICR #2053
 ; Reference to XLFSTR in ICR #19194
 ;
 Q
SAVEADM(ARGS,DATA) ; Save instrument administration and answers
 N YSARR,ADMM,ANSRES,SCRRES,TEST,YSLG
 S TEST=$G(DATA("name")) I TEST="" D SETERROR^YTQRUTL(404,"Missing Test") Q "/api/mha/cdb/instrument/admin/"_0
 S DATA("instrumentId")=$O(^YTT(601.71,"B",TEST,0))
 I DATA("instrumentId")="" S DATA("instrumentId")=$O(^YTT(601.71,"B",$TR(TEST,"_"," "),0))
 I DATA("instrumentId")="" D SETERROR^YTQRUTL(404,"Test not found") Q "/api/mha/cdb/instrument/admin/"_0
 S ADMM=$$FILADMIN(.DATA)  ; Passed in ADMIN ID for previously scored, New ADMIN ID, 0=Error
 I ADMM=0 Q "/api/mha/cdb/instrument/admin/"_ADMM
 S ANSRES=$$FILANS(ADMM,.DATA)
 I ANSRES<1 D SETERROR^YTQRUTL(500,"Error Filing Answers") Q "/api/mha/cdb/instrument/admin/"_0
 S YSLG=$$GET1^DIQ(601.71,DATA("instrumentId")_",",23)
 I YSLG="Yes" K ^TMP($J) Q "/api/mha/cdb/instrument/admin/"_ADMM  ; Don't score legacy instruments
 S SCRRES=-1 I ADMM'=0 S SCRRES=$$SAVESCR(ADMM,.DATA)
 I SCRRES<0 D SETERROR^YTQRUTL(400,"Error Filing Score")
 K ^TMP($J)  ;Clean up result setup
 Q "/api/mha/cdb/instrument/admin/"_ADMM
 ;
SCORADM(ARGS,DATA) ;Score administration
 ;Used when scoring algorithm for this instrument not yet implemented in cloud app
 N DATAOUT,ERRARY,JSONOUT,SCORES,I
 N YSID,YSNAM,YSRAW,YSTSC,CNT,YSTSC2,YSTSC3
 K ^TMP("YTQ-JSON",$J),YTQRRSLT
 K ^TMP($J) N YS
 S YS("CODE")=$G(DATA("name"))
 D SCALEG^YTQAPI3(.YSDATA,.YS)  ;Check if there are any scales for this instrument
 I '$D(^TMP($J,"YSG",2)) D  Q "/api/mha/cdb/instrument/admin/scores/NOSCORE"
 . S ^TMP("YTQ-JSON",$J,1,0)="{}",YTQRRSLT=$NA(^TMP("YTQ-JSON",$J))
 . K ^TMP($J)
 K ^TMP($J)
 D SCOREIT(.DATA,.SCORES)
 I '$D(SCORES)!$D(SCORES("error")) D   Q "/api/mha/cdb/instrument/admin/scores/NOTOK"
 . D SETERROR^YTQRUTL(500,"Error Scoring Answers")
 . S ^TMP("YTQ-JSON",$J,1,0)="ERROR",YTQRRSLT=$NA(^TMP("YTQ-JSON",$J))
 S CNT=1,^TMP("YTQ-JSON",$J,CNT,0)="{""results"":["
 S I=0 F  S I=$O(SCORES(I)) Q:I=""  D
 . S YSID=$G(SCORES(I,"id"))
 . S YSNAM=$G(SCORES(I,"name"))
 . S YSRAW=$G(SCORES(I,"raw"))
 . S YSTSC=$G(SCORES(I,"tscore"))
 . S YSTSC2=$G(SCORES(I,"tscore2"))
 . S YSTSC3=$G(SCORES(I,"tscore3"))
 . I YSRAW'="",(+YSRAW'=YSRAW) S YSRAW=""""_YSRAW_""""  ;String result
 . I YSRAW="" S YSRAW="null"
 . I YSTSC'="",(+YSTSC'=YSTSC) S YSTSC=""""_YSTSC_""""  ;String result
 . I YSTSC="",$D(SCORES(I,"tscore")) S YSTSC="null"  ;Must exist but be null, otherwise don't send tscore at all
 . I YSTSC2'="",(+YSTSC2'=YSTSC2) S YSTSC2=""""_YSTSC2_""""  ;String result
 . I YSTSC2="",$D(SCORES(I,"tscore2")) S YSTSC2="null"
 . I YSTSC3'="",(+YSTSC3'=YSTSC3) S YSTSC3=""""_YSTSC3_""""  ;String result
 . I YSTSC3="",$D(SCORES(I,"tscore3")) S YSTSC3="null"
 . S CNT=CNT+1,^TMP("YTQ-JSON",$J,CNT,0)="{""id"":"_YSID_", ""name"":"""_YSNAM_""", ""raw"":"_YSRAW_$S(YSTSC]"":", ""tscore"":"_YSTSC,1:"")_$S(YSTSC2]"":", ""tscore2"":"_YSTSC2,1:"")_$S(YSTSC3]"":", ""tscore3"":"_YSTSC3,1:"")_"},"
 S ^TMP("YTQ-JSON",$J,CNT,0)=$E(^TMP("YTQ-JSON",$J,CNT,0),1,$L(^TMP("YTQ-JSON",$J,CNT,0))-1)
 S CNT=CNT+1,^TMP("YTQ-JSON",$J,CNT,0)="]}"
 S YTQRRSLT=$NA(^TMP("YTQ-JSON",$J))
 Q "/api/mha/cdb/instrument/admin/scores/OK"
 ;
SAVESCR(ADMM,DATA)  ;Save scores for admin for instruments scored in cloud app and passed in
 ;  ADMM = ADMINID
 ;  DATA = ARRAY OF RESULTS
 N RARR,I,YS,YSID,YSNAM,YSRAW,YSTSC,YSTSC2,YSTSC3
 N SCL,SCLID,RMISS,SCRRES
 S SCRRES=1  ;Default OK
 N YS
 K ^TMP($J,"YSG")
 S YS("CODE")=$G(DATA("name"))
 D SCALEG^YTQAPI3(.YSDATA,.YS)  ;Check if there are any scales for this instrument
 I $D(^TMP($J,"YSG",2)),'$D(DATA("results")) S SCRRES=-1 Q SCRRES  ;Scales exist but no RESULT data sent
 I '$D(^TMP($J,"YSG",2)),'$D(DATA("results")) Q SCRRES  ;No scales for instrument no RESULTs, OK.
 ; Sort results by Scale ID for Instrument Scale definition order matching
 S I=0 F  S I=$O(DATA("results",I)) Q:+I=0  D
 . S YSID=$G(DATA("results",I,"scaleId"))
 . S YSNAM=$G(DATA("results",I,"scaleName"))
 . S YSRAW=$G(DATA("results",I,"rawScore"))
 . S YSTSC=$G(DATA("results",I,"tscore"))
 . S YSTSC2=$G(DATA("results",I,"tscore2"))
 . S YSTSC3=$G(DATA("results",I,"tscore3"))
 . I $$UP^XLFSTR(YSRAW)="NULL" S YSRAW=""
 . I $$UP^XLFSTR(YSTSC)="NULL" S YSTSC=""
 . I $$UP^XLFSTR(YSTSC2)="NULL" S YSTSC2=""
 . I $$UP^XLFSTR(YSTSC3)="NULL" S YSTSC3=""
 . Q:+YSID=0
 . S RARR(YSID)=YSNAM_"="_YSRAW
 . I YSTSC]"" S RARR(YSID)=RARR(YSID)_U_YSTSC
 . I YSTSC2]"" S $P(RARR(YSID),U,3)=YSTSC2
 . I YSTSC3]"" S $P(RARR(YSID),U,4)=YSTSC3
 S YS("CODE")=$G(DATA("name"))
 K ^TMP($J,"YSCOR")
 S ^TMP($J,"YSCOR",1)="[DATA]"
 S RMISS=0
 S I=1 F  S I=$O(^TMP($J,"YSG",I)) Q:+I=0!(RMISS'=0)  D
 . S SCL=^TMP($J,"YSG",I),SCLID=$P($P(SCL,"=",2),U),SCL=$P($P(SCL,"="),"Scale",2)
 . Q:+SCL=0!(+SCLID=0)
 . I '$D(RARR(SCLID)) S RMISS=1 Q  ;Result Missing
 . S ^TMP($J,"YSCOR",SCL+1)=$G(RARR(SCLID))
 I RMISS=1 S SCRRES=-1 Q SCRRES
 K YS S YS("AD")=$G(ADMM)
 D UPDSCORE^YTSCORE(.YSDATA,.YS)
 Q SCRRES
 ;
FILADMIN(DATA)  ;Get YSARR and file mh administration
 ; Expects required MH ADMINISTRATION fields in DATA(prop)
 ; Expects answers in the DATA("answers",i,"id"/"value") array
 N ANSWERS
 N I,ACNT,VAL,ADMIN
 I '$D(DATA("answers")) D SETERROR^YTQRUTL(404,"Missing Answers") Q 0
 I '$D(DATA("patientId")) D SETERROR^YTQRUTL(404,"Missing patient id") Q 0
 I '$D(DATA("orderedById")) D SETERROR^YTQRUTL(404,"Missing ordering clinician") Q 0
 I '$D(DATA("locationId")) D SETERROR^YTQRUTL(404,"Missing location") Q 0
 S DATA("source")=$G(DATA("source")) I DATA("source")="" S DATA("source")="mhaweb"
 I '$D(DATA("administeredById")) S DATA("administeredById")=$G(DUZ)
 I '$D(DATA("completedDate")) S DATA("completedDate")=$$NOW^XLFDT()
 I '$D(DATA("dateSaved")) S DATA("dateSaved")=$$NOW^XLFDT()
 I '$D(DATA("dateGiven")) S DATA("dateGiven")=$$NOW^XLFDT()
 S DATA("complete")="YES"  ;Always Y?
 S (I,ACNT)=0 F  S I=$O(DATA("answers",I)) Q:I=""  D
 . S VAL=$G(DATA("answers",I,"value"))
 . I VAL="null" S DATA("answers",I,"value")="c1155" Q
 . I VAL[1156!(VAL[1157) Q
 . S ACNT=ACNT+1
 S DATA("numAns")=ACNT
 S ADMIN=$$SETADM(.DATA)
 Q ADMIN
 ;
RVW(ARGS,DATA) ; update admin REVIEWED status
 ; Requires input
 ; DATA("adminId")
 ;
 N YS,ADMIN,YTERR,YSORD,YSCMPLT,YSOK,YSMESS,N0
 S YSMESS="",YSOK=""
 S ADMIN=+$G(DATA("adminId"))
 I DATA("adminId")="" S YSMESS="Administration not sent."
 I '$D(^YTT(601.84,ADMIN))="" S YSMESS="Administration not found."
 S N0=$G(^YTT(601.84,ADMIN,0)),YSORD=$P(N0,U,6),YSCMPLT=$P(N0,U,9)
 I $G(DUZ)=YSORD S YSOK=1  ;,($$REQCSGN^YTQRQAD3(ADMIN)="false")
 S YS(601.84,ADMIN_",",19)=YSOK
 D FILE^DIE("","YS","YTERR")
 S YSOK=$S(YSOK=1:"SUCCESS",1:"FAIL")
 I $D(YTERR) S YSMESS="Unable to update admin",YSOK="FAIL"
 ;I YSDATA(1)'="[DATA]" D SETERROR^YTQRUTL(500,"Unable to update admin") Q 0
 Q "/api/mha/cdb/instrument/admin/reviewed/"_YSOK_U_YSMESS  ; otherwise we're updating existing admin
 ;
SETADM(DATA) ; return the id for new/updated admin
 ; Requires input
 ; DATA("patientId")
 ; DATA("orderedById")
 ; DATA("administeredById")
 ; DATA("completedDate")
 ; DATA("dateSaved")
 ; DATA("dateGiven")
 ; DATA("instrumentId")
 ; Optional
 ; DATA("adminId") - if updating existing admin
 ; DATA("cosignerId")
 N YSDATA,YS,ADMIN
 S ADMIN=+$G(DATA("adminId"))
 S YS("FILEN")=601.84
 I ADMIN S YS("IEN")=ADMIN I 1
 E  S YS(1)=".01^NEW^1"
 S YS(2)="1^`"_DATA("patientId")
 S YS(3)="2^`"_DATA("instrumentId")
 S YS(4)="3^"_DATA("dateGiven")
 S YS(5)="4^NOW"
 S YS(6)="5^`"_DATA("orderedById")
 S YS(7)="6^`"_DATA("administeredById")
 S YS(8)="7^N"
 S YS(9)="8^"_DATA("complete")
 S YS(10)="9^"_DATA("numAns")
 S YS(11)="13^`"_DATA("locationId")
 I '$L($G(DATA("source"))) S DATA("source")="web"
 S YS(12)="15^"_DATA("source")
 I +$G(DATA("consultId"))'=0 S YS(13)="17^"_DATA("consultId")
 D ADMSAVE^YTQAPI1(.YSDATA,.YS)
 I YSDATA(1)'="[DATA]" D SETERROR^YTQRUTL(500,"Unable to create admin") Q 0
 I 'ADMIN Q $P(YSDATA(2),U,2)  ; create new admin, ien found in 2nd piece
 Q ADMIN                       ; otherwise we're updating existing admin
 ;
FILANS(ADMIN,DATA) ; File Answers for an ADMIN
 ; Requires:  ADMIN = IEN of MH ADMINISTRATION
 ;            DATA("answers",i,"id"/"value")
 N ARSL
 I +$G(ADMIN)=0 D SETERROR^YTQRUTL(404,"Missing ADMIN ID") Q 0
 I '$D(^YTT(601.84,ADMIN)) D SETERROR^YTQRUTL(404,"Invalid ADMIN ID") Q -1
 I '$D(DATA("answers")) D SETERROR^YTQRUTL(404,"Missing Answers") Q -2
 S ARSL=$$QASAVE(ADMIN,.DATA)
 Q ARSL
 ;
QASAVE(ADMIN,DATA) ; save questions and answers in DATA
 ; loop through DATA to create ANS array, then YSDATA array
 ; ANS(#)=questionId^choiceId    <-- radio group question
 ; ANS(#,#)=wp value             <-- all others
 ; Return:    1 = Success
 ;            0 = Failure
 N I,QNUM,QANS,QID,VAL,ANS,RT1
 S QNUM=0,QANS=0
 S I=0 F  S I=$O(DATA("answers",I)) Q:'I  D
 . S QID=DATA("answers",I,"id")
 . S VAL=DATA("answers",I,"value")
 . QUIT:$E(QID)'="q"   ; skip intros, sections
 . S QNUM=QNUM+1       ; QNUM is sequence w/o intros
 . S QID=$E(QID,2,999) ; remove the "q"
 . I VAL="null" S ANS(QNUM)=QID_U_"NOT ASKED" QUIT
 . ; QANS is number answered, don't include skipped (1155 or 1157)
 . I '((VAL="c1155")!(VAL="c1157")) S QANS=QANS+1
 . S RT1=0             ; response type 1 is choice question
 . I VAL="c1155"!(VAL="c1156")!(VAL="c1157") S RT1=1
 . I $P($G(^YTT(601.72,QID,2)),U,2)=1 S RT1=1
 . I RT1 S ANS(QNUM)=QID_U_$E(VAL,2,999) QUIT
 . S ANS(QNUM)=QID D TXT2ANS(I,QNUM) ; handle longer WP values
 K DATA("answers") ; now in ANS array (which may be large)
 ; save the answers
 N YSDATA
 S ANS("AD")=ADMIN
 D SAVEALL^YTQAPI17(.YSDATA,.ANS)
 I YSDATA(1)'="[DATA]" D SETERROR^YTQRUTL(500,"Answers not saved") Q 0
 Q 1
TXT2ANS(IDX,QNUM) ; Convert web to ANS format for DATA(IDX)
 ; expects DATA,ANS
 N LEN,LN,NODE,J
 S LEN=240,LN=0
 S NODE=DATA("answers",IDX,"value")
 D ADDSEGS(NODE)
 I $D(DATA("answers",IDX,"value","\")) D
 . F J=1:1 Q:'$D(DATA("answers",IDX,"value","\",J))  D
 . . S NODE=DATA("answers",IDX,"value","\",J)
 . . D ADDSEGS(NODE)
 Q
ADDSEGS(NODE) ; split text in node into LEN segments with "|" for newlines
 ; expects DATA,ANS,LEN,LN
 N I,X,END,FIRST,LAST
 S END=$L(NODE),LAST=0 F I=0:1 D  Q:LAST>END   ; iterate thru each segment
 . S FIRST=(I*LEN)+1,LAST=(I*LEN)+LEN,LN=LN+1  ; set first&last char positions
 . S X=$TR($E(NODE,FIRST,LAST),$C(10),"|")     ; set segment, chg newline to |
 . S ANS(QNUM,LN)=X
 Q
 ;
SCOREIT(DATA,SCORES) ; Score instrument based on incoming answers.
 ; Expects DATA("test")=TEST NAME
 ; Expects answers in the DATA("answers",i,"id"/"value") array
 N TEST,ANSWERS,YSLG
 I '$D(N) N N S N=0  ;Initialize for reports if needed.
 S TEST=$G(DATA("name")) I TEST="" D SETERROR^YTQRUTL(404,"Missing Test") Q
 S DATA("instrumentId")=$O(^YTT(601.71,"B",TEST,0))
 I DATA("instrumentId")="" S DATA("instrumentId")=$O(^YTT(601.71,"B",$TR(TEST,"_"," "),0))
 I DATA("instrumentId")="" D SETERROR^YTQRUTL(404,"Test not found") Q
 I '$D(DATA("answers")) D SETERROR^YTQRUTL(404,"Missing Answers") Q
 S YSLG=$$GET1^DIQ(601.71,DATA("instrumentId")_",",23)
 I YSLG="Yes" D LGSCORE(.DATA,.SCORES) Q  ;-->out Score legacy answers in 601.85
 M ANSWERS=DATA("answers")
 D CALC^YTSCOREX(TEST,.ANSWERS,.SCORES)
 Q
LGSCORE(DATA,SCORES) ;
 ; 
 N TESTNM,ADFN,AUSER,ANSWERS
 I '$D(DATA("patientId")) D SETERROR^YTQRUTL(404,"Missing patient id") Q
 S TESTNM=$G(DATA("name"))
 S ADFN=DATA("patientId")
 S AUSER=$G(DATA("orderedById")) S:'AUSER AUSER=DUZ
 M ANSWERS=DATA("answers")
 D LEGACY^YTSCOREX(TESTNM,ADFN,AUSER,.ANSWERS,.SCORES)
 Q

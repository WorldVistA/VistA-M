YTQRQAD2 ;SLC/KCM - RESTful Calls to set/get MHA administrations ;Oct 31, 2024@13:37:11
 ;;5.01;MENTAL HEALTH;**130,141,173,178,182,181,199,202,204,208,233,223,234,238,250,236**;Dec 30, 1994;Build 25
 ;
SAVEADM(ARGS,DATA) ; save answers and return /ys/mha/admin/{adminId}
 I $G(DATA("assignmentId"))?36ANP G POSTADM^YTQRCRW
 N ADMIN
 S ADMIN=$$QASAVE(.DATA) QUIT:'ADMIN ""  ; create admin & answer records
 ;
 ; create a note if this was patient-entered
 N ASMT,CPLT,PTENT,LSTASMT,PNOT,AGPROG,TMPYS
 N YSCERR
 S ASMT=DATA("assignmentId")
 S LSTASMT=$G(DATA("lastAssignment"))
 S CPLT=$S(DATA("complete")="true":"Y",1:"N")
 S YSCERR=""
 I CPLT="Y" D  ;Score instrument results up front in MHA
 . N YS,YSDATA
 . K ^TMP($J,"YSCOR")
 . S YS("AD")=ADMIN
 . D SCORSAVE^YTQAPI11(.YSDATA,.YS)
 . ; check and return any errors from SCORSAVE
 . I $G(^TMP($J,"YSCOR",1))'="[DATA]" S YSCERR=$G(^TMP($J,"YSCOR",2))
 S PTENT=($G(^XTMP("YTQASMT-SET-"_ASMT,1,"entryMode"))="patient")
 I (CPLT="Y"),PTENT,(LSTASMT'="Yes") D NOTE4PT^YTQRQAD3(ADMIN,.DATA)
 ;
 ; update the assignment with adminId, remove completed admins/assignments
 N I,NOD,REMAIN
 S NOD="YTQASMT-SET-"_ASMT,REMAIN=0
 S I=0 F  S I=$O(^XTMP(NOD,1,"instruments",I)) Q:'I  D
 . I ^XTMP(NOD,1,"instruments",I,"id")=DATA("instrumentId") D  QUIT
 . . ; remove instrument if complete and staff-entered
 . . I 'PTENT,(CPLT="Y") K ^XTMP(NOD,1,"instruments",I) QUIT
 . . ;I CPLT="Y" K ^XTMP(NOD,1,"instruments",I) QUIT  ; patient-entered (may need to keep)
 . . S ^XTMP(NOD,1,"instruments",I,"adminId")=ADMIN
 . . S ^XTMP(NOD,1,"instruments",I,"complete")=DATA("complete")
 . . I CPLT'="Y" S REMAIN=1
 . I $G(^XTMP(NOD,1,"instruments",I,"complete"))'="true" S REMAIN=1
 I PTENT,(LSTASMT="Yes"),(CPLT="Y") D
 . I $$ALWNOTE^YTQRQAD3(ADMIN)="true" D BLDRPT^YTQRRPT(.TMPYS,ADMIN,79)
 . D SPLTADM^YTQRCAT(ADMIN) ; separate out the admins if CAT
 S AGPROG=$D(^XTMP(NOD,2))
 ;I LSTASMT="Yes",AGPROG S PNOT=$$FILPNOT^YTQRQAD8(ASMT,"","","",.TMPYS)
 ;Last instrument=Yes and either saved aggregate progress note or TMPYS from current PE instrument.
 I LSTASMT="Yes",(AGPROG!$D(TMPYS)) S PNOT=$$FILPNOT^YTQRQAD8(ASMT,ADMIN,"","",.TMPYS)
 ;Check for consolidated progress note node 2. If exists, ASMT deleted in YTQRQAD8
 I 'REMAIN,'$D(^XTMP(NOD,2)),$D(^XTMP(NOD,0)) D DELASMT1^YTQRQAD1(ASMT)
 I YSCERR'=""  ;need to format return with error message of result save.
 Q "/api/mha/instrument/admin/"_ADMIN ; was erroneously /ys/mha/admin/
 ;
QASAVE(DATA) ; save questions and answers in DATA
 ; loop through DATA to create ANS array, then YSDATA array
 ; ANS(#)=questionId^choiceId    <-- radio group question
 ; ANS(#,#)=wp value             <-- all others
 N I,QNUM,QANS,QID,VAL,ANS,RT1,ADMIN
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
 ; save admin itself
 S ADMIN=$$SETADM(.DATA,QANS)
 Q:'ADMIN ""
 ; save the answers
 N YSDATA
 S ANS("AD")=ADMIN
 D SAVEALL^YTQAPI17(.YSDATA,.ANS)
 I YSDATA(1)'="[DATA]" D SETERROR^YTQRUTL(500,"Answers not saved") Q ""
 Q ADMIN
 ;
SETADM(DATA,NUM) ; return the id for new/updated admin
 N YSDATA,YS,NODE,ADMIN,ADMINDT,ASMTID,YSERR
 S ASMTID=DATA("assignmentId")
 S NODE=$S(ASMTID?36ANP:"YTQCPRS-",1:"YTQASMT-SET-")_ASMTID
 S ADMIN=+$G(DATA("adminId"))
 I '$D(^XTMP(NODE)) D  QUIT 0
 . S YSERR="Unable to create admin."
 . I ADMIN,$P($G(^YTT(601.84,ADMIN,0)),U,9)="Y" S YSERR=YSERR_" Admin was already saved." I 1
 . E  S YSERR=YSERR_" (Scratch assignment was missing)."
 . D SETERROR^YTQRUTL(500,YSERR)
 I 'ADMIN S ADMIN=$$ADM4ASMT(NODE,DATA("instrumentId")) ; auto-save fix
 ;Admin Date added so user can select previous date, time is arbitrary based on current MHA standard
 S ADMINDT=$G(^XTMP(NODE,1,"adminDate")) I ADMINDT]"" S ADMINDT=$$ETFM(ADMINDT) S:ADMINDT ADMINDT=ADMINDT_"."_$P($$NOW^XLFDT(),".",2)
 S YS("FILEN")=601.84
 I ADMIN S YS("IEN")=ADMIN I 1
 E  S YS(1)=".01^NEW^1"
 S YS(2)="1^`"_$G(^XTMP(NODE,1,"patient","dfn"))
 S YS(3)="2^`"_DATA("instrumentId")
 S YS(4)="3^"_$S(ADMINDT]"":ADMINDT,1:$G(^XTMP(NODE,1,"date")))
 ;S YS(4)="3^"_$G(^XTMP(NODE,1,"date"))
 S YS(5)="4^NOW"
 S YS(6)="5^`"_$G(^XTMP(NODE,1,"orderedBy"))
 S YS(7)="6^`"_$G(^XTMP(NODE,1,"interview"))
 S YS(8)="7^N"
 S YS(9)="8^"_$S(DATA("complete")="true":"YES",1:"NO")
 S YS(10)="9^"_NUM
 S YS(11)="13^`"_$G(^XTMP(NODE,1,"location"))
 I '$L($G(DATA("source"))) S DATA("source")="web"
 S YS(12)="15^"_DATA("source")
 I $D(^XTMP(NODE,1,"consult")),($G(^XTMP(NODE,1,"consult"))]"") S YS(13)="17^"_^XTMP(NODE,1,"consult")
 D ADMSAVE^YTQAPI1(.YSDATA,.YS)
 I YSDATA(1)'="[DATA]" D SETERROR^YTQRUTL(500,"Unable to create admin") Q 0
 I 'ADMIN Q $P(YSDATA(2),U,2)  ; create new admin, ien found in 2nd piece
 Q ADMIN                       ; otherwise we're updating existing admin
 ;
ETFM(YSDT) ;External to FM
 ;YSDT = DATE in external
 N X,Y
 I YSDT["@" S YSDT=$P(YSDT,"@")
 S X=YSDT D ^%DT
 I Y<0 S Y=""  ;Invalid YSDT
 Q Y
ADM4ASMT(NODE,TESTID) ; return adminId if one has been saved for assignment
 N I,CURADM
 S CURADM=0
 S I=0 F  S I=$O(^XTMP(NODE,1,"instruments",I)) Q:'I  D  Q:CURADM
 . I $G(^XTMP(NODE,1,"instruments",I,"id"))'=TESTID Q
 . I $G(^XTMP(NODE,1,"instruments",I,"adminId"))>0 S CURADM=^XTMP(NODE,1,"instruments",I,"adminId")
 I $L(CURADM,"-")>0 S CURADM=0  ; only "real" admins, not UUID's
 Q CURADM
 ;
GETADM(ARGS,RESULTS) ; get answers for administration identified by ARGS("adminId")
 I '$L($G(ARGS("adminId"))) D SETERROR^YTQRUTL(404,"Missing admin parameter") Q
 I ARGS("adminId")?36ANP1"-".N G GETADM^YTQRCRW
 I $D(^YTT(601.84,ARGS("adminId")))<10 D  Q
 . D SETERROR^YTQRUTL(404,"Admin not found: "_ARGS("adminId"))
 ;
 N ADMIN,X0,TST,QID,ANS,CTNT,SEQ,TYP,VAL,TOT,NA,TMP,I,J,N,L
 S ADMIN=ARGS("adminId"),X0=^YTT(601.84,ADMIN,0),TST=$P(X0,U,3)
 S RESULTS("adminId")=ADMIN
 S RESULTS("complete")=$S($P(X0,U,9)="Y":"true",1:"false")
 S RESULTS("instrumentId")=TST
 ; iterate through answers to get values and sort by sequence
 S (TOT,NA)=0  ; total questions & not answered count
 S QID=0 F  S QID=$O(^YTT(601.85,"AC",ADMIN,QID)) Q:'QID  D
 . S CTNT=$O(^YTT(601.76,"AF",TST,QID,0))
 . S SEQ=$P($G(^YTT(601.76,+CTNT,0)),U,3) S:'SEQ SEQ=1
 . S TYP=+$P($G(^YTT(601.72,QID,2)),U,2)
 . S ANS=0 F  S ANS=$O(^YTT(601.85,"AC",ADMIN,QID,ANS)) Q:'ANS  D
 . . S VAL=$P(^YTT(601.85,ANS,0),U,4),TOT=TOT+1
 . . I VAL="NOT ASKED"!(VAL=1155)!(VAL=1157) S NA=NA+1  ; skipped=not answered
 . . I VAL="NOT ASKED" S TMP(+SEQ)=QID_U_"null" QUIT    ; not asked
 . . I VAL=1155!(VAL=1156)!(VAL=1157) S TYP=1           ; skipped values
 . . I TYP=1 S TMP(+SEQ)=QID_U_"c"_VAL QUIT             ; mult choice
 . . S VAL=$G(^YTT(601.85,ANS,1,1,0))                   ; integer, etc.
 . . I TYP'=5,(TYP'=11) S TMP(+SEQ)=QID_U_VAL QUIT
 . . S (N,L)=0 F  S N=$O(^YTT(601.85,ANS,1,N)) Q:'N  D  ; memo and checkbox fields
 . . . S VAL=$G(^YTT(601.85,ANS,1,N,0))
 . . . I '$D(TMP(+SEQ)) S TMP(+SEQ)=QID_U_$TR(VAL,"|",$C(10)) I 1
 . . . E  S L=L+1,TMP(+SEQ,L)=$TR(VAL,"|",$C(10))
 N CATPROG S CATPROG=$$CHKPROG^YTQRCAT(ADMIN)
 I CATPROG>-1 S RESULTS("progress")=CATPROG I 1
 E  S RESULTS("progress")=$S(TOT>0:$P((((TOT-NA)/TOT)*100)+.5,"."),1:0)
 ; now move sorted responses from TMP into "answers" nodes
 S I="",N=0 F  S I=$O(TMP(I)) Q:'$L(I)  S N=N+1 D
 . S RESULTS("answers",N,"id")="q"_$P(TMP(I),U)
 . S RESULTS("answers",N,"value")=$P(TMP(I),U,2,999)
 . I $D(TMP(I))>9 S J="",L=0 F  S J=$O(TMP(I,J)) Q:'$L(J)  S L=L+1 D
 . . S RESULTS("answers",N,"value","\",L)=TMP(I,J)
 Q
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
GETCHKS(ARGS,RESULTS) ; verify answer string & return check messages if needed
 ;ARGS("q6440")="c2420"      -- may be choice id
 ;ARGS("q6439")="08/07/2019" -- or literal
 S RESULTS("count")=0
 I ARGS("instrumentName")="BAM-C" D VERIFY^YTSBAMC(.ARGS,.RESULTS)
 I ARGS("instrumentName")="BAM-R" D VERIFY^YTSBAMR(.ARGS,.RESULTS)
 I ARGS("instrumentName")="BAM-IOP" D VERIFY^YTSBAMI(.ARGS,.RESULTS)
 I ARGS("instrumentName")="BAM-C-CBT-SUD" D VERIFY^YTSBAMCC(.ARGS,.RESULTS)
 I ARGS("instrumentName")="BAM-R-CSG-SUD" D VERIFY^YTSBAMRC(.ARGS,.RESULTS)
 I ARGS("instrumentName")="BAM-IOP-CSG-SUD" D VERIFY^YTSBAMIC(.ARGS,.RESULTS)
 I ARGS("instrumentName")="SODU" D VERIFY^YTSSODU(.ARGS,.RESULTS)
 Q

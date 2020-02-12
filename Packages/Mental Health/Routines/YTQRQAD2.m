YTQRQAD2 ;SLC/KCM - RESTful Calls to set/get MHA administrations ; 1/25/2017
 ;;5.01;MENTAL HEALTH;**130**;Dec 30, 1994;Build 62
 ;
SAVEADM(ARGS,DATA) ; save answers and return /ys/mha/admin/{adminId}
 ; loop through DATA to create ANS array, then YSDATA array
 ; ANS(#)=questionId^choiceId    <-- radio group question
 ; ANS(#,#)=wp value             <-- all others
 N I,QNUM,QANS,QID,VAL,ASMT,TEST,ADMIN,CPLT,ANS,PTENT,RT1
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
 ; save admin itself
 S ASMT=DATA("assignmentId")
 S TEST=DATA("instrumentId")
 S CPLT=$S(DATA("complete")="true":"Y",1:"N")
 S ADMIN=$$SETADM(ASMT,TEST,QANS,CPLT,+$G(DATA("adminId")))
 Q:'ADMIN ""
 ; save the answers
 N YSDATA
 S ANS("AD")=ADMIN
 D SAVEALL^YTQAPI17(.YSDATA,.ANS)
 I YSDATA(1)'="[DATA]" D SETERROR^YTQRUTL(500,"Answers not saved") Q ""
 ; create a note if this was patient-entered
 S PTENT=($G(^XTMP("YTQASMT-SET-"_ASMT,1,"entryMode"))="patient")
 I (CPLT="Y"),PTENT D NOTE4PT^YTQRQAD3(ADMIN)
 ; update the assignment with adminId, remove completed admins/assignments
 N NODE,REMAIN
 S NODE="YTQASMT-SET-"_ASMT,REMAIN=0
 S I=0 F  S I=$O(^XTMP(NODE,1,"instruments",I)) Q:'I  D
 . I ^XTMP(NODE,1,"instruments",I,"id")=TEST D  QUIT
 . . ; remove instrument if complete and staff-entered
 . . I 'PTENT,(CPLT="Y") K ^XTMP(NODE,1,"instruments",I) QUIT
 . . ;I CPLT="Y" K ^XTMP(NODE,1,"instruments",I) QUIT  ; patient-entered (may need to keep)
 . . S ^XTMP(NODE,1,"instruments",I,"adminId")=ADMIN
 . . S ^XTMP(NODE,1,"instruments",I,"complete")=DATA("complete")
 . . I CPLT'="Y" S REMAIN=1
 . I $G(^XTMP(NODE,1,"instruments",I,"complete"))'="true" S REMAIN=1
 I 'REMAIN D DELASMT1^YTQRQAD1(ASMT)
 Q "/ys/mha/admin/"_ADMIN
 ;
SETADM(ASMT,TEST,NUM,CPLT,ADMIN) ; return the id for new/updated admin
 N YSDATA,YS,NODE
 S NODE="YTQASMT-SET-"_ASMT
 S YS("FILEN")=601.84
 I ADMIN S YS("IEN")=ADMIN I 1
 E  S YS(1)=".01^NEW^1"
 S YS(2)="1^`"_$G(^XTMP(NODE,1,"patient","dfn"))
 S YS(3)="2^`"_TEST
 S YS(4)="3^"_$G(^XTMP(NODE,1,"date"))
 S YS(5)="4^NOW"
 S YS(6)="5^`"_$G(^XTMP(NODE,1,"orderedBy"))
 S YS(7)="6^`"_$G(^XTMP(NODE,1,"interview"))
 S YS(8)="7^N"
 S YS(9)="8^"_CPLT
 S YS(10)="9^"_NUM
 S YS(11)="13^`"_$G(^XTMP(NODE,1,"location"))
 ; TODO: add new field to admin file to hold consult
 ; I $G(^XTMP(NODE,1,"consult")) S YS(12)="15^`"_^XTMP(NODE,1,"consult")
 D EDAD^YTQAPI1(.YSDATA,.YS)
 I YSDATA(1)'="[DATA]" D SETERROR^YTQRUTL(500,"Unable to create admin") Q 0
 Q:'ADMIN $P(YSDATA(2),U,2) ; only non-null if new admin
 Q ADMIN
 ;
GETADM(ARGS,RESULTS) ; get answers for administration identified by ARGS("adminId")
 I '$G(ARGS("adminId")) D SETERROR^YTQRUTL(404,"Missing admin parameter") Q
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
 . . I TYP'=5 S TMP(+SEQ)=QID_U_VAL QUIT
 . . S (N,L)=0 F  S N=$O(^YTT(601.85,ANS,1,N)) Q:'N  D  ; memo fields
 . . . S VAL=$G(^YTT(601.85,ANS,1,N,0))
 . . . I '$D(TMP(+SEQ)) S TMP(+SEQ)=QID_U_$TR(VAL,"|",$C(10)) I 1
 . . . E  S L=L+1,TMP(+SEQ,L)=$TR(VAL,"|",$C(10))
 S RESULTS("progress")=$S(TOT>0:$P((((TOT-NA)/TOT)*100)+.5,"."),1:0)
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
 Q

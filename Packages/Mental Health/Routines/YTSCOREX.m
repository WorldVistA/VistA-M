YTSCOREX ;SLC/KCM - Score tests without admins ;Mar 04, 2025@09:06
 ;;5.01;MENTAL HEALTH;**223,224,236**;Dec 30, 1994;Build 25
 ;
CALC(TEST,ANSWERS,SCORES) ; Calculate and return .SCORES given ANSWERS
 ;  TEST=name or IEN of instrument
 ; .ANSWERS(n,"id")=questionId
 ; .ANSWERS(n,"value")=choiceId or integerValue
 ; .SCORES(n,"name")=scaleName
 ; .SCORES(n,"id")=scaleId
 ; .SCORES(n,"raw")=rawScore
 ; .SCORES(n,"tscore")=tScore
 ; .SCORES("error")=error message if defined
 ;
 N X,YS,YSDATA
 K ^TMP($J)
 I TEST'=+TEST S TEST=$O(^YTT(601.71,"B",TEST,0))
 I 'TEST S SCORES("error")="test not found" QUIT
 S YS("CODE")=$P($G(^YTT(601.71,TEST,0)),U)
 D SCALEG^YTQAPI3(.YSDATA,.YS)       ; get scales into ^TMP
 S X=$P($G(^YTT(601.71,TEST,9)),U,2) ; check scoring routine
 I X'="",(X'="YTSCORE") D COMPLEX(TEST,.ANSWERS,.SCORES) I 1
 E  D SUMKEY(TEST,.ANSWERS,.SCORES)
 Q
SUMKEY(TEST,ANSWERS,SCORES) ; score by summing scoring keys
 ; expects ^TMP($J,"YSG",n) to contain scale id's
 N I,J,ISCALE,NAME,RAW,QALIST
 D BYQSTN(.ANSWERS,.QALIST)
 S (I,J)=0 F  S I=$O(^TMP($J,"YSG",I)) Q:'I  D
 . I ^TMP($J,"YSG",I)'?1"Scale".E QUIT  ; only use "Scale#" nodes
 . S ISCALE=$P($P(^TMP($J,"YSG",I),"=",2),U)
 . S NAME=$P($P(^TMP($J,"YSG",I),"=",2),U,4)
 . S RAW=$$BYKEY(ISCALE,.QALIST)
 . S J=J+1,SCORES(J,"id")=ISCALE,SCORES(J,"name")=NAME,SCORES(J,"raw")=RAW
 Q
BYQSTN(ANSWERS,QALIST) ; return QALIST(questionId)=choiceText or value
 N I,QSTN,RTYP,VALUE
 S I=0 F  S I=$O(ANSWERS(I)) Q:'I  D
 . S QSTN=$G(ANSWERS(I,"id"))
 . S QSTN=$S($E(QSTN)="q":+$P(QSTN,"q",2),1:+QSTN)
 . QUIT:'QSTN
 . S RTYP=$P($G(^YTT(601.72,QSTN,2)),U,2)
 . S VALUE=$G(ANSWERS(I,"value"))
 . I RTYP=1,($E(VALUE)="c") S VALUE=+$P(VALUE,"c",2) ; MCHOICE
 . I RTYP'=1 S VALUE=";1^"_VALUE
 . S QALIST(QSTN)=VALUE
 Q
BYKEY(SCALE,QALIST) ; returns score based on scoring keys for SCALE
 ; .QALIST(questionId)=choiceId (with "q" and "c" removed)
 N SUM,KEY,X0,QSTN,TARGET,VALUE,CHOICE,TEXT
 S SUM=0
 S KEY=0 F  S KEY=$O(^YTT(601.91,"AC",SCALE,KEY)) Q:'KEY  D
 . S X0=^YTT(601.91,KEY,0)
 . S QSTN=$P(X0,U,3),CHOICE=$G(QALIST(QSTN)) QUIT:'CHOICE
 . S TARGET=$P(X0,U,4),VALUE=$P(X0,U,5)
 . S TEXT=$G(^YTT(601.75,CHOICE,1))
 . I TEXT=TARGET S SUM=SUM+VALUE
 Q SUM
 ;
COMPLEX(TEST,ANSWERS,SCORES) ; score by calling routine
 ; expects: ^TMP($J,"YSG",n) to contain scale id's
 ; expects: YS and YSDATA from CALC
 N YSRTN
 D MKYSDATA(TEST,.ANSWERS,.YSDATA) ; build YSDATA
 S YSRTN=$P($G(^YTT(601.71,TEST,9)),U,2)
 S YSRTN="DLLSTR^"_YSRTN_"(.YSDATA,.YS,1)"
 D @YSRTN  ; call complex scoring routine
 I '$D(^TMP($J,"YSCOR")) S SCORES("error")="Complex scoring failed" QUIT
 N I,X,NMLIST,SNAME,RAW,TSCORE,SEQ,ID,TSCORE2,TSCORE3
 D NSCALES(.NMLIST) ; create name lookup for scale sequence and id
 S I=1 F  S I=$O(^TMP($J,"YSCOR",I)) Q:'I  D  ; iterate named scores
 . S X=^TMP($J,"YSCOR",I)
 . S SNAME=$P(X,"="),RAW=$P($P(X,"=",2),U),TSCORE=$P($P(X,"=",2),U,2),TSCORE2=$P($P(X,"=",2),U,3),TSCORE3=$P($P(X,"=",2),U,4)
 . S SEQ=+$P(NMLIST(SNAME),U),ID=$P(NMLIST(SNAME),U,2)
 . S SCORES(SEQ,"name")=SNAME,SCORES(SEQ,"raw")=RAW,SCORES(SEQ,"id")=ID
 . I $L(TSCORE) S SCORES(SEQ,"tscore")=TSCORE
 . I $L(TSCORE2) S SCORES(SEQ,"tscore2")=TSCORE2
 . I $L(TSCORE3) S SCORES(SEQ,"tscore3")=TSCORE3
 Q
MKYSDATA(TEST,ANSWERS,YSDATA) ; Convert "tree" array of answers to YSDATA format
 N I,N,QSTN,CTNT,QSEQ,SSEQ,RTYP,CHOICE,VAL
 S YSDATA(1)="[DATA]",YSDATA(2)=U_TEST_U_$P($G(^YTT(601.71,TEST,0)),U)
 S N=2
 S I=0 F  S I=$O(ANSWERS(I)) Q:'I  D
 . S QSTN=$G(ANSWERS(I,"id")) QUIT:$E(QSTN)'="q"  ; skip intros, etc.
 . S QSTN=+$P(QSTN,"q",2) QUIT:'QSTN
 . S CTNT=$O(^YTT(601.76,"AE",QSTN,""))
 . S QSEQ=0 I CTNT S QSEQ=+$P(^YTT(601.76,CTNT,0),U,3)
 . S RTYP=$P($G(^YTT(601.72,QSTN,2)),U,2)
 . S VAL=$G(ANSWERS(I,"value")) I VAL="c1155"!(VAL="c1156")!(VAL="c1157") S RTYP=1
 . ; handle common MCHOICE questions
 . I RTYP=1 D  QUIT
 . . S CHOICE=$G(ANSWERS(I,"value"))
 . . I $E(CHOICE)="c" S CHOICE=+$P(CHOICE,"c",2)
 . . S N=N+1,YSDATA(N)=QSTN_U_QSEQ_U_CHOICE
 . ; handle long WP questions
 . I ($L($G(ANSWERS(I,"value")))>240)!$D(ANSWERS(I,"value","\")) D  QUIT
 . . N WPIN,WPOUT,J
 . . M WPIN=ANSWERS(I,"value")
 . . D SPLITWP(.WPIN,.WPOUT)
 . . S SSEQ=0,J=0 F  S J=$O(WPOUT(J)) Q:'J  D
 . . . S SSEQ=SSEQ+1,N=N+1,YSDATA(N)=QSTN_U_QSEQ_";"_SSEQ_U_WPOUT(J)
 . ; handle other values
 . S N=N+1,YSDATA(N)=QSTN_U_QSEQ_";1"_U_$G(ANSWERS(I,"value"))
 Q
NSCALES(NMLIST) ; build scale NMLIST(name)=sequence^scaleId
 ; expects: ^TMP($J,"YSG",n) from CALC
 N I,ID,NM,SEQ,X
 S SEQ=0
 S I=1 F  S I=$O(^TMP($J,"YSG",I)) Q:'I  D
 . S X=$G(^TMP($J,"YSG",I))
 . I $E(X,1,5)'="Scale" QUIT
 . S ID=+$P($P(X,"=",2),U)
 . S NM=$P(X,U,4)
 . I NM="" QUIT
 . S SEQ=SEQ+1
 . S NMLIST(NM)=SEQ_U_ID
 Q
SPLITWP(IN,OUT) ; split WP into 240 char segments and use | as newline
 N I
 D ADDSEGS(IN,.OUT)
 I $D(IN("\")) S I=0 F  S I=$O(IN("\",I)) Q:'I  D ADDSEGS(IN("\",I),.OUT)
 Q
ADDSEGS(LINE,OUT) ; add 240 char segment to OUT array
 ; See ADDSEGS^YTQRQAD2 for similar code.  This is a bit more general.
 N I,J,X,END,FIRST,LAST
 S J=+$O(OUT(""),-1)                           ; get # of last node
 S END=$L(LINE),LAST=0 F I=0:1 D  Q:LAST>END   ; iterate thru each segment
 . S FIRST=(I*240)+1,LAST=(I*240)+240          ; set first&last char positions
 . S X=$TR($E(LINE,FIRST,LAST),$C(10),"|")     ; set segment, chg newline to |
 . S J=J+1,OUT(J)=X                            ; add segment to OUT
 Q
LEGACY(TESTNM,ADFN,AUSER,ANSWERS,SCORES) ; return .SCORES for legacy test
 ; .ANSWERS(n,"id")=questionId
 ; .ANSWERS(n,"value")=choiceId or integerValue
 N YS,YSDATA,I,J,QSTN,RTYP,CHOICE,VALUE,VALSTR
 S YS("CODE")=TESTNM,YS("ADATE")=DT,YS("DFN")=ADFN,YS("STAFF")=AUSER
 S I=0,VALSTR="" F  S I=$O(ANSWERS(I)) Q:'I  D
 . S QSTN=$G(ANSWERS(I,"id"))
 . S QSTN=$S($E(QSTN)="q":+$P(QSTN,"q",2),1:+QSTN) QUIT:'QSTN
 . S RTYP=$P($G(^YTT(601.72,QSTN,2)),U,2)
 . I RTYP=1,($E(ANSWERS(I,"value"))="c") D
 . . S CHOICE=+$P(ANSWERS(I,"value"),"c",2)
 . . S VALUE=$P($G(^YTT(601.75,CHOICE,0)),U,2)
 . E  S VALUE=$G(ANSWERS(I,"value"))
 . S VALSTR=VALSTR_VALUE
 S YS("R1")=$E(VALSTR,1,200)
 S YS("R2")=$E(VALSTR,201,400)
 S YS("R3")=$E(VALSTR,401,600)
 ; The legacy algorithm below does this with 601.2:
 ; - save a backup copy in ^TMP of the day's data for the DFN
 ; - add this result set to 601.2 and call the scoring algorithm
 ; - generate the report for this administration
 ; - replace the day's data for the DFN in 601.2 with what was in ^TMP
 N CNT,INC,X,YSCODEN,YSET,ZTREQ
 D LEGCR^YTQAPI9(.YSDATA,.YS)
 ; Find the scores in the returned YSDATA beginning with line 5 and
 ; go until the report begins -- the link that says ^^PROGRESS NOTE^^
 S J=0,I=5 F  S I=$O(YSDATA(I)) Q:'I  Q:YSDATA(I)["^PROGRESS NOTE^"  D
 . I $E(YSDATA(I))="S" D
 . . S J=J+1
 . . S SCORES(J,"name")=$P(YSDATA(I),U,2)
 . . S SCORES(J,"id")=$P(YSDATA(I),U,3)
 . . S SCORES(J,"raw")=$P(YSDATA(I),U,4)
 . . S:$L($P(YSDATA(I),U,5)) SCORES(J,"tscore")=$P(YSDATA(I),U,5)
 Q
 ;
FULLANS(ANSWERS,QADISP) ; List out display values of questions/answers
 ; expects .ANSWERS(sequence,"id")="q1234"
 ;         .ANSWERS(sequence,"value")="c567"
 ; returns .QADISP(sequence,"qText")=questionText
 ;         .QADISP(sequence,"aText")=answerText
 N I,J,N,QSTN,QTXT,ATXT,CTXT,DELIM,RTYP
 S (I,N)=0 F  S I=$O(ANSWERS(I)) Q:'I  D
 . S QSTN=$G(ANSWERS(I,"id")) QUIT:$E(QSTN)'="q"  ; skip intros, etc.
 . S QSTN=+$P(QSTN,"q",2) QUIT:'QSTN
 . S QTXT="",ATXT=""
 . S J=0 F  S J=$O(^YTT(601.72,QSTN,1,J)) Q:'J  S QTXT=QTXT_$S($L(QTXT):" ",1:"")_^(J,0)
 . S CTXT=$O(^YTT(601.76,"AF",TEST,QSTN,0))
 . S DELIM=$P(^YTT(601.76,CTXT,0),U,5)        ; get delimiter for question text
 . S QTXT=DELIM_" "_QTXT
 . S RTYP=$P($G(^YTT(601.72,QSTN,2)),U,2)
 . I RTYP=1 S ATXT=$G(^YTT(601.75,+$P($G(ANSWERS(I,"value")),"c",2),1)) I 1
 . E  S ATXT=$TR($G(ANSWERS(I,"value")),$C(10),"|") ;ignore "\" nodes, too long
 . S N=N+1,QADISP(N,"qText")=QTXT,QADISP(N,"aText")=ATXT
 S QADISP("qCnt")=N
 Q
 ;
PARTANS(TEST,ANSWERS,QADISP) ; List out display values for designator/legacyValue
 ; expects .ANSWERS(sequence,"id")="q1234"
 ;         .ANSWERS(sequence,"value")="c567"
 ; returns .QADISP(sequence,"qText")=designator
 ;         .QADISP(sequence,"aText")=legacyValue
 N I,N,QSTN,QTXT,CTXT,ATXT,RTYP
 S (I,N)=0 F  S I=$O(ANSWERS(I)) Q:'I  D
 . S QSTN=$G(ANSWERS(I,"id")) QUIT:$E(QSTN)'="q"  ; skip intros, etc.
 . S QSTN=+$P(QSTN,"q",2) QUIT:'QSTN
 . S CTXT=$O(^YTT(601.76,"AF",TEST,QSTN,0))
 . S QTXT=$P(^YTT(601.76,CTXT,0),U,5)          ; delimiter as question text
 . S RTYP=$P($G(^YTT(601.72,QSTN,2)),U,2)
 . S ATXT=""
 . I RTYP=1 D
 . . N CID S CID=+$P($G(ANSWERS(I,"value")),"c",2)
 . . I 'CID!(CID=1155)!(CID=1156)!(CID=1157) S ATXT=" " I 1
 . . E  S ATXT=$P($G(^YTT(601.75,CID,0)),U,2)  ; legacy value as answer text
 . S N=N+1,QADISP(N,"qText")=QTXT,QADISP(N,"aText")=ATXT
 S QADISP("qCnt")=N
 Q
CPRSSTR(TEST,ANSWERS,SCORES) ; build string for CPRS DLL
 N I,TESTNM,CNT,STXT,QTXT,QADISP
 S TESTNM=$P(^YTT(601.71,TEST,0),U)
 ; write full answers if WRITE FULE TEXT (601.71:26) is Yes
 I $P(^YTT(601.71,TEST,8),U,6)="Y" D FULLANS(.ANSWERS,.QADISP) I 1
 E  D PARTANS(TEST,.ANSWERS,.QADISP)
 S CNT=0,STXT="",QTXT=""
 S I=0 F  S I=$O(SCORES(I)) Q:'I  D
 . S STXT=STXT_"*"_SCORES(I,"id")_"~"_SCORES(I,"raw")
 . I $L($G(SCORES(I,"tscore"))) S STXT=STXT_"~"_SCORES(I,"tscore")
 S I=0 F  S I=$O(QADISP(I)) Q:'I  D
 . S QTXT=QTXT_"*"_QADISP(I,"qText")_"~"_QADISP(I,"aText")
 Q "COMPLETE^"_TESTNM_U_QADISP("qCnt")_U_STXT_U_QTXT_U
 ;

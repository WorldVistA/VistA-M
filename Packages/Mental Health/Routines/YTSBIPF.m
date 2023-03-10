YTSBIPF ;SLC/KCM - Score B-IPF ; 10/14/18 2:02pm
 ;;5.01;MENTAL HEALTH;**177**;Dec 30, 1994;Build 6
 ;
DLLSTR(YSDATA,YS,YSTRNG) ; compute scores or report text based on YSTRNG
 ; input
 ;   YSDATA(2)=adminId^patientDFN^instrumentName^dateGiven^isComplete
 ;   YSDATA(2+n)=questionId^sequence^choiceId
 ;   YS("AD")=adminId
 ;   YSTRNG=1 for score, 2 for report
 ; output if YSTRNG=1: ^TMP($J,"YSCOR",n)=scaleId=score
 ; output if YSTRNG=2: append special "answers" to YSDATA
 ;
 I YSTRNG=1 D SCORESV
 I YSTRNG=2 D
 . N SCOREVAL,LEVEL,N
 . D LDSCORES^YTSCORE(.YSDATA,.YS) ; puts score into ^TMP($J,"YSCOR",2)
 . D REPORT(.SCOREVAL,.LEVEL)
 . S N=$O(YSDATA(""),-1) ; get last node
 . S YSDATA(N+1)="7771^9999;1^"_SCOREVAL
 . S YSDATA(N+2)="7772^9999;1^"_LEVEL
 Q
 ;
SCORESV ; calculate the score
 ; expects YSDATA from DLLSTR
 N YTI,YTRAW,YTCNT,YTCHC,SCORE
 S YTRAW=0,YTCNT=0
 S YTI=2 F  S YTI=$O(YSDATA(YTI)) Q:'YTI  D
 . S YTCHC=$P(YSDATA(YTI),U,3)
 . I YTCHC=5226!(YTCHC=1155)!(YTCHC=1156)!(YTCHC=1157) Q  ; N/A or skipped
 . S YTCNT=YTCNT+1
 . S YTRAW=YTRAW+$P(^YTT(601.75,YTCHC,0),U,2)
 ; score is (raw score / maximum given number answered) * 100
 S SCORE=$FN((YTRAW/(YTCNT*6))*100,"",0)
 ;
 ; set scores into ^TMP($J,"YSCOR",n)=scaleId=rawScore^tScore
 K ^TMP($J,"YSCOR")
 I $D(^TMP($J,"YSG",1)),^TMP($J,"YSG",1)="[ERROR]" D  Q  ;-->out
 . S ^TMP($J,"YSCOR",1)="[ERROR]"
 . S ^TMP($J,"YSCOR",2)="No Scale found for ADMIN"
 S ^TMP($J,"YSCOR",1)="[DATA]"
 S ^TMP($J,"YSCOR",2)=$P(^YTT(601.87,1395,0),U,4)_"="_SCORE
 Q
REPORT(VAL,LVL) ; build the scoring display for the report
 ; expects ^TMP($J,"YSCOR",...) and ^TMP($J,"YSG") from DLLSTR
 ;         YSDATA from DLLSTR
 S VAL=$P(^TMP($J,"YSCOR",2),"=",2),LVL=""
 I VAL<11 S LVL="No impairment" Q
 I VAL<31 S LVL="Mild impairment" Q
 I VAL<51 S LVL="Moderate impairment" Q
 I VAL<81 S LVL="Severe impairment" Q
 I VAL<101 S LVL="Extreme impairment" Q
 Q

YTSSBAFP ;SLC/KCM - Score SBAF-PTSD ; 3/25/22 2:02pm
 ;;5.01;MENTAL HEALTH;**218**;Dec 30, 1994;Build 9
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
 . N SCORES,N
 . D LDSCORES^YTSCORE(.YSDATA,.YS) ; puts score into ^TMP($J,"YSCOR",2)
 . D REPORT(.SCORES)
 . S N=$O(YSDATA(""),-1) ; get last node
 . S YSDATA(N+1)="7771^9999;1^"_SCORES
 Q
 ;
SCORESV ; calculate the score
 ; expects YSDATA from DLLSTR (YSDATA from LOADANSW^YTSCORE,SCALEG^YTQAPI3)
 N I,J,QSTN,CID,TOTAL
 S I=2 F  S I=$O(YSDATA(I)) Q:'I  D
 . S CID=$P(YSDATA(I),U,3)
 . I CID=1155!(CID=1156)!(CID=1157) Q  ; don't include skipped questions
 . S QSTN($P(YSDATA(I),U))=$P($G(^YTT(601.75,CID,0)),U,2)
 S TOTAL=$$SUM(.QSTN,"8905,8906,8907,8908,8909,8910,8911,8912,8913,8914")
 ;
 ; set scores into ^TMP($J,"YSCOR",n)=scaleName=score {rawScore^tScore}
 K ^TMP($J,"YSCOR")
 I $D(^TMP($J,"YSG",1)),^TMP($J,"YSG",1)="[ERROR]" D  Q  ;-->out
 . S ^TMP($J,"YSCOR",1)="[ERROR]"
 . S ^TMP($J,"YSCOR",2)="No Scale found for ADMIN"
 ;
 N SCLID,SCLNM
 S ^TMP($J,"YSCOR",1)="[DATA]"
 S I=2,J=1 F  S I=$O(^TMP($J,"YSG",I)) Q:'I  D
 . S SCLID=+$P(^TMP($J,"YSG",I),"=",2)
 . S SCLNM=$P(^TMP($J,"YSG",I),U,4)
 . S J=J+1
 . I SCLID=1473 S ^TMP($J,"YSCOR",J)=SCLNM_"="_TOTAL
 Q
SUM(QSTN,LIST) ; return sum for questions in LIST
 N I,QID,SKIPS,CNT,SUM,MEAN
 ; count the skipped questions & compute average selection
 ; (skipped questions are not in the QSTN array)
 S (CNT,MEAN,SKIPS)=0
 F I=1:1:$L(LIST,",") S QID=$P(LIST,",",I) D
 . I '$D(QSTN(QID))!($G(QSTN(QID))="") S SKIPS=SKIPS+1 QUIT
 . S CNT=CNT+1,MEAN=MEAN+QSTN(QID)
 I SKIPS>3 S SUM="" QUIT SUM  ; too many skips to score this scale
 S MEAN=MEAN/CNT
 ;
 ; sum the answered items, using the mean of answered questions
 ; to substitute for any skipped questions
 S SUM=0 F I=1:1:$L(LIST,",") S QID=$P(LIST,",",I) D  Q:SUM<0
 . I '$D(QSTN(QID))!($G(QSTN(QID))="") S SUM=SUM+MEAN QUIT
 . S SUM=SUM+QSTN(QID)
 Q $FN(SUM,"",0)              ; round raw score to nearest integer
 ;
 ;
REPORT(SCORES) ; build the scoring display for the report
 ; expects ^TMP($J,"YSCOR",...) and ^TMP($J,"YSG") from DLLSTR
 ;         YSDATA from DLLSTR
 N I,X,NAME,VALUE,PTSD
 S I=0 F  S I=$O(^TMP($J,"YSCOR",I)) Q:'I  D
 . S NAME=$P(^TMP($J,"YSCOR",I),"=")
 . S VALUE=$P(^TMP($J,"YSCOR",I),"=",2)
 . I NAME="PTSD" S PTSD=VALUE
 S X=""
 S X=X_"|                             Raw    Average"
 S X=X_"|                 PTSD Score: "_$$SCORTXT(PTSD,10)  ;$J(PTSD,3)_$$AVERAGE(PTSD,10)
 S SCORES=X
 Q
SCORTXT(SUM,N) ; return score string
 I SUM="" Q "No score due to skipped items"
 Q $J(SUM,3)_$$AVERAGE(SUM,N)
 ;
AVERAGE(SUM,N) ; return formatted average
 Q "    "_$J(SUM/N,5,2)
 ;

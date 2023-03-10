YTSEHS14 ;SLC/KCM - Score EHS-14 ; 3/25/22 2:02pm
 ;;5.01;MENTAL HEALTH;**202**;Dec 30, 1994;Build 47
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
 N I,J,QSTN,TOTAL,EMPWR,MOTIV,UTIL,GOAL
 S I=2 F  S I=$O(YSDATA(I)) Q:'I  D
 . S QSTN($P(YSDATA(I),U))=$P(YSDATA(I),U,3)
 S TOTAL=$$AVERAGE(.QSTN,8651,8664)  ; Total
 S EMPWR=$$AVERAGE(.QSTN,8651,8654)  ; Psychological Empowerment
 S MOTIV=$$AVERAGE(.QSTN,8655,8656)  ; Futuristic self-motivation
 S UTIL=$$AVERAGE(.QSTN,8657,8660)   ; Utilization of skills and resources
 S GOAL=$$AVERAGE(.QSTN,8661,8664)   ; Goal orientation
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
 . I SCLID=1425 S ^TMP($J,"YSCOR",J)=SCLNM_"="_TOTAL
 . I SCLID=1426 S ^TMP($J,"YSCOR",J)=SCLNM_"="_EMPWR
 . I SCLID=1427 S ^TMP($J,"YSCOR",J)=SCLNM_"="_MOTIV
 . I SCLID=1428 S ^TMP($J,"YSCOR",J)=SCLNM_"="_UTIL
 . I SCLID=1429 S ^TMP($J,"YSCOR",J)=SCLNM_"="_GOAL
 Q
AVERAGE(QSTN,FIRST,LAST) ;
 N QID,SUM,CNT
 S (SUM,CNT)=0
 F QID=FIRST:1:LAST D  Q:SUM<0
 . I '$D(QSTN(QID)) S SUM=-1 Q
 . S CNT=CNT+1,SUM=SUM+QSTN(QID)
 Q $S(SUM<0:-1,1:+$FN(SUM/CNT,"",2))
 ;
REPORT(SCORES) ; build the scoring display for the report
 ; expects ^TMP($J,"YSCOR",...) and ^TMP($J,"YSG") from DLLSTR
 ;         YSDATA from DLLSTR
 N I,X,NAME,VAL,TOTAL,EMPWR,MOTIV,UTIL,GOAL
 S I=0 F  S I=$O(^TMP($J,"YSCOR",I)) Q:'I  D
 . S NAME=$E($P(^TMP($J,"YSCOR",I),"="),1,5)
 . S VAL=$P(^TMP($J,"YSCOR",I),"=",2)
 . S VAL=$S(VAL<0:" Missing responses",1:$J(VAL,5,2))
 . I NAME="Total" S TOTAL=VAL
 . I NAME="Psych" S EMPWR=VAL
 . I NAME="Futur" S MOTIV=VAL
 . I NAME="Utili" S UTIL=VAL
 . I NAME="Goal " S GOAL=VAL
 S X=""
 S X=X_"|                  EHS-14 total score:"_TOTAL
 S X=X_"|           Psychological empowerment:"_EMPWR
 S X=X_"|          Futuristic self-motivation:"_MOTIV
 S X=X_"| Utilization of skills and resources:"_UTIL
 S X=X_"|                    Goal orientation:"_GOAL
 S SCORES=X
 Q

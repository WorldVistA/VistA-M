YTSWBS ;SLC/KCM - Score WBS ; 3/25/22 2:02pm
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
 N I,J,CHOICE,VALUE,TOTAL,COUNT,DECLINE,AVERAGE
 S (TOTAL,COUNT,DECLINE,AVERAGE)=0
 S I=2 F  S I=$O(YSDATA(I)) Q:'I  D
 . S CHOICE=$P(YSDATA(I),U,3)
 . I CHOICE=5261 S DECLINE=1 Q        ; declined
 . I CHOICE<5250!(CHOICE>5260) Q      ; bad choice value
 . S VALUE=+$P(^YTT(601.75,CHOICE,0),U,2)
 . S COUNT=COUNT+1,TOTAL=TOTAL+VALUE
 I COUNT=3 S AVERAGE=+$FN(TOTAL/3,"",2)
 I DECLINE S AVERAGE=""
 ;
 ; set scores into ^TMP($J,"YSCOR",n)=scaleName=score {rawScore^tScore}
 K ^TMP($J,"YSCOR")
 I $D(^TMP($J,"YSG",1)),(^TMP($J,"YSG",1)="[ERROR]") D  Q  ;-->out
 . S ^TMP($J,"YSCOR",1)="[ERROR]"
 . S ^TMP($J,"YSCOR",2)="No Scale found for ADMIN"
 I 'DECLINE,(COUNT'=3) D  Q                                ;-->out
 . S ^TMP($J,"YSCOR",1)="[ERROR]"
 . S ^TMP($J,"YSCOR",2)="Missing required questions"
 ;
 N SCLID,SCLNM
 S ^TMP($J,"YSCOR",1)="[DATA]"
 S I=2,J=1 F  S I=$O(^TMP($J,"YSG",I)) Q:'I  D
 . S SCLID=+$P(^TMP($J,"YSG",I),"=",2)
 . S SCLNM=$P(^TMP($J,"YSG",I),U,4)
 . S J=J+1
 . I SCLID=1442 S ^TMP($J,"YSCOR",J)=SCLNM_"="_AVERAGE
 Q
REPORT(SCORES) ; build the scoring display for the report
 ; expects ^TMP($J,"YSCOR",...) and ^TMP($J,"YSG") from DLLSTR
 ;         YSDATA from DLLSTR
 N I,X,NAME,VAL,TOTAL,EMPWR,MOTIV,UTIL,GOAL
 S I=0 F  S I=$O(^TMP($J,"YSCOR",I)) Q:'I  D
 . S NAME=$E($P(^TMP($J,"YSCOR",I),"="),1,5)
 . S VAL=$P(^TMP($J,"YSCOR",I),"=",2)
 . I NAME="Avera" S AVERAGE=$S(VAL="":"",1:$FN(VAL,"",2))
 S SCORES=$S(AVERAGE="":"Patient declined to answer",1:AVERAGE_"%")
 Q

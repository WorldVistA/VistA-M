YTSCIA ;SLC/KCM - Score CIA ; 3/25/22 2:02pm
 ;;5.01;MENTAL HEALTH;**217**;Dec 30, 1994;Build 12
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
 N I,J,QID,CID,QSTN,CNT,SUM,TOTAL
 S I=2 F  S I=$O(YSDATA(I)) Q:'I  D
 . S QID=$P(YSDATA(I),U),CID=$P(YSDATA(I),U,3)
 . I CID=1155!(CID=1156)!(CID=1157) Q  ; leave skipped questions undefined
 . S QSTN(QID)=$$GET1^DIQ(601.75,CID_",",4,"I")
 S QID=0,CNT=0,SUM=0
 F  S QID=$O(QSTN(QID)) Q:'QID  S CNT=CNT+1,SUM=SUM+QSTN(QID)
 I CNT<13 S TOTAL="" I 1              ; need at least 12 answered items
 E  S TOTAL=SUM+((16-CNT)*(SUM/CNT))  ; skipped get average of answered
 I TOTAL S TOTAL=$P(TOTAL+0.5,".")
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
 . I SCLID=1450 S ^TMP($J,"YSCOR",J)=SCLNM_"="_TOTAL
 Q
REPORT(SCORES) ; build the scoring display for the report
 ; expects ^TMP($J,"YSCOR",...) and ^TMP($J,"YSG") from DLLSTR
 ;         YSDATA from DLLSTR
 N I,NAME,VALUE,TOTAL
 S I=0 F  S I=$O(^TMP($J,"YSCOR",I)) Q:'I  D
 . S NAME=$E($P(^TMP($J,"YSCOR",I),"="),1,5)
 . S VALUE=$P(^TMP($J,"YSCOR",I),"=",2)
 . I VALUE="" S VALUE=" Too few items rated"
 . I NAME="Total" S TOTAL=VALUE
 S SCORES="| CIA Score: "_TOTAL
 Q

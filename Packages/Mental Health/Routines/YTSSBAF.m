YTSSBAF ;SLC/KCM - Score SBAF ; 3/25/22 2:02pm
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
 N I,J,QSTN,CID,ALL,TOTAL,VIGIL,GANX,SANX,PANIC,HANX,PTSD
 S I=2 F  S I=$O(YSDATA(I)) Q:'I  D
 . S CID=$P(YSDATA(I),U,3)
 . I CID=1155!(CID=1156)!(CID=1157) Q  ; don't include skipped questions
 . S QSTN($P(YSDATA(I),U))=$P($G(^YTT(601.75,CID,0)),U,2)
 S ALL="8864,8865,8866,8867,8868,8869,8870,8871,8872,8873,8874,8875,8876,8877,8878,8879,8880,8881,8882,8883,8884,"
 S ALL=ALL_"8885,8886,8887,8888,8889,8890,8891,8892,8893,8894,8895,8896,8897,8898,8899,8900,8901,8902,8903,8904"
 S TOTAL=$$SUM(.QSTN,ALL)
 S VIGIL=$$SUM(.QSTN,"8864,8865,8866,8867,8868,8869,8870,8871")
 S GANX=$$SUM(.QSTN,"8872,8873,8874,8875,8876,8877,8878")
 S SANX=$$SUM(.QSTN,"8879,8880,8881,8882,8883,8884,8885,8886,8887,8888,8889,8890,8891")
 S PANIC=$$SUM(.QSTN,"8892,8893,8894,8895,8896,8897,8898")
 S HANX=$$SUM(.QSTN,"8899,8900,8901,8902,8903,8904")
 S PTSD=$$SUM(.QSTN,"8864,8865,8867,8868,8869,8870,8871,8884,8889,8891")
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
 . I SCLID=1466 S ^TMP($J,"YSCOR",J)=SCLNM_"="_TOTAL
 . I SCLID=1467 S ^TMP($J,"YSCOR",J)=SCLNM_"="_VIGIL
 . I SCLID=1468 S ^TMP($J,"YSCOR",J)=SCLNM_"="_GANX
 . I SCLID=1469 S ^TMP($J,"YSCOR",J)=SCLNM_"="_SANX
 . I SCLID=1470 S ^TMP($J,"YSCOR",J)=SCLNM_"="_PANIC
 . I SCLID=1471 S ^TMP($J,"YSCOR",J)=SCLNM_"="_HANX
 . I SCLID=1472 S ^TMP($J,"YSCOR",J)=SCLNM_"="_PTSD
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
 N I,X,NAME,VALUE,TOTAL,VIGIL,GANX,SANX,PANIC,HANX,PTSD
 S I=0 F  S I=$O(^TMP($J,"YSCOR",I)) Q:'I  D
 . S NAME=$P(^TMP($J,"YSCOR",I),"=")
 . S VALUE=$P(^TMP($J,"YSCOR",I),"=",2)
 . I NAME="Total" S TOTAL=VALUE
 . I NAME="Vigilance" S VIGIL=VALUE
 . I NAME="Generalized Anxiety" S GANX=VALUE
 . I NAME="Social Anxiety" S SANX=VALUE
 . I NAME="Panic" S PANIC=VALUE
 . I NAME="Health Anxiety" S HANX=VALUE
 . I NAME="PTSD" S PTSD=VALUE
 S X=""
 S X=X_"|                             Raw    Average"
 S X=X_"|            Vigilance Score: "_$$SCORTXT(VIGIL,8)  ;$J(VIGIL,3)_$$AVERAGE(VIGIL,8)
 S X=X_"|  Generalized Anxiety Score: "_$$SCORTXT(GANX,7)   ;$J(GANX,3)_$$AVERAGE(GANX,7)
 S X=X_"|       Social Anxiety Score: "_$$SCORTXT(SANX,13)  ;$J(SANX,3)_$$AVERAGE(SANX,13)
 S X=X_"|                Panic Score: "_$$SCORTXT(PANIC,7)  ;$J(PANIC,3)_$$AVERAGE(PANIC,7)
 S X=X_"|       Health Anxiety Score: "_$$SCORTXT(HANX,6)   ;$J(HANX,3)_$$AVERAGE(HANX,6)
 S X=X_"|                 PTSD Score: "_$$SCORTXT(PTSD,10)  ;$J(PTSD,3)_$$AVERAGE(PTSD,10)
 S X=X_"|                             ---     ----"
 S X=X_"|          Grand Total Score: "_$$SCORTXT(TOTAL,41) ;$J(TOTAL,3)_$$AVERAGE(TOTAL,41)
 S SCORES=X
 Q
SCORTXT(SUM,N) ; return score string
 I SUM="" Q "No score due to skipped items"
 Q $J(SUM,3)_$$AVERAGE(SUM,N)
 ;
AVERAGE(SUM,N) ; return formatted average
 Q "    "_$J(SUM/N,5,2)
 ;

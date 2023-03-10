YTSEDEQ ;SLC/KCM - Score EDEQ ; 3/25/22 2:02pm
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
 N I,J,QID,CID,QSTN,RSTRNT,EATING,SHAPE,WEIGHT,TOTAL
 S I=2 F  S I=$O(YSDATA(I)) Q:'I  D
 . S QID=$P(YSDATA(I),U),CID=$P(YSDATA(I),U,3)
 . I CID=1155!(CID=1156)!(CID=1157) Q  ; leave skipped questions undefined
 . S QSTN(QID)=$$GET1^DIQ(601.75,CID_",",4,"I")
 S RSTRNT=$$AVERAGE(.QSTN,"8706,8707,8708,8709,8710")
 S EATING=$$AVERAGE(.QSTN,"8712,8714,8724,8726,8725")
 S SHAPE=$$AVERAGE(.QSTN,"8711,8713,8728,8715,8731,8732,8733,8716")
 S WEIGHT=$$AVERAGE(.QSTN,"8727,8729,8713,8730,8717")
 I RSTRNT=""!(EATING="")!(SHAPE="")!(WEIGHT="") S TOTAL="" I 1
 E  S TOTAL=(RSTRNT+EATING+SHAPE+WEIGHT)/4
 S RSTRNT=$S(RSTRNT="":"",1:$J(RSTRNT,5,2))
 S EATING=$S(EATING="":"",1:$J(EATING,5,2))
 S SHAPE=$S(SHAPE="":"",1:$J(SHAPE,5,2))
 S WEIGHT=$S(WEIGHT="":"",1:$J(WEIGHT,5,2))
 S TOTAL=$S(TOTAL="":"",1:$J(TOTAL,5,2))
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
 . I SCLID=1445 S ^TMP($J,"YSCOR",J)=SCLNM_"="_RSTRNT
 . I SCLID=1446 S ^TMP($J,"YSCOR",J)=SCLNM_"="_EATING
 . I SCLID=1447 S ^TMP($J,"YSCOR",J)=SCLNM_"="_SHAPE
 . I SCLID=1448 S ^TMP($J,"YSCOR",J)=SCLNM_"="_WEIGHT
 . I SCLID=1449 S ^TMP($J,"YSCOR",J)=SCLNM_"="_TOTAL
 Q
AVERAGE(QSTN,LIST) ; return average value for questions in LIST
 N I,QID,SUM,CNT,RATED,SCORE
 S (SUM,CNT,RATED)=0
 F I=1:1:$L(LIST,",") S QID=$P(LIST,",",I) D
 . S CNT=CNT+1
 . I $D(QSTN(QID)) S RATED=RATED+1,SUM=SUM+QSTN(QID)
 ; SCORE="" if < 1/2 items rated, otherwise average of rated items
 S SCORE="" I (RATED/CNT)>0.5 S SCORE=SUM/RATED
 Q SCORE
 ;
REPORT(SCORES) ; build the scoring display for the report
 ; expects ^TMP($J,"YSCOR",...) and ^TMP($J,"YSG") from DLLSTR
 ;         YSDATA from DLLSTR
 N I,X,NAME,VALUE,RSTRNT,EATING,SHAPE,WEIGHT,TOTAL
 S I=0 F  S I=$O(^TMP($J,"YSCOR",I)) Q:'I  D
 . S NAME=$E($P(^TMP($J,"YSCOR",I),"="),1,5)
 . S VALUE=$P(^TMP($J,"YSCOR",I),"=",2)
 . I VALUE="" S VALUE=" Too few items rated"
 . I NAME="Restr" S RSTRNT=VALUE
 . I NAME="Eatin" S EATING=VALUE
 . I NAME="Shape" S SHAPE=VALUE
 . I NAME="Weigh" S WEIGHT=VALUE
 . I NAME="Globa" S TOTAL=VALUE
 S X=""
 S X=X_"| Global EDE (4 subscales):"_TOTAL
 S X=X_"|       Restraint subscale:"_RSTRNT
 S X=X_"|  Eating Concern subscale:"_EATING
 S X=X_"|   Shape Concern subscale:"_SHAPE
 S X=X_"|  Weight Concern subscale:"_WEIGHT
 S SCORES=X
 Q

YTSPEB20 ;SLC/KCM - Score PEBS-20 ; 3/25/22 2:02pm
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
 N I,J,QSTN,ALL,TOTAL,HEALTH,LABOR,CHILD,HUMAN,SKILL
 S I=2 F  S I=$O(YSDATA(I)) Q:'I  D
 . S QSTN($P(YSDATA(I),U))=$P(YSDATA(I),U,3)
 S ALL="8674,8675,8676,8677,8679,8680,8681,8670,8682,8683,8665,8666,8667,8668,8672,8686,8687,8688,8689,8690"
 S TOTAL=$$AVERAGE(.QSTN,ALL)
 S HEALTH=$$AVERAGE(.QSTN,"8674,8675,8676,8677")
 S LABOR=$$AVERAGE(.QSTN,"8679,8680,8681")
 S CHILD=$$AVERAGE(.QSTN,"8670,8682,8683")
 S HUMAN=$$AVERAGE(.QSTN,"8665,8666,8667,8668,8672")
 S SKILL=$$AVERAGE(.QSTN,"8686,8687,8688,8689,8690")
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
 . I SCLID=1436 S ^TMP($J,"YSCOR",J)=SCLNM_"="_TOTAL
 . I SCLID=1437 S ^TMP($J,"YSCOR",J)=SCLNM_"="_HEALTH
 . I SCLID=1438 S ^TMP($J,"YSCOR",J)=SCLNM_"="_LABOR
 . I SCLID=1439 S ^TMP($J,"YSCOR",J)=SCLNM_"="_CHILD
 . I SCLID=1440 S ^TMP($J,"YSCOR",J)=SCLNM_"="_HUMAN
 . I SCLID=1441 S ^TMP($J,"YSCOR",J)=SCLNM_"="_SKILL
 Q
AVERAGE(QSTN,LIST) ; return average value for questions in LIST
 N I,QID,SUM,CNT
 S (SUM,CNT)=0
 F I=1:1:$L(LIST,",") S QID=$P(LIST,",",I) D  Q:SUM<0
 . I '$D(QSTN(QID)) S SUM=-1 Q
 . S CNT=CNT+1,SUM=SUM+QSTN(QID)
 Q $S(SUM<0:-1,1:+$FN(SUM/CNT,"",2))
 ;
REPORT(SCORES) ; build the scoring display for the report
 ; expects ^TMP($J,"YSCOR",...) and ^TMP($J,"YSG") from DLLSTR
 ;         YSDATA from DLLSTR
 N I,X,NAME,VAL,TOTAL,HEALTH,LABOR,CHILD,HUMAN,SKILL
 S I=0 F  S I=$O(^TMP($J,"YSCOR",I)) Q:'I  D
 . S NAME=$E($P(^TMP($J,"YSCOR",I),"="),1,5)
 . S VAL=$P(^TMP($J,"YSCOR",I),"=",2)
 . S VAL=$S(VAL<0:" Missing responses",1:$J(VAL,5,2))
 . I NAME="Total" S TOTAL=VAL
 . I NAME="Physi" S HEALTH=VAL
 . I NAME="Labor" S LABOR=VAL
 . I NAME="Child" S CHILD=VAL
 . I NAME="Human" S HUMAN=VAL
 . I NAME="Soft " S SKILL=VAL
 S X=""
 S X=X_"|      PEBS-20 total score:"_TOTAL
 S X=X_"| Physical & mental health:"_HEALTH
 S X=X_"|   Labor market exclusion:"_LABOR
 S X=X_"|               Child Care:"_CHILD
 S X=X_"|            Human Capital:"_HUMAN
 S X=X_"|              Soft Skills:"_SKILL
 S SCORES=X
 Q

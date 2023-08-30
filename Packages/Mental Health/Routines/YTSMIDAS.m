YTSMIDAS ;SLC/KCM - Score MIDAS ; 10/14/18 2:02pm
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
 . N TXT,N
 . D LDSCORES^YTSCORE(.YSDATA,.YS) ; puts score into ^TMP($J,"YSCOR",2)
 . D REPORT(.TXT)
 . S N=$O(YSDATA(""),-1) ; get last node
 . S YSDATA(N+1)="7771^9999;1^"_TXT
 Q
 ;
SCORESV ; calculate the score
 ; expects YSDATA from DLLSTR
 N I,J,QSTN,VAL,TOTAL,SCLID,SCLNM
 S TOTAL=0
 S I=2 F  S I=$O(YSDATA(I)) Q:'I  D
 . S QSTN=$P(YSDATA(I),U),VAL=$P(YSDATA(I),U,3)
 . I VAL=1155!(VAL=1156)!(VAL=1157) Q  ; don't include skipped questions
 . ; only score the first five questions
 . I ":8947:8948:8949:8950:8951:"[(":"_QSTN_":") S TOTAL=TOTAL+VAL
 ; set scores into ^TMP($J,"YSCOR",n)=scaleId=rawScore^tScore
 K ^TMP($J,"YSCOR")
 I $D(^TMP($J,"YSG",1)),^TMP($J,"YSG",1)="[ERROR]" D  Q  ;-->out
 . S ^TMP($J,"YSCOR",1)="[ERROR]"
 . S ^TMP($J,"YSCOR",2)="No Scale found for ADMIN"
 ;
 S ^TMP($J,"YSCOR",1)="[DATA]"
 S I=2,J=1 F  S I=$O(^TMP($J,"YSG",I)) Q:'I  D
 . S SCLID=+$P(^TMP($J,"YSG",I),"=",2)
 . S SCLNM=$P(^TMP($J,"YSG",I),U,4)
 . S J=J+1
 . I SCLID=1480 S ^TMP($J,"YSCOR",J)=SCLNM_"="_TOTAL
 Q
REPORT(TXT) ; build the scoring display for the report
 ; expects ^TMP($J,"YSCOR",...) and ^TMP($J,"YSG") from DLLSTR
 ;         YSDATA from DLLSTR
 ; YSDATA(2+n)=questionId^sequence^choiceId or text response
 N I,X,NAME,VALUE,TOTAL
 S I=0 F  S I=$O(^TMP($J,"YSCOR",I)) Q:'I  D
 . S NAME=$P(^TMP($J,"YSCOR",I),"=")
 . S VALUE=$P(^TMP($J,"YSCOR",I),"=",2)
 . I NAME="Total" S TOTAL=VALUE
 I TOTAL<6 S TXT="I   (Little or No Disability)"
 I TOTAL>5,(TOTAL<11) S TXT="II   (Mild Disability)"
 I TOTAL>10,(TOTAL<21) S TXT="III   (Moderate Disability)"
 I TOTAL>20 S TXT="IV   (Severe Disability)"
 S TXT="|  MIDAS Score "_TOTAL_"|  MIDAS Grade "_TXT
 Q

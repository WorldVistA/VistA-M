YTSCSDD ;SLC/MJB- SCORE CSDD-RS ; 12/05/18 9:35am
 ;;5.01;MENTAL HEALTH;**139**;Dec 30, 1994;Build 134
 ;
 ; This routine was split from YTQAPI2A.
 ; This routine handles limited complex reporting requirements without
 ; modifying YS_AUX.DLL by adding free text "answers" that can be used by
 ; a report.
 ;,
 ; Assumptions:  EDIT incomplete instrument should ignore the extra answers
 ; since there are no associated questions.  GRAPHING should ignore the
 ; answers since they not numeric.
 ;
  Q
 ;
DLLSTR(YSDATA,YS,YSTRNG) ;
 ;
 N YSSCALIEN,LEG,DES,DATA,NODE,YSQN,YSSEQ,YSAN,YSCDA,SCORE
 N YSINSNAM,II,YSSCNAM,YSCSDD
 S N=N+1,II=0
 IF YSTRNG=1 D SCORESV
 I YSTRNG=2 D
 .D LDSCORES^YTSCORE(.YSDATA,.YS)
 .D STRING
 Q
 ;
SCORESV ;
 D DATA1
 I $D(^TMP($J,"YSG",1)),^TMP($J,"YSG",1)="[ERROR]" D  Q  ;-->out
 .K ^TMP($J,"YSCOR")
 .S ^TMP($J,"YSCOR",1)="[ERROR]"
 .S ^TMP($J,"YSCOR",2)=$G(YSINSNAM)_" Scale not found"
 S YSSCNAM=$P($G(^TMP($J,"YSG",3)),U,4)             ; Scale Name
 ;
 K ^TMP($J,"YSCOR")
 S ^TMP($J,"YSCOR",1)="[DATA]"
 S YSSCALIEN=+$P(^TMP($J,"YSG",3),"=",2)
 S ^TMP($J,"YSCOR",2)=$$GET1^DIQ(601.87,YSSCALIEN_",",3,"I")_"="_SCORE
 Q
 ;
DATA1 ;
 S YSINSNAM=$P(YSDATA(2),U,3) S SCORE=0
 I $G(YSINSNAM)="" S YSINSNAM=$G(YS("CODE"),"NO NAME PASSED")
 S NODE=2 F  S NODE=$O(YSDATA(NODE)) Q:NODE>21  D  ; Start at YSDATA(3)
 .S DATA=YSDATA(NODE)
 .S YSQN=$P($G(DATA),U,1)
 .S YSSEQ=$P($G(DATA),U,2)
 .S YSCDA=$P($G(DATA),U,3)
 .S YSAN=$$GET1^DIQ(601.75,YSCDA_",",3,"I")
 .S DES=YSSEQ
 .S LEG=$$GET1^DIQ(601.75,YSCDA_",",4,"I")
 .S SCORE=SCORE+LEG
 Q
 ;
STRING ;
 S YSCSDD=+$P(^TMP($J,"YSCOR",2),"=",2)
 S YSDATA(N)="7771^9999;1^"_YSCSDD S N=N+1
 Q

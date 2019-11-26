YTSIMRS ;SLC/BLD- ANSWERS SPECIAL HANDLING - IMRS ; 10/16/18 9:35am
 ;;5.01;MENTAL HEALTH;**151**;DEC 30,1994;Build 92
 ;
DATA1 ;expects score, returns SCORE
 N NODE
 S NODE=2 F  S NODE=$O(YSDATA(NODE)) Q:NODE=""  D
 .N YSCDA,LEG,DATA
 .S DATA=YSDATA(NODE)
 .S YSCDA=$P($G(DATA),U,3) ; Choice ID
 .S LEG=$$GET1^DIQ(601.75,YSCDA_",",4,"I")
 .S SCORE=SCORE+LEG
 Q
 ;
STRING ; Expects ^TMP($J,"YSCOR"
 N SCORE,SKIP13
 I YSDATA(15)="8347^13^1155" S SKIP13=1  ;if question 13 has 1155 mh choice (aka skipped choice)
 S SCORE=$P($G(^TMP($J,"YSCOR",2)),"=",2)
 S STRING1="|IMRS TOTAL SCORE = "_SCORE
 S STRING1=STRING1_"|Total score can range from 15 to 75*. Higher scores indicate better functioning."
 I $G(SKIP13) S STRING1=STRING1_"||Question 13 was skipped because no medication was prescribed."
 S STRING1=STRING1_"||* If Question 13 is skipped, the score range is 14-70"
 S STRING1=STRING1_"||"
 ;
SCORESV ;
 D DATA1
 I $D(^TMP($J,"YSG",1)),^TMP($J,"YSG",1)="[ERROR]" D  Q  ;-->out
 .K ^TMP($J,"YSCOR")
 .S ^TMP($J,"YSCOR",1)="[ERROR]"
 .S ^TMP($J,"YSCOR",2)="No Scale found for ADMIN"
 ;
 K ^TMP($J,"YSCOR")
 S ^TMP($J,"YSCOR",1)="[DATA]"
 S ^TMP($J,"YSCOR",2)=$$GET1^DIQ(601.87,1314_",",3,"I")_"="_SCORE
 Q
 ;
DLLSTR(YSDATA,YS,YSTRNG) ;
 ; YSTRNG = 1 Score Instrument
 ; YSTRNG = 2 get Report Answers and Text
 N DATA,LEG,NODE,SCORE,STRING1,SC
 N YSCDA,YSDFN,YSINSNAM,YSSEX,YSQN
 ;
 S (SC,YSSEX)=""
 S SCORE=0
 I YSTRNG=1 D SCORESV
 I YSTRNG=2 D
 .D LDSCORES^YTSCORE(.YSDATA,.YS)
 .D STRING
 .S YSDATA($O(YSDATA(""),-1)+1)=999999999999_U_U_STRING1
 Q
 ;

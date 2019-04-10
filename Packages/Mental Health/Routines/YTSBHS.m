YTSBHS ;SLC/PIJ - Score BHS ; 01/16/2016
 ;;5.01;MENTAL HEALTH;**123**;Dec 30, 1994;Build 73
 ;
 Q
 ;
DATA1 ;
 S YSINSNAM=$P(YSDATA(2),U,3)
 I $G(YSINSNAM)="" S YSINSNAM=$G(YS("CODE"),"NO NAME PASSED")
 S NODE=2 F  S NODE=$O(YSDATA(NODE)) Q:NODE=""  D  ; Start at YSDATA(3)
 .S DATA=YSDATA(NODE)
 .S YSQN=$P($G(DATA),U,1)
 .S YSSEQ=$P($G(DATA),U,2)
 .S YSCDA=$P($G(DATA),U,3)
 .S YSAN=$$GET1^DIQ(601.75,YSCDA_",",3,"I")
 .S DES=YSSEQ
 .S LEG=$$GET1^DIQ(601.75,YSCDA_",",4,"I")
 .D VALUES
 .D REST
 .S SCORE=SCORE+LEG
 Q
 ;
STRING ;
 I '$D(^TMP($J,"YSCOR")) D  Q
 .S STRING1="| "_YSINSNAM_" score could not be determined."
 .S STRING1=STRING1_"|| Questions and answers"
 ;
 S SCORE=$P($G(^TMP($J,"YSCOR",2)),"=",2)
 S FEEL=$P($G(^TMP($J,"YSCOR",3)),"=",2)
 S MOTIVATE=$P($G(^TMP($J,"YSCOR",4)),"=",2)
 S FUTURE=$P($G(^TMP($J,"YSCOR",5)),"=",2)
 ;
 S RISK=$S(SCORE<4:"None or minimal hopelessness",SCORE<9:"mild hopelessness",SCORE<15:"moderate hopelessness.  Evaluate suicide risk",1:"severe hopelessness.  Definite suicide risk")
 S RANGE=$S(SCORE<4:" between 0 - 3",SCORE<9:" between 4 - 8",SCORE<15:" between 9 - 14",1:" above 14")
 ;
 S STRING="| "_YSINSNAM_" Score: "_SCORE_" indicates "_RISK_"."
 S STRING=STRING_"| The overall range is 0 to 20 with "_$S(SCORE<4:"low hopelessness",SCORE<9:"mild hopelessness",SCORE<15:"moderate hopelessness",1:"severe hopelessness")_RANGE_"."
 S STRING=STRING_"|| Feelings of Future: "_FEEL
 S STRING=STRING_"| Loss of Motivation: "_MOTIVATE
 S STRING=STRING_"| Future Expectations: "_FUTURE
 S STRING=STRING_"|| Questions and answers |"
 Q
 ;
REST ;
 ; Save patient response
 N X
 S X=$P($G(DATA),U,3)
 S STRING1=STRING1_"|  "_DES_". "_$P(^YTT(601.75,X,1),U,1)_" ("_LEG_" point)"
 Q
VALUES ;
 ;Feeling of Future   - 1,6,13,15,19
 ;Loss of Motivation  - 2,3,9,11,12,16,17,20
 ;Future Expectations - 4,7,8,14,18
 ;
 N STR
 S STR="FTFTFFTFTFTTFTFTTTFT"
 I $E(STR,DES)=LEG S LEG=1 D  Q
 .I (DES=1)!(DES=6)!(DES=13)!(DES=15)!(DES=19) S FEEL=FEEL+1 Q       ;FALSE
 .I (DES=2)!(DES=9)!(DES=11)!(DES=12)!(DES=16)!(DES=17)!(DES=20) S MOTIVATE=MOTIVATE+1 Q  ;TRUE
 .I (DES=3) S MOTIVATE=MOTIVATE+1 Q                ;FALSE
 .I (DES=4)!(DES=7)!(DES=14)!(DES=18) S FUTURE=FUTURE+1 Q         ;TRUE
 .I (DES=8) S FUTURE=FUTURE+1 Q                 ;FALSE
 S LEG=0
 Q
 ;
SCORESV ;
 ;
 I $D(^TMP($J,"YSG",1)),^TMP($J,"YSG",1)="[ERROR]" D  Q  ;-->out
 .K ^TMP($J,"YSCOR")
 .S ^TMP($J,"YSCOR",1)="[ERROR]"
 .S ^TMP($J,"YSCOR",2)=YSINSNAM_" Scale not found"
 ;
 S YSSCNAM=$P($G(^TMP($J,"YSG",3)),U,4)
 K ^TMP($J,"YSCOR")
 S ^TMP($J,"YSCOR",1)="[DATA]"
 S ^TMP($J,"YSCOR",2)=$$GET1^DIQ(601.87,902_",",3,"I")_"="_SCORE
 S ^TMP($J,"YSCOR",3)=$$GET1^DIQ(601.87,903_",",3,"I")_"="_FEEL
 S ^TMP($J,"YSCOR",4)=$$GET1^DIQ(601.87,904_",",3,"I")_"="_MOTIVATE
 S ^TMP($J,"YSCOR",5)=$$GET1^DIQ(601.87,905_",",3,"I")_"="_FUTURE
 Q
 ;    
DLLSTR(YSDATA,YS,YSTRNG) ;
 ;  YSTRNG = 1 Score Instrument
 ;  YSTRNG = 2 get Report Answers and Text
 N DATA,DES,NODE,LEG,RISK,YSAN,YSQN,YSINSNAM,YSSEQ,YSCDA,YSSCNAM
 N FEEL,FUTURE,MOTIVATE,RANGE,SCORE,STRING,STRING1
 ;
 S (STRING,STRING1)=""
 S (FEEL,FUTURE,MOTIVATE,SCORE)=0
 ;
 D DATA1
 I YSTRNG=1 D SCORESV
 I YSTRNG=2 D
 .D LDSCORES^YTSCORE(.YSDATA,.YS)
 .D STRING
 .S STRING=STRING_STRING1
 .S YSDATA($O(YSDATA(""),-1)+1)=999999999999_U_U_STRING
 Q

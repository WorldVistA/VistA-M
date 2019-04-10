YTSBDI2 ;SLC/PIJ - Score BDI2 ; 01/16/2016
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
 .S YSCDA=$P($G(DATA),U,3)
 .D DESGNTR^YTSCORE(YSQN,.DES)
 .S LEG=$$GET1^DIQ(601.75,YSCDA_",",4,"I")
 .S YSAN=$$GET1^DIQ(601.75,YSCDA_",",3,"I")
 .; Question2 #16 and #18
 .I (DES=16)!(DES=18) D
 ..I (LEG=2) S LEG=1 Q
 ..I (LEG=3)!(LEG=4) S LEG=2 Q
 ..I (LEG=5)!(LEG=6) S LEG=3 Q
 .I (DES=9) D
 ..I (YSCDA=1155)!(YSCDA=1156) Q
 ..I LEG>0 S RFLAG=1
 .D REST2
 .S SCORE=SCORE+LEG
 Q
 ;
RPT ;
 I '$D(^TMP($J,"YSCOR")) D  Q
 .S STRING1="| "_YSINSNAM_" score could not be determined. "
 ;
 S SCORE=$P($G(^TMP($J,"YSCOR",2)),"=",2)
 I SCORE=-1 D  Q
 .S STRING1=STRING1_"| "_YSINSNAM_" score could not be determined."
 .S STRING1=STRING1_"|| Questions and answers"
 ;
 S RISK=$S(SCORE<14:"low",SCORE<20:"mild",SCORE<29:"moderate",1:"severe")
 S RANGE=$S(SCORE<14:" between 0 - 13",SCORE<20:" between 14 - 19",SCORE<29:" between 20 - 28",1:" above 29")
 S STRING=STRING_"| "_YSINSNAM_" Score: "_SCORE_" indicates "_RISK_" depression."
 S STRING=STRING_" The overall range is 0 to 63 with "_RISK_" depression"_RANGE_"."
 I RFLAG D
 .S STRING=STRING_"|| Responses consistent with the presence of suicidal ideation were endorsed "
 .S STRING=STRING_"in positive direction (item-9), additional clinical assessment is indicated."
 ;
 S STRING=STRING_"||    1 point  = mild symptom level  |    2 points = moderate symptom level  |    3 points = severe symptom level  "
 S STRING=STRING_"|| Questions and answers|"
 Q
 ;
REST2 ; setting up Report Question and Answer section; will move this to YSDATA so
 N I
 F I=1:1 Q:'$D(^YTT(601.72,YSQN,1,I,0))  D
 .S TMP(NODE)=YSQN_U_"9999;1^"_DES_". "_$$GET1^DIQ(601.75,YSCDA_",",3,"E")_" ("_LEG
 .S:LEG'=1 TMP(NODE)=TMP(NODE)_" points)"
 .S:LEG=1 TMP(NODE)=TMP(NODE)_" point)"
 Q
TRANS ; move Answers from TMP to YSDATA
 N I,STR,ANS
 F I=3:1 Q:'$D(YSDATA(I))  K YSDATA(I)
 ;
 S ANS=7770
 F I=3:1:23 S ANS=ANS+1 S:ANS=7788 ANS=7921
 ; 
 S ANS=7770
 F I=3:1 Q:'$D(TMP(I))  S STR=$P(TMP(I),U,2,4) D
 .S ANS=ANS+1 S:ANS=7788 ANS=7921
 .S YSDATA(I)=ANS_U_STR
 Q
SCORESV ; For the Graph/Table
 I $D(^TMP($J,"YSG",1)),^TMP($J,"YSG",1)="[ERROR]" D  Q  ;-->out
 .K ^TMP($J,"YSCOR")
 .S ^TMP($J,"YSCOR",1)="[ERROR]"
 .S ^TMP($J,"YSCOR",2)=YSINSNAM_" Scale not found"
 ;
 K ^TMP($J,"YSCOR")
 S ^TMP($J,"YSCOR",1)="[DATA]"
 S ^TMP($J,"YSCOR",2)=$$GET1^DIQ(601.87,332_",",3,"I")_"="_SCORE
 Q
 ;
DLLSTR(YSDATA,YS,YSTRNG) ;
 ;  YSTRNG = 1 Score Instrument
 ;  YSTRNG = 2 get Report Answers and Text
 N CTR,DATA,DES,LEG,NODE,SCORE,TMP,YSAN,YSQN
 N YSCDA,YSSCNAM,YSINSNAM,RISK
 N STRING,STRING1,RANGE,RFLAG
 ;
 S (STRING,STRING1)=""
 S (CTR,LEG,RFLAG,SCORE)=0
 ;
 D DATA1
 I YSTRNG=1 D SCORESV
 I YSTRNG=2 D
 .D LDSCORES^YTSCORE(.YSDATA,.YS)
 .D TRANS
 .D RPT
 .S STRING=STRING_STRING1
 .S YSDATA($O(YSDATA(""),-1)+1)=999999999999_U_U_STRING
 Q

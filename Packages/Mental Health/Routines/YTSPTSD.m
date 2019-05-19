YTSPTSD ;SLC/PIJ - Score PC PTSD ; 01/08/2016
 ;;5.01;MENTAL HEALTH;**123**;DEC 30,1994;Build 72
 ;
 ;Public, Supported ICRs
 ; #2056 - Fileman API - $$GET1^DIQ
 ;
 Q
 ;
DATA1 ;
 S YSINSNAM=$P($G(YSDATA(2)),U,3)
 I $G(YSINSNAM)="" S YSINSNAM=$G(YS("CODE"),"NO NAME PASSED")
 S NODE=2 F  S NODE=$O(YSDATA(NODE)) Q:NODE=""  D
 .S DATA=YSDATA(NODE)
 .S YSQN=$P(DATA,U,1)
 .S YSCDA=$P($G(DATA),U,3)
 .S LEG=$$GET1^DIQ(601.75,YSCDA_",",4,"I")
 .I (LEG="Y") S TOTYES=TOTYES+1
 Q
 ;
STRING ;
 I '$D(^TMP($J,"YSCOR")) D  Q
 .S STRING="| "_YSINSNAM_" score could not be determined. "
 S TOTYES=$P($G(^TMP($J,"YSCOR",2)),"=",2)
 I TOTYES<=2 S STRING=STRING_"| A score of "_TOTYES_" indicates a negative screen." Q
 S STRING=STRING_"| A score of "_TOTYES_" indicates a positive screen."
 Q
 ;
SCORESV ; Used for Graph and Table
 I $D(^TMP($J,"YSG",1)),^TMP($J,"YSG",1)="[ERROR]" D  Q  ;-->out
 .K ^TMP($J,"YSCOR")
 .S ^TMP($J,"YSCOR",1)="[ERROR]"
 .S ^TMP($J,"YSCOR",2)=YSINSNAM_" Scale not found"
 ;
 K ^TMP($J,"YSCOR")
 S ^TMP($J,"YSCOR",1)="[DATA]"
 S ^TMP($J,"YSCOR",2)=$$GET1^DIQ(601.87,203_",",3,"I")_"="_TOTYES
 Q
 ;
DLLSTR(YSDATA,YS,YSTRNG) ;
 ;  YSTRNG = 1 Score Instrument
 ;  YSTRNG = 2 get Report Answers and Text
 N DATA,NODE,LEG,YSCDA,YSQN,YSINSNAM
 N STRING,TOTYES
 ;
 S STRING=""
 S TOTYES=0
 ;
 D DATA1
 ;
 I YSTRNG=1 D SCORESV
 I YSTRNG=2 D
 .D LDSCORES^YTSCORE(.YSDATA,.YS)
 .D STRING
 .S YSDATA($O(YSDATA(""),-1)+1)=999999999999_U_U_STRING
 Q

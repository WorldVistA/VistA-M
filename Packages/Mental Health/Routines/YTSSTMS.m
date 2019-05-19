YTSSTMS ;SLC/PIJ - Score STMS ; 03/31/2016
 ;;5.01;MENTAL HEALTH;**123**;DEC 30,1994;Build 72
 ;
 ;Public, Supported ICRs
 ; #2056 - Fileman API - $$GET1^DIQ
 ;
 Q
 ;
DATA1 ;
 S TOTAL=0,DIGIT=0
 S YSINSNAM=$P($G(YSDATA(2)),U,3)
 I $G(YSINSNAM)="" S YSINSNAM=$G(YS("CODE"),"NO NAME PASSED")
 S NODE=2 F  S NODE=$O(YSDATA(NODE)) Q:NODE=""  D  ; Start at YSDATA(3)
 .S DATA=YSDATA(NODE)
 .S YSQN=$P(DATA,U,1)
 .S YSCDA=$P($G(DATA),U,3) ; Choice ID
 .D DESGNTR^YTSCORE(YSQN,.DES)
 .S LEG=$$GET1^DIQ(601.75,YSCDA_",",4,"I")  ; LEG = Legacy value
 .;Do special processing on these questions
 .I (DES="2A")!(DES="2B")!(DES="2C")!(DES="3A")!(DES="3B")!(DES=7) D  Q
 ..;Get best number of digit spans (2A, 2B, 2C)
 ..I (DES="2A") S DIGIT=LEG
 ..I (DES="2B"),(YSCDA'=1156) D  Q
 ...I LEG>DIGIT S DIGIT=LEG
 ..I (DES="2C"),(YSCDA'=1156) D  Q
 ...I LEG>DIGIT S DIGIT=LEG
 ..;Get number of Attempts to learn words (3A)
 ..I DES="3A" D  Q
 ...I LEG=4 S TOTAL=TOTAL-3
 ...I LEG=3 S TOTAL=TOTAL-2
 ...I LEG=2 S TOTAL=TOTAL-1
 ..;Get number of words learned (3B)
 ..I DES="3B" S TOTAL=TOTAL+LEG
 ..;Get answer for drawing cube (7)
 ..I DES=7 D  Q
 ...I LEG=1 S TOTAL=TOTAL+2  ; full credit
 ...I LEG=2 S TOTAL=TOTAL+1  ; partial credit
 .I LEG=1 S TOTAL=TOTAL+1
 ;get grand total
 S TOTAL=TOTAL+DIGIT
 Q
 ;
SCORESV ;
 I $D(^TMP($J,"YSG",1)),^TMP($J,"YSG",1)="[ERROR]" D  Q  ;-->out
 .K ^TMP($J,"YSCOR")
 .S ^TMP($J,"YSCOR",1)="[ERROR]"
 .S ^TMP($J,"YSCOR",2)="STMS Scale not found"
 K ^TMP($J,"YSCOR")
 S ^TMP($J,"YSCOR",1)="[DATA]"
 S ^TMP($J,"YSCOR",2)=$$GET1^DIQ(601.87,626_",",3,"I")_"="_TOTAL
 Q
 ;
DLLSTR(YSDATA,YS,YSTRNG) ;
 ;  YSTRNG = 1 Score Instrument
 ;  YSTRNG = 2 get Report Answers and Text
 N DATA,DES,DIGIT,LEG,NODE,YSCDA,YSQN,YSINSNAM,TOTAL
 ;
 I YSTRNG=2 Q  ; No special text in report, use scale
 D DATA1
 D SCORESV
 Q

YTSPHQ2 ;SLC/PIJ - Score PHQ-2 ; 01/08/2016
 ;;5.01;MENTAL HEALTH;**123**;DEC 30,1994;Build 72
 ;
 ;Public, Supported ICRs
 ; #2056 - Fileman API - $$GET1^DIQ
 ;
 Q
 ;
DATA1 ;
 S SKIP=0
 S YSINSNAM=$P($G(YSDATA(2)),U,3)
 I $G(YSINSNAM)="" S YSINSNAM=$G(YS("CODE"),"NO NAME PASSED")
 S NODE=2 F  S NODE=$O(YSDATA(NODE)) Q:NODE=""!(SKIP)  D  ; Start at YSDATA(3)
 .S DATA=YSDATA(NODE)
 .S YSQN=$P(DATA,U,1)
 .S YSCDA=$P($G(DATA),U,3)
 .D DESGNTR^YTSCORE(YSQN,.DES)
 .I (YSCDA=1155)!(YSCDA=1156)!(YSCDA=1157)!(YSCDA="NOT ASKED") S TOTAL="",SKIP=1 Q
 .S LEG=$$GET1^DIQ(601.75,YSCDA_",",4,"I")
 .S TOTAL=TOTAL+LEG-1
 Q
 ;
STRING  ;
 N RES
 I '$D(^TMP($J,"YSCOR")) D  Q
 .S STRING="| "_YSINSNAM_" score could not be determined. "
 S TOTAL=$P($G(^TMP($J,"YSCOR",2)),"=",2)
 ; If TOTAL = "", there are skipped questions and instrument is not valid
 I TOTAL="" D  Q
 .S STRING="| Due to missing Items, this administration cannot be scored. |"
 S RES=$S(TOTAL<=2:"negative",1:"positive")
 S STRING="| The score on this administration is "_TOTAL_", which indicates a "
 S STRING=STRING_RES_" screen on the Depression Scale over the past two weeks."
 Q
 ;
SCORESV ;
 I $D(^TMP($J,"YSG",1)),^TMP($J,"YSG",1)="[ERROR]" D  Q  ;-->out
 .K ^TMP($J,"YSCOR")
 .S ^TMP($J,"YSCOR",1)="[ERROR]"
 .S ^TMP($J,"YSCOR",2)=YSINSNAM_" Scale not found"
  ;
  K ^TMP($J,"YSCOR")
  S ^TMP($J,"YSCOR",1)="[DATA]"
  S ^TMP($J,"YSCOR",2)=$$GET1^DIQ(601.87,492_",",3,"I")_"="_TOTAL
  Q
  ;
DLLSTR(YSDATA,YS,YSTRNG) ;
 ;  YSTRNG = 1 Score Instrument
 ;  YSTRNG = 2 get Report Answers and Text
 N DATA,DES,LEG,NODE,YSQN,YSCDA,TOTAL
 N YSINSNAM,STRING,SKIP
 ;
 S STRING=""
 S TOTAL=""
 D DATA1
 I YSTRNG=1 D SCORESV
 ;
 I YSTRNG=2 D
 .D LDSCORES^YTSCORE(.YSDATA,.YS)
 .D STRING
 .S YSDATA($O(YSDATA(""),-1)+1)=999999999999_U_U_STRING
 Q

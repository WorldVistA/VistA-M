YTSMINIC ;SLC/PIJ - Score MINI COG ; 01/08/2016
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
 S NODE=2 F  S NODE=$O(YSDATA(NODE)) Q:NODE=""  D  ; Start at YSDATA(3)
 .S DATA=YSDATA(NODE)
 .S YSQN=$P(DATA,U,1)
 .S YSSEQ=$P(DATA,U,2),YSSEQ=$P(YSSEQ,";",1)
 .S YSCDA=$P($G(DATA),U,3)
 .D DESGNTR^YTSCORE(YSQN,.DES)
 .S LEG=$$GET1^DIQ(601.75,YSCDA_",",4,"I")
 .I (DES=1),(LEG=0) S CLOCK="false"
 .; Skipped Question
 .I LEG="X" S SKIPQUES=SKIPQUES+1
 .E  D
 ..I (LEG=1) S TOTAL=TOTAL+1
 I SKIPQUES>0 S TOTAL="CND"
 Q
 ;
STRING ;
 N STR1
 I '$D(^TMP($J,"YSCOR")) D  Q
 .S STRING="| "_YSINSNAM_" score could not be determined. "
 ;
 S TOTAL=$P($G(^TMP($J,"YSCOR",2)),"=",2)
 S STRING="Mini-Cog Results: "
 ;
 I SKIPQUES>0 D  Q
 .S STRING="|"_STRING_"Too many items were skipped to score this administration."
 ;
 ;if total = 0, value of CLOCK doesn't matter, positive screen
 I (TOTAL=0) S STR1="Positive for cognitive impairment."
 I (TOTAL>2) S STR1="Negative screen for dementia."
 ; 
 I (TOTAL=1)!(TOTAL=2) D
 .I CLOCK="true" S STR1="Negative screen for dementia."
 .E  S STR1="Positive for cognitive impairment."
 ;
 S STRING="|"_STRING_TOTAL_"  "_STR1
 ;
SCORESV ; Used for Graph and Table
 I $D(^TMP($J,"YSG",1)),^TMP($J,"YSG",1)="[ERROR]" D  Q  ;-->out
 .K ^TMP($J,"YSCOR")
 .S ^TMP($J,"YSCOR",1)="[ERROR]"
 .S ^TMP($J,"YSCOR",2)=YSINSNAM_" Scale not found"
 ;
 K ^TMP($J,"YSCOR")
 S ^TMP($J,"YSCOR",1)="[DATA]"
 S ^TMP($J,"YSCOR",2)=$$GET1^DIQ(601.87,624_",",3,"I")_"="_TOTAL
 Q
 ;
DLLSTR(YSDATA,YS,YSTRNG) ;
 ;  YSTRNG = 1 Score Instrument
 ;  YSTRNG = 2 get Report Answers and Text
 N DATA,DES,NODE,LEG,YSQN,YSSEQ,YSCDA
 N YSSCID,YSINSNAM
 N STRING,TOTAL,CLOCK,SKIPQUES
 ;
 S (SKIPQUES,TOTAL)=0
 S STRING=""
 S CLOCK="true"
 ;
 D DATA1
 ;
 I YSTRNG=1 D
 .D SCORESV
 ;
 I YSTRNG=2 D
 .D LDSCORES^YTSCORE(.YSDATA,.YS)
 .D STRING
 .S YSDATA($O(YSDATA(""),-1)+1)=999999999999_U_U_STRING
 Q

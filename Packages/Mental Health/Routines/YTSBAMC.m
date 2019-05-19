YTSBAMC ;SLC/PIJ - Score BAMC ; 01/08/2016
 ;;5.01;MENTAL HEALTH;**123**;DEC 30,1994;Build 72
 ;
 ;Public, Supported ICRs
 ; #2056 - Fileman API - $$GET1^DIQ
 ;
 Q
 ;
DATA1 ; display scores for administration
 N ANS
 S YSINSNAM=$P($G(YSDATA(2)),U,3)
 I $G(YSINSNAM)="" S YSINSNAM=$G(YS("CODE"),"NO NAME PASSED")
 S NODE=2 F  S NODE=$O(YSDATA(NODE)) Q:NODE=""  D  ; Start at YSDATA(3)
 .S DATA=YSDATA(NODE)
 .S YSQN=$P(DATA,U,1)
 .S ANS=$P(DATA,U,3),ANS=$S(ANS=1155:0,ANS=1156:0,1:ANS)
 .I YSQN=6464 S ALCO=ANS
 .I YSQN=6465 S HALCO=ANS
 .I YSQN=6466 S DRUG=ANS
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
 S ^TMP($J,"YSCOR",2)=$$GET1^DIQ(601.87,778_",",3,"I")_"="_ALCO
 S ^TMP($J,"YSCOR",3)=$$GET1^DIQ(601.87,838_",",3,"I")_"="_HALCO
 S ^TMP($J,"YSCOR",4)=$$GET1^DIQ(601.87,839_",",3,"I")_"="_DRUG
 Q
 ; 
DLLSTR(YSDATA,YS,YSTRNG) ;
 ;  YSTRNG = 1 Score Instrument
 ;  YSTRNG = 2 get Report Answers and Text
 ;
 N ALCO,DATA,DRUG,HALCO,NODE,YSQN,YSINSNAM
 ;
 I YSTRNG=2 Q  ; no special processing or text
 ;
 D DATA1
 D SCORESV
 Q

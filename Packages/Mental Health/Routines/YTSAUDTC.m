YTSAUDTC ;SLC/PIJ - Score AUDC ; 01/08/2016
 ;;5.01;MENTAL HEALTH;**123**;DEC 30,1994;Build 72
 ;
 ;Public, Supported ICRs
 ; #2056 - Fileman API - $$GET1^DIQ
 ;
 ;
DATA1 ;
 ; get DFN and Sex of Patient
 S DATA=$G(YSDATA(2))
 S YSDFN=$P($G(DATA),U,2)
 S YSSEX=$$GET1^DIQ(2,YSDFN_",",.02,"I")
 S YSINSNAM=$P(DATA,U,3)
 S NODE=2 F  S NODE=$O(YSDATA(NODE)) Q:NODE=""  D
 .S DATA=YSDATA(NODE)
 .S YSQN=$P($G(DATA),U,1)
 .S YSCDA=$P($G(DATA),U,3) ; Choice ID
 .S LEG=$$GET1^DIQ(601.75,YSCDA_",",4,"I")
 .S SCORE=SCORE+LEG
 Q
 ;
SCORE ;
 I '$D(^TMP($J,"YSCOR")) D  Q
 .S SC="| "_YSINSNAM_" score could not be determined. "
 ;
 S SCORE=$P($G(^TMP($J,"YSCOR",2)),"=",2)
 I YSSEX="F" D  Q
 .S SC="  Score: "_SCORE_" points, which is a "_$S(SCORE>=3:"positive",1:"negative")_" result."
 S SC="  Score: "_SCORE_" points, which is a "_$S(SCORE>=4:"positive",1:"negative")_" result."
 Q
 ;
SCORESV ;
 I $D(^TMP($J,"YSG",1)),^TMP($J,"YSG",1)="[ERROR]" D  Q  ;-->out
 .K ^TMP($J,"YSCOR")
 .S ^TMP($J,"YSCOR",1)="[ERROR]"
 .S ^TMP($J,"YSCOR",2)="No Scale found for ADMIN"
 ;
 K ^TMP($J,"YSCOR")
 S ^TMP($J,"YSCOR",1)="[DATA]"
 S ^TMP($J,"YSCOR",2)=$$GET1^DIQ(601.87,276_",",3,"I")_"="_SCORE
 Q
 ;
DLLSTR(YSDATA,YS,YSTRNG) ;
 ; YSTRNG = 1 Score Instrument
 ; YSTRNG = 2 get Report Answers and Text
 N DATA,LEG,NODE,SCORE,SC
 N YSCDA,YSDFN,YSINSNAM,YSSEX,YSQN
 ;
 S (SC,YSSEX)=""
 S SCORE=0
 D DATA1
 I YSTRNG=1 D SCORESV
 I YSTRNG=2 D
 .D LDSCORES^YTSCORE(.YSDATA,.YS)
 .D SCORE
 .S YSDATA($O(YSDATA(""),-1)+1)=999999999999_U_U_SC
 Q

YTSBAI ;SLC/PIJ - Score BAI ; 01/19/2016
 ;;5.01;MENTAL HEALTH;**123**;Dec 30, 1994;Build 73
 ;
 ;Public, Supported ICRs
 ; #2056 - Fileman API - $$GET1^DIQ
 ;
 Q
 ;
DATA1 ;
 S YSINSNAM=$P(YSDATA(2),U,3)
 I $G(YSINSNAM)="" S YSINSNAM=$G(YS("CODE"),"NO NAME PASSED")
 S NODE=2 F  S NODE=$O(YSDATA(NODE)) Q:NODE=""  D  ; Start at YSDATA(3)
 .S DATA=YSDATA(NODE)
 .S YSQN=$P($G(DATA),U,1)
 .S YSCDA=$P($G(DATA),U,3) ; Choice ID
 .; calculate skipped questions
 .I YSCDA=1155 S SKIPPED=SKIPPED+1  ; process instrument differently if > 5 questions skipped.  below.
 .S LEG=$$GET1^DIQ(601.75,YSCDA_",",4,"I")
 .S SCORE=SCORE+LEG
 .S YSAN=$$GET1^DIQ(601.75,YSCDA_",",3,"I")
 .I YSAN="Skipped"!(LEG="") S YSAN="Not Answered."
 .D DESGNTR^YTSCORE(YSQN,.DES)
 .S STRING=STRING_"| "_$G(DES)_". "_$P($G(YSAN),"(",1)
 .I LEG'="X" S STRING=STRING_"("_LEG_$S(LEG=1:" point",1:" points")_")"
 I SKIPPED>5 S SCORE="CND"
 Q
 ;
SCORE1 ;
 N RANGE,RISK
 I '$D(^TMP($J,"YSCOR")) D  Q
 .S STRING1="| "_YSINSNAM_" score could not be determined. "
 ;
 S SCORE=$P($G(^TMP($J,"YSCOR",2)),"=",2)
 I SKIPPED>5 S SCORE=-1 D
 .S STRING1=STRING1_"|BAI score could not be determined."
 ;
 I SCORE>-1 D
 .S RISK=$S(SCORE<8:"minimal",SCORE<16:"mild",SCORE<26:"moderate",1:"severe")
 .S RANGE=$S(SCORE<8:"between 0 - 7",SCORE<16:"between 8 - 15",SCORE<26:"between 16 - 25",1:"above 25")
 .S STRING1=STRING1_"|BAI Score: "_SCORE_" indicates "_RISK_" anxiety."
 S STRING1=STRING1_"||The overall range is 0 to 63"
 ;
 I SCORE=-1 S STRING1=STRING1_"."
 ELSE  S STRING1=STRING1_" with "_RISK_" anxiety "_RANGE_"."
 ;
 S STRING1=STRING1_"||  0-7      Minimal level of anxiety"
 S STRING1=STRING1_"|  8-15     Mild anxiety"
 S STRING1=STRING1_"|  16-25    Moderate anxiety"
 S STRING1=STRING1_"|  26-63    Severe anxiety"
 S STRING1=STRING1_"|| Questions and answers"
 S STRING1=STRING1_"| "_STRING
 Q
 ;
SCORESV ;
 ;
 I $D(^TMP($J,"YSG",1)),^TMP($J,"YSG",1)="[ERROR]" D  Q  ;-->out
 .K ^TMP($J,"YSCOR")
 .S ^TMP($J,"YSCOR",1)="[ERROR]"
 .S ^TMP($J,"YSCOR",2)=$G(YSINSNAM)_" Scale not found"
 ;
 K ^TMP($J,"YSCOR")
 S ^TMP($J,"YSCOR",1)="[DATA]"
 S ^TMP($J,"YSCOR",2)=$$GET1^DIQ(601.87,901_",",3,"I")_"="_SCORE
 Q
 ;
DLLSTR(YSDATA,YS,YSTRNG) ;
 ;  YSTRNG = 1 Score Instrument
 ;  YSTRNG = 2 get Report Answers and Text
 N DATA,DES,LEG,NODE,SCORE,SKIPPED,STRING,STRING1
 N YSCDA,YSINSNAM,YSAN,YSQN
 ;
 S (SKIPPED,SCORE)=0
 S (STRING,STRING1)=""
 ;
 D DATA1
 I YSTRNG=1 D
 .D SCORESV
 I YSTRNG=2 D
 .D LDSCORES^YTSCORE(.YSDATA,.YS)
 .D SCORE1
 .S YSDATA($O(YSDATA(""),-1)+1)=999999999999_U_U_STRING1
 Q

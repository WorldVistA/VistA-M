YTSBSS ;SLC/PIJ - Score BSS ; 01/19/2016
 ;;5.01;MENTAL HEALTH;**123**;Dec 30, 1994;Build 73
 ;
 Q
 ;
DATA1 ;
 S SCORE=0
 S YSINSNAM=$P($G(YSDATA(2)),U,3)
 I $G(YSINSNAM)="" S YSINSNAM=$G(YS("CODE"),"NO NAME PASSED")
 S NODE=2 F  S NODE=$O(YSDATA(NODE)) Q:NODE=""  D  ; Start at YSDATA(3)
 .S DATA=YSDATA(NODE)
 .S YSQN=$P($G(DATA),U,1)
 .S YSSEQ=$P($G(DATA),U,2),DES=YSSEQ
 .S YSCDA=$P($G(DATA),U,3)
 .S YSAN=$$GET1^DIQ(601.75,YSCDA_",",3,"I")
 .S LEG=$$GET1^DIQ(601.75,YSCDA,4,"I")
 .I (NODE'=22),(NODE'=23) D
 ..S SCORE=SCORE+LEG
 .;S STRING=STRING_"| "_DES_". "_YSAN_" ("_LEG_" points)"
 .S STRING=STRING_"| "_DES_". "_YSAN_" ("_LEG
 .S:LEG'=1 STRING=STRING_" points)"
 .S:LEG=1 STRING=STRING_" point)"
 Q
 ;
STRING ;
 I '$D(^TMP($J,"YSCOR")) D  Q
 .S STRING1=STRING1_"| "_YSINSNAM_" score could not be determined."
 .S STRING1=STRING1_"|| Questions and answers"
 ;
 S SCORE=$P($G(^TMP($J,"YSCOR",2)),"=",2)
 S STRING1=STRING1_" "_YSINSNAM_" Score: "_SCORE
 S STRING1=STRING1_"||The BSS is intended to assess thoughts, plans and intent to die by suicide "
 S STRING1=STRING1_"or attempt suicide over the past week. Total scores can range from 0-38."
 S STRING1=STRING1_" There is no specific cut-off score to classify severity or guide patient management, "
 S STRING1=STRING1_"however, increasing scores reflect greater risk, and any positive response to any"
 S STRING1=STRING1_" item may reflect the presence of suicidal intention and should be investigated further. "
 S STRING1=STRING1_"||Questions and answers|"
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
 ;Removed this scale.
 ;S ^TMP($J,"YSCOR",2)=$$GET1^DIQ(601.87,337_",",3,"I")_"="_SCORE  ; Suicidal Ideation
 S ^TMP($J,"YSCOR",2)=$$GET1^DIQ(601.87,900_",",3,"I")_"="_SCORE  ; Score
 Q
 ;
DLLSTR(YSDATA,YS,YSTRNG) ;
 ;  YSTRNG = 1 Score Instrument
 ;  YSTRNG = 2 get Report Answers and Text 
 N DATA,DES,LEG,NODE,YSAN,YSQN,YSCDA,SCORE
 N YSSEQ,YSINSNAM,STRING,STRING1
 ;
 S (STRING,STRING1)=""
 S SCORE=0
 ;
 D DATA1
 I YSTRNG=1 D SCORESV
 I YSTRNG=2 D
 .D LDSCORES^YTSCORE(.YSDATA,.YS)
 .D STRING
 .S STRING1=STRING1_STRING
 .S YSDATA($O(YSDATA(""),-1)+1)=999999999999_U_U_STRING1
 Q

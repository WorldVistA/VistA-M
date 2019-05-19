YTSFAST ;SLC/PIJ - Score FAST ; 01/08/2016
 ;;5.01;MENTAL HEALTH;**123**;DEC 30,1994;Build 72
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
 .S YSQN=$P(DATA,U,1)
 .S YSCDA=$P($G(DATA),U,3)
 .D DESGNTR^YTSCORE(YSQN,.DES)
 .S LEG=$$GET1^DIQ(601.75,YSCDA_",",4,"I")
 .I (DES=1),(LEG="Y") S STAGE=1 Q
 .I (DES=2),(LEG="Y") S STAGE=2 Q
 .I (DES=3),(STAGE=2),(LEG="Y") S STAGE=3 Q
 .I (DES=4),(STAGE=3),(LEG="Y") S STAGE=4 Q
 .I (DES=5),(STAGE=4),(LEG="Y") S STAGE=5 Q
 .I (DES="6a"),(STAGE=5),(LEG="Y") S STAGE=6 Q
 .I (DES="6b"),(STAGE=6),(LEG="Y") S STAGE=7 Q
 .I (DES="6c"),(STAGE=7),(LEG="Y") S STAGE=8 Q
 .I (DES="6d"),(STAGE=8),(LEG="Y") S STAGE=9 Q
 .I (DES="6e"),(STAGE=9),(LEG="Y") S STAGE=10 Q
 .I (DES="7a"),(STAGE=10),(LEG="Y") S STAGE=11 Q
 .I (DES="7b"),(STAGE=11),(LEG="Y") S STAGE=12 Q
 .I (DES="7c"),(STAGE=12),(LEG="Y") S STAGE=13 Q
 .I (DES="7d"),(STAGE=13),(LEG="Y") S STAGE=14 Q
 .I (DES="7e"),(STAGE=14),(LEG="Y") S STAGE=15 Q
 .I (DES="7f"),(STAGE=15),(LEG="Y") S STAGE=16 Q
 Q
 ;
STRING ;
 I (STAGE>5),(STAGE<11) S STAGE=6,STRING=STAGE Q
 I (STAGE>10),(STAGE<17) S STAGE=7,STRING=STAGE Q
 S STRING=STAGE
 Q
 ;
SCORESV ;
 I $D(^TMP($J,"YSG",1)),^TMP($J,"YSG",1)="[ERROR]" D  Q  ;-->out
 .K ^TMP($J,"YSCOR")
 .S ^TMP($J,"YSCOR",1)="[ERROR]"
 .S ^TMP($J,"YSCOR",2)=$G(YSINSNAM)_" Scale not found"
 S YSSCNAM=$P($G(^TMP($J,"YSG",3)),U,4)             ; Scale Name
 ;
 K ^TMP($J,"YSCOR")
 S ^TMP($J,"YSCOR",1)="[DATA]"
 S ^TMP($J,"YSCOR",2)=$$GET1^DIQ(601.87,509_",",3,"I")_"="_STAGE
 Q
 ;
DLLSTR(YSDATA,YS,YSTRNG) ;
 ;  YSTRNG = 1 Score Instrument
 ;  YSTRNG = 2 get Report Answers and Text
 N DATA,DES,LEG,NODE,STAGE,YSQN
 N YSCDA,YSSCNAM,YSINSNAM,STRING
 ;
 ; FAST returns a scale score which is calculated and stored, no special text in report
 I YSTRNG=2 Q
 ;
 S STRING=""
 S STAGE=1
 D DATA1
 D STRING
 D SCORESV
 Q

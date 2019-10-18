YTSDERS ;SLC/BLD- MHAX ANSWERS SPECIAL HANDLING FOR DERS
 ;;5.01;MENTAL HEALTH;**139**;DEC 30,1994;Build 134
 ;
 ;Public, Supported ICRs
 ; #2056 - Fileman API - $$GET1^DIQ
 ;
 Q
 ;
DLLSTR(YSDATA,YS,YSTRNG) ;
 ;  YSTRNG = 1 Score Instrument
 ;  YSTRNG = 2 get Report Answers and Text
 N DATA,DES,LEG,NODE,YSQN,YSSCALIEN,TOTSCORE,QUES,BASIS,TOTSCR,NONACPT,GOALS,IMPLUSE,STRATEGY,AWARNESS,CLARITY
 N YSCDA,YSSCNAM,YSINSNAM,STRING,STRING1,TOTSCR,I,YSARRAY
 ;
 ; Basis-24 Psychosis returns a scale score which is calculated and stored, no special text in report
 I YSTRNG=1 D SCORESV Q
 I YSTRNG=2 Q  ;D
 ;
 Q
 ;
STRING ;
 Q
 ;
DATA1 ;
 ;
 ;"Scale1=932^232^1^Non-acceptance of emotional responses^Accp"
 ;"Scale2=933^232^2^Difficulties engaging in goal-directed behavior^Goals"
 ;"Scale3=934^232^3^Impulse control difficulties^Impul"
 ;"Scale4=935^232^4^Limited access to emotion regulation strategies^Strat"
 ;"Scale5=936^232^5^Lack of emotional awareness^Aware"
 ;"Scale6=937^232^6^Lack of emotional clarity^Clar"
 ;"Scale7=1320^232^7^TOTAL" ;
 N I
 F I=3:1:38 S YSARRAY(1320)=$$GET1^DIQ(601.75,$P(YSDATA(I),"^",3)_",",4,"I")+$G(YSARRAY(1320))
 F I=13,14,23,25,27,31 S YSARRAY(932)=$$GET1^DIQ(601.75,$P(YSDATA(I),"^",3)_",",4,"I")+$G(YSARRAY(932))
 F I=15,20,22,28,35 S YSARRAY(933)=$$GET1^DIQ(601.75,$P(YSDATA(I),"^",3)_",",4,"I")+$G(YSARRAY(933))
 F I=5,16,21,26,29,35 S YSARRAY(934)=$$GET1^DIQ(601.75,$P(YSDATA(I),"^",3)_",",4,"I")+$G(YSARRAY(934))
 F I=17,18,24,30,32,33,37,38 S YSARRAY(935)=$$GET1^DIQ(601.75,$P(YSDATA(I),"^",3)_",",4,"I")+$G(YSARRAY(935))
 F I=4,8,10,12,19,36 S YSARRAY(936)=$$GET1^DIQ(601.75,$P(YSDATA(I),"^",3)_",",4,"I")+$G(YSARRAY(936))
 F I=3,6,7,9,11 S YSARRAY(937)=$$GET1^DIQ(601.75,$P(YSDATA(I),"^",3)_",",4,"I")+$G(YSARRAY(937))
 Q
 ;
SCORESV ;
 N YSSCGROUP,I
 D DATA1
 I $D(^TMP($J,"YSG",1)),^TMP($J,"YSG",1)="[ERROR]" D  Q  ;-->out
 .K ^TMP($J,"YSCOR")
 .S ^TMP($J,"YSCOR",1)="[ERROR]"
 .S ^TMP($J,"YSCOR",2)=$G(YSINSNAM)_" Scale not found"
 ;S YSSCNAM=$P($G(^TMP($J,"YSG",3)),U,4)             ; Scale Name
 ;
 K ^TMP($J,"YSCOR")
 ;
 S ^TMP($J,"YSCOR",1)="[DATA]"
 S I=""
 F I=3:1:9 D
 .S YSSCALIEN=$P($P(^TMP($J,"YSG",I),"^",1),"=",2)
 .S ^TMP($J,"YSCOR",I)=$$GET1^DIQ(601.87,YSSCALIEN_",",3,"I")_"="_+$FN(YSARRAY(YSSCALIEN),"",2)
 Q
 ;

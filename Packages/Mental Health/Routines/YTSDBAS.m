YTSDBAS ;SLC/BLD- MHAX ANSWERS SPECIAL HANDLING FOR DBAS
 ;;5.01;MENTAL HEALTH;**151**;DEC 30,1994;Build 92
 ;
 ;Public, Supported ICRs
 ; #2056 - Fileman API - $$GET1^DIQ
 ;
 Q
 ;
DLLSTR(YSDATA,YS,YSTRNG) ;
 ;  YSTRNG = 1 Score Instrument
 ;  YSTRNG = 2 get Report Answers and Text
 N DATA,DES,LEG,NODE,YSQN,YSSCALIEN,TOTSCORE,QUES,BASIS
 N YSCDA,YSSCNAM,YSINSNAM,STRING,STRING1,TOTSCR,I
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
 S TOTSCR=0
 F I=3:1 Q:'$D(YSDATA(I))  S TOTSCR=$G(TOTSCR)+$$GET1^DIQ(601.75,$P(YSDATA(I),"^",3)_",",4,"I")
 S TOTSCR=TOTSCR/16
 ;
 S YSSCGROUP=$P($P(^TMP($J,"YSG",2),"^",1),"=",2)
 S YSSCALIEN=$P($P(^TMP($J,"YSG",3),"^",1),"=",2)
 Q
 ;
SCORESV ;
 N YSSCGROUP
 D DATA1
 I $D(^TMP($J,"YSG",1)),^TMP($J,"YSG",1)="[ERROR]" D  Q  ;-->out
 .K ^TMP($J,"YSCOR")
 .S ^TMP($J,"YSCOR",1)="[ERROR]"
 .S ^TMP($J,"YSCOR",2)=$G(YSINSNAM)_" Scale not found"
 S YSSCNAM=$P($G(^TMP($J,"YSG",3)),U,4)             ; Scale Name
 ;
 K ^TMP($J,"YSCOR")
 ;
 S ^TMP($J,"YSCOR",1)="[DATA]"
 S ^TMP($J,"YSCOR",2)=$$GET1^DIQ(601.87,YSSCALIEN_",",3,"I")_"="_+$FN(TOTSCR,"",2)
 Q
 ;

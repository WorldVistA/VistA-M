YTSCES ;SLC/BLD - Score for Combat Exposure Scale (CES) ; 9/26/2018
 ;;5.01;MENTAL HEALTH;**123,147**;DEC 30,1994;Build 283
 ;
 ;Public, Supported ICRs
 ; #2056 - Fileman API - $$GET1^DIQ
 ;
 Q
 ;
DATA1 ;
 ;
 S QUES1=($$GET1^DIQ(601.75,$P(YSDATA(3),"^",3)_",",4,"I")-1)*2
 S QUES2=(+$$GET1^DIQ(601.75,$P(YSDATA(4),"^",3)_",",4,"I")-1)
 S QUES3=+$$GET1^DIQ(601.75,$P(YSDATA(5),"^",3)_",",4,"I") D
 .I QUES3>0,QUES3<5 S QUES3=(QUES3-1)*2
 .I QUES3=5 S QUES3=(QUES3-2)*2
 S QUES4=+$$GET1^DIQ(601.75,$P(YSDATA(6),"^",3)_",",4,"I") D
 .I QUES4>0,QUES4<5 S QUES4=QUES4-1
 .I QUES4=5 S QUES4=QUES4-2
 S QUES5=+$$GET1^DIQ(601.75,$P(YSDATA(7),"^",3)_",",4,"I")-1
 S QUES6=(+$$GET1^DIQ(601.75,$P(YSDATA(8),"^",3)_",",4,"I")-1)*2
 S QUES7=(+$$GET1^DIQ(601.75,$P(YSDATA(9),"^",3)_",",4,"I")-1)*2
 S TOTSCORE=QUES1+QUES2+QUES3+QUES4+QUES5+QUES6+QUES7
 S STRING1=TOTSCORE
 ;
 Q
 ;
STRING ;
 ;
 I '$D(^TMP($J,"YSCOR")) D LDSCORES(.YSDATA,.YS)
 S TOTSCORE=+$P(^TMP($J,"YSCOR",2),"=",2)
 I TOTSCORE'<0,TOTSCORE'>8 S STRING="Total Combat Exposure Score: "_TOTSCORE_" which indicates light Combat Exposure" S N=N+1
 I TOTSCORE>8,TOTSCORE<17 S STRING="Total Combat Exposure Score: "_TOTSCORE_" which indicates light - moderate Combat Exposure" S N=N+1
 I TOTSCORE>16,TOTSCORE<25 S STRING="Total Combat Exposure Score: "_TOTSCORE_" which indicates moderate Combat Exposure" S N=N+1
 I TOTSCORE>24,TOTSCORE<33 S STRING="Total Combat Exposure Score: "_TOTSCORE_" which indicates moderate-heavy Combat Exposure" S N=N+1
 I TOTSCORE>32,TOTSCORE<42 S STRING="Total Combat Exposure Score: "_TOTSCORE_" which indicates heavy Combat Exposure" S N=N+1
 Q
 ;
 ;
SCORESV ;
 D DATA1
 I $D(^TMP($J,"YSG",1)),^TMP($J,"YSG",1)="[ERROR]" D  Q  ;-->out
 .K ^TMP($J,"YSCOR")
 .S ^TMP($J,"YSCOR",1)="[ERROR]"
 .S ^TMP($J,"YSCOR",2)=$G(YSINSNAM)_" Scale not found"
 S YSSCNAM=$P($G(^TMP($J,"YSG",3)),U,4)             ; Scale Name
 ;
 K ^TMP($J,"YSCOR")
 S ^TMP($J,"YSCOR",1)="[DATA]"
 S YSSCALIEN=+$P(^TMP($J,"YSG",3),"=",2)
 S ^TMP($J,"YSCOR",2)=$$GET1^DIQ(601.87,YSSCALIEN_",",3,"I")_"="_STRING1
 Q
 ;
DLLSTR(YSDATA,YS,YSTRNG) ;
 ;  YSTRNG = 1 Score Instrument
 ;  YSTRNG = 2 get Report Answers and Text
 N DATA,DES,LEG,NODE,YSQN,YSSCALIEN,QUES5,QUES6,QUES7
 N YSCDA,YSSCNAM,YSINSNAM,STRING,STRING1,QUES3,QUES4
 N TOTAL,TXT,TEXT1,TEXT2,QUETOT,CES,QUES1,QUES2,TOTSCORE
 ;
 ; CES returns a scale score which is calculated and stored, no special text in report
 I YSTRNG=1 D SCORESV
 I YSTRNG=2 D
 .D STRING
 .S YSDATA(N)="7772^9999;1^"_STRING S N=N+1
 Q
 ;
LDSCORES(YSDATA,YS) ;  new call for patch 123
 ;input:AD = ADMINISTRATION #
 ;output: [DATA]
 N G,N,IEN71,SCALE,YSAD,YSCODEN,YSCALE
 S YSAD=$G(YS("AD"))
 ;
 S YSDATA=$NA(^TMP($J,"YSCOR"))
 S ^TMP($J,"YSCOR",1)="[DATA]",N=1
 ;
 S YSCALE="",N=1
 F  S YSCALE=$O(^YTT(601.92,"AC",YSAD,YSCALE))  Q:'YSCALE  D
 .S G=$G(^YTT(601.92,YSCALE,0))
 .S SCALE=$P(G,U,3),N=N+1
 .S ^TMP($J,"YSCOR",N)=SCALE_"="_$P(G,U,4,7)
 Q

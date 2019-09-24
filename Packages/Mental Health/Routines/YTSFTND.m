YTSFTND ;SLC/BLD - Fagerström Test for Nicotine Dependence (FTND)  ; 9/26/2018
 ;;5.01;MENTAL HEALTH;**147**;DEC 30,1994;Build 283
 ;
 ;Public, Supported ICRs
 ; #2056 - Fileman API - $$GET1^DIQ
 ;
 Q
 ;
DATA1 ;
 ;
 S TOTAL=0
 F I=3:1 Q:'$D(YSDATA(I))  S TOTAL=$G(TOTAL)+$$GET1^DIQ(601.75,$P(YSDATA(I),"^",3)_",",4,"I")
 ;
 Q
 ;
STRING ;
 ;
 N TXT,FTND,TEXT1,TEXT2,TEXT3,TXT2
 S N=N+1
 I '$D(^TMP($J,"YSCOR")) D LDSCORES(.YSDATA,.YS)
 I ^TMP($J,"YSCOR",1)'="[DATA]" Q
 S TOTAL=$P(^TMP($J,"YSCOR",2),"=",2)
 S TEXT1=" indicating "
 ;S TEXT2="nicotine dependence."
 I TOTAL<3 S TEXT3="VERY LOW nicotine dependence."
 I TOTAL>2,TOTAL<5 S TEXT3="LOW nicotine dependence."
 I TOTAL=5 S TEXT3="MEDIUM nicotine dependence."
 I TOTAL>5,TOTAL<8 S TEXT3="HIGH nicotine dependence."
 I TOTAL>7 S TEXT3="VERY HIGH nicotine dependence."
 S YSDATA(N)="7771^9999;1^"_TOTAL_TEXT1_TEXT3
 ;
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
 S ^TMP($J,"YSCOR",2)=$$GET1^DIQ(601.87,YSSCALIEN_",",3,"I")_"="_TOTAL
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

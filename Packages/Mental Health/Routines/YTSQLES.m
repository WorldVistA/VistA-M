YTSQLES ;SLC/MJB- SCORE QLES ; 9/26/2018
 ;;5.01;MENTAL HEALTH;**138**;DEC 30,1994;Build 68
 ;
 ;Public, Supported ICRs
 ; #2056 - Fileman API - $$GET1^DIQ
 ;
 Q
 ;
DLLSTR(YSDATA,YS,YSTRNG) ;
 ;
 N TOTAL,TXT,YSMED,YSOVER,YSTOTAL,YSCRIT9,YSCRIT11,YSCRIT12,YSCRIT13,YSCALEI,YSSCALIEN
 N YSCRIT9Q,YSCRIT11Q,YSCRIT12Q,YSCRIT13Q,YSCRITA,YSCRITB,YSCRITC,QLESQSF,II,YSTOTALA
 N YSSCNAM,YSINSNAM
 S N=N+1,II=0
 IF YSTRNG=1 D DATA1 D SCORESV
 I YSTRNG=2 D
 .D LDSCORES(.YSDATA,.YS) D YSARRAY(.QLESQSF) ;run YSARRAY again to get the responses and add 0 to skipped questions
 .D STRING
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
 S YSSCALIEN=1224   ;this needs to be changed to the current instrument scale
 S ^TMP($J,"YSCOR",2)=$$GET1^DIQ(601.87,YSSCALIEN_",",3,"I")_"="_YSTOTAL_U_YSTOTALA
 Q
 ;
DATA1 ;
 D YSARRAY(.QLESQSF)
 F II=3:1:16 S YSTOTAL=$G(YSTOTAL)+QLESQSF(II)
 S YSTOTALA=((YSTOTAL-14)/.56)
 S YSTOTALA=$FN(YSTOTALA,"",0)
 Q
 ;
STRING ;
 S YSTOTAL=$P($G(^TMP($J,"YSCOR",2)),"=",2),YSTOTAL=$P(YSTOTAL,U,1)
 S YSTOTALA=$P($G(^TMP($J,"YSCOR",2)),U,2)
 S YSMED=QLESQSF(17)
 S YSOVER=QLESQSF(18)
 S YSCRIT9=QLESQSF(11)
 S YSCRIT11=QLESQSF(13)
 S YSCRIT12=QLESQSF(14)
 S YSCRIT13=QLESQSF(15)
 S YSCRIT9Q="9. Your sexual drive, interest and/or performance?"
 S YSCRIT11Q="11. Your living/housing situation?"
 S YSCRIT12Q="12. Your ability to get around physically without feeling dizzy or unsteady or falling?"
 S YSCRIT13Q="13. Your vision in terms of ability to do work or hobbies?"
 S YSCRITA="1.Very Poor"
 S YSCRITB="2.Poor"
 S YSCRITC="3.Fair"
 I YSMED=0 S YSDATA(N)="7771^9999;1^Item omitted by respondent"  S N=N+1
 I YSMED=1 S YSDATA(N)="7771^9999;1^VERY POOR" S N=N+1
 I YSMED=2 S YSDATA(N)="7771^9999;1^POOR" S N=N+1
 I YSMED=3 S YSDATA(N)="7771^9999;1^FAIR" S N=N+1
 I YSMED=4 S YSDATA(N)="7771^9999;1^GOOD" S N=N+1
 I YSMED=5 S YSDATA(N)="7771^9999;1^VERY GOOD" S N=N+1
 I YSOVER=1 S YSDATA(N)="7772^9999;1^VERY POOR" S N=N+1
 I YSOVER=2 S YSDATA(N)="7772^9999;1^POOR" S N=N+1
 I YSOVER=3 S YSDATA(N)="7772^9999;1^FAIR" S N=N+1
 I YSOVER=4 S YSDATA(N)="7772^9999;1^GOOD" S N=N+1
 I YSOVER=5 S YSDATA(N)="7772^9999;1^VERY GOOD" S N=N+1
 I (YSCRIT9=1)!(YSCRIT9=2)!(YSCRIT9=3) S YSDATA(N)="7773^9999;1^"_YSCRIT9Q S N=N+1
 I YSCRIT9=1 S YSDATA(N)="7774^9999;1^"_YSCRITA S N=N+1
 I YSCRIT9=2 S YSDATA(N)="7774^9999;1^"_YSCRITB S N=N+1
 I YSCRIT9=3 S YSDATA(N)="7774^9999;1^"_YSCRITC S N=N+1
 I (YSCRIT11=1)!(YSCRIT11=2)!(YSCRIT11=3) S YSDATA(N)="7775^9999;1^"_YSCRIT11Q S N=N+1
 I YSCRIT11=1 S YSDATA(N)="7780^9999;1^"_YSCRITA S N=N+1
 I YSCRIT11=2 S YSDATA(N)="7780^9999;1^"_YSCRITB S N=N+1
 I YSCRIT11=3 S YSDATA(N)="7780^9999;1^"_YSCRITC S N=N+1
 I (YSCRIT12=1)!(YSCRIT12=2)!(YSCRIT12=3) S YSDATA(N)="7776^9999;1^"_YSCRIT12Q S N=N+1
 I YSCRIT12=1 S YSDATA(N)="7781^9999;1^"_YSCRITA S N=N+1
 I YSCRIT12=2 S YSDATA(N)="7781^9999;1^"_YSCRITB S N=N+1
 I YSCRIT12=3 S YSDATA(N)="7781^9999;1^"_YSCRITC S N=N+1
 I (YSCRIT13=1)!(YSCRIT13=2)!(YSCRIT13=3) S YSDATA(N)="7777^9999;1^"_YSCRIT13Q S N=N+1
 I YSCRIT13=1 S YSDATA(N)="7782^9999;1^"_YSCRITA S N=N+1
 I YSCRIT13=2 S YSDATA(N)="7782^9999;1^"_YSCRITB S N=N+1
 I YSCRIT13=3 S YSDATA(N)="7782^9999;1^"_YSCRITC S N=N+1
 I (YSCRIT9)&(YSCRIT11)&(YSCRIT12)&(YSCRIT13)>3 S YSDATA(N)="7778^9999;1^The patient did not endorse critical items"
 S YSDATA(N)="7779^9999;1^"_YSTOTALA S N=N+1
 ;
 Q
 ;
YSARRAY(YSARRAY) ;
 N II,YSVAL,YSCALEI,YSKEYI,G,YSQN,YSAI,YSAN,YSTARG
 K YSARRAY
 S II=""
 F II=3:1:18 S YSQN=$P(YSDATA(II),U,1),YSAN=$P(YSDATA(II),U,3) D
 .I YSAN=1155 S YSVAL=0
 .I YSAN=3921 S YSVAL=1
 .I YSAN=3922 S YSVAL=2
 .I YSAN=3923 S YSVAL=3
 .I YSAN=3924 S YSVAL=4
 .I YSAN=3925 S YSVAL=5
 .I YSAN=3926 S YSVAL=0
 .S YSARRAY(II)=YSVAL
 Q
LDSCORES(YSDATA,YS) ;  new call for patch 123 using to get T-scores
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

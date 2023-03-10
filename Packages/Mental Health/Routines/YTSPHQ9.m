YTSPHQ9 ;SLC/KCM - Score PHQ9 ; 01/08/2016
 ;;5.01;MENTAL HEALTH;**141**;DEC 30,1994;Build 85
 ;
DLLSTR(YSDATA,YS,YSMODE) ; main tag for both scores and report text
 ;.YSDATA(1)=[DATA]
 ;.YSDATA(2)=adminId^dfn^testNm^dtGiven^complete
 ;.YSDATA(3..n)=questionId^sequence^choiceId
 ;.YS("AD")=adminId
 ;YSMODE=1 for calc score, 2 for report text
 ;
 ; if score, calculate based on answers in YSDATA, save in ^TMP($J,"YSCOR")
 I YSMODE=1 D SCORE(.YSDATA) QUIT
 ; if report, build special text, add pseudo-question to YSDATA
 I YSMODE=2 D REPORT(.YSDATA) QUIT
 Q
SCORE(YSDATA) ; iterate through answers and calculate score
 ; looks like this is in every scoring routine...
 ; SCOREINS^YTSCORE sets up ^TMP($J,"YSG") with scales
 ; if no scales are defined, we can't score instrument
 I $D(^TMP($J,"YSG",1)),^TMP($J,"YSG",1)="[ERROR]" D  Q  ;-->out
 .K ^TMP($J,"YSCOR")
 .S ^TMP($J,"YSCOR",1)="[ERROR]"
 .S ^TMP($J,"YSCOR",2)="No Scale found for ADMIN"
 ;
 N I,Q,C,S,V,T,E  ; Q=question,C=choice,S=skips,V=value,T=total,E=error
 S S=0,T=0,E=""
 S I=2 F  S I=$O(YSDATA(I)) Q:'I  D
 . S Q=$P(YSDATA(I),U) Q:Q=4019  ; q10 not part of score
 . S C=$P(YSDATA(I),U,3)
 . ; use choice ID's of 212, 1008, 1009, 1010 for scoring
 . ; skipped questions are 1155, 1156, or 1157
 . S V=$S(C=212:0,C=1008:1,C=1009:2,C=1010:3,C=1155!(C=1156)!(C=1157):"X",1:"?")
 . S T=T+V S:V="X" S=S+1
 ; if 1 or 2 skipped questions, set their value to average and add to total 
 I S>0,(S<3) S V=T/(9-S) S T=T+(S*V) S T=+$P((T+0.5),".")
 I S>2 S T="Due to missing Items, this administration cannot be scored."
 I $L(E) S T="Due to unrecognized responses, this administration cannot be scored."
 ;
 S S=$P(^YTT(601.87,419,0),U,4) ; 419 is PHQ9 Total scale
 K ^TMP($J,"YSCOR")
 S ^TMP($J,"YSCOR",1)="[DATA]"
 S ^TMP($J,"YSCOR",2)=S_"="_T
 Q
REPORT(YSDATA) ; return special question 9 text
 ; this was formerly handled in YTAPI2A
 ; Questions:  3382 = PHQ9 question #9
 ;   Choices:  1008 = Several days, 1009 = More than half the days,
 ;             1010 = Nearly every day
 N I,A
 S A=0  ; A=answer
 S I=2 F  S I=$O(YSDATA(I)) Q:'I  D  Q:A
 . I $P(YSDATA(I),U)=3382 S A=+$P(YSDATA(I),U,3)  ; q9 is #3382
 I A=1008!(A=1009)!(A=1010) D
 . S I=$O(YSDATA(""),-1)+1
 . S YSDATA(I)="7771^9999;1^Question 9 answered in the POSITIVE direction, additional clinical assessment is indicated."
 Q

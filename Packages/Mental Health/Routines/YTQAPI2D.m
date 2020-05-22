YTQAPI2D ;SLC/BLD- MHAX ANSWERS SPECIAL HANDLING #2 ; 9/27/18 10:27am
 ;;5.01;MENTAL HEALTH;**147,150**;Dec 30, 1994;Build 210
 ;
 ; This routine was split from YTQAPI2A.
 ; This routine handles limited complex reporting requirements without
 ; modifying YS_AUX.DLL by adding free text "answers" that can be used by
 ; a report.
 ;,
 ; Assumptions:  EDIT incomplete instrument should ignore the extra answers
 ; since there are no associated questions.  GRAPHING should ignore the
 ; answers since they not numeric.
 ;
SPECIAL(TSTNM,YSDATA,N,YSAD,YSTSTN,QUIT) ; add "hidden" computed question text
 ;
 N ANSWER,DEPSCORE,IEN,KEY,LP,PCT,PTSD,SATTSCORE,SCORES,SCRE,SUCSCORE,SUISCORE,SWHENSCORES,TEXT,TEXT1,TEXT2
 N TEXT2A,TEXT2B,TOT,YSCORE,YSCREC,SUISCRN,ALLQUES,POSTXT1,POSTXT2,QUE1621,QUE67,QUE915
 ;
 I TSTNM="AD8" D  Q
 .N TOTAL,TXT
 .S N=N+1
 .D GETSCORE^YTQAPI8(.YSCORE,.YS)
 .I ^TMP($J,"YSCOR",1)'="[DATA]" Q
 .S TOTAL=$P(^TMP($J,"YSCOR",2),"=",2)
 .I TOTAL>1 S TXT="COGNITIVE IMPAIRMENT IS LIKELY TO BE PRESENT."
 .I TOTAL<2 S TXT="NORMAL COGNITION"
 .S YSDATA(N)="7771^9999;1^"_TXT S N=N+1
 ;
 I TSTNM="EPDS" D  Q
 .N TOTAL,TXT,EPDS
 .S N=N+1
 .D GETSCORE^YTQAPI8(.YSCORE,.YS)
 .I ^TMP($J,"YSCOR",1)'="[DATA]" Q
 .D YSARRAY^YTQAPI2C(.EPDS)
 .I $G(EPDS(10)) D
 ..S TXT="Question 10 that assesses ""thought of harming"" oneself was answered in the "
 ..S TXT2="POSITIVE direction, additional clinical assessment is indicated."
 ..S YSDATA(N)="7771^9999;1^"_TXT S N=N+1
 ..S YSDATA(N)="7772^9999;1^"_TXT2 S N=N+1
 ; 
 I TSTNM="FTND" D
 .Q
 .N TOTAL,TXT,FTND,TEXT1,TEXT2,TEXT3,TXT2
 .S N=N+1
 .D GETSCORE^YTQAPI8(.YSCORE,.YS)
 .I ^TMP($J,"YSCOR",1)'="[DATA]" Q
 .;D YSARRAY^YTQAPI2C(.FTND)
 .S TOTAL=$P(^TMP($J,"YSCOR",2),"=",2)
 .S TEXT1=" indicating "
 .;S TEXT2="nicotine dependence."
 .I TOTAL<3 S TEXT3="VERY LOW nicotine dependence."
 .I TOTAL>2,TOTAL<5 S TEXT3="LOW nicotine dependence."
 .I TOTAL=5 S TEXT3="MEDIUM nicotine dependence."
 .I TOTAL>5,TOTAL<8 S TEXT3="HIGH nicotine dependence."
 .I TOTAL>7 S TEXT3="VERY HIGH nicotine dependence."
 .S YSDATA(N)="7771^9999;1^"_TOTAL_TEXT1_TEXT3
 .;
 ;
 ;
 ;I $L($T(SPECIAL^YTQAPI2E)) D SPECIAL^YTQAPI2E(TSTNM,.YSDATA,N,.YSAD,.YSTSTN)
 Q 

YTQAPI2B ;SLC/BLD- MHAX ANSWERS SPECIAL HANDLING #2 ;2/7/2018  17:35
 ;;5.01;MENTAL HEALTH;**134,136**;Dec 30, 1994;Build 235
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
SPECIAL(TSTNM,YSDATA,N,YSAD,YSTSTN) ; 1 add "hidden" computed question text
 N ANSWER,DEPSCORE,IEN,KEY,LP,PCT,PTSD,SATTSCORE,SCORES,SCRE,SUCSCORE,SUISCORE,SWHENSCORES,TEXT,TEXT1,TEXT2
 N TEXT2A,TEXT2B,TOT,YSCORE,YSCREC,SUISCRN,ALLQUES,POSTXT1,POSTXT2,QUE1621,QUE67,QUE915
 ;
 I TSTNM="PC-PTSD-5+I9" D  Q
 .N I,YSCORE,PTSD,SCORES,SUISCRN,SWHENSCORE,TEXT
 .S (ANSWER,SCORES)=0
 .D GETSCORE^YTQAPI8(.YSCORE,.YS)
 .S SCORES=$P(^TMP($J,"YSCOR",2),"=",2)
 .I SCORES=0 D
 ..S YSDATA(N)="7771^9999;1^The score for this administration indicates a NEGATIVE screen for PTSD." S N=N+1
 .S SUISCORE=$P(^TMP($J,"YSCOR",3),"=",2)
 .I $G(SCORES)<4,$G(SCORES)>0 D
 ..S YSDATA(N)="7771^9999;1^The score for this administration is "_SCORES_", which indicates ",N=N+1
 ..S YSDATA(N)="7772^9999;1^   a NEGATIVE screen for PTSD in the past month." S N=N+1
 .I $G(SCORES)>3 D
 ..S YSDATA(N)="7771^9999;1^The score for this administration is "_SCORES_", which indicates ",N=N+1
 ..S YSDATA(N)="7772^9999;1^   a POSITIVE screen for PTSD in the past month. Further assessment is recommended.",N=N+1
 .;
 .I $G(SUISCORE)=0 D
 ..;S YSDATA(N)="7773^9999;1^The results of this administration indicates a NEGATIVE screen ",N=N+1
 ..;S YSDATA(N)="7774^9999;1^   for Risk of Suicide over the last 2 weeks.",N=N+1
 ..S YSDATA(N)="7773^9999;1^The score on this administration is 0, which indicates a NEGATIVE ",N=N+1
 ..S YSDATA(N)="7774^9999;1^   screen for Risk of Suicide over the last 2 weeks."
 .S SUISCRN=$P(^TMP($J,"YSCOR",3),"=",2)
 .I SUISCRN>0 D
 ..I SUISCRN=1 S TEXT="SEVERAL DAYS"
 ..I SUISCRN=2 S TEXT="MORE THAN HALF THE DAYS"
 ..I SUISCRN=3 S TEXT="NEARLY EVERY DAY"
 ..S YSDATA(N)="7773^9999;1^The score on this administration is "_SUISCRN_", which revealed suicidal ideation "_TEXT,N=N+1
 ..S YSDATA(N)="7774^9999;1^   over the last 2 weeks, which indicates a POSITIVE screen for Risk of Suicide.",N=N+1
 .Q
 ;
 ;bld 3/1/2018 Complex Reporting for PC-PTSD-5
 I TSTNM="PC-PTSD-5" D  Q
 .N I,YSCORE,PTSD,SCORES,TEXT
 .S SCORES=0
 .D GETSCORE^YTQAPI8(.YSCORE,.YS)
 .S SCORES=$P(^TMP($J,"YSCOR",2),"=",2)
 .I $G(SCORES)'>3 D
 ..S YSDATA(N)="7771^9999;1^ The score on this administration is "_SCORES_", which indicates a NEGATIVE screen for ",N=N+1
 ..S YSDATA(N)="7772^9999;1^ PTSD in the past month.",N=N+1
 .I $G(SCORES)>3 D
 ..S YSDATA(N)="7771^9999;1^ The score on this administration is "_SCORES_", which indicates a POSITIVE screen for ",N=N+1
 ..S YSDATA(N)="7772^9999;1^ PTSD in the past month. Further assessment is recommended."
 ;
 ;bld 3/1/2018 Complex Reporting for PHQ-2+I9
 I TSTNM="PHQ-2+I9" D  Q
 .N I,DEPSCORE,SUCSCORE,YSCORE,TEXT
 .S N=N+1
 .D GETSCORE^YTQAPI8(.YSCORE,.YS)
 .S DEPSCORE=^TMP($J,"YSCOR",2)
 .S DEPSCORE=$P(DEPSCORE,"=",2)
 .S SUISCORE=^TMP($J,"YSCOR",3)
 .S SUISCORE=$P(SUISCORE,"=",2)
 .I DEPSCORE'>2 D
 ..S YSDATA(N)="7771^9999;1^The score on this administration is "_$G(DEPSCORE)_", which indicates a NEGATIVE screen ",N=N+1
 ..S YSDATA(N)="7772^9999;1^ on the Depression Scale over the past 2 weeks.",N=N+1
 .I DEPSCORE>2 D
 ..S YSDATA(N)="7771^9999;1^The score on this administration is "_$G(DEPSCORE)_", which indicates a POSITIVE screen ",N=N+1
 ..S YSDATA(N)="7772^9999;1^ on the Depression Scale over the past 2 weeks.",N=N+1
 .I SUISCORE=0 D
 ..S YSDATA(N)="7773^9999;1^The score on this administration is "_SUISCORE_", which indicates a NEGATIVE screen ",N=N+1
 ..S YSDATA(N)="7774^9999;1^ for Risk of Suicide over the past 2 weeks.",N=N+1
 .I SUISCORE>0 D
 ..I SUISCORE=1 S TEXT="SEVERAL DAYS"
 ..I SUISCORE=2 S TEXT="MORE THAN HALF THE DAYS"
 ..I SUISCORE=3 S TEXT="NEARLY EVERY DAY"
 ..S YSDATA(N)="7773^9999;1^The score on this administration is "_SUISCORE_", which revealed suicidal ideation "_TEXT,N=N+1
 ..S YSDATA(N)="7774^9999;1^  over the past 2 weeks, which indicates a POSITIVE screen for Risk of Suicide.",N=N+1
 .Q
 ;
 ;bld/dsb 3/1/2018 Complex Reporting for C-SSRS
 I TSTNM="C-SSRS" D  Q
 .N I,YSCORE,YSCREC,PTSD,SCORES,SCRE,QUESNBR,TEXT,TEXT1,TEXT2,TEXT2A,TEXT2B,TEXT3,TEXT3A,TEXT4,TEXT5,TEXT8,TEXT8A,TEXT8B,ADDTEXT
 .S SCORES=""
 .D GETSCORE^YTQAPI8(.YSCORE,.YS)
 .I ^TMP($J,"YSCOR",1)'="[DATA]" Q
 .S LP=1
 .S ADDTEXT="This indicates a clear need for further assessment and clinical management."
 .S TEXT1="This administration indicates presence of SUICIDAL IDEATION WITH AT LEAST SOME INTENT TO DIE in the past one month. "_ADDTEXT
 .S TEXT2A="This administration indicates presence of RECENT SUICIDAL BEHAVIOR. The presence of ANY suicidal behavior (suicide attempt,"
 .S TEXT2B=" interrupted attempt, aborted attempt and preparatory behavior) in the past 3 months indicates clear need for further assessment and clinical management."
 .S TEXT2=TEXT2A_TEXT2B
 .;
 .S TEXT3="This administration indicates presence of SUICIDAL IDEATION "
 .S TEXT3A="WITH AT LEAST SOME INTENT TO DIE in the past month. "  ;q4=yes, q5=no
 .;
 .S TEXT8="This administration indicates presence of RECENT SUICIDAL BEHAVIOR. The presence of ANY suicidal "
 .S TEXT8A="behavior (suicide attempt, interrupted attempt, aborted attempt and preparatory behavior) "
 .S TEXT8B="in the past 3 months indicates clear need for further assessment and clinical management."
 .F  S LP=$O(^TMP($J,"YSCOR",LP)) Q:'LP  D
 ..; Yes=1, No=2 and Skipped=0
 ..S SCRE=$P(^TMP($J,"YSCOR",LP),"=",2)
 ..S SCORES=SCORES_SCRE
 .; get Suicidal Ideation in last month - question 1 and 2
 .D
 ..I $E(SCORES,2)=1 S YSDATA(N)="7771^9999;1^Yes - Suicidal thoughts" S N=N+1 Q
 ..I ($E(SCORES,1)=1)&($E(SCORES,2)=2) S YSDATA(N)="7771^9999;1^Yes - Wish to die" S N=N+1 Q
 ..I ($E(SCORES,1)=2)&($E(SCORES,2)=2) S YSDATA(N)="7771^9999;1^None endorsed" S N=N+1 Q
 . ;
 . ; get Method/plan/Intent in last month - question 3,4,5 and 6
 . S IEN=N
 . D  I '$D(YSDATA(IEN)) D CSSRS(SCORES)
 ..I ($E(SCORES,5)=1)&($E(SCORES,6)=1) S YSDATA(N)="7772^9999;1^Method with specific plan and intent"  S N=N+1 Q
 ..I ($E(SCORES,5)=1)&($E(SCORES,6)=2) S YSDATA(N)="7772^9999;1^Method with specific plan and at least some intent"  S N=N+1 Q
 ..I ($E(SCORES,3)=1)&($E(SCORES,4)=1)&($E(SCORES,5)=1)&($E(SCORES,6)=2) S YSDATA(N)="7772^9999;1^Method with specific plan and at least some intent"  S N=N+1 Q
 ..I ($E(SCORES,3)=1)&($E(SCORES,4)=1)&($E(SCORES,5)=2) S YSDATA(N)="7772^9999;1^Method with at least some intent and no specific plan"  S N=N+1 Q
 ..I ($E(SCORES,3)=1)&($E(SCORES,4)=2)&($E(SCORES,5)=2) S YSDATA(N)="7772^9999;1^Method but with no specific plan or intent"  S N=N+1 Q
 ..I ($E(SCORES,3)=2)&($E(SCORES,4)=2)&($E(SCORES,5)=2) S YSDATA(N)="7772^9999;1^No method, no specific plan, and no intent"  S N=N+1 Q
 ..I ($E(SCORES,3)=2)&($E(SCORES,4)=2)&($E(SCORES,5)=1) S YSDATA(N)="7772^9999;1^Method with specific plan and no intent"  S N=N+1 Q
 ..I ($E(SCORES,3)=2)&($E(SCORES,4)=1)&($E(SCORES,5)=1)&($E(SCORES,6)=1) S YSDATA(N)="7772^9999;1^Method with specific plan and some intent"  S N=N+1 Q
 ..I ($E(SCORES,3)=2)&($E(SCORES,4)=1)&($E(SCORES,5)=2) S YSDATA(N)="7772^9999;1^Method with at least some intent and no specific plan"  S N=N+1 Q
 ..I ($E(SCORES,3)=0)&($E(SCORES,4)=0)&($E(SCORES,5)=0) S YSDATA(N)="7772^9999;1^No method, no specific plan, and no intent"  S N=N+1 Q
 .;
 .; get Sucidal Behavior based on question 7 and 8
 .D
 ..I ($E(SCORES,8)=1) S YSDATA(N)="7773^9999;1^Recent Suicidal Behavior (<3 months)"  S N=N+1 Q
 ..I ($E(SCORES,7)=1)&($E(SCORES,8)=2) S YSDATA(N)="7773^9999;1^Past Suicidal Behavior (>3 Months)"  S N=N+1 Q
 ..I ($E(SCORES,7)=2) S YSDATA(N)="7773^9999;1^No Past Suicidal Behavior Reported"  S N=N+1 Q
 .;
 .;Key Indicators
 .S QUESNBR=7774
 .S KEY=""
 .I ($E(SCORES,4)=1)!($E(SCORES,5)=1) D
 ..S YSDATA(N)="7774^9999;1^"_TEXT3,N=N+1
 ..S YSDATA(N)="7775^9999;1^"_TEXT3A,N=N+1
 ..S YSDATA(N)="7776^9999;1^"_ADDTEXT,N=N+1
 ..S N=N+1,QUESNBR=7777,KEY=1
 .;
 .I ($E(SCORES,8)=1) D
 ..S YSDATA(N)=QUESNBR_"^9999;1^"_TEXT8 S N=N+1,QUESNBR=QUESNBR+1
 ..S YSDATA(N)=QUESNBR_"^9999;1^"_TEXT8A S N=N+1,QUESNBR=QUESNBR+1
 ..S YSDATA(N)=QUESNBR_"^9999;1^"_TEXT8B S N=N+1,QUESNBR=QUESNBR+1,KEY=1
 .I 'KEY S YSDATA(N)="7774^9999;1^None" S N=N+1
 .; Get results code is saved in One Note
 .Q
 ;
 ;dsb/BLD 3/1/2018 Complex Reporting for PSS-3
 I TSTNM="PSS-3" D  Q
 .N I,YSCORE,PTSD,SCORES,DEPSCORE,SUISCORE,SATTSCORE,SWHENSCORES,SWHENSCORE,YSPSS3
 .S SCORES=0
 .S N=N+1
 .D GETSCORE^YTQAPI8(.YSCORE,.YS)
 .D PSS3(.YSPSS3)
 .I ^TMP($J,"YSCOR",1)'="[DATA]" Q
 .S DEPSCORE=$P(^TMP($J,"YSCOR",2),"=",2)
 .S SUISCORE=$P(^TMP($J,"YSCOR",3),"=",2)
 .S SATTSCORE=YSPSS3(7791)
 .I DEPSCORE=0 S YSDATA(N)="7771^9999;1^The score for this administration is No, which indicates a NEGATIVE Screen for Depressed Mood"
 .I DEPSCORE=1 S YSDATA(N)="7771^9999;1^The score for this administration is Yes, which indicates a POSITIVE Screen for Depressed Mood"
 .S N=N+1
 .I SUISCORE=0 S YSDATA(N)="7772^9999;1^The score for this administration is No, which indicates a NEGATIVE Screen for Active Suicidal Ideation"
 .I SUISCORE=1 S YSDATA(N)="7772^9999;1^The score for this administration is Yes, which indicates a POSITIVE Screen for Active Suicidal Ideation"
 .S N=N+1
 .I SATTSCORE=0 S YSDATA(N+1)="7773^9999;1^The score for this administration is No, which indicates a NEGATIVE Screen for Recent Suicide Attempt"
 .I $G(SATTSCORE) D
 ..S SWHENSCORE=YSPSS3(7792)
 ..S N=N+1
 ..I SWHENSCORE>3 S YSDATA(N)="7773^9999;1^The score for this administration is No, which indicates a NEGATIVE Screen for Recent Suicide Attempt"
 ..I SWHENSCORE<4 S YSDATA(N)="7773^9999;1^The score for this administration is Yes, which indicates a POSITIVE Screen for Recent Suicide Attempt"
 .Q
 ;
 ;bld/dsb 3/1/2018 Complex Reporting for WHODAS2.0-12
 I TSTNM="WHODAS2.0-12" D  Q
 .N I,PCT,LP,TOT,YSCORE
 .S (PCT,TOT)=0
 .D GETSCORE^YTQAPI8(.YSCORE,.YS)
 .I ^TMP($J,"YSCOR",1)'="[DATA]" Q
 .S LP=1
 .F  S LP=$O(^TMP($J,"YSCOR",LP)) Q:'LP  D
 ..S TOT=TOT+$P(^TMP($J,"YSCOR",LP),"=",2)
 .S YSDATA(N)="7771^9999;1^"_TOT
 .Q
 ;
 I $L($T(SPECIAL^YTQAPI2C)) D SPECIAL^YTQAPI2C(TSTNM,.YSDATA,N,.YSAD,.YSTSTN) Q
 Q
  ;
CSSRS(SCORES) ;logic for method/plan/intent section of CSSRS report
 ;
 I ($E(SCORES,5)=1)&($E(SCORES,6)=1) S YSDATA(N)="7772^9999;1^Method with specific plan and at least some intent"  S N=N+1 Q
 I ($E(SCORES,5)=1)&($E(SCORES,6)=2) S YSDATA(N)="7772^9999;1^Method with specific plan and no intent" S N=N+1 Q
 ;
PSS3(YSPSS3) ;
 N YSQN,YSAI,YSAN,YSANS
 F YSQN=7791,7792 D
 .S YSAI=$O(^YTT(601.85,"AC",YSAD,YSQN,0))
 .Q:YSAI'>0
 .Q:'$D(^YTT(601.85,YSAI,0))  ;ASF 11/15/07
 .S YSAN=""
 .I $P(^YTT(601.85,YSAI,0),U,4)?1N.N S YSAN=$P(^YTT(601.85,YSAI,0),U,4),YSAN=$G(^YTT(601.75,YSAN,1)),YSPSS3(YSQN)=YSAN
 ;
 I YSPSS3(7791)="Yes" S YSPSS3(7791)=1
 E  S YSPSS3(7791)=0
 S YSANS=YSPSS3(7792)
 I YSANS["Within the past 24 hours (including today)" S YSPSS3(7792)=1 Q
 I YSANS["Within the last month (but not today)" S YSPSS3(7792)=2 Q
 I YSANS["Between 1 and 6 months ago" S YSPSS3(7792)=3 Q
 I YSANS["More than 6 months ago" S YSPSS3(7792)=4 Q
 E  S YSPSS3(7792)=5
 Q

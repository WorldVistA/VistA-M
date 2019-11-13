YTSI9CSS ;SLC/BLD- MHAX ANSWERS SPECIAL HANDLING FOR I9-CSS; 10/11/18 2:18pm
 ;;5.01;MENTAL HEALTH;**151**;DEC 30,1994;Build 92
 ;
DATA1(SCORE) ;expects YSDATA, returns SCORE, multiple scales so we use nodes i.e. SCORE(SCALEIEN)=###
 ;specialized DATA1 uses SCOREDATA table to map question to score relationships
 N QUES,TEXT
 F I=1:1:9 D
 .N SCALE,NODE,DATA,RAW
 .S SCALE=I+1126
 .S NODE=I+2 ;YSDATA question nodes start at 3
 .S DATA=YSDATA(NODE)
 .S RAW=$$GET1^DIQ(601.75,$P($G(DATA),U,3)_",",4,"I")
 .I RAW="X" S RAW="" ;skipped question
 .S SCORE(SCALE)=RAW
 Q
 ;
DLLSTR(YSDATA,YS,YSTRNG) ;
 ;  YSTRNG = 1 Score Instrument
 ;  YSTRNG = 2 get Report Answers and Text
 N DATA,DES,LEG,NODE,YSQN,YSSCALIEN,TOTSCORE
 N YSCDA,YSSCNAM,YSINSNAM,STRING,STRING1,YSCORE
 ;
 I YSTRNG=1 D DATA1(.SCORE),SCORESV(.SCORE)
 I YSTRNG=2 D LDSCORES^YTSCORE("",.YS),BUILDANS(.YSDATA,YSAD)
 Q
 ;
SCORESV(SCORE) ;Expects SCORE to be in format SCORE(SCALE_IEN)=###.  Also expects ^TMP($J,"YSG")
 N YSCORNODE,YSGNODE
 I $D(^TMP($J,"YSG",1)),^TMP($J,"YSG",1)="[ERROR]" D  Q  ;-->out
 .K ^TMP($J,"YSCOR")
 .S ^TMP($J,"YSCOR",1)="[ERROR]"
 .S ^TMP($J,"YSCOR",2)="No Scale found for ADMIN"
 ;
 K ^TMP($J,"YSCOR")
 S ^TMP($J,"YSCOR",1)="[DATA]"
 S YSCORNODE=2
 S YSGNODE=2 F  S YSGNODE=$O(^TMP($J,"YSG",YSGNODE)) Q:YSGNODE=""  D
 .N SCALEIEN
 .I $E(^TMP($J,"YSG",YSGNODE),1,5)'="Scale" Q  ;only read the lines for scales
 .S SCALEIEN=+$P(^TMP($J,"YSG",YSGNODE),"=",2) ;grab the first number after "=" sign
 .S ^TMP($J,"YSCOR",YSCORNODE)=$$GET1^DIQ(601.87,SCALEIEN_",",3,"I")_"="_SCORE(SCALEIEN)
 .S YSCORNODE=YSCORNODE+1
 ;
 Q
 ;
BUILDANS(YSDATA,YSAD) ; add "hidden" computed question text
 ;
 N IEN,LP,SCRE,TEXT,TEXT1,TEXT1A,TEXT1B,TEXT2,TEXT2A,TEXT2B,I,SCORES,N
 S N=$O(YSDATA(""),-1)+1
 S SCORES=""
 I ^TMP($J,"YSCOR",1)'="[DATA]" Q
 S LP=1
 S TEXT1="The results of this administration suggest the presence of at least some suicidal ideation without"
 S TEXT1A="specific plan or intent AND/OR a history of suicidal behavior."
 S TEXT1B="Further suicide risk evaluation or clinical management may be needed."
 S TEXT2="The results of this administration suggest the presence of SUICIDAL IDEATION WITH AT LEAST SOME"
 S TEXT2A="INTENT TO DIE in the past one month AND/OR presence of RECENT SUICIDAL BEHAVIOR. This indicates a"
 S TEXT2B="need for further suicide risk evaluation and clinical management."
 ;
 F  S LP=$O(^TMP($J,"YSCOR",LP)) Q:'LP  D
 .; Ques 1: Not at all=0,Several days=1,More than half the days=2,Nearly every day=3
 .; Ques 2-9: Yes=1, No=2 and Skipped=0
 .S SCRE=+$P(^TMP($J,"YSCOR",LP),"=",2)
 .S SCORES=SCORES_SCRE
 ; First level suicide risk screening - question 1
 I $E(SCORES,1)=0 D  Q
 .S YSDATA(N)="7775^9999;1^NEGATIVE" S N=N+1
 .S YSDATA(N)="7774^9999;1^None"
 S YSDATA(N)="7775^9999;1^POSITIVE" S N=N+1
 S YSDATA(N)="7776^9999;1^SECONDARY SUICIDE RISK SCREEN (C-SSRS)" S N=N+1
 ; get Suicidal Ideation in last month - question 2 and 3
 D
 .S YSDATA(N)="7771^9999;1^Suicidal Ideation in Past Month: "
 .I $E(SCORES,3)=1 S YSDATA(N)=YSDATA(N)_"Yes - Suicidal thoughts" S N=N+1 Q
 .I ($E(SCORES,2)=1)&($E(SCORES,3)=2) S YSDATA(N)=YSDATA(N)_"Yes - Wish to die" S N=N+1 Q
 .I ($E(SCORES,2)=2)&($E(SCORES,3)=2) S YSDATA(N)=YSDATA(N)_"None endorsed" S N=N+1 Q
 ;
 ; get Method/plan/Intent in last month - question 4,5,6 and 7
 S IEN=N
 D  I '$D(YSDATA(IEN)) D CSSRS(SCORES)
 .S YSDATA(N)="7772^9999;1^Method/Plan/Intent in Past Month: "
 .I ($E(SCORES,6)=1)&($E(SCORES,7)=1) S YSDATA(N)=YSDATA(N)_"Method with specific plan and intent"  S N=N+1 Q
 .I ($E(SCORES,6)=1)&($E(SCORES,7)=2) S YSDATA(N)=YSDATA(N)_"Method with specific plan and at least some intent"  S N=N+1 Q
 .I ($E(SCORES,4)=1)&($E(SCORES,5)=1)&($E(SCORES,6)=1)&($E(SCORES,7)=2) S YSDATA(N)=YSDATA(N)_"Method with specific plan and at least some intent"  S N=N+1 Q
 .I ($E(SCORES,4)=1)&($E(SCORES,5)=1)&($E(SCORES,6)=2) S YSDATA(N)=YSDATA(N)_"Method with at least some intent and no specific plan"  S N=N+1 Q
 .I ($E(SCORES,4)=1)&($E(SCORES,5)=2)&($E(SCORES,6)=2) S YSDATA(N)=YSDATA(N)_"Method but with no specific plan or intent"  S N=N+1 Q
 .I ($E(SCORES,4)=2)&($E(SCORES,5)=2)&($E(SCORES,6)=2) S YSDATA(N)=YSDATA(N)_"No method, no specific plan, and no intent"  S N=N+1 Q
 .I ($E(SCORES,4)=2)&($E(SCORES,5)=2)&($E(SCORES,6)=1) S YSDATA(N)=YSDATA(N)_"Method with specific plan and no intent"  S N=N+1 Q
 .I ($E(SCORES,4)=2)&($E(SCORES,5)=1)&($E(SCORES,6)=1)&($E(SCORES,7)=1) S YSDATA(N)=YSDATA(N)_"Method with specific plan and some intent"  S N=N+1 Q
 .I ($E(SCORES,4)=2)&($E(SCORES,5)=1)&($E(SCORES,6)=2) S YSDATA(N)=YSDATA(N)_"Method with at least some intent and no specific plan"  S N=N+1 Q
 .I ($E(SCORES,4)=0)&($E(SCORES,5)=0)&($E(SCORES,6)=0) S YSDATA(N)=YSDATA(N)_"No method, no specific plan, and no intent"  S N=N+1 Q
 .S YSDATA(N)=YSDATA(N)_"END!",N=N+1
 ;
 ; get Sucidal Behavior based on question 8 and 9
 D
 .S YSDATA(N)="7773^9999;1^Suicidal Behavior: "
 .I ($E(SCORES,9)=1) S YSDATA(N)=YSDATA(N)_"Recent Suicidal Behavior (<3 months)"  S N=N+1 Q
 .I ($E(SCORES,8)=1)&($E(SCORES,9)=2) S YSDATA(N)=YSDATA(N)_"Past Suicidal Behavior (>3 Months)"  S N=N+1 Q
 .I ($E(SCORES,8)=2) S YSDATA(N)=YSDATA(N)_"No Past Suicidal Behavior Reported"  S N=N+1 Q
 ;
 ;Screening Indicators
 I $E(SCORES,4,7)_$E(SCORES,9)["1" D  Q
 .S YSDATA(N)="7774^9999;1^"_TEXT2 S N=N+1
 .S YSDATA(N)="7777^9999;1^"_TEXT2A S N=N+1
 .S YSDATA(N)="7778^9999;1^"_TEXT2B S N=N+1
 ;
 S YSDATA(N)="7774^9999;1^"_TEXT1 S N=N+1
 S YSDATA(N)="7777^9999;1^"_TEXT1A S N=N+1
 S YSDATA(N)="7778^9999;1^"_TEXT1B S N=N+1
 ; Get results code is saved in One Note
 Q
 ;
CSSRS(SCORES) ;logic for method/plan/intent section of CSSRS report
 ;
 I ($E(SCORES,5)=1)&($E(SCORES,6)=1) S YSDATA(N)="7772^9999;1^Method with specific plan and at least some intent"  S N=N+1 Q
 I ($E(SCORES,5)=1)&($E(SCORES,6)=2) S YSDATA(N)="7772^9999;1^Method with specific plan and no intent" S N=N+1 Q
 ;

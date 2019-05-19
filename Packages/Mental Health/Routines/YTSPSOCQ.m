YTSPSOCQ ;SLC/LLH - Move PSOCQ Score to complex ; 07/16/2018
 ;;5.01;MENTAL HEALTH;**123**;DEC 30,1994;Build 72
 ;
 ;Public, Supported ICRs
 ; #2056 - Fileman API - $$GET1^DIQ
 ;
 Q
 ;
DATA1 ;
 S YSINSNAM=$P($G(YSDATA(2)),U,3)
 I $G(YSINSNAM)="" S YSINSNAM=$G(YS("CODE"),"NO NAME PASSED")
 S NODE=2 F  S NODE=$O(YSDATA(NODE)) Q:NODE=""  D  ; Start at YSDATA(3)
 .S DATA=YSDATA(NODE)
 .S YSQN=$P(DATA,U,1)
 .S YSCDA=$P($G(DATA),U,3)
 .D DESGNTR^YTSCORE(YSQN,.DES)
 .S LEG=$S(YSCDA=780:1,YSCDA=782:2,YSCDA=999:3,YSCDA=783:4,YSCDA=785:5,1:"")
 .D SCORE
 Q
 ;
SCORE ;
 I "^6536^6537^6538^6539^6540^6541^6542^"[(U_YSQN_U) S STG(928)=STG(928)+LEG
 I "^6543^6544^6545^6546^6547^6548^6549^6550^6551^6552^"[(U_YSQN_U) S STG(929)=STG(929)+LEG
 I "^6553^6554^6555^6556^6557^6558^"[(U_YSQN_U) S STG(930)=STG(930)+LEG
 I "^6560^6561^6562^6563^6564^6565^6566^"[(U_YSQN_U) S STG(931)=STG(931)+LEG
 Q
 ;
SCORESV ;
 I $D(^TMP($J,"YSG",1)),^TMP($J,"YSG",1)="[ERROR]" D  Q  ;-->out
 .K ^TMP($J,"YSCOR")
 .S ^TMP($J,"YSCOR",1)="[ERROR]"
 .S ^TMP($J,"YSCOR",2)=$G(YSINSNAM)_" Scales not found"
 ;
 K ^TMP($J,"YSCOR")
 S ^TMP($J,"YSCOR",1)="[DATA]"
 S ^TMP($J,"YSCOR",2)=$$GET1^DIQ(601.87,928_",",3,"I")_"="_$J((STG(928)/7),0,2) ;Precontemplation
 S ^TMP($J,"YSCOR",3)=$$GET1^DIQ(601.87,929_",",3,"I")_"="_$J((STG(929)/10),0,2) ;Contemplation
 S ^TMP($J,"YSCOR",4)=$$GET1^DIQ(601.87,930_",",3,"I")_"="_$J((STG(930)/6),0,2) ;Action
 S ^TMP($J,"YSCOR",5)=$$GET1^DIQ(601.87,931_",",3,"I")_"="_$J((STG(931)/7),0,2) ;Maintenance
 Q
 ;
DLLSTR(YSDATA,YS,YSTRNG) ;
 ;  YSTRNG = 1 Score Instrument
 ;  YSTRNG = 2 get Report Answers and Text
 N I,DATA,DES,LEG,NODE,YSQN
 N YSCDA,YSSCNAM,YSINSNAM,STG
 ;
 F I=928:1:931 S STG(I)=0
 ; PSOCQ returns a scale score which is calculated and stored, no special text in report
 I YSTRNG=2 Q
 ;
 S STAGE=1
 D DATA1
 D SCORESV
 Q

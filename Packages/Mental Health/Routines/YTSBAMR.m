YTSBAMR ;SLC/PIJ - Score BAM-Revision ; 01/08/2016
 ;;5.01;MENTAL HEALTH;**123,130**;DEC 30,1994;Build 62
 ;
 ;Public, Supported ICRs
 ; #2056 - Fileman API - $$GET1^DIQ
 ;
 Q
 ;
DATA1 ; display scores for administration
 N ANS,LEG,NODE,YSCDA,YSSEQ,YS
 N DATA,DES,SCORE,YSANS,YSQN,CID
 S SCORE=0
 S YSINSNAM=$P($G(YSDATA(2)),U,3)
 I $G(YSINSNAM)="" S YSINSNAM=$G(YS("CODE"),"NO NAME PASSED")
 S NODE=2 F  S NODE=$O(YSDATA(NODE)) Q:NODE=""  D  ; Start at YSDATA(3)
 .S DATA=YSDATA(NODE)
 .S YSQN=$P(DATA,U,1)
 .S YSSEQ=$P($P(DATA,U,2),";",1) ; Sequence Number
 .;if $P(YSSEQ,";",2)'"" then no Choice ID, piece 3 is data 
 .S YSANS=$P($P(DATA,U,2),";",2)
 .S ANS=$P(DATA,U,3),ANS=$S(ANS=1155:0,ANS=1156:0,1:ANS)
 .D DESGNTR^YTSCORE(YSQN,.DES)
 .S YSCDA=$P($G(DATA),U,3) ; Choice ID 
 .I $G(YSANS) S LEG=YSCDA
 .; legacy values are not correct for numerous CHOICE ID's, therefore set value from ID
 .I '$G(YSANS) S CID=YSCDA D
 ..S LEG=$S(CID=212:0,CID=1059:0,CID=1060:1,CID=1061:2,CID=1062:3,CID=1063:4,CID=717:1,CID=685:2,CID=2312:3,CID=687:4,CID=241:"Y",1:"")
 .I (DES="A")!(DES="B") Q
 .D SCORE
 Q
 ;
SCORE ;
 I DES=1 D
 .S HEALTH=HEALTH+LEG
 .S RISK=RISK+$$SCORADJ(LEG)
 I DES=2 D
 .S SLEEP=LEG
 .S RISK=RISK+LEG
 I DES=3 D
 .S DISTR=LEG
 .S RISK=RISK+LEG
 I DES=4 D
 .S DAYSAU=LEG
 .S USE=USE+LEG
 I DES=5 D
 .S DAYSHA=LEG
 .S USE=USE+LEG
 I DES=6 D
 .S DAYSDRUG=LEG
 .S USE=USE+LEG
 I DES=8 D
 .S URGE=LEG
 .S RISK=RISK+$$SCORADJ(LEG)
 I DES=9 D
 .S CONFID=LEG
 .S PROTECT=PROTECT+$$SCORADJ(LEG)
 I DES=10 D
 .S SELF=LEG
 .S PROTECT=PROTECT+LEG
 I DES=11 D
 .S RISKY=LEG
 .S RISK=RISK+LEG
 I DES=12 D
 .S SPIRIT=LEG
 .S PROTECT=PROTECT+$$SCORADJ(LEG)
 I DES=13 D
 .S WORK=LEG
 .S PROTECT=PROTECT+LEG
 I DES=14 D
 .I LEG="Y" S INCME=4,PROTECT=PROTECT+30
 I DES=15 D
 .S RELAT=LEG
 .S RISK=RISK+$$SCORADJ(LEG)
 I DES=16 D
 .S SUPT=LEG
 .S PROTECT=PROTECT+LEG
 Q
 ;
SCORADJ(SCOR) ;
 S ANS=0
 I SCOR=1 S ANS=8
 I SCOR=2 S ANS=15
 I SCOR=3 S ANS=22
 I SCOR=4 S ANS=30
 Q ANS
 ; 
SCORESV ;
 I $D(^TMP($J,"YSG",1)),^TMP($J,"YSG",1)="[ERROR]" D  Q  ;-->out
 .K ^TMP($J,"YSCOR")
 .S ^TMP($J,"YSCOR",1)="[ERROR]"
 .S ^TMP($J,"YSCOR",2)="BAMR Scale not found"
 ;
 K ^TMP($J,"YSCOR")
 S ^TMP($J,"YSCOR",1)="[DATA]"
 S ^TMP($J,"YSCOR",2)=$$GET1^DIQ(601.87,861_",",3,"I")_"="_USE
 S ^TMP($J,"YSCOR",3)=$$GET1^DIQ(601.87,863_",",3,"I")_"="_RISK
 S ^TMP($J,"YSCOR",4)=$$GET1^DIQ(601.87,864_",",3,"I")_"="_PROTECT
 S ^TMP($J,"YSCOR",5)=$$GET1^DIQ(601.87,865_",",3,"I")_"="_DAYSAU
 S ^TMP($J,"YSCOR",6)=$$GET1^DIQ(601.87,866_",",3,"I")_"="_DAYSHA
 S ^TMP($J,"YSCOR",7)=$$GET1^DIQ(601.87,867_",",3,"I")_"="_DAYSDRUG
 S ^TMP($J,"YSCOR",8)=$$GET1^DIQ(601.87,868_",",3,"I")_"="_HEALTH
 S ^TMP($J,"YSCOR",9)=$$GET1^DIQ(601.87,869_",",3,"I")_"="_SLEEP
 S ^TMP($J,"YSCOR",10)=$$GET1^DIQ(601.87,870_",",3,"I")_"="_DISTR
 S ^TMP($J,"YSCOR",11)=$$GET1^DIQ(601.87,871_",",3,"I")_"="_URGE
 S ^TMP($J,"YSCOR",12)=$$GET1^DIQ(601.87,872_",",3,"I")_"="_RISKY
 S ^TMP($J,"YSCOR",13)=$$GET1^DIQ(601.87,873_",",3,"I")_"="_RELAT
 S ^TMP($J,"YSCOR",14)=$$GET1^DIQ(601.87,874_",",3,"I")_"="_CONFID
 S ^TMP($J,"YSCOR",15)=$$GET1^DIQ(601.87,875_",",3,"I")_"="_SELF
 S ^TMP($J,"YSCOR",16)=$$GET1^DIQ(601.87,876_",",3,"I")_"="_SPIRIT
 S ^TMP($J,"YSCOR",17)=$$GET1^DIQ(601.87,877_",",3,"I")_"="_WORK
 S ^TMP($J,"YSCOR",18)=$$GET1^DIQ(601.87,878_",",3,"I")_"="_INCME
 S ^TMP($J,"YSCOR",19)=$$GET1^DIQ(601.87,879_",",3,"I")_"="_SUPT
 ;
 Q
DLLSTR(YSDATA,YS,YSTRNG) ;
 ;  YSTRNG = 1 Score Instrument
 ;  YSTRNG = 2 get Report Answers and Text
 N YSINSNAM
 N USE,RISK,PROTECT,DAYSAU,DAYSHA,DAYSDRUG,HEALTH,SLEEP
 N DISTR,URGE,RISKY,RELAT,CONFID,SELF,SPIRIT,WORK,INCME,SUPT
 ;
 S (USE,RISK,PROTECT,DAYSAU,DAYSHA,DAYSDRUG,HEALTH,SLEEP)=0
 S (DISTR,URGE,RISKY,RELAT,CONFID,SELF,SPIRIT,WORK,INCME,SUPT)=0
 ;
 I YSTRNG=2 Q  ; No special text, computations in the report. 
 ;
 D DATA1
 D SCORESV
 Q
 ;
VERIFY(ARGS,RESULTS) ; Add inconsistency messages based on set of answers in ARGS
 N MSGCNT S MSGCNT=0
 I $$LT("q6501","q6502") D MSG("more","4","5")
 I $$LT("q6503","q6504") D MSG("less","7A","6")
 I $$LT("q6503","q6505") D MSG("less","7B","6")
 I $$LT("q6503","q6506") D MSG("less","7C","6")
 I $$LT("q6503","q6507") D MSG("less","7D","6")
 I $$LT("q6503","q6508") D MSG("less","7E","6")
 I $$LT("q6503","q6509") D MSG("less","7F","6")
 I $$LT("q6503","q6510") D MSG("less","7G","6")
 S RESULTS("count")=MSGCNT
 Q
LT(ID1,ID2) ; returns 1 if ID1 is less than ID2
 ; expects ARGS from VERIFY
 N VAL1,VAL2
 S VAL1=$G(ARGS(ID1)) S:VAL1="c1156" VAL1=0  ; 1156 = skipped by rule
 S VAL2=$G(ARGS(ID2)) S:VAL2="c1156" VAL2=0
 I +VAL1<+VAL2 Q 1
 Q 0
 ;
MSG(REL,Q1,Q2) ; Add text of message to RESULTS
 ; expects MSGCNT, RESULTS from VERIFY
 N X
 S X="There is an inconsistency:  The number of days entered in Question "_Q1
 S X=X_" should be equal to, or "_REL_" than,"
 S X=X_" the number of days in Question "_Q2_"."
 S MSGCNT=MSGCNT+1,RESULTS("messages",MSGCNT)=X
 Q

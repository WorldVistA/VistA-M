YTSFAST ;SLC/KCM - Score FAST ; 01/08/2016
 ;;5.01;MENTAL HEALTH;**123,202,208**;DEC 30,1994;Build 23
 ;
 ; Reference to GET1^DIQ in ICR #2056
 ;
 Q
 ;
DLLSTR(YSDATA,YS,YSTRNG) ; compute scores or report text based on YSTRNG
 ; input
 ;   YSDATA(2)=adminId^patientDFN^instrumentName^dateGiven^isComplete
 ;   YSDATA(2+n)=questionId^sequence^choiceId
 ;   YS("AD")=adminId
 ;   YSTRNG=1 for score, 2 for report
 ; output if YSTRNG=1: ^TMP($J,"YSCOR",n)=scaleId=score
 ; output if YSTRNG=2: append special "answers" to YSDATA
 ;
 I YSTRNG=1 D SCORESV
 I YSTRNG=2 D
 . N SCORES,N
 . D LDSCORES^YTSCORE(.YSDATA,.YS) ; puts score into ^TMP($J,"YSCOR",2)
 . D REPORT(.YSDATA)
 Q
OLDFAST() ;
 ; expects YSDATA from DLLSTR
 N NODE,DATA,YSQN,YSCDA,DES,LEG
 S STAGE=1
 S NODE=2 F  S NODE=$O(YSDATA(NODE)) Q:NODE=""  D  ; Start at YSDATA(3)
 .S DATA=YSDATA(NODE)
 .S YSQN=$P(DATA,U,1)
 .S YSCDA=$P($G(DATA),U,3)
 .D DESGNTR^YTSCORE(YSQN,.DES)
 .S LEG=$$GET1^DIQ(601.75,YSCDA_",",4,"I")
 .I (DES=2),(LEG="Y") S:STAGE<2 STAGE=2
 .I (DES=3),(LEG="Y") S:STAGE<3 STAGE=3
 .I (DES=4),(LEG="Y") S:STAGE<4 STAGE=4
 .I (DES=5),(LEG="Y") S:STAGE<5 STAGE=5
 .I ($E(DES)=6),(LEG="Y") S:STAGE<6 STAGE=6
 .I ($E(DES)=7),(LEG="Y") S:STAGE<7 STAGE=7
 Q STAGE
 ;
SCORESV ; calculate the score
 ; expects YSDATA from DLLSTR (YSDATA from LOADANSW^YTSCORE,SCALEG^YTQAPI3)
 ;
 N I,J,CID,QSTN,STAGE
 S QSTN=$P($G(YSDATA(3)),U),CID=$P($G(YSDATA(3)),U,3)
 I QSTN=8788 D           ; new algorithm for single-question FAST
 . S STAGE=$P($G(^YTT(601.75,+CID,0)),U,2)
 E  S STAGE=$$OLDFAST()  ; different algorithm for multi-question FAST
 ;
 ; set scores into ^TMP($J,"YSCOR",n)=scaleName=score {rawScore^tScore}
 K ^TMP($J,"YSCOR")
 I $D(^TMP($J,"YSG",1)),^TMP($J,"YSG",1)="[ERROR]" D  Q  ;-->out
 . S ^TMP($J,"YSCOR",1)="[ERROR]"
 . S ^TMP($J,"YSCOR",2)="No Scale found for ADMIN"
 ;
 N SCLID,SCLNM
 S ^TMP($J,"YSCOR",1)="[DATA]"
 S I=2,J=1 F  S I=$O(^TMP($J,"YSG",I)) Q:'I  D
 . S SCLID=+$P(^TMP($J,"YSG",I),"=",2)
 . S SCLNM=$P(^TMP($J,"YSG",I),U,4)
 . S J=J+1
 . I SCLID=509 S ^TMP($J,"YSCOR",J)=SCLNM_"="_STAGE
 Q
 ;
REPORT(YSDATA) ; build the scoring display for the report
 ; expects ^TMP($J,"YSCOR",...) and ^TMP($J,"YSG") from DLLSTR
 ;         .YSDATA from DLLSTR
 N I,QID,CID,QLST
 S I=2 F  S I=$O(YSDATA(I)) Q:'I  D
 . S QID=$P(YSDATA(I),U),CID=$P(YSDATA(I),U,3)
 . I CID=1155!(CID=1156)!(CID=1157) Q  ; leave skipped questions undefined
 . S QLST(QID)=$$GET1^DIQ(601.75,CID_",",3,"I")
 ;
 N X,OLDFAST,THISCID,NODE,QNUM,OLDQSTN,QCID,QTXT,THISCID,ANSID,ANSWER
 S OLDFAST=$P($G(YSDATA(3)),U)'=8788
 S THISCID=$S(OLDFAST:"",1:$P($G(YSDATA(3)),U,3))
 S NODE=$O(YSDATA(""),-1) ; get last node
 F QNUM=1:1:16 D
 . S X=$P($T(QSTNS+QNUM),";;",2,999)
 . S OLDQSTN=$P(X,U),QCID=$P(X,U,2),QTXT=$P(X,U,3)
 . S ANSID=7770+QNUM  ; computed answer question IDs are 7771 thru 7787
 . I OLDFAST S ANSWER=QLST(OLDQSTN)
 . I 'OLDFAST S ANSWER=$S(QCID=THISCID:"Yes",1:"No")
 . S NODE=NODE+1,YSDATA(NODE)=ANSID_"^9999;1^"_$S(ANSWER="No":"[ ]",1:"[x]")_"  "_QTXT
 Q
QSTNS ; FAST questions -- ;;oldQuestionID^newChoiceID^QuestionText
 ;;3909^5335^1.  No difficulties, either subjectively or objectively.
 ;;3916^5336^2.  Complains of forgetting location of objects. Subjective word finding|       difficulties.
 ;;3917^5337^3.  Decreased job function evident to co-workers; difficulty in traveling to|       new locations. Decreased organizational capacity.
 ;;3918^5338^4.  Decreased ability to perform complex tasks (e.g., planning dinner for|       guests), handling personal finances (forgetting to pay bills),|       difficulty marketing, etc.
 ;;3919^5339^5.  Requires assistance in choosing proper clothing to wear for day, season,|       or occasion.
 ;;3920^5340^6a. Difficulty putting clothing on properly without assistance.
 ;;3921^5341^6b. Unable to bathe properly; (e.g., difficulty adjusting bath water|       temperature) occasionally or more frequently over the past weeks.
 ;;3922^5342^6c. Inability to handle mechanics of toileting (e.g., forgets to flush|       the toilet, does not wipe properly or properly dispose of toilet|       tissue) occasionally or more frequently over the past weeks.
 ;;3923^5343^6d. Urinary incontinence, occasional or more frequent.
 ;;3924^5344^6e. Fecal incontinence, occasional or more frequently over the past week.
 ;;3925^5345^7a. Ability to speak limited to approximately a half dozen different words or|       fewer, in the course of an average day or in the course of an intensive|       interview.
 ;;3926^5346^7b. Speech ability limited to the use of a single intelligible word in an|       average day or in the course of an interview (the person may repeat|       the word over and over).
 ;;3927^5347^7c. Ambulatory ability lost (cannot walk without personal assistance).
 ;;3928^5348^7d. Ability to sit up without assistance lost (e.g., the individual will fall|       over if there are no lateral rests [arms] on the chair).
 ;;3929^5349^7e. Loss of the ability to smile.
 ;;3932^5350^7f. Unable to hold head up.
 ;;zzzzz

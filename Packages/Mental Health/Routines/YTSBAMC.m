YTSBAMC ;SLC/PIJ - Score BAMC ; 01/08/2016
 ;;5.01;MENTAL HEALTH;**123,130**;DEC 30,1994;Build 62
 ;
 ;Public, Supported ICRs
 ; #2056 - Fileman API - $$GET1^DIQ
 ;
 Q
 ;
DATA1 ; display scores for administration
 N ANS
 S YSINSNAM=$P($G(YSDATA(2)),U,3)
 I $G(YSINSNAM)="" S YSINSNAM=$G(YS("CODE"),"NO NAME PASSED")
 S NODE=2 F  S NODE=$O(YSDATA(NODE)) Q:NODE=""  D  ; Start at YSDATA(3)
 .S DATA=YSDATA(NODE)
 .S YSQN=$P(DATA,U,1)
 .S ANS=$P(DATA,U,3),ANS=$S(ANS=1155:0,ANS=1156:0,1:ANS)
 .I YSQN=6464 S ALCO=ANS
 .I YSQN=6465 S HALCO=ANS
 .I YSQN=6466 S DRUG=ANS
 Q
 ;
SCORESV ;
 I $D(^TMP($J,"YSG",1)),^TMP($J,"YSG",1)="[ERROR]" D  Q  ;-->out
 .K ^TMP($J,"YSCOR")
 .S ^TMP($J,"YSCOR",1)="[ERROR]"
 .S ^TMP($J,"YSCOR",2)=YSINSNAM_" Scale not found"
 ;
 K ^TMP($J,"YSCOR")
 S ^TMP($J,"YSCOR",1)="[DATA]"
 S ^TMP($J,"YSCOR",2)=$$GET1^DIQ(601.87,778_",",3,"I")_"="_ALCO
 S ^TMP($J,"YSCOR",3)=$$GET1^DIQ(601.87,838_",",3,"I")_"="_HALCO
 S ^TMP($J,"YSCOR",4)=$$GET1^DIQ(601.87,839_",",3,"I")_"="_DRUG
 Q
 ; 
DLLSTR(YSDATA,YS,YSTRNG) ;
 ;  YSTRNG = 1 Score Instrument
 ;  YSTRNG = 2 get Report Answers and Text
 ;
 N ALCO,DATA,DRUG,HALCO,NODE,YSQN,YSINSNAM
 ;
 I YSTRNG=2 Q  ; no special processing or text
 ;
 D DATA1
 D SCORESV
 Q
 ;
VERIFY(ARGS,RESULTS) ; Add inconsistency messages based on set of answers in ARGS
 N MSGCNT S MSGCNT=0
 I $$NV("q6464") D NVMSG("1")
 I $$NV("q6465") D NVMSG("2")
 I $$LT("q6464","q6465") D MSG("more","1","2")
 I $$NV("q6466") D NVMSG("3")
 I $$NV("q6467") D NVMSG("4A")
 I $$LT("q6466","q6467") D MSG("less","4A","3")
 I $$NV("q6468") D NVMSG("4B")
 I $$LT("q6466","q6468") D MSG("less","4B","3")
 I $$NV("q6469") D NVMSG("4C")
 I $$LT("q6466","q6469") D MSG("less","4C","3")
 I $$NV("q6470") D NVMSG("4D")
 I $$LT("q6466","q6470") D MSG("less","4D","3")
 I $$NV("q6471") D NVMSG("4E")
 I $$LT("q6466","q6471") D MSG("less","4E","3")
 I $$NV("q6472") D NVMSG("4F")
 I $$LT("q6466","q6472") D MSG("less","4F","3")
 I $$NV("q6473") D NVMSG("4G")
 I $$LT("q6466","q6473") D MSG("less","4G","3")
 D ALLSUB
 S RESULTS("count")=MSGCNT
 Q
LT(ID1,ID2) ; returns 1 if ID1 is less than ID2
 ; expects ARGS from VERIFY
 N VAL1,VAL2        ; 1155=not answered, 1156=skipped by rule
 S VAL1=$G(ARGS(ID1)) S:(VAL1="c1156")!(VAL1="c1155") VAL1=0
 S VAL2=$G(ARGS(ID2)) S:(VAL2="c1156")!(VAL2="c1155") VAL2=0
 I +VAL1<+VAL2 Q 1
 Q 0
 ;
NV(ID) ; returns 1 if ID had no value (has been skipped)
 ; expects ARGS from VERIFY
 N VAL              ; 1155=not answered
 S VAL=$G(ARGS(ID)) I VAL="c1155" Q 1
 Q 0
 ;
MSG(REL,Q1,Q2) ; Add text of message to RESULTS
 ; expects MSGCNT, RESULTS from VERIFY
 N X
 S X="There is an inconsistency: The number of days entered in Question "_Q1
 S X=X_" should be equal to, or "_REL_" than,"
 S X=X_" the number of days in Question "_Q2_"."
 S MSGCNT=MSGCNT+1,RESULTS("messages",MSGCNT)=X
 Q
NVMSG(Q1) ; Add message for no value present
 ; expects MSGCNT, RESULTS from VERIFY
 N X
 S X="There is an inconsistency: The number of days entered in Question "_Q1
 S X=X_" should not be blank."
 S MSGCNT=MSGCNT+1,RESULTS("messages",MSGCNT)=X
 Q
ALLSUB ; compare total of all substances with any substance number
 ; expects ARGS, RESULT from VERIFY
 N SUM,ID,X
 S SUM=0
 F ID="q6467","q6468","q6469","q6470","q6471","q6472","q6473" S SUM=SUM+$G(ARGS(ID))
 I SUM<+$G(ARGS("q6466")) D
 . S X="There is an inconsistency: The addition of all the itemized substances"
 . S X=X_" in questions 4A through 4G should be equal to, or greater than, the"
 . S X=X_" number of days in Question 3."
 . S MSGCNT=MSGCNT+1,RESULTS("messages",MSGCNT)=X
 Q

YTSBAMI ;SLC/KCM - Verify for BAM-IOP ; 01/08/2016
 ;;5.01;MENTAL HEALTH;**130**;DEC 30,1994;Build 62
 ;
 Q
 ;
VERIFY(ARGS,RESULTS) ; Add inconsistency messages based on set of answers in ARGS
 N MSGCNT S MSGCNT=0
 I $$LT("q6444","q6445") D MSG("more","4","5")
 I $$LT("q6446","q6447") D MSG("less","7A","6")
 I $$LT("q6446","q6448") D MSG("less","7B","6")
 I $$LT("q6446","q6449") D MSG("less","7C","6")
 I $$LT("q6446","q6450") D MSG("less","7D","6")
 I $$LT("q6446","q6451") D MSG("less","7E","6")
 I $$LT("q6446","q6452") D MSG("less","7F","6")
 I $$LT("q6446","q6453") D MSG("less","7G","6")
 S RESULTS("count")=MSGCNT
 Q
LT(ID1,ID2) ; returns 1 if ID1 is less than ID2
 ; expects ARGS from VERIFY
 N VAL1,VAL2
 S VAL1=$E($G(ARGS(ID1)),2,9) S:VAL1=1156 VAL1=0  ; 1156 = skipped by rule
 I VAL1 S VAL1=+$P($G(^YTT(601.75,VAL1,0)),U,2)   ; legacy value for compare
 S VAL2=$E($G(ARGS(ID2)),2,9) S:VAL2=1156 VAL2=0
 I VAL2 S VAL2=+$P($G(^YTT(601.75,VAL2,0)),U,2)
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

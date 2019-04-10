YTSMPIR ;SLC/KCM - Score MMPI-2-RF ; 10/24/2015
 ;;5.01;MENTAL HEALTH;**123**;Dec 30, 1994;Build 73
 ;
SCORE(RSLT,ADMIN) ; Score instrument
 ; build tables if necessary
 ; build responses
 ; scan for overall results
 ; compute raw score for each scale
 ; compute adjusted scores, if necessary
 ; get T-scores for each scale
 Q
SCAN(CNT,RSP) ; scan for overall statistics
 N I
 S CNT("trueCount")=0
 S CNT("cannotSay")=0
 S CNT("skipped")=""
 S CNT("responses")=""
 S I=0 F  S I=$O(RSP(I)) Q:'I  D
 .I RSP(I)="T" S CNT("trueCount")=CNT("trueCount")+1
 .I RSP(I)=""  D
 ..S CNT("cannotSay")=CNT("cannotSay")+1
 ..S CNT("skipped")=CNT("skipped")_I_", "
 ;S CNT("trueCount")=CNT("trueCount")/(338-CNT("cannotSay")*100)
 S CNT("trueCount")=$J((CNT("trueCount")/(338-CNT("cannotSay"))*100),0,0)
 Q
 ;
 ; compute scores ---------------------------------------------------
SCORE1(RSLT,SCALE,RSP) ; set .RSLT subscripts for SCALE
 ; expects T (scoring tables)
 ;  .RSLT: subscripts - raw,adjusted,count,percent,tscore
 ;  SCALE: scale to calculate
 ;   .RSP: set of responses -- RSP(q#)=answer
 K RSLT
 S RSLT("raw")=0,RSLT("count")=0
 I SCALE="VRIN-r" D VRIN(.RSLT,.RSP) Q
 I SCALE="TRIN-r" D TRIN(.RSLT,.RSP) Q
 ; all others
 N QID
 S QID=0 F  S QID=$O(T("raw",SCALE,QID)) Q:'$L(QID)  D
 .I RSP(QID)=$P(T("raw",SCALE,QID),U,2) D INC(SCALE,"raw")
 .I RSP(QID)'="" D INC(SCALE,"count")
 D PERCENT(.RSLT,SCALE)
 ; compute adjusted raw score if response rate <90%
 I T("info",SCALE,"adjust"),(RSLT("percent")<90) D RAWADJ(.RSLT,SCALE,.RSP)
 D TSCORE(.RSLT,SCALE)
 ;set into array to save score
 D SETSCORE(.SCR,.RSLT,SCALE)
 Q
VRIN(RSLT,RSP) ; VRIN-r raw,count,percent,t-score
 N QID,Q1,Q2,K1,K2,X
 S QID=0 F  S QID=$O(T("raw","VRIN-r",QID)) Q:'$L(QID)  D
 . S X=T("raw","VRIN-r",QID)
 . S Q1=$P(X,U),K1=$P(X,U,2),Q2=$P(X,U,3),K2=$P(X,U,4)
 . I RSP(Q1)=K1,(RSP(Q2)=K2) D INC(SCALE,"raw")
 . I $P(T("raw","VRIN-r",QID),U,6)="B" Q  ; pair, only count once
 . I (RSP(Q1)="")!(RSP(Q2)="") Q          ; only count if both present
 . D INC(SCALE,"count")
 D PERCENT(.RSLT,"VRIN-r")
 ; compute adjusted raw score if response rate <90%
 I RSLT("percent")<90 D VRINADJ(.RSLT,.RSP)
 D TSCORE(.RSLT,"VRIN-r")
 ;set into array to save score
 D SETSCORE(.SCR,.RSLT,SCALE)
 Q
TRIN(RSLT,RSP) ; TRIN-r raw,count,percent,t-score
 N QID,Q1,Q2,K1,K1,DIFF,X
 S QID=0 F  S QID=$O(T("raw","TRIN-r",QID)) Q:'$L(QID)  D
 . S X=T("raw","TRIN-r",QID)
 . S Q1=$P(X,U),K1=$P(X,U,2),Q2=$P(X,U,3),K2=$P(X,U,4)
 . S DIFF=$S($P(X,U,5)="-":-1,1:1)
 . I RSP(Q1)=K1,(RSP(Q2)=K2) D INC(SCALE,"raw",DIFF)
 . Q:RSP(Q1)=""  Q:RSP(Q2)=""  D INC(SCALE,"count")
 D INC(SCALE,"raw",11)
 D PERCENT(.RSLT,"TRIN-r")
 ; compute adjusted raw score if response rate <90%
 I RSLT("percent")<90,(RSLT("raw")'=11) D TRINADJ(.RSLT,.RSP)
 D TSCORE(.RSLT,"TRIN-r")
 ;set into array to save score
 D SETSCORE(.SCR,.RSLT,SCALE)
 Q
TSCORE(RSLT,SCALE) ; add T-Score to .RSLT
 N RAW
 S RAW=$S($D(RSLT("adjraw")):RSLT("adjraw"),1:RSLT("raw"))
 I $D(T("tscore",SCALE,RAW)) S RSLT("tscore")=T("tscore",SCALE,RAW) I 1
 E  S RSLT("tscore")=T("tscore",SCALE,"default")
 Q
 ;
 ; compute adjusted scores (validity scales < 90% response) ---------
VRINADJ(RSLT,RSP) ; VRIN-r adjusted raw score
 N QID,Q1,Q2,K1,K2,R1,R2,X
 S RSLT("adjraw")=0
 S QID=0 F  S QID=$O(T("raw","VRIN-r",QID)) Q:'$L(QID)  D
 .S X=T("raw","VRIN-r",QID)
 .S Q1=$P(X,U),K1=$P(X,U,2),Q2=$P(X,U,3),K2=$P(X,U,4)
 .S R1=RSP(Q1),R2=RSP(Q2)
 .I R1'="",(R2'="") D  Q  ; if nothing omitted, use original method
 ..I R1=K1,(R2=K2) D INC(SCALE,"adjraw")
 .Q:$P(X,U,6)="S"         ; skip "mate" in pair
 .I $P(X,U,6)="B" D  Q    ; if both shared, omit either increments score
 ..I R1=""!(R2="") D INC(SCALE,"adjraw")
 .I $P(X,U,6)="C" D  Q    ; if pair shares one common item
 ..N QA,QB,QC,KB,KC,RA,RB,RC
 ..S QA=$P(X,U,7),QB=$P(X,U,8),QC=$P(X,U,10),KB=$P(X,U,9),KC=$P(X,U,11)
 ..S RA=RSP(QA),RB=RSP(QB),RC=RSP(QC)
 ..I ((RA="")&((RB=KB)!(RB="")!(RC=KC)!(RC="")))!((RB="")&(RC="")) D INC(SCALE,"adjraw")
 .I $P(X,U,6)="" D        ; otherwise, set missing item to key
 ..S:R1="" R1=K1 S:R2="" R2=K2
 .. I R1=K1,(R2=K2) D INC(SCALE,"adjraw")
 Q
TRINADJ(RSLT,RSP) ; TRIN-r adjusted raw score
 N QID,Q1,Q2,K1,K2,R1,R2,DIFF,X
 N DFLT S DFLT=$S(RSLT("raw")<11:"F",1:"T")
 S RSLT("adjraw")=11
 S QID=0 F  S QID=$O(T("raw","TRIN-r",QID)) Q:'$L(QID)  D
 .S X=T("raw","TRIN-r",QID)
 .S Q1=$P(X,U),K1=$P(X,U,2),Q2=$P(X,U,3),K2=$P(X,U,4)
 .S DIFF=$S($P(X,U,5)="-":-1,1:1)
 .S R1=RSP(Q1),R2=RSP(Q2)
 .S:R1="" R1=DFLT S:R2="" R2=DFLT
 .I R1=K1,(R2=K2) D INC(SCALE,"adjraw",DIFF)
 Q
RAWADJ(RSLT,SCALE,RSP) ; general case adjusted raw score
 N R
 S RSLT("adjraw")=0
 S QID=0 F  S QID=$O(T("raw",SCALE,QID)) Q:'$L(QID)  D
 .S R=RSP(QID) S:R="" R=$P(T("raw",SCALE,QID),U,2)
 .I R=$P(T("raw",SCALE,QID),U,2) D INC(SCALE,"adjraw")
 Q
 ;
 ; utility calls ----------------------------------------------------
PERCENT(RSLT,SCALE) ; compute percent and put back in .RSLT
 ; expects T (scoring tables)
 S RSLT("percent")=$P((RSLT("count")/T("info",SCALE,"count")*100)+.5,".")
 Q
INC(SCALE,SUB,VAL) ; increment (or decrement) subscript SUB by value VAL
 S VAL=$G(VAL,1)
 S RSLT(SUB)=RSLT(SUB)+VAL
 Q
SETSCORE(SCR,RSLT,SCALE) ;
 S SCR(SCALE)=RSLT("raw")_U_RSLT("tscore")_U_RSLT("percent")_U_RSLT("count")
 Q 

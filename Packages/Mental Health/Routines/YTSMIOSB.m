YTSMIOSB ;SLC/KCM - Score MIOS+B-IPF ; 10/14/18 2:02pm
 ;;5.01;MENTAL HEALTH;**218**;Dec 30, 1994;Build 9
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
 . N SCOREVAL,CHKTXT,N
 . D LDSCORES^YTSCORE(.YSDATA,.YS) ; puts score into ^TMP($J,"YSCOR",2)
 . D REPORT(.SCOREVAL,.CHKTXT)
 . S N=$O(YSDATA(""),-1) ; get last node
 . S YSDATA(N+1)="7771^9999;1^"_SCOREVAL
 . S YSDATA(N+2)="7772^9999;1^"_CHKTXT
 Q
 ;
SCORESV ; calculate the score
 ; expects YSDATA from DLLSTR
 N I,J,QSTN,QCNT,CID,TOTAL,SHAME,TRUST,BIPF
 S I=2,QCNT=0 F  S I=$O(YSDATA(I)) Q:'I  D
 . S CID=$P(YSDATA(I),U,3) Q:'CID      ; skip checkbox question (no CID)
 . I CID=1155!(CID=1156)!(CID=1157) Q  ; don't include skipped questions
 . S QSTN($P(YSDATA(I),U))=$P($G(^YTT(601.75,CID,0)),U,2),QCNT=QCNT+1
 ;
 I QSTN(8922)=0,(QCNT<14) D  ; special case -- (if 1st question negative)
 . S TOTAL=""
 . S SHAME=""
 . S TRUST=""
 . S BIPF=""
 E  D                        ; normal cases --
 . S TOTAL=$$SUM(.QSTN,"8924,8925,8926,8927,8928,8929,8930,8931,8932,8933,8934,8935,8936,8937")
 . S SHAME=$$SUM(.QSTN,"8924,8926,8930,8931,8935,8936,8937") ; Questions 1,3,7,8,12,13,14
 . S TRUST=$$SUM(.QSTN,"8925,8927,8928,8929,8932,8933,8934") ; Questions 2,4,5,6,9,10,11
 . S BIPF=$$BIPF(.QSTN,"8938,8939,8940,8941,8942,8943,8944,8945,8946")  ; B-IPF questions
 ;
 ; set scores into ^TMP($J,"YSCOR",n)=scaleId=rawScore^tScore
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
 . I SCLID=1475 S ^TMP($J,"YSCOR",J)=SCLNM_"="_SHAME
 . I SCLID=1476 S ^TMP($J,"YSCOR",J)=SCLNM_"="_TRUST
 . I SCLID=1477 S ^TMP($J,"YSCOR",J)=SCLNM_"="_TOTAL
 . I SCLID=1479 S ^TMP($J,"YSCOR",J)=SCLNM_"="_BIPF
 Q
SUM(QSTN,LIST) ; return sum for questions in LIST
 N I,QID,SUM
 S SUM=0
 F I=1:1:$L(LIST,",") S QID=$P(LIST,",",I) D  Q:SUM<0
 . I '$D(QSTN(QID)) S SUM=-1 Q
 . I QSTN(QID)="" S SUM=-1 Q
 . S SUM=SUM+QSTN(QID)
 Q $S(SUM<0:"",1:SUM)
 ;
BIPF(QSTN,LIST) ; return the B-IPF score from questions in LIST
 ; expects YSDATA
 N I,QID,SUM,CNT
 S SUM=0,CNT=0
 F I=1:1:$L(LIST,",") S QID=$P(LIST,",",I) D  Q:SUM<0
 . Q:'$D(QSTN(QID))  ; skipped questions aren't in array  
 . Q:QSTN(QID)=99    ; not applicable (N/A) value is 99 (CHC=5508)
 . S CNT=CNT+1,SUM=SUM+QSTN(QID)
 ; score is (raw score / maximum given number answered) * 100
 I CNT=0 Q ""  ; everything skipped or N/A
 Q $FN((SUM/(CNT*6))*100,"",0)
 ;
REPORT(SCORES,CHKTXT) ; build the scoring display for the report
 ; expects ^TMP($J,"YSCOR",...) and ^TMP($J,"YSG") from DLLSTR
 ;         YSDATA from DLLSTR
 ; YSDATA(2+n)=questionId^sequence^choiceId or text response
 N I,X,NAME,VALUE,TOTAL,SHAME,TRUST,BIPF
 S I=0 F  S I=$O(^TMP($J,"YSCOR",I)) Q:'I  D
 . S NAME=$P(^TMP($J,"YSCOR",I),"=")
 . S VALUE=$P(^TMP($J,"YSCOR",I),"=",2)
 . I NAME="Shame-related Outcomes" S SHAME=VALUE
 . I NAME="Trust Violation-related Outcomes" S TRUST=VALUE
 . I NAME="MIOS Total" S TOTAL=VALUE
 . I NAME="B-IPF Total" S BIPF=VALUE
 ;
 ; split the checkboxes selected into separate lines <*Answer_8923*>
 S X="",CHKTXT=""
 S I=2 F  S I=$O(YSDATA(I)) Q:'I  D  Q:$L(CHKTXT)
 . I $P(YSDATA(I),U)'=8923 Q
 . S X=X_$P(YSDATA(I),U,3,99)
 I +X=1155 S CHKTXT="|     SKIPPED"
 I +X=1156 S CHKTXT="|     Not asked (due to responses to other questions)"
 I +X=1157 S CHKTXT="|     Skipped but required"
 I CHKTXT="" D
 . I X["1. (A" S CHKTXT=$$WRAP^YTSCAT($G(^YTT(601.75,5493,1)),70,"|     ")
 . I X["2. (B" S CHKTXT=CHKTXT_$$WRAP^YTSCAT($G(^YTT(601.75,5494,1)),70,"|     ")
 . I X["3. (C" S CHKTXT=CHKTXT_$$WRAP^YTSCAT($G(^YTT(601.75,5495,1)),70,"|     ")
 I CHKTXT="" S CHKTXT="|     (No selections made)"
 ;
 S X=""
 ; special case -- if first question = NO, all others skipped
 I SHAME="",(TRUST=""),(TOTAL=""),(BIPF="") D  QUIT
 . S X=X_"| No scores due to negative answer to the first question."
 . S X=X_"| (Have you had at least one experience like this = NO)"
 . S SCORES=X
 ; normal case
 S BIPF=$S(BIPF="":" no score",1:$J(BIPF,3)) ; ="" if all N/A
 S X=X_"|            Shame-related Outcomes: "_$J(SHAME,3)
 S X=X_"|  Trust Violation-related Outcomes: "_$J(TRUST,3)
 S X=X_"|                        MIOS Total: "_$J(TOTAL,3)
 S X=X_"|                       B-IPF Total: "_BIPF
 S X=X_"|"
 S X=X_"|Higher MIOS scores indicate greater levels of current moral injury."
 S X=X_"|Higher B-IPF scores indicate more functional impairment."
 S SCORES=X
 Q

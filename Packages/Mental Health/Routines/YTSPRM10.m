YTSPRM10 ;SLC/KCM - Score PROMIS10 ; 3/25/22 2:02pm
 ;;5.01;MENTAL HEALTH;**218,236**;Dec 30, 1994;Build 25
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
 . D REPORT(.SCORES)
 . S N=$O(YSDATA(""),-1) ; get last node
 . S YSDATA(N+1)="7771^9999;1^"_SCORES
 Q
 ;
SCORESV ; calculate the score
 ; expects YSDATA from DLLSTR (YSDATA from LOADANSW^YTSCORE,SCALEG^YTQAPI3)
 N I,J,QID,CID,QSTN,GPHYS,GMENT,GHLTH,SOCL
 S I=2 F  S I=$O(YSDATA(I)) Q:'I  D
 . S QID=$P(YSDATA(I),U),CID=$P(YSDATA(I),U,3)
 . I CID=1155!(CID=1156)!(CID=1157) Q  ; leave skipped questions undefined
 . I QID=8798 S QSTN(QID)=+CID Q  ;8798 is numerical response. Set only if not skipped
 . S QSTN(QID)=$$GET1^DIQ(601.75,CID_",",4,"I")
 S GPHYS=$$SUM(.QSTN,"8791,8795,8797,8798") ; Questions 3,7,9,10
 S GMENT=$$SUM(.QSTN,"8790,8792,8793,8796") ; Questions 2,4,5,8
 S GHLTH=$$SUM(.QSTN,"8789")                ; Question 1
 S SOCL=$$SUM(.QSTN,"8794")                 ; Question 6
 ;
 ; set scores into ^TMP($J,"YSCOR",n)=scaleName=rawScore {^tScore}
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
 . I SCLID=1456 S ^TMP($J,"YSCOR",J)=SCLNM_"="_GPHYS_U_$$TBLVAL(GPHYS,2)
 . I SCLID=1457 S ^TMP($J,"YSCOR",J)=SCLNM_"="_GMENT_U_$$TBLVAL(GMENT,4)
 . I SCLID=1458 S ^TMP($J,"YSCOR",J)=SCLNM_"="_GHLTH
 . I SCLID=1459 S ^TMP($J,"YSCOR",J)=SCLNM_"="_SOCL
 Q
SUM(QSTN,LIST) ; return sum of values for questions in LIST
 ;
 ; handle mapping for question 10 (question 8798)
 ;
 N I,QID,SUM,CNT
 S CNT=0
 S SUM=0 F I=1:1:$L(LIST,",") S QID=$P(LIST,",",I) D
 . I QID=8798,$D(QSTN(QID)) S QSTN(QID)=$$RECODE(QSTN(QID))
 . I $D(QSTN(QID)) S CNT=CNT+1,SUM=SUM+QSTN(QID)
 Q $S(CNT=$L(LIST,","):SUM,1:"")
 ;
REPORT(SCORES) ; build the scoring display for the report
 ; expects ^TMP($J,"YSCOR",...) and ^TMP($J,"YSG") from DLLSTR
 ;         YSDATA from DLLSTR
 N I,X,NAME,VALUE,GPHYS,GMENT,GHLTH,SOCL,TGPHYS,TGMENT
 S I=0 F  S I=$O(^TMP($J,"YSCOR",I)) Q:'I  D
 . S NAME=$P(^TMP($J,"YSCOR",I),"=")
 . S VALUE=$P(^TMP($J,"YSCOR",I),"=",2)
 . I VALUE="" S VALUE="    Too many items skipped"
 . I NAME="Global Physical Health" S GPHYS=VALUE
 . I NAME="Global Mental Health" S GMENT=VALUE
 . I NAME="General Health" S GHLTH=VALUE
 . I NAME="Social Activities/Roles" S SOCL=VALUE
 S TGPHYS=$P(GPHYS,U,2),GPHYS=$P(GPHYS,U)
 S TGMENT=$P(GMENT,U,2),GMENT=$P(GMENT,U)
 S X=""
 S X=X_"|                              Raw Score    T-Score    Std.Error|"
 S X=X_"|   Global Physical Health:"_$$SCORSTR(GPHYS,TGPHYS,3)
 S X=X_"|     Global Mental Health:"_$$SCORSTR(GMENT,TGMENT,5)
 S X=X_"|           General Health:"_$J(GHLTH,10)
 S X=X_"|  Social Activities/Roles:"_$J(SOCL,10)
 S SCORES=X
 Q
 ;
SCORSTR(RAW,T1,COL) ; return formatted string of score
 I $E(RAW,1,5)="    T" Q RAW
 Q $J(RAW,10)_"        "_$J(T1,5,1)_"        "_$J($$TBLVAL(RAW,COL),3,1)
 ;
TBLVAL(RAW,COLUMN) ; return table value given RAW score and COLUMN
 N X,N
 S X=$P($T(TMAP+RAW),";;",2)
 S N=$P(X,U,COLUMN) S:'N N=""
 Q N
 ;
 ;;Raw^PhysicalT^PhysicalSE^MentalT^MentalSE
 ;; 1 ^    2    ^    3     ^   4   ^    5
TMAP ; Map of raw scores to t-scores
 ;;1^^^^  ; no-op, invalid score
 ;;2^^^^  ; no-op, invalid score
 ;;3^^^^  ; no-op, invalid score
 ;;4^16.2^4.8^21.2^4.6
 ;;5^19.9^4.7^25.1^4.1
 ;;6^23.5^4.5^28.4^3.9
 ;;7^26.7^4.3^31.3^3.7
 ;;8^29.6^4.2^33.8^3.7
 ;;9^32.4^4.2^36.3^3.7
 ;;10^34.9^4.1^38.8^3.6
 ;;11^37.4^4.1^41.1^3.6
 ;;12^39.8^4.1^43.5^3.6
 ;;13^42.3^4.2^45.8^3.6
 ;;14^44.9^4.3^48.3^3.7
 ;;15^47.7^4.4^50.8^3.7
 ;;16^50.8^4.6^53.3^3.7
 ;;17^54.1^4.7^56.0^3.8
 ;;18^57.7^4.9^59.0^3.9
 ;;19^61.9^5.2^62.5^4.2
 ;;20^67.7^5.9^67.6^5.3
 ;;zzzzz
 ;
RECODE(RAW) ; return recoded value for question 10
 N I,X,Y
 F I=1:1 S X=$P($T(MAP10+I),";;",2) Q:X="zzzzz"  I +X=RAW S Y=$P(X,U,2) Q
 Q Y
 ;
MAP10 ; Map for question 10
 ;;0^5
 ;;1^4
 ;;2^4
 ;;3^4
 ;;4^3
 ;;5^3
 ;;6^3
 ;;7^2
 ;;8^2
 ;;9^2
 ;;10^1
 ;;zzzzz

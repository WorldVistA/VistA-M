YTSPROM2 ;SLC/KCM - Score PROMIS29 v2.1 ; 10/14/18 2:02pm
 ;;5.01;MENTAL HEALTH;**173**;Dec 30, 1994;Build 10
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
 . N SCORETXT,N
 . D LDSCORES^YTSCORE(.YSDATA,.YS)
 . D REPORT(.SCORETXT)
 . S N=$O(YSDATA(""),-1) ; get last node
 . S YSDATA(N+1)="7771^9999;1^"_SCORETXT
 Q
 ;
SCORESV ; calculate the raw scores and map to T-Scores
 ; expects YSDATA from DLLSTR
 N YTRESP,X,QSTN,RAW
 D MAPQSTN(.YSDATA,.YTRESP)
 F X="physical","anxiety","depress","fatigue","sleep","social","pain","cog" S RAW(X)=0
 F QSTN=8583:1:8586 S RAW("physical")=RAW("physical")+YTRESP(QSTN)
 F QSTN=8587:1:8590 S RAW("anxiety")=RAW("anxiety")+YTRESP(QSTN)
 F QSTN=8591:1:8594 S RAW("depress")=RAW("depress")+YTRESP(QSTN)
 F QSTN=8595:1:8598 S RAW("fatigue")=RAW("fatigue")+YTRESP(QSTN)
 F QSTN=8599:1:8602 S RAW("sleep")=RAW("sleep")+YTRESP(QSTN)
 F QSTN=8603:1:8606 S RAW("social")=RAW("social")+YTRESP(QSTN)
 F QSTN=8607:1:8610 S RAW("pain")=RAW("pain")+YTRESP(QSTN)
 F QSTN=8611,8612 S RAW("cog")=RAW("cog")+$G(YTRESP(QSTN)) ; only in PROPr
 S RAW("intensity")=$G(YTRESP(8613)) ; pain intensity
 ;
 ; set scores into ^TMP($J,"YSCOR",n)=scaleId=rawScore^tScore
 K ^TMP($J,"YSCOR")
 I $D(^TMP($J,"YSG",1)),^TMP($J,"YSG",1)="[ERROR]" D  Q  ;-->out
 . S ^TMP($J,"YSCOR",1)="[ERROR]"
 . S ^TMP($J,"YSCOR",2)="No Scale found for ADMIN"
 S ^TMP($J,"YSCOR",1)="[DATA]"
 N I,J,X,YTS,YTN,YTX
 S (I,J)=1 F  S I=$O(^TMP($J,"YSG",I)) Q:'I  S X=^TMP($J,"YSG",I) D
 . QUIT:$E(X,1,5)'="Scale"
 . S X=$P(X,"=",2,99),YTS=$P(X,U),YTN=$P(X,U,4),YTX=""
 . I YTS=1375!(YTS=1383) S YTX=RAW("physical")_U_$$TBLVAL(RAW("physical"),2)
 . I YTS=1376!(YTS=1384) S YTX=RAW("anxiety")_U_$$TBLVAL(RAW("anxiety"),4)
 . I YTS=1377!(YTS=1385) S YTX=RAW("depress")_U_$$TBLVAL(RAW("depress"),6)
 . I YTS=1378!(YTS=1386) S YTX=RAW("fatigue")_U_$$TBLVAL(RAW("fatigue"),8)
 . I YTS=1379!(YTS=1387) S YTX=RAW("sleep")_U_$$TBLVAL(RAW("sleep"),10)
 . I YTS=1380!(YTS=1388) S YTX=RAW("social")_U_$$TBLVAL(RAW("social"),12)
 . I YTS=1381!(YTS=1389) S YTX=RAW("pain")_U_$$TBLVAL(RAW("pain"),14)
 . I YTS=1382!(YTS=1391) S YTX=RAW("intensity")           ; (no T-Score)
 . I YTS=1390 S YTX=RAW("cog")_U_$$TBLVAL(RAW("cog"),16)  ; only in PROPr
 . I $L(YTX) S J=J+1,^TMP($J,"YSCOR",J)=YTN_"="_YTX
 Q
MAPQSTN(YSDATA,YTRESP) ; loop YSDATA and map questions to choice values
 N YTI,YTQSTN,YTCHC
 S YTI=2 F  S YTI=$O(YSDATA(YTI)) Q:'YTI  D  ; set actual choice values
 . S YTQSTN=$P(YSDATA(YTI),U),YTCHC=$P(YSDATA(YTI),U,3)
 . I YTQSTN=8613 S YTRESP(YTQSTN)=$P(YSDATA(YTI),U,3) Q  ; 8613=TrackBar
 . S YTRESP(YTQSTN)=+$P(^YTT(601.75,YTCHC,0),U,2)
 Q
 ;
 ;
REPORT(TXT) ; build the scoring display for the report
 ; expects ^TMP($J,"YSCOR",...) and ^TMP($J,"YSG") from DLLSTR
 ;         YSDATA from DLLSTR
 ; organize the scores into SCORES(scaleId)=raw^tscore
 N I,X,MAP,SCORES
 F I=1375:1:1390 S SCORES(I)=""  ; initialize to avoid undefined
 S I=1 F  S I=$O(^TMP($J,"YSG",I)) Q:'I  S X=^TMP($J,"YSG",I) D
 . QUIT:$E(X,1,5)'="Scale"
 . S X=$P(X,"=",2,99)
 . S MAP($P(X,U,4))=+$P(X,U)
 S I=1 F  S I=$O(^TMP($J,"YSCOR",I)) Q:'I  S X=^TMP($J,"YSCOR",I) D
 . QUIT:'$D(MAP($P(X,"=")))
 . S SCORES(MAP($P(X,"=")))=$P(X,"=",2,99)
 I $P(YSDATA(2),U,3)="PROMIS29 V2.1" S TXT=$$PRO29(.SCORES)
 I $P(YSDATA(2),U,3)="PROMIS29+2 V2.1" S TXT=$$PROPR(.SCORES)
 Q
PRO29(SCORES) ; return text for PROMIS29
 N X S X=""
 S X=X_"| TOTALS                       Raw Score    T-Score    Std.Error|"
 S X=X_"| Physical Function                "_$$SCORSTR(1375,SCORES(1375))
 S X=X_"| Anxiety                          "_$$SCORSTR(1376,SCORES(1376))
 S X=X_"| Depression                       "_$$SCORSTR(1377,SCORES(1377))
 S X=X_"| Fatigue                          "_$$SCORSTR(1378,SCORES(1378))
 S X=X_"| Sleep Disturbance                "_$$SCORSTR(1379,SCORES(1379))
 S X=X_"| Social Roles and Activities      "_$$SCORSTR(1380,SCORES(1380))
 S X=X_"| Pain Interference                "_$$SCORSTR(1381,SCORES(1381))
 S X=X_"| Pain Intensity                   "_$J($$PAIN,2)
 Q X
 ;
PROPR(SCORES) ; return text for PROMIS29+2 (PROPr)
 N X S X=""
 S X=X_"| TOTALS                       Raw Score    T-Score    Std.Error|"
 S X=X_"| Physical Function                "_$$SCORSTR(1383,SCORES(1383))
 S X=X_"| Anxiety                          "_$$SCORSTR(1384,SCORES(1384))
 S X=X_"| Depression                       "_$$SCORSTR(1385,SCORES(1385))
 S X=X_"| Fatigue                          "_$$SCORSTR(1386,SCORES(1386))
 S X=X_"| Sleep Disturbance                "_$$SCORSTR(1387,SCORES(1387))
 S X=X_"| Social Roles and Activities      "_$$SCORSTR(1388,SCORES(1388))
 S X=X_"| Pain Interference                "_$$SCORSTR(1389,SCORES(1389))
 S X=X_"| Cognitive Function               "_$$SCORSTR(1390,SCORES(1390))
 S X=X_"| Pain Intensity                   "_$J($$PAIN,2)_"|"
 ;
 ; calculate utility scores from t-scores
 N TSCORES,USCORES
 D MKTLST(.SCORES,.TSCORES),MAUT^YTSPROMU(.TSCORES,.USCORES)
 S X=X_"| PROPr MULTI-ATTRIBUTE SCORES|"
 S X=X_"| PROPr                       "_$G(USCORES("PROPr"))
 S X=X_"| Physical Utility            "_$G(USCORES("physical"))
 S X=X_"| Depression Utility          "_$G(USCORES("depression"))
 S X=X_"| Fatigue Utility             "_$G(USCORES("fatigue"))
 S X=X_"| Sleep Utility               "_$G(USCORES("sleep"))
 S X=X_"| Social Utility              "_$G(USCORES("social"))
 S X=X_"| Pain Utility                "_$G(USCORES("pain"))
 S X=X_"| Cognition Utility           "_$G(USCORES("cognition"))
 Q X
 ;
SCORSTR(SID,SCORE) ; return score string given scale identifier
 N X,RAW,T1,SE
 S RAW=$P(SCORE,U),T1=$P(SCORE,U,2),SE=""
 I SID=1375!(SID=1383) S SE=$$TBLVAL(RAW,3)   ; physical
 I SID=1376!(SID=1384) S SE=$$TBLVAL(RAW,5)   ; anxiety
 I SID=1377!(SID=1385) S SE=$$TBLVAL(RAW,7)   ; depression
 I SID=1378!(SID=1386) S SE=$$TBLVAL(RAW,9)   ; fatigue
 I SID=1379!(SID=1387) S SE=$$TBLVAL(RAW,11)  ; sleep
 I SID=1380!(SID=1388) S SE=$$TBLVAL(RAW,13)  ; social
 I SID=1381!(SID=1389) S SE=$$TBLVAL(RAW,15)  ; pain
 I SID=1390 S SE=$$TBLVAL(RAW,17)             ; cognition
 Q $J(RAW,2)_"        "_$J(T1,5,1)_"        "_$J(SE,3,1)
 ;
PAIN() ; return pain intensity selection
 N I,X
 S I=2,X="" F  S I=$O(YSDATA(I)) Q:'I  D  Q:$L(X)
 . I $P(YSDATA(I),U)=8613 S X=$P(YSDATA(I),U,3)
 Q X
 ;
MKTLST(SCORES,TSCORES) ; build a named list of t-scores for PROPr
 S TSCORES("cognition")=+$P(SCORES(1390),U,2)
 S TSCORES("depression")=+$P(SCORES(1385),U,2)
 S TSCORES("fatigue")=+$P(SCORES(1386),U,2)
 S TSCORES("pain")=+$P(SCORES(1389),U,2)
 S TSCORES("physical")=+$P(SCORES(1383),U,2)
 S TSCORES("sleep")=+$P(SCORES(1387),U,2)
 S TSCORES("social")=+$P(SCORES(1388),U,2)
 Q
 ;
TBLVAL(RAW,COLUMN) ; return table value given RAW score and COLUMN
 N X,N
 S X=$P($T(TMAP+RAW),";;",2)
 S N=$P(X,U,COLUMN) S:'N N=""
 Q N
 ;
 ;;Raw^PhysicalT^PhysicalSE^AnxietyT^AnxietySE^DepressT^DepressSE^FatigueT^FatigueSE^SleepT^SleepSE^SocialT^SocialSE^PainT^PainSE^CogT^CogSE
 ;; 1 ^    2    ^    3     ^    4   ^    5    ^    6   ^    7    ^   8    ^    9    ^  10  ^  11   ^  12   ^   13   ^ 14  ^  15  ^ 16 ^ 17
TMAP ; Map of raw scores to t-scores
 ;;1 (no raw score is 1, this is placeholder to make offset map to raw score)
 ;;2^^^^^^^^^^^^^^^29.5^6.4
 ;;3^^^^^^^^^^^^^^^34.4^5.9
 ;;4^22.5^4.0^40.3^6.1^41.0^6.2^33.7^4.9^32.0^5.2^27.5^4.1^41.6^6.1^38.0^5.7
 ;;5^26.6^2.8^48.0^3.6^49.0^3.2^39.7^3.1^37.5^4.0^31.8^2.5^49.6^2.5^41.2^5.7
 ;;6^28.9^2.5^51.2^3.1^51.8^2.7^43.1^2.7^41.1^3.7^34.0^2.3^52.0^2.0^44.3^5.8
 ;;7^30.5^2.4^53.7^2.8^53.9^2.4^46.0^2.6^43.8^3.5^35.7^2.2^53.9^1.9^47.3^5.8
 ;;8^31.9^2.3^55.8^2.7^55.7^2.3^48.6^2.5^46.2^3.5^37.3^2.1^55.6^1.9^50.5^5.7
 ;;9^33.2^2.3^57.7^2.6^57.3^2.3^51.0^2.5^48.4^3.4^38.8^2.2^57.1^1.9^54.7^5.9
 ;;10^34.4^2.3^59.5^2.6^58.9^2.3^53.1^2.4^50.5^3.4^40.5^2.3^58.5^1.8^61.2^6.9
 ;;11^35.6^2.3^61.4^2.6^60.5^2.3^55.1^2.4^52.4^3.4^42.3^2.3^59.9^1.8^^
 ;;12^36.7^2.3^63.4^2.6^62.2^2.3^57.0^2.3^54.3^3.4^44.2^2.3^61.2^1.8^^
 ;;13^37.9^2.3^65.3^2.7^63.9^2.3^58.8^2.3^56.1^3.4^46.2^2.3^62.5^1.8^^
 ;;14^39.2^2.4^67.3^2.7^65.7^2.3^60.7^2.3^57.9^3.3^48.1^2.2^63.8^1.8^^
 ;;15^40.5^2.4^69.3^2.7^67.5^2.3^62.7^2.4^59.8^3.3^50.0^2.2^65.2^1.8^^
 ;;16^41.9^2.5^71.2^2.7^69.4^2.3^64.6^2.4^61.7^3.3^51.9^2.2^66.6^1.8^^
 ;;17^43.5^2.6^73.3^2.7^71.2^2.4^66.7^2.4^63.8^3.4^53.7^2.3^68.0^1.8^^
 ;;18^45.5^2.8^75.4^2.7^73.3^2.4^69.0^2.5^66.0^3.4^55.8^2.3^69.7^1.9^^
 ;;19^48.3^3.3^77.9^2.9^75.7^2.6^71.6^2.7^68.8^3.7^58.3^2.7^71.6^2.1^^
 ;;20^57.0^6.6^81.6^3.7^79.4^3.6^75.8^3.9^73.3^4.6^64.2^5.1^75.6^3.7^^
 ;;zzzzz

YTSCAT ;SLC/KCM - CAT Scoring and Reporting ; 6/30/2021
 ;;5.01;MENTAL HEALTH;**182,199,202,217**;DEC 30,1994;Build 12
 ;
DLLSTR(YSDATA,YS,YSMODE) ; main tag for both scores and report text
 ;.YSDATA(1)=[DATA]
 ;.YSDATA(2)=adminId^dfn^testNm^dtGiven^complete
 ;.YSDATA(3..n)=questionId^sequence^choiceId
 ;.YS("AD")=adminId
 ;YSMODE=1 for calc score, 2 for report text
 ;
 ; if score, calculate based on answers in YSDATA, save in ^TMP($J,"YSCOR")
 I YSMODE=1 D SCORE(.YSDATA) QUIT
 ; if report, build special text, add pseudo-question responses to YSDATA
 I YSMODE=2 D REPORT(.YSDATA,.YS) QUIT
 Q
SCORE(YSDATA) ; iterate through answers and calculate score
 ; looks like this is in every scoring routine...
 ; SCOREINS^YTSCORE sets up ^TMP($J,"YSG") with scales
 ; if no scales are defined, we can't score instrument
 K ^TMP($J,"YSCOR")
 I $D(^TMP($J,"YSG",1)),^TMP($J,"YSG",1)="[ERROR]" D  Q  ;-->out
 . S ^TMP($J,"YSCOR",1)="[ERROR]"
 . S ^TMP($J,"YSCOR",2)="No Scale found for ADMIN"
 ;
 N TREE
 D WP2JSON(.YSDATA,.TREE)
 I $$INSNAME(TREE("report","tests",1,"type"))'=$P(^TMP($J,"YSG",2),U,2) D  Q
 . S ^TMP($J,"YSCOR",1)="[ERROR]"
 . S ^TMP($J,"YSCOR",2)="Mismatch of test type"
 ;
 ; currently Severity is the only scale in use for CAT
 N I,X,N,SNUM,SNAME,SCORE
 S N=1,^TMP($J,"YSCOR",N)="[DATA]"
 S I=1 F  S I=$O(^TMP($J,"YSG",I)) Q:'I  D
 . S X=^TMP($J,"YSG",I) Q:$E(X,1,5)'="Scale"
 . S SNUM=$P($P(X,"^"),"=",2),SNAME=$P(X,"^",4)
 . I SNAME="Confidence" S SCORE=$G(TREE("report","tests",1,"confidence"))
 . I SNAME="Percentile" S SCORE=$G(TREE("report","tests",1,"percentile"))
 . I SNAME="Precision" S SCORE=$G(TREE("report","tests",1,"precision"))
 . I SNAME="Probability" S SCORE=$G(TREE("report","tests",1,"prob"))
 . I SNAME="Severity" S SCORE=$G(TREE("report","tests",1,"severity"))
 . I SNAME="Probability",$L(SCORE) S SCORE=SCORE_U_SCORE*100
 . I $L(SCORE) S N=N+1,^TMP($J,"YSCOR",N)=SNAME_"="_SCORE
 Q
REPORT(YSDATA,YS) ; add textual scores to report
 ; at this point YTQRRPT has already called GETSCORE^YTQAPI8 so 
 ; ^TMP($J,"YSCOR") is defined and we're in the middle of ALLANS^YTQAPI2
 ; YSDATA(2+n)=questionId^sequence^choiceId or text response
 N I,TTYP,TREE,SCORTXT,ANSTXT,TSTTXT,ALLANS
 S SCORTXT="",ANSTXT="",TSTTXT="",ALLANS=1
 D WP2JSON(.YSDATA,.TREE)
 S I=0 F  S I=$O(TREE("report","tests",I)) Q:'I  D
 . S TTYP=$$LOW^XLFSTR(TREE("report","tests",I,"type"))
 . S TSTTXT=TSTTXT_$S($L(TSTTXT):", ",1:"")_$$FULLNAME(TTYP)
 . S SCORTXT=SCORTXT_"| |   "_$$FULLNAME(TTYP)
 . I TTYP="mdd" D ADDSCORE(I,"diag^conf")
 . I TTYP="dep" D ADDSCORE(I,"cate^seve^prec^prob^perc")
 . I TTYP="anx" D ADDSCORE(I,"cate^seve^prec^prob^perc")
 . I TTYP="m/hm" D ADDSCORE(I,"cate^seve^prec")
 . I TTYP="sud" D ADDSCORE(I,"cate^seve^prec")
 . I TTYP="sa" D ADDSCORE(I,"cate^seve^prec")
 . I TTYP="ptsd" D ADDSCORE(I,"cate^seve^prec")
 . I TTYP="a/adhd" D ADDSCORE(I,"cate^seve^prec")
 . I TTYP="sdoh" D ADDSCORE(I,"cate^seve^prec")
 . I TTYP="ss" D ADDSCORE(I,"cate^seve^prec")
 . I TTYP="ptsd-dx" D ADDSCORE(I,"diag^prob")
 . I TTYP="ptsd-e" D ADDSCORE(I,"cate^seve^prec")
 . I TTYP="psy-c" D ADDSCORE(I,"cate^seve^prec")
 . I TTYP="psy-s" D ADDSCORE(I,"cate^seve^prec")
 . I $D(TREE("report","tests",I,"items"))>1 S ALLANS=0 D TM4TEST(I),QA4TEST(I)
 ;
 I ALLANS D QA4ALL
 S I=$O(YSDATA(""),-1)+1
 S YSDATA(I)="7771^9999;1^"_SCORTXT               ; scoring text
 S YSDATA(I+1)="7772^9999;1^"_TSTTXT              ; test names for note
 Q
QA4TEST(ITEST) ; add Questions & Answers for 1 Test
 ; expects: TREE,SCORTXT,LN from REPORT
 N ITEM,QID,TXT,DUR
 S TXT=""
 S ITEM=0 F  S ITEM=$O(TREE("report","tests",ITEST,"items",ITEM)) Q:'ITEM  D
 . S QID=$G(TREE("report","tests",ITEST,"items",ITEM,"questionId"))
 . I QID D
 . . S TXT=TXT_$$QA4QID(QID)
 . . S DUR=$G(TREE("report","tests",ITEST,"items",ITEM,"duration"),0)
 . . I DUR S TXT=TXT_"("_$$TMSTR(DUR)_")"
 S SCORTXT=SCORTXT_"||Questions and Answers:|"_TXT
 Q
QA4QID(QID) ; return question & response text from answers
 N ANS,QATXT
 S QATXT=""
 S ANS=0 F  S ANS=$O(TREE("answers",ANS)) Q:'ANS  I TREE("answers",ANS,"id")=QID D  Q
 . S QATXT=$$WRAP($G(TREE("answers",ANS,"text")),75,"|")
 . S QATXT=QATXT_"|   "_$$PAD(25,$G(TREE("answers",ANS,"responseText")))
 Q QATXT
 ;
TM4TEST(SEQ) ; return a block of text with the completion time
 N I,TTIME
 I $G(TREE("status"))="declined" QUIT
 ;
 S TTIME=0
 S I=0 F  S I=$O(TREE("report","tests",SEQ,"items",I)) Q:'I  D
 . S TTIME=TTIME+$G(TREE("report","tests",SEQ,"items",I,"duration"),0)
 D ADDLN("|   Total Elapsed Time: "_$$TMSTR(TTIME))
 Q
QA4ALL ; add Questions & Answers for all tests together
 ; expects: TREE,SCORTXT,LN from REPORT
 N I,TXT
 S TXT=""
 S I=0 F  S I=$O(TREE("answers",I)) Q:'I  D
 . S TXT=TXT_$$WRAP($G(TREE("answers",I,"text")),75,"|")
 . S TXT=TXT_"|   "_$$PAD(25,$G(TREE("answers",I,"responseText")))
 . S TXT=TXT_"("_$$TMSTR($G(TREE("answers",I,"duration"))/1000)_")"
 S SCORTXT=SCORTXT_"||Questions and Answers:|"_TXT
 Q
TM4ALL ; add elapsed time for all questions
 N I,TTIME
 S TTIME=0
 S I=0 F  S I=$O(TREE("answers",I)) Q:'I  D
 . S TTIME=TTIME+$G(TREE("answers",I,"duration"),0)
 S TTIME=TTIME/1000
 D ADDLN("|   Total Elapsed Time: "_$$TMSTR(TTIME))
 Q
ADDSCORE(SEQ,WHICH) ; return a block of text with the appropriate scores
 ; expects TREE,SCORTXT from REPORT
 N I,X
 I $G(TREE("status"))="declined" D ADDLN("|   Interview declined.") QUIT
 ;
 F I=1:1:$L(WHICH) S X=$P(WHICH,"^",I) D
 . I X="diag" D ADDLN("|   Diagnosis:   "_$G(TREE("report","tests",SEQ,"diagnosis")))
 . I X="conf" D ADDLN("|   Confidence:  "_$G(TREE("report","tests",SEQ,"confidence")))
 . I X="seve" D ADDLN("|   Severity:    "_$G(TREE("report","tests",SEQ,"severity")))
 . I X="cate" D ADDLN("|   Category:    "_$G(TREE("report","tests",SEQ,"category")))
 . I X="prec" D ADDLN("|   Precision:   "_$G(TREE("report","tests",SEQ,"precision")))
 . I X="prob" D ADDLN("|   Probability: "_$J(+$G(TREE("report","tests",SEQ,"prob")),1,3))
 . I X="perc" D ADDLN("|   Percentile:  "_$G(TREE("report","tests",SEQ,"percentile")))
 Q
ADDLN(TXT) ; add a line of text
 ; expects SCORTXT from REPORT>ADDSCORE
 S SCORTXT=$G(SCORTXT)_TXT
 Q
FULLNAME(TTYP) ; return full name for a CAT Test Type
 S TTYP=$$LOW^XLFSTR(TTYP)
 I TTYP="mdd" Q "Major Depressive Disorder"
 I TTYP="dep" Q "Depression"
 I TTYP="anx" Q "Anxiety Disorder"
 I TTYP="m/hm" Q "Mania/Hypomania"
 I TTYP="sud" Q "Substance Use Disorder"
 I TTYP="sa" Q "Substance Use Disorder"
 I TTYP="ptsd" Q "Post-Traumatic Stress Disorder"
 I TTYP="a/adhd" Q "Adult ADHD"
 I TTYP="sdoh" Q "Social Determinants of Health"
 I TTYP="ss" Q "Suicide Scale"
 I TTYP="ptsd-dx" Q "PTSD-Diagnosis"
 I TTYP="ptsd-e" Q "PTSD-Expanded"
 I TTYP="psy-c" Q "Psychosis - Clinician"
 I TTYP="psy-s" Q "Psychosis - Self-Report"
 Q "Unknown Test"
 ;
INSNAME(TTYP) ; return full name for a CAT Test Type
 S TTYP=$$LOW^XLFSTR(TTYP)
 I TTYP="mdd" Q "CAD-MDD"
 I TTYP="dep" Q "CAT-DEP"
 I TTYP="anx" Q "CAT-ANX"
 I TTYP="m/hm" Q "CAT-MANIA-HYPOMANIA"
 I TTYP="sud" Q "CAT-SUD"
 I TTYP="sa" Q "CAT-SUD"
 I TTYP="ptsd" Q "CAT-PTSD"
 I TTYP="a/adhd" Q "CAT-ADHD"
 I TTYP="sdoh" Q "CAT-SDOH"
 I TTYP="ss" Q "CAT-SS"
 I TTYP="ptsd-dx" Q "CAD-PTSD-DX"
 I TTYP="ptsd-e" Q "CAT-PTSD-E"
 I TTYP="psy-c" Q "CAT-PSYCHOSIS"
 I TTYP="psy-s" Q "CAT-PSYCHOSIS"
 Q "Unknown Test"
 ;
PAD(LEN,STR) ; return spaces until X is LEN
 N X S X="                                        "
 Q STR_$E(X,1,LEN-$L(STR))
 ;
TMSTR(ATIME) ; return a readable elapsed time
 N MIN,SEC,X
 S MIN=ATIME\60
 S SEC=$P(ATIME-(60*MIN)+0.5,".")
 S X=""
 I MIN S X=MIN_$S(MIN=1:" minute ",1:" minutes ")
 S X=X_SEC_$S(SEC=1:" second",1:" seconds")
 Q X
 ;
WP2JSON(YSDATA,TREE) ; put YSDATA answer into M-subscript format
 N I,J,K,L,JSON
 S I=2,K=0 F  S I=$O(YSDATA(I)) Q:'I  Q:$P(YSDATA(I),U)'=8650  D
 . S L=$P(YSDATA(I),"^",3,99)
 . F J=1:1:$L(L,"|") S K=K+1,JSON(K)=$P(L,"|",J)
 D DECODE^XLFJSON("JSON","TREE")
 Q
WRAP(IN,MAX,PRE) ; Return with | and spacing in correct place
 N X,I,J,TXT,WORD
 S J=1,TXT(J)=PRE_$P(IN," ")
 F I=2:1:$L(IN," ") S WORD=$P(IN," ",I) D
 . I ($L(TXT(J))+$L(WORD)+1)<MAX S TXT(J)=TXT(J)_" "_WORD I 1
 . E  S J=J+1,TXT(J)=PRE_WORD
 S X=TXT(1),I=1 F  S I=$O(TXT(I)) Q:'I  S X=X_TXT(I)
 Q X
 ;

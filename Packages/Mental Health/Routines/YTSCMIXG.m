YTSCMIXG ;SLC/KCM - Score Case Mix Level ; 11/03/2020
 ;;5.01;MENTAL HEALTH;**174,187**;DEC 30,1994;Build 73
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
 ; -- compute the ADL, then the Case Mix Level
 N I,QID,CID,QSTN,ADL,ADLD,LVL,LVLNM,ADLNM
 S I=2 F  S I=$O(YSDATA(I)) Q:'I  D
 . S QID=$P(YSDATA(I),U),CID=$P(YSDATA(I),U,3)
 . S QSTN(QID)=$$GET1^DIQ(601.75,CID_",",4,"I")
 S ADLD=0 ; count ADL dependencies
 I $G(QSTN(8535))>1 S ADLD=ADLD+1 ; Q1 Dependency: 2-4 Dressing
 I $G(QSTN(8536))>1 S ADLD=ADLD+1 ; Q2 Dependency: 2-3 Grooming
 I $G(QSTN(8537))>3 S ADLD=ADLD+1 ; Q3 Dependency: 4-5 Bathing
 I $G(QSTN(8538))>1 S ADLD=ADLD+1 ; Q4 Dependency: 2-4 Eating
 I $G(QSTN(8539))>1 S ADLD=ADLD+1 ; Q5 Dependency: 2-3 Bed Mobility*
 I $G(QSTN(8540))>1 S ADLD=ADLD+1 ; Q6 Dependency: 2-4 Transferring*
 I $G(QSTN(8541))>1 S ADLD=ADLD+1 ; Q7 Dependency: 2-4 Walking
 I $G(QSTN(8544))>0 S ADLD=ADLD+1 ;Q10 Dependency: 1-7 Toileting*
 S ADL=$S(ADLD<4:"Low",((ADLD>3)&(ADLD<7)):"Medium",ADLD>6:"High")
 S LVL=$$LEVEL(.QSTN,ADL,ADLD)
 ; store the scores as numeric as required by MH RESULTS
 S LVLNM=$P(^YTT(601.87,1352,0),U,4) ; 1352 is case mix level
 S ADLNM=$P(^YTT(601.87,1353,0),U,4) ; 1353 is number of ADL dependencies
 S ^TMP($J,"YSCOR",1)="[DATA]"
 S ^TMP($J,"YSCOR",2)=LVLNM_"="_$S($L(LVL):$A(LVL)-64,1:0)
 S ^TMP($J,"YSCOR",3)=ADLNM_"="_ADLD
 Q
LEVEL(QSTN,ADL,ADLD) ; Return Case Mix Level given questions(.QSTN) and ADL score
 N Q4,Q5,Q6,Q8,Q10,Q13,Q14,Q15
 S Q4=$G(QSTN(8538))   ; Eating
 S Q5=$G(QSTN(8539))   ; Bed Mobility
 S Q6=$G(QSTN(8540))   ; Transferring
 S Q8=$G(QSTN(8542))   ; Behavior
 S Q10=$G(QSTN(8544))  ; Toileting
 S Q13=$G(QSTN(8547))  ; Special Treatments
 S Q14=$G(QSTN(8549))  ; Clinical Monitoring
 S Q15=$G(QSTN(8550))  ; Special Nursing
 ;
 ; B: special nursing with tubefeedsing or treatments & monitoring
 N SPNURS S SPNURS=0
 I Q15>0,((Q13=1)!((Q13=2)&(Q14=2))) S SPNURS=1
 I SPNURS,(ADL="Low") Q "C"
 I SPNURS,(ADL="Medium") Q "F"
 I SPNURS,(ADL="High") Q "K"
 ;
 ; C: behavioral consideration for low & medium
 I ADL="Low",(Q8>1) Q "B"
 I ADL="Medium",(Q8>1) Q "E"
 ;
 ; D: low and medium ADL without special nursing or behavior
 ; (Q5=Bed Mobility, Q6=Transferring, Q10=Toileting, Q8=Behavior)
 N CRIT S CRIT=0 I (Q5>1)!(Q6>1)!(Q10>0) S CRIT=1
 I ADLD<3,(Q8<2),'CRIT Q "L"
 I ADL="Low",(Q8<2) Q "A"
 I ADL="Medium",(Q8<2) Q "D"
 ;
 ; E: high ADL without special nursing (Q4=Eating, Q8=Behavior)
 I ADLD>6,(Q4<3),(Q8<2) Q "G"
 I ADLD>6,(Q4<3),(Q8>1) Q "H"
 I ADLD>6,(Q4>2),(Q8<3),'$$NEUROICD Q "I"
 I ADLD>6,(Q4>2),((Q8>2)!$$NEUROICD) Q "J"
 Q ""
 ;
NEUROICD() ; Return 1 if any applicable neurodiagnoses present
 ; expects QSTN from LEVEL
 Q +$G(QSTN(8551))  ; Q16 -- Neuromuscular Diagnosis
 ;
 ; the following currently inactive code uses a clinical reminders taxonomy
 ; expects YS("AD") as adminId
 ;N YTDFN,YTRMDR,YTFNDG
 ;S YTDFN=$P(^YTT(601.84,YS("AD"),0),U,2) Q:'YTDFN 0
 ;S YTRMDR=$$FIND1^DIC(811.9,"","BX","CASE MIX NEURO") Q:'YTRMDR 0
 ;D FIDATA^PXRM(YTDFN,YTRMDR,.YTFNDG)
 ;Q ($G(YTFNDG(1))>0)
 ;
REPORT(YSDATA,YS) ; add textual scores to report
 ; at this point YTQRRPT has already called GETSCORE^YTQAPI8 so 
 ; ^TMP($J,"YSCOR") is defined and we're in the middle of ALLANS^YTQAPI2
 ; YSDATA(2+n)=questionId^sequence^choiceId or text response
 N I,LVLNM,ADLNM,LVL,ADLD,ADL,STXT,QTXT,SPTX,QID,CID,NUM,LEG,CTXT
 S LVLNM=$P(^YTT(601.87,1352,0),U,4) ; 1352 is case mix level
 S ADLNM=$P(^YTT(601.87,1353,0),U,4) ; 1353 is number of ADL dependencies
 S I=0 F  S I=$O(^TMP($J,"YSCOR",I)) Q:'I  D
 . I $P(^TMP($J,"YSCOR",I),"=")=LVLNM S LVL=$P(^TMP($J,"YSCOR",I),"=",2)
 . I $P(^TMP($J,"YSCOR",I),"=")=ADLNM S ADLD=$P(^TMP($J,"YSCOR",I),"=",2)
 S ADL=$S(((+ADLD=ADLD)&(ADLD<4)):"Low",((ADLD>3)&(ADLD<7)):"Medium",ADLD>6:"High",1:"Unknown")
 S LVL=$S(LVL>0:$C(LVL+64),1:"Unknown")
 S STXT="               Case Mix Level: "_LVL_"|                ADL Category: "_ADL_" |"
 S QTXT="",SPTX=""  ; question text & special treatments (Q13a)
 S I=2 F  S I=$O(YSDATA(I)) Q:'I  D
 . S QID=$P(YSDATA(I),U),CID=$P(YSDATA(I),U,3)
 . Q:QID>8549  ; handle Q1 thru Q14, remaining are in template
 . I QID=8548 S:CID'=1156 SPTX=CID Q              ; get checkbox text & quit
 . S NUM=+$P($P(^YTT(601.76,QID,0),U,5),"Q",2)    ; question number
 . S LEG=$P(^YTT(601.75,CID,0),U,2)               ; legacy value (score)
 . S CTXT=$TR(^YTT(601.75,CID,1),"?",".")         ; choice text as stmt
 . I $E(CTXT,1,2)="* " S CTXT=$E(CTXT,3,$L(CTXT)) ; * already added to LEG
 . I $L(CTXT)>69 S CTXT=$$WRAP(CTXT,68)           ; wrap longer choices
 . ; mark dependencies
 . I QID<8543,(QID'=8537),(LEG>1) S LEG="*"_LEG   ; Q1-Q8, except Q3
 . I QID=8537,(LEG>3) S LEG="*"_LEG               ; Q3  (bathing)
 . I QID=8544,(LEG>0) S LEG="*"_LEG               ; Q10 (toileting)
 . ; set up question, score, & response
 . S LEG=$S($L(LEG)=2:LEG,1:" "_LEG)
 . S QTXT(NUM)=$P($T(QUESTIONS+NUM),";;",2)_"    "_LEG_"  "_CTXT
 I $L(SPTX) D                                     ; add special tx if any
 . S SPTX="One or more TX such as: "_SPTX
 . I $L(SPTX)>69 S SPTX=$$WRAP(SPTX,68)
 . S QTXT(13)=QTXT(13)_$P(SPTX,"One or more TX such as:",2)
 F I=1:1:14 S QTXT=QTXT_QTXT(I)                   ; make one string
 S I=$O(YSDATA(""),-1)+1
 S YSDATA(I)="7771^9999;1^"_STXT                  ; scoring text
 S YSDATA(I+1)="7772^9999;1^"_QTXT                ; question text (1-14)
 Q
WRAP(IN,MAX) ; Return with | and spacing in correct place
 N X,I,J,TXT,WORD
 S J=1,TXT(J)=$P(IN," ")
 F I=2:1:$L(IN," ") S WORD=$P(IN," ",I) D
 . I ($L(TXT(J))+$L(WORD)+1)<MAX S TXT(J)=TXT(J)_" "_WORD I 1
 . E  S J=J+1,TXT(J)=WORD
 S X=TXT(1),I=1 F  S I=$O(TXT(I)) Q:'I  S X=X_"|        "_TXT(I)
 Q X
 ;
QUESTIONS ; question number and header text
 ;;|Q1.  DRESSING|
 ;;|Q2.  GROOMING|
 ;;|Q3.  BATHING|
 ;;|Q4.  EATING|
 ;;|Q5.  BED MOBILITY|
 ;;|Q6.  TRANSFERRING|
 ;;|Q7.  WALKING|
 ;;|Q8.  BEHAVIOR|
 ;;|Q9.  COMMUNICATION|
 ;;|Q10. TOILETING|
 ;;|Q11. MDS HC 2.0/CPS Cognitive Skill for Daily Decision Making|
 ;;|Q12. MDS 2.0/CPS: Short Term Memory (recall of what was learned or known)|
 ;;|Q13. SPECIAL TREATMENTS|
 ;;|Q14. CLINICAL MONITORING|
 ;;zzzzz

YTQRQAD6 ;SLC/LLB - Determine High Risk Flagging ; 07/15/2020
 ;;5.01;MENTAL HEALTH;**158,181,187,204**;Dec 30, 1994;Build 18
 ;
 ; The assumption is made that variable DFN will exist prior to calling this routine.
 ;
FLAG(DFN,INST,HRR,PR) ; ROUTINE to calculate Positive response and High Risk flagging
 ; ICR #4290 READ OF CLINICAL REMINDER INDEX (PXRMINDX)
 ;  DFN:    IEN to Patient file (#2)
 ;  INST:   Instriment name in MH TESTS AND SURVEYS file (#601.71)
 ;  INSTIEN: IEN to instrument in MH TESTS AND SURVEYS file (#601.71)
 ;  HRR:    High Risk Requirement
 ;             # score greater than #
 ;            A# any question with a score >#
 ;            I9 Positive I9 question
 ;            Y1,2,3,n. Comma delimited list of question numbers. A yes to any is HR
 ;            YA Yes to any question
 ;            G3^0,5^1,q^n. Comma delimited list of question#^Value for question response Greater Than Value
 ;            T#p Can be added to any HRR parameter where # is a positive integer and
 ;                p is the time period M months, W weeks, D day. This will be treated as
 ;                the most recent administration of the instrument but only if the 
 ;                  Ex: "Y,1,2,3,T6M" indicates Yes to Q 1,2, or 3 within the last 6
 ;                      months.
 ;                  Ex: "Y,1,2,3,T6M-I9" is the same as the previous example except that
 ;                      a positive I9, without regard to time frame, triggers High Risk.
 ;           HRR parameters can be combined by adding "-" between them indicating an "or"
 ;               such as "Y,3,4,5,8-I9"
 ;  PR:     Positive Response threshold, Score greater than number passed in PR. 
 ;          Based solely on total score. Ex: 8 indicating any score greater than 8.
 ;  YSFLAG: Will be 0 for no risk
 ;                  1 for Positive Response
 ;                  2 for High Risk
 ;                  3 for Both Positive response & High Risk
 ;          The field SUICIDE RISK (#16) in the MH ADMINISTRATION file (#601.84) will be
 ;          populated with the result.
 N DATE,ADMID,YSFLAG,YS,SI,MULT,INSTIEN,YSLIM,YSCORE
 S SI=0
 I 'DFN D SETERROR^YTQRUTL(404,"Not Found: No patient passed. Cannot continue.") Q
 I INST="" D SETERROR^YTQRUTL(404,"Not Found: No instrument passed. Cannot continue.") Q
 S YSFLAG=0
 S INSTIEN=$O(^YTT(601.71,"B",INST,0)) Q:'$D(^PXRMINDX(601.84,"PI",DFN,INSTIEN))
 S DATE=""
 ; Get date of administration most recent to oldest
 F  S DATE=$O(^PXRMINDX(601.84,"PI",DFN,INSTIEN,DATE),-1) Q:DATE=""  D FLAG2
 Q
 ;
FLAG2 ;
 N X,YSHRT,CURFLG,AGE
 S ADMID=$O(^PXRMINDX(601.84,"PI",DFN,INSTIEN,DATE,"")) ;IEN to file 601.84
 ; NOTE: The ARC index is only updated for completed administrations.
 ; A separate check for Administration COMPLETE is not necessary
 S CURFLG=$P(^YTT(601.84,ADMID,0),U,14)
 I CURFLG=0!(CURFLG=9) Q  ;Flag already set to 'none' or 'expired'
 ;Any PR/HR flag older than 90 days should be set to 'expired'
 I $$FMDIFF^XLFDT($$HTFM^XLFDT($H),DATE)>90 D  Q
 . S YSFLAG=9 D SETFLAG
 I $P(^YTT(601.84,ADMID,0),U,14)'="" Q  ; Flag already set don't recalculate
 D QUEST(ADMID,INST) ; Retrieve questions and patient answers and set them into ^TMP("YSQA",$J,INST,CNT)
 D SCORES ; Get scores for assessment
 S YSFLAG=0
 I PR,YSCORE>PR S YSFLAG=1 ; Evaluate Positive response 
 S MULT=$L(HRR,"-") ; Parse HRR for multiples
 F X=1:1:MULT Q:YSFLAG>1  D
 . S YSLIM=14600 ; 40 Yrs
 . S YSHRT=$P(HRR,"-",X)
 . I YSHRT["T" S YSLIM=$$TIME(YSHRT) ; Check for T specific parameter 
 . I $$FMDIFF^XLFDT($$NOW^XLFDT,DATE,1)>YSLIM Q  ;Assignment too old
 . I YSHRT?1N.E S SI=+YSHRT D HRSCR Q:YSFLAG>1  ; Test for HR based only on Total Raw score
 . I YSFLAG>1 Q  ; High Risk flag already set
 . I $E(YSHRT,1,2)="YA" D YATAG
 . I YSFLAG>1 Q  ; High Risk flag already set
 . I YSHRT?1"Y".N.E D YTAG
 . I YSFLAG>1 Q  ; High Risk flag already set
 . I $E(YSHRT,1)="A" D ATAG
 . I YSFLAG>1 Q  ; High Risk flag already set
 . I $E(YSHRT,1,2)="I9" D I9TAG ;Check for HR solely on I9 question
 . I YSFLAG>1 Q  ;High Risk flag already set
 . I $E(YSHRT,1)="G" D GTTAG
 K ^TMP("YSQA",$J) ; Cleanup ^TMP file
 D SETFLAG Q
 ;
QUEST(ADMID,INST) ; Create core code to look at questions and answers
 ; Requires Administration ID (ADMID) and Instrument name (INST) as an pre-existing value. 
 N TEMP,QNUM,ANSID,QST,CHOICE,CNT,LEG,I
 K ^TMP("YSQA",$J)
 S (QNUM,CNT)=0
 F  S QNUM=$O(^YTT(601.85,"AC",ADMID,QNUM)) Q:QNUM=""  D
 . S ANSID=$O(^YTT(601.85,"AC",ADMID,QNUM,0))
 . S TEMP=^YTT(601.85,ANSID,0)
 . S QST="",I=0,CNT=CNT+1
 . F  S I=$O(^YTT(601.72,$P(TEMP,U,3),1,I)) Q:I=""  D
 . . I $E(QST,$L(QST))?1A S QST=QST_" "
 . . S QST=QST_^YTT(601.72,$P(TEMP,U,3),1,I,0)
 . I $P(TEMP,U,4)="NOT ASKED" S CHOICE="NOT ASKED",LEG=""
 . E  S CHOICE=$S($P(TEMP,U,4)="":"",1:$G(^YTT(601.75,$P(TEMP,U,4),1))),LEG=$S($P(TEMP,U,4)="":"",1:$P($G(^YTT(601.75,$P(TEMP,U,4),0)),U,2))
 . I CHOICE="" S CHOICE="Skipped"
 . S:'$D(LEG) LEG=""
 . S ^TMP("YSQA",$J,INST,CNT)=QST_U_CHOICE_U_LEG
 Q
 ;
SCORES ;
 ;Get total Raw score for administration
 N YSDATA
 S YS("AD")=ADMID
 S YS("CODE")=INST
 S YS("ADATE")=DATE ;$P(^YTT(601.84,ADMID,0),U,3)
 S YS("DFN")=DFN
 K ^TMP($J,"YSCOR"),^TMP($J,"YSG")
 D GETSCORE^YTQAPI8(.YSDATA,.YS)
 S YSCORE=$P(^TMP($J,"YSCOR",2),"=",2)
 Q
 ;
TIME(TPAR) ;
 N DAYS,INC,PERIOD
 S TEMP=$P(TPAR,"T",2)
 S INC=+TEMP
 S PERIOD=$E(TEMP,$L(TEMP))
 I PERIOD="D" S DAYS=INC
 I PERIOD="W" S DAYS=INC*7
 I PERIOD="M" S DAYS=$P(INC*365/12+.5,".") ;Assume 1 month=30.42 days
 Q DAYS
 ;
HRSCR ;
 I YSCORE>SI,YSFLAG=1 S YSFLAG=3 ; Both High Risk & Positive Response
 I YSCORE>SI,YSFLAG<1 S YSFLAG=2 ; High Risk
 Q
 ;
YTAG ; Yes to any of specific list of questions.
 N CNT,CHOICE,TEMP
 S TEMP=$E(YSHRT,2,$L(YSHRT))
 I TEMP["T" S TEMP=$P(TEMP,"T",1)
 S CNT=0
 F  S CNT=$O(^TMP("YSQA",$J,INST,CNT)) Q:CNT=""!(YSFLAG>1)  D
 . I TEMP'[CNT Q
 . S CHOICE=$P(^TMP("YSQA",$J,INST,CNT),U,2) ; if any are Yes set flag and quit
 . S CHOICE=$TR(CHOICE,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 . I CHOICE?1"Y".2U D
 . . I YSFLAG=1 S YSFLAG=3
 . . E  S YSFLAG=2
 Q
 ;
YATAG ; If Yes to any question is High Risk
 N CNT,CHOICE
 S CNT=0
 F  S CNT=$O(^TMP("YSQA",$J,INST,CNT)) Q:CNT=""!(YSFLAG>1)  D
 . S CHOICE=$P(^TMP("YSQA",$J,INST,CNT),U,2) ; if any are Yes set flag and quit
 . S CHOICE=$TR(CHOICE,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 . I CHOICE?1"Y".2U D
 . . I YSFLAG=1 S YSFLAG=3
 . . E  S YSFLAG=2
 Q
 ; 
ATAG ; any question with a score > that passed in with the A# parameter.
 N MIN,AID,TEMP,QID,CHOICEID,LEG
 S MIN=$E(YSHRT,2,$L(YSHRT))
 S AID=""
 F  S AID=$O(^YTT(601.85,"AD",ADMID,AID)) Q:AID=""!(YSFLAG>1)  D
 . S TEMP=^YTT(601.85,AID,0)
 . S QID=$P(TEMP,U,3),CHOICEID=$P(TEMP,U,4)
 . S LEG=$P(^YTT(601.75,CHOICEID,0),U,2)
 . I LEG>MIN D
 . . I YSFLAG=1 S YSFLAG=3
 . . E  S YSFLAG=2
 Q
 ;
I9TAG ;
 N TEST,TEMP,CNT
 S TEST="houghts that you would be better off dead",CNT=0
 F  S CNT=$O(^TMP("YSQA",$J,INST,CNT)) Q:CNT=""!(YSFLAG>1)  D
 . S TEMP=^TMP("YSQA",$J,INST,CNT)
 . I $P(TEMP,U,1)[TEST D
 . . I $P(TEMP,U,2)'="",($P(TEMP,U,2)'="Not at all") D
 . . . I YSFLAG=1 S YSFLAG=3
 . . . E  S YSFLAG=2
 Q
 ;
GTTAG ; specific question with a score > that passed in with the GT# parameter.
 ; If any of the comma delimited question#>value, then YSFLAG=2 for HIGH RISK
 N MIN,AID,TEMP,QID,CHOICEID,LEG
 N QARR,I,PR
 S YSFLAG=0
 S TEMP=$E(YSHRT,2,$L(YSHRT))
 F I=1:1:$L(TEMP,",") D
 . S PR=$P(TEMP,",",I)
 . S AID=$P(PR,U) Q:AID=""  ;If definition malformed
 . S QARR(AID)=$P(PR,U,2)  ;QARR(Ques#)=Greater Than value
 S MIN=$E(YSHRT,2,$L(YSHRT))
 S AID=""
 F  S AID=$O(QARR(AID)) Q:AID=""  D
 . S TEMP=$G(^TMP("YSQA",$J,INST,AID)) Q:TEMP=""
 . S LEG=$P(TEMP,U,3)
 . I LEG>QARR(AID) S YSFLAG=2
 Q
SETFLAG ; Set YSFLAG into the MH ADMISISTRATION file (#601.84)
 N XXX,YSFDA
 S XXX=ADMID_","
 S YSFDA(601.84,XXX,16)=YSFLAG D FILE^DIE("K","YSFDA","YSERR")
 Q 
 ;
BHS ; BHS
 ; High Risk: Score of > 8
 ; Positive Response: None 
 N INST,HRR,PR
 S INST="BHS"
 S HRR=8
 S PR=""
 D FLAG(DFN,INST,HRR,PR)
 Q
 ;
BSS ; BSS
 ; High Risk: Score > 0 to any question
 ; Positive Response: None
 N INST,HRR,PR
 S INST="BSS"
 S HRR="A0"
 S PR=""
 D FLAG(DFN,INST,HRR,PR)
 Q
 ;
PHQ2I9 ; PHQ-2+I9
 ; High Risk: I9 > 0
 ; Positive Response: Score >2
 N INST,HRR,PR
 S INST="PHQ-2+I9"
 S HRR="I9"
 S PR=2
 D FLAG(DFN,INST,HRR,PR)
 Q
 ;
PSS3 ; PSS-3
 ; High Risk: Yes to any of Q1,2,3 within the last 6 months
 ; Positive Response: None
 N INST,HRR,PR
 S INST="PSS-3"
 S HRR="Y1,2,3,T6M"
 S PR=""
 D FLAG(DFN,INST,HRR,PR)
 Q
 ;
PSS32ND ; PSS-3 2ND
 ; High Risk: Yes to any of the questions
 ; Positive Response: None 
 N INST,HRR,PR
 S INST="PSS-3 2ND"
 S HRR="YA"
 S PR=""
 D FLAG(DFN,INST,HRR,PR)
 Q
 ;
CSSRS ; C-SSRS
 ; High Risk: Yes to any of Q3,4,5,8
 ; Positive Response: None 
 N INST,HRR,PR
 S INST="C-SSRS"
 S HRR="Y3,4,5,8"
 S PR=""
 D FLAG(DFN,INST,HRR,PR)
 Q
 ;
I9CSSRS ; I9+C-SSRS
 ; High Risk: Yes to any of Q3,4,5,8 or I9 > 0
 ; Positive Response: None
 N INST,HRR,PR
 S INST="I9+C-SSRS"
 S HRR="Y3,4,5,8-I9"
 S PR=""
 D FLAG(DFN,INST,HRR,PR)
 Q
 ;
PHQ9 ; PHQ9 Instrument
 ; High Risk: I9 > 0
 ; Positive Response: Score > 9 
 N INST,HRR,PR
 S INST="PHQ9"
 S HRR="I9"
 S PR=9
 D FLAG(DFN,INST,HRR,PR)
 Q
 ;
PTSD5I9 ; PC-PTSD-5+19
 ; High Risk: I9 > 0
 ; Positive Response: None 
 N INST,HRR,PR
 S INST="PC-PTSD-5+I9"
 S HRR="I9"
 S PR=""
 D FLAG(DFN,INST,HRR,PR)
 Q
 ;
BDI2 ; BDI2 Instrument
 ; High Risk: Question 9 > 0
 N INST,HRR,PR
 S INST="BDI2"
 S HRR="G9^0"
 S PR=""
 D FLAG(DFN,INST,HRR,PR)
 Q
CCSA ; CCSA-DSM5 Instrument
 ; High Risk: Question 9 > 0
 N INST,HRR,PR
 S INST="CCSA-DSM5"
 S HRR="G11^0"
 S PR=""
 D FLAG(DFN,INST,HRR,PR)
 Q
 ;

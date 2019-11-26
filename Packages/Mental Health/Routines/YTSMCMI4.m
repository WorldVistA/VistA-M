YTSMCMI4 ;BAL/KTL- MHAX ANSWERS SPECIAL HANDLING #2 ; 9/14/18 3:19pm
 ;;5.01;MENTAL HEALTH;**151**;Dec 30, 1994;Build 92
 ;
 ; MCMI4 Scoring
 ;
 ; This routine handles limited complex reporting requirements withoutmodifying YS_AUX.DLL by adding free text "answers" that can be used by
 ; a report.
 ;
 ; Assumptions:  EDIT incomplete instrument should ignore the extra answers since there are no associated questions.  GRAPHING should ignore the
 ; answers since they not numeric.
 ;
DLLSTR(YSDATA,YS,YSTRNG) ;
 ;  YSTRNG = 1 Score Instrument
 ;  YSTRNG = 2 get Report Answers and Text
 N YSCNT,YSIND,CNT,YSCOD,YSINVRPT,YSCALRSL,YSRAWRSL,YSQANS,YSQANS2,YSQSCAL,YSNOGRPH,HIARR,SCALOD
 N YBRS,YPRS   ;Calculated Base Rate, Calculated PR
 N YSNOTE      ;Noteworthy Responses Array
 N LOGIT,RECALC
 S N=N+1
 D INICOD^YTSMCMIB  ;Generate array YSCOD(scalename)=scalecode
 D INIBRS^YTSMCMIC  ;initialize YBRS(scalecode,"STR") that gets possible Base Rate for each scale Raw
 D INIPRS^YTSMCMID  ;initialize YPRS(scalecode,"STR") that gets possible Percentile for each scale Raw (Facet) or Adjusted Base Rate (Non-Facet)
 D YSQ^YTSMCMIB     ;initialize YSQSCAL(scalcode)=questions for that scale.  Needed to check if any scales are invalid.
 D DATA1
 I YSTRNG=1 Q
 ; Generate Report Sections
 ;D LDSCORES^YTSCORE(.YSDATA,.YS)
 K ^YKTL($J,"YSCOR1") M ^YKTL($J,"YSCOR1")=^TMP($J,"YSCOR")
 D MODIND   ;Modifying Indices
 D CPP      ;Clinical Personality Patterns
 D SPP      ;Severe Personality Pathology
 D CS       ;Clinical Syndromes
 D SCS      ;Severe Clinical Syndromes
 D TOP3     ;3 Highest Grossman Facet Scales
 D FACET    ;All Grossman Facet Scales
 D NTWRTHY  ;Noteworthy Responses
 D RESP    ;Set up the table of Responses
 Q
DATA1 ;Extract results can do calculations
 ;I YSTRNG=1, add up the RAW values for each scale. then calculate the adjusted Base Rate and Percentile Rankings, Save them and quit
 ;I YSTRNG=2, then extract them from the saved values, Do any report calculations, Then display the report
 I YSTRNG=1 D  Q
 .D EXTANS  ;Extract the T/F responses to each question - Needed because YSARRAY in different order
 .D ^YTSMCMIA
 D LDSCORES^YTSCORE(.YSDATA,.YS)
 ;Extract the Raw Scale Results;Get the High Point Scores;Get the Base Rate Adjustment Header;Get the V result for Invalidity;Get the W result for Inconsistency
 D EXTRSL,EXTANS,HIGHPT,BRADJH,INVDH,INCNH
 S YSINVRPT=$$INVRPT()  ; See if INVALID Reprt conditions exist
 I YSINVRPT'="" D INVALID(YSINVRPT)
 D INVSCL  ;See if any Scale is invalid
 D ELEV    ;Get the top three Grossman Facet scale for the Elevated Scales portion of the report
 D NOTEW   ;Get the Noteworthy Responses
 Q
INVRPT() ;
 ; Check for Invalid Report conditions
 ; Raw V > 1  ;Invalidity Index elevated
 ; Raw X > 114 ! Raw X < 7  ;Scale X outside acceptable range
 ; All Scales 1-8B Base Rate < 60  ; All scales too low
 ; Raw W > 19  ;Inconsistency Index elevated
 ; Return INVRPT of 1 = YES, INVALID
 ;                  0 = NO, OK TO PROCEED
 N INVSTR,SCALSTR,SCAL,CHK,XQUES,QUES,I
 I YSRAWRSL("V Invalidity")>1 S INVSTR="The Invalidity Index is elevated." Q INVSTR
 I YSRAWRSL("X Disclosure")<7!(YSRAWRSL("X Disclosure")>114) S INVSTR="Scale X is outside of an acceptable range." Q INVSTR
 S CHK=""
 F I=1145:1:1156 D
 .S SCAL=$$GET1^DIQ(601.87,I_",",3,"I")
 .S SCAL=$G(YBRS(SCAL,"RSL"))
 .Q:SCAL<60
 .S CHK=1
 I CHK="" S INVSTR="Scales 1-8B are all less than 60 BR" Q INVSTR
 I $G(YSRAWRSL("W Inconsistency"))>19 S INVSTR="The Inconsistency Index is elevated." Q INVSTR
 S XQUES=YSQSCAL("X Disclosure")
 S CHK=0
 F I=1:1:$L(XQUES,U) D
 .S QUES=$P(XQUES,U,I) I YSQANS(QUES)="" S CHK=CHK+1
 I CHK>13 S INVSTR="X Omits greater than 13" Q INVSTR
 Q ""
INVALID(INVSTR) ;
 ; Text for invalid report
 N I,DONE
 S DONE=""
 S I="" F  S I=$O(YSDATA(I)) Q:I=""!(DONE=1)  D
 .I YSDATA(I)["7771" S $P(YSDATA(I),U,3)="",DONE=1  ;If INVALID, do not display HP Code
 S N=N+1,YSDATA(N)="7783^9999;1^INVALID PROFILE: "_INVSTR_"|"
 S YSNOGRPH=1  ;Do not Graph BR Scores
 Q
INVSCL ;
 ;See if any scale is invalid, more than 2 or 4 omits
 N OMITS,SCALSTR,SCAL,QUES,RSL,CNT,I,II
 F I=1140:1:1143,1145:1:1169,1240:1:1284 D  ;1142 VS 1143
 .;S SCAL=^YTT(601.87,I,0)
 .S SCAL=$$GET1^DIQ(601.87,I_",",3,"I")
 .S CNT=0
 .I SCAL="X Disclosure"!(SCAL="W Inconsistency") Q
 .S OMITS=4 I SCAL="V Invalidity" S OMITS=2
 .F II=1:1:$L(YSQSCAL(SCAL),U) D
 ..S QUES=$P(YSQSCAL(SCAL),U,II),RSL=YSQANS(QUES)
 ..I RSL'=1,(RSL'=2) S CNT=CNT+1
 .I CNT>OMITS D
 ..S YSRAWRSL(SCAL)="-"
 ..S YBRS(SCAL,"RSL")="-"
 ..S YPRS(SCAL,"RSL")="-"
 Q
EXTANS ;
 ;Extract the T/F responses to each question from YSDATA array
 ;TRUE=1 FALSE=2
 N X,QUEST,ANS,STR,PTR,DATA
 S X=2
 F  S X=$O(YSDATA(X)) Q:+X=0  D
 .S DATA=YSDATA(X)
 .S ANS=$$GET1^DIQ(601.75,$P($G(DATA),U,3)_",",4,"I")
 .S QUES=$P(DATA,U,2),PTR=$P(DATA,U)
 .;S ANS=$S(ANS=3919:1,ANS=3920:2,1:"")
 .S YSQANS(QUES)=ANS
 .S YSQANS(QUES,"PTR")=PTR
 .S YSQANS2(PTR)=ANS
 Q
EXTRSL ;
 ; Extract the Raw score and store by Scale Name
 N I,SCAL,VAL,BR,PR,RAW,YSAD,YSCALE,G,SCLNAM
 M ^YKTL($J,YSTRNG,"YSDATA")=YSDATA
 K ^YKTL($J,"YSCOR",YSTRNG) M ^YKTL($J,"YSCOR",YSTRNG)=^TMP($J,"YSCOR")
 S I=1 F  S I=$O(^TMP($J,"YSCOR",I)) Q:I=""  D
 .S VAL=^TMP($J,"YSCOR",I),SCAL=$P(VAL,"="),VAL=$P(VAL,"=",2)
 .S RAW=$P(VAL,U),YSRAWRSL(SCAL)=RAW
 .S BR=$P(VAL,U,2),YBRS(SCAL,"RSL")=BR
 .S PR=$P(VAL,U,3),YPRS(SCAL,"RSL")=PR
 .S SCLNAM(SCAL)=I  ;Index of ^TMP($J,"YSCOR") by scalename to extract calculated results below
 ;^TMP($J,"YSCOR") only contains the first value from 601.92
 ;If YTSCORE is updated to extract computed result fields this may not
 ;be needed in the future.
 D EX2
 Q
EX2 ; PATCH UNTIL WE FIGURE OUT WHY T-SCORE NOT IN ^TMP($J,"YSCOR") 
 S YSAD=$G(YS("AD"))
 S YSCALE=""
 F  S YSCALE=$O(^YTT(601.92,"AC",YSAD,YSCALE))  Q:'YSCALE  D
 .S G=$G(^YTT(601.92,YSCALE,0))
 .S SCAL=$P(G,U,3)
 .S RAW=$P(G,U,4),BR=$P(G,U,5),PR=$P(G,U,6)
 .;S YSRAWRSL(SCAL)=RAW
 .S YBRS(SCAL,"RSL")=BR
 .S YPRS(SCAL,"RSL")=PR
 Q
HIGHPT ; Highpoint Header
 S N=N+1
 N TEXT1,SCAL,SCALC,SCALSTR,SCALCOD,I,HI,DONE,SCALR
 S TEXT1=""
 S SCALCOD="1 ^2A^2B^3 ^4A^4B^5 ^6A^6B^7 ^8A^8B"  ;Spaces added to sort correctly
 ;F I=1:1:$L(SCALSTR,U) D
 F I=1145:1:1156 D
 .S SCAL=$$GET1^DIQ(601.87,I_",",3,"I")
 .S SCALR=$G(YBRS(SCAL,"RSL"))
 .Q:SCALR'>59
 .S SCALC=YSCOD("NAME",SCAL) S:$L(SCALC)=1 SCALC=SCALC_" "  ;To sort numbers vs strings correctly
 .S HI(-SCALR,SCALC)=""
 S DONE=0,I=0
 S SCAL="" F  S SCAL=$O(HI(SCAL)) Q:SCAL=""!DONE  D
 .S SCALC="" F  S SCALC=$O(HI(SCAL,SCALC)) Q:SCALC=""!DONE  D
 ..S SCALCOD=SCALC
 ..S:SCALCOD[" " SCALCOD=+SCALCOD
 ..S TEXT1=TEXT1_SCALCOD_" ",I=I+1
 ..I I=3 S DONE=1
 I $L(TEXT1)>0 S TEXT1=$E(TEXT1,1,$L(TEXT1)-1)
 S YSDATA(N)="7771^9999;1^"_TEXT1
 Q
BRADJH ; Base Rate Adjustment Header
 N X,ACC,A,CC,TEXT1
 S TEXT1=""
 S X=YSRAWRSL("X Disclosure")
 S A=YBRS("A Generalized Anxiety","RSL")
 S CC=YBRS("CC Major Depression","RSL")
 I ((X>0)&(X<21))!((X>61)&(X<122)) S TEXT1="X"
 I (A>74)!(CC>74) S TEXT1=$S(TEXT1="":"A/CC",1:TEXT1_", A/CC")
 S:TEXT1="" TEXT1="None"
 S N=N+1,YSDATA(N)="7772^9999;1^"_TEXT1
 Q
INVDH ; Invalidity Header
 N TEXT1
 S TEXT1=$G(YSRAWRSL("V Invalidity"))
 S N=N+1,YSDATA(N)="7773^9999;1^"_TEXT1
 Q
INCNH ; Inconsistency Header
 N TEXT1
 S TEXT1=$G(YSRAWRSL("W Inconsistency"))
 S N=N+1,YSDATA(N)="7774^9999;1^"_TEXT1
 S YSRAWRSL("W Inconsistency")=0
 Q
CALCW ; Calculate the W Scale
 N PAIR
 S YSRAWRSL("W Inconsistency")=0
 F PAIR="22-170","125-143","47-157","40-181","81-116","85-126","76-150","25-94","44-121","39-59","17-184","33-89","78-164","38-171","74-115","46-154","26-99","20-174","32-122","13-112","55-110","173-194","95-127","60-162","15-149" D
 .D WADD(PAIR)
 S N=N+1,YSDATA(N)="7774^9999;1^"_YSRAWRSL("W Inconsistency")
 Q
WADD(PAIR) ;
 N Q1,Q2,ADD
 S Q1=$G(YSQANS($P(PAIR,"-"))) S:Q1=2 Q1=0    ;False is 0 instead of 2
 S Q2=$G(YSQANS($P(PAIR,"-",2))) S:Q2=2 Q2=0  ;False is 0 instead of 2
 S ADD=$TR((Q1-Q2),"-")  ;W ?30,ADD
 S YSRAWRSL("W Inconsistency")=YSRAWRSL("W Inconsistency")+ADD
 Q
ELEV ; Calculate the three highest Personality Scores from Base Rate
 ; Order of Importance after BR: S, C, P, 1, 2A, 2B, 3, 4A, 4B, 5, 6A, 6B, 7, 8A, 8B
 ; End result is HIARR("FINAL")
 N SCALSTR,SCAL,SCD,BR,TOPN,CNT,SCCOD,SCDF,SCALF,I,J
 F I=1157:1:1159,1145:1:1156 D
 .;S SCAL=^YTT(601.87,I,0)
 .S SCAL=$$GET1^DIQ(601.87,I_",",3,"I")
 .S BR=YBRS(SCAL,"RSL")
 .Q:BR<60
 .S HIARR("RSL",-BR,SCAL)=""
 S TOPN=3  ;Sample report has top 3 but documentation says 4?
 S CNT=0,BR="" F  S BR=$O(HIARR("RSL",BR)) Q:BR=""!(CNT>TOPN)  D
 .F I=1157:1:1159,1145:1:1156 D
 ..S SCAL=$$GET1^DIQ(601.87,I_",",3,"I")
 ..Q:CNT>TOPN
 ..S SCD=YSCOD("NAME",SCAL)
 ..Q:'$D(HIARR("RSL",BR,SCAL))
 ..S CNT=CNT+1,HIARR("FINAL",CNT)=SCAL_U_SCD
 S SCAL="" F  S SCAL=$O(YSCOD("NAME",SCAL)) Q:SCAL=""  S SCCOD(YSCOD("NAME",SCAL))=SCAL  ;Create SCCOD of Scale Codes=Scale Name
 F I=1:1:TOPN D
 .Q:'$D(HIARR("FINAL",I))
 .S SCAL=HIARR("FINAL",I),SCD=$P(SCAL,U,2),SCAL=$P(SCAL,U)
 .F J=1:1:3 D
 ..S SCDF=SCD_"."_J,SCALF=SCCOD(SCDF)
 ..S HIARR("FINAL",I,J)=SCALF_U_SCDF_U_YSRAWRSL(SCALF)_U_YBRS(SCALF,"RSL")_U_YPRS(SCALF,"RSL")
 I $G(LOGIT) M ^TMP("YKTL","HIARR")=HIARR
 Q
NOTEW ; Noteworthy Responses
 ; Use YSQANS(question number)=1/2 (True/False)
 ;     YSQANS(question number,"PTR")=pointer to MH QUESTION to get text if needed.
 ;     Note: Used CNT to index YSNOTE in case the order of display has to change.
 ; Sets array YSNOTE
 N CNT,CAT,QUESTR,QUES,CATTOT
 S CNT=1
 S CAT="Adult ADHD",CATTOT=0
 F QUES=56,77,82,92,108,-63 D SETNOT
 I CATTOT<4 K YSNOTE(CNT)  ;Must be at least four endorsed responses
 S CNT=CNT+1
 S CAT="Autism Spectrum",CATTOT=0
 F QUES=92,119,138,163,165,179,190 D SETNOT
 I CATTOT<4 K YSNOTE(CNT)
 S CNT=CNT+1
 S CAT="Childood Abuse"
 F QUES=47,157 D SETNOT
 S CNT=CNT+1
 S CAT="Eating Disorder"
 F QUES=69,86,102,186 D SETNOT
 S CNT=CNT+1
 S CAT="Emotional Dyscontrol"
 F QUES=27,36,45,56,72,80,127,177 D SETNOT
 S CNT=CNT+1
 S CAT="Explosively Angry"
 F QUES=11,74,115,145,168,191 D SETNOT
 S CNT=CNT+1
 S CAT="Health Preoccupied"
 F QUES=7,41,57,113,120,146 D SETNOT
 S CNT=CNT+1
 S CAT="Interpersonally Alienated"
 F QUES=4,104,182,190 D SETNOT
 S CNT=CNT+1
 S CAT="Prescription Drug Abuse"
 F QUES=124,176 D SETNOT
 S CNT=CNT+1
 S CAT="Self-Destructive Potential"
 F QUES=14,32,34,39,59,101,107,114,126,151,164 D SETNOT
 S CNT=CNT+1
 S CAT="Self-Injurious Behavior/Tendency"
 F QUES=40,181 D SETNOT
 S CNT=CNT+1
 S CAT="Traumatic Brain Injury"
 F QUES=55,110 D SETNOT
 S CNT=CNT+1
 S CAT="Vengefully Prone"
 F QUES=22,37,78,100,103,111,136,167,178,192 D SETNOT
 Q
SETNOT ;
 N CHK
 S CHK=1 ;True
 I QUES<0 S QUES=-QUES,CHK=2  ;Minus Ques# means check for a False response
 S ANS=YSQANS(QUES) Q:ANS'=CHK
 S:'$D(YSNOTE(CNT,"CAT")) YSNOTE(CNT,"CAT")=CAT
 S YSNOTE(CNT,"CAT",QUES)=YSQANS(QUES,"PTR")_U_ANS,CATTOT=CATTOT+1
 Q
MODIND ;
 N SCALSTR,SCAL,XSCAL,SCALCOD,ZTXT,STR,GRPH,I,ANS,RAW,BR
 S ANS=7775,STR="  "
 S SCALSTR="X Disclosure^Y Desirability^Z Debasement"
 D RPTBLK(ANS,SCALSTR)
 Q
CPP ;
 N SCALSTR,SCAL,XSCAL,SCALCOD,ZTXT,STR,GRPH,I,ANS,RAW,BR
 S ANS=7776,STR="  "
 S SCALSTR="1 Schizoid^2A Avoidant^2B Melancholic^3 Dependent^4A Histrionic^4B Turbulent^5 Narcissistic^6A Antisocial^6B Sadistic^7 Compulsive^8A Negativistic^8B Masochistic"
 D RPTBLK1(ANS,SCALSTR)
 Q
SPP ;
 N SCALSTR,SCAL,XSCAL,SCALCOD,ZTXT,STR,GRPH,I,ANS,RAW,BR
 S ANS=7777,STR="  "
 S SCALSTR="S Schizotypal^C Borderline^P Paranoid"
 D RPTBLK1(ANS,SCALSTR)
 Q
CS ;
 N SCALSTR,SCAL,XSCAL,SCALCOD,ZTXT,STR,GRPH,I,ANS,RAW,BR
 S ANS=7778,STR="  "
 S SCALSTR="A Generalized Anxiety^H Somatic Symptom^N Bipolar Spectrum^D Persistent Depression^B Alcohol Use^T Drug Use^R Post-Traumatic Stress"
 D RPTBLK1(ANS,SCALSTR)
 Q
SCS ;
 N SCALSTR,SCAL,XSCAL,SCALCOD,ZTXT,STR,GRPH,I,ANS,RAW,BR
 S ANS=7779,STR="  "
 S SCALSTR="SS Schizophrenic Spectrum^CC Major Depression^PP Delusional"
 D RPTBLK1(ANS,SCALSTR)
 Q
TOP3 ;
 N SCALSTR,SCAL,XSCAL,SCALCOD,ZTXT,STR,GRPH,I,ANS,RAW,BR,TCNT,TCNT2,HD
 S ANS=7780,STR="  "
 Q:'$D(HIARR)
 F TCNT=1:1:3 D
 .S HD=HIARR("FINAL",TCNT),SCAL=$P(HD,U),SCALCOD=$P(HD,U,2)
 .S ZTXT=$$MAKSTR(SCAL,39,"L"),STR=STR_ZTXT_"|"
 .;S ZTXT=$$MAKSTR(SCALCOD,4,"R"),STR=STR_ZTXT_"|"
 .S TCNT2="" F  S TCNT2=$O(HIARR("FINAL",TCNT,TCNT2)) Q:TCNT2=""  D
 ..S HD=HIARR("FINAL",TCNT,TCNT2),SCAL=$P(HD,U),SCALCOD=$P(HD,U,2)
 ..S RAW=$P(HD,U,3),BR=$P(HD,U,4),PR=$P(HD,U,5)
 ..S ZTXT=$$MAKSTR(SCAL,39,"L"),STR=STR_ZTXT
 ..;S ZTXT=$$MAKSTR(SCALCOD,4,"R"),STR=STR_ZTXT
 ..S ZTXT=$$MAKSTR(RAW,4,"R"),STR=STR_ZTXT
 ..S ZTXT=$$MAKSTR(PR,4,"R"),STR=STR_ZTXT
 ..S ZTXT=$$MAKSTR(BR,4,"R"),STR=STR_ZTXT
 ..S GRPH=$$MAKGRP(BR,100),STR=STR_"  "_GRPH_"|"
 .S STR=STR_"|"
 S N=N+1,YSDATA(N)=ANS_"^9999;1^"_STR
 Q
FACET ;
 N SCAL,SCALCOD,GSCAL,GCOD,ZTXT,STR,SCALXRF,I,II
 ;Make SCALXRF by Scale Code in order to get to the individual Grossman Facet Scale Names
 S SCAL="" F  S SCAL=$O(YSCOD("NAME",SCAL)) Q:SCAL=""  S SCALXRF(YSCOD("NAME",SCAL))=SCAL
 S ANS=7781,STR="  "
 F I=1145:1:1159 D
 .;S SCAL=^YTT(601.87,I,0)
 .S SCAL=$$GET1^DIQ(601.87,I_",",3,"I")
 .S SCALCOD=YSCOD("NAME",SCAL)
 .S ZTXT=$$MAKSTR(SCAL,39,"L"),STR=STR_ZTXT_"|"
 .;S ZTXT=$$MAKSTR(SCALCOD,4,"R"),STR=STR_ZTXT_"|"
 .F II=1:1:3 D
 ..S GCOD=SCALCOD_"."_II
 ..S GSCAL=SCALXRF(GCOD)
 ..S ZTXT=$$MAKSTR(GSCAL,39,"L"),STR=STR_ZTXT
 ..;S ZTXT=$$MAKSTR(GCOD,4,"R"),STR=STR_ZTXT
 ..S RAW=YSRAWRSL(GSCAL),PR=YPRS(GSCAL,"RSL"),BR=YBRS(GSCAL,"RSL")
 ..S ZTXT=$$MAKSTR(RAW,4,"R"),STR=STR_ZTXT
 ..S ZTXT=$$MAKSTR(PR,4,"R"),STR=STR_ZTXT
 ..S ZTXT=$$MAKSTR(BR,4,"R"),STR=STR_ZTXT_"|"
 .S STR=STR_"|"
 S N=N+1,YSDATA(N)=ANS_"^9999;1^"_STR
 Q
NTWRTHY ;
 N I,II,CAT,QUES,QPTR,QTXT,ZTXT,STR,QANS
 Q:'$D(YSNOTE)
 S ANS=7782
 S STR="  "
 S I=0 F  S I=$O(YSNOTE(I)) Q:I=""  D
 .S CAT=YSNOTE(I,"CAT")
 .S STR=STR_CAT_"|"
 .S QUES="" F  S QUES=$O(YSNOTE(I,"CAT",QUES)) Q:QUES=""  D
 ..S ZTXT=$$MAKSTR(QUES_". ",5,"R"),STR=STR_ZTXT
 ..S QPTR=$P(YSNOTE(I,"CAT",QUES),U),QANS=$P(YSNOTE(I,"CAT",QUES),U,2)
 ..S QANS=$S(QANS=1:"(True)",QANS=2:"(False)",1:"")
 ..S QTXT="",II=0 F  S II=$O(^YTT(601.72,QPTR,1,II)) Q:+II=0  D
 ... S QTXT=QTXT_^YTT(601.72,QPTR,1,II,0)  ;Space between lines?
 ..S STR=STR_QTXT_" "_QANS_"|"
 .S STR=STR_"|"
 S N=N+1,YSDATA(N)=ANS_"^9999;1^"_STR
 Q
RESP ;
 N I,STR,NUM,QUES,ANS
 S ANS=7784
 M ^TMP("YKTL","YSQANS")=YSQANS
 S STR="||ITEM RESPONSES |"
 I '$D(YSQANS) S STR=STR_"Could not create list of responses for the report|" S N=N+1,YSDATA(N)=ANS_"^9999;1^"_STR Q
 F I=1:1:195 D
 .S NUM=YSQANS(I) I NUM="" S NUM="X"
 .S STR=STR_$$MAKSTR(I_": ",5,"R")_NUM_"  "  I I#10=0 S STR=STR_"|"
 S N=N+1,YSDATA(N)=ANS_"^9999;1^"_STR
 Q
RPTBLK(ANS,SCALSTR) ;
 ;Report Block, no PR
 F I=1:1:$L(SCALSTR,U) D
 .S SCAL=$P(SCALSTR,U,I),SCALCOD=YSCOD("NAME",SCAL)
 .;S XSCAL=$E(SCAL,3,$L(SCAL))  ;Scale name does not include X,Y,Z
 .S ZTXT=$$MAKSTR(SCAL,43,"L"),STR=STR_ZTXT
 .;S ZTXT=$$MAKSTR(SCALCOD,4,"R"),STR=STR_ZTXT
 .S RAW=YSRAWRSL(SCAL),BR=YBRS(SCAL,"RSL")
 .S ZTXT=$$MAKSTR(RAW,4,"R"),STR=STR_ZTXT
 .S ZTXT=$$MAKSTR(BR,4,"R"),STR=STR_ZTXT
 .S GRPH=$$MAKGRP(BR,100),STR=STR_"  "_GRPH_"|"
 S N=N+1,YSDATA(N)=ANS_"^9999;1^"_STR
 Q
RPTBLK1(ANS,SCALSTR) ;
 ;Report Block with PR
 F I=1:1:$L(SCALSTR,U) D
 .S SCAL=$P(SCALSTR,U,I),SCALCOD=YSCOD("NAME",SCAL)
 .S ZTXT=$$MAKSTR(SCAL,39,"L"),STR=STR_ZTXT
 .;S ZTXT=$$MAKSTR(SCALCOD,4,"R"),STR=STR_ZTXT
 .S RAW=YSRAWRSL(SCAL),PR=YPRS(SCAL,"RSL"),BR=YBRS(SCAL,"RSL")
 .S ZTXT=$$MAKSTR(RAW,4,"R"),STR=STR_ZTXT
 .S ZTXT=$$MAKSTR(PR,4,"R"),STR=STR_ZTXT
 .S ZTXT=$$MAKSTR(BR,4,"R"),STR=STR_ZTXT
 .S GRPH=$$MAKGRP(BR,115),STR=STR_"  "_GRPH_"|"
 S N=N+1,YSDATA(N)=ANS_"^9999;1^"_STR
 Q
MAKSTR(TXT,LEN,JUST,CHAR) ;
 ; Make a string, return STR 
 ;   TXT  = Text to embed
 ;   LEN  = Total Length
 ;   JUST = R/L Justified, default is R
 ;   CHAR = Character PAD, default is " "
 N STR,TXTL
 S TXTL=$L(TXT),STR=""
 I TXT[" " S TXT=$TR(TXT," ",$C(0))  ;To pad correctly
 I $G(CHAR)="" S CHAR=" "
 I $G(JUST)="" S JUST="R"
 I JUST="L" D
 .S STR=TXT,$P(STR,CHAR,LEN-TXTL+1)=""
 I JUST="R" D
 .S $P(STR,CHAR,LEN-TXTL+1)="",STR=STR_TXT
 S:STR[$C(0) STR=$TR(STR,$C(0)," ")  ;XLAT out the $C(0)
 Q STR
MAKGRP(NUM,MAX) ;
 ; Make a string of "*" that represents the graph
 N GRP,LEN,RND,J,NCHAR
 S LEN=50  ;Length of graph in #of Chars. May have to adjust based on report format
 I NUM="-"!($G(YSNOGRPH)=1) D  Q GRP
 .S GRP=$$MAKSTR("",LEN,"L")
 S NCHAR=LEN/MAX*NUM,RND=$P(NCHAR,".",2),NCHAR=$P(NCHAR,".")
 I RND>.5 S NCHAR=NCHAR+1
 S $P(GRP,"*",NCHAR+1)="",GRP=$$MAKSTR(GRP,LEN,"L")
 Q GRP
YSARRAY(YSARRAY) ;
 N II,YSVAL,YSCALEI,YSCALEN,YSKEYI,G,YSQN,YSAI,YSAN,YSTARG
 K YSARRAY
 S II=1
 M ^TMP("YKTL","YSG")=^TMP($J,"YSG")
 F I=2:1 Q:'$D(^TMP($J,"YSG",I))  I ^TMP($J,"YSG",I)?1"Scale".E D
 . S YSCALEI=$P(^TMP($J,"YSG",I),U),YSCALEI=$P(YSCALEI,"=",2)
 . S YSCALEN=$P(^TMP($J,"YSG",I),U,4)
 . S YSKEYI=0 F  S YSKEYI=$O(^YTT(601.91,"AC",YSCALEI,YSKEYI)) Q:YSKEYI'>0  D
 ..S G=^YTT(601.91,YSKEYI,0)
 ..S YSQN=$P(G,U,3),YSTARG=$P(G,U,4),YSVAL=$P(G,U,5)
 ..S YSAI=$O(^YTT(601.85,"AC",YSAD,YSQN,0))
 ..Q:YSAI'>0
 ..Q:'$D(^YTT(601.85,YSAI,0))
 ..S YSAN=""
 ..I $D(^YTT(601.85,YSAI,1,1,0)) S YSAN=^YTT(601.85,YSAI,1,1,0)
 ..I $P(^YTT(601.85,YSAI,0),U,4)?1N.N S YSAN=$P(^YTT(601.85,YSAI,0),U,4),YSAN=$G(^YTT(601.75,YSAN,1))
 ..I YSAN=YSTARG S YSARRAY(II)=YSVAL,II=II+1
 ..S YSARRAY("SCALE",YSCALEN)=$G(YSARRAY("SCALE",YSCALEN))+YSVAL
 Q

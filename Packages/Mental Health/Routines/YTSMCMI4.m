YTSMCMI4 ;BAL/KTL - MHAX ANSWERS SPECIAL HANDLING #2 ; 9/14/18 3:19pm
 ;;5.01;MENTAL HEALTH;**151,187,202,217**;Dec 30, 1994;Build 12
 ;
 ; MCMI4
 ;
DLLSTR(YSDATA,YS,YSTRNG) ;
 ;  YSTRNG = 1 Score Instrument
 ;  YSTRNG = 2 get Report Answers and Text
 N YSCNT,YSIND,CNT,YSCOD,YSINVRPT,YSCALRSL,YSRAWRSL,YSQANS,YSQANS2,YSQSCAL,YSNOGRPH,HIARR,SCALOD
 N YBRS,YPRS   ;Calc Base Rate, Calc PR
 N YSNOTE      ;Noteworthy Responses Array
 N HIHIT,GRSHIT ;High 3 Personality Scale Hit and Grossman Facet >75 Hit
 S N=N+1
 D INICOD^YTSMCMIB  ;array YSCOD(scalename)=scalecode
 D INIBRS^YTSMCMIC  ;init YBRS(scalecode,"STR") -get possible Base Rate for each scale Raw
 D INIPRS^YTSMCMID  ;init YPRS(scalecode,"STR") -get possible Percentile for scale Raw (Facet)/Adj Base Rate (Non-Facet)
 D YSQ^YTSMCMIB     ;init YSQSCAL(scalcode)=questions.  Needed to chck if any scales are invalid.
 D DATA1
 I YSTRNG=1 Q
 ; Generate Report Sections
 D MODIND   ;Mod Indices
 D CPP      ;Clin Personality Patterns
 D SPP      ;Sevr Personality Path
 D CS       ;Clinical Syndromes
 D SCS      ;Sevr Clinical Syndromes
 D TOP3     ;3 Highest Grossman Scales
 D FACET    ;All Facet Scales
 D RSLWRN   ;Rsl Warning
 D NTWRTHY
 D RESP     ;Set up Responses
 Q
DATA1 ;Extract results&calc
 ;I YSTRNG=1, add up RAW values for scaleN calc adj BR and PR
 ;I YSTRNG=2, extract from saved values, Do rPT calcs
 I YSTRNG=1 D  Q
 .D EXTANS  ;Extract the T/F responses
 .D ^YTSMCMIA
 D LDSCORES^YTSCORE(.YSDATA,.YS)
 ;Extract Raw Scale Rsl;Get the High Point;Get the BR Adj Header;Get V rsl for Invalidity;Get W rsl for Inconsistency
 D EXTRSL,EXTANS,HIGHPT,BRADJH,INVDH,INCNH
 S YSINVRPT=$$INVRPT()  ; See if INVALID Report conditions
 I YSINVRPT'="" D INVALID(YSINVRPT)
 D INVSCL  ;Any Scale invalid
 D ELEV    ;Top 3 Grossman Face
 D NOTEW   ;Noteworthy Responses
 Q
INVRPT() ;
 ; Check for Invalid Report conditions
 ; Raw V > 1  ;Invalidity Index elevated
 ; Raw X > 114 ! Raw X < 7  ;Scale X outside acceptable range
 ; All Scales 1-8B Base Rate < 60  ; All scales too low
 ; Raw W > 19  ;Inconsistency Index elevated
 ; More than 13 responses skipped for X
 ; INVRPT of 1 = YES, INVALID
 ;           0 = NO, OK TO PROCEED
 N INVSTR,SCALSTR,SCAL,CHK,XQUES,QUES,I,SKIPS
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
 ; Check if X scale>13 omits
 S XQUES=YSQSCAL("X Disclosure")
 S CHK=0
 F I=1:1:$L(XQUES,U) D
 . S QUES=$P(XQUES,U,I) I YSQANS(QUES)="X" S CHK=CHK+1
 I CHK>13 S INVSTR="Scale X omits greater than 13" Q INVSTR
 ; Check all scale>13 omits
 S CHK=0,SCAL=""
 F  S SCAL=$O(YSQSCAL(SCAL)) Q:SCAL=""  D
 . S XQUES=YSQSCAL(SCAL)
 . F I=1:1:$L(XQUES,U) D
 .. S QUES=$P(XQUES,U,I) Q:QUES=""  Q:YSQANS(QUES)'="X"
 .. Q:$D(SKIPS(QUES))  ;already counted from another scale
 .. S CHK=CHK+1,SKIPS(QUES)=""
 I CHK>13 S INVSTR="Invalid responses greater than 13" Q INVSTR
 Q ""
INVALID(INVSTR) ;
 ; Text for invalid report
 N I,DONE
 S DONE=""
 S I="" F  S I=$O(YSDATA(I)) Q:I=""!(DONE=1)  D
 .I YSDATA(I)["7771" S $P(YSDATA(I),U,3)="",DONE=1  ;If INVALID, do not display HP Code
 S N=N+1,YSDATA(N)="7783^9999;1^INVALID PROFILE: "_INVSTR_"|"
 S YSNOGRPH=1  ;Don't Graph BR Scores
 Q
INVSCL ;
 ;Any scale>2 or 4 omits
 N OMITS,SCALSTR,SCAL,QUES,RSL,CNT,I,II
 F I=1140:1:1143,1145:1:1169,1240:1:1284 D
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
 ;Extract the T/F from YSDATA array
 ;TRUE=1 FALSE=2
 N X,QUEST,ANS,STR,PTR,DATA
 S X=2
 F  S X=$O(YSDATA(X)) Q:+X=0  D
 .S DATA=YSDATA(X)
 .S ANS=$$GET1^DIQ(601.75,$P($G(DATA),U,3)_",",4,"I")
 .S QUES=$P(DATA,U,2),PTR=$P(DATA,U)
 .S YSQANS(QUES)=ANS
 .S YSQANS(QUES,"PTR")=PTR
 .S YSQANS2(PTR)=ANS
 Q
EXTRSL ;
 ; Extract the Raw score-store by Scale Name
 N I,SCAL,VAL,BR,PR,RAW,YSAD,YSCALE,G,SCLNAM
 S I=1 F  S I=$O(^TMP($J,"YSCOR",I)) Q:I=""  D
 .S VAL=^TMP($J,"YSCOR",I),SCAL=$P(VAL,"="),VAL=$P(VAL,"=",2)
 .S RAW=$P(VAL,U),YSRAWRSL(SCAL)=RAW
 .S BR=$P(VAL,U,2),BR=$$BRFIX^YTSMCMIA(BR),YBRS(SCAL,"RSL")=BR  ;PATCH X
 .S PR=$P(VAL,U,3),YPRS(SCAL,"RSL")=PR
 .S SCLNAM(SCAL)=I  ;^TMP($J,"YSCOR") by scalename to extract calculated results below
 D EX2
 Q
EX2 ;T-SCORE NOT IN ^TMP($J,"YSCOR") 
 S YSAD=$G(YS("AD"))
 S YSCALE=""
 F  S YSCALE=$O(^YTT(601.92,"AC",YSAD,YSCALE))  Q:'YSCALE  D
 .S G=$G(^YTT(601.92,YSCALE,0))
 .S SCAL=$P(G,U,3)
 .S RAW=$P(G,U,4),BR=$P(G,U,5),BR=$$BRFIX^YTSMCMIA(BR),PR=$P(G,U,6)  ;PATCH X
 .S YBRS(SCAL,"RSL")=BR
 .S YPRS(SCAL,"RSL")=PR
 Q
HIGHPT ; Highpoint Header
 S N=N+1
 N TEXT1,SCAL,SCALC,SCALSTR,SCALCOD,I,HI,DONE,SCALR
 S TEXT1=""
 S SCALCOD="1 ^2A^2B^3 ^4A^4B^5 ^6A^6B^7 ^8A^8B"
 F I=1145:1:1156 D
 .S SCAL=$$GET1^DIQ(601.87,I_",",3,"I")
 .S SCALR=$G(YBRS(SCAL,"RSL"))
 .Q:SCALR'>59
 .S SCALC=YSCOD("NAME",SCAL) S:$L(SCALC)=1 SCALC=SCALC_" "  ;Sort numbers vs strings correctly
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
BRADJH ; BR Adjustment Header
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
 S Q1=$G(YSQANS($P(PAIR,"-"))) S:Q1=2 Q1=0    ;False=0 instead of 2
 S Q2=$G(YSQANS($P(PAIR,"-",2))) S:Q2=2 Q2=0  ;
 S ADD=$TR((Q1-Q2),"-")  ;W ?30,ADD
 S YSRAWRSL("W Inconsistency")=YSRAWRSL("W Inconsistency")+ADD
 Q
ELEV ; Calc three highest Personality Scores from BR
 ; Order of Importance after BR: S,C,P,1,2A,2B,3,4A,4B,5,6A,6B,7,8A,8B
 ; Result is HIARR("FINAL")
 N SCALSTR,SCAL,SCD,BR,TOPN,CNT,SCCOD,SCDF,SCALF,I,J
 F I=1157:1:1159,1145:1:1156 D
 .S SCAL=$$GET1^DIQ(601.87,I_",",3,"I")
 .S BR=YBRS(SCAL,"RSL")
 .Q:BR<60
 .S HIARR("RSL",-BR,SCAL)=""
 S TOPN=3
 S CNT=0,BR="" F  S BR=$O(HIARR("RSL",BR)) Q:BR=""!(CNT>TOPN)  D
 .F I=1157:1:1159,1145:1:1156 D
 ..S SCAL=$$GET1^DIQ(601.87,I_",",3,"I")
 ..Q:CNT>TOPN
 ..S SCD=YSCOD("NAME",SCAL)
 ..Q:'$D(HIARR("RSL",BR,SCAL))
 ..S CNT=CNT+1,HIARR("FINAL",CNT)=SCAL_U_SCD
 S SCAL="" F  S SCAL=$O(YSCOD("NAME",SCAL)) Q:SCAL=""  S SCCOD(YSCOD("NAME",SCAL))=SCAL  ;SCCOD of Scale Codes=Scale Name
 F I=1:1:TOPN D
 .Q:'$D(HIARR("FINAL",I))
 .S SCAL=HIARR("FINAL",I),SCD=$P(SCAL,U,2),SCAL=$P(SCAL,U)
 .F J=1:1:3 D
 ..S SCDF=SCD_"."_J,SCALF=SCCOD(SCDF)
 ..S HIARR("FINAL",I,J)=SCALF_U_SCDF_U_YSRAWRSL(SCALF)_U_YBRS(SCALF,"RSL")_U_YPRS(SCALF,"RSL")
 Q
NOTEW ; Noteworthy Responses
 ; Use YSQANS(question number)=1/2 (True/False)
 ;     YSQANS(question number,"PTR")=pointer to MH QUESTION
 N CNT,CAT,QUESTR,QUES,CATTOT
 S CNT=1
 S CAT="Adult ADHD",CATTOT=0
 F QUES=56,77,82,92,108,-63 D SETNOT
 I CATTOT<4 K YSNOTE(CNT)  ;Must be>=4 endorsed responses
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
 I QUES<0 S QUES=-QUES,CHK=2  ;Minus Ques#-check for a False
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
 S ANS=7780,STR="  ",HIHIT=0
 Q:'$D(HIARR)
 F TCNT=1:1:3 D
 .Q:'$D(HIARR("FINAL",TCNT))
 .S HD=HIARR("FINAL",TCNT),SCAL=$P(HD,U),SCALCOD=$P(HD,U,2),HIHIT=1
 .S ZTXT=$$MAKSTR(SCAL,39,"L"),STR=STR_ZTXT_"|"
 .S TCNT2="" F  S TCNT2=$O(HIARR("FINAL",TCNT,TCNT2)) Q:TCNT2=""  D
 ..S HD=HIARR("FINAL",TCNT,TCNT2),SCAL=$P(HD,U),SCALCOD=$P(HD,U,2)
 ..S RAW=$P(HD,U,3),BR=$P(HD,U,4),PR=$P(HD,U,5)
 ..S ZTXT=$$MAKSTR(SCAL,39,"L"),STR=STR_ZTXT
 ..S ZTXT=$$MAKSTR(RAW,4,"R"),STR=STR_ZTXT
 ..S ZTXT=$$MAKSTR(PR,4,"R"),STR=STR_ZTXT
 ..S ZTXT=$$MAKSTR(BR,4,"R"),STR=STR_ZTXT
 ..S GRPH=$$MAKGRP(BR,100),STR=STR_"  "_GRPH_"|"
 .S STR=STR_"|"
 S N=N+1,YSDATA(N)=ANS_"^9999;1^"_STR
 Q
FACET ;
 N SCAL,SCALCOD,GSCAL,GCOD,ZTXT,STR,SCALXRF,I,II
 ;Make SCALXRF by Scale Code to get to the each Grossman Facet Scale Names
 S SCAL="" F  S SCAL=$O(YSCOD("NAME",SCAL)) Q:SCAL=""  S SCALXRF(YSCOD("NAME",SCAL))=SCAL
 S ANS=7781,STR="  ",GRSHIT=0
 F I=1145:1:1159 D
 .S SCAL=$$GET1^DIQ(601.87,I_",",3,"I")
 .S SCALCOD=YSCOD("NAME",SCAL)
 .S ZTXT=$$MAKSTR(SCAL,39,"L"),STR=STR_ZTXT_"|"
 .F II=1:1:3 D
 ..S GCOD=SCALCOD_"."_II
 ..S GSCAL=SCALXRF(GCOD)
 ..S ZTXT=$$MAKSTR(GSCAL,39,"L"),STR=STR_ZTXT
 ..S RAW=YSRAWRSL(GSCAL),PR=YPRS(GSCAL,"RSL"),BR=YBRS(GSCAL,"RSL")
 ..I BR>74 S GRSHIT=1  ;At least one Grossman Facet >=75
 ..S ZTXT=$$MAKSTR(RAW,4,"R"),STR=STR_ZTXT
 ..S ZTXT=$$MAKSTR(PR,4,"R"),STR=STR_ZTXT
 ..S ZTXT=$$MAKSTR(BR,4,"R"),STR=STR_ZTXT_"|"
 .S STR=STR_"|"
 S N=N+1,YSDATA(N)=ANS_"^9999;1^"_STR
 Q
RSLWRN ; Result warning
 N STR
 ;S HIHIT=1,GRSHIT=0 ;TESTING
 Q:HIHIT=0   ;No Personality Scale >= 60
 Q:GRSHIT=1  ;At least one Grossman Facet >=75
 S STR="Generally, two conditions must be met in order for a Grossman Facet scale score |"
 S STR=STR_"to be considered interpretable. The first is that a primary personality scale |"
 S STR=STR_"must be at or above BR 60. The second is that one or more of its facet scales |"
 S STR=STR_"must be at or above BR 75. Since none of this patient's facet scale scores are|"
 S STR=STR_"at or above BR 75, no facet scale interpretations are included in this report.|"
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
 S STR="||ITEM RESPONSES |"
 I '$D(YSQANS) S STR=STR_"Could not create list of responses for the report|" S N=N+1,YSDATA(N)=ANS_"^9999;1^"_STR Q
 F I=1:1:195 D
 .S NUM=YSQANS(I) I NUM="" S NUM="X"
 .S STR=STR_$$MAKSTR(I_": ",5,"R")_NUM_"  "  I I#10=0 S STR=STR_"|"
 S N=N+1,YSDATA(N)=ANS_"^9999;1^"_STR
 Q
RPTBLK(ANS,SCALSTR) ;
 ;Report Block no PR
 F I=1:1:$L(SCALSTR,U) D
 .S SCAL=$P(SCALSTR,U,I),SCALCOD=YSCOD("NAME",SCAL)
 .S ZTXT=$$MAKSTR(SCAL,43,"L"),STR=STR_ZTXT
 .S RAW=YSRAWRSL(SCAL),BR=YBRS(SCAL,"RSL")
 .S ZTXT=$$MAKSTR(RAW,4,"R"),STR=STR_ZTXT
 .S ZTXT=$$MAKSTR(BR,4,"R"),STR=STR_ZTXT
 .S GRPH=$$MAKGRP(BR,100),STR=STR_"  "_GRPH_"|"
 S N=N+1,YSDATA(N)=ANS_"^9999;1^"_STR
 Q
RPTBLK1(ANS,SCALSTR) ;
 ;Report Block+PR
 F I=1:1:$L(SCALSTR,U) D
 .S SCAL=$P(SCALSTR,U,I),SCALCOD=YSCOD("NAME",SCAL)
 .S ZTXT=$$MAKSTR(SCAL,39,"L"),STR=STR_ZTXT
 .S RAW=YSRAWRSL(SCAL),PR=YPRS(SCAL,"RSL"),BR=YBRS(SCAL,"RSL")
 .S ZTXT=$$MAKSTR(RAW,4,"R"),STR=STR_ZTXT
 .S ZTXT=$$MAKSTR(PR,4,"R"),STR=STR_ZTXT
 .S ZTXT=$$MAKSTR(BR,4,"R"),STR=STR_ZTXT
 .S GRPH=$$MAKGRP(BR,115),STR=STR_"  "_GRPH_"|"
 S N=N+1,YSDATA(N)=ANS_"^9999;1^"_STR
 Q
MAKSTR(TXT,LEN,JUST,CHAR) ;
 ; Make a string, return STR 
 ;   TXT =Text
 ;   LEN =Total Len
 ;   JUST=R/L Justified, def=R
 ;   CHAR=Char PAD, def=" "
 N STR,TXTL
 S TXTL=$L(TXT),STR=""
 I TXT[" " S TXT=$TR(TXT," ",$C(0))
 I $G(CHAR)="" S CHAR=" "
 I $G(JUST)="" S JUST="R"
 I JUST="L" D
 .S STR=TXT,$P(STR,CHAR,LEN-TXTL+1)=""
 I JUST="R" D
 .S $P(STR,CHAR,LEN-TXTL+1)="",STR=STR_TXT
 S:STR[$C(0) STR=$TR(STR,$C(0)," ")  ;XLAT out $C(0)
 Q STR
MAKGRP(NUM,MAX) ;
 ; String of "*" for graph
 N GRP,LEN,RND,J,NCHAR
 S LEN=50  ;Graph #of Chars.
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

YTSNEOP2 ;SLC/PIJ - Score NEO-PI-3 ; 01/08/2016
 ;;5.01;MENTAL HEALTH;**123**;DEC 30,1994;Build 73
 ;
 ;Public, Supported ICRs
 ; #2056 - Fileman API - $$GET1^DIQ
 ;
 Q
 ;
PROGNOTE ;
 N ANS,TXT,TSCORE
 S RSLT=RSLT_""
 I (SKIP>40) D  Q  ; too many blanks, do not score
 .S RSLT=RSLT_"||Too many questions were not answered and no report is possible."
 .S RSLT=RSLT_"|The maximum allowed is 41; in this administration the number of skipped items was "_SKIP
 I (VR'="") D  Q  ; // Random responding, should not score
 .S RSLT=RSLT_"||There is a very strong indication that the respondent answered the "
 .S RSLT=RSLT_"|items in a random fashion. This is not a valid administration. |"
 .S RSLT=RSLT_VR
 I (VA=0)!(VA=1) D   ; // Question A (Validity 1)
 .S RSLT=RSLT_"||WARNING: The validity of the results is in question. "
 .S RSLT=RSLT_"|The respondent said they did not answer the questions honestly or accurately."
 .S RSLT=RSLT_"|The report provided below may be valid depending on why the respondent"
 .S RSLT=RSLT_"|answered Question A with Strongly disagree or Disagree."
 I (VB=1) D   ; // Question B (Validity 2)
 .S RSLT=RSLT_"||Validity concern:"
 .S RSLT=RSLT_"|The respondent said they did not answer all the questions."
 .S RSLT=RSLT_"|There are "_SKIP_" skipped questions. If there are"
 .S RSLT=RSLT_"|more than 41 unanswered questions, the report is not valid."
 I (VC=1) D   ; // Question C (Validity 3)
 .S RSLT=RSLT_"||Validity concern:"
 .S RSLT=RSLT_"|The respondent said they did not enter all their answers in the correct location."
 .S RSLT=RSLT_"|The report provided below may be valid depending on why the respondent"
 .S RSLT=RSLT_"|answered Question C with a No."
 I (THREE+FOUR)>150 D
 .S RSLT=RSLT_"||Validity concern, Acquiescence:"
 .S RSLT=RSLT_"|The respondent has agreed, or strong agreed, with more than 150 items."
 .S RSLT=RSLT_"|This is very unusual; 99% of volunteer respondents did not agree with more"
 .S RSLT=RSLT_"|than 150 items. Interpret these data with caution."
 I (THREE+FOUR)<=50 D
 .S RSLT=RSLT_"||Validity concern, Nay-Saying:"
 .S RSLT=RSLT_"|The respondent has agreed, or strong agreed, with less than 50 items."
 .S RSLT=RSLT_"|This is very unusual; 99% of volunteer respondents agreed with more"
 .S RSLT=RSLT_"|than 50 items. Interpret these data with caution."
 S RSLT=RSLT_"||                              RAW    T-Score    Range"
 S RSLT=RSLT_"| Domains"
 S RSLT=RSLT_"|| N:  Neuroticism    "_"                    "_$P(TSARR("Neuroticism"),U,2)_"      "_$$GETRTEXT^YTSNEOP1($P(TSARR("Neuroticism"),U,2))
 S RSLT=RSLT_"| E:  Extraversion   "_"                    "_$P(TSARR("Extraversion"),U,2)_"      "_$$GETRTEXT^YTSNEOP1($P(TSARR("Extraversion"),U,2))
 S RSLT=RSLT_"| O:  Openness       "_"                    "_$P(TSARR("Openness"),U,2)_"      "_$$GETRTEXT^YTSNEOP1($P(TSARR("Openness"),U,2))
 S RSLT=RSLT_"| A:  Agreeableness  "_"                    "_$P(TSARR("Agreeableness"),U,2)_"      "_$$GETRTEXT^YTSNEOP1($P(TSARR("Agreeableness"),U,2))
 S RSLT=RSLT_"| C:  Conscientiousness     "_"             "_$P(TSARR("Conscientiousness"),U,2)_"      "_$$GETRTEXT^YTSNEOP1($P(TSARR("Conscientiousness"),U,2))
 S RSLT=RSLT_"|| Neuroticism Facets"
 S ANS=$G(TSARR("N1")),TXT=$$GETRTEXT^YTSNEOP1($P(ANS,U,3))
 S RSLT=RSLT_"|| N1: Anxiety"_$J($P(ANS,U,2),20)_$J($P(ANS,U,3),10)_$J(TXT,(15+$L(TXT)-9))
 S ANS=$G(TSARR("N2")),TXT=$$GETRTEXT^YTSNEOP1($P(ANS,U,3))
 S RSLT=RSLT_"| N2: Angry Hostility"_$J($P(ANS,U,2),12)_$J($P(ANS,U,3),10)_$J(TXT,(15+$L(TXT)-9))
 S ANS=$G(TSARR("N3")),TXT=$$GETRTEXT^YTSNEOP1($P(ANS,U,3))
 S RSLT=RSLT_"| N3: Depression"_$J($P(ANS,U,2),17)_$J($P(ANS,U,3),10)_$J(TXT,(15+$L(TXT)-9))
 S ANS=$G(TSARR("N4")),TXT=$$GETRTEXT^YTSNEOP1($P(ANS,U,3))
 S RSLT=RSLT_"| N4: Self-Consciousness"_$J($P(ANS,U,2),9)_$J($P(ANS,U,3),10)_$J(TXT,(15+$L(TXT)-9))
 S ANS=$G(TSARR("N5")),TXT=$$GETRTEXT^YTSNEOP1($P(ANS,U,3))
 S RSLT=RSLT_"| N5: Impulsiveness"_$J($P(ANS,U,2),14)_$J($P(ANS,U,3),10)_$J(TXT,(15+$L(TXT)-9))
 S ANS=$G(TSARR("N6")),TXT=$$GETRTEXT^YTSNEOP1($P(ANS,U,3))
 S RSLT=RSLT_"| N6: Vulnerability"_$J($P(ANS,U,2),14)_$J($P(ANS,U,3),10)_$J(TXT,(15+$L(TXT)-9))
 S RSLT=RSLT_"|| Extraversion Facets"
 S ANS=$G(TSARR("E1")),TXT=$$GETRTEXT^YTSNEOP1($P(ANS,U,3))
 S RSLT=RSLT_"|| E1: Warmth"_$J($P(ANS,U,2),21)_$J($P(ANS,U,3),10)_$J(TXT,(15+$L(TXT)-9))
 S ANS=$G(TSARR("E2")),TXT=$$GETRTEXT^YTSNEOP1($P(ANS,U,3))
 S RSLT=RSLT_"| E2: Gregariousness"_$J($P(ANS,U,2),13)_$J($P(ANS,U,3),10)_$J(TXT,(15+$L(TXT)-9))
 S ANS=$G(TSARR("E3")),TXT=$$GETRTEXT^YTSNEOP1($P(ANS,U,3))
 S RSLT=RSLT_"| E3: Assertiveness"_$J($P(ANS,U,2),14)_$J($P(ANS,U,3),10)_$J(TXT,(15+$L(TXT)-9))
 S ANS=$G(TSARR("E4")),TXT=$$GETRTEXT^YTSNEOP1($P(ANS,U,3))
 S RSLT=RSLT_"| E4: Activity"_$J($P(ANS,U,2),19)_$J($P(ANS,U,3),10)_$J(TXT,(15+$L(TXT)-9))
 S ANS=$G(TSARR("E5")),TXT=$$GETRTEXT^YTSNEOP1($P(ANS,U,3))
 S RSLT=RSLT_"| E5: Excitement-Seeking"_$J($P(ANS,U,2),9)_$J($P(ANS,U,3),10)_$J(TXT,(15+$L(TXT)-9))
 S ANS=$G(TSARR("E6")),TXT=$$GETRTEXT^YTSNEOP1($P(ANS,U,3))
 S RSLT=RSLT_"| E6: Positive Emotions"_$J($P(ANS,U,2),10)_$J($P(ANS,U,3),10)_$J(TXT,(15+$L(TXT)-9))
 S RSLT=RSLT_"|| Openness Facets"
 S ANS=$G(TSARR("O1")),TXT=$$GETRTEXT^YTSNEOP1($P(ANS,U,3))
 S RSLT=RSLT_"|| O1: Fantasy"_$J($P(ANS,U,2),20)_$J($P(ANS,U,3),10)_$J(TXT,(15+$L(TXT)-9))
 S ANS=$G(TSARR("O2")),TXT=$$GETRTEXT^YTSNEOP1($P(ANS,U,3))
 S RSLT=RSLT_"| O2: Aesthetics"_$J($P(ANS,U,2),17)_$J($P(ANS,U,3),10)_$J(TXT,(15+$L(TXT)-9))
 S ANS=$G(TSARR("O3")),TXT=$$GETRTEXT^YTSNEOP1($P(ANS,U,3))
 S RSLT=RSLT_"| O3: Feelings"_$J($P(ANS,U,2),19)_$J($P(ANS,U,3),10)_$J(TXT,(15+$L(TXT)-9))
 S ANS=$G(TSARR("O4")),TXT=$$GETRTEXT^YTSNEOP1($P(ANS,U,3))
 S RSLT=RSLT_"| O4: Actions"_$J($P(ANS,U,2),20)_$J($P(ANS,U,3),10)_$J(TXT,(15+$L(TXT)-9))
 S ANS=$G(TSARR("O5")),TXT=$$GETRTEXT^YTSNEOP1($P(ANS,U,3))
 S RSLT=RSLT_"| O5: Ideas"_$J($P(ANS,U,2),22)_$J($P(ANS,U,3),10)_$J(TXT,(15+$L(TXT)-9))
 S ANS=$G(TSARR("O6")),TXT=$$GETRTEXT^YTSNEOP1($P(ANS,U,3))
 S RSLT=RSLT_"| O6: Values"_$J($P(ANS,U,2),21)_$J($P(ANS,U,3),10)_$J(TXT,(15+$L(TXT)-9))
 S RSLT=RSLT_"|| Agreeableness Facets"
 S ANS=$G(TSARR("A1")),TXT=$$GETRTEXT^YTSNEOP1($P(ANS,U,3))
 S RSLT=RSLT_"|| A1: Trust"_$J($P(ANS,U,2),22)_$J($P(ANS,U,3),10)_$J(TXT,(15+$L(TXT)-9))
 S ANS=$G(TSARR("A2")),TXT=$$GETRTEXT^YTSNEOP1($P(ANS,U,3))
 S RSLT=RSLT_"| A2: Straightforwardness"_$J($P(ANS,U,2),8)_$J($P(ANS,U,3),10)_$J(TXT,(15+$L(TXT)-9))
 S ANS=$G(TSARR("A3")),TXT=$$GETRTEXT^YTSNEOP1($P(ANS,U,3))
 S RSLT=RSLT_"| A3: Altruism"_$J($P(ANS,U,2),19)_$J($P(ANS,U,3),10)_$J(TXT,(15+$L(TXT)-9))
 S ANS=$G(TSARR("A4")),TXT=$$GETRTEXT^YTSNEOP1($P(ANS,U,3))
 S RSLT=RSLT_"| A4: Compliance"_$J($P(ANS,U,2),17)_$J($P(ANS,U,3),10)_$J(TXT,(15+$L(TXT)-9))
 S ANS=$G(TSARR("A5")),TXT=$$GETRTEXT^YTSNEOP1($P(ANS,U,3))
 S RSLT=RSLT_"| A5: Modesty"_$J($P(ANS,U,2),20)_$J($P(ANS,U,3),10)_$J(TXT,(15+$L(TXT)-9))
 S ANS=$G(TSARR("A6")),TXT=$$GETRTEXT^YTSNEOP1($P(ANS,U,3))
 S RSLT=RSLT_"| A6: Tender-Mindedness"_$J($P(ANS,U,2),10)_$J($P(ANS,U,3),10)_$J(TXT,(15+$L(TXT)-9))
 S RSLT=RSLT_"|| Conscientiousness Facets"
 S ANS=$G(TSARR("C1")),TXT=$$GETRTEXT^YTSNEOP1($P(ANS,U,3))
 S RSLT=RSLT_"|| C1: Competence"_$J($P(ANS,U,2),17)_$J($P(ANS,U,3),10)_$J(TXT,(15+$L(TXT)-9))
 S ANS=$G(TSARR("C2")),TXT=$$GETRTEXT^YTSNEOP1($P(ANS,U,3))
 S RSLT=RSLT_"| C2: Order"_$J($P(ANS,U,2),22)_$J($P(ANS,U,3),10)_$J(TXT,(15+$L(TXT)-9))
 S ANS=$G(TSARR("C3")),TXT=$$GETRTEXT^YTSNEOP1($P(ANS,U,3))
 S RSLT=RSLT_"| C3: Dutifulness"_$J($P(ANS,U,2),16)_$J($P(ANS,U,3),10)_$J(TXT,(15+$L(TXT)-9))
 S ANS=$G(TSARR("C4")),TXT=$$GETRTEXT^YTSNEOP1($P(ANS,U,3))
 S RSLT=RSLT_"| C4: Achievement Striving"_$J($P(ANS,U,2),7)_$J($P(ANS,U,3),10)_$J(TXT,(15+$L(TXT)-9))
 S ANS=$G(TSARR("C5")),TXT=$$GETRTEXT^YTSNEOP1($P(ANS,U,3))
 S RSLT=RSLT_"| C5: Self-Discipline"_$J($P(ANS,U,2),12)_$J($P(ANS,U,3),10)_$J(TXT,(15+$L(TXT)-9))
 S ANS=$G(TSARR("C6")),TXT=$$GETRTEXT^YTSNEOP1($P(ANS,U,3))
 S RSLT=RSLT_"| C6: Deliberation"_$J($P(ANS,U,2),15)_$J($P(ANS,U,3),10)_$J(TXT,(15+$L(TXT)-9))
 S RSLT=RSLT_"|| Summary of Responses"
 S RSLT=RSLT_"||   SD: "_$J(100*(ZERO/240),0,2)
 S RSLT=RSLT_"%   D: "_$J(100*(ONE/240),0,2)
 S RSLT=RSLT_"%   N: "_$J(100*(TWO/240),0,2)
 S RSLT=RSLT_"%   A: "_$J(100*(THREE/240),0,2)
 S RSLT=RSLT_"%   SA: "_$J(100*(FOUR/240),0,2)
 S RSLT=RSLT_"%   Skip: "_SKIP
 ;
 D SUMTXT^YTSNEOP3
 Q

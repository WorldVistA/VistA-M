YTSNEOP3 ;SLC/PIJ - Score NEO-PI-3 ; 01/08/2016
 ;;5.01;MENTAL HEALTH;**123**;DEC 30,1994;Build 73
 ;
 ;Public, Supported ICRs
 ; #2056 - Fileman API - $$GET1^DIQ
 ;
 Q
 ;
PROCANS(SCALE,ANSWER,REGREV) ;
 N ANS
 S ANS=""
 S ANS=ANSWER
 I ANSWER="-1" D  ; // score a blank as neutral
 .S ANS=2
 .S V0=0
 .S V1=0
 .S V2=0
 .S V3=0
 .S V4=0
 I ANSWER="0" D   ; // Stronly Disagree
 .S ZERO=ZERO+1
 .S V0=V0+1
 .S V1=0
 .S V2=0
 .S V3=0
 .S V4=0
 I ANSWER="1" D   ; // Disagree
 .S ONE=ONE+1
 .S V0=0
 .S V1=V1+1
 .S V2=0
 .S V3=0
 .S V4=0
 I ANSWER="2" D  ; // Neutral
 .S TWO=TWO+1
 .S V0=0
 .S V1=0
 .S V2=V2+1
 .S V3=0
 .S V4=0
 I ANSWER="3" D  ;  // Agree
 .S THREE=THREE+1
 .S V0=0
 .S V1=0
 .S V2=0
 .S V3=V3+1
 .S V4=0
 I ANSWER="4" D  ;  // Strongly Agree
 .S FOUR=FOUR+1
 .S V0=0
 .S V1=0
 .S V2=0
 .S V3=0
 .S V4=V4+1
 ;
 I YSTRNG=1 D
 .I REGREV="REVERSE" D
 ..S @SCALE=@SCALE+4-ANS
 .I REGREV'="REVERSE" D
 ..S @SCALE=@SCALE+ANS
 ;  
 I (V0=7) D
 .S VR=VR_"|Strongly disagree has been checked at least six times in a row. "
 I (V1=10) D
 .S VR=VR_"|Disagree has been checked at least nine times in a row. "
 I (V2=11) D
 .S VR=VR_"|Neutral has been checked at least ten times in a row. "
 I (V3=15) D
 .S VR=VR_"|Agree has been checked at least 14 times in a row. "
 I (V4=10) D
 .S VR=VR_"|Strongly agree has been checked at least nine times in a row. "
 Q
 ;
SCORDOM ;
 ; There are questions with rounding these Scales based on analysis in the publishers document.
 ; To match publisher results, add .2 to value, then truncate to first decimal piece.
 ;
 ; Calculations to score the Domain Scales
 I SKIP>40 S (N,E,O,A,C)="NA" Q
 D TSCORE
 S N=(.26*TS("N1"))+(.18*TS("N2"))+(.23*TS("N3"))+(.22*TS("N4"))+(.11*TS("N5"))+(.18*TS("N6"))+(.01*TS("E1"))-(.06*TS("E2"))-(.07*TS("E3"))+(.08*TS("E4"))
 S N=(N-(.02*TS("E5"))+(.02*TS("E6"))+(.02*TS("O1"))+(.09*TS("O2"))+(.16*TS("O3"))-(.06*TS("O4"))-(.02*TS("O5"))-(.06*TS("O6"))-(.09*TS("A1"))+(.05*TS("A2")))
 S N=(N+(.05*TS("A3"))-(.02*TS("A4"))+(.07*TS("A5"))+(.05*TS("A6"))-(.03*TS("C1"))+(.10*TS("C2"))+(.05*TS("C3"))+(.09*TS("C4"))+(.01*TS("C5"))+(.02*TS("C6")))-31.00
 S N=$P(N+.2,".")
 ;
 S E=(.02*TS("N1"))+(.00*TS("N2"))-(.02*TS("N3"))-(.04*TS("N4"))+(.16*TS("N5"))-(.01*TS("N6"))+(.21*TS("E1"))+(.24*TS("E2"))+(.10*TS("E3"))+(.15*TS("E4"))
 S E=E+(.21*TS("E5"))+(.24*TS("E6"))-(.01*TS("O1"))-(.12*TS("O2"))+(.07*TS("O3"))-(.01*TS("O4"))-(.14*TS("O5"))-(.05*TS("O6"))+(.05*TS("A1"))-(.05*TS("A2"))
 S E=E+(.19*TS("A3"))-(.03*TS("A4"))-(.01*TS("A5"))+(.08*TS("A6"))-(.01*TS("C1"))+(.01*TS("C2"))-(.07*TS("C3"))+(.01*TS("C4"))+(.02*TS("C5"))-(.14*TS("C6"))-2.50
 S E=$P(E+.2,".")
 ;
 S O=(.00*TS("N1"))+(.00*TS("N2"))+(.03*TS("N3"))+(.00*TS("N4"))-(.06*TS("N5"))-(.01*TS("N6"))-(.02*TS("E1"))-(.09*TS("E2"))+(.02*TS("E3"))-(.02*TS("E4"))-(.06*TS("E5"))
 S O=O-(.03*TS("E6"))+(.23*TS("O1"))+(.34*TS("O2"))+(.17*TS("O3"))+(.22*TS("O4"))+(.35*TS("O5"))+(.21*TS("O6"))+(.05*TS("A1"))+(.00*TS("A2"))-(.09*TS("A3"))+(.03*TS("A4"))
 S O=O-(.04*TS("A5"))+(.03*TS("A6"))+(.04*TS("C1"))-(.09*TS("C2"))+(.03*TS("C3"))+(.04*TS("C4"))-(.05*TS("C5"))+(.04*TS("C6"))-13.50
 S O=$P(O+.2,".")
 ;
 S A=(.03*TS("N1"))-(.12*TS("N2"))+(.03*TS("N3"))+(.05*TS("N4"))-(.04*TS("N5"))+(.05*TS("N6"))+(.12*TS("E1"))+(.02*TS("E2"))-(.12*TS("E3"))-(.09*TS("E4"))-(.11*TS("E5"))
 S A=A+(.03*TS("E6"))-(.01*TS("O1"))+(.08*TS("O2"))+(.02*TS("O3"))+(.02*TS("O4"))-(.02*TS("O5"))-(.01*TS("O6"))+(.16*TS("A1"))+(.20*TS("A2"))+(.16*TS("A3"))+(.23*TS("A4"))
 S A=A+(.19*TS("A5"))+(.20*TS("A6"))-(.02*TS("C1"))-(.03*TS("C2"))+(.06*TS("C3"))-(.06*TS("C4"))-(.02*TS("C5"))+(.04*TS("C6"))-2.00
 S A=$P(A+.2,".")
 ;
 S C=(.09*TS("N1"))+(.09*TS("N2"))+(.04*TS("N3"))+(.07*TS("N4"))-(.05*TS("N5"))-(.02*TS("N6"))-(.03*TS("E1"))-(.09*TS("E2"))+(.05*TS("E3"))+(.13*TS("E4"))-(.05*TS("E5"))
 S C=C-(.02*TS("E6"))-(.08*TS("O1"))+(.08*TS("O2"))+(.08*TS("O3"))-(.05*TS("O4"))+(.05*TS("O5"))-(.07*TS("O6"))-(.08*TS("A1"))+(.07*TS("A2"))+(.03*TS("A3"))-(.04*TS("A4"))
 S C=C-(.01*TS("A5"))-(.03*TS("A6"))+(.16*TS("C1"))+(.24*TS("C2"))+(.21*TS("C3"))+(.25*TS("C4"))+(.21*TS("C5"))+(.18*TS("C6"))-20.50
 S C=$P(C+.2,".")
 ;
 K TS
 Q
 ;
TSCORE  ; Create TS array  (TSCORE)
 N I
 K TS
 F I="N1"_U_N1,"N2"_U_N2,"N3"_U_N3,"N4"_U_N4,"N5"_U_N5,"N6"_U_N6,"E1"_U_E1,"E2"_U_E2,"E3"_U_E3,"E4"_U_E4,"E5"_U_E5,"E6"_U_E6 D
 .S TS($P(I,U,1))=$$GETTSCOR^YTSNEOP1($P(I,U,1),$P(I,U,2))
 ;
 F I="O1"_U_O1,"O2"_U_O2,"O3"_U_O3,"O4"_U_O4,"O5"_U_O5,"O6"_U_O6,"A1"_U_A1,"A2"_U_A2,"A3"_U_A3,"A4"_U_A4,"A5"_U_A5,"A6"_U_A6 D
 .S TS($P(I,U,1))=$$GETTSCOR^YTSNEOP1($P(I,U,1),$P(I,U,2))
 ;
 F I="C1"_U_C1,"C2"_U_C2,"C3"_U_C3,"C4"_U_C4,"C5"_U_C5,"C6"_U_C6 D
 .S TS($P(I,U,1))=$$GETTSCOR^YTSNEOP1($P(I,U,1),$P(I,U,2))
 ;
 Q
SUMTXT ;
 N X
 S RSLT=RSLT_"|| Your NEO Summary"
 S RSLT=RSLT_"||The NEO Inventory measures five broad domain, or dimensions, of personality."
 S RSLT=RSLT_"|Responses describing your thoughts, feelings, and goals can be compared with"
 S RSLT=RSLT_"|those describing others' to portray your personality."
 S RSLT=RSLT_"||This summary is intended to give you a general idea of what your personality"
 S RSLT=RSLT_"|is like. It is not a detailed report. If you completed the inventory again,"
 S RSLT=RSLT_"|or if someone else described you, you might score somewhat differently."
 S RSLT=RSLT_"||The NEO Inventory measures differences among people in general. It is not"
 S RSLT=RSLT_"|a test of intelligence or ability, and it is not intended to diagnose"
 S RSLT=RSLT_"|problems of mental health or adjustment. It does, however, give you some"
 S RSLT=RSLT_"|idea of what makes you unique in your ways of thinking, feeling and"
 S RSLT=RSLT_"|interacting with others."
 S RSLT=RSLT_"||Compared with the responses of other people, your responses suggest that you"
 S RSLT=RSLT_"|can be described as:"
 S X=$P(TSARR("Neuroticism"),U,2) ; Calculates the raw score
 I (X>55) D
 .S RSLT=RSLT_"||Sensitive, emotional, and prone to experience feelings that are upsetting."
 I (X>45),(X<=55) D
 .S RSLT=RSLT_"||Generally calm and able to deal with stress, but you sometimes experience"
 .S RSLT=RSLT_"|feelings of guilt, anger, or sadness."
 I (X<=45) D
 .S RSLT=RSLT_"||Secure, hardy, and generally relaxed, even under stressful conditions."
 ;
 S X=$P(TSARR("Extraversion"),U,2) ; Calculates the raw score
 I (X>55) D
 .S RSLT=RSLT_"||Extraverted, outgoing, active, and high-spirited. You prefer to be around "
 .S RSLT=RSLT_"|people most of the time."
 I (X>45),(X<=55) D
 .S RSLT=RSLT_"||Moderate in activity and enthusiasm. You enjoy the company of others,"
 .S RSLT=RSLT_"|but you also value privacy."
 I (X<=45) D
 .S RSLT=RSLT_"||Introverted, reserved, and serious. You prefer to be alone or with"
 .S RSLT=RSLT_"|a few close friends."
 ;
 S X=$P(TSARR("Openness"),U,2) ; Calculates the raw score
 I (X>55) D
 .S RSLT=RSLT_"||Open to new experiences. You have broad interests and are very imaginative."
 I (X>45),(X<=55) D
 .S RSLT=RSLT_"||Practical, but willing to consider new ways of doing things. You"
 .S RSLT=RSLT_"|seek a balance between the old and the new."
 I (X<=45) D
 .S RSLT=RSLT_"||Down-to-earth, practical, traditional, and pretty much set in your ways."
 ;
 S X=$P(TSARR("Agreeableness"),U,2) ; Calculates the raw score
 I (X>55) D
 .S RSLT=RSLT_"||Compassionate, good-natured, and eager to cooperate and avoid conflict."
 I (X>45),(X<=55) D
 .S RSLT=RSLT_"||Generally warm, trusting and agreeable, but you can sometimes"
 .S RSLT=RSLT_"|be stubborn and competitive."
 I (X<=45) D
 .S RSLT=RSLT_"||Hardheaded, skeptical, proud, and competitive. You tend to express your"
 .S RSLT=RSLT_"|anger directly."
 ;
 S X=$P(TSARR("Conscientiousness"),U,2) ; Calculates the raw score
 I (X>55) D
 .S RSLT=RSLT_"||Conscientious and well-organized. You have high standards and always"
 .S RSLT=RSLT_"|strive to achieve your goals."
 I (X>45),(X<=55) D
 .S RSLT=RSLT_"||Dependable and moderately well-organized. You generally have clear goals,"
 .S RSLT=RSLT_"|but are able to set your work aside."
 I (X<=45) D
 .S RSLT=RSLT_"||Easygoing, not very well-organized, and sometimes careless. You prefer not"
 .S RSLT=RSLT_"|to make plans."
 Q

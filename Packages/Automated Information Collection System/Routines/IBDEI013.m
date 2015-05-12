IBDEI013 ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1101,0)
 ;;=F25.0^^3^45^4
 ;;^UTILITY(U,$J,358.3,1101,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1101,1,3,0)
 ;;=3^Schizoaffective Disorder,Bipolar Type
 ;;^UTILITY(U,$J,358.3,1101,1,4,0)
 ;;=4^F25.0
 ;;^UTILITY(U,$J,358.3,1101,2)
 ;;=^5003480
 ;;^UTILITY(U,$J,358.3,1102,0)
 ;;=F25.1^^3^45^5
 ;;^UTILITY(U,$J,358.3,1102,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1102,1,3,0)
 ;;=3^Schizoaffective Disorder,Depressive Type
 ;;^UTILITY(U,$J,358.3,1102,1,4,0)
 ;;=4^F25.1
 ;;^UTILITY(U,$J,358.3,1102,2)
 ;;=^5003481
 ;;^UTILITY(U,$J,358.3,1103,0)
 ;;=F28.^^3^45^3
 ;;^UTILITY(U,$J,358.3,1103,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1103,1,3,0)
 ;;=3^Other Spec Schizophrenia Spectrum & Other Psychotic Disorder
 ;;^UTILITY(U,$J,358.3,1103,1,4,0)
 ;;=4^F28.
 ;;^UTILITY(U,$J,358.3,1103,2)
 ;;=^5003483
 ;;^UTILITY(U,$J,358.3,1104,0)
 ;;=F29.^^3^45^8
 ;;^UTILITY(U,$J,358.3,1104,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1104,1,3,0)
 ;;=3^Unspec Schizophrenia Spectrum & Other Psychotic Disorder
 ;;^UTILITY(U,$J,358.3,1104,1,4,0)
 ;;=4^F29.
 ;;^UTILITY(U,$J,358.3,1104,2)
 ;;=^5003484
 ;;^UTILITY(U,$J,358.3,1105,0)
 ;;=F52.32^^3^46^1
 ;;^UTILITY(U,$J,358.3,1105,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1105,1,3,0)
 ;;=3^Delayed Ejaculation
 ;;^UTILITY(U,$J,358.3,1105,1,4,0)
 ;;=4^F52.32
 ;;^UTILITY(U,$J,358.3,1105,2)
 ;;=^331927
 ;;^UTILITY(U,$J,358.3,1106,0)
 ;;=F52.21^^3^46^2
 ;;^UTILITY(U,$J,358.3,1106,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1106,1,3,0)
 ;;=3^Erectile Disorder
 ;;^UTILITY(U,$J,358.3,1106,1,4,0)
 ;;=4^F52.21
 ;;^UTILITY(U,$J,358.3,1106,2)
 ;;=^5003620
 ;;^UTILITY(U,$J,358.3,1107,0)
 ;;=F52.31^^3^46^3
 ;;^UTILITY(U,$J,358.3,1107,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1107,1,3,0)
 ;;=3^Female Orgasmic Disorder
 ;;^UTILITY(U,$J,358.3,1107,1,4,0)
 ;;=4^F52.31
 ;;^UTILITY(U,$J,358.3,1107,2)
 ;;=^331926
 ;;^UTILITY(U,$J,358.3,1108,0)
 ;;=F52.22^^3^46^4
 ;;^UTILITY(U,$J,358.3,1108,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1108,1,3,0)
 ;;=3^Female Sexual Interest/Arousal Disorder
 ;;^UTILITY(U,$J,358.3,1108,1,4,0)
 ;;=4^F52.22
 ;;^UTILITY(U,$J,358.3,1108,2)
 ;;=^5003621
 ;;^UTILITY(U,$J,358.3,1109,0)
 ;;=F52.6^^3^46^5
 ;;^UTILITY(U,$J,358.3,1109,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1109,1,3,0)
 ;;=3^Genito-Pelvic Pain/Penetration Disorder
 ;;^UTILITY(U,$J,358.3,1109,1,4,0)
 ;;=4^F52.6
 ;;^UTILITY(U,$J,358.3,1109,2)
 ;;=^5003623
 ;;^UTILITY(U,$J,358.3,1110,0)
 ;;=F52.0^^3^46^6
 ;;^UTILITY(U,$J,358.3,1110,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1110,1,3,0)
 ;;=3^Male Hypoactive Sexual Desire Disorder
 ;;^UTILITY(U,$J,358.3,1110,1,4,0)
 ;;=4^F52.0
 ;;^UTILITY(U,$J,358.3,1110,2)
 ;;=^5003618
 ;;^UTILITY(U,$J,358.3,1111,0)
 ;;=F52.4^^3^46^8
 ;;^UTILITY(U,$J,358.3,1111,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1111,1,3,0)
 ;;=3^Premature (Early) Ejaculation
 ;;^UTILITY(U,$J,358.3,1111,1,4,0)
 ;;=4^F52.4
 ;;^UTILITY(U,$J,358.3,1111,2)
 ;;=^331928
 ;;^UTILITY(U,$J,358.3,1112,0)
 ;;=F52.8^^3^46^7
 ;;^UTILITY(U,$J,358.3,1112,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1112,1,3,0)
 ;;=3^Other Spec Sexual Dysfunction
 ;;^UTILITY(U,$J,358.3,1112,1,4,0)
 ;;=4^F52.8
 ;;^UTILITY(U,$J,358.3,1112,2)
 ;;=^5003624
 ;;^UTILITY(U,$J,358.3,1113,0)
 ;;=F52.9^^3^46^9
 ;;^UTILITY(U,$J,358.3,1113,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1113,1,3,0)
 ;;=3^Unspec Sexual Dysfunction
 ;;^UTILITY(U,$J,358.3,1113,1,4,0)
 ;;=4^F52.9
 ;;^UTILITY(U,$J,358.3,1113,2)
 ;;=^5003625
 ;;^UTILITY(U,$J,358.3,1114,0)
 ;;=G47.09^^3^47^16
 ;;^UTILITY(U,$J,358.3,1114,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1114,1,3,0)
 ;;=3^Other Spec Insomnia Disorder
 ;;^UTILITY(U,$J,358.3,1114,1,4,0)
 ;;=4^G47.09
 ;;^UTILITY(U,$J,358.3,1114,2)
 ;;=^5003970
 ;;^UTILITY(U,$J,358.3,1115,0)
 ;;=G47.00^^3^47^9
 ;;^UTILITY(U,$J,358.3,1115,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1115,1,3,0)
 ;;=3^Insomnia Disorder
 ;;^UTILITY(U,$J,358.3,1115,1,4,0)
 ;;=4^G47.00
 ;;^UTILITY(U,$J,358.3,1115,2)
 ;;=^332924
 ;;^UTILITY(U,$J,358.3,1116,0)
 ;;=G47.10^^3^47^8
 ;;^UTILITY(U,$J,358.3,1116,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1116,1,3,0)
 ;;=3^Hypersomnolence Disorder/Unspec Hypersomnolence Disorder
 ;;^UTILITY(U,$J,358.3,1116,1,4,0)
 ;;=4^G47.10
 ;;^UTILITY(U,$J,358.3,1116,2)
 ;;=^332926
 ;;^UTILITY(U,$J,358.3,1117,0)
 ;;=G47.419^^3^47^10
 ;;^UTILITY(U,$J,358.3,1117,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1117,1,3,0)
 ;;=3^Narcolepsy
 ;;^UTILITY(U,$J,358.3,1117,1,4,0)
 ;;=4^G47.419
 ;;^UTILITY(U,$J,358.3,1117,2)
 ;;=^5003982
 ;;^UTILITY(U,$J,358.3,1118,0)
 ;;=G47.33^^3^47^14
 ;;^UTILITY(U,$J,358.3,1118,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1118,1,3,0)
 ;;=3^Obstructive Sleep Apnea Hypopnea
 ;;^UTILITY(U,$J,358.3,1118,1,4,0)
 ;;=4^G47.33
 ;;^UTILITY(U,$J,358.3,1118,2)
 ;;=^332763
 ;;^UTILITY(U,$J,358.3,1119,0)
 ;;=G47.31^^3^47^1
 ;;^UTILITY(U,$J,358.3,1119,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1119,1,3,0)
 ;;=3^Central Sleep Apnea
 ;;^UTILITY(U,$J,358.3,1119,1,4,0)
 ;;=4^G47.31
 ;;^UTILITY(U,$J,358.3,1119,2)
 ;;=^332761
 ;;^UTILITY(U,$J,358.3,1120,0)
 ;;=G47.21^^3^47^3
 ;;^UTILITY(U,$J,358.3,1120,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1120,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Delayed Sleep Phase Type
 ;;^UTILITY(U,$J,358.3,1120,1,4,0)
 ;;=4^G47.21
 ;;^UTILITY(U,$J,358.3,1120,2)
 ;;=^332769
 ;;^UTILITY(U,$J,358.3,1121,0)
 ;;=G47.22^^3^47^2
 ;;^UTILITY(U,$J,358.3,1121,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1121,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Advanced Sleep Phase Type
 ;;^UTILITY(U,$J,358.3,1121,1,4,0)
 ;;=4^G47.22
 ;;^UTILITY(U,$J,358.3,1121,2)
 ;;=^332770
 ;;^UTILITY(U,$J,358.3,1122,0)
 ;;=G47.23^^3^47^4
 ;;^UTILITY(U,$J,358.3,1122,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1122,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Irregular Sleep Wake Type
 ;;^UTILITY(U,$J,358.3,1122,1,4,0)
 ;;=4^G47.23
 ;;^UTILITY(U,$J,358.3,1122,2)
 ;;=^5003975
 ;;^UTILITY(U,$J,358.3,1123,0)
 ;;=G47.24^^3^47^5
 ;;^UTILITY(U,$J,358.3,1123,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1123,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Non-24 Hr Sleep Wake Type
 ;;^UTILITY(U,$J,358.3,1123,1,4,0)
 ;;=4^G47.24
 ;;^UTILITY(U,$J,358.3,1123,2)
 ;;=^5003976
 ;;^UTILITY(U,$J,358.3,1124,0)
 ;;=G47.26^^3^47^6
 ;;^UTILITY(U,$J,358.3,1124,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1124,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Shift Work Type
 ;;^UTILITY(U,$J,358.3,1124,1,4,0)
 ;;=4^G47.26
 ;;^UTILITY(U,$J,358.3,1124,2)
 ;;=^332774
 ;;^UTILITY(U,$J,358.3,1125,0)
 ;;=G47.20^^3^47^7
 ;;^UTILITY(U,$J,358.3,1125,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1125,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Unspec Type
 ;;^UTILITY(U,$J,358.3,1125,1,4,0)
 ;;=4^G47.20
 ;;^UTILITY(U,$J,358.3,1125,2)
 ;;=^5003974
 ;;^UTILITY(U,$J,358.3,1126,0)
 ;;=F51.3^^3^47^12
 ;;^UTILITY(U,$J,358.3,1126,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1126,1,3,0)
 ;;=3^Non-Rapid Eye Movement Sleep Arousal Disorder;Sleepwalking Type
 ;;^UTILITY(U,$J,358.3,1126,1,4,0)
 ;;=4^F51.3
 ;;^UTILITY(U,$J,358.3,1126,2)
 ;;=^5003613
 ;;^UTILITY(U,$J,358.3,1127,0)
 ;;=F51.4^^3^47^13
 ;;^UTILITY(U,$J,358.3,1127,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1127,1,3,0)
 ;;=3^Non-Rapid Eye Movement Sleep Arousal Disorder;Sleep Terror Type
 ;;^UTILITY(U,$J,358.3,1127,1,4,0)
 ;;=4^F51.4
 ;;^UTILITY(U,$J,358.3,1127,2)
 ;;=^5003614
 ;;^UTILITY(U,$J,358.3,1128,0)
 ;;=F51.5^^3^47^11
 ;;^UTILITY(U,$J,358.3,1128,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1128,1,3,0)
 ;;=3^Nightmare Disorder
 ;;^UTILITY(U,$J,358.3,1128,1,4,0)
 ;;=4^F51.5
 ;;^UTILITY(U,$J,358.3,1128,2)
 ;;=^5003615
 ;;^UTILITY(U,$J,358.3,1129,0)
 ;;=G47.52^^3^47^18
 ;;^UTILITY(U,$J,358.3,1129,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1129,1,3,0)
 ;;=3^Rapid Eye Movement Sleep Behavior Disorder
 ;;^UTILITY(U,$J,358.3,1129,1,4,0)
 ;;=4^G47.52
 ;;^UTILITY(U,$J,358.3,1129,2)
 ;;=^332778
 ;;^UTILITY(U,$J,358.3,1130,0)
 ;;=G25.81^^3^47^19
 ;;^UTILITY(U,$J,358.3,1130,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1130,1,3,0)
 ;;=3^Restless Legs Syndrome
 ;;^UTILITY(U,$J,358.3,1130,1,4,0)
 ;;=4^G25.81
 ;;^UTILITY(U,$J,358.3,1130,2)
 ;;=^5003801
 ;;^UTILITY(U,$J,358.3,1131,0)
 ;;=G47.19^^3^47^15
 ;;^UTILITY(U,$J,358.3,1131,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1131,1,3,0)
 ;;=3^Other Spec Hypersomnolence Disorder
 ;;^UTILITY(U,$J,358.3,1131,1,4,0)
 ;;=4^G47.19
 ;;^UTILITY(U,$J,358.3,1131,2)
 ;;=^5003973
 ;;^UTILITY(U,$J,358.3,1132,0)
 ;;=G47.8^^3^47^17
 ;;^UTILITY(U,$J,358.3,1132,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1132,1,3,0)
 ;;=3^Other Spec Sleep-Wake Disorder
 ;;^UTILITY(U,$J,358.3,1132,1,4,0)
 ;;=4^G47.8
 ;;^UTILITY(U,$J,358.3,1132,2)
 ;;=^5003989
 ;;^UTILITY(U,$J,358.3,1133,0)
 ;;=F10.10^^3^48^1
 ;;^UTILITY(U,$J,358.3,1133,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1133,1,3,0)
 ;;=3^Alcohol Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,1133,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,1133,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,1134,0)
 ;;=F10.14^^3^48^8
 ;;^UTILITY(U,$J,358.3,1134,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1134,1,3,0)
 ;;=3^Alcohol-Induced Bipolar & Related Disorder/Depressive Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,1134,1,4,0)
 ;;=4^F10.14
 ;;^UTILITY(U,$J,358.3,1134,2)
 ;;=^5003072
 ;;^UTILITY(U,$J,358.3,1135,0)
 ;;=F10.182^^3^48^10
 ;;^UTILITY(U,$J,358.3,1135,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1135,1,3,0)
 ;;=3^Alcohol-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,1135,1,4,0)
 ;;=4^F10.182
 ;;^UTILITY(U,$J,358.3,1135,2)
 ;;=^5003078
 ;;^UTILITY(U,$J,358.3,1136,0)
 ;;=F10.20^^3^48^2
 ;;^UTILITY(U,$J,358.3,1136,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1136,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,1136,1,4,0)
 ;;=4^F10.20

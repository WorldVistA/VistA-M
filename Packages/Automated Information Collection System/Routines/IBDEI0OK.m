IBDEI0OK ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31151,0)
 ;;=Z62.29^^91^1353^8
 ;;^UTILITY(U,$J,358.3,31151,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31151,1,3,0)
 ;;=3^Upbringing Away from Parents
 ;;^UTILITY(U,$J,358.3,31151,1,4,0)
 ;;=4^Z62.29
 ;;^UTILITY(U,$J,358.3,31151,2)
 ;;=^5063150
 ;;^UTILITY(U,$J,358.3,31152,0)
 ;;=F20.9^^91^1354^11
 ;;^UTILITY(U,$J,358.3,31152,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31152,1,3,0)
 ;;=3^Schizophrenia
 ;;^UTILITY(U,$J,358.3,31152,1,4,0)
 ;;=4^F20.9
 ;;^UTILITY(U,$J,358.3,31152,2)
 ;;=^5003476
 ;;^UTILITY(U,$J,358.3,31153,0)
 ;;=F20.81^^91^1354^14
 ;;^UTILITY(U,$J,358.3,31153,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31153,1,3,0)
 ;;=3^Schizophreniform Disorder
 ;;^UTILITY(U,$J,358.3,31153,1,4,0)
 ;;=4^F20.81
 ;;^UTILITY(U,$J,358.3,31153,2)
 ;;=^5003474
 ;;^UTILITY(U,$J,358.3,31154,0)
 ;;=F22.^^91^1354^5
 ;;^UTILITY(U,$J,358.3,31154,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31154,1,3,0)
 ;;=3^Delusional Disorder
 ;;^UTILITY(U,$J,358.3,31154,1,4,0)
 ;;=4^F22.
 ;;^UTILITY(U,$J,358.3,31154,2)
 ;;=^5003478
 ;;^UTILITY(U,$J,358.3,31155,0)
 ;;=F23.^^91^1354^1
 ;;^UTILITY(U,$J,358.3,31155,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31155,1,3,0)
 ;;=3^Brief Psychotic Disorder
 ;;^UTILITY(U,$J,358.3,31155,1,4,0)
 ;;=4^F23.
 ;;^UTILITY(U,$J,358.3,31155,2)
 ;;=^5003479
 ;;^UTILITY(U,$J,358.3,31156,0)
 ;;=F25.0^^91^1354^9
 ;;^UTILITY(U,$J,358.3,31156,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31156,1,3,0)
 ;;=3^Schizoaffective Disorder,Bipolar Type
 ;;^UTILITY(U,$J,358.3,31156,1,4,0)
 ;;=4^F25.0
 ;;^UTILITY(U,$J,358.3,31156,2)
 ;;=^5003480
 ;;^UTILITY(U,$J,358.3,31157,0)
 ;;=F25.1^^91^1354^10
 ;;^UTILITY(U,$J,358.3,31157,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31157,1,3,0)
 ;;=3^Schizoaffective Disorder,Depressive Type
 ;;^UTILITY(U,$J,358.3,31157,1,4,0)
 ;;=4^F25.1
 ;;^UTILITY(U,$J,358.3,31157,2)
 ;;=^5003481
 ;;^UTILITY(U,$J,358.3,31158,0)
 ;;=F28.^^91^1354^12
 ;;^UTILITY(U,$J,358.3,31158,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31158,1,3,0)
 ;;=3^Schizophrenia Spectrum & Psychotic Disorder,Oth Specified
 ;;^UTILITY(U,$J,358.3,31158,1,4,0)
 ;;=4^F28.
 ;;^UTILITY(U,$J,358.3,31158,2)
 ;;=^5003483
 ;;^UTILITY(U,$J,358.3,31159,0)
 ;;=F29.^^91^1354^13
 ;;^UTILITY(U,$J,358.3,31159,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31159,1,3,0)
 ;;=3^Schizophrenia Spectrum & Psychotic Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,31159,1,4,0)
 ;;=4^F29.
 ;;^UTILITY(U,$J,358.3,31159,2)
 ;;=^5003484
 ;;^UTILITY(U,$J,358.3,31160,0)
 ;;=F06.1^^91^1354^2
 ;;^UTILITY(U,$J,358.3,31160,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31160,1,3,0)
 ;;=3^Catatonia Associated w/ Another Mental Disorder
 ;;^UTILITY(U,$J,358.3,31160,1,4,0)
 ;;=4^F06.1
 ;;^UTILITY(U,$J,358.3,31160,2)
 ;;=^5003054
 ;;^UTILITY(U,$J,358.3,31161,0)
 ;;=F06.1^^91^1354^4
 ;;^UTILITY(U,$J,358.3,31161,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31161,1,3,0)
 ;;=3^Catatonic Disorder d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,31161,1,4,0)
 ;;=4^F06.1
 ;;^UTILITY(U,$J,358.3,31161,2)
 ;;=^5003054
 ;;^UTILITY(U,$J,358.3,31162,0)
 ;;=F06.1^^91^1354^3
 ;;^UTILITY(U,$J,358.3,31162,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31162,1,3,0)
 ;;=3^Catatonia,Unspec
 ;;^UTILITY(U,$J,358.3,31162,1,4,0)
 ;;=4^F06.1
 ;;^UTILITY(U,$J,358.3,31162,2)
 ;;=^5003054
 ;;^UTILITY(U,$J,358.3,31163,0)
 ;;=R29.818^^91^1354^6
 ;;^UTILITY(U,$J,358.3,31163,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31163,1,3,0)
 ;;=3^Nervous & Musculoskeletal System Symptoms,Other
 ;;^UTILITY(U,$J,358.3,31163,1,4,0)
 ;;=4^R29.818
 ;;^UTILITY(U,$J,358.3,31163,2)
 ;;=^5019318
 ;;^UTILITY(U,$J,358.3,31164,0)
 ;;=F06.2^^91^1354^7
 ;;^UTILITY(U,$J,358.3,31164,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31164,1,3,0)
 ;;=3^Psychotic Disorder d/t Another Med Cond w/ Delusions
 ;;^UTILITY(U,$J,358.3,31164,1,4,0)
 ;;=4^F06.2
 ;;^UTILITY(U,$J,358.3,31164,2)
 ;;=^5003055
 ;;^UTILITY(U,$J,358.3,31165,0)
 ;;=F06.0^^91^1354^8
 ;;^UTILITY(U,$J,358.3,31165,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31165,1,3,0)
 ;;=3^Psychotic Disorder d/t Another Med Cond w/ Hallucinations
 ;;^UTILITY(U,$J,358.3,31165,1,4,0)
 ;;=4^F06.0
 ;;^UTILITY(U,$J,358.3,31165,2)
 ;;=^5003053
 ;;^UTILITY(U,$J,358.3,31166,0)
 ;;=F52.32^^91^1355^1
 ;;^UTILITY(U,$J,358.3,31166,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31166,1,3,0)
 ;;=3^Delayed Ejaculation
 ;;^UTILITY(U,$J,358.3,31166,1,4,0)
 ;;=4^F52.32
 ;;^UTILITY(U,$J,358.3,31166,2)
 ;;=^331927
 ;;^UTILITY(U,$J,358.3,31167,0)
 ;;=F52.21^^91^1355^2
 ;;^UTILITY(U,$J,358.3,31167,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31167,1,3,0)
 ;;=3^Erectile Disorder
 ;;^UTILITY(U,$J,358.3,31167,1,4,0)
 ;;=4^F52.21
 ;;^UTILITY(U,$J,358.3,31167,2)
 ;;=^5003620
 ;;^UTILITY(U,$J,358.3,31168,0)
 ;;=F52.31^^91^1355^3
 ;;^UTILITY(U,$J,358.3,31168,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31168,1,3,0)
 ;;=3^Female Orgasmic Disorder
 ;;^UTILITY(U,$J,358.3,31168,1,4,0)
 ;;=4^F52.31
 ;;^UTILITY(U,$J,358.3,31168,2)
 ;;=^331926
 ;;^UTILITY(U,$J,358.3,31169,0)
 ;;=F52.22^^91^1355^4
 ;;^UTILITY(U,$J,358.3,31169,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31169,1,3,0)
 ;;=3^Female Sexual Interest/Arousal Disorder
 ;;^UTILITY(U,$J,358.3,31169,1,4,0)
 ;;=4^F52.22
 ;;^UTILITY(U,$J,358.3,31169,2)
 ;;=^5003621
 ;;^UTILITY(U,$J,358.3,31170,0)
 ;;=F52.6^^91^1355^5
 ;;^UTILITY(U,$J,358.3,31170,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31170,1,3,0)
 ;;=3^Genito-Pelvic Pain/Penetration Disorder
 ;;^UTILITY(U,$J,358.3,31170,1,4,0)
 ;;=4^F52.6
 ;;^UTILITY(U,$J,358.3,31170,2)
 ;;=^5003623
 ;;^UTILITY(U,$J,358.3,31171,0)
 ;;=F52.0^^91^1355^6
 ;;^UTILITY(U,$J,358.3,31171,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31171,1,3,0)
 ;;=3^Male Hypoactive Sexual Desire Disorder
 ;;^UTILITY(U,$J,358.3,31171,1,4,0)
 ;;=4^F52.0
 ;;^UTILITY(U,$J,358.3,31171,2)
 ;;=^5003618
 ;;^UTILITY(U,$J,358.3,31172,0)
 ;;=F52.4^^91^1355^7
 ;;^UTILITY(U,$J,358.3,31172,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31172,1,3,0)
 ;;=3^Premature (Early) Ejaculation
 ;;^UTILITY(U,$J,358.3,31172,1,4,0)
 ;;=4^F52.4
 ;;^UTILITY(U,$J,358.3,31172,2)
 ;;=^331928
 ;;^UTILITY(U,$J,358.3,31173,0)
 ;;=F52.8^^91^1355^9
 ;;^UTILITY(U,$J,358.3,31173,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31173,1,3,0)
 ;;=3^Sexual Dysfuntion,Other
 ;;^UTILITY(U,$J,358.3,31173,1,4,0)
 ;;=4^F52.8
 ;;^UTILITY(U,$J,358.3,31173,2)
 ;;=^5003624
 ;;^UTILITY(U,$J,358.3,31174,0)
 ;;=F52.9^^91^1355^8
 ;;^UTILITY(U,$J,358.3,31174,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31174,1,3,0)
 ;;=3^Sexual Dysfunction,Unspec
 ;;^UTILITY(U,$J,358.3,31174,1,4,0)
 ;;=4^F52.9
 ;;^UTILITY(U,$J,358.3,31174,2)
 ;;=^5003625
 ;;^UTILITY(U,$J,358.3,31175,0)
 ;;=G47.09^^91^1356^16
 ;;^UTILITY(U,$J,358.3,31175,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31175,1,3,0)
 ;;=3^Insomnia,Other Specified
 ;;^UTILITY(U,$J,358.3,31175,1,4,0)
 ;;=4^G47.09
 ;;^UTILITY(U,$J,358.3,31175,2)
 ;;=^5003970
 ;;^UTILITY(U,$J,358.3,31176,0)
 ;;=G47.00^^91^1356^17
 ;;^UTILITY(U,$J,358.3,31176,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31176,1,3,0)
 ;;=3^Insomnia,Unspec
 ;;^UTILITY(U,$J,358.3,31176,1,4,0)
 ;;=4^G47.00
 ;;^UTILITY(U,$J,358.3,31176,2)
 ;;=^332924
 ;;^UTILITY(U,$J,358.3,31177,0)
 ;;=G47.10^^91^1356^14
 ;;^UTILITY(U,$J,358.3,31177,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31177,1,3,0)
 ;;=3^Hypersomnolence Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,31177,1,4,0)
 ;;=4^G47.10
 ;;^UTILITY(U,$J,358.3,31177,2)
 ;;=^332926
 ;;^UTILITY(U,$J,358.3,31178,0)
 ;;=G47.419^^91^1356^20
 ;;^UTILITY(U,$J,358.3,31178,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31178,1,3,0)
 ;;=3^Narcolepsy w/o Cataplexy w/ Hypocretin Deficiency
 ;;^UTILITY(U,$J,358.3,31178,1,4,0)
 ;;=4^G47.419
 ;;^UTILITY(U,$J,358.3,31178,2)
 ;;=^5003982
 ;;^UTILITY(U,$J,358.3,31179,0)
 ;;=G47.33^^91^1356^24
 ;;^UTILITY(U,$J,358.3,31179,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31179,1,3,0)
 ;;=3^Obstructive Sleep Apnea Hypopnea
 ;;^UTILITY(U,$J,358.3,31179,1,4,0)
 ;;=4^G47.33
 ;;^UTILITY(U,$J,358.3,31179,2)
 ;;=^332763
 ;;^UTILITY(U,$J,358.3,31180,0)
 ;;=G47.31^^91^1356^4
 ;;^UTILITY(U,$J,358.3,31180,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31180,1,3,0)
 ;;=3^Central Sleep Apnea,Idiopathic
 ;;^UTILITY(U,$J,358.3,31180,1,4,0)
 ;;=4^G47.31
 ;;^UTILITY(U,$J,358.3,31180,2)
 ;;=^332761
 ;;^UTILITY(U,$J,358.3,31181,0)
 ;;=G47.21^^91^1356^7
 ;;^UTILITY(U,$J,358.3,31181,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31181,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake D/O;Delayed Sleep Phase Type
 ;;^UTILITY(U,$J,358.3,31181,1,4,0)
 ;;=4^G47.21
 ;;^UTILITY(U,$J,358.3,31181,2)
 ;;=^332769
 ;;^UTILITY(U,$J,358.3,31182,0)
 ;;=G47.22^^91^1356^6
 ;;^UTILITY(U,$J,358.3,31182,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31182,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake D/O;Advanced Sleep Phase Type
 ;;^UTILITY(U,$J,358.3,31182,1,4,0)
 ;;=4^G47.22
 ;;^UTILITY(U,$J,358.3,31182,2)
 ;;=^332770
 ;;^UTILITY(U,$J,358.3,31183,0)
 ;;=G47.23^^91^1356^8
 ;;^UTILITY(U,$J,358.3,31183,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31183,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake D/O;Irregular Sleep Wake Type
 ;;^UTILITY(U,$J,358.3,31183,1,4,0)
 ;;=4^G47.23
 ;;^UTILITY(U,$J,358.3,31183,2)
 ;;=^5003975
 ;;^UTILITY(U,$J,358.3,31184,0)
 ;;=G47.24^^91^1356^9
 ;;^UTILITY(U,$J,358.3,31184,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31184,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake D/O;Non-24 Hr Sleep Wake Type
 ;;^UTILITY(U,$J,358.3,31184,1,4,0)
 ;;=4^G47.24
 ;;^UTILITY(U,$J,358.3,31184,2)
 ;;=^5003976
 ;;^UTILITY(U,$J,358.3,31185,0)
 ;;=G47.26^^91^1356^10
 ;;^UTILITY(U,$J,358.3,31185,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31185,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake D/O;Shift Work Type
 ;;^UTILITY(U,$J,358.3,31185,1,4,0)
 ;;=4^G47.26
 ;;^UTILITY(U,$J,358.3,31185,2)
 ;;=^332774
 ;;^UTILITY(U,$J,358.3,31186,0)
 ;;=G47.20^^91^1356^11

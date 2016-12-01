IBDEI0BW ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15092,2)
 ;;=^5003054
 ;;^UTILITY(U,$J,358.3,15093,0)
 ;;=F06.1^^45^674^3
 ;;^UTILITY(U,$J,358.3,15093,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15093,1,3,0)
 ;;=3^Catatonia,Unspec
 ;;^UTILITY(U,$J,358.3,15093,1,4,0)
 ;;=4^F06.1
 ;;^UTILITY(U,$J,358.3,15093,2)
 ;;=^5003054
 ;;^UTILITY(U,$J,358.3,15094,0)
 ;;=R29.818^^45^674^6
 ;;^UTILITY(U,$J,358.3,15094,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15094,1,3,0)
 ;;=3^Nervous & Musculoskeletal System Symptoms,Other
 ;;^UTILITY(U,$J,358.3,15094,1,4,0)
 ;;=4^R29.818
 ;;^UTILITY(U,$J,358.3,15094,2)
 ;;=^5019318
 ;;^UTILITY(U,$J,358.3,15095,0)
 ;;=F06.2^^45^674^7
 ;;^UTILITY(U,$J,358.3,15095,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15095,1,3,0)
 ;;=3^Psychotic Disorder d/t Another Med Cond w/ Delusions
 ;;^UTILITY(U,$J,358.3,15095,1,4,0)
 ;;=4^F06.2
 ;;^UTILITY(U,$J,358.3,15095,2)
 ;;=^5003055
 ;;^UTILITY(U,$J,358.3,15096,0)
 ;;=F06.0^^45^674^8
 ;;^UTILITY(U,$J,358.3,15096,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15096,1,3,0)
 ;;=3^Psychotic Disorder d/t Another Med Cond w/ Hallucinations
 ;;^UTILITY(U,$J,358.3,15096,1,4,0)
 ;;=4^F06.0
 ;;^UTILITY(U,$J,358.3,15096,2)
 ;;=^5003053
 ;;^UTILITY(U,$J,358.3,15097,0)
 ;;=F52.32^^45^675^1
 ;;^UTILITY(U,$J,358.3,15097,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15097,1,3,0)
 ;;=3^Delayed Ejaculation
 ;;^UTILITY(U,$J,358.3,15097,1,4,0)
 ;;=4^F52.32
 ;;^UTILITY(U,$J,358.3,15097,2)
 ;;=^331927
 ;;^UTILITY(U,$J,358.3,15098,0)
 ;;=F52.21^^45^675^2
 ;;^UTILITY(U,$J,358.3,15098,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15098,1,3,0)
 ;;=3^Erectile Disorder
 ;;^UTILITY(U,$J,358.3,15098,1,4,0)
 ;;=4^F52.21
 ;;^UTILITY(U,$J,358.3,15098,2)
 ;;=^5003620
 ;;^UTILITY(U,$J,358.3,15099,0)
 ;;=F52.31^^45^675^3
 ;;^UTILITY(U,$J,358.3,15099,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15099,1,3,0)
 ;;=3^Female Orgasmic Disorder
 ;;^UTILITY(U,$J,358.3,15099,1,4,0)
 ;;=4^F52.31
 ;;^UTILITY(U,$J,358.3,15099,2)
 ;;=^331926
 ;;^UTILITY(U,$J,358.3,15100,0)
 ;;=F52.22^^45^675^4
 ;;^UTILITY(U,$J,358.3,15100,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15100,1,3,0)
 ;;=3^Female Sexual Interest/Arousal Disorder
 ;;^UTILITY(U,$J,358.3,15100,1,4,0)
 ;;=4^F52.22
 ;;^UTILITY(U,$J,358.3,15100,2)
 ;;=^5003621
 ;;^UTILITY(U,$J,358.3,15101,0)
 ;;=F52.6^^45^675^5
 ;;^UTILITY(U,$J,358.3,15101,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15101,1,3,0)
 ;;=3^Genito-Pelvic Pain/Penetration Disorder
 ;;^UTILITY(U,$J,358.3,15101,1,4,0)
 ;;=4^F52.6
 ;;^UTILITY(U,$J,358.3,15101,2)
 ;;=^5003623
 ;;^UTILITY(U,$J,358.3,15102,0)
 ;;=F52.0^^45^675^6
 ;;^UTILITY(U,$J,358.3,15102,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15102,1,3,0)
 ;;=3^Male Hypoactive Sexual Desire Disorder
 ;;^UTILITY(U,$J,358.3,15102,1,4,0)
 ;;=4^F52.0
 ;;^UTILITY(U,$J,358.3,15102,2)
 ;;=^5003618
 ;;^UTILITY(U,$J,358.3,15103,0)
 ;;=F52.4^^45^675^7
 ;;^UTILITY(U,$J,358.3,15103,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15103,1,3,0)
 ;;=3^Premature (Early) Ejaculation
 ;;^UTILITY(U,$J,358.3,15103,1,4,0)
 ;;=4^F52.4
 ;;^UTILITY(U,$J,358.3,15103,2)
 ;;=^331928
 ;;^UTILITY(U,$J,358.3,15104,0)
 ;;=F52.8^^45^675^9
 ;;^UTILITY(U,$J,358.3,15104,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15104,1,3,0)
 ;;=3^Sexual Dysfuntion,Other
 ;;^UTILITY(U,$J,358.3,15104,1,4,0)
 ;;=4^F52.8
 ;;^UTILITY(U,$J,358.3,15104,2)
 ;;=^5003624
 ;;^UTILITY(U,$J,358.3,15105,0)
 ;;=F52.9^^45^675^8
 ;;^UTILITY(U,$J,358.3,15105,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15105,1,3,0)
 ;;=3^Sexual Dysfunction,Unspec
 ;;^UTILITY(U,$J,358.3,15105,1,4,0)
 ;;=4^F52.9
 ;;^UTILITY(U,$J,358.3,15105,2)
 ;;=^5003625
 ;;^UTILITY(U,$J,358.3,15106,0)
 ;;=G47.09^^45^676^16
 ;;^UTILITY(U,$J,358.3,15106,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15106,1,3,0)
 ;;=3^Insomnia,Other Specified
 ;;^UTILITY(U,$J,358.3,15106,1,4,0)
 ;;=4^G47.09
 ;;^UTILITY(U,$J,358.3,15106,2)
 ;;=^5003970
 ;;^UTILITY(U,$J,358.3,15107,0)
 ;;=G47.00^^45^676^17
 ;;^UTILITY(U,$J,358.3,15107,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15107,1,3,0)
 ;;=3^Insomnia,Unspec
 ;;^UTILITY(U,$J,358.3,15107,1,4,0)
 ;;=4^G47.00
 ;;^UTILITY(U,$J,358.3,15107,2)
 ;;=^332924
 ;;^UTILITY(U,$J,358.3,15108,0)
 ;;=G47.10^^45^676^14
 ;;^UTILITY(U,$J,358.3,15108,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15108,1,3,0)
 ;;=3^Hypersomnolence Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,15108,1,4,0)
 ;;=4^G47.10
 ;;^UTILITY(U,$J,358.3,15108,2)
 ;;=^332926
 ;;^UTILITY(U,$J,358.3,15109,0)
 ;;=G47.419^^45^676^20
 ;;^UTILITY(U,$J,358.3,15109,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15109,1,3,0)
 ;;=3^Narcolepsy w/o Cataplexy w/ Hypocretin Deficiency
 ;;^UTILITY(U,$J,358.3,15109,1,4,0)
 ;;=4^G47.419
 ;;^UTILITY(U,$J,358.3,15109,2)
 ;;=^5003982
 ;;^UTILITY(U,$J,358.3,15110,0)
 ;;=G47.33^^45^676^24
 ;;^UTILITY(U,$J,358.3,15110,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15110,1,3,0)
 ;;=3^Obstructive Sleep Apnea Hypopnea
 ;;^UTILITY(U,$J,358.3,15110,1,4,0)
 ;;=4^G47.33
 ;;^UTILITY(U,$J,358.3,15110,2)
 ;;=^332763
 ;;^UTILITY(U,$J,358.3,15111,0)
 ;;=G47.31^^45^676^4
 ;;^UTILITY(U,$J,358.3,15111,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15111,1,3,0)
 ;;=3^Central Sleep Apnea,Idiopathic
 ;;^UTILITY(U,$J,358.3,15111,1,4,0)
 ;;=4^G47.31
 ;;^UTILITY(U,$J,358.3,15111,2)
 ;;=^332761
 ;;^UTILITY(U,$J,358.3,15112,0)
 ;;=G47.21^^45^676^7
 ;;^UTILITY(U,$J,358.3,15112,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15112,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake D/O;Delayed Sleep Phase Type
 ;;^UTILITY(U,$J,358.3,15112,1,4,0)
 ;;=4^G47.21
 ;;^UTILITY(U,$J,358.3,15112,2)
 ;;=^332769
 ;;^UTILITY(U,$J,358.3,15113,0)
 ;;=G47.22^^45^676^6
 ;;^UTILITY(U,$J,358.3,15113,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15113,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake D/O;Advanced Sleep Phase Type
 ;;^UTILITY(U,$J,358.3,15113,1,4,0)
 ;;=4^G47.22
 ;;^UTILITY(U,$J,358.3,15113,2)
 ;;=^332770
 ;;^UTILITY(U,$J,358.3,15114,0)
 ;;=G47.23^^45^676^8
 ;;^UTILITY(U,$J,358.3,15114,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15114,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake D/O;Irregular Sleep Wake Type
 ;;^UTILITY(U,$J,358.3,15114,1,4,0)
 ;;=4^G47.23
 ;;^UTILITY(U,$J,358.3,15114,2)
 ;;=^5003975
 ;;^UTILITY(U,$J,358.3,15115,0)
 ;;=G47.24^^45^676^9
 ;;^UTILITY(U,$J,358.3,15115,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15115,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake D/O;Non-24 Hr Sleep Wake Type
 ;;^UTILITY(U,$J,358.3,15115,1,4,0)
 ;;=4^G47.24
 ;;^UTILITY(U,$J,358.3,15115,2)
 ;;=^5003976
 ;;^UTILITY(U,$J,358.3,15116,0)
 ;;=G47.26^^45^676^10
 ;;^UTILITY(U,$J,358.3,15116,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15116,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake D/O;Shift Work Type
 ;;^UTILITY(U,$J,358.3,15116,1,4,0)
 ;;=4^G47.26
 ;;^UTILITY(U,$J,358.3,15116,2)
 ;;=^332774
 ;;^UTILITY(U,$J,358.3,15117,0)
 ;;=G47.20^^45^676^11
 ;;^UTILITY(U,$J,358.3,15117,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15117,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake D/O;Unspec Type
 ;;^UTILITY(U,$J,358.3,15117,1,4,0)
 ;;=4^G47.20
 ;;^UTILITY(U,$J,358.3,15117,2)
 ;;=^5003974
 ;;^UTILITY(U,$J,358.3,15118,0)
 ;;=F51.3^^45^676^22
 ;;^UTILITY(U,$J,358.3,15118,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15118,1,3,0)
 ;;=3^Non-Rapid Eye Movement Sleep Arousal D/O;Sleepwalking Type
 ;;^UTILITY(U,$J,358.3,15118,1,4,0)
 ;;=4^F51.3
 ;;^UTILITY(U,$J,358.3,15118,2)
 ;;=^5003613
 ;;^UTILITY(U,$J,358.3,15119,0)
 ;;=F51.4^^45^676^23
 ;;^UTILITY(U,$J,358.3,15119,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15119,1,3,0)
 ;;=3^Non-Rapid Eye Movement Sleep Arousal D/O;Sleep Terror Type
 ;;^UTILITY(U,$J,358.3,15119,1,4,0)
 ;;=4^F51.4
 ;;^UTILITY(U,$J,358.3,15119,2)
 ;;=^5003614
 ;;^UTILITY(U,$J,358.3,15120,0)
 ;;=F51.5^^45^676^21
 ;;^UTILITY(U,$J,358.3,15120,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15120,1,3,0)
 ;;=3^Nightmare Disorder
 ;;^UTILITY(U,$J,358.3,15120,1,4,0)
 ;;=4^F51.5
 ;;^UTILITY(U,$J,358.3,15120,2)
 ;;=^5003615
 ;;^UTILITY(U,$J,358.3,15121,0)
 ;;=G47.52^^45^676^25
 ;;^UTILITY(U,$J,358.3,15121,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15121,1,3,0)
 ;;=3^Rapid Eye Movement Sleep Behavior Disorder
 ;;^UTILITY(U,$J,358.3,15121,1,4,0)
 ;;=4^G47.52
 ;;^UTILITY(U,$J,358.3,15121,2)
 ;;=^332778
 ;;^UTILITY(U,$J,358.3,15122,0)
 ;;=G25.81^^45^676^26
 ;;^UTILITY(U,$J,358.3,15122,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15122,1,3,0)
 ;;=3^Restless Legs Syndrome
 ;;^UTILITY(U,$J,358.3,15122,1,4,0)
 ;;=4^G25.81
 ;;^UTILITY(U,$J,358.3,15122,2)
 ;;=^5003801
 ;;^UTILITY(U,$J,358.3,15123,0)
 ;;=G47.19^^45^676^13
 ;;^UTILITY(U,$J,358.3,15123,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15123,1,3,0)
 ;;=3^Hypersomnolence Disorder,Other Specified
 ;;^UTILITY(U,$J,358.3,15123,1,4,0)
 ;;=4^G47.19
 ;;^UTILITY(U,$J,358.3,15123,2)
 ;;=^5003973
 ;;^UTILITY(U,$J,358.3,15124,0)
 ;;=G47.8^^45^676^30
 ;;^UTILITY(U,$J,358.3,15124,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15124,1,3,0)
 ;;=3^Sleep-Wake Disorder,Other Specified
 ;;^UTILITY(U,$J,358.3,15124,1,4,0)
 ;;=4^G47.8
 ;;^UTILITY(U,$J,358.3,15124,2)
 ;;=^5003989
 ;;^UTILITY(U,$J,358.3,15125,0)
 ;;=G47.411^^45^676^19
 ;;^UTILITY(U,$J,358.3,15125,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15125,1,3,0)
 ;;=3^Narcolepsy w/ Cataplexy w/o Hypocretin Deficiency
 ;;^UTILITY(U,$J,358.3,15125,1,4,0)
 ;;=4^G47.411
 ;;^UTILITY(U,$J,358.3,15125,2)
 ;;=^5003981
 ;;^UTILITY(U,$J,358.3,15126,0)
 ;;=G47.37^^45^676^3
 ;;^UTILITY(U,$J,358.3,15126,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15126,1,3,0)
 ;;=3^Central Sleep Apnea,Comorbid w/ Opioid Use
 ;;^UTILITY(U,$J,358.3,15126,1,4,0)
 ;;=4^G47.37
 ;;^UTILITY(U,$J,358.3,15126,2)
 ;;=^332767
 ;;^UTILITY(U,$J,358.3,15127,0)
 ;;=F51.11^^45^676^12
 ;;^UTILITY(U,$J,358.3,15127,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15127,1,3,0)
 ;;=3^Hypersomnolence Disorder
 ;;^UTILITY(U,$J,358.3,15127,1,4,0)
 ;;=4^F51.11
 ;;^UTILITY(U,$J,358.3,15127,2)
 ;;=^5003609

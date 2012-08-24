IBDEI00G ; ; 12-JAN-2012
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JAN 12, 2012
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,78,1,5,0)
 ;;=5^Bipolar Mixed, Full Remission
 ;;^UTILITY(U,$J,358.3,78,2)
 ;;=^303632
 ;;^UTILITY(U,$J,358.3,79,0)
 ;;=296.7^^1^7^22
 ;;^UTILITY(U,$J,358.3,79,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,79,1,2,0)
 ;;=2^296.7
 ;;^UTILITY(U,$J,358.3,79,1,5,0)
 ;;=5^Bipolar Disorder, NOS
 ;;^UTILITY(U,$J,358.3,79,2)
 ;;=Bipolar Disorder, NOS^303633
 ;;^UTILITY(U,$J,358.3,80,0)
 ;;=297.0^^1^8^2
 ;;^UTILITY(U,$J,358.3,80,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,80,1,2,0)
 ;;=2^297.0
 ;;^UTILITY(U,$J,358.3,80,1,5,0)
 ;;=5^Paranoid State, Simple
 ;;^UTILITY(U,$J,358.3,80,2)
 ;;=^268149
 ;;^UTILITY(U,$J,358.3,81,0)
 ;;=297.1^^1^8^1
 ;;^UTILITY(U,$J,358.3,81,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,81,1,2,0)
 ;;=2^297.1
 ;;^UTILITY(U,$J,358.3,81,1,5,0)
 ;;=5^Paranoia
 ;;^UTILITY(U,$J,358.3,81,2)
 ;;=^89972
 ;;^UTILITY(U,$J,358.3,82,0)
 ;;=298.9^^1^8^4
 ;;^UTILITY(U,$J,358.3,82,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,82,1,2,0)
 ;;=2^298.9
 ;;^UTILITY(U,$J,358.3,82,1,5,0)
 ;;=5^Psychosis, NOS
 ;;^UTILITY(U,$J,358.3,82,2)
 ;;=^259059
 ;;^UTILITY(U,$J,358.3,83,0)
 ;;=298.8^^1^8^3
 ;;^UTILITY(U,$J,358.3,83,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,83,1,2,0)
 ;;=2^298.8
 ;;^UTILITY(U,$J,358.3,83,1,5,0)
 ;;=5^Psychosis, Reactive
 ;;^UTILITY(U,$J,358.3,83,2)
 ;;=^87326
 ;;^UTILITY(U,$J,358.3,84,0)
 ;;=301.7^^1^9^1
 ;;^UTILITY(U,$J,358.3,84,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,84,1,2,0)
 ;;=2^301.7
 ;;^UTILITY(U,$J,358.3,84,1,5,0)
 ;;=5^Antisocial Personality
 ;;^UTILITY(U,$J,358.3,84,2)
 ;;=^9066
 ;;^UTILITY(U,$J,358.3,85,0)
 ;;=301.82^^1^9^2
 ;;^UTILITY(U,$J,358.3,85,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,85,1,2,0)
 ;;=2^301.82
 ;;^UTILITY(U,$J,358.3,85,1,5,0)
 ;;=5^Avoidant Personality
 ;;^UTILITY(U,$J,358.3,85,2)
 ;;=Avoidant Personality^265347
 ;;^UTILITY(U,$J,358.3,86,0)
 ;;=301.83^^1^9^3
 ;;^UTILITY(U,$J,358.3,86,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,86,1,2,0)
 ;;=2^301.83
 ;;^UTILITY(U,$J,358.3,86,1,5,0)
 ;;=5^Borderline Personality
 ;;^UTILITY(U,$J,358.3,86,2)
 ;;=Borderline Personality^16372
 ;;^UTILITY(U,$J,358.3,87,0)
 ;;=301.6^^1^9^5
 ;;^UTILITY(U,$J,358.3,87,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,87,1,2,0)
 ;;=2^301.6
 ;;^UTILITY(U,$J,358.3,87,1,5,0)
 ;;=5^Dependent Personality
 ;;^UTILITY(U,$J,358.3,87,2)
 ;;=Dependent Personality^32860
 ;;^UTILITY(U,$J,358.3,88,0)
 ;;=301.50^^1^9^6
 ;;^UTILITY(U,$J,358.3,88,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,88,1,2,0)
 ;;=2^301.50
 ;;^UTILITY(U,$J,358.3,88,1,5,0)
 ;;=5^Histrionic Personality
 ;;^UTILITY(U,$J,358.3,88,2)
 ;;=Histrionic Personality^57763
 ;;^UTILITY(U,$J,358.3,89,0)
 ;;=301.81^^1^9^7
 ;;^UTILITY(U,$J,358.3,89,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,89,1,2,0)
 ;;=2^301.81
 ;;^UTILITY(U,$J,358.3,89,1,5,0)
 ;;=5^Narcissistic Personality
 ;;^UTILITY(U,$J,358.3,89,2)
 ;;=Narcissistic Personality^265353
 ;;^UTILITY(U,$J,358.3,90,0)
 ;;=301.0^^1^9^8
 ;;^UTILITY(U,$J,358.3,90,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,90,1,2,0)
 ;;=2^301.0
 ;;^UTILITY(U,$J,358.3,90,1,5,0)
 ;;=5^Paranoid Personality
 ;;^UTILITY(U,$J,358.3,90,2)
 ;;=Paranoid Personality^89982
 ;;^UTILITY(U,$J,358.3,91,0)
 ;;=301.9^^1^9^12
 ;;^UTILITY(U,$J,358.3,91,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,91,1,2,0)
 ;;=2^301.9
 ;;^UTILITY(U,$J,358.3,91,1,5,0)
 ;;=5^Unspecified Personality Disorder
 ;;^UTILITY(U,$J,358.3,91,2)
 ;;=Unspecified Personality Disorder^92451
 ;;^UTILITY(U,$J,358.3,92,0)
 ;;=301.20^^1^9^10
 ;;^UTILITY(U,$J,358.3,92,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,92,1,2,0)
 ;;=2^301.20
 ;;^UTILITY(U,$J,358.3,92,1,5,0)
 ;;=5^Schizoid Personality
 ;;^UTILITY(U,$J,358.3,92,2)
 ;;=Schizoid Personality^108271
 ;;^UTILITY(U,$J,358.3,93,0)
 ;;=301.22^^1^9^11
 ;;^UTILITY(U,$J,358.3,93,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,93,1,2,0)
 ;;=2^301.22
 ;;^UTILITY(U,$J,358.3,93,1,5,0)
 ;;=5^Schizotypal Personality
 ;;^UTILITY(U,$J,358.3,93,2)
 ;;=Schizotypal Personality^108367
 ;;^UTILITY(U,$J,358.3,94,0)
 ;;=301.4^^1^9^4
 ;;^UTILITY(U,$J,358.3,94,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,94,1,2,0)
 ;;=2^301.4
 ;;^UTILITY(U,$J,358.3,94,1,5,0)
 ;;=5^Compulsive Personality
 ;;^UTILITY(U,$J,358.3,94,2)
 ;;=Compulsive Personality^27122
 ;;^UTILITY(U,$J,358.3,95,0)
 ;;=301.84^^1^9^9
 ;;^UTILITY(U,$J,358.3,95,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,95,1,2,0)
 ;;=2^301.84
 ;;^UTILITY(U,$J,358.3,95,1,5,0)
 ;;=5^Passive-Aggressive Personality Disorder
 ;;^UTILITY(U,$J,358.3,95,2)
 ;;=Passive-Aggressive Personality Disorder^90602
 ;;^UTILITY(U,$J,358.3,96,0)
 ;;=302.2^^1^10^6
 ;;^UTILITY(U,$J,358.3,96,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,96,1,2,0)
 ;;=2^302.2
 ;;^UTILITY(U,$J,358.3,96,1,5,0)
 ;;=5^Pedophilia
 ;;^UTILITY(U,$J,358.3,96,2)
 ;;=^91008
 ;;^UTILITY(U,$J,358.3,97,0)
 ;;=302.4^^1^10^1
 ;;^UTILITY(U,$J,358.3,97,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,97,1,2,0)
 ;;=2^302.4
 ;;^UTILITY(U,$J,358.3,97,1,5,0)
 ;;=5^Exhibitionism
 ;;^UTILITY(U,$J,358.3,97,2)
 ;;=^43610
 ;;^UTILITY(U,$J,358.3,98,0)
 ;;=302.72^^1^10^5
 ;;^UTILITY(U,$J,358.3,98,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,98,1,2,0)
 ;;=2^302.72
 ;;^UTILITY(U,$J,358.3,98,1,5,0)
 ;;=5^Inhibited Sex Excite
 ;;^UTILITY(U,$J,358.3,98,2)
 ;;=^100632
 ;;^UTILITY(U,$J,358.3,99,0)
 ;;=302.73^^1^10^3
 ;;^UTILITY(U,$J,358.3,99,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,99,1,2,0)
 ;;=2^302.73
 ;;^UTILITY(U,$J,358.3,99,1,5,0)
 ;;=5^Inhibited Female Orgasm
 ;;^UTILITY(U,$J,358.3,99,2)
 ;;=^100628
 ;;^UTILITY(U,$J,358.3,100,0)
 ;;=302.74^^1^10^4
 ;;^UTILITY(U,$J,358.3,100,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,100,1,2,0)
 ;;=2^302.74
 ;;^UTILITY(U,$J,358.3,100,1,5,0)
 ;;=5^Inhibited Male Orgasm
 ;;^UTILITY(U,$J,358.3,100,2)
 ;;=^100630
 ;;^UTILITY(U,$J,358.3,101,0)
 ;;=302.75^^1^10^7
 ;;^UTILITY(U,$J,358.3,101,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,101,1,2,0)
 ;;=2^302.75
 ;;^UTILITY(U,$J,358.3,101,1,5,0)
 ;;=5^Premature Ejaculation
 ;;^UTILITY(U,$J,358.3,101,2)
 ;;=^100637
 ;;^UTILITY(U,$J,358.3,102,0)
 ;;=302.85^^1^10^2
 ;;^UTILITY(U,$J,358.3,102,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,102,1,2,0)
 ;;=2^302.85
 ;;^UTILITY(U,$J,358.3,102,1,5,0)
 ;;=5^Gender Ident Disorder
 ;;^UTILITY(U,$J,358.3,102,2)
 ;;=^268180
 ;;^UTILITY(U,$J,358.3,103,0)
 ;;=780.52^^1^11^1
 ;;^UTILITY(U,$J,358.3,103,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,103,1,2,0)
 ;;=2^780.52
 ;;^UTILITY(U,$J,358.3,103,1,5,0)
 ;;=5^Insomnia
 ;;^UTILITY(U,$J,358.3,103,2)
 ;;=^87662
 ;;^UTILITY(U,$J,358.3,104,0)
 ;;=780.51^^1^11^2
 ;;^UTILITY(U,$J,358.3,104,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,104,1,2,0)
 ;;=2^780.51
 ;;^UTILITY(U,$J,358.3,104,1,5,0)
 ;;=5^Insomnia w/Sleep Apnea
 ;;^UTILITY(U,$J,358.3,104,2)
 ;;=^273348
 ;;^UTILITY(U,$J,358.3,105,0)
 ;;=780.57^^1^11^4
 ;;^UTILITY(U,$J,358.3,105,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,105,1,2,0)
 ;;=2^780.57
 ;;^UTILITY(U,$J,358.3,105,1,5,0)
 ;;=5^Sleep Apnea
 ;;^UTILITY(U,$J,358.3,105,2)
 ;;=^293933
 ;;^UTILITY(U,$J,358.3,106,0)
 ;;=780.50^^1^11^5
 ;;^UTILITY(U,$J,358.3,106,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,106,1,2,0)
 ;;=2^780.50
 ;;^UTILITY(U,$J,358.3,106,1,5,0)
 ;;=5^Sleep Disturbance, Unspec
 ;;^UTILITY(U,$J,358.3,106,2)
 ;;=^111271
 ;;^UTILITY(U,$J,358.3,107,0)
 ;;=314.00^^1^12^1
 ;;^UTILITY(U,$J,358.3,107,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,107,1,2,0)
 ;;=2^314.00
 ;;^UTILITY(U,$J,358.3,107,1,5,0)
 ;;=5^Attn Deficw/o Hyperactiv.
 ;;^UTILITY(U,$J,358.3,107,2)
 ;;=^268351
 ;;^UTILITY(U,$J,358.3,108,0)
 ;;=312.31^^1^12^7
 ;;^UTILITY(U,$J,358.3,108,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,108,1,2,0)
 ;;=2^312.31
 ;;^UTILITY(U,$J,358.3,108,1,5,0)
 ;;=5^Pathological Gambling
 ;;^UTILITY(U,$J,358.3,108,2)
 ;;=^90682
 ;;^UTILITY(U,$J,358.3,109,0)
 ;;=316.^^1^12^8
 ;;^UTILITY(U,$J,358.3,109,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,109,1,2,0)
 ;;=2^316.
 ;;^UTILITY(U,$J,358.3,109,1,5,0)
 ;;=5^Psychic Fact w/Other Dis
 ;;^UTILITY(U,$J,358.3,109,2)
 ;;=^268363
 ;;^UTILITY(U,$J,358.3,110,0)
 ;;=314.01^^1^12^1.01
 ;;^UTILITY(U,$J,358.3,110,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,110,1,2,0)
 ;;=2^314.01
 ;;^UTILITY(U,$J,358.3,110,1,5,0)
 ;;=5^Attn Defic w/Hyperactiv.
 ;;^UTILITY(U,$J,358.3,110,2)
 ;;=^303679
 ;;^UTILITY(U,$J,358.3,111,0)
 ;;=300.16^^1^12^4
 ;;^UTILITY(U,$J,358.3,111,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,111,1,2,0)
 ;;=2^300.16
 ;;^UTILITY(U,$J,358.3,111,1,5,0)
 ;;=5^Factitious Disorder
 ;;^UTILITY(U,$J,358.3,111,2)
 ;;=^303643
 ;;^UTILITY(U,$J,358.3,112,0)
 ;;=317.^^1^12^10
 ;;^UTILITY(U,$J,358.3,112,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,112,1,2,0)
 ;;=2^317.
 ;;^UTILITY(U,$J,358.3,112,1,5,0)
 ;;=5^Mild Intellectial Disabilities
 ;;^UTILITY(U,$J,358.3,112,2)
 ;;=^340649
 ;;^UTILITY(U,$J,358.3,113,0)
 ;;=303.00^^1^13^5
 ;;^UTILITY(U,$J,358.3,113,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,113,1,2,0)
 ;;=2^303.00
 ;;^UTILITY(U,$J,358.3,113,1,5,0)
 ;;=5^Acute Alc Intox, Nos
 ;;^UTILITY(U,$J,358.3,113,2)
 ;;=^268183
 ;;^UTILITY(U,$J,358.3,114,0)
 ;;=303.90^^1^13^4
 ;;^UTILITY(U,$J,358.3,114,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,114,1,2,0)
 ;;=2^303.90
 ;;^UTILITY(U,$J,358.3,114,1,5,0)
 ;;=5^Alc Dependence, Nos
 ;;^UTILITY(U,$J,358.3,114,2)
 ;;=^268187
 ;;^UTILITY(U,$J,358.3,115,0)
 ;;=303.93^^1^13^4.9
 ;;^UTILITY(U,$J,358.3,115,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,115,1,2,0)
 ;;=2^303.93
 ;;^UTILITY(U,$J,358.3,115,1,5,0)
 ;;=5^Alc Dependence, Remission
 ;;^UTILITY(U,$J,358.3,115,2)
 ;;=^268190
 ;;^UTILITY(U,$J,358.3,116,0)
 ;;=305.00^^1^13^1
 ;;^UTILITY(U,$J,358.3,116,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,116,1,2,0)
 ;;=2^305.00
 ;;^UTILITY(U,$J,358.3,116,1,5,0)
 ;;=5^Alc Abuse, Nos
 ;;^UTILITY(U,$J,358.3,116,2)
 ;;=^268227
 ;;^UTILITY(U,$J,358.3,117,0)
 ;;=305.03^^1^13^2
 ;;^UTILITY(U,$J,358.3,117,1,0)
 ;;=^358.31IA^5^2

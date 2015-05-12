IBDEI011 ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1027,2)
 ;;=^5003055
 ;;^UTILITY(U,$J,358.3,1028,0)
 ;;=F06.0^^3^34^5
 ;;^UTILITY(U,$J,358.3,1028,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1028,1,3,0)
 ;;=3^Psychotic Disorder w/ Hallucinations d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,1028,1,4,0)
 ;;=4^F06.0
 ;;^UTILITY(U,$J,358.3,1028,2)
 ;;=^5003053
 ;;^UTILITY(U,$J,358.3,1029,0)
 ;;=F06.4^^3^34^1
 ;;^UTILITY(U,$J,358.3,1029,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1029,1,3,0)
 ;;=3^Anxiety Disorder d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,1029,1,4,0)
 ;;=4^F06.4
 ;;^UTILITY(U,$J,358.3,1029,2)
 ;;=^5003061
 ;;^UTILITY(U,$J,358.3,1030,0)
 ;;=F06.1^^3^34^2
 ;;^UTILITY(U,$J,358.3,1030,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1030,1,3,0)
 ;;=3^Catatonia Associated w/ Schizophrenia
 ;;^UTILITY(U,$J,358.3,1030,1,4,0)
 ;;=4^F06.1
 ;;^UTILITY(U,$J,358.3,1030,2)
 ;;=^5003054
 ;;^UTILITY(U,$J,358.3,1031,0)
 ;;=R41.9^^3^34^6
 ;;^UTILITY(U,$J,358.3,1031,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1031,1,3,0)
 ;;=3^Unspec Neurocognitive Disorder
 ;;^UTILITY(U,$J,358.3,1031,1,4,0)
 ;;=4^R41.9
 ;;^UTILITY(U,$J,358.3,1031,2)
 ;;=^5019449
 ;;^UTILITY(U,$J,358.3,1032,0)
 ;;=F29.^^3^34^7
 ;;^UTILITY(U,$J,358.3,1032,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1032,1,3,0)
 ;;=3^Unspec Schizophrenia Spectrum & Oth Psychotic Disorder
 ;;^UTILITY(U,$J,358.3,1032,1,4,0)
 ;;=4^F29.
 ;;^UTILITY(U,$J,358.3,1032,2)
 ;;=^5003484
 ;;^UTILITY(U,$J,358.3,1033,0)
 ;;=F07.0^^3^34^3
 ;;^UTILITY(U,$J,358.3,1033,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1033,1,3,0)
 ;;=3^Personality Change d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,1033,1,4,0)
 ;;=4^F07.0
 ;;^UTILITY(U,$J,358.3,1033,2)
 ;;=^5003063
 ;;^UTILITY(U,$J,358.3,1034,0)
 ;;=Z91.49^^3^35^5
 ;;^UTILITY(U,$J,358.3,1034,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1034,1,3,0)
 ;;=3^Other Personal Hx of Psychological Trauma
 ;;^UTILITY(U,$J,358.3,1034,1,4,0)
 ;;=4^Z91.49
 ;;^UTILITY(U,$J,358.3,1034,2)
 ;;=^5063623
 ;;^UTILITY(U,$J,358.3,1035,0)
 ;;=Z91.5^^3^35^9
 ;;^UTILITY(U,$J,358.3,1035,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1035,1,3,0)
 ;;=3^Personal Hx of Self-Harm
 ;;^UTILITY(U,$J,358.3,1035,1,4,0)
 ;;=4^Z91.5
 ;;^UTILITY(U,$J,358.3,1035,2)
 ;;=^5063624
 ;;^UTILITY(U,$J,358.3,1036,0)
 ;;=Z91.82^^3^35^8
 ;;^UTILITY(U,$J,358.3,1036,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1036,1,3,0)
 ;;=3^Personal Hx of Military Deployment
 ;;^UTILITY(U,$J,358.3,1036,1,4,0)
 ;;=4^Z91.82
 ;;^UTILITY(U,$J,358.3,1036,2)
 ;;=^5063626
 ;;^UTILITY(U,$J,358.3,1037,0)
 ;;=Z91.89^^3^35^6
 ;;^UTILITY(U,$J,358.3,1037,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1037,1,3,0)
 ;;=3^Other Personal Risk Factors
 ;;^UTILITY(U,$J,358.3,1037,1,4,0)
 ;;=4^Z91.89
 ;;^UTILITY(U,$J,358.3,1037,2)
 ;;=^5063628
 ;;^UTILITY(U,$J,358.3,1038,0)
 ;;=Z72.9^^3^35^10
 ;;^UTILITY(U,$J,358.3,1038,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1038,1,3,0)
 ;;=3^Problem Related to Lifestyle
 ;;^UTILITY(U,$J,358.3,1038,1,4,0)
 ;;=4^Z72.9
 ;;^UTILITY(U,$J,358.3,1038,2)
 ;;=^5063267
 ;;^UTILITY(U,$J,358.3,1039,0)
 ;;=Z72.811^^3^35^1
 ;;^UTILITY(U,$J,358.3,1039,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1039,1,3,0)
 ;;=3^Adult Antisocial Behavior
 ;;^UTILITY(U,$J,358.3,1039,1,4,0)
 ;;=4^Z72.811
 ;;^UTILITY(U,$J,358.3,1039,2)
 ;;=^5063263
 ;;^UTILITY(U,$J,358.3,1040,0)
 ;;=Z91.19^^3^35^4
 ;;^UTILITY(U,$J,358.3,1040,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1040,1,3,0)
 ;;=3^Nonadherence to Medical Treatment
 ;;^UTILITY(U,$J,358.3,1040,1,4,0)
 ;;=4^Z91.19
 ;;^UTILITY(U,$J,358.3,1040,2)
 ;;=^5063618
 ;;^UTILITY(U,$J,358.3,1041,0)
 ;;=E66.9^^3^35^7
 ;;^UTILITY(U,$J,358.3,1041,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1041,1,3,0)
 ;;=3^Overweight or Obesity
 ;;^UTILITY(U,$J,358.3,1041,1,4,0)
 ;;=4^E66.9
 ;;^UTILITY(U,$J,358.3,1041,2)
 ;;=^5002832
 ;;^UTILITY(U,$J,358.3,1042,0)
 ;;=Z76.5^^3^35^3
 ;;^UTILITY(U,$J,358.3,1042,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1042,1,3,0)
 ;;=3^Malingering
 ;;^UTILITY(U,$J,358.3,1042,1,4,0)
 ;;=4^Z76.5
 ;;^UTILITY(U,$J,358.3,1042,2)
 ;;=^5063302
 ;;^UTILITY(U,$J,358.3,1043,0)
 ;;=R41.83^^3^35^2
 ;;^UTILITY(U,$J,358.3,1043,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1043,1,3,0)
 ;;=3^Borderline Intellectual Functioning
 ;;^UTILITY(U,$J,358.3,1043,1,4,0)
 ;;=4^R41.83
 ;;^UTILITY(U,$J,358.3,1043,2)
 ;;=^5019442
 ;;^UTILITY(U,$J,358.3,1044,0)
 ;;=F68.10^^3^36^4
 ;;^UTILITY(U,$J,358.3,1044,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1044,1,3,0)
 ;;=3^Factitious Disorder
 ;;^UTILITY(U,$J,358.3,1044,1,4,0)
 ;;=4^F68.10
 ;;^UTILITY(U,$J,358.3,1044,2)
 ;;=^5003663
 ;;^UTILITY(U,$J,358.3,1045,0)
 ;;=F63.0^^3^36^5
 ;;^UTILITY(U,$J,358.3,1045,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1045,1,3,0)
 ;;=3^Gambling Disorder
 ;;^UTILITY(U,$J,358.3,1045,1,4,0)
 ;;=4^F63.0
 ;;^UTILITY(U,$J,358.3,1045,2)
 ;;=^5003640
 ;;^UTILITY(U,$J,358.3,1046,0)
 ;;=F90.0^^3^36^1
 ;;^UTILITY(U,$J,358.3,1046,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1046,1,3,0)
 ;;=3^Attention-Deficit/Hyperactivity Disorder,Predominantly Inattentive Presentation
 ;;^UTILITY(U,$J,358.3,1046,1,4,0)
 ;;=4^F90.0
 ;;^UTILITY(U,$J,358.3,1046,2)
 ;;=^5003692
 ;;^UTILITY(U,$J,358.3,1047,0)
 ;;=F90.2^^3^36^2
 ;;^UTILITY(U,$J,358.3,1047,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1047,1,3,0)
 ;;=3^Attention-Deficit/Hyperactivity Disorder Combined Presentation
 ;;^UTILITY(U,$J,358.3,1047,1,4,0)
 ;;=4^F90.2
 ;;^UTILITY(U,$J,358.3,1047,2)
 ;;=^5003694
 ;;^UTILITY(U,$J,358.3,1048,0)
 ;;=F90.1^^3^36^3
 ;;^UTILITY(U,$J,358.3,1048,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1048,1,3,0)
 ;;=3^Attention-Deficit/Hyperactivity Disorder,Predominantly Hyperactive/Impulsive Presentation
 ;;^UTILITY(U,$J,358.3,1048,1,4,0)
 ;;=4^F90.1
 ;;^UTILITY(U,$J,358.3,1048,2)
 ;;=^5003693
 ;;^UTILITY(U,$J,358.3,1049,0)
 ;;=Z70.9^^3^37^2
 ;;^UTILITY(U,$J,358.3,1049,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1049,1,3,0)
 ;;=3^Sex Counseling
 ;;^UTILITY(U,$J,358.3,1049,1,4,0)
 ;;=4^Z70.9
 ;;^UTILITY(U,$J,358.3,1049,2)
 ;;=^5063241
 ;;^UTILITY(U,$J,358.3,1050,0)
 ;;=Z71.9^^3^37^1
 ;;^UTILITY(U,$J,358.3,1050,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1050,1,3,0)
 ;;=3^Other Counseling or Consultation
 ;;^UTILITY(U,$J,358.3,1050,1,4,0)
 ;;=4^Z71.9
 ;;^UTILITY(U,$J,358.3,1050,2)
 ;;=^5063254
 ;;^UTILITY(U,$J,358.3,1051,0)
 ;;=Z60.0^^3^38^2
 ;;^UTILITY(U,$J,358.3,1051,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1051,1,3,0)
 ;;=3^Phase of Life Problem
 ;;^UTILITY(U,$J,358.3,1051,1,4,0)
 ;;=4^Z60.0
 ;;^UTILITY(U,$J,358.3,1051,2)
 ;;=^5063139
 ;;^UTILITY(U,$J,358.3,1052,0)
 ;;=Z60.2^^3^38^3
 ;;^UTILITY(U,$J,358.3,1052,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1052,1,3,0)
 ;;=3^Problem Related to Living Alone
 ;;^UTILITY(U,$J,358.3,1052,1,4,0)
 ;;=4^Z60.2
 ;;^UTILITY(U,$J,358.3,1052,2)
 ;;=^5063140
 ;;^UTILITY(U,$J,358.3,1053,0)
 ;;=Z60.3^^3^38^1
 ;;^UTILITY(U,$J,358.3,1053,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1053,1,3,0)
 ;;=3^Acculturation Difficulty
 ;;^UTILITY(U,$J,358.3,1053,1,4,0)
 ;;=4^Z60.3
 ;;^UTILITY(U,$J,358.3,1053,2)
 ;;=^5063141
 ;;^UTILITY(U,$J,358.3,1054,0)
 ;;=Z60.4^^3^38^4
 ;;^UTILITY(U,$J,358.3,1054,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1054,1,3,0)
 ;;=3^Social Exclusion or Rejection
 ;;^UTILITY(U,$J,358.3,1054,1,4,0)
 ;;=4^Z60.4
 ;;^UTILITY(U,$J,358.3,1054,2)
 ;;=^5063142
 ;;^UTILITY(U,$J,358.3,1055,0)
 ;;=Z60.5^^3^38^5
 ;;^UTILITY(U,$J,358.3,1055,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1055,1,3,0)
 ;;=3^Target of (Perceived) Adverse Discrimination or Persecution
 ;;^UTILITY(U,$J,358.3,1055,1,4,0)
 ;;=4^Z60.5
 ;;^UTILITY(U,$J,358.3,1055,2)
 ;;=^5063143
 ;;^UTILITY(U,$J,358.3,1056,0)
 ;;=Z60.9^^3^38^6
 ;;^UTILITY(U,$J,358.3,1056,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1056,1,3,0)
 ;;=3^Unspec Problem Related to Social Environment
 ;;^UTILITY(U,$J,358.3,1056,1,4,0)
 ;;=4^Z60.9
 ;;^UTILITY(U,$J,358.3,1056,2)
 ;;=^5063145
 ;;^UTILITY(U,$J,358.3,1057,0)
 ;;=F65.4^^3^39^5
 ;;^UTILITY(U,$J,358.3,1057,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1057,1,3,0)
 ;;=3^Pedophilia Disorder
 ;;^UTILITY(U,$J,358.3,1057,1,4,0)
 ;;=4^F65.4
 ;;^UTILITY(U,$J,358.3,1057,2)
 ;;=^5003655
 ;;^UTILITY(U,$J,358.3,1058,0)
 ;;=F65.2^^3^39^1
 ;;^UTILITY(U,$J,358.3,1058,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1058,1,3,0)
 ;;=3^Exhibitionistic Disorder
 ;;^UTILITY(U,$J,358.3,1058,1,4,0)
 ;;=4^F65.2
 ;;^UTILITY(U,$J,358.3,1058,2)
 ;;=^5003653
 ;;^UTILITY(U,$J,358.3,1059,0)
 ;;=F65.3^^3^39^10
 ;;^UTILITY(U,$J,358.3,1059,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1059,1,3,0)
 ;;=3^Voyeuristic Disorder
 ;;^UTILITY(U,$J,358.3,1059,1,4,0)
 ;;=4^F65.3
 ;;^UTILITY(U,$J,358.3,1059,2)
 ;;=^5003654
 ;;^UTILITY(U,$J,358.3,1060,0)
 ;;=F65.81^^3^39^3
 ;;^UTILITY(U,$J,358.3,1060,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1060,1,3,0)
 ;;=3^Frotteuristic Disorder
 ;;^UTILITY(U,$J,358.3,1060,1,4,0)
 ;;=4^F65.81
 ;;^UTILITY(U,$J,358.3,1060,2)
 ;;=^5003659
 ;;^UTILITY(U,$J,358.3,1061,0)
 ;;=F65.51^^3^39^6
 ;;^UTILITY(U,$J,358.3,1061,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1061,1,3,0)
 ;;=3^Sexual Masochism Disorder
 ;;^UTILITY(U,$J,358.3,1061,1,4,0)
 ;;=4^F65.51
 ;;^UTILITY(U,$J,358.3,1061,2)
 ;;=^5003657
 ;;^UTILITY(U,$J,358.3,1062,0)
 ;;=F65.52^^3^39^7
 ;;^UTILITY(U,$J,358.3,1062,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1062,1,3,0)
 ;;=3^Sexual Sadism Disorder
 ;;^UTILITY(U,$J,358.3,1062,1,4,0)
 ;;=4^F65.52
 ;;^UTILITY(U,$J,358.3,1062,2)
 ;;=^5003658
 ;;^UTILITY(U,$J,358.3,1063,0)
 ;;=F65.0^^3^39^2
 ;;^UTILITY(U,$J,358.3,1063,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1063,1,3,0)
 ;;=3^Fetishistic Disorder
 ;;^UTILITY(U,$J,358.3,1063,1,4,0)
 ;;=4^F65.0
 ;;^UTILITY(U,$J,358.3,1063,2)
 ;;=^5003651
 ;;^UTILITY(U,$J,358.3,1064,0)
 ;;=F65.1^^3^39^8
 ;;^UTILITY(U,$J,358.3,1064,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1064,1,3,0)
 ;;=3^Transvestic Disorder

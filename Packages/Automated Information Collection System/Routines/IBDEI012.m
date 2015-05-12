IBDEI012 ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1064,1,4,0)
 ;;=4^F65.1
 ;;^UTILITY(U,$J,358.3,1064,2)
 ;;=^5003652
 ;;^UTILITY(U,$J,358.3,1065,0)
 ;;=F65.89^^3^39^4
 ;;^UTILITY(U,$J,358.3,1065,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1065,1,3,0)
 ;;=3^Other Spec Paraphilic Disorder
 ;;^UTILITY(U,$J,358.3,1065,1,4,0)
 ;;=4^F65.89
 ;;^UTILITY(U,$J,358.3,1065,2)
 ;;=^5003660
 ;;^UTILITY(U,$J,358.3,1066,0)
 ;;=F65.9^^3^39^9
 ;;^UTILITY(U,$J,358.3,1066,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1066,1,3,0)
 ;;=3^Unspec Paraphilic Disorder
 ;;^UTILITY(U,$J,358.3,1066,1,4,0)
 ;;=4^F65.9
 ;;^UTILITY(U,$J,358.3,1066,2)
 ;;=^5003661
 ;;^UTILITY(U,$J,358.3,1067,0)
 ;;=F60.0^^3^40^9
 ;;^UTILITY(U,$J,358.3,1067,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1067,1,3,0)
 ;;=3^Paranoid Personality Disorder
 ;;^UTILITY(U,$J,358.3,1067,1,4,0)
 ;;=4^F60.0
 ;;^UTILITY(U,$J,358.3,1067,2)
 ;;=^5003635
 ;;^UTILITY(U,$J,358.3,1068,0)
 ;;=F60.1^^3^40^10
 ;;^UTILITY(U,$J,358.3,1068,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1068,1,3,0)
 ;;=3^Schizoid Personality Disorder
 ;;^UTILITY(U,$J,358.3,1068,1,4,0)
 ;;=4^F60.1
 ;;^UTILITY(U,$J,358.3,1068,2)
 ;;=^108271
 ;;^UTILITY(U,$J,358.3,1069,0)
 ;;=F21.^^3^40^11
 ;;^UTILITY(U,$J,358.3,1069,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1069,1,3,0)
 ;;=3^Schizotypal Personality Disorder
 ;;^UTILITY(U,$J,358.3,1069,1,4,0)
 ;;=4^F21.
 ;;^UTILITY(U,$J,358.3,1069,2)
 ;;=^5003477
 ;;^UTILITY(U,$J,358.3,1070,0)
 ;;=F60.5^^3^40^7
 ;;^UTILITY(U,$J,358.3,1070,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1070,1,3,0)
 ;;=3^Obsessive-Compulsive Personality Disorder
 ;;^UTILITY(U,$J,358.3,1070,1,4,0)
 ;;=4^F60.5
 ;;^UTILITY(U,$J,358.3,1070,2)
 ;;=^331918
 ;;^UTILITY(U,$J,358.3,1071,0)
 ;;=F60.4^^3^40^5
 ;;^UTILITY(U,$J,358.3,1071,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1071,1,3,0)
 ;;=3^Histrionic Personality Disorder
 ;;^UTILITY(U,$J,358.3,1071,1,4,0)
 ;;=4^F60.4
 ;;^UTILITY(U,$J,358.3,1071,2)
 ;;=^5003636
 ;;^UTILITY(U,$J,358.3,1072,0)
 ;;=F60.7^^3^40^4
 ;;^UTILITY(U,$J,358.3,1072,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1072,1,3,0)
 ;;=3^Dependent Personality Disorder
 ;;^UTILITY(U,$J,358.3,1072,1,4,0)
 ;;=4^F60.7
 ;;^UTILITY(U,$J,358.3,1072,2)
 ;;=^5003637
 ;;^UTILITY(U,$J,358.3,1073,0)
 ;;=F60.2^^3^40^1
 ;;^UTILITY(U,$J,358.3,1073,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1073,1,3,0)
 ;;=3^Antisocial Personality Disorder
 ;;^UTILITY(U,$J,358.3,1073,1,4,0)
 ;;=4^F60.2
 ;;^UTILITY(U,$J,358.3,1073,2)
 ;;=^9066
 ;;^UTILITY(U,$J,358.3,1074,0)
 ;;=F60.81^^3^40^6
 ;;^UTILITY(U,$J,358.3,1074,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1074,1,3,0)
 ;;=3^Narcissistic Personality Disorder
 ;;^UTILITY(U,$J,358.3,1074,1,4,0)
 ;;=4^F60.81
 ;;^UTILITY(U,$J,358.3,1074,2)
 ;;=^331919
 ;;^UTILITY(U,$J,358.3,1075,0)
 ;;=F60.6^^3^40^2
 ;;^UTILITY(U,$J,358.3,1075,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1075,1,3,0)
 ;;=3^Avoidant Personality Disorder
 ;;^UTILITY(U,$J,358.3,1075,1,4,0)
 ;;=4^F60.6
 ;;^UTILITY(U,$J,358.3,1075,2)
 ;;=^331920
 ;;^UTILITY(U,$J,358.3,1076,0)
 ;;=F60.3^^3^40^3
 ;;^UTILITY(U,$J,358.3,1076,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1076,1,3,0)
 ;;=3^Boderline Personality Disorder
 ;;^UTILITY(U,$J,358.3,1076,1,4,0)
 ;;=4^F60.3
 ;;^UTILITY(U,$J,358.3,1076,2)
 ;;=^331921
 ;;^UTILITY(U,$J,358.3,1077,0)
 ;;=F60.89^^3^40^8
 ;;^UTILITY(U,$J,358.3,1077,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1077,1,3,0)
 ;;=3^Other Spec Personality Disorder
 ;;^UTILITY(U,$J,358.3,1077,1,4,0)
 ;;=4^F60.89
 ;;^UTILITY(U,$J,358.3,1077,2)
 ;;=^5003638
 ;;^UTILITY(U,$J,358.3,1078,0)
 ;;=F60.9^^3^40^12
 ;;^UTILITY(U,$J,358.3,1078,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1078,1,3,0)
 ;;=3^Unspec Personality Disorder
 ;;^UTILITY(U,$J,358.3,1078,1,4,0)
 ;;=4^F60.9
 ;;^UTILITY(U,$J,358.3,1078,2)
 ;;=^5003639
 ;;^UTILITY(U,$J,358.3,1079,0)
 ;;=Z65.4^^3^41^4
 ;;^UTILITY(U,$J,358.3,1079,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1079,1,3,0)
 ;;=3^Victim of Crime,Terrorism or Torture
 ;;^UTILITY(U,$J,358.3,1079,1,4,0)
 ;;=4^Z65.4
 ;;^UTILITY(U,$J,358.3,1079,2)
 ;;=^5063183
 ;;^UTILITY(U,$J,358.3,1080,0)
 ;;=Z65.0^^3^41^1
 ;;^UTILITY(U,$J,358.3,1080,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1080,1,3,0)
 ;;=3^Conviction in Civil/Criminal Proceedings w/o Imprisonment
 ;;^UTILITY(U,$J,358.3,1080,1,4,0)
 ;;=4^Z65.0
 ;;^UTILITY(U,$J,358.3,1080,2)
 ;;=^5063179
 ;;^UTILITY(U,$J,358.3,1081,0)
 ;;=Z65.2^^3^41^3
 ;;^UTILITY(U,$J,358.3,1081,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1081,1,3,0)
 ;;=3^Problems Related to Release from Prison
 ;;^UTILITY(U,$J,358.3,1081,1,4,0)
 ;;=4^Z65.2
 ;;^UTILITY(U,$J,358.3,1081,2)
 ;;=^5063181
 ;;^UTILITY(U,$J,358.3,1082,0)
 ;;=Z65.3^^3^41^2
 ;;^UTILITY(U,$J,358.3,1082,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1082,1,3,0)
 ;;=3^Problems Related to Oth Legal Circumstances
 ;;^UTILITY(U,$J,358.3,1082,1,4,0)
 ;;=4^Z65.3
 ;;^UTILITY(U,$J,358.3,1082,2)
 ;;=^5063182
 ;;^UTILITY(U,$J,358.3,1083,0)
 ;;=F70.^^3^42^1
 ;;^UTILITY(U,$J,358.3,1083,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1083,1,3,0)
 ;;=3^Intellectual Diability (Intellectual Developmental Disorder),Mild
 ;;^UTILITY(U,$J,358.3,1083,1,4,0)
 ;;=4^F70.
 ;;^UTILITY(U,$J,358.3,1083,2)
 ;;=^5003668
 ;;^UTILITY(U,$J,358.3,1084,0)
 ;;=Z65.8^^3^43^5
 ;;^UTILITY(U,$J,358.3,1084,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1084,1,3,0)
 ;;=3^Religious/Spiritual Problem;Oth Problem Related to Psychosocial Circumstances
 ;;^UTILITY(U,$J,358.3,1084,1,4,0)
 ;;=4^Z65.8
 ;;^UTILITY(U,$J,358.3,1084,2)
 ;;=^5063185
 ;;^UTILITY(U,$J,358.3,1085,0)
 ;;=Z64.0^^3^43^4
 ;;^UTILITY(U,$J,358.3,1085,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1085,1,3,0)
 ;;=3^Problems Related to Unwanted Pregnancy
 ;;^UTILITY(U,$J,358.3,1085,1,4,0)
 ;;=4^Z64.0
 ;;^UTILITY(U,$J,358.3,1085,2)
 ;;=^5063176
 ;;^UTILITY(U,$J,358.3,1086,0)
 ;;=Z64.1^^3^43^3
 ;;^UTILITY(U,$J,358.3,1086,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1086,1,3,0)
 ;;=3^Problems Related to Multiparity
 ;;^UTILITY(U,$J,358.3,1086,1,4,0)
 ;;=4^Z64.1
 ;;^UTILITY(U,$J,358.3,1086,2)
 ;;=^5063177
 ;;^UTILITY(U,$J,358.3,1087,0)
 ;;=Z64.4^^3^43^1
 ;;^UTILITY(U,$J,358.3,1087,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1087,1,3,0)
 ;;=3^Discord w/ Social Service Provider,Including Probation Officer,Case Manager,Social Worker
 ;;^UTILITY(U,$J,358.3,1087,1,4,0)
 ;;=4^Z64.4
 ;;^UTILITY(U,$J,358.3,1087,2)
 ;;=^5063178
 ;;^UTILITY(U,$J,358.3,1088,0)
 ;;=Z65.5^^3^43^2
 ;;^UTILITY(U,$J,358.3,1088,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1088,1,3,0)
 ;;=3^Exposure to Disaster,War or Other Hostilities
 ;;^UTILITY(U,$J,358.3,1088,1,4,0)
 ;;=4^Z65.5
 ;;^UTILITY(U,$J,358.3,1088,2)
 ;;=^5063184
 ;;^UTILITY(U,$J,358.3,1089,0)
 ;;=Z65.9^^3^43^6
 ;;^UTILITY(U,$J,358.3,1089,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1089,1,3,0)
 ;;=3^Unspec Problem Related to Unspec Psychosocial Circumstances
 ;;^UTILITY(U,$J,358.3,1089,1,4,0)
 ;;=4^Z65.9
 ;;^UTILITY(U,$J,358.3,1089,2)
 ;;=^5063186
 ;;^UTILITY(U,$J,358.3,1090,0)
 ;;=Z62.820^^3^44^4
 ;;^UTILITY(U,$J,358.3,1090,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1090,1,3,0)
 ;;=3^Parent-Child Relational Problem
 ;;^UTILITY(U,$J,358.3,1090,1,4,0)
 ;;=4^Z62.820
 ;;^UTILITY(U,$J,358.3,1090,2)
 ;;=^5063157
 ;;^UTILITY(U,$J,358.3,1091,0)
 ;;=Z62.891^^3^44^6
 ;;^UTILITY(U,$J,358.3,1091,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1091,1,3,0)
 ;;=3^Sibling Relational Problem
 ;;^UTILITY(U,$J,358.3,1091,1,4,0)
 ;;=4^Z62.891
 ;;^UTILITY(U,$J,358.3,1091,2)
 ;;=^5063161
 ;;^UTILITY(U,$J,358.3,1092,0)
 ;;=Z62.898^^3^44^1
 ;;^UTILITY(U,$J,358.3,1092,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1092,1,3,0)
 ;;=3^Child Affected by Parental Relationship Distress
 ;;^UTILITY(U,$J,358.3,1092,1,4,0)
 ;;=4^Z62.898
 ;;^UTILITY(U,$J,358.3,1092,2)
 ;;=^5063162
 ;;^UTILITY(U,$J,358.3,1093,0)
 ;;=Z63.0^^3^44^5
 ;;^UTILITY(U,$J,358.3,1093,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1093,1,3,0)
 ;;=3^Relationship Distress w/ Spouse/Partner
 ;;^UTILITY(U,$J,358.3,1093,1,4,0)
 ;;=4^Z63.0
 ;;^UTILITY(U,$J,358.3,1093,2)
 ;;=^5063164
 ;;^UTILITY(U,$J,358.3,1094,0)
 ;;=Z63.5^^3^44^2
 ;;^UTILITY(U,$J,358.3,1094,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1094,1,3,0)
 ;;=3^Disruption of Family by Separation or Divorce
 ;;^UTILITY(U,$J,358.3,1094,1,4,0)
 ;;=4^Z63.5
 ;;^UTILITY(U,$J,358.3,1094,2)
 ;;=^5063169
 ;;^UTILITY(U,$J,358.3,1095,0)
 ;;=Z63.8^^3^44^3
 ;;^UTILITY(U,$J,358.3,1095,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1095,1,3,0)
 ;;=3^High Exporessed Emotion Level w/in Family
 ;;^UTILITY(U,$J,358.3,1095,1,4,0)
 ;;=4^Z63.8
 ;;^UTILITY(U,$J,358.3,1095,2)
 ;;=^5063174
 ;;^UTILITY(U,$J,358.3,1096,0)
 ;;=Z63.4^^3^44^7
 ;;^UTILITY(U,$J,358.3,1096,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1096,1,3,0)
 ;;=3^Uncomplicated Bereavement
 ;;^UTILITY(U,$J,358.3,1096,1,4,0)
 ;;=4^Z63.4
 ;;^UTILITY(U,$J,358.3,1096,2)
 ;;=^5063168
 ;;^UTILITY(U,$J,358.3,1097,0)
 ;;=F20.9^^3^45^6
 ;;^UTILITY(U,$J,358.3,1097,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1097,1,3,0)
 ;;=3^Schizophrenia
 ;;^UTILITY(U,$J,358.3,1097,1,4,0)
 ;;=4^F20.9
 ;;^UTILITY(U,$J,358.3,1097,2)
 ;;=^5003476
 ;;^UTILITY(U,$J,358.3,1098,0)
 ;;=F20.81^^3^45^7
 ;;^UTILITY(U,$J,358.3,1098,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1098,1,3,0)
 ;;=3^Schizophreniform Disorder
 ;;^UTILITY(U,$J,358.3,1098,1,4,0)
 ;;=4^F20.81
 ;;^UTILITY(U,$J,358.3,1098,2)
 ;;=^5003474
 ;;^UTILITY(U,$J,358.3,1099,0)
 ;;=F22.^^3^45^2
 ;;^UTILITY(U,$J,358.3,1099,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1099,1,3,0)
 ;;=3^Delusional Disorder
 ;;^UTILITY(U,$J,358.3,1099,1,4,0)
 ;;=4^F22.
 ;;^UTILITY(U,$J,358.3,1099,2)
 ;;=^5003478
 ;;^UTILITY(U,$J,358.3,1100,0)
 ;;=F23.^^3^45^1
 ;;^UTILITY(U,$J,358.3,1100,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1100,1,3,0)
 ;;=3^Brief Psychotic Disorder
 ;;^UTILITY(U,$J,358.3,1100,1,4,0)
 ;;=4^F23.
 ;;^UTILITY(U,$J,358.3,1100,2)
 ;;=^5003479

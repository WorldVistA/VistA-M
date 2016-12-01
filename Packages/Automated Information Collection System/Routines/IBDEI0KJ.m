IBDEI0KJ ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25995,2)
 ;;=^5003636
 ;;^UTILITY(U,$J,358.3,25996,0)
 ;;=F60.7^^69^1076^4
 ;;^UTILITY(U,$J,358.3,25996,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25996,1,3,0)
 ;;=3^Dependent Personality Disorder
 ;;^UTILITY(U,$J,358.3,25996,1,4,0)
 ;;=4^F60.7
 ;;^UTILITY(U,$J,358.3,25996,2)
 ;;=^5003637
 ;;^UTILITY(U,$J,358.3,25997,0)
 ;;=F60.2^^69^1076^1
 ;;^UTILITY(U,$J,358.3,25997,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25997,1,3,0)
 ;;=3^Antisocial Personality Disorder
 ;;^UTILITY(U,$J,358.3,25997,1,4,0)
 ;;=4^F60.2
 ;;^UTILITY(U,$J,358.3,25997,2)
 ;;=^9066
 ;;^UTILITY(U,$J,358.3,25998,0)
 ;;=F60.81^^69^1076^6
 ;;^UTILITY(U,$J,358.3,25998,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25998,1,3,0)
 ;;=3^Narcissistic Personality Disorder
 ;;^UTILITY(U,$J,358.3,25998,1,4,0)
 ;;=4^F60.81
 ;;^UTILITY(U,$J,358.3,25998,2)
 ;;=^331919
 ;;^UTILITY(U,$J,358.3,25999,0)
 ;;=F60.6^^69^1076^2
 ;;^UTILITY(U,$J,358.3,25999,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25999,1,3,0)
 ;;=3^Avoidant Personality Disorder
 ;;^UTILITY(U,$J,358.3,25999,1,4,0)
 ;;=4^F60.6
 ;;^UTILITY(U,$J,358.3,25999,2)
 ;;=^331920
 ;;^UTILITY(U,$J,358.3,26000,0)
 ;;=F60.3^^69^1076^3
 ;;^UTILITY(U,$J,358.3,26000,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26000,1,3,0)
 ;;=3^Borderline Personality Disorder
 ;;^UTILITY(U,$J,358.3,26000,1,4,0)
 ;;=4^F60.3
 ;;^UTILITY(U,$J,358.3,26000,2)
 ;;=^331921
 ;;^UTILITY(U,$J,358.3,26001,0)
 ;;=F60.89^^69^1076^10
 ;;^UTILITY(U,$J,358.3,26001,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26001,1,3,0)
 ;;=3^Personality Disorder,Other
 ;;^UTILITY(U,$J,358.3,26001,1,4,0)
 ;;=4^F60.89
 ;;^UTILITY(U,$J,358.3,26001,2)
 ;;=^5003638
 ;;^UTILITY(U,$J,358.3,26002,0)
 ;;=F60.9^^69^1076^11
 ;;^UTILITY(U,$J,358.3,26002,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26002,1,3,0)
 ;;=3^Personality Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,26002,1,4,0)
 ;;=4^F60.9
 ;;^UTILITY(U,$J,358.3,26002,2)
 ;;=^5003639
 ;;^UTILITY(U,$J,358.3,26003,0)
 ;;=F07.0^^69^1076^9
 ;;^UTILITY(U,$J,358.3,26003,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26003,1,3,0)
 ;;=3^Personality Change d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,26003,1,4,0)
 ;;=4^F07.0
 ;;^UTILITY(U,$J,358.3,26003,2)
 ;;=^5003063
 ;;^UTILITY(U,$J,358.3,26004,0)
 ;;=Z65.4^^69^1077^5
 ;;^UTILITY(U,$J,358.3,26004,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26004,1,3,0)
 ;;=3^Victim of Crime
 ;;^UTILITY(U,$J,358.3,26004,1,4,0)
 ;;=4^Z65.4
 ;;^UTILITY(U,$J,358.3,26004,2)
 ;;=^5063183
 ;;^UTILITY(U,$J,358.3,26005,0)
 ;;=Z65.0^^69^1077^1
 ;;^UTILITY(U,$J,358.3,26005,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26005,1,3,0)
 ;;=3^Conviction in Civil/Criminal Proceedings w/o Imprisonment
 ;;^UTILITY(U,$J,358.3,26005,1,4,0)
 ;;=4^Z65.0
 ;;^UTILITY(U,$J,358.3,26005,2)
 ;;=^5063179
 ;;^UTILITY(U,$J,358.3,26006,0)
 ;;=Z65.2^^69^1077^4
 ;;^UTILITY(U,$J,358.3,26006,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26006,1,3,0)
 ;;=3^Problems Related to Release from Prison
 ;;^UTILITY(U,$J,358.3,26006,1,4,0)
 ;;=4^Z65.2
 ;;^UTILITY(U,$J,358.3,26006,2)
 ;;=^5063181
 ;;^UTILITY(U,$J,358.3,26007,0)
 ;;=Z65.3^^69^1077^3
 ;;^UTILITY(U,$J,358.3,26007,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26007,1,3,0)
 ;;=3^Problems Related to Other Legal Circumstances
 ;;^UTILITY(U,$J,358.3,26007,1,4,0)
 ;;=4^Z65.3
 ;;^UTILITY(U,$J,358.3,26007,2)
 ;;=^5063182
 ;;^UTILITY(U,$J,358.3,26008,0)
 ;;=Z65.1^^69^1077^2
 ;;^UTILITY(U,$J,358.3,26008,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26008,1,3,0)
 ;;=3^Imprisonment or Other Incarceration
 ;;^UTILITY(U,$J,358.3,26008,1,4,0)
 ;;=4^Z65.1
 ;;^UTILITY(U,$J,358.3,26008,2)
 ;;=^5063180
 ;;^UTILITY(U,$J,358.3,26009,0)
 ;;=Z65.8^^69^1078^7
 ;;^UTILITY(U,$J,358.3,26009,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26009,1,3,0)
 ;;=3^Religious/Spiritual Problem;Oth Problem Related to Psychosocial Circumstances
 ;;^UTILITY(U,$J,358.3,26009,1,4,0)
 ;;=4^Z65.8
 ;;^UTILITY(U,$J,358.3,26009,2)
 ;;=^5063185
 ;;^UTILITY(U,$J,358.3,26010,0)
 ;;=Z64.0^^69^1078^6
 ;;^UTILITY(U,$J,358.3,26010,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26010,1,3,0)
 ;;=3^Problems Related to Unwanted Pregnancy
 ;;^UTILITY(U,$J,358.3,26010,1,4,0)
 ;;=4^Z64.0
 ;;^UTILITY(U,$J,358.3,26010,2)
 ;;=^5063176
 ;;^UTILITY(U,$J,358.3,26011,0)
 ;;=Z64.1^^69^1078^4
 ;;^UTILITY(U,$J,358.3,26011,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26011,1,3,0)
 ;;=3^Problems Related to Multiparity
 ;;^UTILITY(U,$J,358.3,26011,1,4,0)
 ;;=4^Z64.1
 ;;^UTILITY(U,$J,358.3,26011,2)
 ;;=^5063177
 ;;^UTILITY(U,$J,358.3,26012,0)
 ;;=Z64.4^^69^1078^1
 ;;^UTILITY(U,$J,358.3,26012,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26012,1,3,0)
 ;;=3^Discord w/ Social Service Provider,Including Probation Officer,Case Manager,Social Worker
 ;;^UTILITY(U,$J,358.3,26012,1,4,0)
 ;;=4^Z64.4
 ;;^UTILITY(U,$J,358.3,26012,2)
 ;;=^5063178
 ;;^UTILITY(U,$J,358.3,26013,0)
 ;;=Z65.5^^69^1078^2
 ;;^UTILITY(U,$J,358.3,26013,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26013,1,3,0)
 ;;=3^Exposure to Disaster,War or Other Hostilities
 ;;^UTILITY(U,$J,358.3,26013,1,4,0)
 ;;=4^Z65.5
 ;;^UTILITY(U,$J,358.3,26013,2)
 ;;=^5063184
 ;;^UTILITY(U,$J,358.3,26014,0)
 ;;=Z65.8^^69^1078^5
 ;;^UTILITY(U,$J,358.3,26014,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26014,1,3,0)
 ;;=3^Problems Related to Psychosocial Circumstances,Other
 ;;^UTILITY(U,$J,358.3,26014,1,4,0)
 ;;=4^Z65.8
 ;;^UTILITY(U,$J,358.3,26014,2)
 ;;=^5063185
 ;;^UTILITY(U,$J,358.3,26015,0)
 ;;=Z65.9^^69^1078^3
 ;;^UTILITY(U,$J,358.3,26015,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26015,1,3,0)
 ;;=3^Problem Related to Psychosocial Circumstances,Unspec
 ;;^UTILITY(U,$J,358.3,26015,1,4,0)
 ;;=4^Z65.9
 ;;^UTILITY(U,$J,358.3,26015,2)
 ;;=^5063186
 ;;^UTILITY(U,$J,358.3,26016,0)
 ;;=Z65.4^^69^1078^8
 ;;^UTILITY(U,$J,358.3,26016,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26016,1,3,0)
 ;;=3^Victim of Terrorism or Torture
 ;;^UTILITY(U,$J,358.3,26016,1,4,0)
 ;;=4^Z65.4
 ;;^UTILITY(U,$J,358.3,26016,2)
 ;;=^5063183
 ;;^UTILITY(U,$J,358.3,26017,0)
 ;;=Z62.820^^69^1079^4
 ;;^UTILITY(U,$J,358.3,26017,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26017,1,3,0)
 ;;=3^Parent-Child Relational Problem
 ;;^UTILITY(U,$J,358.3,26017,1,4,0)
 ;;=4^Z62.820
 ;;^UTILITY(U,$J,358.3,26017,2)
 ;;=^5063157
 ;;^UTILITY(U,$J,358.3,26018,0)
 ;;=Z62.891^^69^1079^6
 ;;^UTILITY(U,$J,358.3,26018,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26018,1,3,0)
 ;;=3^Sibling Relational Problem
 ;;^UTILITY(U,$J,358.3,26018,1,4,0)
 ;;=4^Z62.891
 ;;^UTILITY(U,$J,358.3,26018,2)
 ;;=^5063161
 ;;^UTILITY(U,$J,358.3,26019,0)
 ;;=Z62.898^^69^1079^1
 ;;^UTILITY(U,$J,358.3,26019,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26019,1,3,0)
 ;;=3^Child Affected by Parental Relationship Distress
 ;;^UTILITY(U,$J,358.3,26019,1,4,0)
 ;;=4^Z62.898
 ;;^UTILITY(U,$J,358.3,26019,2)
 ;;=^5063162
 ;;^UTILITY(U,$J,358.3,26020,0)
 ;;=Z63.0^^69^1079^5
 ;;^UTILITY(U,$J,358.3,26020,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26020,1,3,0)
 ;;=3^Relationship Distress w/ Spouse/Partner
 ;;^UTILITY(U,$J,358.3,26020,1,4,0)
 ;;=4^Z63.0
 ;;^UTILITY(U,$J,358.3,26020,2)
 ;;=^5063164
 ;;^UTILITY(U,$J,358.3,26021,0)
 ;;=Z63.5^^69^1079^2
 ;;^UTILITY(U,$J,358.3,26021,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26021,1,3,0)
 ;;=3^Disruption of Family by Separation or Divorce
 ;;^UTILITY(U,$J,358.3,26021,1,4,0)
 ;;=4^Z63.5
 ;;^UTILITY(U,$J,358.3,26021,2)
 ;;=^5063169
 ;;^UTILITY(U,$J,358.3,26022,0)
 ;;=Z63.8^^69^1079^3
 ;;^UTILITY(U,$J,358.3,26022,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26022,1,3,0)
 ;;=3^High Expressed Emotion Level w/in Family
 ;;^UTILITY(U,$J,358.3,26022,1,4,0)
 ;;=4^Z63.8
 ;;^UTILITY(U,$J,358.3,26022,2)
 ;;=^5063174
 ;;^UTILITY(U,$J,358.3,26023,0)
 ;;=Z63.4^^69^1079^7
 ;;^UTILITY(U,$J,358.3,26023,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26023,1,3,0)
 ;;=3^Uncomplicated Bereavement
 ;;^UTILITY(U,$J,358.3,26023,1,4,0)
 ;;=4^Z63.4
 ;;^UTILITY(U,$J,358.3,26023,2)
 ;;=^5063168
 ;;^UTILITY(U,$J,358.3,26024,0)
 ;;=Z62.29^^69^1079^8
 ;;^UTILITY(U,$J,358.3,26024,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26024,1,3,0)
 ;;=3^Upbringing Away from Parents
 ;;^UTILITY(U,$J,358.3,26024,1,4,0)
 ;;=4^Z62.29
 ;;^UTILITY(U,$J,358.3,26024,2)
 ;;=^5063150
 ;;^UTILITY(U,$J,358.3,26025,0)
 ;;=F20.9^^69^1080^11
 ;;^UTILITY(U,$J,358.3,26025,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26025,1,3,0)
 ;;=3^Schizophrenia
 ;;^UTILITY(U,$J,358.3,26025,1,4,0)
 ;;=4^F20.9
 ;;^UTILITY(U,$J,358.3,26025,2)
 ;;=^5003476
 ;;^UTILITY(U,$J,358.3,26026,0)
 ;;=F20.81^^69^1080^14
 ;;^UTILITY(U,$J,358.3,26026,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26026,1,3,0)
 ;;=3^Schizophreniform Disorder
 ;;^UTILITY(U,$J,358.3,26026,1,4,0)
 ;;=4^F20.81
 ;;^UTILITY(U,$J,358.3,26026,2)
 ;;=^5003474
 ;;^UTILITY(U,$J,358.3,26027,0)
 ;;=F22.^^69^1080^5
 ;;^UTILITY(U,$J,358.3,26027,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26027,1,3,0)
 ;;=3^Delusional Disorder
 ;;^UTILITY(U,$J,358.3,26027,1,4,0)
 ;;=4^F22.
 ;;^UTILITY(U,$J,358.3,26027,2)
 ;;=^5003478
 ;;^UTILITY(U,$J,358.3,26028,0)
 ;;=F23.^^69^1080^1
 ;;^UTILITY(U,$J,358.3,26028,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26028,1,3,0)
 ;;=3^Brief Psychotic Disorder
 ;;^UTILITY(U,$J,358.3,26028,1,4,0)
 ;;=4^F23.
 ;;^UTILITY(U,$J,358.3,26028,2)
 ;;=^5003479
 ;;^UTILITY(U,$J,358.3,26029,0)
 ;;=F25.0^^69^1080^9
 ;;^UTILITY(U,$J,358.3,26029,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26029,1,3,0)
 ;;=3^Schizoaffective Disorder,Bipolar Type
 ;;^UTILITY(U,$J,358.3,26029,1,4,0)
 ;;=4^F25.0
 ;;^UTILITY(U,$J,358.3,26029,2)
 ;;=^5003480
 ;;^UTILITY(U,$J,358.3,26030,0)
 ;;=F25.1^^69^1080^10
 ;;^UTILITY(U,$J,358.3,26030,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26030,1,3,0)
 ;;=3^Schizoaffective Disorder,Depressive Type
 ;;^UTILITY(U,$J,358.3,26030,1,4,0)
 ;;=4^F25.1
 ;;^UTILITY(U,$J,358.3,26030,2)
 ;;=^5003481

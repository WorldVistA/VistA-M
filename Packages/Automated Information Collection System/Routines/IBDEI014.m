IBDEI014 ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1136,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,1137,0)
 ;;=F10.21^^3^48^3
 ;;^UTILITY(U,$J,358.3,1137,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1137,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,1137,1,4,0)
 ;;=4^F10.21
 ;;^UTILITY(U,$J,358.3,1137,2)
 ;;=^5003082
 ;;^UTILITY(U,$J,358.3,1138,0)
 ;;=F10.230^^3^48^4
 ;;^UTILITY(U,$J,358.3,1138,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1138,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,1138,1,4,0)
 ;;=4^F10.230
 ;;^UTILITY(U,$J,358.3,1138,2)
 ;;=^5003086
 ;;^UTILITY(U,$J,358.3,1139,0)
 ;;=F10.231^^3^48^5
 ;;^UTILITY(U,$J,358.3,1139,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1139,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe w/ Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,1139,1,4,0)
 ;;=4^F10.231
 ;;^UTILITY(U,$J,358.3,1139,2)
 ;;=^5003087
 ;;^UTILITY(U,$J,358.3,1140,0)
 ;;=F10.232^^3^48^6
 ;;^UTILITY(U,$J,358.3,1140,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1140,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe w/ Withdrawal Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,1140,1,4,0)
 ;;=4^F10.232
 ;;^UTILITY(U,$J,358.3,1140,2)
 ;;=^5003088
 ;;^UTILITY(U,$J,358.3,1141,0)
 ;;=F10.239^^3^48^7
 ;;^UTILITY(U,$J,358.3,1141,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1141,1,3,0)
 ;;=3^Alcohol Withdrawal w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,1141,1,4,0)
 ;;=4^F10.239
 ;;^UTILITY(U,$J,358.3,1141,2)
 ;;=^5003089
 ;;^UTILITY(U,$J,358.3,1142,0)
 ;;=F10.24^^3^48^9
 ;;^UTILITY(U,$J,358.3,1142,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1142,1,3,0)
 ;;=3^Alcohol-Induced Depressive & Related Disorder w/ Moderate-Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,1142,1,4,0)
 ;;=4^F10.24
 ;;^UTILITY(U,$J,358.3,1142,2)
 ;;=^5003090
 ;;^UTILITY(U,$J,358.3,1143,0)
 ;;=F10.29^^3^48^11
 ;;^UTILITY(U,$J,358.3,1143,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1143,1,3,0)
 ;;=3^Unspec Alcohol-Related Disorder
 ;;^UTILITY(U,$J,358.3,1143,1,4,0)
 ;;=4^F10.29
 ;;^UTILITY(U,$J,358.3,1143,2)
 ;;=^5003100
 ;;^UTILITY(U,$J,358.3,1144,0)
 ;;=F15.10^^3^49^4
 ;;^UTILITY(U,$J,358.3,1144,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1144,1,3,0)
 ;;=3^Amphetamine-Type Disorder,Mild
 ;;^UTILITY(U,$J,358.3,1144,1,4,0)
 ;;=4^F15.10
 ;;^UTILITY(U,$J,358.3,1144,2)
 ;;=^5003282
 ;;^UTILITY(U,$J,358.3,1145,0)
 ;;=F15.14^^3^49^2
 ;;^UTILITY(U,$J,358.3,1145,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1145,1,3,0)
 ;;=3^Amphetamine-Induced Depressive,Bipolar & Related Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,1145,1,4,0)
 ;;=4^F15.14
 ;;^UTILITY(U,$J,358.3,1145,2)
 ;;=^5003287
 ;;^UTILITY(U,$J,358.3,1146,0)
 ;;=F15.182^^3^49^3
 ;;^UTILITY(U,$J,358.3,1146,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1146,1,3,0)
 ;;=3^Amphetamine-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,1146,1,4,0)
 ;;=4^F15.182
 ;;^UTILITY(U,$J,358.3,1146,2)
 ;;=^5003293
 ;;^UTILITY(U,$J,358.3,1147,0)
 ;;=F15.20^^3^49^5
 ;;^UTILITY(U,$J,358.3,1147,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1147,1,3,0)
 ;;=3^Amphetamine-Type Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,1147,1,4,0)
 ;;=4^F15.20
 ;;^UTILITY(U,$J,358.3,1147,2)
 ;;=^5003295
 ;;^UTILITY(U,$J,358.3,1148,0)
 ;;=F15.21^^3^49^6
 ;;^UTILITY(U,$J,358.3,1148,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1148,1,3,0)
 ;;=3^Amphetamine-Type Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,1148,1,4,0)
 ;;=4^F15.21
 ;;^UTILITY(U,$J,358.3,1148,2)
 ;;=^5003296
 ;;^UTILITY(U,$J,358.3,1149,0)
 ;;=F15.23^^3^49^1
 ;;^UTILITY(U,$J,358.3,1149,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1149,1,3,0)
 ;;=3^Amphetamine or Other Stimulant Withdrawal
 ;;^UTILITY(U,$J,358.3,1149,1,4,0)
 ;;=4^F15.23
 ;;^UTILITY(U,$J,358.3,1149,2)
 ;;=^5003301
 ;;^UTILITY(U,$J,358.3,1150,0)
 ;;=F12.10^^3^50^1
 ;;^UTILITY(U,$J,358.3,1150,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1150,1,3,0)
 ;;=3^Cannabis Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,1150,1,4,0)
 ;;=4^F12.10
 ;;^UTILITY(U,$J,358.3,1150,2)
 ;;=^5003155
 ;;^UTILITY(U,$J,358.3,1151,0)
 ;;=F12.180^^3^50^2
 ;;^UTILITY(U,$J,358.3,1151,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1151,1,3,0)
 ;;=3^Cannabis-Induced Anxiety Disorder w/ Mild Use Disorders
 ;;^UTILITY(U,$J,358.3,1151,1,4,0)
 ;;=4^F12.180
 ;;^UTILITY(U,$J,358.3,1151,2)
 ;;=^5003163
 ;;^UTILITY(U,$J,358.3,1152,0)
 ;;=F12.188^^3^50^3
 ;;^UTILITY(U,$J,358.3,1152,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1152,1,3,0)
 ;;=3^Cannabis-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,1152,1,4,0)
 ;;=4^F12.188
 ;;^UTILITY(U,$J,358.3,1152,2)
 ;;=^5003164
 ;;^UTILITY(U,$J,358.3,1153,0)
 ;;=F12.20^^3^50^4
 ;;^UTILITY(U,$J,358.3,1153,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1153,1,3,0)
 ;;=3^Cannabis Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,1153,1,4,0)
 ;;=4^F12.20
 ;;^UTILITY(U,$J,358.3,1153,2)
 ;;=^5003166
 ;;^UTILITY(U,$J,358.3,1154,0)
 ;;=F12.21^^3^50^5
 ;;^UTILITY(U,$J,358.3,1154,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1154,1,3,0)
 ;;=3^Cannabis Use Disorder,Moderate-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,1154,1,4,0)
 ;;=4^F12.21
 ;;^UTILITY(U,$J,358.3,1154,2)
 ;;=^5003167
 ;;^UTILITY(U,$J,358.3,1155,0)
 ;;=F12.288^^3^50^6
 ;;^UTILITY(U,$J,358.3,1155,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1155,1,3,0)
 ;;=3^Cannabis Withdrawal
 ;;^UTILITY(U,$J,358.3,1155,1,4,0)
 ;;=4^F12.288
 ;;^UTILITY(U,$J,358.3,1155,2)
 ;;=^5003176
 ;;^UTILITY(U,$J,358.3,1156,0)
 ;;=F12.280^^3^50^7
 ;;^UTILITY(U,$J,358.3,1156,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1156,1,3,0)
 ;;=3^Cannabis-Induced Anxiety Disorder w/ Moderate-Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,1156,1,4,0)
 ;;=4^F12.280
 ;;^UTILITY(U,$J,358.3,1156,2)
 ;;=^5003175
 ;;^UTILITY(U,$J,358.3,1157,0)
 ;;=F16.10^^3^51^1
 ;;^UTILITY(U,$J,358.3,1157,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1157,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,1157,1,4,0)
 ;;=4^F16.10
 ;;^UTILITY(U,$J,358.3,1157,2)
 ;;=^5003323
 ;;^UTILITY(U,$J,358.3,1158,0)
 ;;=F16.20^^3^51^2
 ;;^UTILITY(U,$J,358.3,1158,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1158,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,1158,1,4,0)
 ;;=4^F16.20
 ;;^UTILITY(U,$J,358.3,1158,2)
 ;;=^5003336
 ;;^UTILITY(U,$J,358.3,1159,0)
 ;;=F16.21^^3^51^3
 ;;^UTILITY(U,$J,358.3,1159,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1159,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Moderate-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,1159,1,4,0)
 ;;=4^F16.21
 ;;^UTILITY(U,$J,358.3,1159,2)
 ;;=^5003337
 ;;^UTILITY(U,$J,358.3,1160,0)
 ;;=F11.10^^3^52^3
 ;;^UTILITY(U,$J,358.3,1160,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1160,1,3,0)
 ;;=3^Opioid Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,1160,1,4,0)
 ;;=4^F11.10
 ;;^UTILITY(U,$J,358.3,1160,2)
 ;;=^5003114
 ;;^UTILITY(U,$J,358.3,1161,0)
 ;;=F11.129^^3^52^2
 ;;^UTILITY(U,$J,358.3,1161,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1161,1,3,0)
 ;;=3^Opioid Intoxication w/o Perceptual Disturbances;Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,1161,1,4,0)
 ;;=4^F11.129
 ;;^UTILITY(U,$J,358.3,1161,2)
 ;;=^5003118
 ;;^UTILITY(U,$J,358.3,1162,0)
 ;;=F11.14^^3^52^7
 ;;^UTILITY(U,$J,358.3,1162,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1162,1,3,0)
 ;;=3^Opioid-Induced Depressive Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,1162,1,4,0)
 ;;=4^F11.14
 ;;^UTILITY(U,$J,358.3,1162,2)
 ;;=^5003119
 ;;^UTILITY(U,$J,358.3,1163,0)
 ;;=F11.182^^3^52^9
 ;;^UTILITY(U,$J,358.3,1163,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1163,1,3,0)
 ;;=3^Opioid-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,1163,1,4,0)
 ;;=4^F11.182
 ;;^UTILITY(U,$J,358.3,1163,2)
 ;;=^5003124
 ;;^UTILITY(U,$J,358.3,1164,0)
 ;;=F11.20^^3^52^4
 ;;^UTILITY(U,$J,358.3,1164,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1164,1,3,0)
 ;;=3^Opioid Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,1164,1,4,0)
 ;;=4^F11.20
 ;;^UTILITY(U,$J,358.3,1164,2)
 ;;=^5003127
 ;;^UTILITY(U,$J,358.3,1165,0)
 ;;=F11.21^^3^52^5
 ;;^UTILITY(U,$J,358.3,1165,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1165,1,3,0)
 ;;=3^Opioid Use Disorder,Moderate-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,1165,1,4,0)
 ;;=4^F11.21
 ;;^UTILITY(U,$J,358.3,1165,2)
 ;;=^5003128
 ;;^UTILITY(U,$J,358.3,1166,0)
 ;;=F11.23^^3^52^6
 ;;^UTILITY(U,$J,358.3,1166,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1166,1,3,0)
 ;;=3^Opioid Withdrawal
 ;;^UTILITY(U,$J,358.3,1166,1,4,0)
 ;;=4^F11.23
 ;;^UTILITY(U,$J,358.3,1166,2)
 ;;=^5003133
 ;;^UTILITY(U,$J,358.3,1167,0)
 ;;=F11.24^^3^52^8
 ;;^UTILITY(U,$J,358.3,1167,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1167,1,3,0)
 ;;=3^Opioid-Induced Depressive Disorder w/ Moderate-Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,1167,1,4,0)
 ;;=4^F11.24
 ;;^UTILITY(U,$J,358.3,1167,2)
 ;;=^5003134
 ;;^UTILITY(U,$J,358.3,1168,0)
 ;;=F11.29^^3^52^1
 ;;^UTILITY(U,$J,358.3,1168,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1168,1,3,0)
 ;;=3^Opioid Dependence w/ Unspec Opioid-Induced Disorder
 ;;^UTILITY(U,$J,358.3,1168,1,4,0)
 ;;=4^F11.29
 ;;^UTILITY(U,$J,358.3,1168,2)
 ;;=^5003141
 ;;^UTILITY(U,$J,358.3,1169,0)
 ;;=F19.10^^3^53^1
 ;;^UTILITY(U,$J,358.3,1169,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1169,1,3,0)
 ;;=3^Other Substance Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,1169,1,4,0)
 ;;=4^F19.10
 ;;^UTILITY(U,$J,358.3,1169,2)
 ;;=^5003416
 ;;^UTILITY(U,$J,358.3,1170,0)
 ;;=F19.14^^3^53^2
 ;;^UTILITY(U,$J,358.3,1170,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1170,1,3,0)
 ;;=3^Other Substance-Induced Depressive,Bipolar & Related Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,1170,1,4,0)
 ;;=4^F19.14
 ;;^UTILITY(U,$J,358.3,1170,2)
 ;;=^5003421
 ;;^UTILITY(U,$J,358.3,1171,0)
 ;;=F19.182^^3^53^3
 ;;^UTILITY(U,$J,358.3,1171,1,0)
 ;;=^358.31IA^4^2

IBDEI015 ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1171,1,3,0)
 ;;=3^Other Substance-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,1171,1,4,0)
 ;;=4^F19.182
 ;;^UTILITY(U,$J,358.3,1171,2)
 ;;=^5003429
 ;;^UTILITY(U,$J,358.3,1172,0)
 ;;=F19.20^^3^53^4
 ;;^UTILITY(U,$J,358.3,1172,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1172,1,3,0)
 ;;=3^Other Substance Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,1172,1,4,0)
 ;;=4^F19.20
 ;;^UTILITY(U,$J,358.3,1172,2)
 ;;=^5003431
 ;;^UTILITY(U,$J,358.3,1173,0)
 ;;=F19.21^^3^53^5
 ;;^UTILITY(U,$J,358.3,1173,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1173,1,3,0)
 ;;=3^Other Substance Use Disorder,Moderate-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,1173,1,4,0)
 ;;=4^F19.21
 ;;^UTILITY(U,$J,358.3,1173,2)
 ;;=^5003432
 ;;^UTILITY(U,$J,358.3,1174,0)
 ;;=F19.24^^3^53^6
 ;;^UTILITY(U,$J,358.3,1174,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1174,1,3,0)
 ;;=3^Other Substance-Induced Depressive,Bipolar & Related Disorder w/ Moderate-Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,1174,1,4,0)
 ;;=4^F19.24
 ;;^UTILITY(U,$J,358.3,1174,2)
 ;;=^5003441
 ;;^UTILITY(U,$J,358.3,1175,0)
 ;;=F13.10^^3^54^1
 ;;^UTILITY(U,$J,358.3,1175,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1175,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,1175,1,4,0)
 ;;=4^F13.10
 ;;^UTILITY(U,$J,358.3,1175,2)
 ;;=^5003189
 ;;^UTILITY(U,$J,358.3,1176,0)
 ;;=F13.14^^3^54^7
 ;;^UTILITY(U,$J,358.3,1176,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1176,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic-Induced Depressive,Bipolar or Related Disorder w/ Mild use Disorder
 ;;^UTILITY(U,$J,358.3,1176,1,4,0)
 ;;=4^F13.14
 ;;^UTILITY(U,$J,358.3,1176,2)
 ;;=^5003193
 ;;^UTILITY(U,$J,358.3,1177,0)
 ;;=F13.182^^3^54^8
 ;;^UTILITY(U,$J,358.3,1177,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1177,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,1177,1,4,0)
 ;;=4^F13.182
 ;;^UTILITY(U,$J,358.3,1177,2)
 ;;=^5003199
 ;;^UTILITY(U,$J,358.3,1178,0)
 ;;=F13.20^^3^54^2
 ;;^UTILITY(U,$J,358.3,1178,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1178,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,1178,1,4,0)
 ;;=4^F13.20
 ;;^UTILITY(U,$J,358.3,1178,2)
 ;;=^5003202
 ;;^UTILITY(U,$J,358.3,1179,0)
 ;;=F13.21^^3^54^3
 ;;^UTILITY(U,$J,358.3,1179,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1179,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Use Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,1179,1,4,0)
 ;;=4^F13.21
 ;;^UTILITY(U,$J,358.3,1179,2)
 ;;=^331934
 ;;^UTILITY(U,$J,358.3,1180,0)
 ;;=F13.232^^3^54^4
 ;;^UTILITY(U,$J,358.3,1180,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1180,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Withdrawal w/ Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,1180,1,4,0)
 ;;=4^F13.232
 ;;^UTILITY(U,$J,358.3,1180,2)
 ;;=^5003208
 ;;^UTILITY(U,$J,358.3,1181,0)
 ;;=F13.239^^3^54^5
 ;;^UTILITY(U,$J,358.3,1181,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1181,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Withdrawal w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,1181,1,4,0)
 ;;=4^F13.239
 ;;^UTILITY(U,$J,358.3,1181,2)
 ;;=^5003209
 ;;^UTILITY(U,$J,358.3,1182,0)
 ;;=F13.24^^3^54^9
 ;;^UTILITY(U,$J,358.3,1182,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1182,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic-Induced Dep,Bip or Related Disorder w/ Mod-Sev Use Disorder
 ;;^UTILITY(U,$J,358.3,1182,1,4,0)
 ;;=4^F13.24
 ;;^UTILITY(U,$J,358.3,1182,2)
 ;;=^5003210
 ;;^UTILITY(U,$J,358.3,1183,0)
 ;;=F13.231^^3^54^6
 ;;^UTILITY(U,$J,358.3,1183,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1183,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,1183,1,4,0)
 ;;=4^F13.231
 ;;^UTILITY(U,$J,358.3,1183,2)
 ;;=^5003207
 ;;^UTILITY(U,$J,358.3,1184,0)
 ;;=F17.200^^3^55^1
 ;;^UTILITY(U,$J,358.3,1184,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1184,1,3,0)
 ;;=3^Tobacco Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,1184,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,1184,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,1185,0)
 ;;=F17.201^^3^55^2
 ;;^UTILITY(U,$J,358.3,1185,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1185,1,3,0)
 ;;=3^Tobacco Use Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,1185,1,4,0)
 ;;=4^F17.201
 ;;^UTILITY(U,$J,358.3,1185,2)
 ;;=^5003361
 ;;^UTILITY(U,$J,358.3,1186,0)
 ;;=F17.203^^3^55^3
 ;;^UTILITY(U,$J,358.3,1186,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1186,1,3,0)
 ;;=3^Tobacco Withdrawal
 ;;^UTILITY(U,$J,358.3,1186,1,4,0)
 ;;=4^F17.203
 ;;^UTILITY(U,$J,358.3,1186,2)
 ;;=^5003362
 ;;^UTILITY(U,$J,358.3,1187,0)
 ;;=F17.210^^3^55^4
 ;;^UTILITY(U,$J,358.3,1187,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1187,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes,Uncomplicated
 ;;^UTILITY(U,$J,358.3,1187,1,4,0)
 ;;=4^F17.210
 ;;^UTILITY(U,$J,358.3,1187,2)
 ;;=^5003365
 ;;^UTILITY(U,$J,358.3,1188,0)
 ;;=F17.211^^3^55^5
 ;;^UTILITY(U,$J,358.3,1188,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1188,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes,In Remission
 ;;^UTILITY(U,$J,358.3,1188,1,4,0)
 ;;=4^F17.211
 ;;^UTILITY(U,$J,358.3,1188,2)
 ;;=^5003366
 ;;^UTILITY(U,$J,358.3,1189,0)
 ;;=F17.220^^3^55^6
 ;;^UTILITY(U,$J,358.3,1189,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1189,1,3,0)
 ;;=3^Nicotine Dependence,Chewing Tobacco,Uncomplicated
 ;;^UTILITY(U,$J,358.3,1189,1,4,0)
 ;;=4^F17.220
 ;;^UTILITY(U,$J,358.3,1189,2)
 ;;=^5003370
 ;;^UTILITY(U,$J,358.3,1190,0)
 ;;=F17.221^^3^55^7
 ;;^UTILITY(U,$J,358.3,1190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1190,1,3,0)
 ;;=3^Nicotine Dependence,Chewing Tobacco,In Remission
 ;;^UTILITY(U,$J,358.3,1190,1,4,0)
 ;;=4^F17.221
 ;;^UTILITY(U,$J,358.3,1190,2)
 ;;=^5003371
 ;;^UTILITY(U,$J,358.3,1191,0)
 ;;=F17.290^^3^55^8
 ;;^UTILITY(U,$J,358.3,1191,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1191,1,3,0)
 ;;=3^Nicotine Dependence,Oth Tobacco Product,Uncomplicated
 ;;^UTILITY(U,$J,358.3,1191,1,4,0)
 ;;=4^F17.290
 ;;^UTILITY(U,$J,358.3,1191,2)
 ;;=^5003375
 ;;^UTILITY(U,$J,358.3,1192,0)
 ;;=F17.291^^3^55^9
 ;;^UTILITY(U,$J,358.3,1192,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1192,1,3,0)
 ;;=3^Nicotine Dependence,Oth Tobacco Product,In Remission
 ;;^UTILITY(U,$J,358.3,1192,1,4,0)
 ;;=4^F17.291
 ;;^UTILITY(U,$J,358.3,1192,2)
 ;;=^5003376
 ;;^UTILITY(U,$J,358.3,1193,0)
 ;;=F14.10^^3^56^1
 ;;^UTILITY(U,$J,358.3,1193,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1193,1,3,0)
 ;;=3^Cocaine Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,1193,1,4,0)
 ;;=4^F14.10
 ;;^UTILITY(U,$J,358.3,1193,2)
 ;;=^5003239
 ;;^UTILITY(U,$J,358.3,1194,0)
 ;;=F14.14^^3^56^5
 ;;^UTILITY(U,$J,358.3,1194,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1194,1,3,0)
 ;;=3^Cocaine-Induced Depressive,Bipolar or Related Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,1194,1,4,0)
 ;;=4^F14.14
 ;;^UTILITY(U,$J,358.3,1194,2)
 ;;=^5003244
 ;;^UTILITY(U,$J,358.3,1195,0)
 ;;=F14.182^^3^56^6
 ;;^UTILITY(U,$J,358.3,1195,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1195,1,3,0)
 ;;=3^Cocaine-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,1195,1,4,0)
 ;;=4^F14.182
 ;;^UTILITY(U,$J,358.3,1195,2)
 ;;=^5003250
 ;;^UTILITY(U,$J,358.3,1196,0)
 ;;=F14.20^^3^56^3
 ;;^UTILITY(U,$J,358.3,1196,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1196,1,3,0)
 ;;=3^Cocaine Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,1196,1,4,0)
 ;;=4^F14.20
 ;;^UTILITY(U,$J,358.3,1196,2)
 ;;=^5003253
 ;;^UTILITY(U,$J,358.3,1197,0)
 ;;=F14.21^^3^56^2
 ;;^UTILITY(U,$J,358.3,1197,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1197,1,3,0)
 ;;=3^Cocaine Use Disorder,Mod-Sev,In Remission
 ;;^UTILITY(U,$J,358.3,1197,1,4,0)
 ;;=4^F14.21
 ;;^UTILITY(U,$J,358.3,1197,2)
 ;;=^5003254
 ;;^UTILITY(U,$J,358.3,1198,0)
 ;;=F14.23^^3^56^4
 ;;^UTILITY(U,$J,358.3,1198,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1198,1,3,0)
 ;;=3^Cocaine Withdrawal
 ;;^UTILITY(U,$J,358.3,1198,1,4,0)
 ;;=4^F14.23
 ;;^UTILITY(U,$J,358.3,1198,2)
 ;;=^5003259
 ;;^UTILITY(U,$J,358.3,1199,0)
 ;;=F43.0^^3^57^1
 ;;^UTILITY(U,$J,358.3,1199,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1199,1,3,0)
 ;;=3^Acute Stress Disorder
 ;;^UTILITY(U,$J,358.3,1199,1,4,0)
 ;;=4^F43.0
 ;;^UTILITY(U,$J,358.3,1199,2)
 ;;=^5003569
 ;;^UTILITY(U,$J,358.3,1200,0)
 ;;=F43.21^^3^57^3
 ;;^UTILITY(U,$J,358.3,1200,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1200,1,3,0)
 ;;=3^Adjustment Disorder w/ Depressed Mood
 ;;^UTILITY(U,$J,358.3,1200,1,4,0)
 ;;=4^F43.21
 ;;^UTILITY(U,$J,358.3,1200,2)
 ;;=^331948
 ;;^UTILITY(U,$J,358.3,1201,0)
 ;;=F43.22^^3^57^2
 ;;^UTILITY(U,$J,358.3,1201,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1201,1,3,0)
 ;;=3^Adjustment Disorder w/ Anxiety
 ;;^UTILITY(U,$J,358.3,1201,1,4,0)
 ;;=4^F43.22
 ;;^UTILITY(U,$J,358.3,1201,2)
 ;;=^331949
 ;;^UTILITY(U,$J,358.3,1202,0)
 ;;=F43.23^^3^57^5
 ;;^UTILITY(U,$J,358.3,1202,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1202,1,3,0)
 ;;=3^Adjustment Disorder w/ Mixed Anxiety & Depressed Mood
 ;;^UTILITY(U,$J,358.3,1202,1,4,0)
 ;;=4^F43.23
 ;;^UTILITY(U,$J,358.3,1202,2)
 ;;=^331950
 ;;^UTILITY(U,$J,358.3,1203,0)
 ;;=F43.24^^3^57^4
 ;;^UTILITY(U,$J,358.3,1203,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1203,1,3,0)
 ;;=3^Adjustment Disorder w/ Disturbance of Conduct
 ;;^UTILITY(U,$J,358.3,1203,1,4,0)
 ;;=4^F43.24
 ;;^UTILITY(U,$J,358.3,1203,2)
 ;;=^331951
 ;;^UTILITY(U,$J,358.3,1204,0)
 ;;=F43.25^^3^57^6
 ;;^UTILITY(U,$J,358.3,1204,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1204,1,3,0)
 ;;=3^Adjustment Disorder w/ Mixed Disturbance Emotions & Conduct
 ;;^UTILITY(U,$J,358.3,1204,1,4,0)
 ;;=4^F43.25
 ;;^UTILITY(U,$J,358.3,1204,2)
 ;;=^331952
 ;;^UTILITY(U,$J,358.3,1205,0)
 ;;=F43.10^^3^57^9
 ;;^UTILITY(U,$J,358.3,1205,1,0)
 ;;=^358.31IA^4^2

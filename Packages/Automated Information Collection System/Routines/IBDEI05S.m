IBDEI05S ; ; 01-AUG-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;AUG 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,13981,0)
 ;;=F12.10^^53^593^3
 ;;^UTILITY(U,$J,358.3,13981,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13981,1,3,0)
 ;;=3^Cannabis Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,13981,1,4,0)
 ;;=4^F12.10
 ;;^UTILITY(U,$J,358.3,13981,2)
 ;;=^5003155
 ;;^UTILITY(U,$J,358.3,13982,0)
 ;;=F12.180^^53^593^8
 ;;^UTILITY(U,$J,358.3,13982,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13982,1,3,0)
 ;;=3^Cannabis-Induced Anxiety Disorder w/ Mild Use Disorders
 ;;^UTILITY(U,$J,358.3,13982,1,4,0)
 ;;=4^F12.180
 ;;^UTILITY(U,$J,358.3,13982,2)
 ;;=^5003163
 ;;^UTILITY(U,$J,358.3,13983,0)
 ;;=F12.188^^53^593^10
 ;;^UTILITY(U,$J,358.3,13983,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13983,1,3,0)
 ;;=3^Cannabis-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,13983,1,4,0)
 ;;=4^F12.188
 ;;^UTILITY(U,$J,358.3,13983,2)
 ;;=^5003164
 ;;^UTILITY(U,$J,358.3,13984,0)
 ;;=F12.20^^53^593^4
 ;;^UTILITY(U,$J,358.3,13984,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13984,1,3,0)
 ;;=3^Cannabis Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,13984,1,4,0)
 ;;=4^F12.20
 ;;^UTILITY(U,$J,358.3,13984,2)
 ;;=^5003166
 ;;^UTILITY(U,$J,358.3,13985,0)
 ;;=F12.21^^53^593^5
 ;;^UTILITY(U,$J,358.3,13985,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13985,1,3,0)
 ;;=3^Cannabis Use Disorder,Moderate-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,13985,1,4,0)
 ;;=4^F12.21
 ;;^UTILITY(U,$J,358.3,13985,2)
 ;;=^5003167
 ;;^UTILITY(U,$J,358.3,13986,0)
 ;;=F12.288^^53^593^7
 ;;^UTILITY(U,$J,358.3,13986,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13986,1,3,0)
 ;;=3^Cannabis Withdrawal
 ;;^UTILITY(U,$J,358.3,13986,1,4,0)
 ;;=4^F12.288
 ;;^UTILITY(U,$J,358.3,13986,2)
 ;;=^5003176
 ;;^UTILITY(U,$J,358.3,13987,0)
 ;;=F12.280^^53^593^9
 ;;^UTILITY(U,$J,358.3,13987,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13987,1,3,0)
 ;;=3^Cannabis-Induced Anxiety Disorder w/ Moderate-Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,13987,1,4,0)
 ;;=4^F12.280
 ;;^UTILITY(U,$J,358.3,13987,2)
 ;;=^5003175
 ;;^UTILITY(U,$J,358.3,13988,0)
 ;;=F12.11^^53^593^1
 ;;^UTILITY(U,$J,358.3,13988,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13988,1,3,0)
 ;;=3^Cannabis Abuse,In Remission
 ;;^UTILITY(U,$J,358.3,13988,1,4,0)
 ;;=4^F12.11
 ;;^UTILITY(U,$J,358.3,13988,2)
 ;;=^268236
 ;;^UTILITY(U,$J,358.3,13989,0)
 ;;=F12.23^^53^593^2
 ;;^UTILITY(U,$J,358.3,13989,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13989,1,3,0)
 ;;=3^Cannabis Dependence w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,13989,1,4,0)
 ;;=4^F12.23
 ;;^UTILITY(U,$J,358.3,13989,2)
 ;;=^5157301
 ;;^UTILITY(U,$J,358.3,13990,0)
 ;;=F12.93^^53^593^6
 ;;^UTILITY(U,$J,358.3,13990,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13990,1,3,0)
 ;;=3^Cannabis Use,Unspec w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,13990,1,4,0)
 ;;=4^F12.93
 ;;^UTILITY(U,$J,358.3,13990,2)
 ;;=^5157302
 ;;^UTILITY(U,$J,358.3,13991,0)
 ;;=F14.10^^53^594^2
 ;;^UTILITY(U,$J,358.3,13991,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13991,1,3,0)
 ;;=3^Cocaine Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,13991,1,4,0)
 ;;=4^F14.10
 ;;^UTILITY(U,$J,358.3,13991,2)
 ;;=^5003239
 ;;^UTILITY(U,$J,358.3,13992,0)
 ;;=F14.14^^53^594^6
 ;;^UTILITY(U,$J,358.3,13992,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13992,1,3,0)
 ;;=3^Cocaine-Induced Depressive,Bipolar or Related Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,13992,1,4,0)
 ;;=4^F14.14
 ;;^UTILITY(U,$J,358.3,13992,2)
 ;;=^5003244
 ;;^UTILITY(U,$J,358.3,13993,0)
 ;;=F14.182^^53^594^7
 ;;^UTILITY(U,$J,358.3,13993,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13993,1,3,0)
 ;;=3^Cocaine-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,13993,1,4,0)
 ;;=4^F14.182
 ;;^UTILITY(U,$J,358.3,13993,2)
 ;;=^5003250
 ;;^UTILITY(U,$J,358.3,13994,0)
 ;;=F14.20^^53^594^4
 ;;^UTILITY(U,$J,358.3,13994,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13994,1,3,0)
 ;;=3^Cocaine Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,13994,1,4,0)
 ;;=4^F14.20
 ;;^UTILITY(U,$J,358.3,13994,2)
 ;;=^5003253
 ;;^UTILITY(U,$J,358.3,13995,0)
 ;;=F14.21^^53^594^3
 ;;^UTILITY(U,$J,358.3,13995,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13995,1,3,0)
 ;;=3^Cocaine Use Disorder,Mod-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,13995,1,4,0)
 ;;=4^F14.21
 ;;^UTILITY(U,$J,358.3,13995,2)
 ;;=^5003254
 ;;^UTILITY(U,$J,358.3,13996,0)
 ;;=F14.23^^53^594^5
 ;;^UTILITY(U,$J,358.3,13996,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13996,1,3,0)
 ;;=3^Cocaine Withdrawal
 ;;^UTILITY(U,$J,358.3,13996,1,4,0)
 ;;=4^F14.23
 ;;^UTILITY(U,$J,358.3,13996,2)
 ;;=^5003259
 ;;^UTILITY(U,$J,358.3,13997,0)
 ;;=F14.11^^53^594^1
 ;;^UTILITY(U,$J,358.3,13997,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13997,1,3,0)
 ;;=3^Cocaine Abuse,In Remission
 ;;^UTILITY(U,$J,358.3,13997,1,4,0)
 ;;=4^F14.11
 ;;^UTILITY(U,$J,358.3,13997,2)
 ;;=^268249
 ;;^UTILITY(U,$J,358.3,13998,0)
 ;;=F16.10^^53^595^2
 ;;^UTILITY(U,$J,358.3,13998,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13998,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,13998,1,4,0)
 ;;=4^F16.10
 ;;^UTILITY(U,$J,358.3,13998,2)
 ;;=^5003323
 ;;^UTILITY(U,$J,358.3,13999,0)
 ;;=F16.20^^53^595^3
 ;;^UTILITY(U,$J,358.3,13999,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13999,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,13999,1,4,0)
 ;;=4^F16.20
 ;;^UTILITY(U,$J,358.3,13999,2)
 ;;=^5003336
 ;;^UTILITY(U,$J,358.3,14000,0)
 ;;=F16.21^^53^595^4
 ;;^UTILITY(U,$J,358.3,14000,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14000,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Moderate-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,14000,1,4,0)
 ;;=4^F16.21
 ;;^UTILITY(U,$J,358.3,14000,2)
 ;;=^5003337
 ;;^UTILITY(U,$J,358.3,14001,0)
 ;;=F16.11^^53^595^1
 ;;^UTILITY(U,$J,358.3,14001,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14001,1,3,0)
 ;;=3^Hallucinogen Abuse,In Remission
 ;;^UTILITY(U,$J,358.3,14001,1,4,0)
 ;;=4^F16.11
 ;;^UTILITY(U,$J,358.3,14001,2)
 ;;=^268239
 ;;^UTILITY(U,$J,358.3,14002,0)
 ;;=F18.10^^53^596^2
 ;;^UTILITY(U,$J,358.3,14002,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14002,1,3,0)
 ;;=3^Inhalant Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,14002,1,4,0)
 ;;=4^F18.10
 ;;^UTILITY(U,$J,358.3,14002,2)
 ;;=^5003380
 ;;^UTILITY(U,$J,358.3,14003,0)
 ;;=F18.20^^53^596^3
 ;;^UTILITY(U,$J,358.3,14003,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14003,1,3,0)
 ;;=3^Inhalant Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,14003,1,4,0)
 ;;=4^F18.20
 ;;^UTILITY(U,$J,358.3,14003,2)
 ;;=^5003392
 ;;^UTILITY(U,$J,358.3,14004,0)
 ;;=F18.21^^53^596^4
 ;;^UTILITY(U,$J,358.3,14004,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14004,1,3,0)
 ;;=3^Inhalant Use Disorder,Moderate-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,14004,1,4,0)
 ;;=4^F18.21
 ;;^UTILITY(U,$J,358.3,14004,2)
 ;;=^5003393
 ;;^UTILITY(U,$J,358.3,14005,0)
 ;;=F18.14^^53^596^5
 ;;^UTILITY(U,$J,358.3,14005,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14005,1,3,0)
 ;;=3^Inhalant-Induced Depressive Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,14005,1,4,0)
 ;;=4^F18.14
 ;;^UTILITY(U,$J,358.3,14005,2)
 ;;=^5003384
 ;;^UTILITY(U,$J,358.3,14006,0)
 ;;=F18.24^^53^596^6
 ;;^UTILITY(U,$J,358.3,14006,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14006,1,3,0)
 ;;=3^Inhalant-Induced Depressive Disorder w/ Moderate to Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,14006,1,4,0)
 ;;=4^F18.24
 ;;^UTILITY(U,$J,358.3,14006,2)
 ;;=^5003397
 ;;^UTILITY(U,$J,358.3,14007,0)
 ;;=F18.11^^53^596^1
 ;;^UTILITY(U,$J,358.3,14007,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14007,1,3,0)
 ;;=3^Inhalant Abuse,In Remission
 ;;^UTILITY(U,$J,358.3,14007,1,4,0)
 ;;=4^F18.11
 ;;^UTILITY(U,$J,358.3,14007,2)
 ;;=^5151305
 ;;^UTILITY(U,$J,358.3,14008,0)
 ;;=F11.10^^53^597^7
 ;;^UTILITY(U,$J,358.3,14008,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14008,1,3,0)
 ;;=3^Opioid Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,14008,1,4,0)
 ;;=4^F11.10
 ;;^UTILITY(U,$J,358.3,14008,2)
 ;;=^5003114
 ;;^UTILITY(U,$J,358.3,14009,0)
 ;;=F11.129^^53^597^6
 ;;^UTILITY(U,$J,358.3,14009,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14009,1,3,0)
 ;;=3^Opioid Intoxication w/o Perceptual Disturbances;Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,14009,1,4,0)
 ;;=4^F11.129
 ;;^UTILITY(U,$J,358.3,14009,2)
 ;;=^5003118
 ;;^UTILITY(U,$J,358.3,14010,0)
 ;;=F11.14^^53^597^10
 ;;^UTILITY(U,$J,358.3,14010,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14010,1,3,0)
 ;;=3^Opioid-Induced Depressive Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,14010,1,4,0)
 ;;=4^F11.14
 ;;^UTILITY(U,$J,358.3,14010,2)
 ;;=^5003119
 ;;^UTILITY(U,$J,358.3,14011,0)
 ;;=F11.182^^53^597^12
 ;;^UTILITY(U,$J,358.3,14011,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14011,1,3,0)
 ;;=3^Opioid-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,14011,1,4,0)
 ;;=4^F11.182
 ;;^UTILITY(U,$J,358.3,14011,2)
 ;;=^5003124
 ;;^UTILITY(U,$J,358.3,14012,0)
 ;;=F11.20^^53^597^8
 ;;^UTILITY(U,$J,358.3,14012,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14012,1,3,0)
 ;;=3^Opioid Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,14012,1,4,0)
 ;;=4^F11.20
 ;;^UTILITY(U,$J,358.3,14012,2)
 ;;=^5003127
 ;;^UTILITY(U,$J,358.3,14013,0)
 ;;=F11.21^^53^597^9
 ;;^UTILITY(U,$J,358.3,14013,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14013,1,3,0)
 ;;=3^Opioid Use Disorder,Moderate-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,14013,1,4,0)
 ;;=4^F11.21
 ;;^UTILITY(U,$J,358.3,14013,2)
 ;;=^5003128
 ;;^UTILITY(U,$J,358.3,14014,0)
 ;;=F11.23^^53^597^5
 ;;^UTILITY(U,$J,358.3,14014,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14014,1,3,0)
 ;;=3^Opioid Dependence w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,14014,1,4,0)
 ;;=4^F11.23
 ;;^UTILITY(U,$J,358.3,14014,2)
 ;;=^5003133
 ;;^UTILITY(U,$J,358.3,14015,0)
 ;;=F11.24^^53^597^11
 ;;^UTILITY(U,$J,358.3,14015,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14015,1,3,0)
 ;;=3^Opioid-Induced Depressive Disorder w/ Moderate-Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,14015,1,4,0)
 ;;=4^F11.24
 ;;^UTILITY(U,$J,358.3,14015,2)
 ;;=^5003134
 ;;^UTILITY(U,$J,358.3,14016,0)
 ;;=F11.29^^53^597^4
 ;;^UTILITY(U,$J,358.3,14016,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14016,1,3,0)
 ;;=3^Opioid Dependence w/ Unspec Opioid-Induced Disorder
 ;;^UTILITY(U,$J,358.3,14016,1,4,0)
 ;;=4^F11.29
 ;;^UTILITY(U,$J,358.3,14016,2)
 ;;=^5003141
 ;;^UTILITY(U,$J,358.3,14017,0)
 ;;=F11.220^^53^597^3
 ;;^UTILITY(U,$J,358.3,14017,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14017,1,3,0)
 ;;=3^Opioid Dependence w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,14017,1,4,0)
 ;;=4^F11.220
 ;;^UTILITY(U,$J,358.3,14017,2)
 ;;=^5003129
 ;;^UTILITY(U,$J,358.3,14018,0)
 ;;=F11.11^^53^597^2
 ;;^UTILITY(U,$J,358.3,14018,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14018,1,3,0)
 ;;=3^Opioid Abuse,In Remission
 ;;^UTILITY(U,$J,358.3,14018,1,4,0)
 ;;=4^F11.11
 ;;^UTILITY(U,$J,358.3,14018,2)
 ;;=^268246
 ;;^UTILITY(U,$J,358.3,14019,0)
 ;;=F11.13^^53^597^1
 ;;^UTILITY(U,$J,358.3,14019,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14019,1,3,0)
 ;;=3^Opioid Abuse w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,14019,1,4,0)
 ;;=4^F11.13
 ;;^UTILITY(U,$J,358.3,14019,2)
 ;;=^5159138
 ;;^UTILITY(U,$J,358.3,14020,0)
 ;;=F19.10^^53^598^4
 ;;^UTILITY(U,$J,358.3,14020,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14020,1,3,0)
 ;;=3^Psychoactive Substance Abuse NEC,Uncomplicated
 ;;^UTILITY(U,$J,358.3,14020,1,4,0)
 ;;=4^F19.10
 ;;^UTILITY(U,$J,358.3,14020,2)
 ;;=^5003416
 ;;^UTILITY(U,$J,358.3,14021,0)
 ;;=F19.14^^53^598^1
 ;;^UTILITY(U,$J,358.3,14021,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14021,1,3,0)
 ;;=3^Psychoactive Substance Abuse NEC w/ Induced Mood Disorder
 ;;^UTILITY(U,$J,358.3,14021,1,4,0)
 ;;=4^F19.14
 ;;^UTILITY(U,$J,358.3,14021,2)
 ;;=^5003421
 ;;^UTILITY(U,$J,358.3,14022,0)
 ;;=F19.182^^53^598^2
 ;;^UTILITY(U,$J,358.3,14022,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14022,1,3,0)
 ;;=3^Psychoactive Substance Abuse NEC w/ Induced Sleep Disorder
 ;;^UTILITY(U,$J,358.3,14022,1,4,0)
 ;;=4^F19.182
 ;;^UTILITY(U,$J,358.3,14022,2)
 ;;=^5003429
 ;;^UTILITY(U,$J,358.3,14023,0)
 ;;=F19.20^^53^598^7
 ;;^UTILITY(U,$J,358.3,14023,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14023,1,3,0)
 ;;=3^Psychoactive Substance Dependence NEC,Uncomplicated
 ;;^UTILITY(U,$J,358.3,14023,1,4,0)
 ;;=4^F19.20
 ;;^UTILITY(U,$J,358.3,14023,2)
 ;;=^5003431
 ;;^UTILITY(U,$J,358.3,14024,0)
 ;;=F19.21^^53^598^6
 ;;^UTILITY(U,$J,358.3,14024,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14024,1,3,0)
 ;;=3^Psychoactive Substance Dependence NEC,In Remission
 ;;^UTILITY(U,$J,358.3,14024,1,4,0)
 ;;=4^F19.21
 ;;^UTILITY(U,$J,358.3,14024,2)
 ;;=^5003432
 ;;^UTILITY(U,$J,358.3,14025,0)
 ;;=F19.24^^53^598^5
 ;;^UTILITY(U,$J,358.3,14025,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14025,1,3,0)
 ;;=3^Psychoactive Substance Dependence NEC w/ Induced Mood Disorder
 ;;^UTILITY(U,$J,358.3,14025,1,4,0)
 ;;=4^F19.24
 ;;^UTILITY(U,$J,358.3,14025,2)
 ;;=^5003441
 ;;^UTILITY(U,$J,358.3,14026,0)
 ;;=F19.11^^53^598^3
 ;;^UTILITY(U,$J,358.3,14026,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14026,1,3,0)
 ;;=3^Psychoactive Substance Abuse NEC,In Remission
 ;;^UTILITY(U,$J,358.3,14026,1,4,0)
 ;;=4^F19.11
 ;;^UTILITY(U,$J,358.3,14026,2)
 ;;=^5151306
 ;;^UTILITY(U,$J,358.3,14027,0)
 ;;=F13.10^^53^599^2
 ;;^UTILITY(U,$J,358.3,14027,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14027,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,14027,1,4,0)
 ;;=4^F13.10
 ;;^UTILITY(U,$J,358.3,14027,2)
 ;;=^5003189
 ;;^UTILITY(U,$J,358.3,14028,0)
 ;;=F13.14^^53^599^8
 ;;^UTILITY(U,$J,358.3,14028,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14028,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic-Induced Depressive,Bipolar or Related Disorder w/ Mild use Disorder
 ;;^UTILITY(U,$J,358.3,14028,1,4,0)
 ;;=4^F13.14
 ;;^UTILITY(U,$J,358.3,14028,2)
 ;;=^5003193
 ;;^UTILITY(U,$J,358.3,14029,0)
 ;;=F13.182^^53^599^9
 ;;^UTILITY(U,$J,358.3,14029,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14029,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,14029,1,4,0)
 ;;=4^F13.182
 ;;^UTILITY(U,$J,358.3,14029,2)
 ;;=^5003199
 ;;^UTILITY(U,$J,358.3,14030,0)
 ;;=F13.20^^53^599^3
 ;;^UTILITY(U,$J,358.3,14030,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14030,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,14030,1,4,0)
 ;;=4^F13.20
 ;;^UTILITY(U,$J,358.3,14030,2)
 ;;=^5003202
 ;;^UTILITY(U,$J,358.3,14031,0)
 ;;=F13.21^^53^599^4
 ;;^UTILITY(U,$J,358.3,14031,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14031,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Use Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,14031,1,4,0)
 ;;=4^F13.21
 ;;^UTILITY(U,$J,358.3,14031,2)
 ;;=^331934
 ;;^UTILITY(U,$J,358.3,14032,0)
 ;;=F13.232^^53^599^5
 ;;^UTILITY(U,$J,358.3,14032,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14032,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Withdrawal w/ Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,14032,1,4,0)
 ;;=4^F13.232
 ;;^UTILITY(U,$J,358.3,14032,2)
 ;;=^5003208
 ;;^UTILITY(U,$J,358.3,14033,0)
 ;;=F13.239^^53^599^6
 ;;^UTILITY(U,$J,358.3,14033,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14033,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Withdrawal w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,14033,1,4,0)
 ;;=4^F13.239
 ;;^UTILITY(U,$J,358.3,14033,2)
 ;;=^5003209
 ;;^UTILITY(U,$J,358.3,14034,0)
 ;;=F13.24^^53^599^10
 ;;^UTILITY(U,$J,358.3,14034,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14034,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic-Induced Dep,Bip or Related Disorder w/ Mod-Sev Use Disorder
 ;;^UTILITY(U,$J,358.3,14034,1,4,0)
 ;;=4^F13.24
 ;;^UTILITY(U,$J,358.3,14034,2)
 ;;=^5003210
 ;;^UTILITY(U,$J,358.3,14035,0)
 ;;=F13.231^^53^599^7
 ;;^UTILITY(U,$J,358.3,14035,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14035,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,14035,1,4,0)
 ;;=4^F13.231
 ;;^UTILITY(U,$J,358.3,14035,2)
 ;;=^5003207
 ;;^UTILITY(U,$J,358.3,14036,0)
 ;;=F13.11^^53^599^1
 ;;^UTILITY(U,$J,358.3,14036,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14036,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Abuse,In Remission
 ;;^UTILITY(U,$J,358.3,14036,1,4,0)
 ;;=4^F13.11
 ;;^UTILITY(U,$J,358.3,14036,2)
 ;;=^331938
 ;;^UTILITY(U,$J,358.3,14037,0)
 ;;=F17.200^^53^600^1
 ;;^UTILITY(U,$J,358.3,14037,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14037,1,3,0)
 ;;=3^Tobacco Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,14037,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,14037,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,14038,0)
 ;;=F17.201^^53^600^2
 ;;^UTILITY(U,$J,358.3,14038,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14038,1,3,0)
 ;;=3^Tobacco Use Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,14038,1,4,0)
 ;;=4^F17.201
 ;;^UTILITY(U,$J,358.3,14038,2)
 ;;=^5003361
 ;;^UTILITY(U,$J,358.3,14039,0)
 ;;=F17.203^^53^600^3
 ;;^UTILITY(U,$J,358.3,14039,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14039,1,3,0)
 ;;=3^Tobacco Withdrawal
 ;;^UTILITY(U,$J,358.3,14039,1,4,0)
 ;;=4^F17.203
 ;;^UTILITY(U,$J,358.3,14039,2)
 ;;=^5003362
 ;;^UTILITY(U,$J,358.3,14040,0)
 ;;=F17.210^^53^600^4
 ;;^UTILITY(U,$J,358.3,14040,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14040,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes,Uncomplicated
 ;;^UTILITY(U,$J,358.3,14040,1,4,0)
 ;;=4^F17.210
 ;;^UTILITY(U,$J,358.3,14040,2)
 ;;=^5003365
 ;;^UTILITY(U,$J,358.3,14041,0)
 ;;=F17.211^^53^600^5
 ;;^UTILITY(U,$J,358.3,14041,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14041,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes,In Remission
 ;;^UTILITY(U,$J,358.3,14041,1,4,0)
 ;;=4^F17.211
 ;;^UTILITY(U,$J,358.3,14041,2)
 ;;=^5003366
 ;;^UTILITY(U,$J,358.3,14042,0)
 ;;=F17.220^^53^600^6
 ;;^UTILITY(U,$J,358.3,14042,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14042,1,3,0)
 ;;=3^Nicotine Dependence,Chewing Tobacco,Uncomplicated
 ;;^UTILITY(U,$J,358.3,14042,1,4,0)
 ;;=4^F17.220
 ;;^UTILITY(U,$J,358.3,14042,2)
 ;;=^5003370
 ;;^UTILITY(U,$J,358.3,14043,0)
 ;;=F17.221^^53^600^7
 ;;^UTILITY(U,$J,358.3,14043,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14043,1,3,0)
 ;;=3^Nicotine Dependence,Chewing Tobacco,In Remission
 ;;^UTILITY(U,$J,358.3,14043,1,4,0)
 ;;=4^F17.221
 ;;^UTILITY(U,$J,358.3,14043,2)
 ;;=^5003371
 ;;^UTILITY(U,$J,358.3,14044,0)
 ;;=F17.290^^53^600^8
 ;;^UTILITY(U,$J,358.3,14044,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14044,1,3,0)
 ;;=3^Nicotine Dependence,Oth Tobacco Product,Uncomplicated
 ;;^UTILITY(U,$J,358.3,14044,1,4,0)
 ;;=4^F17.290
 ;;^UTILITY(U,$J,358.3,14044,2)
 ;;=^5003375
 ;;^UTILITY(U,$J,358.3,14045,0)
 ;;=F17.291^^53^600^9
 ;;^UTILITY(U,$J,358.3,14045,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14045,1,3,0)
 ;;=3^Nicotine Dependence,Oth Tobacco Product,In Remission
 ;;^UTILITY(U,$J,358.3,14045,1,4,0)
 ;;=4^F17.291
 ;;^UTILITY(U,$J,358.3,14045,2)
 ;;=^5003376

IBDEI046 ; ; 01-AUG-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;AUG 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,10052,0)
 ;;=F11.221^^45^445^52
 ;;^UTILITY(U,$J,358.3,10052,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10052,1,3,0)
 ;;=3^Opioid Dependence w/ Intoxication Delirium
 ;;^UTILITY(U,$J,358.3,10052,1,4,0)
 ;;=4^F11.221
 ;;^UTILITY(U,$J,358.3,10052,2)
 ;;=^5003130
 ;;^UTILITY(U,$J,358.3,10053,0)
 ;;=F11.220^^45^445^54
 ;;^UTILITY(U,$J,358.3,10053,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10053,1,3,0)
 ;;=3^Opioid Dependence w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,10053,1,4,0)
 ;;=4^F11.220
 ;;^UTILITY(U,$J,358.3,10053,2)
 ;;=^5003129
 ;;^UTILITY(U,$J,358.3,10054,0)
 ;;=F14.29^^45^445^34
 ;;^UTILITY(U,$J,358.3,10054,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10054,1,3,0)
 ;;=3^Cocaine Dependence w/ Unspec Cocaine-Induced Disorder
 ;;^UTILITY(U,$J,358.3,10054,1,4,0)
 ;;=4^F14.29
 ;;^UTILITY(U,$J,358.3,10054,2)
 ;;=^5003268
 ;;^UTILITY(U,$J,358.3,10055,0)
 ;;=F14.288^^45^445^33
 ;;^UTILITY(U,$J,358.3,10055,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10055,1,3,0)
 ;;=3^Cocaine Dependence w/ Other Cocaine-Induced Disorder
 ;;^UTILITY(U,$J,358.3,10055,1,4,0)
 ;;=4^F14.288
 ;;^UTILITY(U,$J,358.3,10055,2)
 ;;=^5003267
 ;;^UTILITY(U,$J,358.3,10056,0)
 ;;=F14.282^^45^445^27
 ;;^UTILITY(U,$J,358.3,10056,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10056,1,3,0)
 ;;=3^Cocaine Dependence w/ Cocaine-Induced Sleep Disorder
 ;;^UTILITY(U,$J,358.3,10056,1,4,0)
 ;;=4^F14.282
 ;;^UTILITY(U,$J,358.3,10056,2)
 ;;=^5003266
 ;;^UTILITY(U,$J,358.3,10057,0)
 ;;=F14.281^^45^445^28
 ;;^UTILITY(U,$J,358.3,10057,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10057,1,3,0)
 ;;=3^Cocaine Dependence w/ Cocaine-Induced Sexual Dysfunction
 ;;^UTILITY(U,$J,358.3,10057,1,4,0)
 ;;=4^F14.281
 ;;^UTILITY(U,$J,358.3,10057,2)
 ;;=^5003265
 ;;^UTILITY(U,$J,358.3,10058,0)
 ;;=F14.280^^45^445^25
 ;;^UTILITY(U,$J,358.3,10058,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10058,1,3,0)
 ;;=3^Cocaine Dependence w/ Cocaine-Induced Anxiety Disorder
 ;;^UTILITY(U,$J,358.3,10058,1,4,0)
 ;;=4^F14.280
 ;;^UTILITY(U,$J,358.3,10058,2)
 ;;=^5003264
 ;;^UTILITY(U,$J,358.3,10059,0)
 ;;=F14.259^^45^445^24
 ;;^UTILITY(U,$J,358.3,10059,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10059,1,3,0)
 ;;=3^Cocaine Dependence w/ Cocaine-Induc Psychotic Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,10059,1,4,0)
 ;;=4^F14.259
 ;;^UTILITY(U,$J,358.3,10059,2)
 ;;=^5003263
 ;;^UTILITY(U,$J,358.3,10060,0)
 ;;=F14.251^^45^445^23
 ;;^UTILITY(U,$J,358.3,10060,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10060,1,3,0)
 ;;=3^Cocaine Depend w/ Cocaine-Induc Psychotic Disorder w/ Hallucin
 ;;^UTILITY(U,$J,358.3,10060,1,4,0)
 ;;=4^F14.251
 ;;^UTILITY(U,$J,358.3,10060,2)
 ;;=^5003262
 ;;^UTILITY(U,$J,358.3,10061,0)
 ;;=F14.250^^45^445^22
 ;;^UTILITY(U,$J,358.3,10061,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10061,1,3,0)
 ;;=3^Cocaine Depend w/ Cocaine-Induc Psych Disorder w/ Delusions
 ;;^UTILITY(U,$J,358.3,10061,1,4,0)
 ;;=4^F14.250
 ;;^UTILITY(U,$J,358.3,10061,2)
 ;;=^5003261
 ;;^UTILITY(U,$J,358.3,10062,0)
 ;;=F14.24^^45^445^26
 ;;^UTILITY(U,$J,358.3,10062,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10062,1,3,0)
 ;;=3^Cocaine Dependence w/ Cocaine-Induced Mood Disorder
 ;;^UTILITY(U,$J,358.3,10062,1,4,0)
 ;;=4^F14.24
 ;;^UTILITY(U,$J,358.3,10062,2)
 ;;=^5003260
 ;;^UTILITY(U,$J,358.3,10063,0)
 ;;=F14.23^^45^445^35
 ;;^UTILITY(U,$J,358.3,10063,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10063,1,3,0)
 ;;=3^Cocaine Dependence w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,10063,1,4,0)
 ;;=4^F14.23
 ;;^UTILITY(U,$J,358.3,10063,2)
 ;;=^5003259
 ;;^UTILITY(U,$J,358.3,10064,0)
 ;;=F14.229^^45^445^32
 ;;^UTILITY(U,$J,358.3,10064,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10064,1,3,0)
 ;;=3^Cocaine Dependence w/ Intoxication,Unspec
 ;;^UTILITY(U,$J,358.3,10064,1,4,0)
 ;;=4^F14.229
 ;;^UTILITY(U,$J,358.3,10064,2)
 ;;=^5003258
 ;;^UTILITY(U,$J,358.3,10065,0)
 ;;=F14.222^^45^445^30
 ;;^UTILITY(U,$J,358.3,10065,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10065,1,3,0)
 ;;=3^Cocaine Dependence w/ Intoxication w/ Perceptual Disturbance
 ;;^UTILITY(U,$J,358.3,10065,1,4,0)
 ;;=4^F14.222
 ;;^UTILITY(U,$J,358.3,10065,2)
 ;;=^5003257
 ;;^UTILITY(U,$J,358.3,10066,0)
 ;;=F14.221^^45^445^29
 ;;^UTILITY(U,$J,358.3,10066,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10066,1,3,0)
 ;;=3^Cocaine Dependence w/ Intoxication Delirium
 ;;^UTILITY(U,$J,358.3,10066,1,4,0)
 ;;=4^F14.221
 ;;^UTILITY(U,$J,358.3,10066,2)
 ;;=^5003256
 ;;^UTILITY(U,$J,358.3,10067,0)
 ;;=F14.220^^45^445^31
 ;;^UTILITY(U,$J,358.3,10067,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10067,1,3,0)
 ;;=3^Cocaine Dependence w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,10067,1,4,0)
 ;;=4^F14.220
 ;;^UTILITY(U,$J,358.3,10067,2)
 ;;=^5003255
 ;;^UTILITY(U,$J,358.3,10068,0)
 ;;=F14.20^^45^445^36
 ;;^UTILITY(U,$J,358.3,10068,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10068,1,3,0)
 ;;=3^Cocaine Dependence,Uncompicated
 ;;^UTILITY(U,$J,358.3,10068,1,4,0)
 ;;=4^F14.20
 ;;^UTILITY(U,$J,358.3,10068,2)
 ;;=^5003253
 ;;^UTILITY(U,$J,358.3,10069,0)
 ;;=F10.120^^45^445^1
 ;;^UTILITY(U,$J,358.3,10069,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10069,1,3,0)
 ;;=3^Alcohol Abuse w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,10069,1,4,0)
 ;;=4^F10.120
 ;;^UTILITY(U,$J,358.3,10069,2)
 ;;=^5003069
 ;;^UTILITY(U,$J,358.3,10070,0)
 ;;=F10.10^^45^445^7
 ;;^UTILITY(U,$J,358.3,10070,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10070,1,3,0)
 ;;=3^Alcohol Abuse,Uncomplicated
 ;;^UTILITY(U,$J,358.3,10070,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,10070,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,10071,0)
 ;;=F17.201^^45^445^41
 ;;^UTILITY(U,$J,358.3,10071,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10071,1,3,0)
 ;;=3^Nicotine Dependence In Remission,Unspec
 ;;^UTILITY(U,$J,358.3,10071,1,4,0)
 ;;=4^F17.201
 ;;^UTILITY(U,$J,358.3,10071,2)
 ;;=^5003361
 ;;^UTILITY(U,$J,358.3,10072,0)
 ;;=F17.210^^45^445^40
 ;;^UTILITY(U,$J,358.3,10072,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10072,1,3,0)
 ;;=3^Nicotine Dependence Cigarettes,Uncomplicated
 ;;^UTILITY(U,$J,358.3,10072,1,4,0)
 ;;=4^F17.210
 ;;^UTILITY(U,$J,358.3,10072,2)
 ;;=^5003365
 ;;^UTILITY(U,$J,358.3,10073,0)
 ;;=F17.291^^45^445^42
 ;;^UTILITY(U,$J,358.3,10073,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10073,1,3,0)
 ;;=3^Nicotine Dependence Oth Tobacco Product,In Remission
 ;;^UTILITY(U,$J,358.3,10073,1,4,0)
 ;;=4^F17.291
 ;;^UTILITY(U,$J,358.3,10073,2)
 ;;=^5003376
 ;;^UTILITY(U,$J,358.3,10074,0)
 ;;=F17.290^^45^445^43
 ;;^UTILITY(U,$J,358.3,10074,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10074,1,3,0)
 ;;=3^Nicotine Dependence Oth Tobacco Product,Uncomplicated
 ;;^UTILITY(U,$J,358.3,10074,1,4,0)
 ;;=4^F17.290
 ;;^UTILITY(U,$J,358.3,10074,2)
 ;;=^5003375
 ;;^UTILITY(U,$J,358.3,10075,0)
 ;;=F17.221^^45^445^37
 ;;^UTILITY(U,$J,358.3,10075,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10075,1,3,0)
 ;;=3^Nicotine Dependence Chewing Tobacco,In Remission
 ;;^UTILITY(U,$J,358.3,10075,1,4,0)
 ;;=4^F17.221
 ;;^UTILITY(U,$J,358.3,10075,2)
 ;;=^5003371
 ;;^UTILITY(U,$J,358.3,10076,0)
 ;;=F17.220^^45^445^38
 ;;^UTILITY(U,$J,358.3,10076,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10076,1,3,0)
 ;;=3^Nicotine Dependence Chewing Tobacco,Uncomplicated
 ;;^UTILITY(U,$J,358.3,10076,1,4,0)
 ;;=4^F17.220
 ;;^UTILITY(U,$J,358.3,10076,2)
 ;;=^5003370
 ;;^UTILITY(U,$J,358.3,10077,0)
 ;;=F17.211^^45^445^39
 ;;^UTILITY(U,$J,358.3,10077,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10077,1,3,0)
 ;;=3^Nicotine Dependence Cigarettes,In Remission
 ;;^UTILITY(U,$J,358.3,10077,1,4,0)
 ;;=4^F17.211
 ;;^UTILITY(U,$J,358.3,10077,2)
 ;;=^5003366
 ;;^UTILITY(U,$J,358.3,10078,0)
 ;;=F17.200^^45^445^44
 ;;^UTILITY(U,$J,358.3,10078,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10078,1,3,0)
 ;;=3^Nicotine Dependence,Unspec,Uncomplicated
 ;;^UTILITY(U,$J,358.3,10078,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,10078,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,10079,0)
 ;;=F11.120^^45^445^45
 ;;^UTILITY(U,$J,358.3,10079,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10079,1,3,0)
 ;;=3^Opioid Abuse w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,10079,1,4,0)
 ;;=4^F11.120
 ;;^UTILITY(U,$J,358.3,10079,2)
 ;;=^5003115
 ;;^UTILITY(U,$J,358.3,10080,0)
 ;;=F11.10^^45^445^49
 ;;^UTILITY(U,$J,358.3,10080,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10080,1,3,0)
 ;;=3^Opioid Abuse,Uncomplicated
 ;;^UTILITY(U,$J,358.3,10080,1,4,0)
 ;;=4^F11.10
 ;;^UTILITY(U,$J,358.3,10080,2)
 ;;=^5003114
 ;;^UTILITY(U,$J,358.3,10081,0)
 ;;=F11.129^^45^445^46
 ;;^UTILITY(U,$J,358.3,10081,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10081,1,3,0)
 ;;=3^Opioid Abuse w/ Intoxication,Unspec
 ;;^UTILITY(U,$J,358.3,10081,1,4,0)
 ;;=4^F11.129
 ;;^UTILITY(U,$J,358.3,10081,2)
 ;;=^5003118
 ;;^UTILITY(U,$J,358.3,10082,0)
 ;;=F10.21^^45^445^8
 ;;^UTILITY(U,$J,358.3,10082,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10082,1,3,0)
 ;;=3^Alcohol Dependence,In Remission
 ;;^UTILITY(U,$J,358.3,10082,1,4,0)
 ;;=4^F10.21
 ;;^UTILITY(U,$J,358.3,10082,2)
 ;;=^5003082
 ;;^UTILITY(U,$J,358.3,10083,0)
 ;;=F12.10^^45^445^16
 ;;^UTILITY(U,$J,358.3,10083,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10083,1,3,0)
 ;;=3^Cannabis Abuse,Uncomplicated
 ;;^UTILITY(U,$J,358.3,10083,1,4,0)
 ;;=4^F12.10
 ;;^UTILITY(U,$J,358.3,10083,2)
 ;;=^5003155
 ;;^UTILITY(U,$J,358.3,10084,0)
 ;;=F12.20^^45^445^18
 ;;^UTILITY(U,$J,358.3,10084,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10084,1,3,0)
 ;;=3^Cannabis Dependence,Uncomplicated
 ;;^UTILITY(U,$J,358.3,10084,1,4,0)
 ;;=4^F12.20
 ;;^UTILITY(U,$J,358.3,10084,2)
 ;;=^5003166
 ;;^UTILITY(U,$J,358.3,10085,0)
 ;;=F12.21^^45^445^17
 ;;^UTILITY(U,$J,358.3,10085,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10085,1,3,0)
 ;;=3^Cannabis Dependence,In Remission
 ;;^UTILITY(U,$J,358.3,10085,1,4,0)
 ;;=4^F12.21
 ;;^UTILITY(U,$J,358.3,10085,2)
 ;;=^5003167
 ;;^UTILITY(U,$J,358.3,10086,0)
 ;;=F12.90^^45^445^20
 ;;^UTILITY(U,$J,358.3,10086,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10086,1,3,0)
 ;;=3^Cannabis Use,Unspec,Uncomplicated
 ;;^UTILITY(U,$J,358.3,10086,1,4,0)
 ;;=4^F12.90
 ;;^UTILITY(U,$J,358.3,10086,2)
 ;;=^5003178
 ;;^UTILITY(U,$J,358.3,10087,0)
 ;;=F10.11^^45^445^6
 ;;^UTILITY(U,$J,358.3,10087,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10087,1,3,0)
 ;;=3^Alcohol Abuse,In Remission
 ;;^UTILITY(U,$J,358.3,10087,1,4,0)
 ;;=4^F10.11
 ;;^UTILITY(U,$J,358.3,10087,2)
 ;;=^268230
 ;;^UTILITY(U,$J,358.3,10088,0)
 ;;=F12.11^^45^445^15
 ;;^UTILITY(U,$J,358.3,10088,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10088,1,3,0)
 ;;=3^Cannabis Abuse,In Remission
 ;;^UTILITY(U,$J,358.3,10088,1,4,0)
 ;;=4^F12.11
 ;;^UTILITY(U,$J,358.3,10088,2)
 ;;=^268236
 ;;^UTILITY(U,$J,358.3,10089,0)
 ;;=F14.11^^45^445^21
 ;;^UTILITY(U,$J,358.3,10089,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10089,1,3,0)
 ;;=3^Cocaine Abuse,In Remission
 ;;^UTILITY(U,$J,358.3,10089,1,4,0)
 ;;=4^F14.11
 ;;^UTILITY(U,$J,358.3,10089,2)
 ;;=^268249
 ;;^UTILITY(U,$J,358.3,10090,0)
 ;;=F11.11^^45^445^48
 ;;^UTILITY(U,$J,358.3,10090,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10090,1,3,0)
 ;;=3^Opioid Abuse,In Remission
 ;;^UTILITY(U,$J,358.3,10090,1,4,0)
 ;;=4^F11.11
 ;;^UTILITY(U,$J,358.3,10090,2)
 ;;=^268246
 ;;^UTILITY(U,$J,358.3,10091,0)
 ;;=F12.93^^45^445^19
 ;;^UTILITY(U,$J,358.3,10091,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10091,1,3,0)
 ;;=3^Cannabis Use,Unspec w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,10091,1,4,0)
 ;;=4^F12.93
 ;;^UTILITY(U,$J,358.3,10091,2)
 ;;=^5157302
 ;;^UTILITY(U,$J,358.3,10092,0)
 ;;=F10.130^^45^445^4
 ;;^UTILITY(U,$J,358.3,10092,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10092,1,3,0)
 ;;=3^Alcohol Abuse w/ Withdrawal,Uncomp
 ;;^UTILITY(U,$J,358.3,10092,1,4,0)
 ;;=4^F10.130
 ;;^UTILITY(U,$J,358.3,10092,2)
 ;;=^5159130
 ;;^UTILITY(U,$J,358.3,10093,0)
 ;;=F10.131^^45^445^2
 ;;^UTILITY(U,$J,358.3,10093,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10093,1,3,0)
 ;;=3^Alcohol Abuse w/ Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,10093,1,4,0)
 ;;=4^F10.131
 ;;^UTILITY(U,$J,358.3,10093,2)
 ;;=^5159131
 ;;^UTILITY(U,$J,358.3,10094,0)
 ;;=F10.132^^45^445^3
 ;;^UTILITY(U,$J,358.3,10094,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10094,1,3,0)
 ;;=3^Alcohol Abuse w/ Withdrawal w/ Perceptual Disturbance
 ;;^UTILITY(U,$J,358.3,10094,1,4,0)
 ;;=4^F10.132
 ;;^UTILITY(U,$J,358.3,10094,2)
 ;;=^5159132
 ;;^UTILITY(U,$J,358.3,10095,0)
 ;;=F10.139^^45^445^5
 ;;^UTILITY(U,$J,358.3,10095,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10095,1,3,0)
 ;;=3^Alcohol Abuse w/ Withdrawal,Unspec
 ;;^UTILITY(U,$J,358.3,10095,1,4,0)
 ;;=4^F10.139
 ;;^UTILITY(U,$J,358.3,10095,2)
 ;;=^5159133
 ;;^UTILITY(U,$J,358.3,10096,0)
 ;;=F10.930^^45^445^12
 ;;^UTILITY(U,$J,358.3,10096,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10096,1,3,0)
 ;;=3^Alcohol Use,Unspec w/ Withdrawal,Uncomp
 ;;^UTILITY(U,$J,358.3,10096,1,4,0)
 ;;=4^F10.930
 ;;^UTILITY(U,$J,358.3,10096,2)
 ;;=^5159134
 ;;^UTILITY(U,$J,358.3,10097,0)
 ;;=F10.931^^45^445^10
 ;;^UTILITY(U,$J,358.3,10097,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10097,1,3,0)
 ;;=3^Alcohol Use,Unspec w/ Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,10097,1,4,0)
 ;;=4^F10.931
 ;;^UTILITY(U,$J,358.3,10097,2)
 ;;=^5159135
 ;;^UTILITY(U,$J,358.3,10098,0)
 ;;=F10.932^^45^445^11
 ;;^UTILITY(U,$J,358.3,10098,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10098,1,3,0)
 ;;=3^Alcohol Use,Unspec w/ Withdrawal w/ Perceptual Disturbance
 ;;^UTILITY(U,$J,358.3,10098,1,4,0)
 ;;=4^F10.932
 ;;^UTILITY(U,$J,358.3,10098,2)
 ;;=^5159136
 ;;^UTILITY(U,$J,358.3,10099,0)
 ;;=F10.939^^45^445^13
 ;;^UTILITY(U,$J,358.3,10099,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10099,1,3,0)
 ;;=3^Alcohol Use,Unspec w/ Withdrawal,Unspec
 ;;^UTILITY(U,$J,358.3,10099,1,4,0)
 ;;=4^F10.939
 ;;^UTILITY(U,$J,358.3,10099,2)
 ;;=^5159137
 ;;^UTILITY(U,$J,358.3,10100,0)
 ;;=F12.13^^45^445^14
 ;;^UTILITY(U,$J,358.3,10100,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10100,1,3,0)
 ;;=3^Cannabis Abuse w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,10100,1,4,0)
 ;;=4^F12.13
 ;;^UTILITY(U,$J,358.3,10100,2)
 ;;=^5159139
 ;;^UTILITY(U,$J,358.3,10101,0)
 ;;=F11.13^^45^445^47
 ;;^UTILITY(U,$J,358.3,10101,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10101,1,3,0)
 ;;=3^Opioid Abuse w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,10101,1,4,0)
 ;;=4^F11.13
 ;;^UTILITY(U,$J,358.3,10101,2)
 ;;=^5159138
 ;;^UTILITY(U,$J,358.3,10102,0)
 ;;=I83.019^^45^446^3
 ;;^UTILITY(U,$J,358.3,10102,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10102,1,3,0)
 ;;=3^Varicose Veins Right Lower Extrem w/ Ulcer,Unspec
 ;;^UTILITY(U,$J,358.3,10102,1,4,0)
 ;;=4^I83.019
 ;;^UTILITY(U,$J,358.3,10102,2)
 ;;=^5007979
 ;;^UTILITY(U,$J,358.3,10103,0)
 ;;=I83.219^^45^446^4
 ;;^UTILITY(U,$J,358.3,10103,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10103,1,3,0)
 ;;=3^Varicose Veins Right Lower Extrem w/ Ulcer & Inflam,Unspec
 ;;^UTILITY(U,$J,358.3,10103,1,4,0)
 ;;=4^I83.219
 ;;^UTILITY(U,$J,358.3,10103,2)
 ;;=^5008003
 ;;^UTILITY(U,$J,358.3,10104,0)
 ;;=I83.029^^45^446^1
 ;;^UTILITY(U,$J,358.3,10104,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10104,1,3,0)
 ;;=3^Varicose Veins Left Lower Extrem w/ Ulcer,Unspec
 ;;^UTILITY(U,$J,358.3,10104,1,4,0)
 ;;=4^I83.029
 ;;^UTILITY(U,$J,358.3,10104,2)
 ;;=^5007986
 ;;^UTILITY(U,$J,358.3,10105,0)
 ;;=I83.229^^45^446^2
 ;;^UTILITY(U,$J,358.3,10105,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10105,1,3,0)
 ;;=3^Varicose Veins Left Lower Extrem w/ Ulcer & Inflam,Unspec
 ;;^UTILITY(U,$J,358.3,10105,1,4,0)
 ;;=4^I83.229
 ;;^UTILITY(U,$J,358.3,10105,2)
 ;;=^5008010
 ;;^UTILITY(U,$J,358.3,10106,0)
 ;;=B00.81^^45^447^55
 ;;^UTILITY(U,$J,358.3,10106,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10106,1,3,0)
 ;;=3^Herpesviral Hepatitis
 ;;^UTILITY(U,$J,358.3,10106,1,4,0)
 ;;=4^B00.81
 ;;^UTILITY(U,$J,358.3,10106,2)
 ;;=^5000478
 ;;^UTILITY(U,$J,358.3,10107,0)
 ;;=D25.9^^45^447^64
 ;;^UTILITY(U,$J,358.3,10107,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10107,1,3,0)
 ;;=3^Leiomyoma of Uterus,Unspec
 ;;^UTILITY(U,$J,358.3,10107,1,4,0)
 ;;=4^D25.9
 ;;^UTILITY(U,$J,358.3,10107,2)
 ;;=^5002081
 ;;^UTILITY(U,$J,358.3,10108,0)
 ;;=F52.9^^45^447^103
 ;;^UTILITY(U,$J,358.3,10108,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10108,1,3,0)
 ;;=3^Sexual Dysfnct Not d/t a Sub/Known Physiol Cond,Unspec
 ;;^UTILITY(U,$J,358.3,10108,1,4,0)
 ;;=4^F52.9
 ;;^UTILITY(U,$J,358.3,10108,2)
 ;;=^5003625
 ;;^UTILITY(U,$J,358.3,10109,0)
 ;;=R37.^^45^447^104
 ;;^UTILITY(U,$J,358.3,10109,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10109,1,3,0)
 ;;=3^Sexual Dysfunction,Unspec
 ;;^UTILITY(U,$J,358.3,10109,1,4,0)
 ;;=4^R37.
 ;;^UTILITY(U,$J,358.3,10109,2)
 ;;=^5019339
 ;;^UTILITY(U,$J,358.3,10110,0)
 ;;=N60.01^^45^447^107
 ;;^UTILITY(U,$J,358.3,10110,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10110,1,3,0)
 ;;=3^Solitary Cyst of Right Breast
 ;;^UTILITY(U,$J,358.3,10110,1,4,0)
 ;;=4^N60.01
 ;;^UTILITY(U,$J,358.3,10110,2)
 ;;=^5015770
 ;;^UTILITY(U,$J,358.3,10111,0)
 ;;=N60.02^^45^447^106
 ;;^UTILITY(U,$J,358.3,10111,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10111,1,3,0)
 ;;=3^Solitary Cyst of Left Breast
 ;;^UTILITY(U,$J,358.3,10111,1,4,0)
 ;;=4^N60.02
 ;;^UTILITY(U,$J,358.3,10111,2)
 ;;=^5015771
 ;;^UTILITY(U,$J,358.3,10112,0)
 ;;=N60.09^^45^447^108
 ;;^UTILITY(U,$J,358.3,10112,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10112,1,3,0)
 ;;=3^Solitary Cyst of Unspec Breast
 ;;^UTILITY(U,$J,358.3,10112,1,4,0)
 ;;=4^N60.09
 ;;^UTILITY(U,$J,358.3,10112,2)
 ;;=^5015772
 ;;^UTILITY(U,$J,358.3,10113,0)
 ;;=N60.11^^45^447^27
 ;;^UTILITY(U,$J,358.3,10113,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10113,1,3,0)
 ;;=3^Diffuse Cystic Mastopathy of Right Breast
 ;;^UTILITY(U,$J,358.3,10113,1,4,0)
 ;;=4^N60.11
 ;;^UTILITY(U,$J,358.3,10113,2)
 ;;=^5015773
 ;;^UTILITY(U,$J,358.3,10114,0)
 ;;=N60.12^^45^447^26
 ;;^UTILITY(U,$J,358.3,10114,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10114,1,3,0)
 ;;=3^Diffuse Cystic Mastopathy of Left Breast
 ;;^UTILITY(U,$J,358.3,10114,1,4,0)
 ;;=4^N60.12
 ;;^UTILITY(U,$J,358.3,10114,2)
 ;;=^5015774
 ;;^UTILITY(U,$J,358.3,10115,0)
 ;;=N64.4^^45^447^68
 ;;^UTILITY(U,$J,358.3,10115,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10115,1,3,0)
 ;;=3^Mastodynia
 ;;^UTILITY(U,$J,358.3,10115,1,4,0)
 ;;=4^N64.4
 ;;^UTILITY(U,$J,358.3,10115,2)
 ;;=^5015794
 ;;^UTILITY(U,$J,358.3,10116,0)
 ;;=N64.51^^45^447^60
 ;;^UTILITY(U,$J,358.3,10116,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10116,1,3,0)
 ;;=3^Induration of Breast
 ;;^UTILITY(U,$J,358.3,10116,1,4,0)
 ;;=4^N64.51
 ;;^UTILITY(U,$J,358.3,10116,2)
 ;;=^5015795
 ;;^UTILITY(U,$J,358.3,10117,0)
 ;;=N64.59^^45^447^105
 ;;^UTILITY(U,$J,358.3,10117,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10117,1,3,0)
 ;;=3^Signs and Symptoms in Breast,Other
 ;;^UTILITY(U,$J,358.3,10117,1,4,0)
 ;;=4^N64.59
 ;;^UTILITY(U,$J,358.3,10117,2)
 ;;=^5015797
 ;;^UTILITY(U,$J,358.3,10118,0)
 ;;=N64.52^^45^447^71
 ;;^UTILITY(U,$J,358.3,10118,1,0)
 ;;=^358.31IA^4^2

IBDEI0F9 ; ; 03-MAY-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 03, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,38149,1,3,0)
 ;;=3^Sprain of Neck Joints/Ligaments,Init Encntr
 ;;^UTILITY(U,$J,358.3,38149,1,4,0)
 ;;=4^S13.8XXA
 ;;^UTILITY(U,$J,358.3,38149,2)
 ;;=^5022034
 ;;^UTILITY(U,$J,358.3,38150,0)
 ;;=S16.1XXA^^107^1500^39
 ;;^UTILITY(U,$J,358.3,38150,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38150,1,3,0)
 ;;=3^Strain of Neck Muscle/Fasc/Tendon,Init Encntr
 ;;^UTILITY(U,$J,358.3,38150,1,4,0)
 ;;=4^S16.1XXA
 ;;^UTILITY(U,$J,358.3,38150,2)
 ;;=^5022358
 ;;^UTILITY(U,$J,358.3,38151,0)
 ;;=S33.5XXA^^107^1500^12
 ;;^UTILITY(U,$J,358.3,38151,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38151,1,3,0)
 ;;=3^Sprain of Lumbar Spine Ligaments,Init Encntr
 ;;^UTILITY(U,$J,358.3,38151,1,4,0)
 ;;=4^S33.5XXA
 ;;^UTILITY(U,$J,358.3,38151,2)
 ;;=^5025172
 ;;^UTILITY(U,$J,358.3,38152,0)
 ;;=S20.221A^^107^1500^4
 ;;^UTILITY(U,$J,358.3,38152,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38152,1,3,0)
 ;;=3^Contusion,Rt Back Wall of Thorax
 ;;^UTILITY(U,$J,358.3,38152,1,4,0)
 ;;=4^S20.221A
 ;;^UTILITY(U,$J,358.3,38152,2)
 ;;=^5022484
 ;;^UTILITY(U,$J,358.3,38153,0)
 ;;=S20.222A^^107^1500^2
 ;;^UTILITY(U,$J,358.3,38153,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38153,1,3,0)
 ;;=3^Contusion,Lt Back Wall of Thorax
 ;;^UTILITY(U,$J,358.3,38153,1,4,0)
 ;;=4^S20.222A
 ;;^UTILITY(U,$J,358.3,38153,2)
 ;;=^5022487
 ;;^UTILITY(U,$J,358.3,38154,0)
 ;;=S20.223A^^107^1500^1
 ;;^UTILITY(U,$J,358.3,38154,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38154,1,3,0)
 ;;=3^Contusion,Bilateral Back Wall of Thorax
 ;;^UTILITY(U,$J,358.3,38154,1,4,0)
 ;;=4^S20.223A
 ;;^UTILITY(U,$J,358.3,38154,2)
 ;;=^5159315
 ;;^UTILITY(U,$J,358.3,38155,0)
 ;;=S20.224A^^107^1500^3
 ;;^UTILITY(U,$J,358.3,38155,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38155,1,3,0)
 ;;=3^Contusion,Middle Back Wall of Thorax
 ;;^UTILITY(U,$J,358.3,38155,1,4,0)
 ;;=4^S20.224A
 ;;^UTILITY(U,$J,358.3,38155,2)
 ;;=^5159318
 ;;^UTILITY(U,$J,358.3,38156,0)
 ;;=F10.20^^107^1501^9
 ;;^UTILITY(U,$J,358.3,38156,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38156,1,3,0)
 ;;=3^Alcohol Dependence,Uncomplicated
 ;;^UTILITY(U,$J,358.3,38156,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,38156,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,38157,0)
 ;;=F11.29^^107^1501^61
 ;;^UTILITY(U,$J,358.3,38157,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38157,1,3,0)
 ;;=3^Opioid Dependence w/ Unspec Opioid-Induced Disorder
 ;;^UTILITY(U,$J,358.3,38157,1,4,0)
 ;;=4^F11.29
 ;;^UTILITY(U,$J,358.3,38157,2)
 ;;=^5003141
 ;;^UTILITY(U,$J,358.3,38158,0)
 ;;=F11.288^^107^1501^60
 ;;^UTILITY(U,$J,358.3,38158,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38158,1,3,0)
 ;;=3^Opioid Dependence w/ Other Opioid-Induced Disorder
 ;;^UTILITY(U,$J,358.3,38158,1,4,0)
 ;;=4^F11.288
 ;;^UTILITY(U,$J,358.3,38158,2)
 ;;=^5003140
 ;;^UTILITY(U,$J,358.3,38159,0)
 ;;=F11.282^^107^1501^59
 ;;^UTILITY(U,$J,358.3,38159,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38159,1,3,0)
 ;;=3^Opioid Dependence w/ Opioid-Induced Sleep Disorder
 ;;^UTILITY(U,$J,358.3,38159,1,4,0)
 ;;=4^F11.282
 ;;^UTILITY(U,$J,358.3,38159,2)
 ;;=^5003139
 ;;^UTILITY(U,$J,358.3,38160,0)
 ;;=F11.281^^107^1501^58
 ;;^UTILITY(U,$J,358.3,38160,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38160,1,3,0)
 ;;=3^Opioid Dependence w/ Opioid-Induced Sexual Dysfunction
 ;;^UTILITY(U,$J,358.3,38160,1,4,0)
 ;;=4^F11.281
 ;;^UTILITY(U,$J,358.3,38160,2)
 ;;=^5003138
 ;;^UTILITY(U,$J,358.3,38161,0)
 ;;=F11.259^^107^1501^57
 ;;^UTILITY(U,$J,358.3,38161,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38161,1,3,0)
 ;;=3^Opioid Dependence w/ Opioid-Induced Psychotic Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,38161,1,4,0)
 ;;=4^F11.259
 ;;^UTILITY(U,$J,358.3,38161,2)
 ;;=^5003137
 ;;^UTILITY(U,$J,358.3,38162,0)
 ;;=F11.251^^107^1501^50
 ;;^UTILITY(U,$J,358.3,38162,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38162,1,3,0)
 ;;=3^Opioid Depend w/ Opioid-Induc Psychotic Disorder w/ Hallucin
 ;;^UTILITY(U,$J,358.3,38162,1,4,0)
 ;;=4^F11.251
 ;;^UTILITY(U,$J,358.3,38162,2)
 ;;=^5003136
 ;;^UTILITY(U,$J,358.3,38163,0)
 ;;=F11.250^^107^1501^51
 ;;^UTILITY(U,$J,358.3,38163,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38163,1,3,0)
 ;;=3^Opioid Depend w/ Opioid-Induc Psychotic Disorder w/ Delusions
 ;;^UTILITY(U,$J,358.3,38163,1,4,0)
 ;;=4^F11.250
 ;;^UTILITY(U,$J,358.3,38163,2)
 ;;=^5003135
 ;;^UTILITY(U,$J,358.3,38164,0)
 ;;=F11.24^^107^1501^56
 ;;^UTILITY(U,$J,358.3,38164,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38164,1,3,0)
 ;;=3^Opioid Dependence w/ Opioid-Induced Mood Disorder
 ;;^UTILITY(U,$J,358.3,38164,1,4,0)
 ;;=4^F11.24
 ;;^UTILITY(U,$J,358.3,38164,2)
 ;;=^5003134
 ;;^UTILITY(U,$J,358.3,38165,0)
 ;;=F11.23^^107^1501^62
 ;;^UTILITY(U,$J,358.3,38165,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38165,1,3,0)
 ;;=3^Opioid Dependence w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,38165,1,4,0)
 ;;=4^F11.23
 ;;^UTILITY(U,$J,358.3,38165,2)
 ;;=^5003133
 ;;^UTILITY(U,$J,358.3,38166,0)
 ;;=F11.20^^107^1501^63
 ;;^UTILITY(U,$J,358.3,38166,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38166,1,3,0)
 ;;=3^Opioid Dependence,Uncomplicated
 ;;^UTILITY(U,$J,358.3,38166,1,4,0)
 ;;=4^F11.20
 ;;^UTILITY(U,$J,358.3,38166,2)
 ;;=^5003127
 ;;^UTILITY(U,$J,358.3,38167,0)
 ;;=F11.229^^107^1501^55
 ;;^UTILITY(U,$J,358.3,38167,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38167,1,3,0)
 ;;=3^Opioid Dependence w/ Intoxication,Unspec
 ;;^UTILITY(U,$J,358.3,38167,1,4,0)
 ;;=4^F11.229
 ;;^UTILITY(U,$J,358.3,38167,2)
 ;;=^5003132
 ;;^UTILITY(U,$J,358.3,38168,0)
 ;;=F11.222^^107^1501^53
 ;;^UTILITY(U,$J,358.3,38168,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38168,1,3,0)
 ;;=3^Opioid Dependence w/ Intoxication w/ Perceptual Disturbance
 ;;^UTILITY(U,$J,358.3,38168,1,4,0)
 ;;=4^F11.222
 ;;^UTILITY(U,$J,358.3,38168,2)
 ;;=^5003131
 ;;^UTILITY(U,$J,358.3,38169,0)
 ;;=F11.221^^107^1501^52
 ;;^UTILITY(U,$J,358.3,38169,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38169,1,3,0)
 ;;=3^Opioid Dependence w/ Intoxication Delirium
 ;;^UTILITY(U,$J,358.3,38169,1,4,0)
 ;;=4^F11.221
 ;;^UTILITY(U,$J,358.3,38169,2)
 ;;=^5003130
 ;;^UTILITY(U,$J,358.3,38170,0)
 ;;=F11.220^^107^1501^54
 ;;^UTILITY(U,$J,358.3,38170,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38170,1,3,0)
 ;;=3^Opioid Dependence w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,38170,1,4,0)
 ;;=4^F11.220
 ;;^UTILITY(U,$J,358.3,38170,2)
 ;;=^5003129
 ;;^UTILITY(U,$J,358.3,38171,0)
 ;;=F14.29^^107^1501^34
 ;;^UTILITY(U,$J,358.3,38171,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38171,1,3,0)
 ;;=3^Cocaine Dependence w/ Unspec Cocaine-Induced Disorder
 ;;^UTILITY(U,$J,358.3,38171,1,4,0)
 ;;=4^F14.29
 ;;^UTILITY(U,$J,358.3,38171,2)
 ;;=^5003268
 ;;^UTILITY(U,$J,358.3,38172,0)
 ;;=F14.288^^107^1501^33
 ;;^UTILITY(U,$J,358.3,38172,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38172,1,3,0)
 ;;=3^Cocaine Dependence w/ Other Cocaine-Induced Disorder
 ;;^UTILITY(U,$J,358.3,38172,1,4,0)
 ;;=4^F14.288
 ;;^UTILITY(U,$J,358.3,38172,2)
 ;;=^5003267
 ;;^UTILITY(U,$J,358.3,38173,0)
 ;;=F14.282^^107^1501^27
 ;;^UTILITY(U,$J,358.3,38173,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38173,1,3,0)
 ;;=3^Cocaine Dependence w/ Cocaine-Induced Sleep Disorder
 ;;^UTILITY(U,$J,358.3,38173,1,4,0)
 ;;=4^F14.282
 ;;^UTILITY(U,$J,358.3,38173,2)
 ;;=^5003266
 ;;^UTILITY(U,$J,358.3,38174,0)
 ;;=F14.281^^107^1501^28
 ;;^UTILITY(U,$J,358.3,38174,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38174,1,3,0)
 ;;=3^Cocaine Dependence w/ Cocaine-Induced Sexual Dysfunction
 ;;^UTILITY(U,$J,358.3,38174,1,4,0)
 ;;=4^F14.281
 ;;^UTILITY(U,$J,358.3,38174,2)
 ;;=^5003265
 ;;^UTILITY(U,$J,358.3,38175,0)
 ;;=F14.280^^107^1501^25
 ;;^UTILITY(U,$J,358.3,38175,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38175,1,3,0)
 ;;=3^Cocaine Dependence w/ Cocaine-Induced Anxiety Disorder
 ;;^UTILITY(U,$J,358.3,38175,1,4,0)
 ;;=4^F14.280
 ;;^UTILITY(U,$J,358.3,38175,2)
 ;;=^5003264
 ;;^UTILITY(U,$J,358.3,38176,0)
 ;;=F14.259^^107^1501^24
 ;;^UTILITY(U,$J,358.3,38176,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38176,1,3,0)
 ;;=3^Cocaine Dependence w/ Cocaine-Induc Psychotic Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,38176,1,4,0)
 ;;=4^F14.259
 ;;^UTILITY(U,$J,358.3,38176,2)
 ;;=^5003263
 ;;^UTILITY(U,$J,358.3,38177,0)
 ;;=F14.251^^107^1501^23
 ;;^UTILITY(U,$J,358.3,38177,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38177,1,3,0)
 ;;=3^Cocaine Depend w/ Cocaine-Induc Psychotic Disorder w/ Hallucin
 ;;^UTILITY(U,$J,358.3,38177,1,4,0)
 ;;=4^F14.251
 ;;^UTILITY(U,$J,358.3,38177,2)
 ;;=^5003262
 ;;^UTILITY(U,$J,358.3,38178,0)
 ;;=F14.250^^107^1501^22
 ;;^UTILITY(U,$J,358.3,38178,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38178,1,3,0)
 ;;=3^Cocaine Depend w/ Cocaine-Induc Psych Disorder w/ Delusions
 ;;^UTILITY(U,$J,358.3,38178,1,4,0)
 ;;=4^F14.250
 ;;^UTILITY(U,$J,358.3,38178,2)
 ;;=^5003261
 ;;^UTILITY(U,$J,358.3,38179,0)
 ;;=F14.24^^107^1501^26
 ;;^UTILITY(U,$J,358.3,38179,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38179,1,3,0)
 ;;=3^Cocaine Dependence w/ Cocaine-Induced Mood Disorder
 ;;^UTILITY(U,$J,358.3,38179,1,4,0)
 ;;=4^F14.24
 ;;^UTILITY(U,$J,358.3,38179,2)
 ;;=^5003260
 ;;^UTILITY(U,$J,358.3,38180,0)
 ;;=F14.23^^107^1501^35
 ;;^UTILITY(U,$J,358.3,38180,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38180,1,3,0)
 ;;=3^Cocaine Dependence w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,38180,1,4,0)
 ;;=4^F14.23
 ;;^UTILITY(U,$J,358.3,38180,2)
 ;;=^5003259
 ;;^UTILITY(U,$J,358.3,38181,0)
 ;;=F14.229^^107^1501^32
 ;;^UTILITY(U,$J,358.3,38181,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38181,1,3,0)
 ;;=3^Cocaine Dependence w/ Intoxication,Unspec
 ;;^UTILITY(U,$J,358.3,38181,1,4,0)
 ;;=4^F14.229
 ;;^UTILITY(U,$J,358.3,38181,2)
 ;;=^5003258
 ;;^UTILITY(U,$J,358.3,38182,0)
 ;;=F14.222^^107^1501^30
 ;;^UTILITY(U,$J,358.3,38182,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38182,1,3,0)
 ;;=3^Cocaine Dependence w/ Intoxication w/ Perceptual Disturbance
 ;;^UTILITY(U,$J,358.3,38182,1,4,0)
 ;;=4^F14.222
 ;;^UTILITY(U,$J,358.3,38182,2)
 ;;=^5003257
 ;;^UTILITY(U,$J,358.3,38183,0)
 ;;=F14.221^^107^1501^29
 ;;^UTILITY(U,$J,358.3,38183,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38183,1,3,0)
 ;;=3^Cocaine Dependence w/ Intoxication Delirium
 ;;^UTILITY(U,$J,358.3,38183,1,4,0)
 ;;=4^F14.221
 ;;^UTILITY(U,$J,358.3,38183,2)
 ;;=^5003256
 ;;^UTILITY(U,$J,358.3,38184,0)
 ;;=F14.220^^107^1501^31
 ;;^UTILITY(U,$J,358.3,38184,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38184,1,3,0)
 ;;=3^Cocaine Dependence w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,38184,1,4,0)
 ;;=4^F14.220
 ;;^UTILITY(U,$J,358.3,38184,2)
 ;;=^5003255
 ;;^UTILITY(U,$J,358.3,38185,0)
 ;;=F14.20^^107^1501^36
 ;;^UTILITY(U,$J,358.3,38185,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38185,1,3,0)
 ;;=3^Cocaine Dependence,Uncompicated
 ;;^UTILITY(U,$J,358.3,38185,1,4,0)
 ;;=4^F14.20
 ;;^UTILITY(U,$J,358.3,38185,2)
 ;;=^5003253
 ;;^UTILITY(U,$J,358.3,38186,0)
 ;;=F10.120^^107^1501^1
 ;;^UTILITY(U,$J,358.3,38186,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38186,1,3,0)
 ;;=3^Alcohol Abuse w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,38186,1,4,0)
 ;;=4^F10.120
 ;;^UTILITY(U,$J,358.3,38186,2)
 ;;=^5003069
 ;;^UTILITY(U,$J,358.3,38187,0)
 ;;=F10.10^^107^1501^7
 ;;^UTILITY(U,$J,358.3,38187,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38187,1,3,0)
 ;;=3^Alcohol Abuse,Uncomplicated
 ;;^UTILITY(U,$J,358.3,38187,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,38187,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,38188,0)
 ;;=F17.201^^107^1501^41
 ;;^UTILITY(U,$J,358.3,38188,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38188,1,3,0)
 ;;=3^Nicotine Dependence In Remission,Unspec
 ;;^UTILITY(U,$J,358.3,38188,1,4,0)
 ;;=4^F17.201
 ;;^UTILITY(U,$J,358.3,38188,2)
 ;;=^5003361
 ;;^UTILITY(U,$J,358.3,38189,0)
 ;;=F17.210^^107^1501^40
 ;;^UTILITY(U,$J,358.3,38189,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38189,1,3,0)
 ;;=3^Nicotine Dependence Cigarettes,Uncomplicated
 ;;^UTILITY(U,$J,358.3,38189,1,4,0)
 ;;=4^F17.210
 ;;^UTILITY(U,$J,358.3,38189,2)
 ;;=^5003365
 ;;^UTILITY(U,$J,358.3,38190,0)
 ;;=F17.291^^107^1501^42
 ;;^UTILITY(U,$J,358.3,38190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38190,1,3,0)
 ;;=3^Nicotine Dependence Oth Tobacco Product,In Remission
 ;;^UTILITY(U,$J,358.3,38190,1,4,0)
 ;;=4^F17.291
 ;;^UTILITY(U,$J,358.3,38190,2)
 ;;=^5003376
 ;;^UTILITY(U,$J,358.3,38191,0)
 ;;=F17.290^^107^1501^43
 ;;^UTILITY(U,$J,358.3,38191,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38191,1,3,0)
 ;;=3^Nicotine Dependence Oth Tobacco Product,Uncomplicated
 ;;^UTILITY(U,$J,358.3,38191,1,4,0)
 ;;=4^F17.290
 ;;^UTILITY(U,$J,358.3,38191,2)
 ;;=^5003375
 ;;^UTILITY(U,$J,358.3,38192,0)
 ;;=F17.221^^107^1501^37
 ;;^UTILITY(U,$J,358.3,38192,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38192,1,3,0)
 ;;=3^Nicotine Dependence Chewing Tobacco,In Remission
 ;;^UTILITY(U,$J,358.3,38192,1,4,0)
 ;;=4^F17.221
 ;;^UTILITY(U,$J,358.3,38192,2)
 ;;=^5003371
 ;;^UTILITY(U,$J,358.3,38193,0)
 ;;=F17.220^^107^1501^38
 ;;^UTILITY(U,$J,358.3,38193,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38193,1,3,0)
 ;;=3^Nicotine Dependence Chewing Tobacco,Uncomplicated
 ;;^UTILITY(U,$J,358.3,38193,1,4,0)
 ;;=4^F17.220
 ;;^UTILITY(U,$J,358.3,38193,2)
 ;;=^5003370
 ;;^UTILITY(U,$J,358.3,38194,0)
 ;;=F17.211^^107^1501^39
 ;;^UTILITY(U,$J,358.3,38194,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38194,1,3,0)
 ;;=3^Nicotine Dependence Cigarettes,In Remission
 ;;^UTILITY(U,$J,358.3,38194,1,4,0)
 ;;=4^F17.211
 ;;^UTILITY(U,$J,358.3,38194,2)
 ;;=^5003366
 ;;^UTILITY(U,$J,358.3,38195,0)
 ;;=F17.200^^107^1501^44
 ;;^UTILITY(U,$J,358.3,38195,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38195,1,3,0)
 ;;=3^Nicotine Dependence,Unspec,Uncomplicated
 ;;^UTILITY(U,$J,358.3,38195,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,38195,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,38196,0)
 ;;=F11.120^^107^1501^45
 ;;^UTILITY(U,$J,358.3,38196,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38196,1,3,0)
 ;;=3^Opioid Abuse w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,38196,1,4,0)
 ;;=4^F11.120
 ;;^UTILITY(U,$J,358.3,38196,2)
 ;;=^5003115
 ;;^UTILITY(U,$J,358.3,38197,0)
 ;;=F11.10^^107^1501^49
 ;;^UTILITY(U,$J,358.3,38197,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38197,1,3,0)
 ;;=3^Opioid Abuse,Uncomplicated
 ;;^UTILITY(U,$J,358.3,38197,1,4,0)
 ;;=4^F11.10
 ;;^UTILITY(U,$J,358.3,38197,2)
 ;;=^5003114
 ;;^UTILITY(U,$J,358.3,38198,0)
 ;;=F11.129^^107^1501^46
 ;;^UTILITY(U,$J,358.3,38198,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38198,1,3,0)
 ;;=3^Opioid Abuse w/ Intoxication,Unspec
 ;;^UTILITY(U,$J,358.3,38198,1,4,0)
 ;;=4^F11.129
 ;;^UTILITY(U,$J,358.3,38198,2)
 ;;=^5003118
 ;;^UTILITY(U,$J,358.3,38199,0)
 ;;=F10.21^^107^1501^8
 ;;^UTILITY(U,$J,358.3,38199,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38199,1,3,0)
 ;;=3^Alcohol Dependence,In Remission
 ;;^UTILITY(U,$J,358.3,38199,1,4,0)
 ;;=4^F10.21
 ;;^UTILITY(U,$J,358.3,38199,2)
 ;;=^5003082
 ;;^UTILITY(U,$J,358.3,38200,0)
 ;;=F12.10^^107^1501^16
 ;;^UTILITY(U,$J,358.3,38200,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38200,1,3,0)
 ;;=3^Cannabis Abuse,Uncomplicated
 ;;^UTILITY(U,$J,358.3,38200,1,4,0)
 ;;=4^F12.10
 ;;^UTILITY(U,$J,358.3,38200,2)
 ;;=^5003155
 ;;^UTILITY(U,$J,358.3,38201,0)
 ;;=F12.20^^107^1501^18
 ;;^UTILITY(U,$J,358.3,38201,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38201,1,3,0)
 ;;=3^Cannabis Dependence,Uncomplicated
 ;;^UTILITY(U,$J,358.3,38201,1,4,0)
 ;;=4^F12.20
 ;;^UTILITY(U,$J,358.3,38201,2)
 ;;=^5003166
 ;;^UTILITY(U,$J,358.3,38202,0)
 ;;=F12.21^^107^1501^17
 ;;^UTILITY(U,$J,358.3,38202,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38202,1,3,0)
 ;;=3^Cannabis Dependence,In Remission
 ;;^UTILITY(U,$J,358.3,38202,1,4,0)
 ;;=4^F12.21
 ;;^UTILITY(U,$J,358.3,38202,2)
 ;;=^5003167
 ;;^UTILITY(U,$J,358.3,38203,0)
 ;;=F12.90^^107^1501^20
 ;;^UTILITY(U,$J,358.3,38203,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38203,1,3,0)
 ;;=3^Cannabis Use,Unspec,Uncomplicated
 ;;^UTILITY(U,$J,358.3,38203,1,4,0)
 ;;=4^F12.90
 ;;^UTILITY(U,$J,358.3,38203,2)
 ;;=^5003178
 ;;^UTILITY(U,$J,358.3,38204,0)
 ;;=F10.11^^107^1501^6
 ;;^UTILITY(U,$J,358.3,38204,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38204,1,3,0)
 ;;=3^Alcohol Abuse,In Remission
 ;;^UTILITY(U,$J,358.3,38204,1,4,0)
 ;;=4^F10.11
 ;;^UTILITY(U,$J,358.3,38204,2)
 ;;=^268230
 ;;^UTILITY(U,$J,358.3,38205,0)
 ;;=F12.11^^107^1501^15
 ;;^UTILITY(U,$J,358.3,38205,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38205,1,3,0)
 ;;=3^Cannabis Abuse,In Remission
 ;;^UTILITY(U,$J,358.3,38205,1,4,0)
 ;;=4^F12.11
 ;;^UTILITY(U,$J,358.3,38205,2)
 ;;=^268236
 ;;^UTILITY(U,$J,358.3,38206,0)
 ;;=F14.11^^107^1501^21
 ;;^UTILITY(U,$J,358.3,38206,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38206,1,3,0)
 ;;=3^Cocaine Abuse,In Remission
 ;;^UTILITY(U,$J,358.3,38206,1,4,0)
 ;;=4^F14.11
 ;;^UTILITY(U,$J,358.3,38206,2)
 ;;=^268249
 ;;^UTILITY(U,$J,358.3,38207,0)
 ;;=F11.11^^107^1501^48
 ;;^UTILITY(U,$J,358.3,38207,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38207,1,3,0)
 ;;=3^Opioid Abuse,In Remission
 ;;^UTILITY(U,$J,358.3,38207,1,4,0)
 ;;=4^F11.11
 ;;^UTILITY(U,$J,358.3,38207,2)
 ;;=^268246
 ;;^UTILITY(U,$J,358.3,38208,0)
 ;;=F12.93^^107^1501^19
 ;;^UTILITY(U,$J,358.3,38208,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38208,1,3,0)
 ;;=3^Cannabis Use,Unspec w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,38208,1,4,0)
 ;;=4^F12.93
 ;;^UTILITY(U,$J,358.3,38208,2)
 ;;=^5157302
 ;;^UTILITY(U,$J,358.3,38209,0)
 ;;=F10.130^^107^1501^4
 ;;^UTILITY(U,$J,358.3,38209,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38209,1,3,0)
 ;;=3^Alcohol Abuse w/ Withdrawal,Uncomp
 ;;^UTILITY(U,$J,358.3,38209,1,4,0)
 ;;=4^F10.130
 ;;^UTILITY(U,$J,358.3,38209,2)
 ;;=^5159130
 ;;^UTILITY(U,$J,358.3,38210,0)
 ;;=F10.131^^107^1501^2
 ;;^UTILITY(U,$J,358.3,38210,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38210,1,3,0)
 ;;=3^Alcohol Abuse w/ Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,38210,1,4,0)
 ;;=4^F10.131
 ;;^UTILITY(U,$J,358.3,38210,2)
 ;;=^5159131
 ;;^UTILITY(U,$J,358.3,38211,0)
 ;;=F10.132^^107^1501^3
 ;;^UTILITY(U,$J,358.3,38211,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38211,1,3,0)
 ;;=3^Alcohol Abuse w/ Withdrawal w/ Perceptual Disturbance
 ;;^UTILITY(U,$J,358.3,38211,1,4,0)
 ;;=4^F10.132
 ;;^UTILITY(U,$J,358.3,38211,2)
 ;;=^5159132
 ;;^UTILITY(U,$J,358.3,38212,0)
 ;;=F10.139^^107^1501^5
 ;;^UTILITY(U,$J,358.3,38212,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38212,1,3,0)
 ;;=3^Alcohol Abuse w/ Withdrawal,Unspec
 ;;^UTILITY(U,$J,358.3,38212,1,4,0)
 ;;=4^F10.139
 ;;^UTILITY(U,$J,358.3,38212,2)
 ;;=^5159133
 ;;^UTILITY(U,$J,358.3,38213,0)
 ;;=F10.930^^107^1501^12
 ;;^UTILITY(U,$J,358.3,38213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38213,1,3,0)
 ;;=3^Alcohol Use,Unspec w/ Withdrawal,Uncomp
 ;;^UTILITY(U,$J,358.3,38213,1,4,0)
 ;;=4^F10.930
 ;;^UTILITY(U,$J,358.3,38213,2)
 ;;=^5159134
 ;;^UTILITY(U,$J,358.3,38214,0)
 ;;=F10.931^^107^1501^10
 ;;^UTILITY(U,$J,358.3,38214,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38214,1,3,0)
 ;;=3^Alcohol Use,Unspec w/ Withdrawal Delirium

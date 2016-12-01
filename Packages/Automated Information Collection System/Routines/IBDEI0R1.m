IBDEI0R1 ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,35739,2)
 ;;=^5031838
 ;;^UTILITY(U,$J,358.3,35740,0)
 ;;=S56.512A^^100^1520^19
 ;;^UTILITY(U,$J,358.3,35740,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35740,1,3,0)
 ;;=3^Strain of Left Forearm Extn Musc/Fasc/Tend
 ;;^UTILITY(U,$J,358.3,35740,1,4,0)
 ;;=4^S56.512A
 ;;^UTILITY(U,$J,358.3,35740,2)
 ;;=^5031841
 ;;^UTILITY(U,$J,358.3,35741,0)
 ;;=S13.8XXA^^100^1520^10
 ;;^UTILITY(U,$J,358.3,35741,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35741,1,3,0)
 ;;=3^Sprain of Neck Joints/Ligaments,Init Encntr
 ;;^UTILITY(U,$J,358.3,35741,1,4,0)
 ;;=4^S13.8XXA
 ;;^UTILITY(U,$J,358.3,35741,2)
 ;;=^5022034
 ;;^UTILITY(U,$J,358.3,35742,0)
 ;;=S16.1XXA^^100^1520^37
 ;;^UTILITY(U,$J,358.3,35742,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35742,1,3,0)
 ;;=3^Strain of Neck Muscle/Fasc/Tendon,Init Encntr
 ;;^UTILITY(U,$J,358.3,35742,1,4,0)
 ;;=4^S16.1XXA
 ;;^UTILITY(U,$J,358.3,35742,2)
 ;;=^5022358
 ;;^UTILITY(U,$J,358.3,35743,0)
 ;;=S33.5XXA^^100^1520^8
 ;;^UTILITY(U,$J,358.3,35743,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35743,1,3,0)
 ;;=3^Sprain of Lumbar Spine Ligaments,Init Encntr
 ;;^UTILITY(U,$J,358.3,35743,1,4,0)
 ;;=4^S33.5XXA
 ;;^UTILITY(U,$J,358.3,35743,2)
 ;;=^5025172
 ;;^UTILITY(U,$J,358.3,35744,0)
 ;;=F10.20^^100^1521^4
 ;;^UTILITY(U,$J,358.3,35744,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35744,1,3,0)
 ;;=3^Alcohol Dependence,Uncomplicated
 ;;^UTILITY(U,$J,358.3,35744,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,35744,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,35745,0)
 ;;=F11.29^^100^1521^46
 ;;^UTILITY(U,$J,358.3,35745,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35745,1,3,0)
 ;;=3^Opioid Dependence w/ Unspec Opioid-Induced Disorder
 ;;^UTILITY(U,$J,358.3,35745,1,4,0)
 ;;=4^F11.29
 ;;^UTILITY(U,$J,358.3,35745,2)
 ;;=^5003141
 ;;^UTILITY(U,$J,358.3,35746,0)
 ;;=F11.288^^100^1521^45
 ;;^UTILITY(U,$J,358.3,35746,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35746,1,3,0)
 ;;=3^Opioid Dependence w/ Other Opioid-Induced Disorder
 ;;^UTILITY(U,$J,358.3,35746,1,4,0)
 ;;=4^F11.288
 ;;^UTILITY(U,$J,358.3,35746,2)
 ;;=^5003140
 ;;^UTILITY(U,$J,358.3,35747,0)
 ;;=F11.282^^100^1521^44
 ;;^UTILITY(U,$J,358.3,35747,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35747,1,3,0)
 ;;=3^Opioid Dependence w/ Opioid-Induced Sleep Disorder
 ;;^UTILITY(U,$J,358.3,35747,1,4,0)
 ;;=4^F11.282
 ;;^UTILITY(U,$J,358.3,35747,2)
 ;;=^5003139
 ;;^UTILITY(U,$J,358.3,35748,0)
 ;;=F11.281^^100^1521^43
 ;;^UTILITY(U,$J,358.3,35748,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35748,1,3,0)
 ;;=3^Opioid Dependence w/ Opioid-Induced Sexual Dysfunction
 ;;^UTILITY(U,$J,358.3,35748,1,4,0)
 ;;=4^F11.281
 ;;^UTILITY(U,$J,358.3,35748,2)
 ;;=^5003138
 ;;^UTILITY(U,$J,358.3,35749,0)
 ;;=F11.259^^100^1521^42
 ;;^UTILITY(U,$J,358.3,35749,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35749,1,3,0)
 ;;=3^Opioid Dependence w/ Opioid-Induced Psychotic Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,35749,1,4,0)
 ;;=4^F11.259
 ;;^UTILITY(U,$J,358.3,35749,2)
 ;;=^5003137
 ;;^UTILITY(U,$J,358.3,35750,0)
 ;;=F11.251^^100^1521^35
 ;;^UTILITY(U,$J,358.3,35750,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35750,1,3,0)
 ;;=3^Opioid Depend w/ Opioid-Induc Psychotic Disorder w/ Hallucin
 ;;^UTILITY(U,$J,358.3,35750,1,4,0)
 ;;=4^F11.251
 ;;^UTILITY(U,$J,358.3,35750,2)
 ;;=^5003136
 ;;^UTILITY(U,$J,358.3,35751,0)
 ;;=F11.250^^100^1521^36
 ;;^UTILITY(U,$J,358.3,35751,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35751,1,3,0)
 ;;=3^Opioid Depend w/ Opioid-Induc Psychotic Disorder w/ Delusions
 ;;^UTILITY(U,$J,358.3,35751,1,4,0)
 ;;=4^F11.250
 ;;^UTILITY(U,$J,358.3,35751,2)
 ;;=^5003135
 ;;^UTILITY(U,$J,358.3,35752,0)
 ;;=F11.24^^100^1521^41
 ;;^UTILITY(U,$J,358.3,35752,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35752,1,3,0)
 ;;=3^Opioid Dependence w/ Opioid-Induced Mood Disorder
 ;;^UTILITY(U,$J,358.3,35752,1,4,0)
 ;;=4^F11.24
 ;;^UTILITY(U,$J,358.3,35752,2)
 ;;=^5003134
 ;;^UTILITY(U,$J,358.3,35753,0)
 ;;=F11.23^^100^1521^47
 ;;^UTILITY(U,$J,358.3,35753,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35753,1,3,0)
 ;;=3^Opioid Dependence w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,35753,1,4,0)
 ;;=4^F11.23
 ;;^UTILITY(U,$J,358.3,35753,2)
 ;;=^5003133
 ;;^UTILITY(U,$J,358.3,35754,0)
 ;;=F11.20^^100^1521^48
 ;;^UTILITY(U,$J,358.3,35754,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35754,1,3,0)
 ;;=3^Opioid Dependence,Uncomplicated
 ;;^UTILITY(U,$J,358.3,35754,1,4,0)
 ;;=4^F11.20
 ;;^UTILITY(U,$J,358.3,35754,2)
 ;;=^5003127
 ;;^UTILITY(U,$J,358.3,35755,0)
 ;;=F11.229^^100^1521^40
 ;;^UTILITY(U,$J,358.3,35755,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35755,1,3,0)
 ;;=3^Opioid Dependence w/ Intoxication,Unspec
 ;;^UTILITY(U,$J,358.3,35755,1,4,0)
 ;;=4^F11.229
 ;;^UTILITY(U,$J,358.3,35755,2)
 ;;=^5003132
 ;;^UTILITY(U,$J,358.3,35756,0)
 ;;=F11.222^^100^1521^38
 ;;^UTILITY(U,$J,358.3,35756,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35756,1,3,0)
 ;;=3^Opioid Dependence w/ Intoxication w/ Perceptual Disturbance
 ;;^UTILITY(U,$J,358.3,35756,1,4,0)
 ;;=4^F11.222
 ;;^UTILITY(U,$J,358.3,35756,2)
 ;;=^5003131
 ;;^UTILITY(U,$J,358.3,35757,0)
 ;;=F11.221^^100^1521^37
 ;;^UTILITY(U,$J,358.3,35757,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35757,1,3,0)
 ;;=3^Opioid Dependence w/ Intoxication Delirium
 ;;^UTILITY(U,$J,358.3,35757,1,4,0)
 ;;=4^F11.221
 ;;^UTILITY(U,$J,358.3,35757,2)
 ;;=^5003130
 ;;^UTILITY(U,$J,358.3,35758,0)
 ;;=F11.220^^100^1521^39
 ;;^UTILITY(U,$J,358.3,35758,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35758,1,3,0)
 ;;=3^Opioid Dependence w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,35758,1,4,0)
 ;;=4^F11.220
 ;;^UTILITY(U,$J,358.3,35758,2)
 ;;=^5003129
 ;;^UTILITY(U,$J,358.3,35759,0)
 ;;=F14.29^^100^1521^21
 ;;^UTILITY(U,$J,358.3,35759,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35759,1,3,0)
 ;;=3^Cocaine Dependence w/ Unspec Cocaine-Induced Disorder
 ;;^UTILITY(U,$J,358.3,35759,1,4,0)
 ;;=4^F14.29
 ;;^UTILITY(U,$J,358.3,35759,2)
 ;;=^5003268
 ;;^UTILITY(U,$J,358.3,35760,0)
 ;;=F14.288^^100^1521^20
 ;;^UTILITY(U,$J,358.3,35760,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35760,1,3,0)
 ;;=3^Cocaine Dependence w/ Other Cocaine-Induced Disorder
 ;;^UTILITY(U,$J,358.3,35760,1,4,0)
 ;;=4^F14.288
 ;;^UTILITY(U,$J,358.3,35760,2)
 ;;=^5003267
 ;;^UTILITY(U,$J,358.3,35761,0)
 ;;=F14.282^^100^1521^14
 ;;^UTILITY(U,$J,358.3,35761,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35761,1,3,0)
 ;;=3^Cocaine Dependence w/ Cocaine-Induced Sleep Disorder
 ;;^UTILITY(U,$J,358.3,35761,1,4,0)
 ;;=4^F14.282
 ;;^UTILITY(U,$J,358.3,35761,2)
 ;;=^5003266
 ;;^UTILITY(U,$J,358.3,35762,0)
 ;;=F14.281^^100^1521^15
 ;;^UTILITY(U,$J,358.3,35762,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35762,1,3,0)
 ;;=3^Cocaine Dependence w/ Cocaine-Induced Sexual Dysfunction
 ;;^UTILITY(U,$J,358.3,35762,1,4,0)
 ;;=4^F14.281
 ;;^UTILITY(U,$J,358.3,35762,2)
 ;;=^5003265
 ;;^UTILITY(U,$J,358.3,35763,0)
 ;;=F14.280^^100^1521^12
 ;;^UTILITY(U,$J,358.3,35763,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35763,1,3,0)
 ;;=3^Cocaine Dependence w/ Cocaine-Induced Anxiety Disorder
 ;;^UTILITY(U,$J,358.3,35763,1,4,0)
 ;;=4^F14.280
 ;;^UTILITY(U,$J,358.3,35763,2)
 ;;=^5003264
 ;;^UTILITY(U,$J,358.3,35764,0)
 ;;=F14.259^^100^1521^11
 ;;^UTILITY(U,$J,358.3,35764,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35764,1,3,0)
 ;;=3^Cocaine Dependence w/ Cocaine-Induc Psychotic Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,35764,1,4,0)
 ;;=4^F14.259
 ;;^UTILITY(U,$J,358.3,35764,2)
 ;;=^5003263
 ;;^UTILITY(U,$J,358.3,35765,0)
 ;;=F14.251^^100^1521^10
 ;;^UTILITY(U,$J,358.3,35765,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35765,1,3,0)
 ;;=3^Cocaine Depend w/ Cocaine-Induc Psychotic Disorder w/ Hallucin
 ;;^UTILITY(U,$J,358.3,35765,1,4,0)
 ;;=4^F14.251
 ;;^UTILITY(U,$J,358.3,35765,2)
 ;;=^5003262
 ;;^UTILITY(U,$J,358.3,35766,0)
 ;;=F14.250^^100^1521^9
 ;;^UTILITY(U,$J,358.3,35766,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35766,1,3,0)
 ;;=3^Cocaine Depend w/ Cocaine-Induc Psych Disorder w/ Delusions
 ;;^UTILITY(U,$J,358.3,35766,1,4,0)
 ;;=4^F14.250
 ;;^UTILITY(U,$J,358.3,35766,2)
 ;;=^5003261
 ;;^UTILITY(U,$J,358.3,35767,0)
 ;;=F14.24^^100^1521^13
 ;;^UTILITY(U,$J,358.3,35767,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35767,1,3,0)
 ;;=3^Cocaine Dependence w/ Cocaine-Induced Mood Disorder
 ;;^UTILITY(U,$J,358.3,35767,1,4,0)
 ;;=4^F14.24
 ;;^UTILITY(U,$J,358.3,35767,2)
 ;;=^5003260
 ;;^UTILITY(U,$J,358.3,35768,0)
 ;;=F14.23^^100^1521^22
 ;;^UTILITY(U,$J,358.3,35768,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35768,1,3,0)
 ;;=3^Cocaine Dependence w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,35768,1,4,0)
 ;;=4^F14.23
 ;;^UTILITY(U,$J,358.3,35768,2)
 ;;=^5003259
 ;;^UTILITY(U,$J,358.3,35769,0)
 ;;=F14.229^^100^1521^19
 ;;^UTILITY(U,$J,358.3,35769,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35769,1,3,0)
 ;;=3^Cocaine Dependence w/ Intoxication,Unspec
 ;;^UTILITY(U,$J,358.3,35769,1,4,0)
 ;;=4^F14.229
 ;;^UTILITY(U,$J,358.3,35769,2)
 ;;=^5003258
 ;;^UTILITY(U,$J,358.3,35770,0)
 ;;=F14.222^^100^1521^17
 ;;^UTILITY(U,$J,358.3,35770,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35770,1,3,0)
 ;;=3^Cocaine Dependence w/ Intoxication w/ Perceptual Disturbance
 ;;^UTILITY(U,$J,358.3,35770,1,4,0)
 ;;=4^F14.222
 ;;^UTILITY(U,$J,358.3,35770,2)
 ;;=^5003257
 ;;^UTILITY(U,$J,358.3,35771,0)
 ;;=F14.221^^100^1521^16
 ;;^UTILITY(U,$J,358.3,35771,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35771,1,3,0)
 ;;=3^Cocaine Dependence w/ Intoxication Delirium
 ;;^UTILITY(U,$J,358.3,35771,1,4,0)
 ;;=4^F14.221
 ;;^UTILITY(U,$J,358.3,35771,2)
 ;;=^5003256
 ;;^UTILITY(U,$J,358.3,35772,0)
 ;;=F14.220^^100^1521^18
 ;;^UTILITY(U,$J,358.3,35772,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35772,1,3,0)
 ;;=3^Cocaine Dependence w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,35772,1,4,0)
 ;;=4^F14.220
 ;;^UTILITY(U,$J,358.3,35772,2)
 ;;=^5003255

IBDEI1PN ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,28621,1,4,0)
 ;;=4^F11.24
 ;;^UTILITY(U,$J,358.3,28621,2)
 ;;=^5003134
 ;;^UTILITY(U,$J,358.3,28622,0)
 ;;=F11.23^^132^1334^47
 ;;^UTILITY(U,$J,358.3,28622,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28622,1,3,0)
 ;;=3^Opioid Dependence w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,28622,1,4,0)
 ;;=4^F11.23
 ;;^UTILITY(U,$J,358.3,28622,2)
 ;;=^5003133
 ;;^UTILITY(U,$J,358.3,28623,0)
 ;;=F11.20^^132^1334^48
 ;;^UTILITY(U,$J,358.3,28623,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28623,1,3,0)
 ;;=3^Opioid Dependence,Uncomplicated
 ;;^UTILITY(U,$J,358.3,28623,1,4,0)
 ;;=4^F11.20
 ;;^UTILITY(U,$J,358.3,28623,2)
 ;;=^5003127
 ;;^UTILITY(U,$J,358.3,28624,0)
 ;;=F11.229^^132^1334^40
 ;;^UTILITY(U,$J,358.3,28624,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28624,1,3,0)
 ;;=3^Opioid Dependence w/ Intoxication,Unspec
 ;;^UTILITY(U,$J,358.3,28624,1,4,0)
 ;;=4^F11.229
 ;;^UTILITY(U,$J,358.3,28624,2)
 ;;=^5003132
 ;;^UTILITY(U,$J,358.3,28625,0)
 ;;=F11.222^^132^1334^38
 ;;^UTILITY(U,$J,358.3,28625,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28625,1,3,0)
 ;;=3^Opioid Dependence w/ Intoxication w/ Perceptual Disturbance
 ;;^UTILITY(U,$J,358.3,28625,1,4,0)
 ;;=4^F11.222
 ;;^UTILITY(U,$J,358.3,28625,2)
 ;;=^5003131
 ;;^UTILITY(U,$J,358.3,28626,0)
 ;;=F11.221^^132^1334^37
 ;;^UTILITY(U,$J,358.3,28626,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28626,1,3,0)
 ;;=3^Opioid Dependence w/ Intoxication Delirium
 ;;^UTILITY(U,$J,358.3,28626,1,4,0)
 ;;=4^F11.221
 ;;^UTILITY(U,$J,358.3,28626,2)
 ;;=^5003130
 ;;^UTILITY(U,$J,358.3,28627,0)
 ;;=F11.220^^132^1334^39
 ;;^UTILITY(U,$J,358.3,28627,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28627,1,3,0)
 ;;=3^Opioid Dependence w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,28627,1,4,0)
 ;;=4^F11.220
 ;;^UTILITY(U,$J,358.3,28627,2)
 ;;=^5003129
 ;;^UTILITY(U,$J,358.3,28628,0)
 ;;=F14.29^^132^1334^21
 ;;^UTILITY(U,$J,358.3,28628,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28628,1,3,0)
 ;;=3^Cocaine Dependence w/ Unspec Cocaine-Induced Disorder
 ;;^UTILITY(U,$J,358.3,28628,1,4,0)
 ;;=4^F14.29
 ;;^UTILITY(U,$J,358.3,28628,2)
 ;;=^5003268
 ;;^UTILITY(U,$J,358.3,28629,0)
 ;;=F14.288^^132^1334^20
 ;;^UTILITY(U,$J,358.3,28629,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28629,1,3,0)
 ;;=3^Cocaine Dependence w/ Other Cocaine-Induced Disorder
 ;;^UTILITY(U,$J,358.3,28629,1,4,0)
 ;;=4^F14.288
 ;;^UTILITY(U,$J,358.3,28629,2)
 ;;=^5003267
 ;;^UTILITY(U,$J,358.3,28630,0)
 ;;=F14.282^^132^1334^14
 ;;^UTILITY(U,$J,358.3,28630,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28630,1,3,0)
 ;;=3^Cocaine Dependence w/ Cocaine-Induced Sleep Disorder
 ;;^UTILITY(U,$J,358.3,28630,1,4,0)
 ;;=4^F14.282
 ;;^UTILITY(U,$J,358.3,28630,2)
 ;;=^5003266
 ;;^UTILITY(U,$J,358.3,28631,0)
 ;;=F14.281^^132^1334^15
 ;;^UTILITY(U,$J,358.3,28631,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28631,1,3,0)
 ;;=3^Cocaine Dependence w/ Cocaine-Induced Sexual Dysfunction
 ;;^UTILITY(U,$J,358.3,28631,1,4,0)
 ;;=4^F14.281
 ;;^UTILITY(U,$J,358.3,28631,2)
 ;;=^5003265
 ;;^UTILITY(U,$J,358.3,28632,0)
 ;;=F14.280^^132^1334^12
 ;;^UTILITY(U,$J,358.3,28632,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28632,1,3,0)
 ;;=3^Cocaine Dependence w/ Cocaine-Induced Anxiety Disorder
 ;;^UTILITY(U,$J,358.3,28632,1,4,0)
 ;;=4^F14.280
 ;;^UTILITY(U,$J,358.3,28632,2)
 ;;=^5003264
 ;;^UTILITY(U,$J,358.3,28633,0)
 ;;=F14.259^^132^1334^11
 ;;^UTILITY(U,$J,358.3,28633,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28633,1,3,0)
 ;;=3^Cocaine Dependence w/ Cocaine-Induc Psychotic Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,28633,1,4,0)
 ;;=4^F14.259

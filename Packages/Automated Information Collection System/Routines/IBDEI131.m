IBDEI131 ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,17580,1,3,0)
 ;;=3^Opioid Dependence w/ Opioid-Induced Mood Disorder
 ;;^UTILITY(U,$J,358.3,17580,1,4,0)
 ;;=4^F11.24
 ;;^UTILITY(U,$J,358.3,17580,2)
 ;;=^5003134
 ;;^UTILITY(U,$J,358.3,17581,0)
 ;;=F11.23^^61^789^62
 ;;^UTILITY(U,$J,358.3,17581,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17581,1,3,0)
 ;;=3^Opioid Dependence w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,17581,1,4,0)
 ;;=4^F11.23
 ;;^UTILITY(U,$J,358.3,17581,2)
 ;;=^5003133
 ;;^UTILITY(U,$J,358.3,17582,0)
 ;;=F11.20^^61^789^63
 ;;^UTILITY(U,$J,358.3,17582,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17582,1,3,0)
 ;;=3^Opioid Dependence,Uncomplicated
 ;;^UTILITY(U,$J,358.3,17582,1,4,0)
 ;;=4^F11.20
 ;;^UTILITY(U,$J,358.3,17582,2)
 ;;=^5003127
 ;;^UTILITY(U,$J,358.3,17583,0)
 ;;=F11.229^^61^789^55
 ;;^UTILITY(U,$J,358.3,17583,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17583,1,3,0)
 ;;=3^Opioid Dependence w/ Intoxication,Unspec
 ;;^UTILITY(U,$J,358.3,17583,1,4,0)
 ;;=4^F11.229
 ;;^UTILITY(U,$J,358.3,17583,2)
 ;;=^5003132
 ;;^UTILITY(U,$J,358.3,17584,0)
 ;;=F11.222^^61^789^53
 ;;^UTILITY(U,$J,358.3,17584,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17584,1,3,0)
 ;;=3^Opioid Dependence w/ Intoxication w/ Perceptual Disturbance
 ;;^UTILITY(U,$J,358.3,17584,1,4,0)
 ;;=4^F11.222
 ;;^UTILITY(U,$J,358.3,17584,2)
 ;;=^5003131
 ;;^UTILITY(U,$J,358.3,17585,0)
 ;;=F11.221^^61^789^52
 ;;^UTILITY(U,$J,358.3,17585,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17585,1,3,0)
 ;;=3^Opioid Dependence w/ Intoxication Delirium
 ;;^UTILITY(U,$J,358.3,17585,1,4,0)
 ;;=4^F11.221
 ;;^UTILITY(U,$J,358.3,17585,2)
 ;;=^5003130
 ;;^UTILITY(U,$J,358.3,17586,0)
 ;;=F11.220^^61^789^54
 ;;^UTILITY(U,$J,358.3,17586,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17586,1,3,0)
 ;;=3^Opioid Dependence w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,17586,1,4,0)
 ;;=4^F11.220
 ;;^UTILITY(U,$J,358.3,17586,2)
 ;;=^5003129
 ;;^UTILITY(U,$J,358.3,17587,0)
 ;;=F14.29^^61^789^34
 ;;^UTILITY(U,$J,358.3,17587,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17587,1,3,0)
 ;;=3^Cocaine Dependence w/ Unspec Cocaine-Induced Disorder
 ;;^UTILITY(U,$J,358.3,17587,1,4,0)
 ;;=4^F14.29
 ;;^UTILITY(U,$J,358.3,17587,2)
 ;;=^5003268
 ;;^UTILITY(U,$J,358.3,17588,0)
 ;;=F14.288^^61^789^33
 ;;^UTILITY(U,$J,358.3,17588,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17588,1,3,0)
 ;;=3^Cocaine Dependence w/ Other Cocaine-Induced Disorder
 ;;^UTILITY(U,$J,358.3,17588,1,4,0)
 ;;=4^F14.288
 ;;^UTILITY(U,$J,358.3,17588,2)
 ;;=^5003267
 ;;^UTILITY(U,$J,358.3,17589,0)
 ;;=F14.282^^61^789^27
 ;;^UTILITY(U,$J,358.3,17589,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17589,1,3,0)
 ;;=3^Cocaine Dependence w/ Cocaine-Induced Sleep Disorder
 ;;^UTILITY(U,$J,358.3,17589,1,4,0)
 ;;=4^F14.282
 ;;^UTILITY(U,$J,358.3,17589,2)
 ;;=^5003266
 ;;^UTILITY(U,$J,358.3,17590,0)
 ;;=F14.281^^61^789^28
 ;;^UTILITY(U,$J,358.3,17590,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17590,1,3,0)
 ;;=3^Cocaine Dependence w/ Cocaine-Induced Sexual Dysfunction
 ;;^UTILITY(U,$J,358.3,17590,1,4,0)
 ;;=4^F14.281
 ;;^UTILITY(U,$J,358.3,17590,2)
 ;;=^5003265
 ;;^UTILITY(U,$J,358.3,17591,0)
 ;;=F14.280^^61^789^25
 ;;^UTILITY(U,$J,358.3,17591,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17591,1,3,0)
 ;;=3^Cocaine Dependence w/ Cocaine-Induced Anxiety Disorder
 ;;^UTILITY(U,$J,358.3,17591,1,4,0)
 ;;=4^F14.280
 ;;^UTILITY(U,$J,358.3,17591,2)
 ;;=^5003264

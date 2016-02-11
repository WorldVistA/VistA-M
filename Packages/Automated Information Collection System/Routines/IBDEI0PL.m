IBDEI0PL ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,11721,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11721,1,3,0)
 ;;=3^Opioid Dependence w/ Intoxication,Unspec
 ;;^UTILITY(U,$J,358.3,11721,1,4,0)
 ;;=4^F11.229
 ;;^UTILITY(U,$J,358.3,11721,2)
 ;;=^5003132
 ;;^UTILITY(U,$J,358.3,11722,0)
 ;;=F11.222^^68^689^38
 ;;^UTILITY(U,$J,358.3,11722,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11722,1,3,0)
 ;;=3^Opioid Dependence w/ Intoxication w/ Perceptual Disturbance
 ;;^UTILITY(U,$J,358.3,11722,1,4,0)
 ;;=4^F11.222
 ;;^UTILITY(U,$J,358.3,11722,2)
 ;;=^5003131
 ;;^UTILITY(U,$J,358.3,11723,0)
 ;;=F11.221^^68^689^37
 ;;^UTILITY(U,$J,358.3,11723,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11723,1,3,0)
 ;;=3^Opioid Dependence w/ Intoxication Delirium
 ;;^UTILITY(U,$J,358.3,11723,1,4,0)
 ;;=4^F11.221
 ;;^UTILITY(U,$J,358.3,11723,2)
 ;;=^5003130
 ;;^UTILITY(U,$J,358.3,11724,0)
 ;;=F11.220^^68^689^39
 ;;^UTILITY(U,$J,358.3,11724,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11724,1,3,0)
 ;;=3^Opioid Dependence w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,11724,1,4,0)
 ;;=4^F11.220
 ;;^UTILITY(U,$J,358.3,11724,2)
 ;;=^5003129
 ;;^UTILITY(U,$J,358.3,11725,0)
 ;;=F14.29^^68^689^21
 ;;^UTILITY(U,$J,358.3,11725,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11725,1,3,0)
 ;;=3^Cocaine Dependence w/ Unspec Cocaine-Induced Disorder
 ;;^UTILITY(U,$J,358.3,11725,1,4,0)
 ;;=4^F14.29
 ;;^UTILITY(U,$J,358.3,11725,2)
 ;;=^5003268
 ;;^UTILITY(U,$J,358.3,11726,0)
 ;;=F14.288^^68^689^20
 ;;^UTILITY(U,$J,358.3,11726,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11726,1,3,0)
 ;;=3^Cocaine Dependence w/ Other Cocaine-Induced Disorder
 ;;^UTILITY(U,$J,358.3,11726,1,4,0)
 ;;=4^F14.288
 ;;^UTILITY(U,$J,358.3,11726,2)
 ;;=^5003267
 ;;^UTILITY(U,$J,358.3,11727,0)
 ;;=F14.282^^68^689^14
 ;;^UTILITY(U,$J,358.3,11727,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11727,1,3,0)
 ;;=3^Cocaine Dependence w/ Cocaine-Induced Sleep Disorder
 ;;^UTILITY(U,$J,358.3,11727,1,4,0)
 ;;=4^F14.282
 ;;^UTILITY(U,$J,358.3,11727,2)
 ;;=^5003266
 ;;^UTILITY(U,$J,358.3,11728,0)
 ;;=F14.281^^68^689^15
 ;;^UTILITY(U,$J,358.3,11728,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11728,1,3,0)
 ;;=3^Cocaine Dependence w/ Cocaine-Induced Sexual Dysfunction
 ;;^UTILITY(U,$J,358.3,11728,1,4,0)
 ;;=4^F14.281
 ;;^UTILITY(U,$J,358.3,11728,2)
 ;;=^5003265
 ;;^UTILITY(U,$J,358.3,11729,0)
 ;;=F14.280^^68^689^12
 ;;^UTILITY(U,$J,358.3,11729,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11729,1,3,0)
 ;;=3^Cocaine Dependence w/ Cocaine-Induced Anxiety Disorder
 ;;^UTILITY(U,$J,358.3,11729,1,4,0)
 ;;=4^F14.280
 ;;^UTILITY(U,$J,358.3,11729,2)
 ;;=^5003264
 ;;^UTILITY(U,$J,358.3,11730,0)
 ;;=F14.259^^68^689^11
 ;;^UTILITY(U,$J,358.3,11730,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11730,1,3,0)
 ;;=3^Cocaine Dependence w/ Cocaine-Induc Psychotic Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,11730,1,4,0)
 ;;=4^F14.259
 ;;^UTILITY(U,$J,358.3,11730,2)
 ;;=^5003263
 ;;^UTILITY(U,$J,358.3,11731,0)
 ;;=F14.251^^68^689^10
 ;;^UTILITY(U,$J,358.3,11731,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11731,1,3,0)
 ;;=3^Cocaine Depend w/ Cocaine-Induc Psychotic Disorder w/ Hallucin
 ;;^UTILITY(U,$J,358.3,11731,1,4,0)
 ;;=4^F14.251
 ;;^UTILITY(U,$J,358.3,11731,2)
 ;;=^5003262
 ;;^UTILITY(U,$J,358.3,11732,0)
 ;;=F14.250^^68^689^9
 ;;^UTILITY(U,$J,358.3,11732,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11732,1,3,0)
 ;;=3^Cocaine Depend w/ Cocaine-Induc Psych Disorder w/ Delusions
 ;;^UTILITY(U,$J,358.3,11732,1,4,0)
 ;;=4^F14.250
 ;;^UTILITY(U,$J,358.3,11732,2)
 ;;=^5003261
 ;;^UTILITY(U,$J,358.3,11733,0)
 ;;=F14.24^^68^689^13

IBDEI16T ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,19841,1,3,0)
 ;;=3^Opioid Dependence w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,19841,1,4,0)
 ;;=4^F11.220
 ;;^UTILITY(U,$J,358.3,19841,2)
 ;;=^5003129
 ;;^UTILITY(U,$J,358.3,19842,0)
 ;;=F14.29^^94^930^21
 ;;^UTILITY(U,$J,358.3,19842,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19842,1,3,0)
 ;;=3^Cocaine Dependence w/ Unspec Cocaine-Induced Disorder
 ;;^UTILITY(U,$J,358.3,19842,1,4,0)
 ;;=4^F14.29
 ;;^UTILITY(U,$J,358.3,19842,2)
 ;;=^5003268
 ;;^UTILITY(U,$J,358.3,19843,0)
 ;;=F14.288^^94^930^20
 ;;^UTILITY(U,$J,358.3,19843,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19843,1,3,0)
 ;;=3^Cocaine Dependence w/ Other Cocaine-Induced Disorder
 ;;^UTILITY(U,$J,358.3,19843,1,4,0)
 ;;=4^F14.288
 ;;^UTILITY(U,$J,358.3,19843,2)
 ;;=^5003267
 ;;^UTILITY(U,$J,358.3,19844,0)
 ;;=F14.282^^94^930^14
 ;;^UTILITY(U,$J,358.3,19844,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19844,1,3,0)
 ;;=3^Cocaine Dependence w/ Cocaine-Induced Sleep Disorder
 ;;^UTILITY(U,$J,358.3,19844,1,4,0)
 ;;=4^F14.282
 ;;^UTILITY(U,$J,358.3,19844,2)
 ;;=^5003266
 ;;^UTILITY(U,$J,358.3,19845,0)
 ;;=F14.281^^94^930^15
 ;;^UTILITY(U,$J,358.3,19845,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19845,1,3,0)
 ;;=3^Cocaine Dependence w/ Cocaine-Induced Sexual Dysfunction
 ;;^UTILITY(U,$J,358.3,19845,1,4,0)
 ;;=4^F14.281
 ;;^UTILITY(U,$J,358.3,19845,2)
 ;;=^5003265
 ;;^UTILITY(U,$J,358.3,19846,0)
 ;;=F14.280^^94^930^12
 ;;^UTILITY(U,$J,358.3,19846,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19846,1,3,0)
 ;;=3^Cocaine Dependence w/ Cocaine-Induced Anxiety Disorder
 ;;^UTILITY(U,$J,358.3,19846,1,4,0)
 ;;=4^F14.280
 ;;^UTILITY(U,$J,358.3,19846,2)
 ;;=^5003264
 ;;^UTILITY(U,$J,358.3,19847,0)
 ;;=F14.259^^94^930^11
 ;;^UTILITY(U,$J,358.3,19847,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19847,1,3,0)
 ;;=3^Cocaine Dependence w/ Cocaine-Induc Psychotic Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,19847,1,4,0)
 ;;=4^F14.259
 ;;^UTILITY(U,$J,358.3,19847,2)
 ;;=^5003263
 ;;^UTILITY(U,$J,358.3,19848,0)
 ;;=F14.251^^94^930^10
 ;;^UTILITY(U,$J,358.3,19848,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19848,1,3,0)
 ;;=3^Cocaine Depend w/ Cocaine-Induc Psychotic Disorder w/ Hallucin
 ;;^UTILITY(U,$J,358.3,19848,1,4,0)
 ;;=4^F14.251
 ;;^UTILITY(U,$J,358.3,19848,2)
 ;;=^5003262
 ;;^UTILITY(U,$J,358.3,19849,0)
 ;;=F14.250^^94^930^9
 ;;^UTILITY(U,$J,358.3,19849,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19849,1,3,0)
 ;;=3^Cocaine Depend w/ Cocaine-Induc Psych Disorder w/ Delusions
 ;;^UTILITY(U,$J,358.3,19849,1,4,0)
 ;;=4^F14.250
 ;;^UTILITY(U,$J,358.3,19849,2)
 ;;=^5003261
 ;;^UTILITY(U,$J,358.3,19850,0)
 ;;=F14.24^^94^930^13
 ;;^UTILITY(U,$J,358.3,19850,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19850,1,3,0)
 ;;=3^Cocaine Dependence w/ Cocaine-Induced Mood Disorder
 ;;^UTILITY(U,$J,358.3,19850,1,4,0)
 ;;=4^F14.24
 ;;^UTILITY(U,$J,358.3,19850,2)
 ;;=^5003260
 ;;^UTILITY(U,$J,358.3,19851,0)
 ;;=F14.23^^94^930^22
 ;;^UTILITY(U,$J,358.3,19851,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19851,1,3,0)
 ;;=3^Cocaine Dependence w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,19851,1,4,0)
 ;;=4^F14.23
 ;;^UTILITY(U,$J,358.3,19851,2)
 ;;=^5003259
 ;;^UTILITY(U,$J,358.3,19852,0)
 ;;=F14.229^^94^930^19
 ;;^UTILITY(U,$J,358.3,19852,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19852,1,3,0)
 ;;=3^Cocaine Dependence w/ Intoxication,Unspec
 ;;^UTILITY(U,$J,358.3,19852,1,4,0)
 ;;=4^F14.229
 ;;^UTILITY(U,$J,358.3,19852,2)
 ;;=^5003258
 ;;^UTILITY(U,$J,358.3,19853,0)
 ;;=F14.222^^94^930^17
 ;;^UTILITY(U,$J,358.3,19853,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19853,1,3,0)
 ;;=3^Cocaine Dependence w/ Intoxication w/ Perceptual Disturbance

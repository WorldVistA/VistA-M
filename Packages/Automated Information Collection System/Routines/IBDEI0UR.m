IBDEI0UR ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,14424,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14424,1,3,0)
 ;;=3^Opioid Dependence w/ Intoxication,Unspec
 ;;^UTILITY(U,$J,358.3,14424,1,4,0)
 ;;=4^F11.229
 ;;^UTILITY(U,$J,358.3,14424,2)
 ;;=^5003132
 ;;^UTILITY(U,$J,358.3,14425,0)
 ;;=F11.222^^53^607^38
 ;;^UTILITY(U,$J,358.3,14425,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14425,1,3,0)
 ;;=3^Opioid Dependence w/ Intoxication w/ Perceptual Disturbance
 ;;^UTILITY(U,$J,358.3,14425,1,4,0)
 ;;=4^F11.222
 ;;^UTILITY(U,$J,358.3,14425,2)
 ;;=^5003131
 ;;^UTILITY(U,$J,358.3,14426,0)
 ;;=F11.221^^53^607^37
 ;;^UTILITY(U,$J,358.3,14426,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14426,1,3,0)
 ;;=3^Opioid Dependence w/ Intoxication Delirium
 ;;^UTILITY(U,$J,358.3,14426,1,4,0)
 ;;=4^F11.221
 ;;^UTILITY(U,$J,358.3,14426,2)
 ;;=^5003130
 ;;^UTILITY(U,$J,358.3,14427,0)
 ;;=F11.220^^53^607^39
 ;;^UTILITY(U,$J,358.3,14427,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14427,1,3,0)
 ;;=3^Opioid Dependence w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,14427,1,4,0)
 ;;=4^F11.220
 ;;^UTILITY(U,$J,358.3,14427,2)
 ;;=^5003129
 ;;^UTILITY(U,$J,358.3,14428,0)
 ;;=F14.29^^53^607^21
 ;;^UTILITY(U,$J,358.3,14428,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14428,1,3,0)
 ;;=3^Cocaine Dependence w/ Unspec Cocaine-Induced Disorder
 ;;^UTILITY(U,$J,358.3,14428,1,4,0)
 ;;=4^F14.29
 ;;^UTILITY(U,$J,358.3,14428,2)
 ;;=^5003268
 ;;^UTILITY(U,$J,358.3,14429,0)
 ;;=F14.288^^53^607^20
 ;;^UTILITY(U,$J,358.3,14429,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14429,1,3,0)
 ;;=3^Cocaine Dependence w/ Other Cocaine-Induced Disorder
 ;;^UTILITY(U,$J,358.3,14429,1,4,0)
 ;;=4^F14.288
 ;;^UTILITY(U,$J,358.3,14429,2)
 ;;=^5003267
 ;;^UTILITY(U,$J,358.3,14430,0)
 ;;=F14.282^^53^607^14
 ;;^UTILITY(U,$J,358.3,14430,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14430,1,3,0)
 ;;=3^Cocaine Dependence w/ Cocaine-Induced Sleep Disorder
 ;;^UTILITY(U,$J,358.3,14430,1,4,0)
 ;;=4^F14.282
 ;;^UTILITY(U,$J,358.3,14430,2)
 ;;=^5003266
 ;;^UTILITY(U,$J,358.3,14431,0)
 ;;=F14.281^^53^607^15
 ;;^UTILITY(U,$J,358.3,14431,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14431,1,3,0)
 ;;=3^Cocaine Dependence w/ Cocaine-Induced Sexual Dysfunction
 ;;^UTILITY(U,$J,358.3,14431,1,4,0)
 ;;=4^F14.281
 ;;^UTILITY(U,$J,358.3,14431,2)
 ;;=^5003265
 ;;^UTILITY(U,$J,358.3,14432,0)
 ;;=F14.280^^53^607^12
 ;;^UTILITY(U,$J,358.3,14432,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14432,1,3,0)
 ;;=3^Cocaine Dependence w/ Cocaine-Induced Anxiety Disorder
 ;;^UTILITY(U,$J,358.3,14432,1,4,0)
 ;;=4^F14.280
 ;;^UTILITY(U,$J,358.3,14432,2)
 ;;=^5003264
 ;;^UTILITY(U,$J,358.3,14433,0)
 ;;=F14.259^^53^607^11
 ;;^UTILITY(U,$J,358.3,14433,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14433,1,3,0)
 ;;=3^Cocaine Dependence w/ Cocaine-Induc Psychotic Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,14433,1,4,0)
 ;;=4^F14.259
 ;;^UTILITY(U,$J,358.3,14433,2)
 ;;=^5003263
 ;;^UTILITY(U,$J,358.3,14434,0)
 ;;=F14.251^^53^607^10
 ;;^UTILITY(U,$J,358.3,14434,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14434,1,3,0)
 ;;=3^Cocaine Depend w/ Cocaine-Induc Psychotic Disorder w/ Hallucin
 ;;^UTILITY(U,$J,358.3,14434,1,4,0)
 ;;=4^F14.251
 ;;^UTILITY(U,$J,358.3,14434,2)
 ;;=^5003262
 ;;^UTILITY(U,$J,358.3,14435,0)
 ;;=F14.250^^53^607^9
 ;;^UTILITY(U,$J,358.3,14435,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14435,1,3,0)
 ;;=3^Cocaine Depend w/ Cocaine-Induc Psych Disorder w/ Delusions
 ;;^UTILITY(U,$J,358.3,14435,1,4,0)
 ;;=4^F14.250
 ;;^UTILITY(U,$J,358.3,14435,2)
 ;;=^5003261
 ;;^UTILITY(U,$J,358.3,14436,0)
 ;;=F14.24^^53^607^13

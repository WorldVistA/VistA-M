IBDEI18N ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,21050,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21050,1,3,0)
 ;;=3^Opioid Dependence w/ Intoxication,Unspec
 ;;^UTILITY(U,$J,358.3,21050,1,4,0)
 ;;=4^F11.229
 ;;^UTILITY(U,$J,358.3,21050,2)
 ;;=^5003132
 ;;^UTILITY(U,$J,358.3,21051,0)
 ;;=F11.222^^84^943^38
 ;;^UTILITY(U,$J,358.3,21051,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21051,1,3,0)
 ;;=3^Opioid Dependence w/ Intoxication w/ Perceptual Disturbance
 ;;^UTILITY(U,$J,358.3,21051,1,4,0)
 ;;=4^F11.222
 ;;^UTILITY(U,$J,358.3,21051,2)
 ;;=^5003131
 ;;^UTILITY(U,$J,358.3,21052,0)
 ;;=F11.221^^84^943^37
 ;;^UTILITY(U,$J,358.3,21052,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21052,1,3,0)
 ;;=3^Opioid Dependence w/ Intoxication Delirium
 ;;^UTILITY(U,$J,358.3,21052,1,4,0)
 ;;=4^F11.221
 ;;^UTILITY(U,$J,358.3,21052,2)
 ;;=^5003130
 ;;^UTILITY(U,$J,358.3,21053,0)
 ;;=F11.220^^84^943^39
 ;;^UTILITY(U,$J,358.3,21053,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21053,1,3,0)
 ;;=3^Opioid Dependence w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,21053,1,4,0)
 ;;=4^F11.220
 ;;^UTILITY(U,$J,358.3,21053,2)
 ;;=^5003129
 ;;^UTILITY(U,$J,358.3,21054,0)
 ;;=F14.29^^84^943^21
 ;;^UTILITY(U,$J,358.3,21054,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21054,1,3,0)
 ;;=3^Cocaine Dependence w/ Unspec Cocaine-Induced Disorder
 ;;^UTILITY(U,$J,358.3,21054,1,4,0)
 ;;=4^F14.29
 ;;^UTILITY(U,$J,358.3,21054,2)
 ;;=^5003268
 ;;^UTILITY(U,$J,358.3,21055,0)
 ;;=F14.288^^84^943^20
 ;;^UTILITY(U,$J,358.3,21055,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21055,1,3,0)
 ;;=3^Cocaine Dependence w/ Other Cocaine-Induced Disorder
 ;;^UTILITY(U,$J,358.3,21055,1,4,0)
 ;;=4^F14.288
 ;;^UTILITY(U,$J,358.3,21055,2)
 ;;=^5003267
 ;;^UTILITY(U,$J,358.3,21056,0)
 ;;=F14.282^^84^943^14
 ;;^UTILITY(U,$J,358.3,21056,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21056,1,3,0)
 ;;=3^Cocaine Dependence w/ Cocaine-Induced Sleep Disorder
 ;;^UTILITY(U,$J,358.3,21056,1,4,0)
 ;;=4^F14.282
 ;;^UTILITY(U,$J,358.3,21056,2)
 ;;=^5003266
 ;;^UTILITY(U,$J,358.3,21057,0)
 ;;=F14.281^^84^943^15
 ;;^UTILITY(U,$J,358.3,21057,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21057,1,3,0)
 ;;=3^Cocaine Dependence w/ Cocaine-Induced Sexual Dysfunction
 ;;^UTILITY(U,$J,358.3,21057,1,4,0)
 ;;=4^F14.281
 ;;^UTILITY(U,$J,358.3,21057,2)
 ;;=^5003265
 ;;^UTILITY(U,$J,358.3,21058,0)
 ;;=F14.280^^84^943^12
 ;;^UTILITY(U,$J,358.3,21058,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21058,1,3,0)
 ;;=3^Cocaine Dependence w/ Cocaine-Induced Anxiety Disorder
 ;;^UTILITY(U,$J,358.3,21058,1,4,0)
 ;;=4^F14.280
 ;;^UTILITY(U,$J,358.3,21058,2)
 ;;=^5003264
 ;;^UTILITY(U,$J,358.3,21059,0)
 ;;=F14.259^^84^943^11
 ;;^UTILITY(U,$J,358.3,21059,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21059,1,3,0)
 ;;=3^Cocaine Dependence w/ Cocaine-Induc Psychotic Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,21059,1,4,0)
 ;;=4^F14.259
 ;;^UTILITY(U,$J,358.3,21059,2)
 ;;=^5003263
 ;;^UTILITY(U,$J,358.3,21060,0)
 ;;=F14.251^^84^943^10
 ;;^UTILITY(U,$J,358.3,21060,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21060,1,3,0)
 ;;=3^Cocaine Depend w/ Cocaine-Induc Psychotic Disorder w/ Hallucin
 ;;^UTILITY(U,$J,358.3,21060,1,4,0)
 ;;=4^F14.251
 ;;^UTILITY(U,$J,358.3,21060,2)
 ;;=^5003262
 ;;^UTILITY(U,$J,358.3,21061,0)
 ;;=F14.250^^84^943^9
 ;;^UTILITY(U,$J,358.3,21061,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21061,1,3,0)
 ;;=3^Cocaine Depend w/ Cocaine-Induc Psych Disorder w/ Delusions
 ;;^UTILITY(U,$J,358.3,21061,1,4,0)
 ;;=4^F14.250
 ;;^UTILITY(U,$J,358.3,21061,2)
 ;;=^5003261
 ;;^UTILITY(U,$J,358.3,21062,0)
 ;;=F14.24^^84^943^13

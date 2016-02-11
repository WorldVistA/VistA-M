IBDEI0EP ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6425,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6425,1,3,0)
 ;;=3^Sedatv/Hyp/Anxiolytc Abuse w/ Psych Disorder w/ Delusions
 ;;^UTILITY(U,$J,358.3,6425,1,4,0)
 ;;=4^F13.150
 ;;^UTILITY(U,$J,358.3,6425,2)
 ;;=^5003194
 ;;^UTILITY(U,$J,358.3,6426,0)
 ;;=F14.150^^43^397^4
 ;;^UTILITY(U,$J,358.3,6426,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6426,1,3,0)
 ;;=3^Cocaine Abuse w/ Psych Disorder w/ Delusions
 ;;^UTILITY(U,$J,358.3,6426,1,4,0)
 ;;=4^F14.150
 ;;^UTILITY(U,$J,358.3,6426,2)
 ;;=^5003245
 ;;^UTILITY(U,$J,358.3,6427,0)
 ;;=F14.250^^43^397^7
 ;;^UTILITY(U,$J,358.3,6427,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6427,1,3,0)
 ;;=3^Cocaine Dependence w/ Psych Disorder w/ Delusions
 ;;^UTILITY(U,$J,358.3,6427,1,4,0)
 ;;=4^F14.250
 ;;^UTILITY(U,$J,358.3,6427,2)
 ;;=^5003261
 ;;^UTILITY(U,$J,358.3,6428,0)
 ;;=F19.250^^43^397^22
 ;;^UTILITY(U,$J,358.3,6428,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6428,1,3,0)
 ;;=3^Psychoactive Subs Dependence w/ Psych Disorder w/ Delusions
 ;;^UTILITY(U,$J,358.3,6428,1,4,0)
 ;;=4^F19.250
 ;;^UTILITY(U,$J,358.3,6428,2)
 ;;=^5003442
 ;;^UTILITY(U,$J,358.3,6429,0)
 ;;=F16.250^^43^397^10
 ;;^UTILITY(U,$J,358.3,6429,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6429,1,3,0)
 ;;=3^Hallucinogen Dependence w/ Psych Disorder w/ Delusions
 ;;^UTILITY(U,$J,358.3,6429,1,4,0)
 ;;=4^F16.250
 ;;^UTILITY(U,$J,358.3,6429,2)
 ;;=^5003342
 ;;^UTILITY(U,$J,358.3,6430,0)
 ;;=F11.250^^43^397^14
 ;;^UTILITY(U,$J,358.3,6430,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6430,1,3,0)
 ;;=3^Opioid Dependence w/ Psych Disorder w/ Delusions
 ;;^UTILITY(U,$J,358.3,6430,1,4,0)
 ;;=4^F11.250
 ;;^UTILITY(U,$J,358.3,6430,2)
 ;;=^5003135
 ;;^UTILITY(U,$J,358.3,6431,0)
 ;;=F19.150^^43^397^18
 ;;^UTILITY(U,$J,358.3,6431,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6431,1,3,0)
 ;;=3^Psychoactive Subs Abuse w/ Psych Disorder w/ Delusions
 ;;^UTILITY(U,$J,358.3,6431,1,4,0)
 ;;=4^F19.150
 ;;^UTILITY(U,$J,358.3,6431,2)
 ;;=^5003422
 ;;^UTILITY(U,$J,358.3,6432,0)
 ;;=F15.251^^43^397^45
 ;;^UTILITY(U,$J,358.3,6432,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6432,1,3,0)
 ;;=3^Stimulant Dependence w/ Psych Disorder w/ Hallucinations
 ;;^UTILITY(U,$J,358.3,6432,1,4,0)
 ;;=4^F15.251
 ;;^UTILITY(U,$J,358.3,6432,2)
 ;;=^5003304
 ;;^UTILITY(U,$J,358.3,6433,0)
 ;;=F15.151^^43^397^41
 ;;^UTILITY(U,$J,358.3,6433,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6433,1,3,0)
 ;;=3^Stimulant Abuse w/ Psych Disorder w/ Hallucinations
 ;;^UTILITY(U,$J,358.3,6433,1,4,0)
 ;;=4^F15.151
 ;;^UTILITY(U,$J,358.3,6433,2)
 ;;=^5003289
 ;;^UTILITY(U,$J,358.3,6434,0)
 ;;=F13.251^^43^397^37
 ;;^UTILITY(U,$J,358.3,6434,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6434,1,3,0)
 ;;=3^Sedatv/Hyp/Anxiolytc Dependence w/ Psych Disorder w/ Hallucinations
 ;;^UTILITY(U,$J,358.3,6434,1,4,0)
 ;;=4^F13.251
 ;;^UTILITY(U,$J,358.3,6434,2)
 ;;=^5003212
 ;;^UTILITY(U,$J,358.3,6435,0)
 ;;=F13.151^^43^397^31
 ;;^UTILITY(U,$J,358.3,6435,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6435,1,3,0)
 ;;=3^Sedatv/Hyp/Anxiolytc Abuse w/ Psych Disorder w/ Hallucinations
 ;;^UTILITY(U,$J,358.3,6435,1,4,0)
 ;;=4^F13.151
 ;;^UTILITY(U,$J,358.3,6435,2)
 ;;=^5003195
 ;;^UTILITY(U,$J,358.3,6436,0)
 ;;=F12.251^^43^397^2
 ;;^UTILITY(U,$J,358.3,6436,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6436,1,3,0)
 ;;=3^Cannabis Dependence w/ Psych Disorder w/ Hallucinations
 ;;^UTILITY(U,$J,358.3,6436,1,4,0)
 ;;=4^F12.251
 ;;^UTILITY(U,$J,358.3,6436,2)
 ;;=^5003173
 ;;^UTILITY(U,$J,358.3,6437,0)
 ;;=F14.151^^43^397^6
 ;;^UTILITY(U,$J,358.3,6437,1,0)
 ;;=^358.31IA^4^2

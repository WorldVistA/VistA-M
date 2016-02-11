IBDEI0EQ ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6437,1,3,0)
 ;;=3^Cocaine Abuse w/ Psych Disorder w/ Hallucinations
 ;;^UTILITY(U,$J,358.3,6437,1,4,0)
 ;;=4^F14.151
 ;;^UTILITY(U,$J,358.3,6437,2)
 ;;=^5003246
 ;;^UTILITY(U,$J,358.3,6438,0)
 ;;=F14.251^^43^397^8
 ;;^UTILITY(U,$J,358.3,6438,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6438,1,3,0)
 ;;=3^Cocaine Dependence w/ Psych Disorder w/ Hallucinations
 ;;^UTILITY(U,$J,358.3,6438,1,4,0)
 ;;=4^F14.251
 ;;^UTILITY(U,$J,358.3,6438,2)
 ;;=^5003262
 ;;^UTILITY(U,$J,358.3,6439,0)
 ;;=F19.251^^43^397^23
 ;;^UTILITY(U,$J,358.3,6439,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6439,1,3,0)
 ;;=3^Psychoactive Subs Dependence w/ Psych Disorder w/ Hallucinations
 ;;^UTILITY(U,$J,358.3,6439,1,4,0)
 ;;=4^F19.251
 ;;^UTILITY(U,$J,358.3,6439,2)
 ;;=^5003443
 ;;^UTILITY(U,$J,358.3,6440,0)
 ;;=F16.251^^43^397^11
 ;;^UTILITY(U,$J,358.3,6440,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6440,1,3,0)
 ;;=3^Hallucinogen Dependence w/ Psych Disorder w/ Hallucinations
 ;;^UTILITY(U,$J,358.3,6440,1,4,0)
 ;;=4^F16.251
 ;;^UTILITY(U,$J,358.3,6440,2)
 ;;=^5003343
 ;;^UTILITY(U,$J,358.3,6441,0)
 ;;=F11.251^^43^397^15
 ;;^UTILITY(U,$J,358.3,6441,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6441,1,3,0)
 ;;=3^Opioid Dependence w/ Psych Disorder w/ Hallucinations
 ;;^UTILITY(U,$J,358.3,6441,1,4,0)
 ;;=4^F11.251
 ;;^UTILITY(U,$J,358.3,6441,2)
 ;;=^5003136
 ;;^UTILITY(U,$J,358.3,6442,0)
 ;;=F19.151^^43^397^19
 ;;^UTILITY(U,$J,358.3,6442,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6442,1,3,0)
 ;;=3^Psychoactive Subs Abuse w/ Psych Disorder w/ Hallucinations
 ;;^UTILITY(U,$J,358.3,6442,1,4,0)
 ;;=4^F19.151
 ;;^UTILITY(U,$J,358.3,6442,2)
 ;;=^5003423
 ;;^UTILITY(U,$J,358.3,6443,0)
 ;;=F13.27^^43^397^35
 ;;^UTILITY(U,$J,358.3,6443,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6443,1,3,0)
 ;;=3^Sedatv/Hyp/Anxiolytc Dependence w/ Persisting Dementia
 ;;^UTILITY(U,$J,358.3,6443,1,4,0)
 ;;=4^F13.27
 ;;^UTILITY(U,$J,358.3,6443,2)
 ;;=^5003215
 ;;^UTILITY(U,$J,358.3,6444,0)
 ;;=G30.9^^43^398^1
 ;;^UTILITY(U,$J,358.3,6444,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6444,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,6444,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,6444,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,6445,0)
 ;;=G31.83^^43^398^2
 ;;^UTILITY(U,$J,358.3,6445,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6445,1,3,0)
 ;;=3^Dementia w/ Lewy Bodies
 ;;^UTILITY(U,$J,358.3,6445,1,4,0)
 ;;=4^G31.83
 ;;^UTILITY(U,$J,358.3,6445,2)
 ;;=^329888
 ;;^UTILITY(U,$J,358.3,6446,0)
 ;;=G31.09^^43^398^3
 ;;^UTILITY(U,$J,358.3,6446,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6446,1,3,0)
 ;;=3^Frontotemporal Dementia,Other
 ;;^UTILITY(U,$J,358.3,6446,1,4,0)
 ;;=4^G31.09
 ;;^UTILITY(U,$J,358.3,6446,2)
 ;;=^329916
 ;;^UTILITY(U,$J,358.3,6447,0)
 ;;=G20.^^43^398^5
 ;;^UTILITY(U,$J,358.3,6447,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6447,1,3,0)
 ;;=3^Parkinson's Disease
 ;;^UTILITY(U,$J,358.3,6447,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,6447,2)
 ;;=^5003770
 ;;^UTILITY(U,$J,358.3,6448,0)
 ;;=G35.^^43^398^4
 ;;^UTILITY(U,$J,358.3,6448,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6448,1,3,0)
 ;;=3^Multiple Sclerosis
 ;;^UTILITY(U,$J,358.3,6448,1,4,0)
 ;;=4^G35.
 ;;^UTILITY(U,$J,358.3,6448,2)
 ;;=^79761
 ;;^UTILITY(U,$J,358.3,6449,0)
 ;;=F04.^^43^399^1
 ;;^UTILITY(U,$J,358.3,6449,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6449,1,3,0)
 ;;=3^Amnestic Disorder d/t Physiological Condition
 ;;^UTILITY(U,$J,358.3,6449,1,4,0)
 ;;=4^F04.
 ;;^UTILITY(U,$J,358.3,6449,2)
 ;;=^5003051
 ;;^UTILITY(U,$J,358.3,6450,0)
 ;;=F02.81^^43^399^2

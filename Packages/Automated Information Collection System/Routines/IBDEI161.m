IBDEI161 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,19474,1,4,0)
 ;;=4^F01.50
 ;;^UTILITY(U,$J,358.3,19474,2)
 ;;=^5003046
 ;;^UTILITY(U,$J,358.3,19475,0)
 ;;=F10.27^^94^923^11
 ;;^UTILITY(U,$J,358.3,19475,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19475,1,3,0)
 ;;=3^Dementia,Alcohol-Induced/Persist w/ Alcohol Dependence
 ;;^UTILITY(U,$J,358.3,19475,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,19475,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,19476,0)
 ;;=F06.1^^94^923^6
 ;;^UTILITY(U,$J,358.3,19476,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19476,1,3,0)
 ;;=3^Catatonic Disorder d/t Known Physiological Condition
 ;;^UTILITY(U,$J,358.3,19476,1,4,0)
 ;;=4^F06.1
 ;;^UTILITY(U,$J,358.3,19476,2)
 ;;=^5003054
 ;;^UTILITY(U,$J,358.3,19477,0)
 ;;=F06.8^^94^923^19
 ;;^UTILITY(U,$J,358.3,19477,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19477,1,3,0)
 ;;=3^Mental Disorders d/t Known Physiological Condition,Other
 ;;^UTILITY(U,$J,358.3,19477,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,19477,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,19478,0)
 ;;=F06.0^^94^923^35
 ;;^UTILITY(U,$J,358.3,19478,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19478,1,3,0)
 ;;=3^Psychotic Disorder w/ Hallucin d/t Known Physiol Condition
 ;;^UTILITY(U,$J,358.3,19478,1,4,0)
 ;;=4^F06.0
 ;;^UTILITY(U,$J,358.3,19478,2)
 ;;=^5003053
 ;;^UTILITY(U,$J,358.3,19479,0)
 ;;=G44.209^^94^923^37
 ;;^UTILITY(U,$J,358.3,19479,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19479,1,3,0)
 ;;=3^Tension-Type Headache,Not Intractable,Unspec
 ;;^UTILITY(U,$J,358.3,19479,1,4,0)
 ;;=4^G44.209
 ;;^UTILITY(U,$J,358.3,19479,2)
 ;;=^5003936
 ;;^UTILITY(U,$J,358.3,19480,0)
 ;;=F09.^^94^923^18
 ;;^UTILITY(U,$J,358.3,19480,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19480,1,3,0)
 ;;=3^Mental Disorder d/t Known Physiological Condition,Unspec
 ;;^UTILITY(U,$J,358.3,19480,1,4,0)
 ;;=4^F09.
 ;;^UTILITY(U,$J,358.3,19480,2)
 ;;=^5003067
 ;;^UTILITY(U,$J,358.3,19481,0)
 ;;=F07.9^^94^923^33
 ;;^UTILITY(U,$J,358.3,19481,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19481,1,3,0)
 ;;=3^Personality & Behavrl Disorder d/t Known Physiol Cond,Unspec
 ;;^UTILITY(U,$J,358.3,19481,1,4,0)
 ;;=4^F07.9
 ;;^UTILITY(U,$J,358.3,19481,2)
 ;;=^5003066
 ;;^UTILITY(U,$J,358.3,19482,0)
 ;;=G30.0^^94^923^1
 ;;^UTILITY(U,$J,358.3,19482,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19482,1,3,0)
 ;;=3^Alzheimer's Disease w/ Early Onset
 ;;^UTILITY(U,$J,358.3,19482,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,19482,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,19483,0)
 ;;=G30.8^^94^923^3
 ;;^UTILITY(U,$J,358.3,19483,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19483,1,3,0)
 ;;=3^Alzheimer's Disease,Other
 ;;^UTILITY(U,$J,358.3,19483,1,4,0)
 ;;=4^G30.8
 ;;^UTILITY(U,$J,358.3,19483,2)
 ;;=^5003807
 ;;^UTILITY(U,$J,358.3,19484,0)
 ;;=G30.1^^94^923^2
 ;;^UTILITY(U,$J,358.3,19484,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19484,1,3,0)
 ;;=3^Alzheimer's Disease w/ Late Onset
 ;;^UTILITY(U,$J,358.3,19484,1,4,0)
 ;;=4^G30.1
 ;;^UTILITY(U,$J,358.3,19484,2)
 ;;=^5003806
 ;;^UTILITY(U,$J,358.3,19485,0)
 ;;=G30.9^^94^923^4
 ;;^UTILITY(U,$J,358.3,19485,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19485,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,19485,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,19485,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,19486,0)
 ;;=G21.4^^94^923^40
 ;;^UTILITY(U,$J,358.3,19486,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19486,1,3,0)
 ;;=3^Vascular Parkinsonism
 ;;^UTILITY(U,$J,358.3,19486,1,4,0)
 ;;=4^G21.4
 ;;^UTILITY(U,$J,358.3,19486,2)
 ;;=^5003776
 ;;^UTILITY(U,$J,358.3,19487,0)
 ;;=G20.^^94^923^32
 ;;^UTILITY(U,$J,358.3,19487,1,0)
 ;;=^358.31IA^4^2

IBDEI0OT ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,11354,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11354,1,3,0)
 ;;=3^Postherpetic Nervous System Involvement,Other
 ;;^UTILITY(U,$J,358.3,11354,1,4,0)
 ;;=4^B02.29
 ;;^UTILITY(U,$J,358.3,11354,2)
 ;;=^5000492
 ;;^UTILITY(U,$J,358.3,11355,0)
 ;;=F03.90^^68^682^10
 ;;^UTILITY(U,$J,358.3,11355,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11355,1,3,0)
 ;;=3^Dementia w/o Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,11355,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,11355,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,11356,0)
 ;;=F03.91^^68^682^9
 ;;^UTILITY(U,$J,358.3,11356,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11356,1,3,0)
 ;;=3^Dementia w/ Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,11356,1,4,0)
 ;;=4^F03.91
 ;;^UTILITY(U,$J,358.3,11356,2)
 ;;=^5133350
 ;;^UTILITY(U,$J,358.3,11357,0)
 ;;=F01.50^^68^682^12
 ;;^UTILITY(U,$J,358.3,11357,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11357,1,3,0)
 ;;=3^Dementia,Vascular w/o Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,11357,1,4,0)
 ;;=4^F01.50
 ;;^UTILITY(U,$J,358.3,11357,2)
 ;;=^5003046
 ;;^UTILITY(U,$J,358.3,11358,0)
 ;;=F10.27^^68^682^11
 ;;^UTILITY(U,$J,358.3,11358,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11358,1,3,0)
 ;;=3^Dementia,Alcohol-Induced/Persist w/ Alcohol Dependence
 ;;^UTILITY(U,$J,358.3,11358,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,11358,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,11359,0)
 ;;=F06.1^^68^682^6
 ;;^UTILITY(U,$J,358.3,11359,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11359,1,3,0)
 ;;=3^Catatonic Disorder d/t Known Physiological Condition
 ;;^UTILITY(U,$J,358.3,11359,1,4,0)
 ;;=4^F06.1
 ;;^UTILITY(U,$J,358.3,11359,2)
 ;;=^5003054
 ;;^UTILITY(U,$J,358.3,11360,0)
 ;;=F06.8^^68^682^19
 ;;^UTILITY(U,$J,358.3,11360,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11360,1,3,0)
 ;;=3^Mental Disorders d/t Known Physiological Condition,Other
 ;;^UTILITY(U,$J,358.3,11360,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,11360,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,11361,0)
 ;;=F06.0^^68^682^35
 ;;^UTILITY(U,$J,358.3,11361,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11361,1,3,0)
 ;;=3^Psychotic Disorder w/ Hallucin d/t Known Physiol Condition
 ;;^UTILITY(U,$J,358.3,11361,1,4,0)
 ;;=4^F06.0
 ;;^UTILITY(U,$J,358.3,11361,2)
 ;;=^5003053
 ;;^UTILITY(U,$J,358.3,11362,0)
 ;;=G44.209^^68^682^37
 ;;^UTILITY(U,$J,358.3,11362,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11362,1,3,0)
 ;;=3^Tension-Type Headache,Not Intractable,Unspec
 ;;^UTILITY(U,$J,358.3,11362,1,4,0)
 ;;=4^G44.209
 ;;^UTILITY(U,$J,358.3,11362,2)
 ;;=^5003936
 ;;^UTILITY(U,$J,358.3,11363,0)
 ;;=F09.^^68^682^18
 ;;^UTILITY(U,$J,358.3,11363,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11363,1,3,0)
 ;;=3^Mental Disorder d/t Known Physiological Condition,Unspec
 ;;^UTILITY(U,$J,358.3,11363,1,4,0)
 ;;=4^F09.
 ;;^UTILITY(U,$J,358.3,11363,2)
 ;;=^5003067
 ;;^UTILITY(U,$J,358.3,11364,0)
 ;;=F07.9^^68^682^33
 ;;^UTILITY(U,$J,358.3,11364,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11364,1,3,0)
 ;;=3^Personality & Behavrl Disorder d/t Known Physiol Cond,Unspec
 ;;^UTILITY(U,$J,358.3,11364,1,4,0)
 ;;=4^F07.9
 ;;^UTILITY(U,$J,358.3,11364,2)
 ;;=^5003066
 ;;^UTILITY(U,$J,358.3,11365,0)
 ;;=G30.0^^68^682^1
 ;;^UTILITY(U,$J,358.3,11365,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11365,1,3,0)
 ;;=3^Alzheimer's Disease w/ Early Onset
 ;;^UTILITY(U,$J,358.3,11365,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,11365,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,11366,0)
 ;;=G30.8^^68^682^3
 ;;^UTILITY(U,$J,358.3,11366,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11366,1,3,0)
 ;;=3^Alzheimer's Disease,Other

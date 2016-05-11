IBDEI17V ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,20683,1,3,0)
 ;;=3^Catatonic Disorder d/t Known Physiological Condition
 ;;^UTILITY(U,$J,358.3,20683,1,4,0)
 ;;=4^F06.1
 ;;^UTILITY(U,$J,358.3,20683,2)
 ;;=^5003054
 ;;^UTILITY(U,$J,358.3,20684,0)
 ;;=F06.8^^84^936^21
 ;;^UTILITY(U,$J,358.3,20684,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20684,1,3,0)
 ;;=3^Mental Disorders d/t Known Physiological Condition,Other
 ;;^UTILITY(U,$J,358.3,20684,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,20684,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,20685,0)
 ;;=F06.0^^84^936^37
 ;;^UTILITY(U,$J,358.3,20685,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20685,1,3,0)
 ;;=3^Psychotic Disorder w/ Hallucin d/t Known Physiol Condition
 ;;^UTILITY(U,$J,358.3,20685,1,4,0)
 ;;=4^F06.0
 ;;^UTILITY(U,$J,358.3,20685,2)
 ;;=^5003053
 ;;^UTILITY(U,$J,358.3,20686,0)
 ;;=G44.209^^84^936^42
 ;;^UTILITY(U,$J,358.3,20686,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20686,1,3,0)
 ;;=3^Tension-Type Headache,Not Intractable,Unspec
 ;;^UTILITY(U,$J,358.3,20686,1,4,0)
 ;;=4^G44.209
 ;;^UTILITY(U,$J,358.3,20686,2)
 ;;=^5003936
 ;;^UTILITY(U,$J,358.3,20687,0)
 ;;=F09.^^84^936^20
 ;;^UTILITY(U,$J,358.3,20687,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20687,1,3,0)
 ;;=3^Mental Disorder d/t Known Physiological Condition,Unspec
 ;;^UTILITY(U,$J,358.3,20687,1,4,0)
 ;;=4^F09.
 ;;^UTILITY(U,$J,358.3,20687,2)
 ;;=^5003067
 ;;^UTILITY(U,$J,358.3,20688,0)
 ;;=F07.9^^84^936^35
 ;;^UTILITY(U,$J,358.3,20688,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20688,1,3,0)
 ;;=3^Personality & Behavrl Disorder d/t Known Physiol Cond,Unspec
 ;;^UTILITY(U,$J,358.3,20688,1,4,0)
 ;;=4^F07.9
 ;;^UTILITY(U,$J,358.3,20688,2)
 ;;=^5003066
 ;;^UTILITY(U,$J,358.3,20689,0)
 ;;=G30.0^^84^936^1
 ;;^UTILITY(U,$J,358.3,20689,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20689,1,3,0)
 ;;=3^Alzheimer's Disease w/ Early Onset
 ;;^UTILITY(U,$J,358.3,20689,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,20689,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,20690,0)
 ;;=G30.8^^84^936^3
 ;;^UTILITY(U,$J,358.3,20690,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20690,1,3,0)
 ;;=3^Alzheimer's Disease,Other
 ;;^UTILITY(U,$J,358.3,20690,1,4,0)
 ;;=4^G30.8
 ;;^UTILITY(U,$J,358.3,20690,2)
 ;;=^5003807
 ;;^UTILITY(U,$J,358.3,20691,0)
 ;;=G30.1^^84^936^2
 ;;^UTILITY(U,$J,358.3,20691,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20691,1,3,0)
 ;;=3^Alzheimer's Disease w/ Late Onset
 ;;^UTILITY(U,$J,358.3,20691,1,4,0)
 ;;=4^G30.1
 ;;^UTILITY(U,$J,358.3,20691,2)
 ;;=^5003806
 ;;^UTILITY(U,$J,358.3,20692,0)
 ;;=G30.9^^84^936^4
 ;;^UTILITY(U,$J,358.3,20692,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20692,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,20692,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,20692,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,20693,0)
 ;;=G21.4^^84^936^45
 ;;^UTILITY(U,$J,358.3,20693,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20693,1,3,0)
 ;;=3^Vascular Parkinsonism
 ;;^UTILITY(U,$J,358.3,20693,1,4,0)
 ;;=4^G21.4
 ;;^UTILITY(U,$J,358.3,20693,2)
 ;;=^5003776
 ;;^UTILITY(U,$J,358.3,20694,0)
 ;;=G20.^^84^936^34
 ;;^UTILITY(U,$J,358.3,20694,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20694,1,3,0)
 ;;=3^Parkinson's Disease
 ;;^UTILITY(U,$J,358.3,20694,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,20694,2)
 ;;=^5003770
 ;;^UTILITY(U,$J,358.3,20695,0)
 ;;=G25.0^^84^936^15
 ;;^UTILITY(U,$J,358.3,20695,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20695,1,3,0)
 ;;=3^Essential Tremor
 ;;^UTILITY(U,$J,358.3,20695,1,4,0)
 ;;=4^G25.0
 ;;^UTILITY(U,$J,358.3,20695,2)
 ;;=^5003791
 ;;^UTILITY(U,$J,358.3,20696,0)
 ;;=G25.2^^84^936^44

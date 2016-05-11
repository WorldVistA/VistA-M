IBDEI0FJ ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7166,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,7167,0)
 ;;=F06.0^^30^403^38
 ;;^UTILITY(U,$J,358.3,7167,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7167,1,3,0)
 ;;=3^Psychotic Disorder w/ Hallucin d/t Known Physiol Condition
 ;;^UTILITY(U,$J,358.3,7167,1,4,0)
 ;;=4^F06.0
 ;;^UTILITY(U,$J,358.3,7167,2)
 ;;=^5003053
 ;;^UTILITY(U,$J,358.3,7168,0)
 ;;=G44.209^^30^403^41
 ;;^UTILITY(U,$J,358.3,7168,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7168,1,3,0)
 ;;=3^Tension-Type Headache,Not Intractable,Unspec
 ;;^UTILITY(U,$J,358.3,7168,1,4,0)
 ;;=4^G44.209
 ;;^UTILITY(U,$J,358.3,7168,2)
 ;;=^5003936
 ;;^UTILITY(U,$J,358.3,7169,0)
 ;;=F09.^^30^403^20
 ;;^UTILITY(U,$J,358.3,7169,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7169,1,3,0)
 ;;=3^Mental Disorder d/t Known Physiological Condition,Unspec
 ;;^UTILITY(U,$J,358.3,7169,1,4,0)
 ;;=4^F09.
 ;;^UTILITY(U,$J,358.3,7169,2)
 ;;=^5003067
 ;;^UTILITY(U,$J,358.3,7170,0)
 ;;=F07.9^^30^403^35
 ;;^UTILITY(U,$J,358.3,7170,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7170,1,3,0)
 ;;=3^Personality & Behavrl Disorder d/t Known Physiol Cond,Unspec
 ;;^UTILITY(U,$J,358.3,7170,1,4,0)
 ;;=4^F07.9
 ;;^UTILITY(U,$J,358.3,7170,2)
 ;;=^5003066
 ;;^UTILITY(U,$J,358.3,7171,0)
 ;;=G30.0^^30^403^1
 ;;^UTILITY(U,$J,358.3,7171,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7171,1,3,0)
 ;;=3^Alzheimer's Disease w/ Early Onset
 ;;^UTILITY(U,$J,358.3,7171,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,7171,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,7172,0)
 ;;=G30.8^^30^403^3
 ;;^UTILITY(U,$J,358.3,7172,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7172,1,3,0)
 ;;=3^Alzheimer's Disease,Other
 ;;^UTILITY(U,$J,358.3,7172,1,4,0)
 ;;=4^G30.8
 ;;^UTILITY(U,$J,358.3,7172,2)
 ;;=^5003807
 ;;^UTILITY(U,$J,358.3,7173,0)
 ;;=G30.1^^30^403^2
 ;;^UTILITY(U,$J,358.3,7173,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7173,1,3,0)
 ;;=3^Alzheimer's Disease w/ Late Onset
 ;;^UTILITY(U,$J,358.3,7173,1,4,0)
 ;;=4^G30.1
 ;;^UTILITY(U,$J,358.3,7173,2)
 ;;=^5003806
 ;;^UTILITY(U,$J,358.3,7174,0)
 ;;=G30.9^^30^403^4
 ;;^UTILITY(U,$J,358.3,7174,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7174,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,7174,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,7174,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,7175,0)
 ;;=G21.4^^30^403^44
 ;;^UTILITY(U,$J,358.3,7175,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7175,1,3,0)
 ;;=3^Vascular Parkinsonism
 ;;^UTILITY(U,$J,358.3,7175,1,4,0)
 ;;=4^G21.4
 ;;^UTILITY(U,$J,358.3,7175,2)
 ;;=^5003776
 ;;^UTILITY(U,$J,358.3,7176,0)
 ;;=G20.^^30^403^34
 ;;^UTILITY(U,$J,358.3,7176,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7176,1,3,0)
 ;;=3^Parkinson's Disease
 ;;^UTILITY(U,$J,358.3,7176,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,7176,2)
 ;;=^5003770
 ;;^UTILITY(U,$J,358.3,7177,0)
 ;;=G25.0^^30^403^17
 ;;^UTILITY(U,$J,358.3,7177,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7177,1,3,0)
 ;;=3^Essential Tremor
 ;;^UTILITY(U,$J,358.3,7177,1,4,0)
 ;;=4^G25.0
 ;;^UTILITY(U,$J,358.3,7177,2)
 ;;=^5003791
 ;;^UTILITY(U,$J,358.3,7178,0)
 ;;=G25.2^^30^403^43
 ;;^UTILITY(U,$J,358.3,7178,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7178,1,3,0)
 ;;=3^Tremor,Other Spec Forms
 ;;^UTILITY(U,$J,358.3,7178,1,4,0)
 ;;=4^G25.2
 ;;^UTILITY(U,$J,358.3,7178,2)
 ;;=^5003793
 ;;^UTILITY(U,$J,358.3,7179,0)
 ;;=G25.1^^30^403^42
 ;;^UTILITY(U,$J,358.3,7179,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7179,1,3,0)
 ;;=3^Tremor,Drug-Induced
 ;;^UTILITY(U,$J,358.3,7179,1,4,0)
 ;;=4^G25.1
 ;;^UTILITY(U,$J,358.3,7179,2)
 ;;=^5003792
 ;;^UTILITY(U,$J,358.3,7180,0)
 ;;=G25.81^^30^403^39

IBDEI0TZ ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,14057,1,3,0)
 ;;=3^Catatonic Disorder d/t Known Physiological Condition
 ;;^UTILITY(U,$J,358.3,14057,1,4,0)
 ;;=4^F06.1
 ;;^UTILITY(U,$J,358.3,14057,2)
 ;;=^5003054
 ;;^UTILITY(U,$J,358.3,14058,0)
 ;;=F06.8^^53^600^21
 ;;^UTILITY(U,$J,358.3,14058,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14058,1,3,0)
 ;;=3^Mental Disorders d/t Known Physiological Condition,Other
 ;;^UTILITY(U,$J,358.3,14058,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,14058,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,14059,0)
 ;;=F06.0^^53^600^37
 ;;^UTILITY(U,$J,358.3,14059,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14059,1,3,0)
 ;;=3^Psychotic Disorder w/ Hallucin d/t Known Physiol Condition
 ;;^UTILITY(U,$J,358.3,14059,1,4,0)
 ;;=4^F06.0
 ;;^UTILITY(U,$J,358.3,14059,2)
 ;;=^5003053
 ;;^UTILITY(U,$J,358.3,14060,0)
 ;;=G44.209^^53^600^42
 ;;^UTILITY(U,$J,358.3,14060,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14060,1,3,0)
 ;;=3^Tension-Type Headache,Not Intractable,Unspec
 ;;^UTILITY(U,$J,358.3,14060,1,4,0)
 ;;=4^G44.209
 ;;^UTILITY(U,$J,358.3,14060,2)
 ;;=^5003936
 ;;^UTILITY(U,$J,358.3,14061,0)
 ;;=F09.^^53^600^20
 ;;^UTILITY(U,$J,358.3,14061,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14061,1,3,0)
 ;;=3^Mental Disorder d/t Known Physiological Condition,Unspec
 ;;^UTILITY(U,$J,358.3,14061,1,4,0)
 ;;=4^F09.
 ;;^UTILITY(U,$J,358.3,14061,2)
 ;;=^5003067
 ;;^UTILITY(U,$J,358.3,14062,0)
 ;;=F07.9^^53^600^35
 ;;^UTILITY(U,$J,358.3,14062,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14062,1,3,0)
 ;;=3^Personality & Behavrl Disorder d/t Known Physiol Cond,Unspec
 ;;^UTILITY(U,$J,358.3,14062,1,4,0)
 ;;=4^F07.9
 ;;^UTILITY(U,$J,358.3,14062,2)
 ;;=^5003066
 ;;^UTILITY(U,$J,358.3,14063,0)
 ;;=G30.0^^53^600^1
 ;;^UTILITY(U,$J,358.3,14063,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14063,1,3,0)
 ;;=3^Alzheimer's Disease w/ Early Onset
 ;;^UTILITY(U,$J,358.3,14063,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,14063,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,14064,0)
 ;;=G30.8^^53^600^3
 ;;^UTILITY(U,$J,358.3,14064,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14064,1,3,0)
 ;;=3^Alzheimer's Disease,Other
 ;;^UTILITY(U,$J,358.3,14064,1,4,0)
 ;;=4^G30.8
 ;;^UTILITY(U,$J,358.3,14064,2)
 ;;=^5003807
 ;;^UTILITY(U,$J,358.3,14065,0)
 ;;=G30.1^^53^600^2
 ;;^UTILITY(U,$J,358.3,14065,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14065,1,3,0)
 ;;=3^Alzheimer's Disease w/ Late Onset
 ;;^UTILITY(U,$J,358.3,14065,1,4,0)
 ;;=4^G30.1
 ;;^UTILITY(U,$J,358.3,14065,2)
 ;;=^5003806
 ;;^UTILITY(U,$J,358.3,14066,0)
 ;;=G30.9^^53^600^4
 ;;^UTILITY(U,$J,358.3,14066,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14066,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,14066,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,14066,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,14067,0)
 ;;=G21.4^^53^600^45
 ;;^UTILITY(U,$J,358.3,14067,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14067,1,3,0)
 ;;=3^Vascular Parkinsonism
 ;;^UTILITY(U,$J,358.3,14067,1,4,0)
 ;;=4^G21.4
 ;;^UTILITY(U,$J,358.3,14067,2)
 ;;=^5003776
 ;;^UTILITY(U,$J,358.3,14068,0)
 ;;=G20.^^53^600^34
 ;;^UTILITY(U,$J,358.3,14068,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14068,1,3,0)
 ;;=3^Parkinson's Disease
 ;;^UTILITY(U,$J,358.3,14068,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,14068,2)
 ;;=^5003770
 ;;^UTILITY(U,$J,358.3,14069,0)
 ;;=G25.0^^53^600^15
 ;;^UTILITY(U,$J,358.3,14069,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14069,1,3,0)
 ;;=3^Essential Tremor
 ;;^UTILITY(U,$J,358.3,14069,1,4,0)
 ;;=4^G25.0
 ;;^UTILITY(U,$J,358.3,14069,2)
 ;;=^5003791
 ;;^UTILITY(U,$J,358.3,14070,0)
 ;;=G25.2^^53^600^44

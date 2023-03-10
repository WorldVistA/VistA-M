IBDEI126 ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,17198,1,3,0)
 ;;=3^Mental Disorders d/t Known Physiological Condition,Other
 ;;^UTILITY(U,$J,358.3,17198,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,17198,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,17199,0)
 ;;=F06.0^^61^782^38
 ;;^UTILITY(U,$J,358.3,17199,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17199,1,3,0)
 ;;=3^Psychotic Disorder w/ Hallucin d/t Known Physiol Condition
 ;;^UTILITY(U,$J,358.3,17199,1,4,0)
 ;;=4^F06.0
 ;;^UTILITY(U,$J,358.3,17199,2)
 ;;=^5003053
 ;;^UTILITY(U,$J,358.3,17200,0)
 ;;=G44.209^^61^782^43
 ;;^UTILITY(U,$J,358.3,17200,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17200,1,3,0)
 ;;=3^Tension-Type Headache,Not Intractable,Unspec
 ;;^UTILITY(U,$J,358.3,17200,1,4,0)
 ;;=4^G44.209
 ;;^UTILITY(U,$J,358.3,17200,2)
 ;;=^5003936
 ;;^UTILITY(U,$J,358.3,17201,0)
 ;;=F09.^^61^782^21
 ;;^UTILITY(U,$J,358.3,17201,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17201,1,3,0)
 ;;=3^Mental Disorder d/t Known Physiological Condition,Unspec
 ;;^UTILITY(U,$J,358.3,17201,1,4,0)
 ;;=4^F09.
 ;;^UTILITY(U,$J,358.3,17201,2)
 ;;=^5003067
 ;;^UTILITY(U,$J,358.3,17202,0)
 ;;=F07.9^^61^782^36
 ;;^UTILITY(U,$J,358.3,17202,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17202,1,3,0)
 ;;=3^Personality & Behavrl Disorder d/t Known Physiol Cond,Unspec
 ;;^UTILITY(U,$J,358.3,17202,1,4,0)
 ;;=4^F07.9
 ;;^UTILITY(U,$J,358.3,17202,2)
 ;;=^5003066
 ;;^UTILITY(U,$J,358.3,17203,0)
 ;;=G30.0^^61^782^1
 ;;^UTILITY(U,$J,358.3,17203,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17203,1,3,0)
 ;;=3^Alzheimer's Disease w/ Early Onset
 ;;^UTILITY(U,$J,358.3,17203,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,17203,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,17204,0)
 ;;=G30.8^^61^782^3
 ;;^UTILITY(U,$J,358.3,17204,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17204,1,3,0)
 ;;=3^Alzheimer's Disease,Other
 ;;^UTILITY(U,$J,358.3,17204,1,4,0)
 ;;=4^G30.8
 ;;^UTILITY(U,$J,358.3,17204,2)
 ;;=^5003807
 ;;^UTILITY(U,$J,358.3,17205,0)
 ;;=G30.1^^61^782^2
 ;;^UTILITY(U,$J,358.3,17205,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17205,1,3,0)
 ;;=3^Alzheimer's Disease w/ Late Onset
 ;;^UTILITY(U,$J,358.3,17205,1,4,0)
 ;;=4^G30.1
 ;;^UTILITY(U,$J,358.3,17205,2)
 ;;=^5003806
 ;;^UTILITY(U,$J,358.3,17206,0)
 ;;=G30.9^^61^782^4
 ;;^UTILITY(U,$J,358.3,17206,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17206,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,17206,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,17206,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,17207,0)
 ;;=G21.4^^61^782^46
 ;;^UTILITY(U,$J,358.3,17207,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17207,1,3,0)
 ;;=3^Vascular Parkinsonism
 ;;^UTILITY(U,$J,358.3,17207,1,4,0)
 ;;=4^G21.4
 ;;^UTILITY(U,$J,358.3,17207,2)
 ;;=^5003776
 ;;^UTILITY(U,$J,358.3,17208,0)
 ;;=G20.^^61^782^35
 ;;^UTILITY(U,$J,358.3,17208,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17208,1,3,0)
 ;;=3^Parkinson's Disease
 ;;^UTILITY(U,$J,358.3,17208,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,17208,2)
 ;;=^5003770
 ;;^UTILITY(U,$J,358.3,17209,0)
 ;;=G25.0^^61^782^16
 ;;^UTILITY(U,$J,358.3,17209,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17209,1,3,0)
 ;;=3^Essential Tremor
 ;;^UTILITY(U,$J,358.3,17209,1,4,0)
 ;;=4^G25.0
 ;;^UTILITY(U,$J,358.3,17209,2)
 ;;=^5003791
 ;;^UTILITY(U,$J,358.3,17210,0)
 ;;=G25.2^^61^782^45
 ;;^UTILITY(U,$J,358.3,17210,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17210,1,3,0)
 ;;=3^Tremor,Other Spec Forms

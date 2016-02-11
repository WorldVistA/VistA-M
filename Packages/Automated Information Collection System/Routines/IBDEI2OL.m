IBDEI2OL ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,44994,1,3,0)
 ;;=3^Dementia,Vascular w/o Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,44994,1,4,0)
 ;;=4^F01.50
 ;;^UTILITY(U,$J,358.3,44994,2)
 ;;=^5003046
 ;;^UTILITY(U,$J,358.3,44995,0)
 ;;=F10.27^^200^2235^11
 ;;^UTILITY(U,$J,358.3,44995,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44995,1,3,0)
 ;;=3^Dementia,Alcohol-Induced/Persist w/ Alcohol Dependence
 ;;^UTILITY(U,$J,358.3,44995,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,44995,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,44996,0)
 ;;=F06.1^^200^2235^6
 ;;^UTILITY(U,$J,358.3,44996,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44996,1,3,0)
 ;;=3^Catatonic Disorder d/t Known Physiological Condition
 ;;^UTILITY(U,$J,358.3,44996,1,4,0)
 ;;=4^F06.1
 ;;^UTILITY(U,$J,358.3,44996,2)
 ;;=^5003054
 ;;^UTILITY(U,$J,358.3,44997,0)
 ;;=F06.8^^200^2235^19
 ;;^UTILITY(U,$J,358.3,44997,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44997,1,3,0)
 ;;=3^Mental Disorders d/t Known Physiological Condition,Other
 ;;^UTILITY(U,$J,358.3,44997,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,44997,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,44998,0)
 ;;=F06.0^^200^2235^35
 ;;^UTILITY(U,$J,358.3,44998,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44998,1,3,0)
 ;;=3^Psychotic Disorder w/ Hallucin d/t Known Physiol Condition
 ;;^UTILITY(U,$J,358.3,44998,1,4,0)
 ;;=4^F06.0
 ;;^UTILITY(U,$J,358.3,44998,2)
 ;;=^5003053
 ;;^UTILITY(U,$J,358.3,44999,0)
 ;;=G44.209^^200^2235^37
 ;;^UTILITY(U,$J,358.3,44999,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44999,1,3,0)
 ;;=3^Tension-Type Headache,Not Intractable,Unspec
 ;;^UTILITY(U,$J,358.3,44999,1,4,0)
 ;;=4^G44.209
 ;;^UTILITY(U,$J,358.3,44999,2)
 ;;=^5003936
 ;;^UTILITY(U,$J,358.3,45000,0)
 ;;=F09.^^200^2235^18
 ;;^UTILITY(U,$J,358.3,45000,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45000,1,3,0)
 ;;=3^Mental Disorder d/t Known Physiological Condition,Unspec
 ;;^UTILITY(U,$J,358.3,45000,1,4,0)
 ;;=4^F09.
 ;;^UTILITY(U,$J,358.3,45000,2)
 ;;=^5003067
 ;;^UTILITY(U,$J,358.3,45001,0)
 ;;=F07.9^^200^2235^33
 ;;^UTILITY(U,$J,358.3,45001,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45001,1,3,0)
 ;;=3^Personality & Behavrl Disorder d/t Known Physiol Cond,Unspec
 ;;^UTILITY(U,$J,358.3,45001,1,4,0)
 ;;=4^F07.9
 ;;^UTILITY(U,$J,358.3,45001,2)
 ;;=^5003066
 ;;^UTILITY(U,$J,358.3,45002,0)
 ;;=G30.0^^200^2235^1
 ;;^UTILITY(U,$J,358.3,45002,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45002,1,3,0)
 ;;=3^Alzheimer's Disease w/ Early Onset
 ;;^UTILITY(U,$J,358.3,45002,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,45002,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,45003,0)
 ;;=G30.8^^200^2235^3
 ;;^UTILITY(U,$J,358.3,45003,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45003,1,3,0)
 ;;=3^Alzheimer's Disease,Other
 ;;^UTILITY(U,$J,358.3,45003,1,4,0)
 ;;=4^G30.8
 ;;^UTILITY(U,$J,358.3,45003,2)
 ;;=^5003807
 ;;^UTILITY(U,$J,358.3,45004,0)
 ;;=G30.1^^200^2235^2
 ;;^UTILITY(U,$J,358.3,45004,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45004,1,3,0)
 ;;=3^Alzheimer's Disease w/ Late Onset
 ;;^UTILITY(U,$J,358.3,45004,1,4,0)
 ;;=4^G30.1
 ;;^UTILITY(U,$J,358.3,45004,2)
 ;;=^5003806
 ;;^UTILITY(U,$J,358.3,45005,0)
 ;;=G30.9^^200^2235^4
 ;;^UTILITY(U,$J,358.3,45005,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45005,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,45005,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,45005,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,45006,0)
 ;;=G21.4^^200^2235^40
 ;;^UTILITY(U,$J,358.3,45006,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45006,1,3,0)
 ;;=3^Vascular Parkinsonism
 ;;^UTILITY(U,$J,358.3,45006,1,4,0)
 ;;=4^G21.4

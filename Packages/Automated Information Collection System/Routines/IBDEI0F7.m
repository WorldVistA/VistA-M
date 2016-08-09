IBDEI0F7 ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15206,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15206,1,3,0)
 ;;=3^Dementia,Alcohol-Induced/Persist w/ Alcohol Dependence
 ;;^UTILITY(U,$J,358.3,15206,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,15206,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,15207,0)
 ;;=F06.1^^61^747^6
 ;;^UTILITY(U,$J,358.3,15207,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15207,1,3,0)
 ;;=3^Catatonic Disorder d/t Known Physiological Condition
 ;;^UTILITY(U,$J,358.3,15207,1,4,0)
 ;;=4^F06.1
 ;;^UTILITY(U,$J,358.3,15207,2)
 ;;=^5003054
 ;;^UTILITY(U,$J,358.3,15208,0)
 ;;=F06.8^^61^747^21
 ;;^UTILITY(U,$J,358.3,15208,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15208,1,3,0)
 ;;=3^Mental Disorders d/t Known Physiological Condition,Other
 ;;^UTILITY(U,$J,358.3,15208,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,15208,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,15209,0)
 ;;=F06.0^^61^747^37
 ;;^UTILITY(U,$J,358.3,15209,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15209,1,3,0)
 ;;=3^Psychotic Disorder w/ Hallucin d/t Known Physiol Condition
 ;;^UTILITY(U,$J,358.3,15209,1,4,0)
 ;;=4^F06.0
 ;;^UTILITY(U,$J,358.3,15209,2)
 ;;=^5003053
 ;;^UTILITY(U,$J,358.3,15210,0)
 ;;=G44.209^^61^747^42
 ;;^UTILITY(U,$J,358.3,15210,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15210,1,3,0)
 ;;=3^Tension-Type Headache,Not Intractable,Unspec
 ;;^UTILITY(U,$J,358.3,15210,1,4,0)
 ;;=4^G44.209
 ;;^UTILITY(U,$J,358.3,15210,2)
 ;;=^5003936
 ;;^UTILITY(U,$J,358.3,15211,0)
 ;;=F09.^^61^747^20
 ;;^UTILITY(U,$J,358.3,15211,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15211,1,3,0)
 ;;=3^Mental Disorder d/t Known Physiological Condition,Unspec
 ;;^UTILITY(U,$J,358.3,15211,1,4,0)
 ;;=4^F09.
 ;;^UTILITY(U,$J,358.3,15211,2)
 ;;=^5003067
 ;;^UTILITY(U,$J,358.3,15212,0)
 ;;=F07.9^^61^747^35
 ;;^UTILITY(U,$J,358.3,15212,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15212,1,3,0)
 ;;=3^Personality & Behavrl Disorder d/t Known Physiol Cond,Unspec
 ;;^UTILITY(U,$J,358.3,15212,1,4,0)
 ;;=4^F07.9
 ;;^UTILITY(U,$J,358.3,15212,2)
 ;;=^5003066
 ;;^UTILITY(U,$J,358.3,15213,0)
 ;;=G30.0^^61^747^1
 ;;^UTILITY(U,$J,358.3,15213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15213,1,3,0)
 ;;=3^Alzheimer's Disease w/ Early Onset
 ;;^UTILITY(U,$J,358.3,15213,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,15213,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,15214,0)
 ;;=G30.8^^61^747^3
 ;;^UTILITY(U,$J,358.3,15214,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15214,1,3,0)
 ;;=3^Alzheimer's Disease,Other
 ;;^UTILITY(U,$J,358.3,15214,1,4,0)
 ;;=4^G30.8
 ;;^UTILITY(U,$J,358.3,15214,2)
 ;;=^5003807
 ;;^UTILITY(U,$J,358.3,15215,0)
 ;;=G30.1^^61^747^2
 ;;^UTILITY(U,$J,358.3,15215,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15215,1,3,0)
 ;;=3^Alzheimer's Disease w/ Late Onset
 ;;^UTILITY(U,$J,358.3,15215,1,4,0)
 ;;=4^G30.1
 ;;^UTILITY(U,$J,358.3,15215,2)
 ;;=^5003806
 ;;^UTILITY(U,$J,358.3,15216,0)
 ;;=G30.9^^61^747^4
 ;;^UTILITY(U,$J,358.3,15216,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15216,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,15216,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,15216,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,15217,0)
 ;;=G21.4^^61^747^45
 ;;^UTILITY(U,$J,358.3,15217,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15217,1,3,0)
 ;;=3^Vascular Parkinsonism
 ;;^UTILITY(U,$J,358.3,15217,1,4,0)
 ;;=4^G21.4
 ;;^UTILITY(U,$J,358.3,15217,2)
 ;;=^5003776
 ;;^UTILITY(U,$J,358.3,15218,0)
 ;;=G20.^^61^747^34
 ;;^UTILITY(U,$J,358.3,15218,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15218,1,3,0)
 ;;=3^Parkinson's Disease
 ;;^UTILITY(U,$J,358.3,15218,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,15218,2)
 ;;=^5003770
 ;;^UTILITY(U,$J,358.3,15219,0)
 ;;=G25.0^^61^747^15
 ;;^UTILITY(U,$J,358.3,15219,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15219,1,3,0)
 ;;=3^Essential Tremor
 ;;^UTILITY(U,$J,358.3,15219,1,4,0)
 ;;=4^G25.0
 ;;^UTILITY(U,$J,358.3,15219,2)
 ;;=^5003791
 ;;^UTILITY(U,$J,358.3,15220,0)
 ;;=G25.2^^61^747^44
 ;;^UTILITY(U,$J,358.3,15220,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15220,1,3,0)
 ;;=3^Tremor,Other Spec Forms
 ;;^UTILITY(U,$J,358.3,15220,1,4,0)
 ;;=4^G25.2
 ;;^UTILITY(U,$J,358.3,15220,2)
 ;;=^5003793
 ;;^UTILITY(U,$J,358.3,15221,0)
 ;;=G25.1^^61^747^43
 ;;^UTILITY(U,$J,358.3,15221,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15221,1,3,0)
 ;;=3^Tremor,Drug-Induced
 ;;^UTILITY(U,$J,358.3,15221,1,4,0)
 ;;=4^G25.1
 ;;^UTILITY(U,$J,358.3,15221,2)
 ;;=^5003792
 ;;^UTILITY(U,$J,358.3,15222,0)
 ;;=G25.81^^61^747^38
 ;;^UTILITY(U,$J,358.3,15222,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15222,1,3,0)
 ;;=3^Restless Legs Syndrome
 ;;^UTILITY(U,$J,358.3,15222,1,4,0)
 ;;=4^G25.81
 ;;^UTILITY(U,$J,358.3,15222,2)
 ;;=^5003801
 ;;^UTILITY(U,$J,358.3,15223,0)
 ;;=G35.^^61^747^31
 ;;^UTILITY(U,$J,358.3,15223,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15223,1,3,0)
 ;;=3^Multiple Sclerosis
 ;;^UTILITY(U,$J,358.3,15223,1,4,0)
 ;;=4^G35.
 ;;^UTILITY(U,$J,358.3,15223,2)
 ;;=^79761
 ;;^UTILITY(U,$J,358.3,15224,0)
 ;;=G40.901^^61^747^13
 ;;^UTILITY(U,$J,358.3,15224,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15224,1,3,0)
 ;;=3^Epilepsy,Not Intractable w/ Status Epilepticus,Unspec
 ;;^UTILITY(U,$J,358.3,15224,1,4,0)
 ;;=4^G40.901
 ;;^UTILITY(U,$J,358.3,15224,2)
 ;;=^5003864
 ;;^UTILITY(U,$J,358.3,15225,0)
 ;;=G40.909^^61^747^14
 ;;^UTILITY(U,$J,358.3,15225,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15225,1,3,0)
 ;;=3^Epilepsy,Not Intractable w/o Status Epilepticus,Unspec
 ;;^UTILITY(U,$J,358.3,15225,1,4,0)
 ;;=4^G40.909
 ;;^UTILITY(U,$J,358.3,15225,2)
 ;;=^5003865
 ;;^UTILITY(U,$J,358.3,15226,0)
 ;;=G43.809^^61^747^28
 ;;^UTILITY(U,$J,358.3,15226,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15226,1,3,0)
 ;;=3^Migraine,Not Intractable w/o Status Migrainosus,Other
 ;;^UTILITY(U,$J,358.3,15226,1,4,0)
 ;;=4^G43.809
 ;;^UTILITY(U,$J,358.3,15226,2)
 ;;=^5003901
 ;;^UTILITY(U,$J,358.3,15227,0)
 ;;=G43.B0^^61^747^30
 ;;^UTILITY(U,$J,358.3,15227,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15227,1,3,0)
 ;;=3^Migraine,Ophthalmoplegic Not Intractable
 ;;^UTILITY(U,$J,358.3,15227,1,4,0)
 ;;=4^G43.B0
 ;;^UTILITY(U,$J,358.3,15227,2)
 ;;=^5003914
 ;;^UTILITY(U,$J,358.3,15228,0)
 ;;=G43.C0^^61^747^17
 ;;^UTILITY(U,$J,358.3,15228,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15228,1,3,0)
 ;;=3^Headache Syndromes,Periodic Not Intractable
 ;;^UTILITY(U,$J,358.3,15228,1,4,0)
 ;;=4^G43.C0
 ;;^UTILITY(U,$J,358.3,15228,2)
 ;;=^5003916
 ;;^UTILITY(U,$J,358.3,15229,0)
 ;;=G43.A0^^61^747^8
 ;;^UTILITY(U,$J,358.3,15229,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15229,1,3,0)
 ;;=3^Cyclical Vomiting Not Intractable
 ;;^UTILITY(U,$J,358.3,15229,1,4,0)
 ;;=4^G43.A0
 ;;^UTILITY(U,$J,358.3,15229,2)
 ;;=^5003912
 ;;^UTILITY(U,$J,358.3,15230,0)
 ;;=G43.C1^^61^747^16
 ;;^UTILITY(U,$J,358.3,15230,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15230,1,3,0)
 ;;=3^Headache Syndromes,Periodic Intractable
 ;;^UTILITY(U,$J,358.3,15230,1,4,0)
 ;;=4^G43.C1
 ;;^UTILITY(U,$J,358.3,15230,2)
 ;;=^5003917
 ;;^UTILITY(U,$J,358.3,15231,0)
 ;;=G43.B1^^61^747^29
 ;;^UTILITY(U,$J,358.3,15231,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15231,1,3,0)
 ;;=3^Migraine,Ophthalmoplegic Intractable
 ;;^UTILITY(U,$J,358.3,15231,1,4,0)
 ;;=4^G43.B1
 ;;^UTILITY(U,$J,358.3,15231,2)
 ;;=^5003915
 ;;^UTILITY(U,$J,358.3,15232,0)
 ;;=G43.A1^^61^747^7
 ;;^UTILITY(U,$J,358.3,15232,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15232,1,3,0)
 ;;=3^Cyclical Vomiting Intractable
 ;;^UTILITY(U,$J,358.3,15232,1,4,0)
 ;;=4^G43.A1
 ;;^UTILITY(U,$J,358.3,15232,2)
 ;;=^5003913
 ;;^UTILITY(U,$J,358.3,15233,0)
 ;;=G43.819^^61^747^25
 ;;^UTILITY(U,$J,358.3,15233,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15233,1,3,0)
 ;;=3^Migraine Intractable w/o Status Migrainosus,Other
 ;;^UTILITY(U,$J,358.3,15233,1,4,0)
 ;;=4^G43.819

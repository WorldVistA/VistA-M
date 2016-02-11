IBDEI1TU ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30585,1,3,0)
 ;;=3^Epilepsy,Not Intractable w/ Status Epilepticus,Unspec
 ;;^UTILITY(U,$J,358.3,30585,1,4,0)
 ;;=4^G40.901
 ;;^UTILITY(U,$J,358.3,30585,2)
 ;;=^5003864
 ;;^UTILITY(U,$J,358.3,30586,0)
 ;;=G40.909^^135^1379^14
 ;;^UTILITY(U,$J,358.3,30586,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30586,1,3,0)
 ;;=3^Epilepsy,Not Intractable w/o Status Epilepticus,Unspec
 ;;^UTILITY(U,$J,358.3,30586,1,4,0)
 ;;=4^G40.909
 ;;^UTILITY(U,$J,358.3,30586,2)
 ;;=^5003865
 ;;^UTILITY(U,$J,358.3,30587,0)
 ;;=G43.809^^135^1379^26
 ;;^UTILITY(U,$J,358.3,30587,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30587,1,3,0)
 ;;=3^Migraine,Not Intractable w/o Status Migrainosus,Other
 ;;^UTILITY(U,$J,358.3,30587,1,4,0)
 ;;=4^G43.809
 ;;^UTILITY(U,$J,358.3,30587,2)
 ;;=^5003901
 ;;^UTILITY(U,$J,358.3,30588,0)
 ;;=G43.B0^^135^1379^28
 ;;^UTILITY(U,$J,358.3,30588,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30588,1,3,0)
 ;;=3^Migraine,Ophthalmoplegic Not Intractable
 ;;^UTILITY(U,$J,358.3,30588,1,4,0)
 ;;=4^G43.B0
 ;;^UTILITY(U,$J,358.3,30588,2)
 ;;=^5003914
 ;;^UTILITY(U,$J,358.3,30589,0)
 ;;=G43.C0^^135^1379^17
 ;;^UTILITY(U,$J,358.3,30589,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30589,1,3,0)
 ;;=3^Headache Syndromes,Periodic Not Intractable
 ;;^UTILITY(U,$J,358.3,30589,1,4,0)
 ;;=4^G43.C0
 ;;^UTILITY(U,$J,358.3,30589,2)
 ;;=^5003916
 ;;^UTILITY(U,$J,358.3,30590,0)
 ;;=G43.A0^^135^1379^8
 ;;^UTILITY(U,$J,358.3,30590,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30590,1,3,0)
 ;;=3^Cyclical Vomiting Not Intractable
 ;;^UTILITY(U,$J,358.3,30590,1,4,0)
 ;;=4^G43.A0
 ;;^UTILITY(U,$J,358.3,30590,2)
 ;;=^5003912
 ;;^UTILITY(U,$J,358.3,30591,0)
 ;;=G43.C1^^135^1379^16
 ;;^UTILITY(U,$J,358.3,30591,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30591,1,3,0)
 ;;=3^Headache Syndromes,Periodic Intractable
 ;;^UTILITY(U,$J,358.3,30591,1,4,0)
 ;;=4^G43.C1
 ;;^UTILITY(U,$J,358.3,30591,2)
 ;;=^5003917
 ;;^UTILITY(U,$J,358.3,30592,0)
 ;;=G43.B1^^135^1379^27
 ;;^UTILITY(U,$J,358.3,30592,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30592,1,3,0)
 ;;=3^Migraine,Ophthalmoplegic Intractable
 ;;^UTILITY(U,$J,358.3,30592,1,4,0)
 ;;=4^G43.B1
 ;;^UTILITY(U,$J,358.3,30592,2)
 ;;=^5003915
 ;;^UTILITY(U,$J,358.3,30593,0)
 ;;=G43.A1^^135^1379^7
 ;;^UTILITY(U,$J,358.3,30593,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30593,1,3,0)
 ;;=3^Cyclical Vomiting Intractable
 ;;^UTILITY(U,$J,358.3,30593,1,4,0)
 ;;=4^G43.A1
 ;;^UTILITY(U,$J,358.3,30593,2)
 ;;=^5003913
 ;;^UTILITY(U,$J,358.3,30594,0)
 ;;=G43.819^^135^1379^23
 ;;^UTILITY(U,$J,358.3,30594,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30594,1,3,0)
 ;;=3^Migraine Intractable w/o Status Migrainosus,Other
 ;;^UTILITY(U,$J,358.3,30594,1,4,0)
 ;;=4^G43.819
 ;;^UTILITY(U,$J,358.3,30594,2)
 ;;=^5003903
 ;;^UTILITY(U,$J,358.3,30595,0)
 ;;=G43.909^^135^1379^25
 ;;^UTILITY(U,$J,358.3,30595,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30595,1,3,0)
 ;;=3^Migraine Not Intractable w/o Status Migrainosus,Unspec
 ;;^UTILITY(U,$J,358.3,30595,1,4,0)
 ;;=4^G43.909
 ;;^UTILITY(U,$J,358.3,30595,2)
 ;;=^5003909
 ;;^UTILITY(U,$J,358.3,30596,0)
 ;;=G43.919^^135^1379^24
 ;;^UTILITY(U,$J,358.3,30596,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30596,1,3,0)
 ;;=3^Migraine Intractable w/o Status Migrainosus,Unspec
 ;;^UTILITY(U,$J,358.3,30596,1,4,0)
 ;;=4^G43.919
 ;;^UTILITY(U,$J,358.3,30596,2)
 ;;=^5003911
 ;;^UTILITY(U,$J,358.3,30597,0)
 ;;=G51.0^^135^1379^5
 ;;^UTILITY(U,$J,358.3,30597,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30597,1,3,0)
 ;;=3^Bell's Palsy
 ;;^UTILITY(U,$J,358.3,30597,1,4,0)
 ;;=4^G51.0

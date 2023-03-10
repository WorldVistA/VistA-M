IBDEI127 ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,17210,1,4,0)
 ;;=4^G25.2
 ;;^UTILITY(U,$J,358.3,17210,2)
 ;;=^5003793
 ;;^UTILITY(U,$J,358.3,17211,0)
 ;;=G25.1^^61^782^44
 ;;^UTILITY(U,$J,358.3,17211,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17211,1,3,0)
 ;;=3^Tremor,Drug-Induced
 ;;^UTILITY(U,$J,358.3,17211,1,4,0)
 ;;=4^G25.1
 ;;^UTILITY(U,$J,358.3,17211,2)
 ;;=^5003792
 ;;^UTILITY(U,$J,358.3,17212,0)
 ;;=G25.81^^61^782^39
 ;;^UTILITY(U,$J,358.3,17212,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17212,1,3,0)
 ;;=3^Restless Legs Syndrome
 ;;^UTILITY(U,$J,358.3,17212,1,4,0)
 ;;=4^G25.81
 ;;^UTILITY(U,$J,358.3,17212,2)
 ;;=^5003801
 ;;^UTILITY(U,$J,358.3,17213,0)
 ;;=G35.^^61^782^32
 ;;^UTILITY(U,$J,358.3,17213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17213,1,3,0)
 ;;=3^Multiple Sclerosis
 ;;^UTILITY(U,$J,358.3,17213,1,4,0)
 ;;=4^G35.
 ;;^UTILITY(U,$J,358.3,17213,2)
 ;;=^79761
 ;;^UTILITY(U,$J,358.3,17214,0)
 ;;=G40.901^^61^782^14
 ;;^UTILITY(U,$J,358.3,17214,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17214,1,3,0)
 ;;=3^Epilepsy,Not Intractable w/ Status Epilepticus,Unspec
 ;;^UTILITY(U,$J,358.3,17214,1,4,0)
 ;;=4^G40.901
 ;;^UTILITY(U,$J,358.3,17214,2)
 ;;=^5003864
 ;;^UTILITY(U,$J,358.3,17215,0)
 ;;=G40.909^^61^782^15
 ;;^UTILITY(U,$J,358.3,17215,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17215,1,3,0)
 ;;=3^Epilepsy,Not Intractable w/o Status Epilepticus,Unspec
 ;;^UTILITY(U,$J,358.3,17215,1,4,0)
 ;;=4^G40.909
 ;;^UTILITY(U,$J,358.3,17215,2)
 ;;=^5003865
 ;;^UTILITY(U,$J,358.3,17216,0)
 ;;=G43.809^^61^782^29
 ;;^UTILITY(U,$J,358.3,17216,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17216,1,3,0)
 ;;=3^Migraine,Not Intractable w/o Status Migrainosus,Other
 ;;^UTILITY(U,$J,358.3,17216,1,4,0)
 ;;=4^G43.809
 ;;^UTILITY(U,$J,358.3,17216,2)
 ;;=^5003901
 ;;^UTILITY(U,$J,358.3,17217,0)
 ;;=G43.B0^^61^782^31
 ;;^UTILITY(U,$J,358.3,17217,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17217,1,3,0)
 ;;=3^Migraine,Ophthalmoplegic Not Intractable
 ;;^UTILITY(U,$J,358.3,17217,1,4,0)
 ;;=4^G43.B0
 ;;^UTILITY(U,$J,358.3,17217,2)
 ;;=^5003914
 ;;^UTILITY(U,$J,358.3,17218,0)
 ;;=G43.C0^^61^782^18
 ;;^UTILITY(U,$J,358.3,17218,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17218,1,3,0)
 ;;=3^Headache Syndromes,Periodic Not Intractable
 ;;^UTILITY(U,$J,358.3,17218,1,4,0)
 ;;=4^G43.C0
 ;;^UTILITY(U,$J,358.3,17218,2)
 ;;=^5003916
 ;;^UTILITY(U,$J,358.3,17219,0)
 ;;=G43.A0^^61^782^9
 ;;^UTILITY(U,$J,358.3,17219,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17219,1,3,0)
 ;;=3^Cyclical Vomiting Not Intractable
 ;;^UTILITY(U,$J,358.3,17219,1,4,0)
 ;;=4^G43.A0
 ;;^UTILITY(U,$J,358.3,17219,2)
 ;;=^5003912
 ;;^UTILITY(U,$J,358.3,17220,0)
 ;;=G43.C1^^61^782^17
 ;;^UTILITY(U,$J,358.3,17220,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17220,1,3,0)
 ;;=3^Headache Syndromes,Periodic Intractable
 ;;^UTILITY(U,$J,358.3,17220,1,4,0)
 ;;=4^G43.C1
 ;;^UTILITY(U,$J,358.3,17220,2)
 ;;=^5003917
 ;;^UTILITY(U,$J,358.3,17221,0)
 ;;=G43.B1^^61^782^30
 ;;^UTILITY(U,$J,358.3,17221,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17221,1,3,0)
 ;;=3^Migraine,Ophthalmoplegic Intractable
 ;;^UTILITY(U,$J,358.3,17221,1,4,0)
 ;;=4^G43.B1
 ;;^UTILITY(U,$J,358.3,17221,2)
 ;;=^5003915
 ;;^UTILITY(U,$J,358.3,17222,0)
 ;;=G43.A1^^61^782^8
 ;;^UTILITY(U,$J,358.3,17222,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17222,1,3,0)
 ;;=3^Cyclical Vomiting Intractable
 ;;^UTILITY(U,$J,358.3,17222,1,4,0)
 ;;=4^G43.A1

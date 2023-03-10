IBDEI0KK ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9251,1,3,0)
 ;;=3^Tremor,Drug-Induced
 ;;^UTILITY(U,$J,358.3,9251,1,4,0)
 ;;=4^G25.1
 ;;^UTILITY(U,$J,358.3,9251,2)
 ;;=^5003792
 ;;^UTILITY(U,$J,358.3,9252,0)
 ;;=G25.81^^39^408^39
 ;;^UTILITY(U,$J,358.3,9252,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9252,1,3,0)
 ;;=3^Restless Legs Syndrome
 ;;^UTILITY(U,$J,358.3,9252,1,4,0)
 ;;=4^G25.81
 ;;^UTILITY(U,$J,358.3,9252,2)
 ;;=^5003801
 ;;^UTILITY(U,$J,358.3,9253,0)
 ;;=G35.^^39^408^32
 ;;^UTILITY(U,$J,358.3,9253,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9253,1,3,0)
 ;;=3^Multiple Sclerosis
 ;;^UTILITY(U,$J,358.3,9253,1,4,0)
 ;;=4^G35.
 ;;^UTILITY(U,$J,358.3,9253,2)
 ;;=^79761
 ;;^UTILITY(U,$J,358.3,9254,0)
 ;;=G40.901^^39^408^14
 ;;^UTILITY(U,$J,358.3,9254,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9254,1,3,0)
 ;;=3^Epilepsy,Not Intractable w/ Status Epilepticus,Unspec
 ;;^UTILITY(U,$J,358.3,9254,1,4,0)
 ;;=4^G40.901
 ;;^UTILITY(U,$J,358.3,9254,2)
 ;;=^5003864
 ;;^UTILITY(U,$J,358.3,9255,0)
 ;;=G40.909^^39^408^15
 ;;^UTILITY(U,$J,358.3,9255,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9255,1,3,0)
 ;;=3^Epilepsy,Not Intractable w/o Status Epilepticus,Unspec
 ;;^UTILITY(U,$J,358.3,9255,1,4,0)
 ;;=4^G40.909
 ;;^UTILITY(U,$J,358.3,9255,2)
 ;;=^5003865
 ;;^UTILITY(U,$J,358.3,9256,0)
 ;;=G43.809^^39^408^29
 ;;^UTILITY(U,$J,358.3,9256,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9256,1,3,0)
 ;;=3^Migraine,Not Intractable w/o Status Migrainosus,Other
 ;;^UTILITY(U,$J,358.3,9256,1,4,0)
 ;;=4^G43.809
 ;;^UTILITY(U,$J,358.3,9256,2)
 ;;=^5003901
 ;;^UTILITY(U,$J,358.3,9257,0)
 ;;=G43.B0^^39^408^31
 ;;^UTILITY(U,$J,358.3,9257,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9257,1,3,0)
 ;;=3^Migraine,Ophthalmoplegic Not Intractable
 ;;^UTILITY(U,$J,358.3,9257,1,4,0)
 ;;=4^G43.B0
 ;;^UTILITY(U,$J,358.3,9257,2)
 ;;=^5003914
 ;;^UTILITY(U,$J,358.3,9258,0)
 ;;=G43.C0^^39^408^18
 ;;^UTILITY(U,$J,358.3,9258,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9258,1,3,0)
 ;;=3^Headache Syndromes,Periodic Not Intractable
 ;;^UTILITY(U,$J,358.3,9258,1,4,0)
 ;;=4^G43.C0
 ;;^UTILITY(U,$J,358.3,9258,2)
 ;;=^5003916
 ;;^UTILITY(U,$J,358.3,9259,0)
 ;;=G43.A0^^39^408^9
 ;;^UTILITY(U,$J,358.3,9259,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9259,1,3,0)
 ;;=3^Cyclical Vomiting Not Intractable
 ;;^UTILITY(U,$J,358.3,9259,1,4,0)
 ;;=4^G43.A0
 ;;^UTILITY(U,$J,358.3,9259,2)
 ;;=^5003912
 ;;^UTILITY(U,$J,358.3,9260,0)
 ;;=G43.C1^^39^408^17
 ;;^UTILITY(U,$J,358.3,9260,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9260,1,3,0)
 ;;=3^Headache Syndromes,Periodic Intractable
 ;;^UTILITY(U,$J,358.3,9260,1,4,0)
 ;;=4^G43.C1
 ;;^UTILITY(U,$J,358.3,9260,2)
 ;;=^5003917
 ;;^UTILITY(U,$J,358.3,9261,0)
 ;;=G43.B1^^39^408^30
 ;;^UTILITY(U,$J,358.3,9261,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9261,1,3,0)
 ;;=3^Migraine,Ophthalmoplegic Intractable
 ;;^UTILITY(U,$J,358.3,9261,1,4,0)
 ;;=4^G43.B1
 ;;^UTILITY(U,$J,358.3,9261,2)
 ;;=^5003915
 ;;^UTILITY(U,$J,358.3,9262,0)
 ;;=G43.A1^^39^408^8
 ;;^UTILITY(U,$J,358.3,9262,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9262,1,3,0)
 ;;=3^Cyclical Vomiting Intractable
 ;;^UTILITY(U,$J,358.3,9262,1,4,0)
 ;;=4^G43.A1
 ;;^UTILITY(U,$J,358.3,9262,2)
 ;;=^5003913
 ;;^UTILITY(U,$J,358.3,9263,0)
 ;;=G43.819^^39^408^26
 ;;^UTILITY(U,$J,358.3,9263,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9263,1,3,0)
 ;;=3^Migraine Intractable w/o Status Migrainosus,Other

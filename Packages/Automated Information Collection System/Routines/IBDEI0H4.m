IBDEI0H4 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7426,0)
 ;;=G21.4^^58^474^45
 ;;^UTILITY(U,$J,358.3,7426,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7426,1,3,0)
 ;;=3^Vascular Parkinsonism
 ;;^UTILITY(U,$J,358.3,7426,1,4,0)
 ;;=4^G21.4
 ;;^UTILITY(U,$J,358.3,7426,2)
 ;;=^5003776
 ;;^UTILITY(U,$J,358.3,7427,0)
 ;;=G20.^^58^474^34
 ;;^UTILITY(U,$J,358.3,7427,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7427,1,3,0)
 ;;=3^Parkinson's Disease
 ;;^UTILITY(U,$J,358.3,7427,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,7427,2)
 ;;=^5003770
 ;;^UTILITY(U,$J,358.3,7428,0)
 ;;=G25.0^^58^474^15
 ;;^UTILITY(U,$J,358.3,7428,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7428,1,3,0)
 ;;=3^Essential Tremor
 ;;^UTILITY(U,$J,358.3,7428,1,4,0)
 ;;=4^G25.0
 ;;^UTILITY(U,$J,358.3,7428,2)
 ;;=^5003791
 ;;^UTILITY(U,$J,358.3,7429,0)
 ;;=G25.2^^58^474^44
 ;;^UTILITY(U,$J,358.3,7429,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7429,1,3,0)
 ;;=3^Tremor,Other Spec Forms
 ;;^UTILITY(U,$J,358.3,7429,1,4,0)
 ;;=4^G25.2
 ;;^UTILITY(U,$J,358.3,7429,2)
 ;;=^5003793
 ;;^UTILITY(U,$J,358.3,7430,0)
 ;;=G25.1^^58^474^43
 ;;^UTILITY(U,$J,358.3,7430,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7430,1,3,0)
 ;;=3^Tremor,Drug-Induced
 ;;^UTILITY(U,$J,358.3,7430,1,4,0)
 ;;=4^G25.1
 ;;^UTILITY(U,$J,358.3,7430,2)
 ;;=^5003792
 ;;^UTILITY(U,$J,358.3,7431,0)
 ;;=G25.81^^58^474^38
 ;;^UTILITY(U,$J,358.3,7431,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7431,1,3,0)
 ;;=3^Restless Legs Syndrome
 ;;^UTILITY(U,$J,358.3,7431,1,4,0)
 ;;=4^G25.81
 ;;^UTILITY(U,$J,358.3,7431,2)
 ;;=^5003801
 ;;^UTILITY(U,$J,358.3,7432,0)
 ;;=G35.^^58^474^31
 ;;^UTILITY(U,$J,358.3,7432,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7432,1,3,0)
 ;;=3^Multiple Sclerosis
 ;;^UTILITY(U,$J,358.3,7432,1,4,0)
 ;;=4^G35.
 ;;^UTILITY(U,$J,358.3,7432,2)
 ;;=^79761
 ;;^UTILITY(U,$J,358.3,7433,0)
 ;;=G40.901^^58^474^13
 ;;^UTILITY(U,$J,358.3,7433,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7433,1,3,0)
 ;;=3^Epilepsy,Not Intractable w/ Status Epilepticus,Unspec
 ;;^UTILITY(U,$J,358.3,7433,1,4,0)
 ;;=4^G40.901
 ;;^UTILITY(U,$J,358.3,7433,2)
 ;;=^5003864
 ;;^UTILITY(U,$J,358.3,7434,0)
 ;;=G40.909^^58^474^14
 ;;^UTILITY(U,$J,358.3,7434,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7434,1,3,0)
 ;;=3^Epilepsy,Not Intractable w/o Status Epilepticus,Unspec
 ;;^UTILITY(U,$J,358.3,7434,1,4,0)
 ;;=4^G40.909
 ;;^UTILITY(U,$J,358.3,7434,2)
 ;;=^5003865
 ;;^UTILITY(U,$J,358.3,7435,0)
 ;;=G43.809^^58^474^28
 ;;^UTILITY(U,$J,358.3,7435,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7435,1,3,0)
 ;;=3^Migraine,Not Intractable w/o Status Migrainosus,Other
 ;;^UTILITY(U,$J,358.3,7435,1,4,0)
 ;;=4^G43.809
 ;;^UTILITY(U,$J,358.3,7435,2)
 ;;=^5003901
 ;;^UTILITY(U,$J,358.3,7436,0)
 ;;=G43.B0^^58^474^30
 ;;^UTILITY(U,$J,358.3,7436,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7436,1,3,0)
 ;;=3^Migraine,Ophthalmoplegic Not Intractable
 ;;^UTILITY(U,$J,358.3,7436,1,4,0)
 ;;=4^G43.B0
 ;;^UTILITY(U,$J,358.3,7436,2)
 ;;=^5003914
 ;;^UTILITY(U,$J,358.3,7437,0)
 ;;=G43.C0^^58^474^17
 ;;^UTILITY(U,$J,358.3,7437,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7437,1,3,0)
 ;;=3^Headache Syndromes,Periodic Not Intractable
 ;;^UTILITY(U,$J,358.3,7437,1,4,0)
 ;;=4^G43.C0
 ;;^UTILITY(U,$J,358.3,7437,2)
 ;;=^5003916
 ;;^UTILITY(U,$J,358.3,7438,0)
 ;;=G43.A0^^58^474^8
 ;;^UTILITY(U,$J,358.3,7438,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7438,1,3,0)
 ;;=3^Cyclical Vomiting Not Intractable

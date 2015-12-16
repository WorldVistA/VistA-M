IBDEI1W6 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,33272,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33272,1,3,0)
 ;;=3^Restless Legs Syndrome
 ;;^UTILITY(U,$J,358.3,33272,1,4,0)
 ;;=4^G25.81
 ;;^UTILITY(U,$J,358.3,33272,2)
 ;;=^5003801
 ;;^UTILITY(U,$J,358.3,33273,0)
 ;;=G35.^^182^1999^29
 ;;^UTILITY(U,$J,358.3,33273,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33273,1,3,0)
 ;;=3^Multiple Sclerosis
 ;;^UTILITY(U,$J,358.3,33273,1,4,0)
 ;;=4^G35.
 ;;^UTILITY(U,$J,358.3,33273,2)
 ;;=^79761
 ;;^UTILITY(U,$J,358.3,33274,0)
 ;;=G40.901^^182^1999^13
 ;;^UTILITY(U,$J,358.3,33274,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33274,1,3,0)
 ;;=3^Epilepsy,Not Intractable w/ Status Epilepticus,Unspec
 ;;^UTILITY(U,$J,358.3,33274,1,4,0)
 ;;=4^G40.901
 ;;^UTILITY(U,$J,358.3,33274,2)
 ;;=^5003864
 ;;^UTILITY(U,$J,358.3,33275,0)
 ;;=G40.909^^182^1999^14
 ;;^UTILITY(U,$J,358.3,33275,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33275,1,3,0)
 ;;=3^Epilepsy,Not Intractable w/o Status Epilepticus,Unspec
 ;;^UTILITY(U,$J,358.3,33275,1,4,0)
 ;;=4^G40.909
 ;;^UTILITY(U,$J,358.3,33275,2)
 ;;=^5003865
 ;;^UTILITY(U,$J,358.3,33276,0)
 ;;=G43.809^^182^1999^26
 ;;^UTILITY(U,$J,358.3,33276,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33276,1,3,0)
 ;;=3^Migraine,Not Intractable w/o Status Migrainosus,Other
 ;;^UTILITY(U,$J,358.3,33276,1,4,0)
 ;;=4^G43.809
 ;;^UTILITY(U,$J,358.3,33276,2)
 ;;=^5003901
 ;;^UTILITY(U,$J,358.3,33277,0)
 ;;=G43.B0^^182^1999^28
 ;;^UTILITY(U,$J,358.3,33277,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33277,1,3,0)
 ;;=3^Migraine,Ophthalmoplegic Not Intractable
 ;;^UTILITY(U,$J,358.3,33277,1,4,0)
 ;;=4^G43.B0
 ;;^UTILITY(U,$J,358.3,33277,2)
 ;;=^5003914
 ;;^UTILITY(U,$J,358.3,33278,0)
 ;;=G43.C0^^182^1999^17
 ;;^UTILITY(U,$J,358.3,33278,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33278,1,3,0)
 ;;=3^Headache Syndromes,Periodic Not Intractable
 ;;^UTILITY(U,$J,358.3,33278,1,4,0)
 ;;=4^G43.C0
 ;;^UTILITY(U,$J,358.3,33278,2)
 ;;=^5003916
 ;;^UTILITY(U,$J,358.3,33279,0)
 ;;=G43.A0^^182^1999^8
 ;;^UTILITY(U,$J,358.3,33279,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33279,1,3,0)
 ;;=3^Cyclical Vomiting Not Intractable
 ;;^UTILITY(U,$J,358.3,33279,1,4,0)
 ;;=4^G43.A0
 ;;^UTILITY(U,$J,358.3,33279,2)
 ;;=^5003912
 ;;^UTILITY(U,$J,358.3,33280,0)
 ;;=G43.C1^^182^1999^16
 ;;^UTILITY(U,$J,358.3,33280,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33280,1,3,0)
 ;;=3^Headache Syndromes,Periodic Intractable
 ;;^UTILITY(U,$J,358.3,33280,1,4,0)
 ;;=4^G43.C1
 ;;^UTILITY(U,$J,358.3,33280,2)
 ;;=^5003917
 ;;^UTILITY(U,$J,358.3,33281,0)
 ;;=G43.B1^^182^1999^27
 ;;^UTILITY(U,$J,358.3,33281,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33281,1,3,0)
 ;;=3^Migraine,Ophthalmoplegic Intractable
 ;;^UTILITY(U,$J,358.3,33281,1,4,0)
 ;;=4^G43.B1
 ;;^UTILITY(U,$J,358.3,33281,2)
 ;;=^5003915
 ;;^UTILITY(U,$J,358.3,33282,0)
 ;;=G43.A1^^182^1999^7
 ;;^UTILITY(U,$J,358.3,33282,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33282,1,3,0)
 ;;=3^Cyclical Vomiting Intractable
 ;;^UTILITY(U,$J,358.3,33282,1,4,0)
 ;;=4^G43.A1
 ;;^UTILITY(U,$J,358.3,33282,2)
 ;;=^5003913
 ;;^UTILITY(U,$J,358.3,33283,0)
 ;;=G43.819^^182^1999^23
 ;;^UTILITY(U,$J,358.3,33283,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33283,1,3,0)
 ;;=3^Migraine Intractable w/o Status Migrainosus,Other
 ;;^UTILITY(U,$J,358.3,33283,1,4,0)
 ;;=4^G43.819
 ;;^UTILITY(U,$J,358.3,33283,2)
 ;;=^5003903
 ;;^UTILITY(U,$J,358.3,33284,0)
 ;;=G43.909^^182^1999^25
 ;;^UTILITY(U,$J,358.3,33284,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33284,1,3,0)
 ;;=3^Migraine Not Intractable w/o Status Migrainosus,Unspec
 ;;^UTILITY(U,$J,358.3,33284,1,4,0)
 ;;=4^G43.909

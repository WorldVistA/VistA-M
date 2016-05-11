IBDEI0FK ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7180,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7180,1,3,0)
 ;;=3^Restless Legs Syndrome
 ;;^UTILITY(U,$J,358.3,7180,1,4,0)
 ;;=4^G25.81
 ;;^UTILITY(U,$J,358.3,7180,2)
 ;;=^5003801
 ;;^UTILITY(U,$J,358.3,7181,0)
 ;;=G35.^^30^403^31
 ;;^UTILITY(U,$J,358.3,7181,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7181,1,3,0)
 ;;=3^Multiple Sclerosis
 ;;^UTILITY(U,$J,358.3,7181,1,4,0)
 ;;=4^G35.
 ;;^UTILITY(U,$J,358.3,7181,2)
 ;;=^79761
 ;;^UTILITY(U,$J,358.3,7182,0)
 ;;=G40.901^^30^403^15
 ;;^UTILITY(U,$J,358.3,7182,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7182,1,3,0)
 ;;=3^Epilepsy,Not Intractable w/ Status Epilepticus,Unspec
 ;;^UTILITY(U,$J,358.3,7182,1,4,0)
 ;;=4^G40.901
 ;;^UTILITY(U,$J,358.3,7182,2)
 ;;=^5003864
 ;;^UTILITY(U,$J,358.3,7183,0)
 ;;=G40.909^^30^403^16
 ;;^UTILITY(U,$J,358.3,7183,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7183,1,3,0)
 ;;=3^Epilepsy,Not Intractable w/o Status Epilepticus,Unspec
 ;;^UTILITY(U,$J,358.3,7183,1,4,0)
 ;;=4^G40.909
 ;;^UTILITY(U,$J,358.3,7183,2)
 ;;=^5003865
 ;;^UTILITY(U,$J,358.3,7184,0)
 ;;=G43.809^^30^403^28
 ;;^UTILITY(U,$J,358.3,7184,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7184,1,3,0)
 ;;=3^Migraine,Not Intractable w/o Status Migrainosus,Other
 ;;^UTILITY(U,$J,358.3,7184,1,4,0)
 ;;=4^G43.809
 ;;^UTILITY(U,$J,358.3,7184,2)
 ;;=^5003901
 ;;^UTILITY(U,$J,358.3,7185,0)
 ;;=G43.B0^^30^403^30
 ;;^UTILITY(U,$J,358.3,7185,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7185,1,3,0)
 ;;=3^Migraine,Ophthalmoplegic Not Intractable
 ;;^UTILITY(U,$J,358.3,7185,1,4,0)
 ;;=4^G43.B0
 ;;^UTILITY(U,$J,358.3,7185,2)
 ;;=^5003914
 ;;^UTILITY(U,$J,358.3,7186,0)
 ;;=G43.C0^^30^403^19
 ;;^UTILITY(U,$J,358.3,7186,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7186,1,3,0)
 ;;=3^Headache Syndromes,Periodic Not Intractable
 ;;^UTILITY(U,$J,358.3,7186,1,4,0)
 ;;=4^G43.C0
 ;;^UTILITY(U,$J,358.3,7186,2)
 ;;=^5003916
 ;;^UTILITY(U,$J,358.3,7187,0)
 ;;=G43.A0^^30^403^10
 ;;^UTILITY(U,$J,358.3,7187,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7187,1,3,0)
 ;;=3^Cyclical Vomiting Not Intractable
 ;;^UTILITY(U,$J,358.3,7187,1,4,0)
 ;;=4^G43.A0
 ;;^UTILITY(U,$J,358.3,7187,2)
 ;;=^5003912
 ;;^UTILITY(U,$J,358.3,7188,0)
 ;;=G43.C1^^30^403^18
 ;;^UTILITY(U,$J,358.3,7188,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7188,1,3,0)
 ;;=3^Headache Syndromes,Periodic Intractable
 ;;^UTILITY(U,$J,358.3,7188,1,4,0)
 ;;=4^G43.C1
 ;;^UTILITY(U,$J,358.3,7188,2)
 ;;=^5003917
 ;;^UTILITY(U,$J,358.3,7189,0)
 ;;=G43.B1^^30^403^29
 ;;^UTILITY(U,$J,358.3,7189,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7189,1,3,0)
 ;;=3^Migraine,Ophthalmoplegic Intractable
 ;;^UTILITY(U,$J,358.3,7189,1,4,0)
 ;;=4^G43.B1
 ;;^UTILITY(U,$J,358.3,7189,2)
 ;;=^5003915
 ;;^UTILITY(U,$J,358.3,7190,0)
 ;;=G43.A1^^30^403^9
 ;;^UTILITY(U,$J,358.3,7190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7190,1,3,0)
 ;;=3^Cyclical Vomiting Intractable
 ;;^UTILITY(U,$J,358.3,7190,1,4,0)
 ;;=4^G43.A1
 ;;^UTILITY(U,$J,358.3,7190,2)
 ;;=^5003913
 ;;^UTILITY(U,$J,358.3,7191,0)
 ;;=G43.819^^30^403^25
 ;;^UTILITY(U,$J,358.3,7191,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7191,1,3,0)
 ;;=3^Migraine Intractable w/o Status Migrainosus,Other
 ;;^UTILITY(U,$J,358.3,7191,1,4,0)
 ;;=4^G43.819
 ;;^UTILITY(U,$J,358.3,7191,2)
 ;;=^5003903
 ;;^UTILITY(U,$J,358.3,7192,0)
 ;;=G43.909^^30^403^27
 ;;^UTILITY(U,$J,358.3,7192,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7192,1,3,0)
 ;;=3^Migraine Not Intractable w/o Status Migrainosus,Unspec
 ;;^UTILITY(U,$J,358.3,7192,1,4,0)
 ;;=4^G43.909
 ;;^UTILITY(U,$J,358.3,7192,2)
 ;;=^5003909

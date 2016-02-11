IBDEI3B5 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,55582,1,3,0)
 ;;=3^Epilepsy,Not Intractable w/ Status Epilepticus,Unspec
 ;;^UTILITY(U,$J,358.3,55582,1,4,0)
 ;;=4^G40.901
 ;;^UTILITY(U,$J,358.3,55582,2)
 ;;=^5003864
 ;;^UTILITY(U,$J,358.3,55583,0)
 ;;=G40.909^^256^2782^14
 ;;^UTILITY(U,$J,358.3,55583,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,55583,1,3,0)
 ;;=3^Epilepsy,Not Intractable w/o Status Epilepticus,Unspec
 ;;^UTILITY(U,$J,358.3,55583,1,4,0)
 ;;=4^G40.909
 ;;^UTILITY(U,$J,358.3,55583,2)
 ;;=^5003865
 ;;^UTILITY(U,$J,358.3,55584,0)
 ;;=G43.809^^256^2782^26
 ;;^UTILITY(U,$J,358.3,55584,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,55584,1,3,0)
 ;;=3^Migraine,Not Intractable w/o Status Migrainosus,Other
 ;;^UTILITY(U,$J,358.3,55584,1,4,0)
 ;;=4^G43.809
 ;;^UTILITY(U,$J,358.3,55584,2)
 ;;=^5003901
 ;;^UTILITY(U,$J,358.3,55585,0)
 ;;=G43.B0^^256^2782^28
 ;;^UTILITY(U,$J,358.3,55585,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,55585,1,3,0)
 ;;=3^Migraine,Ophthalmoplegic Not Intractable
 ;;^UTILITY(U,$J,358.3,55585,1,4,0)
 ;;=4^G43.B0
 ;;^UTILITY(U,$J,358.3,55585,2)
 ;;=^5003914
 ;;^UTILITY(U,$J,358.3,55586,0)
 ;;=G43.C0^^256^2782^17
 ;;^UTILITY(U,$J,358.3,55586,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,55586,1,3,0)
 ;;=3^Headache Syndromes,Periodic Not Intractable
 ;;^UTILITY(U,$J,358.3,55586,1,4,0)
 ;;=4^G43.C0
 ;;^UTILITY(U,$J,358.3,55586,2)
 ;;=^5003916
 ;;^UTILITY(U,$J,358.3,55587,0)
 ;;=G43.A0^^256^2782^8
 ;;^UTILITY(U,$J,358.3,55587,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,55587,1,3,0)
 ;;=3^Cyclical Vomiting Not Intractable
 ;;^UTILITY(U,$J,358.3,55587,1,4,0)
 ;;=4^G43.A0
 ;;^UTILITY(U,$J,358.3,55587,2)
 ;;=^5003912
 ;;^UTILITY(U,$J,358.3,55588,0)
 ;;=G43.C1^^256^2782^16
 ;;^UTILITY(U,$J,358.3,55588,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,55588,1,3,0)
 ;;=3^Headache Syndromes,Periodic Intractable
 ;;^UTILITY(U,$J,358.3,55588,1,4,0)
 ;;=4^G43.C1
 ;;^UTILITY(U,$J,358.3,55588,2)
 ;;=^5003917
 ;;^UTILITY(U,$J,358.3,55589,0)
 ;;=G43.B1^^256^2782^27
 ;;^UTILITY(U,$J,358.3,55589,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,55589,1,3,0)
 ;;=3^Migraine,Ophthalmoplegic Intractable
 ;;^UTILITY(U,$J,358.3,55589,1,4,0)
 ;;=4^G43.B1
 ;;^UTILITY(U,$J,358.3,55589,2)
 ;;=^5003915
 ;;^UTILITY(U,$J,358.3,55590,0)
 ;;=G43.A1^^256^2782^7
 ;;^UTILITY(U,$J,358.3,55590,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,55590,1,3,0)
 ;;=3^Cyclical Vomiting Intractable
 ;;^UTILITY(U,$J,358.3,55590,1,4,0)
 ;;=4^G43.A1
 ;;^UTILITY(U,$J,358.3,55590,2)
 ;;=^5003913
 ;;^UTILITY(U,$J,358.3,55591,0)
 ;;=G43.819^^256^2782^23
 ;;^UTILITY(U,$J,358.3,55591,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,55591,1,3,0)
 ;;=3^Migraine Intractable w/o Status Migrainosus,Other
 ;;^UTILITY(U,$J,358.3,55591,1,4,0)
 ;;=4^G43.819
 ;;^UTILITY(U,$J,358.3,55591,2)
 ;;=^5003903
 ;;^UTILITY(U,$J,358.3,55592,0)
 ;;=G43.909^^256^2782^25
 ;;^UTILITY(U,$J,358.3,55592,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,55592,1,3,0)
 ;;=3^Migraine Not Intractable w/o Status Migrainosus,Unspec
 ;;^UTILITY(U,$J,358.3,55592,1,4,0)
 ;;=4^G43.909
 ;;^UTILITY(U,$J,358.3,55592,2)
 ;;=^5003909
 ;;^UTILITY(U,$J,358.3,55593,0)
 ;;=G43.919^^256^2782^24
 ;;^UTILITY(U,$J,358.3,55593,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,55593,1,3,0)
 ;;=3^Migraine Intractable w/o Status Migrainosus,Unspec
 ;;^UTILITY(U,$J,358.3,55593,1,4,0)
 ;;=4^G43.919
 ;;^UTILITY(U,$J,358.3,55593,2)
 ;;=^5003911
 ;;^UTILITY(U,$J,358.3,55594,0)
 ;;=G51.0^^256^2782^5
 ;;^UTILITY(U,$J,358.3,55594,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,55594,1,3,0)
 ;;=3^Bell's Palsy
 ;;^UTILITY(U,$J,358.3,55594,1,4,0)
 ;;=4^G51.0

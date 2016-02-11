IBDEI0JG ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8759,0)
 ;;=G43.809^^55^545^48
 ;;^UTILITY(U,$J,358.3,8759,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8759,1,3,0)
 ;;=3^Other migraine, not intractable, without status migrainosus
 ;;^UTILITY(U,$J,358.3,8759,1,4,0)
 ;;=4^G43.809
 ;;^UTILITY(U,$J,358.3,8759,2)
 ;;=^5003901
 ;;^UTILITY(U,$J,358.3,8760,0)
 ;;=G43.A0^^55^545^23
 ;;^UTILITY(U,$J,358.3,8760,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8760,1,3,0)
 ;;=3^Cyclical vomiting, not intractable
 ;;^UTILITY(U,$J,358.3,8760,1,4,0)
 ;;=4^G43.A0
 ;;^UTILITY(U,$J,358.3,8760,2)
 ;;=^5003912
 ;;^UTILITY(U,$J,358.3,8761,0)
 ;;=G43.B0^^55^545^46
 ;;^UTILITY(U,$J,358.3,8761,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8761,1,3,0)
 ;;=3^Ophthalmoplegic migraine, not intractable
 ;;^UTILITY(U,$J,358.3,8761,1,4,0)
 ;;=4^G43.B0
 ;;^UTILITY(U,$J,358.3,8761,2)
 ;;=^5003914
 ;;^UTILITY(U,$J,358.3,8762,0)
 ;;=G43.C0^^55^545^54
 ;;^UTILITY(U,$J,358.3,8762,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8762,1,3,0)
 ;;=3^Periodic Headache Syndromes,Not Intractable
 ;;^UTILITY(U,$J,358.3,8762,1,4,0)
 ;;=4^G43.C0
 ;;^UTILITY(U,$J,358.3,8762,2)
 ;;=^5003916
 ;;^UTILITY(U,$J,358.3,8763,0)
 ;;=G43.D0^^55^545^2
 ;;^UTILITY(U,$J,358.3,8763,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8763,1,3,0)
 ;;=3^Abdominal migraine, not intractable
 ;;^UTILITY(U,$J,358.3,8763,1,4,0)
 ;;=4^G43.D0
 ;;^UTILITY(U,$J,358.3,8763,2)
 ;;=^5003918
 ;;^UTILITY(U,$J,358.3,8764,0)
 ;;=G43.A1^^55^545^22
 ;;^UTILITY(U,$J,358.3,8764,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8764,1,3,0)
 ;;=3^Cyclical vomiting, intractable
 ;;^UTILITY(U,$J,358.3,8764,1,4,0)
 ;;=4^G43.A1
 ;;^UTILITY(U,$J,358.3,8764,2)
 ;;=^5003913
 ;;^UTILITY(U,$J,358.3,8765,0)
 ;;=G43.B1^^55^545^45
 ;;^UTILITY(U,$J,358.3,8765,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8765,1,3,0)
 ;;=3^Ophthalmoplegic migraine, intractable
 ;;^UTILITY(U,$J,358.3,8765,1,4,0)
 ;;=4^G43.B1
 ;;^UTILITY(U,$J,358.3,8765,2)
 ;;=^5003915
 ;;^UTILITY(U,$J,358.3,8766,0)
 ;;=G43.C1^^55^545^53
 ;;^UTILITY(U,$J,358.3,8766,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8766,1,3,0)
 ;;=3^Periodic Headache Syndromes,Intractable
 ;;^UTILITY(U,$J,358.3,8766,1,4,0)
 ;;=4^G43.C1
 ;;^UTILITY(U,$J,358.3,8766,2)
 ;;=^5003917
 ;;^UTILITY(U,$J,358.3,8767,0)
 ;;=G43.D1^^55^545^1
 ;;^UTILITY(U,$J,358.3,8767,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8767,1,3,0)
 ;;=3^Abdominal migraine, intractable
 ;;^UTILITY(U,$J,358.3,8767,1,4,0)
 ;;=4^G43.D1
 ;;^UTILITY(U,$J,358.3,8767,2)
 ;;=^5003919
 ;;^UTILITY(U,$J,358.3,8768,0)
 ;;=G43.909^^55^545^42
 ;;^UTILITY(U,$J,358.3,8768,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8768,1,3,0)
 ;;=3^Migraine, unsp, not intractable, without status migrainosus
 ;;^UTILITY(U,$J,358.3,8768,1,4,0)
 ;;=4^G43.909
 ;;^UTILITY(U,$J,358.3,8768,2)
 ;;=^5003909
 ;;^UTILITY(U,$J,358.3,8769,0)
 ;;=G43.919^^55^545^41
 ;;^UTILITY(U,$J,358.3,8769,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8769,1,3,0)
 ;;=3^Migraine, unsp, intractable, without status migrainosus
 ;;^UTILITY(U,$J,358.3,8769,1,4,0)
 ;;=4^G43.919
 ;;^UTILITY(U,$J,358.3,8769,2)
 ;;=^5003911
 ;;^UTILITY(U,$J,358.3,8770,0)
 ;;=G51.0^^55^545^12
 ;;^UTILITY(U,$J,358.3,8770,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8770,1,3,0)
 ;;=3^Bell's palsy
 ;;^UTILITY(U,$J,358.3,8770,1,4,0)
 ;;=4^G51.0
 ;;^UTILITY(U,$J,358.3,8770,2)
 ;;=^13238
 ;;^UTILITY(U,$J,358.3,8771,0)
 ;;=G57.11^^55^545^40
 ;;^UTILITY(U,$J,358.3,8771,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8771,1,3,0)
 ;;=3^Meralgia paresthetica, right lower limb
 ;;^UTILITY(U,$J,358.3,8771,1,4,0)
 ;;=4^G57.11
 ;;^UTILITY(U,$J,358.3,8771,2)
 ;;=^5004042

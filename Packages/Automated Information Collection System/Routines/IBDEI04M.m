IBDEI04M ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1634,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,1635,0)
 ;;=G20.^^3^46^52
 ;;^UTILITY(U,$J,358.3,1635,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1635,1,3,0)
 ;;=3^Parkinson's disease
 ;;^UTILITY(U,$J,358.3,1635,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,1635,2)
 ;;=^5003770
 ;;^UTILITY(U,$J,358.3,1636,0)
 ;;=G25.0^^3^46^30
 ;;^UTILITY(U,$J,358.3,1636,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1636,1,3,0)
 ;;=3^Essential tremor
 ;;^UTILITY(U,$J,358.3,1636,1,4,0)
 ;;=4^G25.0
 ;;^UTILITY(U,$J,358.3,1636,2)
 ;;=^5003791
 ;;^UTILITY(U,$J,358.3,1637,0)
 ;;=G25.1^^3^46^26
 ;;^UTILITY(U,$J,358.3,1637,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1637,1,3,0)
 ;;=3^Drug-induced tremor
 ;;^UTILITY(U,$J,358.3,1637,1,4,0)
 ;;=4^G25.1
 ;;^UTILITY(U,$J,358.3,1637,2)
 ;;=^5003792
 ;;^UTILITY(U,$J,358.3,1638,0)
 ;;=G25.2^^3^46^64
 ;;^UTILITY(U,$J,358.3,1638,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1638,1,3,0)
 ;;=3^Tremor NEC
 ;;^UTILITY(U,$J,358.3,1638,1,4,0)
 ;;=4^G25.2
 ;;^UTILITY(U,$J,358.3,1638,2)
 ;;=^5003793
 ;;^UTILITY(U,$J,358.3,1639,0)
 ;;=G25.81^^3^46^57
 ;;^UTILITY(U,$J,358.3,1639,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1639,1,3,0)
 ;;=3^Restless legs syndrome
 ;;^UTILITY(U,$J,358.3,1639,1,4,0)
 ;;=4^G25.81
 ;;^UTILITY(U,$J,358.3,1639,2)
 ;;=^5003801
 ;;^UTILITY(U,$J,358.3,1640,0)
 ;;=G90.59^^3^46^19
 ;;^UTILITY(U,$J,358.3,1640,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1640,1,3,0)
 ;;=3^Complex regional pain syndrome I of other specified site
 ;;^UTILITY(U,$J,358.3,1640,1,4,0)
 ;;=4^G90.59
 ;;^UTILITY(U,$J,358.3,1640,2)
 ;;=^5004171
 ;;^UTILITY(U,$J,358.3,1641,0)
 ;;=G35.^^3^46^43
 ;;^UTILITY(U,$J,358.3,1641,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1641,1,3,0)
 ;;=3^Multiple sclerosis
 ;;^UTILITY(U,$J,358.3,1641,1,4,0)
 ;;=4^G35.
 ;;^UTILITY(U,$J,358.3,1641,2)
 ;;=^79761
 ;;^UTILITY(U,$J,358.3,1642,0)
 ;;=G82.20^^3^46^50
 ;;^UTILITY(U,$J,358.3,1642,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1642,1,3,0)
 ;;=3^Paraplegia, unspecified
 ;;^UTILITY(U,$J,358.3,1642,1,4,0)
 ;;=4^G82.20
 ;;^UTILITY(U,$J,358.3,1642,2)
 ;;=^5004125
 ;;^UTILITY(U,$J,358.3,1643,0)
 ;;=G40.909^^3^46^29
 ;;^UTILITY(U,$J,358.3,1643,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1643,1,3,0)
 ;;=3^Epilepsy, unsp, not intractable, without status epilepticus
 ;;^UTILITY(U,$J,358.3,1643,1,4,0)
 ;;=4^G40.909
 ;;^UTILITY(U,$J,358.3,1643,2)
 ;;=^5003865
 ;;^UTILITY(U,$J,358.3,1644,0)
 ;;=G40.901^^3^46^28
 ;;^UTILITY(U,$J,358.3,1644,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1644,1,3,0)
 ;;=3^Epilepsy, unsp, not intractable, with status epilepticus
 ;;^UTILITY(U,$J,358.3,1644,1,4,0)
 ;;=4^G40.901
 ;;^UTILITY(U,$J,358.3,1644,2)
 ;;=^5003864
 ;;^UTILITY(U,$J,358.3,1645,0)
 ;;=G43.809^^3^46^48
 ;;^UTILITY(U,$J,358.3,1645,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1645,1,3,0)
 ;;=3^Other migraine, not intractable, without status migrainosus
 ;;^UTILITY(U,$J,358.3,1645,1,4,0)
 ;;=4^G43.809
 ;;^UTILITY(U,$J,358.3,1645,2)
 ;;=^5003901
 ;;^UTILITY(U,$J,358.3,1646,0)
 ;;=G43.A0^^3^46^23
 ;;^UTILITY(U,$J,358.3,1646,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1646,1,3,0)
 ;;=3^Cyclical vomiting, not intractable
 ;;^UTILITY(U,$J,358.3,1646,1,4,0)
 ;;=4^G43.A0
 ;;^UTILITY(U,$J,358.3,1646,2)
 ;;=^5003912
 ;;^UTILITY(U,$J,358.3,1647,0)
 ;;=G43.B0^^3^46^46
 ;;^UTILITY(U,$J,358.3,1647,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1647,1,3,0)
 ;;=3^Ophthalmoplegic migraine, not intractable
 ;;^UTILITY(U,$J,358.3,1647,1,4,0)
 ;;=4^G43.B0
 ;;^UTILITY(U,$J,358.3,1647,2)
 ;;=^5003914
 ;;^UTILITY(U,$J,358.3,1648,0)
 ;;=G43.C0^^3^46^54

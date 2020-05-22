IBDEI0FU ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6841,1,4,0)
 ;;=4^G44.221
 ;;^UTILITY(U,$J,358.3,6841,2)
 ;;=^5003939
 ;;^UTILITY(U,$J,358.3,6842,0)
 ;;=G44.229^^56^440^3
 ;;^UTILITY(U,$J,358.3,6842,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6842,1,3,0)
 ;;=3^Chronic tension-type headache, not intractable
 ;;^UTILITY(U,$J,358.3,6842,1,4,0)
 ;;=4^G44.229
 ;;^UTILITY(U,$J,358.3,6842,2)
 ;;=^5003940
 ;;^UTILITY(U,$J,358.3,6843,0)
 ;;=G44.211^^56^440^4
 ;;^UTILITY(U,$J,358.3,6843,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6843,1,3,0)
 ;;=3^Episodic tension-type headache, intractable
 ;;^UTILITY(U,$J,358.3,6843,1,4,0)
 ;;=4^G44.211
 ;;^UTILITY(U,$J,358.3,6843,2)
 ;;=^5003937
 ;;^UTILITY(U,$J,358.3,6844,0)
 ;;=G44.219^^56^440^5
 ;;^UTILITY(U,$J,358.3,6844,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6844,1,3,0)
 ;;=3^Episodic tension-type headache, not intractable
 ;;^UTILITY(U,$J,358.3,6844,1,4,0)
 ;;=4^G44.219
 ;;^UTILITY(U,$J,358.3,6844,2)
 ;;=^5003938
 ;;^UTILITY(U,$J,358.3,6845,0)
 ;;=G43.109^^56^440^8
 ;;^UTILITY(U,$J,358.3,6845,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6845,1,3,0)
 ;;=3^Migraine with aura, not intractable, w/o status migrainosus
 ;;^UTILITY(U,$J,358.3,6845,1,4,0)
 ;;=4^G43.109
 ;;^UTILITY(U,$J,358.3,6845,2)
 ;;=^5003881
 ;;^UTILITY(U,$J,358.3,6846,0)
 ;;=G43.009^^56^440^7
 ;;^UTILITY(U,$J,358.3,6846,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6846,1,3,0)
 ;;=3^Migraine w/o aura, not intractable, w/o status migrainosus
 ;;^UTILITY(U,$J,358.3,6846,1,4,0)
 ;;=4^G43.009
 ;;^UTILITY(U,$J,358.3,6846,2)
 ;;=^5003877
 ;;^UTILITY(U,$J,358.3,6847,0)
 ;;=G43.D0^^56^440^1
 ;;^UTILITY(U,$J,358.3,6847,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6847,1,3,0)
 ;;=3^Abdominal migraine, not intractable
 ;;^UTILITY(U,$J,358.3,6847,1,4,0)
 ;;=4^G43.D0
 ;;^UTILITY(U,$J,358.3,6847,2)
 ;;=^5003918
 ;;^UTILITY(U,$J,358.3,6848,0)
 ;;=G43.809^^56^440^9
 ;;^UTILITY(U,$J,358.3,6848,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6848,1,3,0)
 ;;=3^Migraine, not intractable, w/o status migrainosis, other
 ;;^UTILITY(U,$J,358.3,6848,1,4,0)
 ;;=4^G43.809
 ;;^UTILITY(U,$J,358.3,6848,2)
 ;;=^5003901
 ;;^UTILITY(U,$J,358.3,6849,0)
 ;;=G43.B0^^56^440^11
 ;;^UTILITY(U,$J,358.3,6849,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6849,1,3,0)
 ;;=3^Ophthalmoplegic migraine, not intractable
 ;;^UTILITY(U,$J,358.3,6849,1,4,0)
 ;;=4^G43.B0
 ;;^UTILITY(U,$J,358.3,6849,2)
 ;;=^5003914
 ;;^UTILITY(U,$J,358.3,6850,0)
 ;;=G35.^^56^440^10
 ;;^UTILITY(U,$J,358.3,6850,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6850,1,3,0)
 ;;=3^Multiple sclerosis
 ;;^UTILITY(U,$J,358.3,6850,1,4,0)
 ;;=4^G35.
 ;;^UTILITY(U,$J,358.3,6850,2)
 ;;=^79761
 ;;^UTILITY(U,$J,358.3,6851,0)
 ;;=G43.C0^^56^440^12
 ;;^UTILITY(U,$J,358.3,6851,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6851,1,3,0)
 ;;=3^Periodic headache syndromes in chld/adlt, not intractable
 ;;^UTILITY(U,$J,358.3,6851,1,4,0)
 ;;=4^G43.C0
 ;;^UTILITY(U,$J,358.3,6851,2)
 ;;=^5003916
 ;;^UTILITY(U,$J,358.3,6852,0)
 ;;=G44.201^^56^440^13
 ;;^UTILITY(U,$J,358.3,6852,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6852,1,3,0)
 ;;=3^Tension-type headache, unspecified, intractable
 ;;^UTILITY(U,$J,358.3,6852,1,4,0)
 ;;=4^G44.201
 ;;^UTILITY(U,$J,358.3,6852,2)
 ;;=^5003935
 ;;^UTILITY(U,$J,358.3,6853,0)
 ;;=G44.209^^56^440^14
 ;;^UTILITY(U,$J,358.3,6853,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6853,1,3,0)
 ;;=3^Tension-type headache, unspecified, not intractable

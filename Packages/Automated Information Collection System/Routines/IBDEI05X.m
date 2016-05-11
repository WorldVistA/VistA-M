IBDEI05X ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2435,1,3,0)
 ;;=3^Abdominal migraine, not intractable
 ;;^UTILITY(U,$J,358.3,2435,1,4,0)
 ;;=4^G43.D0
 ;;^UTILITY(U,$J,358.3,2435,2)
 ;;=^5003918
 ;;^UTILITY(U,$J,358.3,2436,0)
 ;;=G43.809^^15^187^9
 ;;^UTILITY(U,$J,358.3,2436,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2436,1,3,0)
 ;;=3^Migraine, not intractable, w/o status migrainosis, other
 ;;^UTILITY(U,$J,358.3,2436,1,4,0)
 ;;=4^G43.809
 ;;^UTILITY(U,$J,358.3,2436,2)
 ;;=^5003901
 ;;^UTILITY(U,$J,358.3,2437,0)
 ;;=G43.B0^^15^187^11
 ;;^UTILITY(U,$J,358.3,2437,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2437,1,3,0)
 ;;=3^Ophthalmoplegic migraine, not intractable
 ;;^UTILITY(U,$J,358.3,2437,1,4,0)
 ;;=4^G43.B0
 ;;^UTILITY(U,$J,358.3,2437,2)
 ;;=^5003914
 ;;^UTILITY(U,$J,358.3,2438,0)
 ;;=G35.^^15^187^10
 ;;^UTILITY(U,$J,358.3,2438,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2438,1,3,0)
 ;;=3^Multiple sclerosis
 ;;^UTILITY(U,$J,358.3,2438,1,4,0)
 ;;=4^G35.
 ;;^UTILITY(U,$J,358.3,2438,2)
 ;;=^79761
 ;;^UTILITY(U,$J,358.3,2439,0)
 ;;=G43.C0^^15^187^12
 ;;^UTILITY(U,$J,358.3,2439,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2439,1,3,0)
 ;;=3^Periodic headache syndromes in chld/adlt, not intractable
 ;;^UTILITY(U,$J,358.3,2439,1,4,0)
 ;;=4^G43.C0
 ;;^UTILITY(U,$J,358.3,2439,2)
 ;;=^5003916
 ;;^UTILITY(U,$J,358.3,2440,0)
 ;;=G44.201^^15^187^13
 ;;^UTILITY(U,$J,358.3,2440,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2440,1,3,0)
 ;;=3^Tension-type headache, unspecified, intractable
 ;;^UTILITY(U,$J,358.3,2440,1,4,0)
 ;;=4^G44.201
 ;;^UTILITY(U,$J,358.3,2440,2)
 ;;=^5003935
 ;;^UTILITY(U,$J,358.3,2441,0)
 ;;=G44.209^^15^187^14
 ;;^UTILITY(U,$J,358.3,2441,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2441,1,3,0)
 ;;=3^Tension-type headache, unspecified, not intractable
 ;;^UTILITY(U,$J,358.3,2441,1,4,0)
 ;;=4^G44.209
 ;;^UTILITY(U,$J,358.3,2441,2)
 ;;=^5003936
 ;;^UTILITY(U,$J,358.3,2442,0)
 ;;=R51.^^15^187^6
 ;;^UTILITY(U,$J,358.3,2442,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2442,1,3,0)
 ;;=3^Headache
 ;;^UTILITY(U,$J,358.3,2442,1,4,0)
 ;;=4^R51.
 ;;^UTILITY(U,$J,358.3,2442,2)
 ;;=^5019513
 ;;^UTILITY(U,$J,358.3,2443,0)
 ;;=M99.81^^15^188^1
 ;;^UTILITY(U,$J,358.3,2443,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2443,1,3,0)
 ;;=3^Biomechanical lesions of cervial region, other
 ;;^UTILITY(U,$J,358.3,2443,1,4,0)
 ;;=4^M99.81
 ;;^UTILITY(U,$J,358.3,2443,2)
 ;;=^5015481
 ;;^UTILITY(U,$J,358.3,2444,0)
 ;;=M99.80^^15^188^2
 ;;^UTILITY(U,$J,358.3,2444,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2444,1,3,0)
 ;;=3^Biomechanical lesions of head region, other
 ;;^UTILITY(U,$J,358.3,2444,1,4,0)
 ;;=4^M99.80
 ;;^UTILITY(U,$J,358.3,2444,2)
 ;;=^5015480
 ;;^UTILITY(U,$J,358.3,2445,0)
 ;;=M50.30^^15^188^3
 ;;^UTILITY(U,$J,358.3,2445,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2445,1,3,0)
 ;;=3^Cervical disc degeneration, unspec cervical region
 ;;^UTILITY(U,$J,358.3,2445,1,4,0)
 ;;=4^M50.30
 ;;^UTILITY(U,$J,358.3,2445,2)
 ;;=^5012227
 ;;^UTILITY(U,$J,358.3,2446,0)
 ;;=G54.2^^15^188^7
 ;;^UTILITY(U,$J,358.3,2446,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2446,1,3,0)
 ;;=3^Cervical root disorders NEC
 ;;^UTILITY(U,$J,358.3,2446,1,4,0)
 ;;=4^G54.2
 ;;^UTILITY(U,$J,358.3,2446,2)
 ;;=^5004009
 ;;^UTILITY(U,$J,358.3,2447,0)
 ;;=M54.2^^15^188^8
 ;;^UTILITY(U,$J,358.3,2447,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2447,1,3,0)
 ;;=3^Cervicalgia
 ;;^UTILITY(U,$J,358.3,2447,1,4,0)
 ;;=4^M54.2
 ;;^UTILITY(U,$J,358.3,2447,2)
 ;;=^5012304
 ;;^UTILITY(U,$J,358.3,2448,0)
 ;;=M53.0^^15^188^9
 ;;^UTILITY(U,$J,358.3,2448,1,0)
 ;;=^358.31IA^4^2

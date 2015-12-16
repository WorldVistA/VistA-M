IBDEI06C ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2442,1,3,0)
 ;;=3^Peripheral vertigo, left ear NEC
 ;;^UTILITY(U,$J,358.3,2442,1,4,0)
 ;;=4^H81.392
 ;;^UTILITY(U,$J,358.3,2442,2)
 ;;=^5006877
 ;;^UTILITY(U,$J,358.3,2443,0)
 ;;=H81.11^^5^71^12
 ;;^UTILITY(U,$J,358.3,2443,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2443,1,3,0)
 ;;=3^Benign paroxysmal vertigo, right ear
 ;;^UTILITY(U,$J,358.3,2443,1,4,0)
 ;;=4^H81.11
 ;;^UTILITY(U,$J,358.3,2443,2)
 ;;=^5006865
 ;;^UTILITY(U,$J,358.3,2444,0)
 ;;=H81.12^^5^71^11
 ;;^UTILITY(U,$J,358.3,2444,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2444,1,3,0)
 ;;=3^Benign paroxysmal vertigo, left ear
 ;;^UTILITY(U,$J,358.3,2444,1,4,0)
 ;;=4^H81.12
 ;;^UTILITY(U,$J,358.3,2444,2)
 ;;=^5006866
 ;;^UTILITY(U,$J,358.3,2445,0)
 ;;=H92.03^^5^71^42
 ;;^UTILITY(U,$J,358.3,2445,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2445,1,3,0)
 ;;=3^Otalgia, bilateral
 ;;^UTILITY(U,$J,358.3,2445,1,4,0)
 ;;=4^H92.03
 ;;^UTILITY(U,$J,358.3,2445,2)
 ;;=^5006947
 ;;^UTILITY(U,$J,358.3,2446,0)
 ;;=R42.^^5^71^22
 ;;^UTILITY(U,$J,358.3,2446,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2446,1,3,0)
 ;;=3^Dizziness and giddiness
 ;;^UTILITY(U,$J,358.3,2446,1,4,0)
 ;;=4^R42.
 ;;^UTILITY(U,$J,358.3,2446,2)
 ;;=^5019450
 ;;^UTILITY(U,$J,358.3,2447,0)
 ;;=L04.9^^5^72^1
 ;;^UTILITY(U,$J,358.3,2447,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2447,1,3,0)
 ;;=3^Acute lymphadenitis, unspecified
 ;;^UTILITY(U,$J,358.3,2447,1,4,0)
 ;;=4^L04.9
 ;;^UTILITY(U,$J,358.3,2447,2)
 ;;=^5009074
 ;;^UTILITY(U,$J,358.3,2448,0)
 ;;=G47.33^^5^72^8
 ;;^UTILITY(U,$J,358.3,2448,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2448,1,3,0)
 ;;=3^Obstructive sleep apnea (adult) (pediatric)
 ;;^UTILITY(U,$J,358.3,2448,1,4,0)
 ;;=4^G47.33
 ;;^UTILITY(U,$J,358.3,2448,2)
 ;;=^332763
 ;;^UTILITY(U,$J,358.3,2449,0)
 ;;=R51.^^5^72^6
 ;;^UTILITY(U,$J,358.3,2449,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2449,1,3,0)
 ;;=3^Headache
 ;;^UTILITY(U,$J,358.3,2449,1,4,0)
 ;;=4^R51.
 ;;^UTILITY(U,$J,358.3,2449,2)
 ;;=^5019513
 ;;^UTILITY(U,$J,358.3,2450,0)
 ;;=R59.9^^5^72^5
 ;;^UTILITY(U,$J,358.3,2450,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2450,1,3,0)
 ;;=3^Enlarged lymph nodes, unspecified
 ;;^UTILITY(U,$J,358.3,2450,1,4,0)
 ;;=4^R59.9
 ;;^UTILITY(U,$J,358.3,2450,2)
 ;;=^5019531
 ;;^UTILITY(U,$J,358.3,2451,0)
 ;;=R05.^^5^72^4
 ;;^UTILITY(U,$J,358.3,2451,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2451,1,3,0)
 ;;=3^Cough
 ;;^UTILITY(U,$J,358.3,2451,1,4,0)
 ;;=4^R05.
 ;;^UTILITY(U,$J,358.3,2451,2)
 ;;=^5019179
 ;;^UTILITY(U,$J,358.3,2452,0)
 ;;=R04.2^^5^72^7
 ;;^UTILITY(U,$J,358.3,2452,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2452,1,3,0)
 ;;=3^Hemoptysis
 ;;^UTILITY(U,$J,358.3,2452,1,4,0)
 ;;=4^R04.2
 ;;^UTILITY(U,$J,358.3,2452,2)
 ;;=^5019175
 ;;^UTILITY(U,$J,358.3,2453,0)
 ;;=Z43.0^^5^72^2
 ;;^UTILITY(U,$J,358.3,2453,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2453,1,3,0)
 ;;=3^Attention to Tracheostomy
 ;;^UTILITY(U,$J,358.3,2453,1,4,0)
 ;;=4^Z43.0
 ;;^UTILITY(U,$J,358.3,2453,2)
 ;;=^5062958
 ;;^UTILITY(U,$J,358.3,2454,0)
 ;;=G51.0^^5^72^3
 ;;^UTILITY(U,$J,358.3,2454,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2454,1,3,0)
 ;;=3^Bell's palsy
 ;;^UTILITY(U,$J,358.3,2454,1,4,0)
 ;;=4^G51.0
 ;;^UTILITY(U,$J,358.3,2454,2)
 ;;=^13238
 ;;^UTILITY(U,$J,358.3,2455,0)
 ;;=C77.9^^5^73^1
 ;;^UTILITY(U,$J,358.3,2455,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2455,1,3,0)
 ;;=3^Secondary and unsp malignant neoplasm of lymph node, unsp
 ;;^UTILITY(U,$J,358.3,2455,1,4,0)
 ;;=4^C77.9
 ;;^UTILITY(U,$J,358.3,2455,2)
 ;;=^5001333
 ;;^UTILITY(U,$J,358.3,2456,0)
 ;;=C77.0^^5^73^2

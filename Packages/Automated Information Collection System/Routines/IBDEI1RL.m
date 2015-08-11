IBDEI1RL ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31550,0)
 ;;=N06.9^^190^1939^83
 ;;^UTILITY(U,$J,358.3,31550,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31550,1,3,0)
 ;;=3^Proteinuria Isolated w/ Unspec Morphologic Lesion
 ;;^UTILITY(U,$J,358.3,31550,1,4,0)
 ;;=4^N06.9
 ;;^UTILITY(U,$J,358.3,31550,2)
 ;;=^5015558
 ;;^UTILITY(U,$J,358.3,31551,0)
 ;;=N05.9^^190^1939^65
 ;;^UTILITY(U,$J,358.3,31551,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31551,1,3,0)
 ;;=3^Nephritic Syndrome w/ Unspec Morphologic Changes
 ;;^UTILITY(U,$J,358.3,31551,1,4,0)
 ;;=4^N05.9
 ;;^UTILITY(U,$J,358.3,31551,2)
 ;;=^5134086
 ;;^UTILITY(U,$J,358.3,31552,0)
 ;;=N07.9^^190^1939^67
 ;;^UTILITY(U,$J,358.3,31552,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31552,1,3,0)
 ;;=3^Nephropathy Hereditary w/ Unspec Morphologic Lesions
 ;;^UTILITY(U,$J,358.3,31552,1,4,0)
 ;;=4^N07.9
 ;;^UTILITY(U,$J,358.3,31552,2)
 ;;=^5015568
 ;;^UTILITY(U,$J,358.3,31553,0)
 ;;=N15.9^^190^1939^88
 ;;^UTILITY(U,$J,358.3,31553,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31553,1,3,0)
 ;;=3^Renal Tubulo-Interstitial Disease,Unspec
 ;;^UTILITY(U,$J,358.3,31553,1,4,0)
 ;;=4^N15.9
 ;;^UTILITY(U,$J,358.3,31553,2)
 ;;=^5015596
 ;;^UTILITY(U,$J,358.3,31554,0)
 ;;=N17.9^^190^1939^58
 ;;^UTILITY(U,$J,358.3,31554,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31554,1,3,0)
 ;;=3^Kidney Failure,Acute,Unspec
 ;;^UTILITY(U,$J,358.3,31554,1,4,0)
 ;;=4^N17.9
 ;;^UTILITY(U,$J,358.3,31554,2)
 ;;=^338532
 ;;^UTILITY(U,$J,358.3,31555,0)
 ;;=N18.9^^190^1939^57
 ;;^UTILITY(U,$J,358.3,31555,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31555,1,3,0)
 ;;=3^Kidney Disease,Chronic,Unspec
 ;;^UTILITY(U,$J,358.3,31555,1,4,0)
 ;;=4^N18.9
 ;;^UTILITY(U,$J,358.3,31555,2)
 ;;=^332812
 ;;^UTILITY(U,$J,358.3,31556,0)
 ;;=N19.^^190^1939^59
 ;;^UTILITY(U,$J,358.3,31556,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31556,1,3,0)
 ;;=3^Kidney Failure,Unspec
 ;;^UTILITY(U,$J,358.3,31556,1,4,0)
 ;;=4^N19.
 ;;^UTILITY(U,$J,358.3,31556,2)
 ;;=^5015607
 ;;^UTILITY(U,$J,358.3,31557,0)
 ;;=N11.0^^190^1939^87
 ;;^UTILITY(U,$J,358.3,31557,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31557,1,3,0)
 ;;=3^Pyelonephritis,Chronic Nonobstructive Reflux-Associated
 ;;^UTILITY(U,$J,358.3,31557,1,4,0)
 ;;=4^N11.0
 ;;^UTILITY(U,$J,358.3,31557,2)
 ;;=^5015571
 ;;^UTILITY(U,$J,358.3,31558,0)
 ;;=N10.^^190^1939^66
 ;;^UTILITY(U,$J,358.3,31558,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31558,1,3,0)
 ;;=3^Nephritis Acute Tubulo-Interstitial
 ;;^UTILITY(U,$J,358.3,31558,1,4,0)
 ;;=4^N10.
 ;;^UTILITY(U,$J,358.3,31558,2)
 ;;=^5015570
 ;;^UTILITY(U,$J,358.3,31559,0)
 ;;=N20.2^^190^1939^8
 ;;^UTILITY(U,$J,358.3,31559,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31559,1,3,0)
 ;;=3^Calculus Kidney w/ Calculus Ureter
 ;;^UTILITY(U,$J,358.3,31559,1,4,0)
 ;;=4^N20.2
 ;;^UTILITY(U,$J,358.3,31559,2)
 ;;=^5015609
 ;;^UTILITY(U,$J,358.3,31560,0)
 ;;=N20.0^^190^1939^7
 ;;^UTILITY(U,$J,358.3,31560,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31560,1,3,0)
 ;;=3^Calculus Kidney
 ;;^UTILITY(U,$J,358.3,31560,1,4,0)
 ;;=4^N20.0
 ;;^UTILITY(U,$J,358.3,31560,2)
 ;;=^67056
 ;;^UTILITY(U,$J,358.3,31561,0)
 ;;=N29.^^190^1939^56
 ;;^UTILITY(U,$J,358.3,31561,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31561,1,3,0)
 ;;=3^Kidney & Ureter Disorders in Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,31561,1,4,0)
 ;;=4^N29.
 ;;^UTILITY(U,$J,358.3,31561,2)
 ;;=^5015631
 ;;^UTILITY(U,$J,358.3,31562,0)
 ;;=N28.9^^190^1939^55
 ;;^UTILITY(U,$J,358.3,31562,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31562,1,3,0)
 ;;=3^Kidney & Ureter Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,31562,1,4,0)
 ;;=4^N28.9

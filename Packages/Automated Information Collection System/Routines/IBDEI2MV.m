IBDEI2MV ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,44193,1,4,0)
 ;;=4^N02.9
 ;;^UTILITY(U,$J,358.3,44193,2)
 ;;=^5015520
 ;;^UTILITY(U,$J,358.3,44194,0)
 ;;=N06.9^^200^2224^86
 ;;^UTILITY(U,$J,358.3,44194,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44194,1,3,0)
 ;;=3^Proteinuria Isolated w/ Unspec Morphologic Lesion
 ;;^UTILITY(U,$J,358.3,44194,1,4,0)
 ;;=4^N06.9
 ;;^UTILITY(U,$J,358.3,44194,2)
 ;;=^5015558
 ;;^UTILITY(U,$J,358.3,44195,0)
 ;;=N05.9^^200^2224^66
 ;;^UTILITY(U,$J,358.3,44195,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44195,1,3,0)
 ;;=3^Nephritic Syndrome w/ Unspec Morphologic Changes
 ;;^UTILITY(U,$J,358.3,44195,1,4,0)
 ;;=4^N05.9
 ;;^UTILITY(U,$J,358.3,44195,2)
 ;;=^5134086
 ;;^UTILITY(U,$J,358.3,44196,0)
 ;;=N07.9^^200^2224^68
 ;;^UTILITY(U,$J,358.3,44196,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44196,1,3,0)
 ;;=3^Nephropathy Hereditary w/ Unspec Morphologic Lesions
 ;;^UTILITY(U,$J,358.3,44196,1,4,0)
 ;;=4^N07.9
 ;;^UTILITY(U,$J,358.3,44196,2)
 ;;=^5015568
 ;;^UTILITY(U,$J,358.3,44197,0)
 ;;=N15.9^^200^2224^92
 ;;^UTILITY(U,$J,358.3,44197,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44197,1,3,0)
 ;;=3^Renal Tubulo-Interstitial Disease,Unspec
 ;;^UTILITY(U,$J,358.3,44197,1,4,0)
 ;;=4^N15.9
 ;;^UTILITY(U,$J,358.3,44197,2)
 ;;=^5015596
 ;;^UTILITY(U,$J,358.3,44198,0)
 ;;=N17.9^^200^2224^61
 ;;^UTILITY(U,$J,358.3,44198,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44198,1,3,0)
 ;;=3^Kidney Failure,Acute,Unspec
 ;;^UTILITY(U,$J,358.3,44198,1,4,0)
 ;;=4^N17.9
 ;;^UTILITY(U,$J,358.3,44198,2)
 ;;=^338532
 ;;^UTILITY(U,$J,358.3,44199,0)
 ;;=N19.^^200^2224^62
 ;;^UTILITY(U,$J,358.3,44199,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44199,1,3,0)
 ;;=3^Kidney Failure,Unspec
 ;;^UTILITY(U,$J,358.3,44199,1,4,0)
 ;;=4^N19.
 ;;^UTILITY(U,$J,358.3,44199,2)
 ;;=^5015607
 ;;^UTILITY(U,$J,358.3,44200,0)
 ;;=N11.0^^200^2224^90
 ;;^UTILITY(U,$J,358.3,44200,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44200,1,3,0)
 ;;=3^Pyelonephritis,Chronic Nonobstructive Reflux-Associated
 ;;^UTILITY(U,$J,358.3,44200,1,4,0)
 ;;=4^N11.0
 ;;^UTILITY(U,$J,358.3,44200,2)
 ;;=^5015571
 ;;^UTILITY(U,$J,358.3,44201,0)
 ;;=N10.^^200^2224^67
 ;;^UTILITY(U,$J,358.3,44201,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44201,1,3,0)
 ;;=3^Nephritis Acute Tubulo-Interstitial
 ;;^UTILITY(U,$J,358.3,44201,1,4,0)
 ;;=4^N10.
 ;;^UTILITY(U,$J,358.3,44201,2)
 ;;=^5015570
 ;;^UTILITY(U,$J,358.3,44202,0)
 ;;=N20.2^^200^2224^8
 ;;^UTILITY(U,$J,358.3,44202,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44202,1,3,0)
 ;;=3^Calculus Kidney w/ Calculus Ureter
 ;;^UTILITY(U,$J,358.3,44202,1,4,0)
 ;;=4^N20.2
 ;;^UTILITY(U,$J,358.3,44202,2)
 ;;=^5015609
 ;;^UTILITY(U,$J,358.3,44203,0)
 ;;=N20.0^^200^2224^7
 ;;^UTILITY(U,$J,358.3,44203,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44203,1,3,0)
 ;;=3^Calculus Kidney
 ;;^UTILITY(U,$J,358.3,44203,1,4,0)
 ;;=4^N20.0
 ;;^UTILITY(U,$J,358.3,44203,2)
 ;;=^67056
 ;;^UTILITY(U,$J,358.3,44204,0)
 ;;=N29.^^200^2224^60
 ;;^UTILITY(U,$J,358.3,44204,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44204,1,3,0)
 ;;=3^Kidney & Ureter Disorders in Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,44204,1,4,0)
 ;;=4^N29.
 ;;^UTILITY(U,$J,358.3,44204,2)
 ;;=^5015631
 ;;^UTILITY(U,$J,358.3,44205,0)
 ;;=N28.9^^200^2224^59
 ;;^UTILITY(U,$J,358.3,44205,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44205,1,3,0)
 ;;=3^Kidney & Ureter Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,44205,1,4,0)
 ;;=4^N28.9
 ;;^UTILITY(U,$J,358.3,44205,2)
 ;;=^5015630
 ;;^UTILITY(U,$J,358.3,44206,0)
 ;;=N30.01^^200^2224^20
 ;;^UTILITY(U,$J,358.3,44206,1,0)
 ;;=^358.31IA^4^2

IBDEI1B1 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,22180,2)
 ;;=^5003620
 ;;^UTILITY(U,$J,358.3,22181,0)
 ;;=I12.9^^87^977^55
 ;;^UTILITY(U,$J,358.3,22181,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22181,1,3,0)
 ;;=3^Hypertensive Kidney Disease Chronic w/ Stg 1-4
 ;;^UTILITY(U,$J,358.3,22181,1,4,0)
 ;;=4^I12.9
 ;;^UTILITY(U,$J,358.3,22181,2)
 ;;=^5007066
 ;;^UTILITY(U,$J,358.3,22182,0)
 ;;=N04.9^^87^977^69
 ;;^UTILITY(U,$J,358.3,22182,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22182,1,3,0)
 ;;=3^Nephrotic Syndrome w/ Unspec Morphologic Changes
 ;;^UTILITY(U,$J,358.3,22182,1,4,0)
 ;;=4^N04.9
 ;;^UTILITY(U,$J,358.3,22182,2)
 ;;=^5015540
 ;;^UTILITY(U,$J,358.3,22183,0)
 ;;=N02.9^^87^977^50
 ;;^UTILITY(U,$J,358.3,22183,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22183,1,3,0)
 ;;=3^Hematuria w/ Unspec Morphologic Changes,Recurrent & Persistent
 ;;^UTILITY(U,$J,358.3,22183,1,4,0)
 ;;=4^N02.9
 ;;^UTILITY(U,$J,358.3,22183,2)
 ;;=^5015520
 ;;^UTILITY(U,$J,358.3,22184,0)
 ;;=N06.9^^87^977^86
 ;;^UTILITY(U,$J,358.3,22184,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22184,1,3,0)
 ;;=3^Proteinuria Isolated w/ Unspec Morphologic Lesion
 ;;^UTILITY(U,$J,358.3,22184,1,4,0)
 ;;=4^N06.9
 ;;^UTILITY(U,$J,358.3,22184,2)
 ;;=^5015558
 ;;^UTILITY(U,$J,358.3,22185,0)
 ;;=N05.9^^87^977^66
 ;;^UTILITY(U,$J,358.3,22185,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22185,1,3,0)
 ;;=3^Nephritic Syndrome w/ Unspec Morphologic Changes
 ;;^UTILITY(U,$J,358.3,22185,1,4,0)
 ;;=4^N05.9
 ;;^UTILITY(U,$J,358.3,22185,2)
 ;;=^5134086
 ;;^UTILITY(U,$J,358.3,22186,0)
 ;;=N07.9^^87^977^68
 ;;^UTILITY(U,$J,358.3,22186,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22186,1,3,0)
 ;;=3^Nephropathy Hereditary w/ Unspec Morphologic Lesions
 ;;^UTILITY(U,$J,358.3,22186,1,4,0)
 ;;=4^N07.9
 ;;^UTILITY(U,$J,358.3,22186,2)
 ;;=^5015568
 ;;^UTILITY(U,$J,358.3,22187,0)
 ;;=N15.9^^87^977^92
 ;;^UTILITY(U,$J,358.3,22187,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22187,1,3,0)
 ;;=3^Renal Tubulo-Interstitial Disease,Unspec
 ;;^UTILITY(U,$J,358.3,22187,1,4,0)
 ;;=4^N15.9
 ;;^UTILITY(U,$J,358.3,22187,2)
 ;;=^5015596
 ;;^UTILITY(U,$J,358.3,22188,0)
 ;;=N17.9^^87^977^61
 ;;^UTILITY(U,$J,358.3,22188,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22188,1,3,0)
 ;;=3^Kidney Failure,Acute,Unspec
 ;;^UTILITY(U,$J,358.3,22188,1,4,0)
 ;;=4^N17.9
 ;;^UTILITY(U,$J,358.3,22188,2)
 ;;=^338532
 ;;^UTILITY(U,$J,358.3,22189,0)
 ;;=N19.^^87^977^62
 ;;^UTILITY(U,$J,358.3,22189,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22189,1,3,0)
 ;;=3^Kidney Failure,Unspec
 ;;^UTILITY(U,$J,358.3,22189,1,4,0)
 ;;=4^N19.
 ;;^UTILITY(U,$J,358.3,22189,2)
 ;;=^5015607
 ;;^UTILITY(U,$J,358.3,22190,0)
 ;;=N11.0^^87^977^90
 ;;^UTILITY(U,$J,358.3,22190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22190,1,3,0)
 ;;=3^Pyelonephritis,Chronic Nonobstructive Reflux-Associated
 ;;^UTILITY(U,$J,358.3,22190,1,4,0)
 ;;=4^N11.0
 ;;^UTILITY(U,$J,358.3,22190,2)
 ;;=^5015571
 ;;^UTILITY(U,$J,358.3,22191,0)
 ;;=N10.^^87^977^67
 ;;^UTILITY(U,$J,358.3,22191,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22191,1,3,0)
 ;;=3^Nephritis Acute Tubulo-Interstitial
 ;;^UTILITY(U,$J,358.3,22191,1,4,0)
 ;;=4^N10.
 ;;^UTILITY(U,$J,358.3,22191,2)
 ;;=^5015570
 ;;^UTILITY(U,$J,358.3,22192,0)
 ;;=N20.2^^87^977^8
 ;;^UTILITY(U,$J,358.3,22192,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22192,1,3,0)
 ;;=3^Calculus Kidney w/ Calculus Ureter
 ;;^UTILITY(U,$J,358.3,22192,1,4,0)
 ;;=4^N20.2
 ;;^UTILITY(U,$J,358.3,22192,2)
 ;;=^5015609
 ;;^UTILITY(U,$J,358.3,22193,0)
 ;;=N20.0^^87^977^7
 ;;^UTILITY(U,$J,358.3,22193,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22193,1,3,0)
 ;;=3^Calculus Kidney

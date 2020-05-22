IBDEI1JG ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24592,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24592,1,3,0)
 ;;=3^Hypertensive Kidney Disease Chronic w/ Stg 1-4
 ;;^UTILITY(U,$J,358.3,24592,1,4,0)
 ;;=4^I12.9
 ;;^UTILITY(U,$J,358.3,24592,2)
 ;;=^5007066
 ;;^UTILITY(U,$J,358.3,24593,0)
 ;;=N04.9^^107^1208^76
 ;;^UTILITY(U,$J,358.3,24593,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24593,1,3,0)
 ;;=3^Nephrotic Syndrome w/ Unspec Morphologic Changes
 ;;^UTILITY(U,$J,358.3,24593,1,4,0)
 ;;=4^N04.9
 ;;^UTILITY(U,$J,358.3,24593,2)
 ;;=^5015540
 ;;^UTILITY(U,$J,358.3,24594,0)
 ;;=N02.9^^107^1208^53
 ;;^UTILITY(U,$J,358.3,24594,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24594,1,3,0)
 ;;=3^Hematuria w/ Unspec Morphologic Changes,Recurrent & Persistent
 ;;^UTILITY(U,$J,358.3,24594,1,4,0)
 ;;=4^N02.9
 ;;^UTILITY(U,$J,358.3,24594,2)
 ;;=^5015520
 ;;^UTILITY(U,$J,358.3,24595,0)
 ;;=N06.9^^107^1208^93
 ;;^UTILITY(U,$J,358.3,24595,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24595,1,3,0)
 ;;=3^Proteinuria Isolated w/ Unspec Morphologic Lesion
 ;;^UTILITY(U,$J,358.3,24595,1,4,0)
 ;;=4^N06.9
 ;;^UTILITY(U,$J,358.3,24595,2)
 ;;=^5015558
 ;;^UTILITY(U,$J,358.3,24596,0)
 ;;=N05.9^^107^1208^73
 ;;^UTILITY(U,$J,358.3,24596,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24596,1,3,0)
 ;;=3^Nephritic Syndrome w/ Unspec Morphologic Changes
 ;;^UTILITY(U,$J,358.3,24596,1,4,0)
 ;;=4^N05.9
 ;;^UTILITY(U,$J,358.3,24596,2)
 ;;=^5134086
 ;;^UTILITY(U,$J,358.3,24597,0)
 ;;=N07.9^^107^1208^75
 ;;^UTILITY(U,$J,358.3,24597,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24597,1,3,0)
 ;;=3^Nephropathy Hereditary w/ Unspec Morphologic Lesions
 ;;^UTILITY(U,$J,358.3,24597,1,4,0)
 ;;=4^N07.9
 ;;^UTILITY(U,$J,358.3,24597,2)
 ;;=^5015568
 ;;^UTILITY(U,$J,358.3,24598,0)
 ;;=N15.9^^107^1208^100
 ;;^UTILITY(U,$J,358.3,24598,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24598,1,3,0)
 ;;=3^Renal Tubulo-Interstitial Disease,Unspec
 ;;^UTILITY(U,$J,358.3,24598,1,4,0)
 ;;=4^N15.9
 ;;^UTILITY(U,$J,358.3,24598,2)
 ;;=^5015596
 ;;^UTILITY(U,$J,358.3,24599,0)
 ;;=N17.9^^107^1208^65
 ;;^UTILITY(U,$J,358.3,24599,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24599,1,3,0)
 ;;=3^Kidney Failure,Acute,Unspec
 ;;^UTILITY(U,$J,358.3,24599,1,4,0)
 ;;=4^N17.9
 ;;^UTILITY(U,$J,358.3,24599,2)
 ;;=^338532
 ;;^UTILITY(U,$J,358.3,24600,0)
 ;;=N19.^^107^1208^66
 ;;^UTILITY(U,$J,358.3,24600,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24600,1,3,0)
 ;;=3^Kidney Failure,Unspec
 ;;^UTILITY(U,$J,358.3,24600,1,4,0)
 ;;=4^N19.
 ;;^UTILITY(U,$J,358.3,24600,2)
 ;;=^5015607
 ;;^UTILITY(U,$J,358.3,24601,0)
 ;;=N11.0^^107^1208^97
 ;;^UTILITY(U,$J,358.3,24601,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24601,1,3,0)
 ;;=3^Pyelonephritis,Chronic Nonobstructive Reflux-Associated
 ;;^UTILITY(U,$J,358.3,24601,1,4,0)
 ;;=4^N11.0
 ;;^UTILITY(U,$J,358.3,24601,2)
 ;;=^5015571
 ;;^UTILITY(U,$J,358.3,24602,0)
 ;;=N10.^^107^1208^74
 ;;^UTILITY(U,$J,358.3,24602,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24602,1,3,0)
 ;;=3^Nephritis Acute Tubulo-Interstitial
 ;;^UTILITY(U,$J,358.3,24602,1,4,0)
 ;;=4^N10.
 ;;^UTILITY(U,$J,358.3,24602,2)
 ;;=^5015570
 ;;^UTILITY(U,$J,358.3,24603,0)
 ;;=N20.2^^107^1208^10
 ;;^UTILITY(U,$J,358.3,24603,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24603,1,3,0)
 ;;=3^Calculus Kidney w/ Calculus Ureter
 ;;^UTILITY(U,$J,358.3,24603,1,4,0)
 ;;=4^N20.2
 ;;^UTILITY(U,$J,358.3,24603,2)
 ;;=^5015609

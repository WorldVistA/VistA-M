IBDEI1N5 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,27456,1,4,0)
 ;;=4^F52.21
 ;;^UTILITY(U,$J,358.3,27456,2)
 ;;=^5003620
 ;;^UTILITY(U,$J,358.3,27457,0)
 ;;=I12.9^^132^1316^55
 ;;^UTILITY(U,$J,358.3,27457,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27457,1,3,0)
 ;;=3^Hypertensive Kidney Disease Chronic w/ Stg 1-4
 ;;^UTILITY(U,$J,358.3,27457,1,4,0)
 ;;=4^I12.9
 ;;^UTILITY(U,$J,358.3,27457,2)
 ;;=^5007066
 ;;^UTILITY(U,$J,358.3,27458,0)
 ;;=N04.9^^132^1316^69
 ;;^UTILITY(U,$J,358.3,27458,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27458,1,3,0)
 ;;=3^Nephrotic Syndrome w/ Unspec Morphologic Changes
 ;;^UTILITY(U,$J,358.3,27458,1,4,0)
 ;;=4^N04.9
 ;;^UTILITY(U,$J,358.3,27458,2)
 ;;=^5015540
 ;;^UTILITY(U,$J,358.3,27459,0)
 ;;=N02.9^^132^1316^50
 ;;^UTILITY(U,$J,358.3,27459,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27459,1,3,0)
 ;;=3^Hematuria w/ Unspec Morphologic Changes,Recurrent & Persistent
 ;;^UTILITY(U,$J,358.3,27459,1,4,0)
 ;;=4^N02.9
 ;;^UTILITY(U,$J,358.3,27459,2)
 ;;=^5015520
 ;;^UTILITY(U,$J,358.3,27460,0)
 ;;=N06.9^^132^1316^86
 ;;^UTILITY(U,$J,358.3,27460,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27460,1,3,0)
 ;;=3^Proteinuria Isolated w/ Unspec Morphologic Lesion
 ;;^UTILITY(U,$J,358.3,27460,1,4,0)
 ;;=4^N06.9
 ;;^UTILITY(U,$J,358.3,27460,2)
 ;;=^5015558
 ;;^UTILITY(U,$J,358.3,27461,0)
 ;;=N05.9^^132^1316^66
 ;;^UTILITY(U,$J,358.3,27461,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27461,1,3,0)
 ;;=3^Nephritic Syndrome w/ Unspec Morphologic Changes
 ;;^UTILITY(U,$J,358.3,27461,1,4,0)
 ;;=4^N05.9
 ;;^UTILITY(U,$J,358.3,27461,2)
 ;;=^5134086
 ;;^UTILITY(U,$J,358.3,27462,0)
 ;;=N07.9^^132^1316^68
 ;;^UTILITY(U,$J,358.3,27462,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27462,1,3,0)
 ;;=3^Nephropathy Hereditary w/ Unspec Morphologic Lesions
 ;;^UTILITY(U,$J,358.3,27462,1,4,0)
 ;;=4^N07.9
 ;;^UTILITY(U,$J,358.3,27462,2)
 ;;=^5015568
 ;;^UTILITY(U,$J,358.3,27463,0)
 ;;=N15.9^^132^1316^92
 ;;^UTILITY(U,$J,358.3,27463,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27463,1,3,0)
 ;;=3^Renal Tubulo-Interstitial Disease,Unspec
 ;;^UTILITY(U,$J,358.3,27463,1,4,0)
 ;;=4^N15.9
 ;;^UTILITY(U,$J,358.3,27463,2)
 ;;=^5015596
 ;;^UTILITY(U,$J,358.3,27464,0)
 ;;=N17.9^^132^1316^61
 ;;^UTILITY(U,$J,358.3,27464,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27464,1,3,0)
 ;;=3^Kidney Failure,Acute,Unspec
 ;;^UTILITY(U,$J,358.3,27464,1,4,0)
 ;;=4^N17.9
 ;;^UTILITY(U,$J,358.3,27464,2)
 ;;=^338532
 ;;^UTILITY(U,$J,358.3,27465,0)
 ;;=N19.^^132^1316^62
 ;;^UTILITY(U,$J,358.3,27465,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27465,1,3,0)
 ;;=3^Kidney Failure,Unspec
 ;;^UTILITY(U,$J,358.3,27465,1,4,0)
 ;;=4^N19.
 ;;^UTILITY(U,$J,358.3,27465,2)
 ;;=^5015607
 ;;^UTILITY(U,$J,358.3,27466,0)
 ;;=N11.0^^132^1316^90
 ;;^UTILITY(U,$J,358.3,27466,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27466,1,3,0)
 ;;=3^Pyelonephritis,Chronic Nonobstructive Reflux-Associated
 ;;^UTILITY(U,$J,358.3,27466,1,4,0)
 ;;=4^N11.0
 ;;^UTILITY(U,$J,358.3,27466,2)
 ;;=^5015571
 ;;^UTILITY(U,$J,358.3,27467,0)
 ;;=N10.^^132^1316^67
 ;;^UTILITY(U,$J,358.3,27467,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27467,1,3,0)
 ;;=3^Nephritis Acute Tubulo-Interstitial
 ;;^UTILITY(U,$J,358.3,27467,1,4,0)
 ;;=4^N10.
 ;;^UTILITY(U,$J,358.3,27467,2)
 ;;=^5015570
 ;;^UTILITY(U,$J,358.3,27468,0)
 ;;=N20.2^^132^1316^8
 ;;^UTILITY(U,$J,358.3,27468,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27468,1,3,0)
 ;;=3^Calculus Kidney w/ Calculus Ureter
 ;;^UTILITY(U,$J,358.3,27468,1,4,0)
 ;;=4^N20.2
 ;;^UTILITY(U,$J,358.3,27468,2)
 ;;=^5015609
 ;;^UTILITY(U,$J,358.3,27469,0)
 ;;=N20.0^^132^1316^7

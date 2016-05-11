IBDEI0DT ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6344,0)
 ;;=N11.0^^30^392^96
 ;;^UTILITY(U,$J,358.3,6344,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6344,1,3,0)
 ;;=3^Pyelonephritis,Chronic Nonobstructive Reflux-Associated
 ;;^UTILITY(U,$J,358.3,6344,1,4,0)
 ;;=4^N11.0
 ;;^UTILITY(U,$J,358.3,6344,2)
 ;;=^5015571
 ;;^UTILITY(U,$J,358.3,6345,0)
 ;;=N10.^^30^392^73
 ;;^UTILITY(U,$J,358.3,6345,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6345,1,3,0)
 ;;=3^Nephritis Acute Tubulo-Interstitial
 ;;^UTILITY(U,$J,358.3,6345,1,4,0)
 ;;=4^N10.
 ;;^UTILITY(U,$J,358.3,6345,2)
 ;;=^5015570
 ;;^UTILITY(U,$J,358.3,6346,0)
 ;;=N20.2^^30^392^8
 ;;^UTILITY(U,$J,358.3,6346,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6346,1,3,0)
 ;;=3^Calculus Kidney w/ Calculus Ureter
 ;;^UTILITY(U,$J,358.3,6346,1,4,0)
 ;;=4^N20.2
 ;;^UTILITY(U,$J,358.3,6346,2)
 ;;=^5015609
 ;;^UTILITY(U,$J,358.3,6347,0)
 ;;=N20.0^^30^392^7
 ;;^UTILITY(U,$J,358.3,6347,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6347,1,3,0)
 ;;=3^Calculus Kidney
 ;;^UTILITY(U,$J,358.3,6347,1,4,0)
 ;;=4^N20.0
 ;;^UTILITY(U,$J,358.3,6347,2)
 ;;=^67056
 ;;^UTILITY(U,$J,358.3,6348,0)
 ;;=N29.^^30^392^66
 ;;^UTILITY(U,$J,358.3,6348,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6348,1,3,0)
 ;;=3^Kidney & Ureter Disorders in Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,6348,1,4,0)
 ;;=4^N29.
 ;;^UTILITY(U,$J,358.3,6348,2)
 ;;=^5015631
 ;;^UTILITY(U,$J,358.3,6349,0)
 ;;=N28.9^^30^392^65
 ;;^UTILITY(U,$J,358.3,6349,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6349,1,3,0)
 ;;=3^Kidney & Ureter Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,6349,1,4,0)
 ;;=4^N28.9
 ;;^UTILITY(U,$J,358.3,6349,2)
 ;;=^5015630
 ;;^UTILITY(U,$J,358.3,6350,0)
 ;;=N30.01^^30^392^20
 ;;^UTILITY(U,$J,358.3,6350,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6350,1,3,0)
 ;;=3^Cystitis w/ Hematuria,Acute
 ;;^UTILITY(U,$J,358.3,6350,1,4,0)
 ;;=4^N30.01
 ;;^UTILITY(U,$J,358.3,6350,2)
 ;;=^5015633
 ;;^UTILITY(U,$J,358.3,6351,0)
 ;;=N30.00^^30^392^24
 ;;^UTILITY(U,$J,358.3,6351,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6351,1,3,0)
 ;;=3^Cystitis w/o Hematuria,Acute
 ;;^UTILITY(U,$J,358.3,6351,1,4,0)
 ;;=4^N30.00
 ;;^UTILITY(U,$J,358.3,6351,2)
 ;;=^5015632
 ;;^UTILITY(U,$J,358.3,6352,0)
 ;;=N30.41^^30^392^21
 ;;^UTILITY(U,$J,358.3,6352,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6352,1,3,0)
 ;;=3^Cystitis w/ Hematuria,Irradiation
 ;;^UTILITY(U,$J,358.3,6352,1,4,0)
 ;;=4^N30.41
 ;;^UTILITY(U,$J,358.3,6352,2)
 ;;=^5015640
 ;;^UTILITY(U,$J,358.3,6353,0)
 ;;=N30.40^^30^392^25
 ;;^UTILITY(U,$J,358.3,6353,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6353,1,3,0)
 ;;=3^Cystitis w/o Hematuria,Irradiation
 ;;^UTILITY(U,$J,358.3,6353,1,4,0)
 ;;=4^N30.40
 ;;^UTILITY(U,$J,358.3,6353,2)
 ;;=^5015639
 ;;^UTILITY(U,$J,358.3,6354,0)
 ;;=N32.0^^30^392^6
 ;;^UTILITY(U,$J,358.3,6354,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6354,1,3,0)
 ;;=3^Bladder-Neck Obstruction
 ;;^UTILITY(U,$J,358.3,6354,1,4,0)
 ;;=4^N32.0
 ;;^UTILITY(U,$J,358.3,6354,2)
 ;;=^5015649
 ;;^UTILITY(U,$J,358.3,6355,0)
 ;;=N31.9^^30^392^76
 ;;^UTILITY(U,$J,358.3,6355,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6355,1,3,0)
 ;;=3^Neurogenic Bladder Dysfunction,Unspec
 ;;^UTILITY(U,$J,358.3,6355,1,4,0)
 ;;=4^N31.9
 ;;^UTILITY(U,$J,358.3,6355,2)
 ;;=^5015648
 ;;^UTILITY(U,$J,358.3,6356,0)
 ;;=N31.1^^30^392^77
 ;;^UTILITY(U,$J,358.3,6356,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6356,1,3,0)
 ;;=3^Neuropathic Bladder,Reflex NEC
 ;;^UTILITY(U,$J,358.3,6356,1,4,0)
 ;;=4^N31.1
 ;;^UTILITY(U,$J,358.3,6356,2)
 ;;=^5015645
 ;;^UTILITY(U,$J,358.3,6357,0)
 ;;=N32.89^^30^392^5
 ;;^UTILITY(U,$J,358.3,6357,1,0)
 ;;=^358.31IA^4^2

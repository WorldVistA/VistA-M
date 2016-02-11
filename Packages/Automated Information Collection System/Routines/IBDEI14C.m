IBDEI14C ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,18680,1,3,0)
 ;;=3^Pyelonephritis,Chronic Nonobstructive Reflux-Associated
 ;;^UTILITY(U,$J,358.3,18680,1,4,0)
 ;;=4^N11.0
 ;;^UTILITY(U,$J,358.3,18680,2)
 ;;=^5015571
 ;;^UTILITY(U,$J,358.3,18681,0)
 ;;=N10.^^94^912^67
 ;;^UTILITY(U,$J,358.3,18681,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18681,1,3,0)
 ;;=3^Nephritis Acute Tubulo-Interstitial
 ;;^UTILITY(U,$J,358.3,18681,1,4,0)
 ;;=4^N10.
 ;;^UTILITY(U,$J,358.3,18681,2)
 ;;=^5015570
 ;;^UTILITY(U,$J,358.3,18682,0)
 ;;=N20.2^^94^912^8
 ;;^UTILITY(U,$J,358.3,18682,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18682,1,3,0)
 ;;=3^Calculus Kidney w/ Calculus Ureter
 ;;^UTILITY(U,$J,358.3,18682,1,4,0)
 ;;=4^N20.2
 ;;^UTILITY(U,$J,358.3,18682,2)
 ;;=^5015609
 ;;^UTILITY(U,$J,358.3,18683,0)
 ;;=N20.0^^94^912^7
 ;;^UTILITY(U,$J,358.3,18683,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18683,1,3,0)
 ;;=3^Calculus Kidney
 ;;^UTILITY(U,$J,358.3,18683,1,4,0)
 ;;=4^N20.0
 ;;^UTILITY(U,$J,358.3,18683,2)
 ;;=^67056
 ;;^UTILITY(U,$J,358.3,18684,0)
 ;;=N29.^^94^912^60
 ;;^UTILITY(U,$J,358.3,18684,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18684,1,3,0)
 ;;=3^Kidney & Ureter Disorders in Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,18684,1,4,0)
 ;;=4^N29.
 ;;^UTILITY(U,$J,358.3,18684,2)
 ;;=^5015631
 ;;^UTILITY(U,$J,358.3,18685,0)
 ;;=N28.9^^94^912^59
 ;;^UTILITY(U,$J,358.3,18685,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18685,1,3,0)
 ;;=3^Kidney & Ureter Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,18685,1,4,0)
 ;;=4^N28.9
 ;;^UTILITY(U,$J,358.3,18685,2)
 ;;=^5015630
 ;;^UTILITY(U,$J,358.3,18686,0)
 ;;=N30.01^^94^912^20
 ;;^UTILITY(U,$J,358.3,18686,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18686,1,3,0)
 ;;=3^Cystitis w/ Hematuria,Acute
 ;;^UTILITY(U,$J,358.3,18686,1,4,0)
 ;;=4^N30.01
 ;;^UTILITY(U,$J,358.3,18686,2)
 ;;=^5015633
 ;;^UTILITY(U,$J,358.3,18687,0)
 ;;=N30.00^^94^912^22
 ;;^UTILITY(U,$J,358.3,18687,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18687,1,3,0)
 ;;=3^Cystitis w/o Hematuria,Acute
 ;;^UTILITY(U,$J,358.3,18687,1,4,0)
 ;;=4^N30.00
 ;;^UTILITY(U,$J,358.3,18687,2)
 ;;=^5015632
 ;;^UTILITY(U,$J,358.3,18688,0)
 ;;=N30.41^^94^912^21
 ;;^UTILITY(U,$J,358.3,18688,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18688,1,3,0)
 ;;=3^Cystitis w/ Hematuria,Irradiation
 ;;^UTILITY(U,$J,358.3,18688,1,4,0)
 ;;=4^N30.41
 ;;^UTILITY(U,$J,358.3,18688,2)
 ;;=^5015640
 ;;^UTILITY(U,$J,358.3,18689,0)
 ;;=N30.40^^94^912^23
 ;;^UTILITY(U,$J,358.3,18689,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18689,1,3,0)
 ;;=3^Cystitis w/o Hematuria,Irradiation
 ;;^UTILITY(U,$J,358.3,18689,1,4,0)
 ;;=4^N30.40
 ;;^UTILITY(U,$J,358.3,18689,2)
 ;;=^5015639
 ;;^UTILITY(U,$J,358.3,18690,0)
 ;;=N32.0^^94^912^6
 ;;^UTILITY(U,$J,358.3,18690,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18690,1,3,0)
 ;;=3^Bladder-Neck Obstruction
 ;;^UTILITY(U,$J,358.3,18690,1,4,0)
 ;;=4^N32.0
 ;;^UTILITY(U,$J,358.3,18690,2)
 ;;=^5015649
 ;;^UTILITY(U,$J,358.3,18691,0)
 ;;=N31.9^^94^912^70
 ;;^UTILITY(U,$J,358.3,18691,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18691,1,3,0)
 ;;=3^Neurogenic Bladder Dysfunction,Unspec
 ;;^UTILITY(U,$J,358.3,18691,1,4,0)
 ;;=4^N31.9
 ;;^UTILITY(U,$J,358.3,18691,2)
 ;;=^5015648
 ;;^UTILITY(U,$J,358.3,18692,0)
 ;;=N31.1^^94^912^71
 ;;^UTILITY(U,$J,358.3,18692,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18692,1,3,0)
 ;;=3^Neuropathic Bladder,Reflex NEC
 ;;^UTILITY(U,$J,358.3,18692,1,4,0)
 ;;=4^N31.1
 ;;^UTILITY(U,$J,358.3,18692,2)
 ;;=^5015645
 ;;^UTILITY(U,$J,358.3,18693,0)
 ;;=N32.89^^94^912^5
 ;;^UTILITY(U,$J,358.3,18693,1,0)
 ;;=^358.31IA^4^2

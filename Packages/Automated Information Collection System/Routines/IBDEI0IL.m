IBDEI0IL ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8363,2)
 ;;=^5015568
 ;;^UTILITY(U,$J,358.3,8364,0)
 ;;=N15.9^^39^398^102
 ;;^UTILITY(U,$J,358.3,8364,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8364,1,3,0)
 ;;=3^Renal Tubulo-Interstitial Disease,Unspec
 ;;^UTILITY(U,$J,358.3,8364,1,4,0)
 ;;=4^N15.9
 ;;^UTILITY(U,$J,358.3,8364,2)
 ;;=^5015596
 ;;^UTILITY(U,$J,358.3,8365,0)
 ;;=N17.9^^39^398^67
 ;;^UTILITY(U,$J,358.3,8365,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8365,1,3,0)
 ;;=3^Kidney Failure,Acute,Unspec
 ;;^UTILITY(U,$J,358.3,8365,1,4,0)
 ;;=4^N17.9
 ;;^UTILITY(U,$J,358.3,8365,2)
 ;;=^338532
 ;;^UTILITY(U,$J,358.3,8366,0)
 ;;=N19.^^39^398^68
 ;;^UTILITY(U,$J,358.3,8366,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8366,1,3,0)
 ;;=3^Kidney Failure,Unspec
 ;;^UTILITY(U,$J,358.3,8366,1,4,0)
 ;;=4^N19.
 ;;^UTILITY(U,$J,358.3,8366,2)
 ;;=^5015607
 ;;^UTILITY(U,$J,358.3,8367,0)
 ;;=N11.0^^39^398^99
 ;;^UTILITY(U,$J,358.3,8367,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8367,1,3,0)
 ;;=3^Pyelonephritis,Chronic Nonobstructive Reflux-Associated
 ;;^UTILITY(U,$J,358.3,8367,1,4,0)
 ;;=4^N11.0
 ;;^UTILITY(U,$J,358.3,8367,2)
 ;;=^5015571
 ;;^UTILITY(U,$J,358.3,8368,0)
 ;;=N10.^^39^398^76
 ;;^UTILITY(U,$J,358.3,8368,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8368,1,3,0)
 ;;=3^Nephritis Acute Tubulo-Interstitial
 ;;^UTILITY(U,$J,358.3,8368,1,4,0)
 ;;=4^N10.
 ;;^UTILITY(U,$J,358.3,8368,2)
 ;;=^5015570
 ;;^UTILITY(U,$J,358.3,8369,0)
 ;;=N20.2^^39^398^10
 ;;^UTILITY(U,$J,358.3,8369,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8369,1,3,0)
 ;;=3^Calculus Kidney w/ Calculus Ureter
 ;;^UTILITY(U,$J,358.3,8369,1,4,0)
 ;;=4^N20.2
 ;;^UTILITY(U,$J,358.3,8369,2)
 ;;=^5015609
 ;;^UTILITY(U,$J,358.3,8370,0)
 ;;=N20.0^^39^398^9
 ;;^UTILITY(U,$J,358.3,8370,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8370,1,3,0)
 ;;=3^Calculus Kidney
 ;;^UTILITY(U,$J,358.3,8370,1,4,0)
 ;;=4^N20.0
 ;;^UTILITY(U,$J,358.3,8370,2)
 ;;=^67056
 ;;^UTILITY(U,$J,358.3,8371,0)
 ;;=N29.^^39^398^66
 ;;^UTILITY(U,$J,358.3,8371,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8371,1,3,0)
 ;;=3^Kidney & Ureter Disorders in Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,8371,1,4,0)
 ;;=4^N29.
 ;;^UTILITY(U,$J,358.3,8371,2)
 ;;=^5015631
 ;;^UTILITY(U,$J,358.3,8372,0)
 ;;=N28.9^^39^398^65
 ;;^UTILITY(U,$J,358.3,8372,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8372,1,3,0)
 ;;=3^Kidney & Ureter Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,8372,1,4,0)
 ;;=4^N28.9
 ;;^UTILITY(U,$J,358.3,8372,2)
 ;;=^5015630
 ;;^UTILITY(U,$J,358.3,8373,0)
 ;;=N30.01^^39^398^24
 ;;^UTILITY(U,$J,358.3,8373,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8373,1,3,0)
 ;;=3^Cystitis w/ Hematuria,Acute
 ;;^UTILITY(U,$J,358.3,8373,1,4,0)
 ;;=4^N30.01
 ;;^UTILITY(U,$J,358.3,8373,2)
 ;;=^5015633
 ;;^UTILITY(U,$J,358.3,8374,0)
 ;;=N30.00^^39^398^26
 ;;^UTILITY(U,$J,358.3,8374,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8374,1,3,0)
 ;;=3^Cystitis w/o Hematuria,Acute
 ;;^UTILITY(U,$J,358.3,8374,1,4,0)
 ;;=4^N30.00
 ;;^UTILITY(U,$J,358.3,8374,2)
 ;;=^5015632
 ;;^UTILITY(U,$J,358.3,8375,0)
 ;;=N30.41^^39^398^25
 ;;^UTILITY(U,$J,358.3,8375,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8375,1,3,0)
 ;;=3^Cystitis w/ Hematuria,Irradiation
 ;;^UTILITY(U,$J,358.3,8375,1,4,0)
 ;;=4^N30.41
 ;;^UTILITY(U,$J,358.3,8375,2)
 ;;=^5015640
 ;;^UTILITY(U,$J,358.3,8376,0)
 ;;=N30.40^^39^398^27
 ;;^UTILITY(U,$J,358.3,8376,1,0)
 ;;=^358.31IA^4^2

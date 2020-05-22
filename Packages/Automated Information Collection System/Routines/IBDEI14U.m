IBDEI14U ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,18185,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18185,1,3,0)
 ;;=3^Acute Tubulo-Interstitial Nephritis
 ;;^UTILITY(U,$J,358.3,18185,1,4,0)
 ;;=4^N10.
 ;;^UTILITY(U,$J,358.3,18185,2)
 ;;=^5015570
 ;;^UTILITY(U,$J,358.3,18186,0)
 ;;=N11.9^^88^913^4
 ;;^UTILITY(U,$J,358.3,18186,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18186,1,3,0)
 ;;=3^Chronic Tubulo-Interstitial Nephritis,Unspec
 ;;^UTILITY(U,$J,358.3,18186,1,4,0)
 ;;=4^N11.9
 ;;^UTILITY(U,$J,358.3,18186,2)
 ;;=^5015574
 ;;^UTILITY(U,$J,358.3,18187,0)
 ;;=N30.91^^88^913^5
 ;;^UTILITY(U,$J,358.3,18187,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18187,1,3,0)
 ;;=3^Cystitis,Unspec w/ Hematuria
 ;;^UTILITY(U,$J,358.3,18187,1,4,0)
 ;;=4^N30.91
 ;;^UTILITY(U,$J,358.3,18187,2)
 ;;=^5015643
 ;;^UTILITY(U,$J,358.3,18188,0)
 ;;=N30.90^^88^913^6
 ;;^UTILITY(U,$J,358.3,18188,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18188,1,3,0)
 ;;=3^Cystitis,Unspec w/o Hematuria
 ;;^UTILITY(U,$J,358.3,18188,1,4,0)
 ;;=4^N30.90
 ;;^UTILITY(U,$J,358.3,18188,2)
 ;;=^5015642
 ;;^UTILITY(U,$J,358.3,18189,0)
 ;;=N28.84^^88^913^7
 ;;^UTILITY(U,$J,358.3,18189,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18189,1,3,0)
 ;;=3^Pyelitis Cystica
 ;;^UTILITY(U,$J,358.3,18189,1,4,0)
 ;;=4^N28.84
 ;;^UTILITY(U,$J,358.3,18189,2)
 ;;=^5015628
 ;;^UTILITY(U,$J,358.3,18190,0)
 ;;=N28.85^^88^913^8
 ;;^UTILITY(U,$J,358.3,18190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18190,1,3,0)
 ;;=3^Pyeloureteritis Cystica
 ;;^UTILITY(U,$J,358.3,18190,1,4,0)
 ;;=4^N28.85
 ;;^UTILITY(U,$J,358.3,18190,2)
 ;;=^270372
 ;;^UTILITY(U,$J,358.3,18191,0)
 ;;=N15.1^^88^913^9
 ;;^UTILITY(U,$J,358.3,18191,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18191,1,3,0)
 ;;=3^Renal & Perinephric Abscess
 ;;^UTILITY(U,$J,358.3,18191,1,4,0)
 ;;=4^N15.1
 ;;^UTILITY(U,$J,358.3,18191,2)
 ;;=^270371
 ;;^UTILITY(U,$J,358.3,18192,0)
 ;;=N16.^^88^913^10
 ;;^UTILITY(U,$J,358.3,18192,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18192,1,3,0)
 ;;=3^Tubulo-Interstitial D/O in Diseases Classigied Elsewhere
 ;;^UTILITY(U,$J,358.3,18192,1,4,0)
 ;;=4^N16.
 ;;^UTILITY(U,$J,358.3,18192,2)
 ;;=^5015597
 ;;^UTILITY(U,$J,358.3,18193,0)
 ;;=N15.9^^88^913^11
 ;;^UTILITY(U,$J,358.3,18193,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18193,1,3,0)
 ;;=3^Tubulo-Interstitial Disease,Unspec
 ;;^UTILITY(U,$J,358.3,18193,1,4,0)
 ;;=4^N15.9
 ;;^UTILITY(U,$J,358.3,18193,2)
 ;;=^5015596
 ;;^UTILITY(U,$J,358.3,18194,0)
 ;;=N12.^^88^913^12
 ;;^UTILITY(U,$J,358.3,18194,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18194,1,3,0)
 ;;=3^Tubulo-Interstitial Nephritis,Not Spec as Acute or Chronic
 ;;^UTILITY(U,$J,358.3,18194,1,4,0)
 ;;=4^N12.
 ;;^UTILITY(U,$J,358.3,18194,2)
 ;;=^5015575
 ;;^UTILITY(U,$J,358.3,18195,0)
 ;;=N28.86^^88^913^14
 ;;^UTILITY(U,$J,358.3,18195,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18195,1,3,0)
 ;;=3^Ureteritis Cystica
 ;;^UTILITY(U,$J,358.3,18195,1,4,0)
 ;;=4^N28.86
 ;;^UTILITY(U,$J,358.3,18195,2)
 ;;=^5015629
 ;;^UTILITY(U,$J,358.3,18196,0)
 ;;=A08.0^^88^914^6
 ;;^UTILITY(U,$J,358.3,18196,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18196,1,3,0)
 ;;=3^Enteritis,Rotaviral
 ;;^UTILITY(U,$J,358.3,18196,1,4,0)
 ;;=4^A08.0
 ;;^UTILITY(U,$J,358.3,18196,2)
 ;;=^5000052
 ;;^UTILITY(U,$J,358.3,18197,0)
 ;;=A08.11^^88^914^1
 ;;^UTILITY(U,$J,358.3,18197,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18197,1,3,0)
 ;;=3^Acute Gastroenteropathy d/t Norwalk Agent

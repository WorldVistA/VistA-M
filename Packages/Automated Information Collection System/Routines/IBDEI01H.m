IBDEI01H ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,160,1,5,0)
 ;;=5^Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,160,2)
 ;;=Withdrawal Delirium^4589
 ;;^UTILITY(U,$J,358.3,161,0)
 ;;=292.81^^3^28^2
 ;;^UTILITY(U,$J,358.3,161,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,161,1,2,0)
 ;;=2^292.81
 ;;^UTILITY(U,$J,358.3,161,1,5,0)
 ;;=5^Drug Induced Delirium
 ;;^UTILITY(U,$J,358.3,161,2)
 ;;=Drug Induced Delirium^268022
 ;;^UTILITY(U,$J,358.3,162,0)
 ;;=296.50^^3^29^6
 ;;^UTILITY(U,$J,358.3,162,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,162,1,2,0)
 ;;=2^296.50
 ;;^UTILITY(U,$J,358.3,162,1,5,0)
 ;;=5^Bipolar Depressed, NOS
 ;;^UTILITY(U,$J,358.3,162,2)
 ;;=^268130
 ;;^UTILITY(U,$J,358.3,163,0)
 ;;=296.51^^3^29^4
 ;;^UTILITY(U,$J,358.3,163,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,163,1,2,0)
 ;;=2^296.51
 ;;^UTILITY(U,$J,358.3,163,1,5,0)
 ;;=5^Bipolar Depressed, Mild
 ;;^UTILITY(U,$J,358.3,163,2)
 ;;=^303620
 ;;^UTILITY(U,$J,358.3,164,0)
 ;;=296.52^^3^29^5
 ;;^UTILITY(U,$J,358.3,164,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,164,1,2,0)
 ;;=2^296.52
 ;;^UTILITY(U,$J,358.3,164,1,5,0)
 ;;=5^Bipolar Depressed, Moderate
 ;;^UTILITY(U,$J,358.3,164,2)
 ;;=^303621
 ;;^UTILITY(U,$J,358.3,165,0)
 ;;=296.53^^3^29^2
 ;;^UTILITY(U,$J,358.3,165,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,165,1,2,0)
 ;;=2^296.53
 ;;^UTILITY(U,$J,358.3,165,1,5,0)
 ;;=5^Bipolar Depress Severe w/o Psychosis
 ;;^UTILITY(U,$J,358.3,165,2)
 ;;=^303622
 ;;^UTILITY(U,$J,358.3,166,0)
 ;;=296.54^^3^29^1
 ;;^UTILITY(U,$J,358.3,166,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,166,1,2,0)
 ;;=2^296.54
 ;;^UTILITY(U,$J,358.3,166,1,5,0)
 ;;=5^Bipolar Depress Severe w/Psychosis
 ;;^UTILITY(U,$J,358.3,166,2)
 ;;=Bipolar Depress Severe w/Psychosis^303623
 ;;^UTILITY(U,$J,358.3,167,0)
 ;;=296.55^^3^29^7
 ;;^UTILITY(U,$J,358.3,167,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,167,1,2,0)
 ;;=2^296.55
 ;;^UTILITY(U,$J,358.3,167,1,5,0)
 ;;=5^Bipolar Depressed, Part Remiss
 ;;^UTILITY(U,$J,358.3,167,2)
 ;;=^303624
 ;;^UTILITY(U,$J,358.3,168,0)
 ;;=296.56^^3^29^3
 ;;^UTILITY(U,$J,358.3,168,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,168,1,2,0)
 ;;=2^296.56
 ;;^UTILITY(U,$J,358.3,168,1,5,0)
 ;;=5^Bipolar Depressed, Full Remission
 ;;^UTILITY(U,$J,358.3,168,2)
 ;;=^303625
 ;;^UTILITY(U,$J,358.3,169,0)
 ;;=296.40^^3^29^14
 ;;^UTILITY(U,$J,358.3,169,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,169,1,2,0)
 ;;=2^296.40
 ;;^UTILITY(U,$J,358.3,169,1,5,0)
 ;;=5^Bipolar Manic, NOS
 ;;^UTILITY(U,$J,358.3,169,2)
 ;;=^303607
 ;;^UTILITY(U,$J,358.3,170,0)
 ;;=296.41^^3^29^12
 ;;^UTILITY(U,$J,358.3,170,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,170,1,2,0)
 ;;=2^296.41
 ;;^UTILITY(U,$J,358.3,170,1,5,0)
 ;;=5^Bipolar Manic, Mild
 ;;^UTILITY(U,$J,358.3,170,2)
 ;;=^303608
 ;;^UTILITY(U,$J,358.3,171,0)
 ;;=296.42^^3^29^13
 ;;^UTILITY(U,$J,358.3,171,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,171,1,2,0)
 ;;=2^296.42
 ;;^UTILITY(U,$J,358.3,171,1,5,0)
 ;;=5^Bipolar Manic, Mod
 ;;^UTILITY(U,$J,358.3,171,2)
 ;;=^303609
 ;;^UTILITY(U,$J,358.3,172,0)
 ;;=296.43^^3^29^17
 ;;^UTILITY(U,$J,358.3,172,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,172,1,2,0)
 ;;=2^296.43
 ;;^UTILITY(U,$J,358.3,172,1,5,0)
 ;;=5^Bipolar Manic, Sev w/o Psychosis
 ;;^UTILITY(U,$J,358.3,172,2)
 ;;=^303610
 ;;^UTILITY(U,$J,358.3,173,0)
 ;;=296.44^^3^29^16
 ;;^UTILITY(U,$J,358.3,173,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,173,1,2,0)
 ;;=2^296.44
 ;;^UTILITY(U,$J,358.3,173,1,5,0)
 ;;=5^Bipolar Manic, Sev w/Psychosis
 ;;^UTILITY(U,$J,358.3,173,2)
 ;;=^303611
 ;;^UTILITY(U,$J,358.3,174,0)
 ;;=296.45^^3^29^15
 ;;^UTILITY(U,$J,358.3,174,1,0)
 ;;=^358.31IA^5^2

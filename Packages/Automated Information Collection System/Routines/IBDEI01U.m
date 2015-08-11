IBDEI01U ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,344,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,344,1,2,0)
 ;;=2^V60.89
 ;;^UTILITY(U,$J,358.3,344,1,5,0)
 ;;=5^Housing/Econom Circum NEC
 ;;^UTILITY(U,$J,358.3,344,2)
 ;;=^295545
 ;;^UTILITY(U,$J,358.3,345,0)
 ;;=V61.22^^3^36^44
 ;;^UTILITY(U,$J,358.3,345,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,345,1,2,0)
 ;;=2^V61.22
 ;;^UTILITY(U,$J,358.3,345,1,5,0)
 ;;=5^Perpetrator-Parental Child
 ;;^UTILITY(U,$J,358.3,345,2)
 ;;=^304358
 ;;^UTILITY(U,$J,358.3,346,0)
 ;;=V61.23^^3^36^40
 ;;^UTILITY(U,$J,358.3,346,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,346,1,2,0)
 ;;=2^V61.23
 ;;^UTILITY(U,$J,358.3,346,1,5,0)
 ;;=5^Parent-Biological Child Prob
 ;;^UTILITY(U,$J,358.3,346,2)
 ;;=^338508
 ;;^UTILITY(U,$J,358.3,347,0)
 ;;=V61.24^^3^36^39
 ;;^UTILITY(U,$J,358.3,347,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,347,1,2,0)
 ;;=2^V61.24
 ;;^UTILITY(U,$J,358.3,347,1,5,0)
 ;;=5^Parent-Adopted Child Prob
 ;;^UTILITY(U,$J,358.3,347,2)
 ;;=^338509
 ;;^UTILITY(U,$J,358.3,348,0)
 ;;=V61.25^^3^36^42
 ;;^UTILITY(U,$J,358.3,348,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,348,1,2,0)
 ;;=2^V61.25
 ;;^UTILITY(U,$J,358.3,348,1,5,0)
 ;;=5^Parent-Foster Child Prob
 ;;^UTILITY(U,$J,358.3,348,2)
 ;;=^338510
 ;;^UTILITY(U,$J,358.3,349,0)
 ;;=V40.31^^3^36^52
 ;;^UTILITY(U,$J,358.3,349,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,349,1,2,0)
 ;;=2^V40.31
 ;;^UTILITY(U,$J,358.3,349,1,5,0)
 ;;=5^Wandering-Dis Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,349,2)
 ;;=^340621
 ;;^UTILITY(U,$J,358.3,350,0)
 ;;=V40.39^^3^36^37
 ;;^UTILITY(U,$J,358.3,350,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,350,1,2,0)
 ;;=2^V40.39
 ;;^UTILITY(U,$J,358.3,350,1,5,0)
 ;;=5^Oth Specified Behavioral Problem
 ;;^UTILITY(U,$J,358.3,350,2)
 ;;=^340622
 ;;^UTILITY(U,$J,358.3,351,0)
 ;;=V65.19^^3^36^45
 ;;^UTILITY(U,$J,358.3,351,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,351,1,2,0)
 ;;=2^V65.19
 ;;^UTILITY(U,$J,358.3,351,1,5,0)
 ;;=5^Person Consulting on Behalf of Pt
 ;;^UTILITY(U,$J,358.3,351,2)
 ;;=^329985
 ;;^UTILITY(U,$J,358.3,352,0)
 ;;=V66.7^^3^36^5
 ;;^UTILITY(U,$J,358.3,352,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,352,1,2,0)
 ;;=2^V66.7
 ;;^UTILITY(U,$J,358.3,352,1,5,0)
 ;;=5^Encounter for Palliative Care
 ;;^UTILITY(U,$J,358.3,352,2)
 ;;=^89209
 ;;^UTILITY(U,$J,358.3,353,0)
 ;;=V11.4^^3^36^18
 ;;^UTILITY(U,$J,358.3,353,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,353,1,2,0)
 ;;=2^V11.4
 ;;^UTILITY(U,$J,358.3,353,1,5,0)
 ;;=5^Hx Combat/Operational Stress
 ;;^UTILITY(U,$J,358.3,353,2)
 ;;=^339674
 ;;^UTILITY(U,$J,358.3,354,0)
 ;;=V60.1^^3^36^20
 ;;^UTILITY(U,$J,358.3,354,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,354,1,2,0)
 ;;=2^V60.1
 ;;^UTILITY(U,$J,358.3,354,1,5,0)
 ;;=5^Inadequate Housing
 ;;^UTILITY(U,$J,358.3,354,2)
 ;;=^295540
 ;;^UTILITY(U,$J,358.3,355,0)
 ;;=V62.84^^3^36^49
 ;;^UTILITY(U,$J,358.3,355,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,355,1,2,0)
 ;;=2^V62.84
 ;;^UTILITY(U,$J,358.3,355,1,5,0)
 ;;=5^Suicidal Ideation
 ;;^UTILITY(U,$J,358.3,355,2)
 ;;=^332876
 ;;^UTILITY(U,$J,358.3,356,0)
 ;;=V62.85^^3^36^16
 ;;^UTILITY(U,$J,358.3,356,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,356,1,2,0)
 ;;=2^V62.85
 ;;^UTILITY(U,$J,358.3,356,1,5,0)
 ;;=5^Homicidal Ideation
 ;;^UTILITY(U,$J,358.3,356,2)
 ;;=^339690
 ;;^UTILITY(U,$J,358.3,357,0)
 ;;=V58.61^^3^36^23
 ;;^UTILITY(U,$J,358.3,357,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,357,1,2,0)
 ;;=2^V58.61
 ;;^UTILITY(U,$J,358.3,357,1,5,0)
 ;;=5^L/T (Current) Anticoagulant Use
 ;;^UTILITY(U,$J,358.3,357,2)
 ;;=^303459
 ;;^UTILITY(U,$J,358.3,358,0)
 ;;=V58.62^^3^36^22

IBDEI02N ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,775,1,4,0)
 ;;=4^Problem w/ Hearing
 ;;^UTILITY(U,$J,358.3,775,2)
 ;;=^295429
 ;;^UTILITY(U,$J,358.3,776,0)
 ;;=V40.0^^8^86^10
 ;;^UTILITY(U,$J,358.3,776,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,776,1,3,0)
 ;;=3^V40.0
 ;;^UTILITY(U,$J,358.3,776,1,4,0)
 ;;=4^Problem w/ Learning
 ;;^UTILITY(U,$J,358.3,776,2)
 ;;=^295424
 ;;^UTILITY(U,$J,358.3,777,0)
 ;;=V41.4^^8^86^12
 ;;^UTILITY(U,$J,358.3,777,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,777,1,3,0)
 ;;=3^V41.4
 ;;^UTILITY(U,$J,358.3,777,1,4,0)
 ;;=4^Voice Production Problem
 ;;^UTILITY(U,$J,358.3,777,2)
 ;;=^295431
 ;;^UTILITY(U,$J,358.3,778,0)
 ;;=V41.6^^8^86^11
 ;;^UTILITY(U,$J,358.3,778,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,778,1,3,0)
 ;;=3^V41.6
 ;;^UTILITY(U,$J,358.3,778,1,4,0)
 ;;=4^Problem w/ Swallowing
 ;;^UTILITY(U,$J,358.3,778,2)
 ;;=^295433
 ;;^UTILITY(U,$J,358.3,779,0)
 ;;=V64.1^^8^86^5
 ;;^UTILITY(U,$J,358.3,779,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,779,1,3,0)
 ;;=3^V64.1
 ;;^UTILITY(U,$J,358.3,779,1,4,0)
 ;;=4^No Procedure d/t Contraindication
 ;;^UTILITY(U,$J,358.3,779,2)
 ;;=^295558
 ;;^UTILITY(U,$J,358.3,780,0)
 ;;=V64.2^^8^86^6
 ;;^UTILITY(U,$J,358.3,780,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,780,1,3,0)
 ;;=3^V64.2
 ;;^UTILITY(U,$J,358.3,780,1,4,0)
 ;;=4^No Procedure d/t Pt Decision
 ;;^UTILITY(U,$J,358.3,780,2)
 ;;=^295559
 ;;^UTILITY(U,$J,358.3,781,0)
 ;;=V65.2^^8^86^4
 ;;^UTILITY(U,$J,358.3,781,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,781,1,3,0)
 ;;=3^V65.2
 ;;^UTILITY(U,$J,358.3,781,1,4,0)
 ;;=4^Malingerer
 ;;^UTILITY(U,$J,358.3,781,2)
 ;;=^73536
 ;;^UTILITY(U,$J,358.3,782,0)
 ;;=V71.89^^8^86^7
 ;;^UTILITY(U,$J,358.3,782,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,782,1,3,0)
 ;;=3^V71.89
 ;;^UTILITY(U,$J,358.3,782,1,4,0)
 ;;=4^Observation for Spec Suspec Cond NEC
 ;;^UTILITY(U,$J,358.3,782,2)
 ;;=^322082
 ;;^UTILITY(U,$J,358.3,783,0)
 ;;=389.14^^8^87^1
 ;;^UTILITY(U,$J,358.3,783,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,783,1,3,0)
 ;;=3^389.14
 ;;^UTILITY(U,$J,358.3,783,1,4,0)
 ;;=4^Central Hearing Loss
 ;;^UTILITY(U,$J,358.3,783,2)
 ;;=^54567
 ;;^UTILITY(U,$J,358.3,784,0)
 ;;=389.00^^8^87^9
 ;;^UTILITY(U,$J,358.3,784,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,784,1,3,0)
 ;;=3^389.00
 ;;^UTILITY(U,$J,358.3,784,1,4,0)
 ;;=4^Conduct Hearing Loss Nos
 ;;^UTILITY(U,$J,358.3,784,2)
 ;;=^54574
 ;;^UTILITY(U,$J,358.3,785,0)
 ;;=389.08^^8^87^2
 ;;^UTILITY(U,$J,358.3,785,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,785,1,3,0)
 ;;=3^389.08
 ;;^UTILITY(U,$J,358.3,785,1,4,0)
 ;;=4^Cond Hear Loss Comb Type
 ;;^UTILITY(U,$J,358.3,785,2)
 ;;=^269546
 ;;^UTILITY(U,$J,358.3,786,0)
 ;;=389.01^^8^87^6
 ;;^UTILITY(U,$J,358.3,786,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,786,1,3,0)
 ;;=3^389.01
 ;;^UTILITY(U,$J,358.3,786,1,4,0)
 ;;=4^Conduc Hear Loss Ext Ear
 ;;^UTILITY(U,$J,358.3,786,2)
 ;;=^269542
 ;;^UTILITY(U,$J,358.3,787,0)
 ;;=389.04^^8^87^3
 ;;^UTILITY(U,$J,358.3,787,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,787,1,3,0)
 ;;=3^389.04
 ;;^UTILITY(U,$J,358.3,787,1,4,0)
 ;;=4^Cond Hear Loss Inner Ear
 ;;^UTILITY(U,$J,358.3,787,2)
 ;;=^269545
 ;;^UTILITY(U,$J,358.3,788,0)
 ;;=389.03^^8^87^7
 ;;^UTILITY(U,$J,358.3,788,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,788,1,3,0)
 ;;=3^389.03
 ;;^UTILITY(U,$J,358.3,788,1,4,0)
 ;;=4^Conduc Hear Loss Mid Ear
 ;;^UTILITY(U,$J,358.3,788,2)
 ;;=^269544
 ;;^UTILITY(U,$J,358.3,789,0)
 ;;=389.02^^8^87^8
 ;;^UTILITY(U,$J,358.3,789,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,789,1,3,0)
 ;;=3^389.02
 ;;^UTILITY(U,$J,358.3,789,1,4,0)
 ;;=4^Conduct Hear Loss Tympan

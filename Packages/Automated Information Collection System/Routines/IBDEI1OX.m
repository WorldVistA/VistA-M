IBDEI1OX ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,29992,1,4,0)
 ;;=4^O10.33
 ;;^UTILITY(U,$J,358.3,29992,2)
 ;;=^5016131
 ;;^UTILITY(U,$J,358.3,29993,0)
 ;;=O13.1^^178^1910^4
 ;;^UTILITY(U,$J,358.3,29993,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29993,1,3,0)
 ;;=3^Gestational htn w/o significant proteinuria, first trimester
 ;;^UTILITY(U,$J,358.3,29993,1,4,0)
 ;;=4^O13.1
 ;;^UTILITY(U,$J,358.3,29993,2)
 ;;=^5016158
 ;;^UTILITY(U,$J,358.3,29994,0)
 ;;=O13.2^^178^1910^5
 ;;^UTILITY(U,$J,358.3,29994,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29994,1,3,0)
 ;;=3^Gestational htn w/o significant proteinuria, second trimester
 ;;^UTILITY(U,$J,358.3,29994,1,4,0)
 ;;=4^O13.2
 ;;^UTILITY(U,$J,358.3,29994,2)
 ;;=^5016159
 ;;^UTILITY(U,$J,358.3,29995,0)
 ;;=O13.3^^178^1910^6
 ;;^UTILITY(U,$J,358.3,29995,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29995,1,3,0)
 ;;=3^Gestational htn w/o significant proteinuria, third trimester
 ;;^UTILITY(U,$J,358.3,29995,1,4,0)
 ;;=4^O13.3
 ;;^UTILITY(U,$J,358.3,29995,2)
 ;;=^5016160
 ;;^UTILITY(U,$J,358.3,29996,0)
 ;;=O16.1^^178^1910^9
 ;;^UTILITY(U,$J,358.3,29996,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29996,1,3,0)
 ;;=3^Maternal hypertension, first trimester NEC
 ;;^UTILITY(U,$J,358.3,29996,1,4,0)
 ;;=4^O16.1
 ;;^UTILITY(U,$J,358.3,29996,2)
 ;;=^5016180
 ;;^UTILITY(U,$J,358.3,29997,0)
 ;;=O16.2^^178^1910^10
 ;;^UTILITY(U,$J,358.3,29997,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29997,1,3,0)
 ;;=3^Maternal hypertension, second trimester NEC
 ;;^UTILITY(U,$J,358.3,29997,1,4,0)
 ;;=4^O16.2
 ;;^UTILITY(U,$J,358.3,29997,2)
 ;;=^5016181
 ;;^UTILITY(U,$J,358.3,29998,0)
 ;;=O16.3^^178^1910^11
 ;;^UTILITY(U,$J,358.3,29998,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29998,1,3,0)
 ;;=3^Maternal hypertension, third trimester NEC
 ;;^UTILITY(U,$J,358.3,29998,1,4,0)
 ;;=4^O16.3
 ;;^UTILITY(U,$J,358.3,29998,2)
 ;;=^5016182
 ;;^UTILITY(U,$J,358.3,29999,0)
 ;;=O14.02^^178^1910^12
 ;;^UTILITY(U,$J,358.3,29999,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29999,1,3,0)
 ;;=3^Mild to moderate pre-eclampsia, second trimester
 ;;^UTILITY(U,$J,358.3,29999,1,4,0)
 ;;=4^O14.02
 ;;^UTILITY(U,$J,358.3,29999,2)
 ;;=^5016163
 ;;^UTILITY(U,$J,358.3,30000,0)
 ;;=O14.03^^178^1910^13
 ;;^UTILITY(U,$J,358.3,30000,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30000,1,3,0)
 ;;=3^Mild to moderate pre-eclampsia, third trimester
 ;;^UTILITY(U,$J,358.3,30000,1,4,0)
 ;;=4^O14.03
 ;;^UTILITY(U,$J,358.3,30000,2)
 ;;=^5016164
 ;;^UTILITY(U,$J,358.3,30001,0)
 ;;=O14.90^^178^1910^16
 ;;^UTILITY(U,$J,358.3,30001,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30001,1,3,0)
 ;;=3^Pre-eclampsia, unspecified trimester NEC
 ;;^UTILITY(U,$J,358.3,30001,1,4,0)
 ;;=4^O14.90
 ;;^UTILITY(U,$J,358.3,30001,2)
 ;;=^5016171
 ;;^UTILITY(U,$J,358.3,30002,0)
 ;;=O14.92^^178^1910^14
 ;;^UTILITY(U,$J,358.3,30002,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30002,1,3,0)
 ;;=3^Pre-eclampsia, second trimester NEC
 ;;^UTILITY(U,$J,358.3,30002,1,4,0)
 ;;=4^O14.92
 ;;^UTILITY(U,$J,358.3,30002,2)
 ;;=^5016172
 ;;^UTILITY(U,$J,358.3,30003,0)
 ;;=O14.93^^178^1910^15
 ;;^UTILITY(U,$J,358.3,30003,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30003,1,3,0)
 ;;=3^Pre-eclampsia, third trimester NEC
 ;;^UTILITY(U,$J,358.3,30003,1,4,0)
 ;;=4^O14.93
 ;;^UTILITY(U,$J,358.3,30003,2)
 ;;=^5016173
 ;;^UTILITY(U,$J,358.3,30004,0)
 ;;=O15.2^^178^1910^3
 ;;^UTILITY(U,$J,358.3,30004,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30004,1,3,0)
 ;;=3^Eclampsia in the puerperium
 ;;^UTILITY(U,$J,358.3,30004,1,4,0)
 ;;=4^O15.2
 ;;^UTILITY(U,$J,358.3,30004,2)
 ;;=^5016178
 ;;^UTILITY(U,$J,358.3,30005,0)
 ;;=O14.12^^178^1910^43

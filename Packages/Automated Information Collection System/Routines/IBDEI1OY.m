IBDEI1OY ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30005,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30005,1,3,0)
 ;;=3^Severe pre-eclampsia, second trimester
 ;;^UTILITY(U,$J,358.3,30005,1,4,0)
 ;;=4^O14.12
 ;;^UTILITY(U,$J,358.3,30005,2)
 ;;=^5016166
 ;;^UTILITY(U,$J,358.3,30006,0)
 ;;=O14.13^^178^1910^44
 ;;^UTILITY(U,$J,358.3,30006,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30006,1,3,0)
 ;;=3^Severe pre-eclampsia, third trimester
 ;;^UTILITY(U,$J,358.3,30006,1,4,0)
 ;;=4^O14.13
 ;;^UTILITY(U,$J,358.3,30006,2)
 ;;=^5016167
 ;;^UTILITY(U,$J,358.3,30007,0)
 ;;=O14.22^^178^1910^7
 ;;^UTILITY(U,$J,358.3,30007,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30007,1,3,0)
 ;;=3^HELLP syndrome (HELLP), second trimester
 ;;^UTILITY(U,$J,358.3,30007,1,4,0)
 ;;=4^O14.22
 ;;^UTILITY(U,$J,358.3,30007,2)
 ;;=^5016169
 ;;^UTILITY(U,$J,358.3,30008,0)
 ;;=O14.23^^178^1910^8
 ;;^UTILITY(U,$J,358.3,30008,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30008,1,3,0)
 ;;=3^HELLP syndrome (HELLP), third trimester
 ;;^UTILITY(U,$J,358.3,30008,1,4,0)
 ;;=4^O14.23
 ;;^UTILITY(U,$J,358.3,30008,2)
 ;;=^5016170
 ;;^UTILITY(U,$J,358.3,30009,0)
 ;;=O15.02^^178^1910^1
 ;;^UTILITY(U,$J,358.3,30009,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30009,1,3,0)
 ;;=3^Eclampsia in pregnancy, second trimester
 ;;^UTILITY(U,$J,358.3,30009,1,4,0)
 ;;=4^O15.02
 ;;^UTILITY(U,$J,358.3,30009,2)
 ;;=^5016175
 ;;^UTILITY(U,$J,358.3,30010,0)
 ;;=O15.03^^178^1910^2
 ;;^UTILITY(U,$J,358.3,30010,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30010,1,3,0)
 ;;=3^Eclampsia in pregnancy, third trimester
 ;;^UTILITY(U,$J,358.3,30010,1,4,0)
 ;;=4^O15.03
 ;;^UTILITY(U,$J,358.3,30010,2)
 ;;=^5016176
 ;;^UTILITY(U,$J,358.3,30011,0)
 ;;=O11.1^^178^1910^35
 ;;^UTILITY(U,$J,358.3,30011,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30011,1,3,0)
 ;;=3^Pre-existing hypertension w pre-eclampsia, first trimester
 ;;^UTILITY(U,$J,358.3,30011,1,4,0)
 ;;=4^O11.1
 ;;^UTILITY(U,$J,358.3,30011,2)
 ;;=^5016142
 ;;^UTILITY(U,$J,358.3,30012,0)
 ;;=O11.2^^178^1910^36
 ;;^UTILITY(U,$J,358.3,30012,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30012,1,3,0)
 ;;=3^Pre-existing hypertension w pre-eclampsia, second trimester
 ;;^UTILITY(U,$J,358.3,30012,1,4,0)
 ;;=4^O11.2
 ;;^UTILITY(U,$J,358.3,30012,2)
 ;;=^5016143
 ;;^UTILITY(U,$J,358.3,30013,0)
 ;;=O11.3^^178^1910^37
 ;;^UTILITY(U,$J,358.3,30013,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30013,1,3,0)
 ;;=3^Pre-existing hypertension w pre-eclampsia, third trimester
 ;;^UTILITY(U,$J,358.3,30013,1,4,0)
 ;;=4^O11.3
 ;;^UTILITY(U,$J,358.3,30013,2)
 ;;=^5016144
 ;;^UTILITY(U,$J,358.3,30014,0)
 ;;=O21.0^^178^1911^3
 ;;^UTILITY(U,$J,358.3,30014,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30014,1,3,0)
 ;;=3^Mild hyperemesis gravidarum
 ;;^UTILITY(U,$J,358.3,30014,1,4,0)
 ;;=4^O21.0
 ;;^UTILITY(U,$J,358.3,30014,2)
 ;;=^5016185
 ;;^UTILITY(U,$J,358.3,30015,0)
 ;;=O21.1^^178^1911^1
 ;;^UTILITY(U,$J,358.3,30015,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30015,1,3,0)
 ;;=3^Hyperemesis gravidarum with metabolic disturbance
 ;;^UTILITY(U,$J,358.3,30015,1,4,0)
 ;;=4^O21.1
 ;;^UTILITY(U,$J,358.3,30015,2)
 ;;=^270869
 ;;^UTILITY(U,$J,358.3,30016,0)
 ;;=O21.2^^178^1911^2
 ;;^UTILITY(U,$J,358.3,30016,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30016,1,3,0)
 ;;=3^Late vomiting of pregnancy
 ;;^UTILITY(U,$J,358.3,30016,1,4,0)
 ;;=4^O21.2
 ;;^UTILITY(U,$J,358.3,30016,2)
 ;;=^270873
 ;;^UTILITY(U,$J,358.3,30017,0)
 ;;=O48.0^^178^1912^1
 ;;^UTILITY(U,$J,358.3,30017,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30017,1,3,0)
 ;;=3^Post-term pregnancy
 ;;^UTILITY(U,$J,358.3,30017,1,4,0)
 ;;=4^O48.0

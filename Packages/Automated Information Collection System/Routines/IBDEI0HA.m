IBDEI0HA ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8049,1,5,0)
 ;;=5^Urinary Tract Infection
 ;;^UTILITY(U,$J,358.3,8049,2)
 ;;=Urinary Tract Infection^124436
 ;;^UTILITY(U,$J,358.3,8050,0)
 ;;=275.42^^35^480^28
 ;;^UTILITY(U,$J,358.3,8050,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8050,1,4,0)
 ;;=4^275.42
 ;;^UTILITY(U,$J,358.3,8050,1,5,0)
 ;;=5^Hypercalcemia
 ;;^UTILITY(U,$J,358.3,8050,2)
 ;;=Hypercalcemia^59932
 ;;^UTILITY(U,$J,358.3,8051,0)
 ;;=275.41^^35^480^31
 ;;^UTILITY(U,$J,358.3,8051,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8051,1,4,0)
 ;;=4^275.41
 ;;^UTILITY(U,$J,358.3,8051,1,5,0)
 ;;=5^Hypocalcemia
 ;;^UTILITY(U,$J,358.3,8051,2)
 ;;=Hypocalcemia^60542
 ;;^UTILITY(U,$J,358.3,8052,0)
 ;;=276.7^^35^480^29
 ;;^UTILITY(U,$J,358.3,8052,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8052,1,4,0)
 ;;=4^276.7
 ;;^UTILITY(U,$J,358.3,8052,1,5,0)
 ;;=5^Hyperkalemia/Hyperpotassemia
 ;;^UTILITY(U,$J,358.3,8052,2)
 ;;=Hyperkalemia/Hyperpotassemia^60042
 ;;^UTILITY(U,$J,358.3,8053,0)
 ;;=276.8^^35^480^32
 ;;^UTILITY(U,$J,358.3,8053,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8053,1,4,0)
 ;;=4^276.8
 ;;^UTILITY(U,$J,358.3,8053,1,5,0)
 ;;=5^Hypokalemia/Hypopotassemia
 ;;^UTILITY(U,$J,358.3,8053,2)
 ;;=Hypokalemia/Hypopotassemia^60611
 ;;^UTILITY(U,$J,358.3,8054,0)
 ;;=275.2^^35^480^26
 ;;^UTILITY(U,$J,358.3,8054,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8054,1,4,0)
 ;;=4^275.2
 ;;^UTILITY(U,$J,358.3,8054,1,5,0)
 ;;=5^Hyper Or Hypomagnesemia
 ;;^UTILITY(U,$J,358.3,8054,2)
 ;;=^35626
 ;;^UTILITY(U,$J,358.3,8055,0)
 ;;=276.0^^35^480^30
 ;;^UTILITY(U,$J,358.3,8055,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8055,1,4,0)
 ;;=4^276.0
 ;;^UTILITY(U,$J,358.3,8055,1,5,0)
 ;;=5^Hypernatremia
 ;;^UTILITY(U,$J,358.3,8055,2)
 ;;=^60144
 ;;^UTILITY(U,$J,358.3,8056,0)
 ;;=276.1^^35^480^33
 ;;^UTILITY(U,$J,358.3,8056,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8056,1,4,0)
 ;;=4^276.1
 ;;^UTILITY(U,$J,358.3,8056,1,5,0)
 ;;=5^Hyponatremia
 ;;^UTILITY(U,$J,358.3,8056,2)
 ;;=Hyponatremia^60722
 ;;^UTILITY(U,$J,358.3,8057,0)
 ;;=275.3^^35^480^27
 ;;^UTILITY(U,$J,358.3,8057,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8057,1,4,0)
 ;;=4^275.3
 ;;^UTILITY(U,$J,358.3,8057,1,5,0)
 ;;=5^Hyper Or Hypophosphatemia
 ;;^UTILITY(U,$J,358.3,8057,2)
 ;;=^93796
 ;;^UTILITY(U,$J,358.3,8058,0)
 ;;=250.40^^35^480^16
 ;;^UTILITY(U,$J,358.3,8058,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8058,1,4,0)
 ;;=4^250.40
 ;;^UTILITY(U,$J,358.3,8058,1,5,0)
 ;;=5^DM type II with Nephropathy
 ;;^UTILITY(U,$J,358.3,8058,2)
 ;;=DM type II with Nephropathy^267837^583.81
 ;;^UTILITY(U,$J,358.3,8059,0)
 ;;=790.93^^35^480^1
 ;;^UTILITY(U,$J,358.3,8059,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8059,1,4,0)
 ;;=4^790.93
 ;;^UTILITY(U,$J,358.3,8059,1,5,0)
 ;;=5^Abnormal PSA
 ;;^UTILITY(U,$J,358.3,8059,2)
 ;;=Abnormal PSA^295772
 ;;^UTILITY(U,$J,358.3,8060,0)
 ;;=627.3^^35^480^3
 ;;^UTILITY(U,$J,358.3,8060,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8060,1,4,0)
 ;;=4^627.3
 ;;^UTILITY(U,$J,358.3,8060,1,5,0)
 ;;=5^Atrophic Vaginitis
 ;;^UTILITY(U,$J,358.3,8060,2)
 ;;=^270577
 ;;^UTILITY(U,$J,358.3,8061,0)
 ;;=607.1^^35^480^6
 ;;^UTILITY(U,$J,358.3,8061,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8061,1,4,0)
 ;;=4^607.1
 ;;^UTILITY(U,$J,358.3,8061,1,5,0)
 ;;=5^Balanitis
 ;;^UTILITY(U,$J,358.3,8061,2)
 ;;=^12530
 ;;^UTILITY(U,$J,358.3,8062,0)
 ;;=596.0^^35^480^7
 ;;^UTILITY(U,$J,358.3,8062,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8062,1,4,0)
 ;;=4^596.0
 ;;^UTILITY(U,$J,358.3,8062,1,5,0)
 ;;=5^Bladder Neck Obstruction
 ;;^UTILITY(U,$J,358.3,8062,2)
 ;;=^15144
 ;;^UTILITY(U,$J,358.3,8063,0)
 ;;=595.0^^35^480^10

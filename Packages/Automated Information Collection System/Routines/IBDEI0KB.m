IBDEI0KB ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9953,1,4,0)
 ;;=4^276.7
 ;;^UTILITY(U,$J,358.3,9953,1,5,0)
 ;;=5^Hyperkalemia/Hyperpotassemia
 ;;^UTILITY(U,$J,358.3,9953,2)
 ;;=Hyperkalemia/Hyperpotassemia^60042
 ;;^UTILITY(U,$J,358.3,9954,0)
 ;;=276.8^^67^670^32
 ;;^UTILITY(U,$J,358.3,9954,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9954,1,4,0)
 ;;=4^276.8
 ;;^UTILITY(U,$J,358.3,9954,1,5,0)
 ;;=5^Hypokalemia/Hypopotassemia
 ;;^UTILITY(U,$J,358.3,9954,2)
 ;;=Hypokalemia/Hypopotassemia^60611
 ;;^UTILITY(U,$J,358.3,9955,0)
 ;;=275.2^^67^670^26
 ;;^UTILITY(U,$J,358.3,9955,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9955,1,4,0)
 ;;=4^275.2
 ;;^UTILITY(U,$J,358.3,9955,1,5,0)
 ;;=5^Hyper Or Hypomagnesemia
 ;;^UTILITY(U,$J,358.3,9955,2)
 ;;=^35626
 ;;^UTILITY(U,$J,358.3,9956,0)
 ;;=276.0^^67^670^30
 ;;^UTILITY(U,$J,358.3,9956,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9956,1,4,0)
 ;;=4^276.0
 ;;^UTILITY(U,$J,358.3,9956,1,5,0)
 ;;=5^Hypernatremia
 ;;^UTILITY(U,$J,358.3,9956,2)
 ;;=^60144
 ;;^UTILITY(U,$J,358.3,9957,0)
 ;;=276.1^^67^670^33
 ;;^UTILITY(U,$J,358.3,9957,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9957,1,4,0)
 ;;=4^276.1
 ;;^UTILITY(U,$J,358.3,9957,1,5,0)
 ;;=5^Hyponatremia
 ;;^UTILITY(U,$J,358.3,9957,2)
 ;;=Hyponatremia^60722
 ;;^UTILITY(U,$J,358.3,9958,0)
 ;;=275.3^^67^670^27
 ;;^UTILITY(U,$J,358.3,9958,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9958,1,4,0)
 ;;=4^275.3
 ;;^UTILITY(U,$J,358.3,9958,1,5,0)
 ;;=5^Hyper Or Hypophosphatemia
 ;;^UTILITY(U,$J,358.3,9958,2)
 ;;=^93796
 ;;^UTILITY(U,$J,358.3,9959,0)
 ;;=250.40^^67^670^16
 ;;^UTILITY(U,$J,358.3,9959,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9959,1,4,0)
 ;;=4^250.40
 ;;^UTILITY(U,$J,358.3,9959,1,5,0)
 ;;=5^DM type II with Nephropathy
 ;;^UTILITY(U,$J,358.3,9959,2)
 ;;=DM type II with Nephropathy^267837^583.81
 ;;^UTILITY(U,$J,358.3,9960,0)
 ;;=790.93^^67^670^1
 ;;^UTILITY(U,$J,358.3,9960,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9960,1,4,0)
 ;;=4^790.93
 ;;^UTILITY(U,$J,358.3,9960,1,5,0)
 ;;=5^Abnormal PSA
 ;;^UTILITY(U,$J,358.3,9960,2)
 ;;=Abnormal PSA^295772
 ;;^UTILITY(U,$J,358.3,9961,0)
 ;;=627.3^^67^670^3
 ;;^UTILITY(U,$J,358.3,9961,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9961,1,4,0)
 ;;=4^627.3
 ;;^UTILITY(U,$J,358.3,9961,1,5,0)
 ;;=5^Atrophic Vaginitis
 ;;^UTILITY(U,$J,358.3,9961,2)
 ;;=^270577
 ;;^UTILITY(U,$J,358.3,9962,0)
 ;;=607.1^^67^670^6
 ;;^UTILITY(U,$J,358.3,9962,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9962,1,4,0)
 ;;=4^607.1
 ;;^UTILITY(U,$J,358.3,9962,1,5,0)
 ;;=5^Balanitis
 ;;^UTILITY(U,$J,358.3,9962,2)
 ;;=^12530
 ;;^UTILITY(U,$J,358.3,9963,0)
 ;;=596.0^^67^670^7
 ;;^UTILITY(U,$J,358.3,9963,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9963,1,4,0)
 ;;=4^596.0
 ;;^UTILITY(U,$J,358.3,9963,1,5,0)
 ;;=5^Bladder Neck Obstruction
 ;;^UTILITY(U,$J,358.3,9963,2)
 ;;=^15144
 ;;^UTILITY(U,$J,358.3,9964,0)
 ;;=595.0^^67^670^10
 ;;^UTILITY(U,$J,358.3,9964,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9964,1,4,0)
 ;;=4^595.0
 ;;^UTILITY(U,$J,358.3,9964,1,5,0)
 ;;=5^Cystitis, Acute
 ;;^UTILITY(U,$J,358.3,9964,2)
 ;;=^259104
 ;;^UTILITY(U,$J,358.3,9965,0)
 ;;=595.82^^67^670^11
 ;;^UTILITY(U,$J,358.3,9965,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9965,1,4,0)
 ;;=4^595.82
 ;;^UTILITY(U,$J,358.3,9965,1,5,0)
 ;;=5^Cystitis, Radiation
 ;;^UTILITY(U,$J,358.3,9965,2)
 ;;=^270391
 ;;^UTILITY(U,$J,358.3,9966,0)
 ;;=596.59^^67^670^17
 ;;^UTILITY(U,$J,358.3,9966,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9966,1,4,0)
 ;;=4^596.59
 ;;^UTILITY(U,$J,358.3,9966,1,5,0)
 ;;=5^Detrusor Muscle Insuff
 ;;^UTILITY(U,$J,358.3,9966,2)
 ;;=^270393
 ;;^UTILITY(U,$J,358.3,9967,0)
 ;;=788.1^^67^670^18

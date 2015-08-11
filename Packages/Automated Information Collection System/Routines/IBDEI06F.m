IBDEI06F ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2793,1,2,0)
 ;;=2^Blood Transfusion Service
 ;;^UTILITY(U,$J,358.3,2793,1,4,0)
 ;;=4^36430
 ;;^UTILITY(U,$J,358.3,2794,0)
 ;;=96360^^25^232^1^^^^1
 ;;^UTILITY(U,$J,358.3,2794,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2794,1,2,0)
 ;;=2^Hydration IV Inf,Init
 ;;^UTILITY(U,$J,358.3,2794,1,4,0)
 ;;=4^96360
 ;;^UTILITY(U,$J,358.3,2795,0)
 ;;=96361^^25^232^2^^^^1
 ;;^UTILITY(U,$J,358.3,2795,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2795,1,2,0)
 ;;=2^Hydration IV Inf,Add-On
 ;;^UTILITY(U,$J,358.3,2795,1,4,0)
 ;;=4^96361
 ;;^UTILITY(U,$J,358.3,2796,0)
 ;;=96365^^25^232^3^^^^1
 ;;^UTILITY(U,$J,358.3,2796,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2796,1,2,0)
 ;;=2^IV Inf Ther/Proph/Diag Init Hr
 ;;^UTILITY(U,$J,358.3,2796,1,4,0)
 ;;=4^96365
 ;;^UTILITY(U,$J,358.3,2797,0)
 ;;=96366^^25^232^4^^^^1
 ;;^UTILITY(U,$J,358.3,2797,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2797,1,2,0)
 ;;=2^IV Inf Ther/Proph/Diag Ea Addl Hr
 ;;^UTILITY(U,$J,358.3,2797,1,4,0)
 ;;=4^96366
 ;;^UTILITY(U,$J,358.3,2798,0)
 ;;=J1750^^25^233^13^^^^1
 ;;^UTILITY(U,$J,358.3,2798,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2798,1,2,0)
 ;;=2^Iron Dextran Inj 50mg
 ;;^UTILITY(U,$J,358.3,2798,1,4,0)
 ;;=4^J1750
 ;;^UTILITY(U,$J,358.3,2799,0)
 ;;=J1756^^25^233^14^^^^1
 ;;^UTILITY(U,$J,358.3,2799,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2799,1,2,0)
 ;;=2^Iron Sucrose Inj 1mg/ml
 ;;^UTILITY(U,$J,358.3,2799,1,4,0)
 ;;=4^J1756
 ;;^UTILITY(U,$J,358.3,2800,0)
 ;;=J2323^^25^233^17^^^^1
 ;;^UTILITY(U,$J,358.3,2800,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2800,1,2,0)
 ;;=2^Natalizumab Inj 1mg
 ;;^UTILITY(U,$J,358.3,2800,1,4,0)
 ;;=4^J2323
 ;;^UTILITY(U,$J,358.3,2801,0)
 ;;=J9310^^25^233^19^^^^1
 ;;^UTILITY(U,$J,358.3,2801,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2801,1,2,0)
 ;;=2^Rituximab Inj 100mg
 ;;^UTILITY(U,$J,358.3,2801,1,4,0)
 ;;=4^J9310
 ;;^UTILITY(U,$J,358.3,2802,0)
 ;;=J1094^^25^233^5^^^^1
 ;;^UTILITY(U,$J,358.3,2802,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2802,1,2,0)
 ;;=2^Dexamethasone Acetate 1mg
 ;;^UTILITY(U,$J,358.3,2802,1,4,0)
 ;;=4^J1094
 ;;^UTILITY(U,$J,358.3,2803,0)
 ;;=J0256^^25^233^1^^^^1
 ;;^UTILITY(U,$J,358.3,2803,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2803,1,2,0)
 ;;=2^Alpha 1 Proteinase Inhib 10mg
 ;;^UTILITY(U,$J,358.3,2803,1,4,0)
 ;;=4^J0256
 ;;^UTILITY(U,$J,358.3,2804,0)
 ;;=J3370^^25^233^20^^^^1
 ;;^UTILITY(U,$J,358.3,2804,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2804,1,2,0)
 ;;=2^Vancomycin HCL Inj 500mg
 ;;^UTILITY(U,$J,358.3,2804,1,4,0)
 ;;=4^J3370
 ;;^UTILITY(U,$J,358.3,2805,0)
 ;;=J3475^^25^233^15^^^^1
 ;;^UTILITY(U,$J,358.3,2805,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2805,1,2,0)
 ;;=2^Magnesium Sulfate Inj 500mg
 ;;^UTILITY(U,$J,358.3,2805,1,4,0)
 ;;=4^J3475
 ;;^UTILITY(U,$J,358.3,2806,0)
 ;;=J3480^^25^233^18^^^^1
 ;;^UTILITY(U,$J,358.3,2806,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2806,1,2,0)
 ;;=2^Potassium Chloride Inj 2mEq
 ;;^UTILITY(U,$J,358.3,2806,1,4,0)
 ;;=4^J3480
 ;;^UTILITY(U,$J,358.3,2807,0)
 ;;=J9070^^25^233^2^^^^1
 ;;^UTILITY(U,$J,358.3,2807,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2807,1,2,0)
 ;;=2^Cyclophosphamide Inj 100mg
 ;;^UTILITY(U,$J,358.3,2807,1,4,0)
 ;;=4^J9070
 ;;^UTILITY(U,$J,358.3,2808,0)
 ;;=J8530^^25^233^3^^^^1
 ;;^UTILITY(U,$J,358.3,2808,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2808,1,2,0)
 ;;=2^Cyclophosphamide Oral 25mg
 ;;^UTILITY(U,$J,358.3,2808,1,4,0)
 ;;=4^J8530
 ;;^UTILITY(U,$J,358.3,2809,0)
 ;;=J1020^^25^233^16^^^^1
 ;;^UTILITY(U,$J,358.3,2809,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2809,1,2,0)
 ;;=2^Methylprednisolone Inj 20mg

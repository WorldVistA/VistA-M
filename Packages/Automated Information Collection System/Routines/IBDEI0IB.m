IBDEI0IB ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7986,2)
 ;;=^5001090
 ;;^UTILITY(U,$J,358.3,7987,0)
 ;;=C43.0^^65^517^8
 ;;^UTILITY(U,$J,358.3,7987,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7987,1,3,0)
 ;;=3^Malig Melanoma of Lip
 ;;^UTILITY(U,$J,358.3,7987,1,4,0)
 ;;=4^C43.0
 ;;^UTILITY(U,$J,358.3,7987,2)
 ;;=^5000994
 ;;^UTILITY(U,$J,358.3,7988,0)
 ;;=C43.21^^65^517^11
 ;;^UTILITY(U,$J,358.3,7988,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7988,1,3,0)
 ;;=3^Malig Melanoma of Right Ear/External Auricular Canal
 ;;^UTILITY(U,$J,358.3,7988,1,4,0)
 ;;=4^C43.21
 ;;^UTILITY(U,$J,358.3,7988,2)
 ;;=^5000999
 ;;^UTILITY(U,$J,358.3,7989,0)
 ;;=C43.22^^65^517^3
 ;;^UTILITY(U,$J,358.3,7989,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7989,1,3,0)
 ;;=3^Malig Melanoma of Left Ear/External Auricular Canal
 ;;^UTILITY(U,$J,358.3,7989,1,4,0)
 ;;=4^C43.22
 ;;^UTILITY(U,$J,358.3,7989,2)
 ;;=^5001000
 ;;^UTILITY(U,$J,358.3,7990,0)
 ;;=C43.31^^65^517^9
 ;;^UTILITY(U,$J,358.3,7990,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7990,1,3,0)
 ;;=3^Malig Melanoma of Nose
 ;;^UTILITY(U,$J,358.3,7990,1,4,0)
 ;;=4^C43.31
 ;;^UTILITY(U,$J,358.3,7990,2)
 ;;=^5001002
 ;;^UTILITY(U,$J,358.3,7991,0)
 ;;=C43.39^^65^517^2
 ;;^UTILITY(U,$J,358.3,7991,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7991,1,3,0)
 ;;=3^Malig Melanoma of Face,Other Parts
 ;;^UTILITY(U,$J,358.3,7991,1,4,0)
 ;;=4^C43.39
 ;;^UTILITY(U,$J,358.3,7991,2)
 ;;=^5001003
 ;;^UTILITY(U,$J,358.3,7992,0)
 ;;=C43.4^^65^517^16
 ;;^UTILITY(U,$J,358.3,7992,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7992,1,3,0)
 ;;=3^Malig Melanoma of Scalp/Neck
 ;;^UTILITY(U,$J,358.3,7992,1,4,0)
 ;;=4^C43.4
 ;;^UTILITY(U,$J,358.3,7992,2)
 ;;=^5001004
 ;;^UTILITY(U,$J,358.3,7993,0)
 ;;=C43.59^^65^517^18
 ;;^UTILITY(U,$J,358.3,7993,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7993,1,3,0)
 ;;=3^Malig Melanoma of Trunk,Other Part
 ;;^UTILITY(U,$J,358.3,7993,1,4,0)
 ;;=4^C43.59
 ;;^UTILITY(U,$J,358.3,7993,2)
 ;;=^5001007
 ;;^UTILITY(U,$J,358.3,7994,0)
 ;;=C43.51^^65^517^1
 ;;^UTILITY(U,$J,358.3,7994,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7994,1,3,0)
 ;;=3^Malig Melanoma of Anal Skin
 ;;^UTILITY(U,$J,358.3,7994,1,4,0)
 ;;=4^C43.51
 ;;^UTILITY(U,$J,358.3,7994,2)
 ;;=^5001005
 ;;^UTILITY(U,$J,358.3,7995,0)
 ;;=C43.52^^65^517^17
 ;;^UTILITY(U,$J,358.3,7995,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7995,1,3,0)
 ;;=3^Malig Melanoma of Skin of Breast
 ;;^UTILITY(U,$J,358.3,7995,1,4,0)
 ;;=4^C43.52
 ;;^UTILITY(U,$J,358.3,7995,2)
 ;;=^5001006
 ;;^UTILITY(U,$J,358.3,7996,0)
 ;;=C43.61^^65^517^15
 ;;^UTILITY(U,$J,358.3,7996,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7996,1,3,0)
 ;;=3^Malig Melanoma of Right Upper Limb
 ;;^UTILITY(U,$J,358.3,7996,1,4,0)
 ;;=4^C43.61
 ;;^UTILITY(U,$J,358.3,7996,2)
 ;;=^5001009
 ;;^UTILITY(U,$J,358.3,7997,0)
 ;;=C43.62^^65^517^7
 ;;^UTILITY(U,$J,358.3,7997,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7997,1,3,0)
 ;;=3^Malig Melanoma of Left Upper Limb
 ;;^UTILITY(U,$J,358.3,7997,1,4,0)
 ;;=4^C43.62
 ;;^UTILITY(U,$J,358.3,7997,2)
 ;;=^5001010
 ;;^UTILITY(U,$J,358.3,7998,0)
 ;;=C43.71^^65^517^13
 ;;^UTILITY(U,$J,358.3,7998,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7998,1,3,0)
 ;;=3^Malig Melanoma of Right Lower Limb
 ;;^UTILITY(U,$J,358.3,7998,1,4,0)
 ;;=4^C43.71
 ;;^UTILITY(U,$J,358.3,7998,2)
 ;;=^5001012
 ;;^UTILITY(U,$J,358.3,7999,0)
 ;;=C43.72^^65^517^5
 ;;^UTILITY(U,$J,358.3,7999,1,0)
 ;;=^358.31IA^4^2

IBDEI0IC ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7999,1,3,0)
 ;;=3^Malig Melanoma of Left Lower Limb
 ;;^UTILITY(U,$J,358.3,7999,1,4,0)
 ;;=4^C43.72
 ;;^UTILITY(U,$J,358.3,7999,2)
 ;;=^5001013
 ;;^UTILITY(U,$J,358.3,8000,0)
 ;;=C43.8^^65^517^10
 ;;^UTILITY(U,$J,358.3,8000,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8000,1,3,0)
 ;;=3^Malig Melanoma of Overlapping Sites of Skin
 ;;^UTILITY(U,$J,358.3,8000,1,4,0)
 ;;=4^C43.8
 ;;^UTILITY(U,$J,358.3,8000,2)
 ;;=^5001014
 ;;^UTILITY(U,$J,358.3,8001,0)
 ;;=D03.0^^65^517^66
 ;;^UTILITY(U,$J,358.3,8001,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8001,1,3,0)
 ;;=3^Melanoma in Situ of Lip
 ;;^UTILITY(U,$J,358.3,8001,1,4,0)
 ;;=4^D03.0
 ;;^UTILITY(U,$J,358.3,8001,2)
 ;;=^5001888
 ;;^UTILITY(U,$J,358.3,8002,0)
 ;;=D03.21^^65^517^58
 ;;^UTILITY(U,$J,358.3,8002,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8002,1,3,0)
 ;;=3^Melanoma in Situ Right Ear/External Auricular Canal
 ;;^UTILITY(U,$J,358.3,8002,1,4,0)
 ;;=4^D03.21
 ;;^UTILITY(U,$J,358.3,8002,2)
 ;;=^5001893
 ;;^UTILITY(U,$J,358.3,8003,0)
 ;;=D03.22^^65^517^55
 ;;^UTILITY(U,$J,358.3,8003,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8003,1,3,0)
 ;;=3^Melanoma in Situ Left Ear/External Auricular Canal
 ;;^UTILITY(U,$J,358.3,8003,1,4,0)
 ;;=4^D03.22
 ;;^UTILITY(U,$J,358.3,8003,2)
 ;;=^5001894
 ;;^UTILITY(U,$J,358.3,8004,0)
 ;;=D03.30^^65^517^63
 ;;^UTILITY(U,$J,358.3,8004,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8004,1,3,0)
 ;;=3^Melanoma in Situ Unspec Part of Face
 ;;^UTILITY(U,$J,358.3,8004,1,4,0)
 ;;=4^D03.30
 ;;^UTILITY(U,$J,358.3,8004,2)
 ;;=^5001895
 ;;^UTILITY(U,$J,358.3,8005,0)
 ;;=D03.4^^65^517^61
 ;;^UTILITY(U,$J,358.3,8005,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8005,1,3,0)
 ;;=3^Melanoma in Situ Scalp/Neck
 ;;^UTILITY(U,$J,358.3,8005,1,4,0)
 ;;=4^D03.4
 ;;^UTILITY(U,$J,358.3,8005,2)
 ;;=^5001897
 ;;^UTILITY(U,$J,358.3,8006,0)
 ;;=D03.59^^65^517^62
 ;;^UTILITY(U,$J,358.3,8006,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8006,1,3,0)
 ;;=3^Melanoma in Situ Trunk,Other Part
 ;;^UTILITY(U,$J,358.3,8006,1,4,0)
 ;;=4^D03.59
 ;;^UTILITY(U,$J,358.3,8006,2)
 ;;=^5001900
 ;;^UTILITY(U,$J,358.3,8007,0)
 ;;=D03.51^^65^517^53
 ;;^UTILITY(U,$J,358.3,8007,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8007,1,3,0)
 ;;=3^Melanoma in Situ Anal Skin
 ;;^UTILITY(U,$J,358.3,8007,1,4,0)
 ;;=4^D03.51
 ;;^UTILITY(U,$J,358.3,8007,2)
 ;;=^5001898
 ;;^UTILITY(U,$J,358.3,8008,0)
 ;;=D03.52^^65^517^54
 ;;^UTILITY(U,$J,358.3,8008,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8008,1,3,0)
 ;;=3^Melanoma in Situ Breast,Skin/Soft Tissue
 ;;^UTILITY(U,$J,358.3,8008,1,4,0)
 ;;=4^D03.52
 ;;^UTILITY(U,$J,358.3,8008,2)
 ;;=^5001899
 ;;^UTILITY(U,$J,358.3,8009,0)
 ;;=D03.61^^65^517^60
 ;;^UTILITY(U,$J,358.3,8009,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8009,1,3,0)
 ;;=3^Melanoma in Situ Right Upper Limb
 ;;^UTILITY(U,$J,358.3,8009,1,4,0)
 ;;=4^D03.61
 ;;^UTILITY(U,$J,358.3,8009,2)
 ;;=^5001902
 ;;^UTILITY(U,$J,358.3,8010,0)
 ;;=D03.62^^65^517^57
 ;;^UTILITY(U,$J,358.3,8010,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8010,1,3,0)
 ;;=3^Melanoma in Situ Left Upper Limb
 ;;^UTILITY(U,$J,358.3,8010,1,4,0)
 ;;=4^D03.62
 ;;^UTILITY(U,$J,358.3,8010,2)
 ;;=^5001903
 ;;^UTILITY(U,$J,358.3,8011,0)
 ;;=D03.71^^65^517^59
 ;;^UTILITY(U,$J,358.3,8011,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8011,1,3,0)
 ;;=3^Melanoma in Situ Right Lower Limb
 ;;^UTILITY(U,$J,358.3,8011,1,4,0)
 ;;=4^D03.71

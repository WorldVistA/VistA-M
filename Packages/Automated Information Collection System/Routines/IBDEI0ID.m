IBDEI0ID ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8011,2)
 ;;=^5001905
 ;;^UTILITY(U,$J,358.3,8012,0)
 ;;=D03.72^^65^517^56
 ;;^UTILITY(U,$J,358.3,8012,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8012,1,3,0)
 ;;=3^Melanoma in Situ Left Lower Limb
 ;;^UTILITY(U,$J,358.3,8012,1,4,0)
 ;;=4^D03.72
 ;;^UTILITY(U,$J,358.3,8012,2)
 ;;=^5001906
 ;;^UTILITY(U,$J,358.3,8013,0)
 ;;=D03.8^^65^517^67
 ;;^UTILITY(U,$J,358.3,8013,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8013,1,3,0)
 ;;=3^Melanoma in Situ of Other Sites
 ;;^UTILITY(U,$J,358.3,8013,1,4,0)
 ;;=4^D03.8
 ;;^UTILITY(U,$J,358.3,8013,2)
 ;;=^5001907
 ;;^UTILITY(U,$J,358.3,8014,0)
 ;;=D22.0^^65^517^43
 ;;^UTILITY(U,$J,358.3,8014,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8014,1,3,0)
 ;;=3^Melanocytic Nevi of Lip
 ;;^UTILITY(U,$J,358.3,8014,1,4,0)
 ;;=4^D22.0
 ;;^UTILITY(U,$J,358.3,8014,2)
 ;;=^5002041
 ;;^UTILITY(U,$J,358.3,8015,0)
 ;;=D22.21^^65^517^44
 ;;^UTILITY(U,$J,358.3,8015,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8015,1,3,0)
 ;;=3^Melanocytic Nevi of Right Ear/External Auricular Canal
 ;;^UTILITY(U,$J,358.3,8015,1,4,0)
 ;;=4^D22.21
 ;;^UTILITY(U,$J,358.3,8015,2)
 ;;=^5002046
 ;;^UTILITY(U,$J,358.3,8016,0)
 ;;=D22.22^^65^517^38
 ;;^UTILITY(U,$J,358.3,8016,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8016,1,3,0)
 ;;=3^Melanocytic Nevi of Left Ear/External Auricular Canal
 ;;^UTILITY(U,$J,358.3,8016,1,4,0)
 ;;=4^D22.22
 ;;^UTILITY(U,$J,358.3,8016,2)
 ;;=^5002047
 ;;^UTILITY(U,$J,358.3,8017,0)
 ;;=D22.30^^65^517^51
 ;;^UTILITY(U,$J,358.3,8017,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8017,1,3,0)
 ;;=3^Melanocytic Nevi of Unspec Part of Face
 ;;^UTILITY(U,$J,358.3,8017,1,4,0)
 ;;=4^D22.30
 ;;^UTILITY(U,$J,358.3,8017,2)
 ;;=^5002048
 ;;^UTILITY(U,$J,358.3,8018,0)
 ;;=D22.4^^65^517^49
 ;;^UTILITY(U,$J,358.3,8018,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8018,1,3,0)
 ;;=3^Melanocytic Nevi of Scalp/Neck
 ;;^UTILITY(U,$J,358.3,8018,1,4,0)
 ;;=4^D22.4
 ;;^UTILITY(U,$J,358.3,8018,2)
 ;;=^5002050
 ;;^UTILITY(U,$J,358.3,8019,0)
 ;;=D22.5^^65^517^50
 ;;^UTILITY(U,$J,358.3,8019,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8019,1,3,0)
 ;;=3^Melanocytic Nevi of Trunk
 ;;^UTILITY(U,$J,358.3,8019,1,4,0)
 ;;=4^D22.5
 ;;^UTILITY(U,$J,358.3,8019,2)
 ;;=^5002051
 ;;^UTILITY(U,$J,358.3,8020,0)
 ;;=D22.61^^65^517^48
 ;;^UTILITY(U,$J,358.3,8020,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8020,1,3,0)
 ;;=3^Melanocytic Nevi of Right Upper Limb
 ;;^UTILITY(U,$J,358.3,8020,1,4,0)
 ;;=4^D22.61
 ;;^UTILITY(U,$J,358.3,8020,2)
 ;;=^5002053
 ;;^UTILITY(U,$J,358.3,8021,0)
 ;;=D22.62^^65^517^42
 ;;^UTILITY(U,$J,358.3,8021,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8021,1,3,0)
 ;;=3^Melanocytic Nevi of Left Upper Limb
 ;;^UTILITY(U,$J,358.3,8021,1,4,0)
 ;;=4^D22.62
 ;;^UTILITY(U,$J,358.3,8021,2)
 ;;=^5002054
 ;;^UTILITY(U,$J,358.3,8022,0)
 ;;=D22.71^^65^517^46
 ;;^UTILITY(U,$J,358.3,8022,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8022,1,3,0)
 ;;=3^Melanocytic Nevi of Right Lower Limb
 ;;^UTILITY(U,$J,358.3,8022,1,4,0)
 ;;=4^D22.71
 ;;^UTILITY(U,$J,358.3,8022,2)
 ;;=^5002056
 ;;^UTILITY(U,$J,358.3,8023,0)
 ;;=D22.72^^65^517^40
 ;;^UTILITY(U,$J,358.3,8023,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8023,1,3,0)
 ;;=3^Melanocytic Nevi of Left Lower Limb
 ;;^UTILITY(U,$J,358.3,8023,1,4,0)
 ;;=4^D22.72
 ;;^UTILITY(U,$J,358.3,8023,2)
 ;;=^5002057
 ;;^UTILITY(U,$J,358.3,8024,0)
 ;;=C44.390^^65^517^36

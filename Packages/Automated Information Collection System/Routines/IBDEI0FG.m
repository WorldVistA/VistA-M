IBDEI0FG ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6813,1,4,0)
 ;;=4^C43.4
 ;;^UTILITY(U,$J,358.3,6813,2)
 ;;=^5001004
 ;;^UTILITY(U,$J,358.3,6814,0)
 ;;=C43.59^^46^451^16
 ;;^UTILITY(U,$J,358.3,6814,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6814,1,3,0)
 ;;=3^Malig Melanoma of Trunk,Other Part
 ;;^UTILITY(U,$J,358.3,6814,1,4,0)
 ;;=4^C43.59
 ;;^UTILITY(U,$J,358.3,6814,2)
 ;;=^5001007
 ;;^UTILITY(U,$J,358.3,6815,0)
 ;;=C43.51^^46^451^1
 ;;^UTILITY(U,$J,358.3,6815,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6815,1,3,0)
 ;;=3^Malig Melanoma of Anal Skin
 ;;^UTILITY(U,$J,358.3,6815,1,4,0)
 ;;=4^C43.51
 ;;^UTILITY(U,$J,358.3,6815,2)
 ;;=^5001005
 ;;^UTILITY(U,$J,358.3,6816,0)
 ;;=C43.52^^46^451^15
 ;;^UTILITY(U,$J,358.3,6816,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6816,1,3,0)
 ;;=3^Malig Melanoma of Skin of Breast
 ;;^UTILITY(U,$J,358.3,6816,1,4,0)
 ;;=4^C43.52
 ;;^UTILITY(U,$J,358.3,6816,2)
 ;;=^5001006
 ;;^UTILITY(U,$J,358.3,6817,0)
 ;;=C43.61^^46^451^13
 ;;^UTILITY(U,$J,358.3,6817,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6817,1,3,0)
 ;;=3^Malig Melanoma of Right Upper Limb
 ;;^UTILITY(U,$J,358.3,6817,1,4,0)
 ;;=4^C43.61
 ;;^UTILITY(U,$J,358.3,6817,2)
 ;;=^5001009
 ;;^UTILITY(U,$J,358.3,6818,0)
 ;;=C43.62^^46^451^6
 ;;^UTILITY(U,$J,358.3,6818,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6818,1,3,0)
 ;;=3^Malig Melanoma of Left Upper Limb
 ;;^UTILITY(U,$J,358.3,6818,1,4,0)
 ;;=4^C43.62
 ;;^UTILITY(U,$J,358.3,6818,2)
 ;;=^5001010
 ;;^UTILITY(U,$J,358.3,6819,0)
 ;;=C43.71^^46^451^12
 ;;^UTILITY(U,$J,358.3,6819,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6819,1,3,0)
 ;;=3^Malig Melanoma of Right Lower Limb
 ;;^UTILITY(U,$J,358.3,6819,1,4,0)
 ;;=4^C43.71
 ;;^UTILITY(U,$J,358.3,6819,2)
 ;;=^5001012
 ;;^UTILITY(U,$J,358.3,6820,0)
 ;;=C43.72^^46^451^5
 ;;^UTILITY(U,$J,358.3,6820,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6820,1,3,0)
 ;;=3^Malig Melanoma of Left Lower Limb
 ;;^UTILITY(U,$J,358.3,6820,1,4,0)
 ;;=4^C43.72
 ;;^UTILITY(U,$J,358.3,6820,2)
 ;;=^5001013
 ;;^UTILITY(U,$J,358.3,6821,0)
 ;;=C43.8^^46^451^9
 ;;^UTILITY(U,$J,358.3,6821,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6821,1,3,0)
 ;;=3^Malig Melanoma of Overlapping Sites of Skin
 ;;^UTILITY(U,$J,358.3,6821,1,4,0)
 ;;=4^C43.8
 ;;^UTILITY(U,$J,358.3,6821,2)
 ;;=^5001014
 ;;^UTILITY(U,$J,358.3,6822,0)
 ;;=D03.0^^46^451^60
 ;;^UTILITY(U,$J,358.3,6822,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6822,1,3,0)
 ;;=3^Melanoma in Situ of Lip
 ;;^UTILITY(U,$J,358.3,6822,1,4,0)
 ;;=4^D03.0
 ;;^UTILITY(U,$J,358.3,6822,2)
 ;;=^5001888
 ;;^UTILITY(U,$J,358.3,6823,0)
 ;;=D03.11^^46^451^54
 ;;^UTILITY(U,$J,358.3,6823,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6823,1,3,0)
 ;;=3^Melanoma in Situ Right Eyelid
 ;;^UTILITY(U,$J,358.3,6823,1,4,0)
 ;;=4^D03.11
 ;;^UTILITY(U,$J,358.3,6823,2)
 ;;=^5001890
 ;;^UTILITY(U,$J,358.3,6824,0)
 ;;=D03.12^^46^451^50
 ;;^UTILITY(U,$J,358.3,6824,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6824,1,3,0)
 ;;=3^Melanoma in Situ Left Eyelid
 ;;^UTILITY(U,$J,358.3,6824,1,4,0)
 ;;=4^D03.12
 ;;^UTILITY(U,$J,358.3,6824,2)
 ;;=^5001891
 ;;^UTILITY(U,$J,358.3,6825,0)
 ;;=D03.21^^46^451^53
 ;;^UTILITY(U,$J,358.3,6825,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6825,1,3,0)
 ;;=3^Melanoma in Situ Right Ear/External Auricular Canal
 ;;^UTILITY(U,$J,358.3,6825,1,4,0)
 ;;=4^D03.21
 ;;^UTILITY(U,$J,358.3,6825,2)
 ;;=^5001893
 ;;^UTILITY(U,$J,358.3,6826,0)
 ;;=D03.22^^46^451^49
 ;;^UTILITY(U,$J,358.3,6826,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6826,1,3,0)
 ;;=3^Melanoma in Situ Left Ear/External Auricular Canal
 ;;^UTILITY(U,$J,358.3,6826,1,4,0)
 ;;=4^D03.22

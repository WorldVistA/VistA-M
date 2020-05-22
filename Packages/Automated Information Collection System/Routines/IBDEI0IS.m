IBDEI0IS ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8202,0)
 ;;=I83.012^^65^523^8
 ;;^UTILITY(U,$J,358.3,8202,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8202,1,3,0)
 ;;=3^Varicose Veins Right Lower Extrem w/ Ulcer of Calf
 ;;^UTILITY(U,$J,358.3,8202,1,4,0)
 ;;=4^I83.012
 ;;^UTILITY(U,$J,358.3,8202,2)
 ;;=^5007974
 ;;^UTILITY(U,$J,358.3,8203,0)
 ;;=I83.013^^65^523^9
 ;;^UTILITY(U,$J,358.3,8203,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8203,1,3,0)
 ;;=3^Varicose Veins Right Lower Extrem w/ Ulcer of Ankle
 ;;^UTILITY(U,$J,358.3,8203,1,4,0)
 ;;=4^I83.013
 ;;^UTILITY(U,$J,358.3,8203,2)
 ;;=^5007975
 ;;^UTILITY(U,$J,358.3,8204,0)
 ;;=I83.014^^65^523^10
 ;;^UTILITY(U,$J,358.3,8204,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8204,1,3,0)
 ;;=3^Varicose Veins Right Lower Extrem w/ Ulcer of Heel/Midfoot
 ;;^UTILITY(U,$J,358.3,8204,1,4,0)
 ;;=4^I83.014
 ;;^UTILITY(U,$J,358.3,8204,2)
 ;;=^5007976
 ;;^UTILITY(U,$J,358.3,8205,0)
 ;;=I83.11^^65^523^6
 ;;^UTILITY(U,$J,358.3,8205,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8205,1,3,0)
 ;;=3^Varicose Veins Right Lower Extrem w/ Inflammation
 ;;^UTILITY(U,$J,358.3,8205,1,4,0)
 ;;=4^I83.11
 ;;^UTILITY(U,$J,358.3,8205,2)
 ;;=^5007988
 ;;^UTILITY(U,$J,358.3,8206,0)
 ;;=I83.022^^65^523^3
 ;;^UTILITY(U,$J,358.3,8206,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8206,1,3,0)
 ;;=3^Varicose Veins Left Lower Extrem w/ Ulcer of Calf
 ;;^UTILITY(U,$J,358.3,8206,1,4,0)
 ;;=4^I83.022
 ;;^UTILITY(U,$J,358.3,8206,2)
 ;;=^5007981
 ;;^UTILITY(U,$J,358.3,8207,0)
 ;;=I83.023^^65^523^4
 ;;^UTILITY(U,$J,358.3,8207,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8207,1,3,0)
 ;;=3^Varicose Veins Left Lower Extrem w/ Ulcer of Ankle
 ;;^UTILITY(U,$J,358.3,8207,1,4,0)
 ;;=4^I83.023
 ;;^UTILITY(U,$J,358.3,8207,2)
 ;;=^5007982
 ;;^UTILITY(U,$J,358.3,8208,0)
 ;;=I83.024^^65^523^5
 ;;^UTILITY(U,$J,358.3,8208,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8208,1,3,0)
 ;;=3^Varicose Veins Left Lower Extrem w/ Ulcer of Heel/Midfoot
 ;;^UTILITY(U,$J,358.3,8208,1,4,0)
 ;;=4^I83.024
 ;;^UTILITY(U,$J,358.3,8208,2)
 ;;=^5007983
 ;;^UTILITY(U,$J,358.3,8209,0)
 ;;=I83.12^^65^523^1
 ;;^UTILITY(U,$J,358.3,8209,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8209,1,3,0)
 ;;=3^Varicose Veins Left Lower Extrem w/ Inflammation
 ;;^UTILITY(U,$J,358.3,8209,1,4,0)
 ;;=4^I83.12
 ;;^UTILITY(U,$J,358.3,8209,2)
 ;;=^5007989
 ;;^UTILITY(U,$J,358.3,8210,0)
 ;;=I87.2^^65^523^11
 ;;^UTILITY(U,$J,358.3,8210,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8210,1,3,0)
 ;;=3^Venous Insufficiency
 ;;^UTILITY(U,$J,358.3,8210,1,4,0)
 ;;=4^I87.2
 ;;^UTILITY(U,$J,358.3,8210,2)
 ;;=^5008047
 ;;^UTILITY(U,$J,358.3,8211,0)
 ;;=L85.3^^65^524^1
 ;;^UTILITY(U,$J,358.3,8211,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8211,1,3,0)
 ;;=3^Xerosis Cutis
 ;;^UTILITY(U,$J,358.3,8211,1,4,0)
 ;;=4^L85.3
 ;;^UTILITY(U,$J,358.3,8211,2)
 ;;=^5009323
 ;;^UTILITY(U,$J,358.3,8212,0)
 ;;=L03.113^^65^525^34
 ;;^UTILITY(U,$J,358.3,8212,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8212,1,3,0)
 ;;=3^Cellulitis of Right Upper Limb
 ;;^UTILITY(U,$J,358.3,8212,1,4,0)
 ;;=4^L03.113
 ;;^UTILITY(U,$J,358.3,8212,2)
 ;;=^5009033
 ;;^UTILITY(U,$J,358.3,8213,0)
 ;;=L03.114^^65^525^29
 ;;^UTILITY(U,$J,358.3,8213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8213,1,3,0)
 ;;=3^Cellulitis of Left Upper Limb
 ;;^UTILITY(U,$J,358.3,8213,1,4,0)
 ;;=4^L03.114
 ;;^UTILITY(U,$J,358.3,8213,2)
 ;;=^5009034
 ;;^UTILITY(U,$J,358.3,8214,0)
 ;;=L03.317^^65^525^21

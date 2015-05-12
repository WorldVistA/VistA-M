IBDEI038 ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3880,0)
 ;;=I82.A12^^19^180^11
 ;;^UTILITY(U,$J,358.3,3880,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3880,1,3,0)
 ;;=3^AC Embolism & Thrombosis Lt Axillary Vein
 ;;^UTILITY(U,$J,358.3,3880,1,4,0)
 ;;=4^I82.A12
 ;;^UTILITY(U,$J,358.3,3880,2)
 ;;=^5007943
 ;;^UTILITY(U,$J,358.3,3881,0)
 ;;=I82.A13^^19^180^1
 ;;^UTILITY(U,$J,358.3,3881,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3881,1,3,0)
 ;;=3^AC Embolism & Thrombosis Bilateral Axillary Vein
 ;;^UTILITY(U,$J,358.3,3881,1,4,0)
 ;;=4^I82.A13
 ;;^UTILITY(U,$J,358.3,3881,2)
 ;;=^5007944
 ;;^UTILITY(U,$J,358.3,3882,0)
 ;;=I82.B11^^19^180^28
 ;;^UTILITY(U,$J,358.3,3882,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3882,1,3,0)
 ;;=3^AC Embolism & Thrombosis Rt Subclavian Vein
 ;;^UTILITY(U,$J,358.3,3882,1,4,0)
 ;;=4^I82.B11
 ;;^UTILITY(U,$J,358.3,3882,2)
 ;;=^5007950
 ;;^UTILITY(U,$J,358.3,3883,0)
 ;;=I82.B12^^19^180^17
 ;;^UTILITY(U,$J,358.3,3883,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3883,1,3,0)
 ;;=3^AC Embolism & Thrombosis Lt Subclavian Vein
 ;;^UTILITY(U,$J,358.3,3883,1,4,0)
 ;;=4^I82.B12
 ;;^UTILITY(U,$J,358.3,3883,2)
 ;;=^5007951
 ;;^UTILITY(U,$J,358.3,3884,0)
 ;;=I82.B13^^19^180^7
 ;;^UTILITY(U,$J,358.3,3884,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3884,1,3,0)
 ;;=3^AC Embolism & Thrombosis Bilateral Subclavian Vein
 ;;^UTILITY(U,$J,358.3,3884,1,4,0)
 ;;=4^I82.B13
 ;;^UTILITY(U,$J,358.3,3884,2)
 ;;=^5007952
 ;;^UTILITY(U,$J,358.3,3885,0)
 ;;=I82.C11^^19^180^25
 ;;^UTILITY(U,$J,358.3,3885,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3885,1,3,0)
 ;;=3^AC Embolism & Thrombosis Rt Internal Jugular Vein
 ;;^UTILITY(U,$J,358.3,3885,1,4,0)
 ;;=4^I82.C11
 ;;^UTILITY(U,$J,358.3,3885,2)
 ;;=^5007958
 ;;^UTILITY(U,$J,358.3,3886,0)
 ;;=I82.C12^^19^180^14
 ;;^UTILITY(U,$J,358.3,3886,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3886,1,3,0)
 ;;=3^AC Embolism & Thrombosis Lt Internal Jugular Vein
 ;;^UTILITY(U,$J,358.3,3886,1,4,0)
 ;;=4^I82.C12
 ;;^UTILITY(U,$J,358.3,3886,2)
 ;;=^5007959
 ;;^UTILITY(U,$J,358.3,3887,0)
 ;;=I82.C13^^19^180^4
 ;;^UTILITY(U,$J,358.3,3887,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3887,1,3,0)
 ;;=3^AC Embolism & Thrombosis Bilateral Internal Jugular Vein
 ;;^UTILITY(U,$J,358.3,3887,1,4,0)
 ;;=4^I82.C13
 ;;^UTILITY(U,$J,358.3,3887,2)
 ;;=^5007960
 ;;^UTILITY(U,$J,358.3,3888,0)
 ;;=I82.890^^19^180^21
 ;;^UTILITY(U,$J,358.3,3888,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3888,1,3,0)
 ;;=3^AC Embolism & Thrombosis Oth Spec Veins
 ;;^UTILITY(U,$J,358.3,3888,1,4,0)
 ;;=4^I82.890
 ;;^UTILITY(U,$J,358.3,3888,2)
 ;;=^5007938
 ;;^UTILITY(U,$J,358.3,3889,0)
 ;;=I83.011^^19^180^158
 ;;^UTILITY(U,$J,358.3,3889,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3889,1,3,0)
 ;;=3^Varicose Veins Rt Lower Extrem w/ Ulcer of Thigh
 ;;^UTILITY(U,$J,358.3,3889,1,4,0)
 ;;=4^I83.011
 ;;^UTILITY(U,$J,358.3,3889,2)
 ;;=^5007973
 ;;^UTILITY(U,$J,358.3,3890,0)
 ;;=I83.012^^19^180^159
 ;;^UTILITY(U,$J,358.3,3890,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3890,1,3,0)
 ;;=3^Varicose Veins Rt Lower Extrem w/ Ulcer of Calf
 ;;^UTILITY(U,$J,358.3,3890,1,4,0)
 ;;=4^I83.012
 ;;^UTILITY(U,$J,358.3,3890,2)
 ;;=^5007974
 ;;^UTILITY(U,$J,358.3,3891,0)
 ;;=I83.013^^19^180^160
 ;;^UTILITY(U,$J,358.3,3891,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3891,1,3,0)
 ;;=3^Varicose Veins Rt Lower Extrem w/ Ulcer of Ankle
 ;;^UTILITY(U,$J,358.3,3891,1,4,0)
 ;;=4^I83.013
 ;;^UTILITY(U,$J,358.3,3891,2)
 ;;=^5007975
 ;;^UTILITY(U,$J,358.3,3892,0)
 ;;=I83.014^^19^180^161
 ;;^UTILITY(U,$J,358.3,3892,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3892,1,3,0)
 ;;=3^Varicose Veins Rt Lower Extrem w/ Ulcer of Heel & Midfoot
 ;;^UTILITY(U,$J,358.3,3892,1,4,0)
 ;;=4^I83.014
 ;;^UTILITY(U,$J,358.3,3892,2)
 ;;=^5007976
 ;;^UTILITY(U,$J,358.3,3893,0)
 ;;=I83.015^^19^180^162
 ;;^UTILITY(U,$J,358.3,3893,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3893,1,3,0)
 ;;=3^Varicose Veins Rt Lower Extrem w/ Ulcer of Oth Part of Foot
 ;;^UTILITY(U,$J,358.3,3893,1,4,0)
 ;;=4^I83.015
 ;;^UTILITY(U,$J,358.3,3893,2)
 ;;=^5007977
 ;;^UTILITY(U,$J,358.3,3894,0)
 ;;=I83.023^^19^180^147
 ;;^UTILITY(U,$J,358.3,3894,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3894,1,3,0)
 ;;=3^Varicose Veins Lt Lower Extrem w/ Ulcer of Ankle
 ;;^UTILITY(U,$J,358.3,3894,1,4,0)
 ;;=4^I83.023
 ;;^UTILITY(U,$J,358.3,3894,2)
 ;;=^5007982
 ;;^UTILITY(U,$J,358.3,3895,0)
 ;;=I83.024^^19^180^148
 ;;^UTILITY(U,$J,358.3,3895,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3895,1,3,0)
 ;;=3^Varicose Veins Lt Lower Extrem w/ Ulcer of Heel & Midfoot
 ;;^UTILITY(U,$J,358.3,3895,1,4,0)
 ;;=4^I83.024
 ;;^UTILITY(U,$J,358.3,3895,2)
 ;;=^5007983
 ;;^UTILITY(U,$J,358.3,3896,0)
 ;;=I83.025^^19^180^149
 ;;^UTILITY(U,$J,358.3,3896,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3896,1,3,0)
 ;;=3^Varicose Veins Lt Lower Extrem w/ Ulcer of Oth Part of Foot
 ;;^UTILITY(U,$J,358.3,3896,1,4,0)
 ;;=4^I83.025
 ;;^UTILITY(U,$J,358.3,3896,2)
 ;;=^5007984
 ;;^UTILITY(U,$J,358.3,3897,0)
 ;;=I83.021^^19^180^150
 ;;^UTILITY(U,$J,358.3,3897,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3897,1,3,0)
 ;;=3^Varicose Veins Lt Lower Extrem w/ Ulcer of Thigh
 ;;^UTILITY(U,$J,358.3,3897,1,4,0)
 ;;=4^I83.021
 ;;^UTILITY(U,$J,358.3,3897,2)
 ;;=^5007980
 ;;^UTILITY(U,$J,358.3,3898,0)
 ;;=I83.022^^19^180^151
 ;;^UTILITY(U,$J,358.3,3898,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3898,1,3,0)
 ;;=3^Varicose Veins Lt Lower Extrem w/ Ulcer of Calf
 ;;^UTILITY(U,$J,358.3,3898,1,4,0)
 ;;=4^I83.022
 ;;^UTILITY(U,$J,358.3,3898,2)
 ;;=^5007981
 ;;^UTILITY(U,$J,358.3,3899,0)
 ;;=I83.028^^19^180^152
 ;;^UTILITY(U,$J,358.3,3899,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3899,1,3,0)
 ;;=3^Varicose Veins Lt Lower Extrem w/ Ulcer of Oth Part Lower Leg
 ;;^UTILITY(U,$J,358.3,3899,1,4,0)
 ;;=4^I83.028
 ;;^UTILITY(U,$J,358.3,3899,2)
 ;;=^5007985
 ;;^UTILITY(U,$J,358.3,3900,0)
 ;;=I83.11^^19^180^153
 ;;^UTILITY(U,$J,358.3,3900,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3900,1,3,0)
 ;;=3^Varicose Veins Rt Lower Extrem w/ Inflammation
 ;;^UTILITY(U,$J,358.3,3900,1,4,0)
 ;;=4^I83.11
 ;;^UTILITY(U,$J,358.3,3900,2)
 ;;=^5007988
 ;;^UTILITY(U,$J,358.3,3901,0)
 ;;=I83.12^^19^180^140
 ;;^UTILITY(U,$J,358.3,3901,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3901,1,3,0)
 ;;=3^Varicose Veins Lt Lower Extrem w/ Inflammation
 ;;^UTILITY(U,$J,358.3,3901,1,4,0)
 ;;=4^I83.12
 ;;^UTILITY(U,$J,358.3,3901,2)
 ;;=^5007989
 ;;^UTILITY(U,$J,358.3,3902,0)
 ;;=I83.213^^19^180^156
 ;;^UTILITY(U,$J,358.3,3902,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3902,1,3,0)
 ;;=3^Varicose Veins Rt Lower Extrem w/ Ulc of Ankle & Inflammation
 ;;^UTILITY(U,$J,358.3,3902,1,4,0)
 ;;=4^I83.213
 ;;^UTILITY(U,$J,358.3,3902,2)
 ;;=^5007999
 ;;^UTILITY(U,$J,358.3,3903,0)
 ;;=I83.214^^19^180^157
 ;;^UTILITY(U,$J,358.3,3903,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3903,1,3,0)
 ;;=3^Varicose Veins Rt Lower Extrem w/ Ulc of Heel & Midfoot & Inflammation
 ;;^UTILITY(U,$J,358.3,3903,1,4,0)
 ;;=4^I83.214
 ;;^UTILITY(U,$J,358.3,3903,2)
 ;;=^5008000
 ;;^UTILITY(U,$J,358.3,3904,0)
 ;;=I83.215^^19^180^154
 ;;^UTILITY(U,$J,358.3,3904,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3904,1,3,0)
 ;;=3^Varicose Veins Rt Lower Extrem w/ Ulc Oth Part of Foot & Inflammation
 ;;^UTILITY(U,$J,358.3,3904,1,4,0)
 ;;=4^I83.215
 ;;^UTILITY(U,$J,358.3,3904,2)
 ;;=^5008001
 ;;^UTILITY(U,$J,358.3,3905,0)
 ;;=I83.218^^19^180^155
 ;;^UTILITY(U,$J,358.3,3905,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3905,1,3,0)
 ;;=3^Varicose Veins Rt Lower Extrem w/ Ulc Oth Part Lower Extrem & Inflammation
 ;;^UTILITY(U,$J,358.3,3905,1,4,0)
 ;;=4^I83.218
 ;;^UTILITY(U,$J,358.3,3905,2)
 ;;=^5008002
 ;;^UTILITY(U,$J,358.3,3906,0)
 ;;=I83.221^^19^180^141
 ;;^UTILITY(U,$J,358.3,3906,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3906,1,3,0)
 ;;=3^Varicose Veins Lt Lower Extrem w/ Ulc of Thigh & Inflammation
 ;;^UTILITY(U,$J,358.3,3906,1,4,0)
 ;;=4^I83.221
 ;;^UTILITY(U,$J,358.3,3906,2)
 ;;=^5008004
 ;;^UTILITY(U,$J,358.3,3907,0)
 ;;=I83.222^^19^180^142
 ;;^UTILITY(U,$J,358.3,3907,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3907,1,3,0)
 ;;=3^Varicose Veins Lt Lower Extrem w/ Ulc of Calf & Inflammation
 ;;^UTILITY(U,$J,358.3,3907,1,4,0)
 ;;=4^I83.222
 ;;^UTILITY(U,$J,358.3,3907,2)
 ;;=^5008005
 ;;^UTILITY(U,$J,358.3,3908,0)
 ;;=I83.223^^19^180^143
 ;;^UTILITY(U,$J,358.3,3908,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3908,1,3,0)
 ;;=3^Varicose Veins Lt Lower Extrem w/ Ulc of Ankle & Inflammation
 ;;^UTILITY(U,$J,358.3,3908,1,4,0)
 ;;=4^I83.223
 ;;^UTILITY(U,$J,358.3,3908,2)
 ;;=^5008006
 ;;^UTILITY(U,$J,358.3,3909,0)
 ;;=I83.224^^19^180^144
 ;;^UTILITY(U,$J,358.3,3909,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3909,1,3,0)
 ;;=3^Varicose Veins Lt Lower Extrem w/ Ulc of Heel & Midfoot & Inflammation
 ;;^UTILITY(U,$J,358.3,3909,1,4,0)
 ;;=4^I83.224
 ;;^UTILITY(U,$J,358.3,3909,2)
 ;;=^5008007
 ;;^UTILITY(U,$J,358.3,3910,0)
 ;;=I83.225^^19^180^145
 ;;^UTILITY(U,$J,358.3,3910,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3910,1,3,0)
 ;;=3^Varicose Veins Lt Lower Extrem w/ Ulc of Oth Part of Foot & Inflammation
 ;;^UTILITY(U,$J,358.3,3910,1,4,0)
 ;;=4^I83.225
 ;;^UTILITY(U,$J,358.3,3910,2)
 ;;=^5008008
 ;;^UTILITY(U,$J,358.3,3911,0)
 ;;=I83.228^^19^180^146
 ;;^UTILITY(U,$J,358.3,3911,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3911,1,3,0)
 ;;=3^Varicose Veins Lt Lower Extrem w/ Ulc of Oth Part Lower Extrem & Inflammation
 ;;^UTILITY(U,$J,358.3,3911,1,4,0)
 ;;=4^I83.228
 ;;^UTILITY(U,$J,358.3,3911,2)
 ;;=^5008009
 ;;^UTILITY(U,$J,358.3,3912,0)
 ;;=I83.91^^19^180^41
 ;;^UTILITY(U,$J,358.3,3912,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3912,1,3,0)
 ;;=3^Asymptomatic Varicose Veins Rt Lower Extremity
 ;;^UTILITY(U,$J,358.3,3912,1,4,0)
 ;;=4^I83.91
 ;;^UTILITY(U,$J,358.3,3912,2)
 ;;=^5008020
 ;;^UTILITY(U,$J,358.3,3913,0)
 ;;=I83.92^^19^180^40

IBDEI0RB ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,12296,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer Rt LL Limited to Brkdwn of Skin
 ;;^UTILITY(U,$J,358.3,12296,1,4,0)
 ;;=4^L97.911
 ;;^UTILITY(U,$J,358.3,12296,2)
 ;;=^5133679
 ;;^UTILITY(U,$J,358.3,12297,0)
 ;;=L97.912^^49^596^116
 ;;^UTILITY(U,$J,358.3,12297,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12297,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer Rt LL w/ Fat Layer Exposed
 ;;^UTILITY(U,$J,358.3,12297,1,4,0)
 ;;=4^L97.912
 ;;^UTILITY(U,$J,358.3,12297,2)
 ;;=^5133681
 ;;^UTILITY(U,$J,358.3,12298,0)
 ;;=L97.913^^49^596^118
 ;;^UTILITY(U,$J,358.3,12298,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12298,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer Rt LL w/ Necrosis of Msl
 ;;^UTILITY(U,$J,358.3,12298,1,4,0)
 ;;=4^L97.913
 ;;^UTILITY(U,$J,358.3,12298,2)
 ;;=^5133683
 ;;^UTILITY(U,$J,358.3,12299,0)
 ;;=L97.914^^49^596^119
 ;;^UTILITY(U,$J,358.3,12299,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12299,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer Rt LL w/ Necrosis of Bone
 ;;^UTILITY(U,$J,358.3,12299,1,4,0)
 ;;=4^L97.914
 ;;^UTILITY(U,$J,358.3,12299,2)
 ;;=^5133685
 ;;^UTILITY(U,$J,358.3,12300,0)
 ;;=L97.915^^49^596^117
 ;;^UTILITY(U,$J,358.3,12300,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12300,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer Rt LL w/ Msl Invl w/o Necrosis
 ;;^UTILITY(U,$J,358.3,12300,1,4,0)
 ;;=4^L97.915
 ;;^UTILITY(U,$J,358.3,12300,2)
 ;;=^5151487
 ;;^UTILITY(U,$J,358.3,12301,0)
 ;;=L97.916^^49^596^115
 ;;^UTILITY(U,$J,358.3,12301,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12301,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer Rt LL w/ Bone Invl w/o Necrosis
 ;;^UTILITY(U,$J,358.3,12301,1,4,0)
 ;;=4^L97.916
 ;;^UTILITY(U,$J,358.3,12301,2)
 ;;=^5151488
 ;;^UTILITY(U,$J,358.3,12302,0)
 ;;=L97.918^^49^596^120
 ;;^UTILITY(U,$J,358.3,12302,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12302,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer Rt LL w/ Oth Severity
 ;;^UTILITY(U,$J,358.3,12302,1,4,0)
 ;;=4^L97.918
 ;;^UTILITY(U,$J,358.3,12302,2)
 ;;=^5151489
 ;;^UTILITY(U,$J,358.3,12303,0)
 ;;=L97.111^^49^596^122
 ;;^UTILITY(U,$J,358.3,12303,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12303,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer Rt Thigh Limited to Brkdwn of Skin
 ;;^UTILITY(U,$J,358.3,12303,1,4,0)
 ;;=4^L97.111
 ;;^UTILITY(U,$J,358.3,12303,2)
 ;;=^5009485
 ;;^UTILITY(U,$J,358.3,12304,0)
 ;;=L97.112^^49^596^124
 ;;^UTILITY(U,$J,358.3,12304,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12304,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer Rt Thigh w/ Fat Layer Exposed
 ;;^UTILITY(U,$J,358.3,12304,1,4,0)
 ;;=4^L97.112
 ;;^UTILITY(U,$J,358.3,12304,2)
 ;;=^5009486
 ;;^UTILITY(U,$J,358.3,12305,0)
 ;;=L97.113^^49^596^126
 ;;^UTILITY(U,$J,358.3,12305,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12305,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer Rt Thigh w/ Necrosis of Msl
 ;;^UTILITY(U,$J,358.3,12305,1,4,0)
 ;;=4^L97.113
 ;;^UTILITY(U,$J,358.3,12305,2)
 ;;=^5009487
 ;;^UTILITY(U,$J,358.3,12306,0)
 ;;=L97.114^^49^596^127
 ;;^UTILITY(U,$J,358.3,12306,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12306,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer Rt Thigh w/ Necrosis of Bone
 ;;^UTILITY(U,$J,358.3,12306,1,4,0)
 ;;=4^L97.114
 ;;^UTILITY(U,$J,358.3,12306,2)
 ;;=^5009488
 ;;^UTILITY(U,$J,358.3,12307,0)
 ;;=L97.115^^49^596^125
 ;;^UTILITY(U,$J,358.3,12307,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12307,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer Rt Thigh w/ Msl Invl w/o Necrosis
 ;;^UTILITY(U,$J,358.3,12307,1,4,0)
 ;;=4^L97.115

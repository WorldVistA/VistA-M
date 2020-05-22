IBDEI19R ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,20309,1,3,0)
 ;;=3^Fatigue fracture of vertebra, cervicothoracic region, sqla
 ;;^UTILITY(U,$J,358.3,20309,1,4,0)
 ;;=4^M48.43XS
 ;;^UTILITY(U,$J,358.3,20309,2)
 ;;=^5012138
 ;;^UTILITY(U,$J,358.3,20310,0)
 ;;=M48.46XS^^93^1001^13
 ;;^UTILITY(U,$J,358.3,20310,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20310,1,3,0)
 ;;=3^Fatigue fracture of vertebra, lumbar region, sqla
 ;;^UTILITY(U,$J,358.3,20310,1,4,0)
 ;;=4^M48.46XS
 ;;^UTILITY(U,$J,358.3,20310,2)
 ;;=^5012150
 ;;^UTILITY(U,$J,358.3,20311,0)
 ;;=M48.47XS^^93^1001^14
 ;;^UTILITY(U,$J,358.3,20311,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20311,1,3,0)
 ;;=3^Fatigue fracture of vertebra, lumbosacral region, sqla
 ;;^UTILITY(U,$J,358.3,20311,1,4,0)
 ;;=4^M48.47XS
 ;;^UTILITY(U,$J,358.3,20311,2)
 ;;=^5012154
 ;;^UTILITY(U,$J,358.3,20312,0)
 ;;=M48.41XS^^93^1001^15
 ;;^UTILITY(U,$J,358.3,20312,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20312,1,3,0)
 ;;=3^Fatigue fracture of vertebra, occipt-atlan-ax region, sqla
 ;;^UTILITY(U,$J,358.3,20312,1,4,0)
 ;;=4^M48.41XS
 ;;^UTILITY(U,$J,358.3,20312,2)
 ;;=^5012130
 ;;^UTILITY(U,$J,358.3,20313,0)
 ;;=M48.48XS^^93^1001^16
 ;;^UTILITY(U,$J,358.3,20313,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20313,1,3,0)
 ;;=3^Fatigue fracture of vertebra, sacr/sacrocygl region, sqla
 ;;^UTILITY(U,$J,358.3,20313,1,4,0)
 ;;=4^M48.48XS
 ;;^UTILITY(U,$J,358.3,20313,2)
 ;;=^5012158
 ;;^UTILITY(U,$J,358.3,20314,0)
 ;;=M48.44XS^^93^1001^17
 ;;^UTILITY(U,$J,358.3,20314,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20314,1,3,0)
 ;;=3^Fatigue fracture of vertebra, thoracic region, sqla
 ;;^UTILITY(U,$J,358.3,20314,1,4,0)
 ;;=4^M48.44XS
 ;;^UTILITY(U,$J,358.3,20314,2)
 ;;=^5012142
 ;;^UTILITY(U,$J,358.3,20315,0)
 ;;=M48.45XS^^93^1001^18
 ;;^UTILITY(U,$J,358.3,20315,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20315,1,3,0)
 ;;=3^Fatigue fracture of vertebra, thoracolumbar region, sqla
 ;;^UTILITY(U,$J,358.3,20315,1,4,0)
 ;;=4^M48.45XS
 ;;^UTILITY(U,$J,358.3,20315,2)
 ;;=^5012146
 ;;^UTILITY(U,$J,358.3,20316,0)
 ;;=S12.041S^^93^1001^27
 ;;^UTILITY(U,$J,358.3,20316,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20316,1,3,0)
 ;;=3^Nondisp lateral mass fx first cervcal vertebra, sequela
 ;;^UTILITY(U,$J,358.3,20316,1,4,0)
 ;;=4^S12.041S
 ;;^UTILITY(U,$J,358.3,20316,2)
 ;;=^5021592
 ;;^UTILITY(U,$J,358.3,20317,0)
 ;;=S12.031S^^93^1001^28
 ;;^UTILITY(U,$J,358.3,20317,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20317,1,3,0)
 ;;=3^Nondisp posterior arch fx first cervcal vertebra, sequela
 ;;^UTILITY(U,$J,358.3,20317,1,4,0)
 ;;=4^S12.031S
 ;;^UTILITY(U,$J,358.3,20317,2)
 ;;=^5021580
 ;;^UTILITY(U,$J,358.3,20318,0)
 ;;=S32.051S^^93^1001^37
 ;;^UTILITY(U,$J,358.3,20318,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20318,1,3,0)
 ;;=3^Stable burst fracture of fifth lumbar vertebra, sequela
 ;;^UTILITY(U,$J,358.3,20318,1,4,0)
 ;;=4^S32.051S
 ;;^UTILITY(U,$J,358.3,20318,2)
 ;;=^5024502
 ;;^UTILITY(U,$J,358.3,20319,0)
 ;;=S12.01XS^^93^1001^38
 ;;^UTILITY(U,$J,358.3,20319,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20319,1,3,0)
 ;;=3^Stable burst fracture of first cervical vertebra, sequela
 ;;^UTILITY(U,$J,358.3,20319,1,4,0)
 ;;=4^S12.01XS
 ;;^UTILITY(U,$J,358.3,20319,2)
 ;;=^5021562
 ;;^UTILITY(U,$J,358.3,20320,0)
 ;;=S32.011S^^93^1001^39
 ;;^UTILITY(U,$J,358.3,20320,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20320,1,3,0)
 ;;=3^Stable burst fracture of first lumbar vertebra, sequela

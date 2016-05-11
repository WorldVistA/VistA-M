IBDEI0IQ ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8705,1,3,0)
 ;;=3^Keratoconjunctivitis,Left Eye,Unspec
 ;;^UTILITY(U,$J,358.3,8705,1,4,0)
 ;;=4^H16.202
 ;;^UTILITY(U,$J,358.3,8705,2)
 ;;=^5004918
 ;;^UTILITY(U,$J,358.3,8706,0)
 ;;=H16.291^^41^468^102
 ;;^UTILITY(U,$J,358.3,8706,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8706,1,3,0)
 ;;=3^Keratoconjunctivitis,Right Eye NEC
 ;;^UTILITY(U,$J,358.3,8706,1,4,0)
 ;;=4^H16.291
 ;;^UTILITY(U,$J,358.3,8706,2)
 ;;=^5004944
 ;;^UTILITY(U,$J,358.3,8707,0)
 ;;=H16.292^^41^468^100
 ;;^UTILITY(U,$J,358.3,8707,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8707,1,3,0)
 ;;=3^Keratoconjunctivitis,Left Eye NEC
 ;;^UTILITY(U,$J,358.3,8707,1,4,0)
 ;;=4^H16.292
 ;;^UTILITY(U,$J,358.3,8707,2)
 ;;=^5133471
 ;;^UTILITY(U,$J,358.3,8708,0)
 ;;=H16.401^^41^468^54
 ;;^UTILITY(U,$J,358.3,8708,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8708,1,3,0)
 ;;=3^Corneal Neovascularization,Right Eye,Unspec
 ;;^UTILITY(U,$J,358.3,8708,1,4,0)
 ;;=4^H16.401
 ;;^UTILITY(U,$J,358.3,8708,2)
 ;;=^5004965
 ;;^UTILITY(U,$J,358.3,8709,0)
 ;;=H16.402^^41^468^53
 ;;^UTILITY(U,$J,358.3,8709,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8709,1,3,0)
 ;;=3^Corneal Neovascularization,Left Eye,Unspec
 ;;^UTILITY(U,$J,358.3,8709,1,4,0)
 ;;=4^H16.402
 ;;^UTILITY(U,$J,358.3,8709,2)
 ;;=^5004966
 ;;^UTILITY(U,$J,358.3,8710,0)
 ;;=H16.421^^41^468^123
 ;;^UTILITY(U,$J,358.3,8710,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8710,1,3,0)
 ;;=3^Pannus Corneal,Right Eye
 ;;^UTILITY(U,$J,358.3,8710,1,4,0)
 ;;=4^H16.421
 ;;^UTILITY(U,$J,358.3,8710,2)
 ;;=^5004972
 ;;^UTILITY(U,$J,358.3,8711,0)
 ;;=H16.422^^41^468^122
 ;;^UTILITY(U,$J,358.3,8711,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8711,1,3,0)
 ;;=3^Pannus Corneal,Left Eye
 ;;^UTILITY(U,$J,358.3,8711,1,4,0)
 ;;=4^H16.422
 ;;^UTILITY(U,$J,358.3,8711,2)
 ;;=^5004973
 ;;^UTILITY(U,$J,358.3,8712,0)
 ;;=H17.9^^41^468^56
 ;;^UTILITY(U,$J,358.3,8712,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8712,1,3,0)
 ;;=3^Corneal Scar & Opacity,Unspec
 ;;^UTILITY(U,$J,358.3,8712,1,4,0)
 ;;=4^H17.9
 ;;^UTILITY(U,$J,358.3,8712,2)
 ;;=^5005003
 ;;^UTILITY(U,$J,358.3,8713,0)
 ;;=H17.89^^41^468^55
 ;;^UTILITY(U,$J,358.3,8713,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8713,1,3,0)
 ;;=3^Corneal Scar & Opacity NEC
 ;;^UTILITY(U,$J,358.3,8713,1,4,0)
 ;;=4^H17.89
 ;;^UTILITY(U,$J,358.3,8713,2)
 ;;=^5005002
 ;;^UTILITY(U,$J,358.3,8714,0)
 ;;=H17.821^^41^468^129
 ;;^UTILITY(U,$J,358.3,8714,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8714,1,3,0)
 ;;=3^Peripheral Opacity of Cornea,Right Eye
 ;;^UTILITY(U,$J,358.3,8714,1,4,0)
 ;;=4^H17.821
 ;;^UTILITY(U,$J,358.3,8714,2)
 ;;=^5004998
 ;;^UTILITY(U,$J,358.3,8715,0)
 ;;=H17.822^^41^468^128
 ;;^UTILITY(U,$J,358.3,8715,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8715,1,3,0)
 ;;=3^Peripheral Opacity of Cornea,Left Eye
 ;;^UTILITY(U,$J,358.3,8715,1,4,0)
 ;;=4^H17.822
 ;;^UTILITY(U,$J,358.3,8715,2)
 ;;=^5004999
 ;;^UTILITY(U,$J,358.3,8716,0)
 ;;=H17.11^^41^468^28
 ;;^UTILITY(U,$J,358.3,8716,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8716,1,3,0)
 ;;=3^Central Corneal Opacity,Right Eye
 ;;^UTILITY(U,$J,358.3,8716,1,4,0)
 ;;=4^H17.11
 ;;^UTILITY(U,$J,358.3,8716,2)
 ;;=^5004991
 ;;^UTILITY(U,$J,358.3,8717,0)
 ;;=H17.12^^41^468^27
 ;;^UTILITY(U,$J,358.3,8717,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8717,1,3,0)
 ;;=3^Central Corneal Opacity,Left Eye
 ;;^UTILITY(U,$J,358.3,8717,1,4,0)
 ;;=4^H17.12
 ;;^UTILITY(U,$J,358.3,8717,2)
 ;;=^5004992
 ;;^UTILITY(U,$J,358.3,8718,0)
 ;;=H18.001^^41^468^49
 ;;^UTILITY(U,$J,358.3,8718,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8718,1,3,0)
 ;;=3^Corneal Deposit,Right Eye,Unspec

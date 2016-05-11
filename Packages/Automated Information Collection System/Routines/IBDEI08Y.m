IBDEI08Y ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3904,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3904,1,3,0)
 ;;=3^Noncompliance w/ Med Regimen d/t Other Reasons
 ;;^UTILITY(U,$J,358.3,3904,1,4,0)
 ;;=4^Z91.128
 ;;^UTILITY(U,$J,358.3,3904,2)
 ;;=^5063613
 ;;^UTILITY(U,$J,358.3,3905,0)
 ;;=Z91.130^^18^224^76
 ;;^UTILITY(U,$J,358.3,3905,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3905,1,3,0)
 ;;=3^Noncompliance w/ Med Regimen d/t Age-Related Debility
 ;;^UTILITY(U,$J,358.3,3905,1,4,0)
 ;;=4^Z91.130
 ;;^UTILITY(U,$J,358.3,3905,2)
 ;;=^5063614
 ;;^UTILITY(U,$J,358.3,3906,0)
 ;;=Z91.138^^18^224^75
 ;;^UTILITY(U,$J,358.3,3906,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3906,1,3,0)
 ;;=3^Noncompliance w/ Med Regimen Unintentional
 ;;^UTILITY(U,$J,358.3,3906,1,4,0)
 ;;=4^Z91.138
 ;;^UTILITY(U,$J,358.3,3906,2)
 ;;=^5063615
 ;;^UTILITY(U,$J,358.3,3907,0)
 ;;=Z91.19^^18^224^79
 ;;^UTILITY(U,$J,358.3,3907,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3907,1,3,0)
 ;;=3^Noncompliance w/ Medical Treatment/Regimen
 ;;^UTILITY(U,$J,358.3,3907,1,4,0)
 ;;=4^Z91.19
 ;;^UTILITY(U,$J,358.3,3907,2)
 ;;=^5063618
 ;;^UTILITY(U,$J,358.3,3908,0)
 ;;=Z91.15^^18^224^80
 ;;^UTILITY(U,$J,358.3,3908,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3908,1,3,0)
 ;;=3^Noncompliance w/ Renal Dialysis
 ;;^UTILITY(U,$J,358.3,3908,1,4,0)
 ;;=4^Z91.15
 ;;^UTILITY(U,$J,358.3,3908,2)
 ;;=^5063617
 ;;^UTILITY(U,$J,358.3,3909,0)
 ;;=Z57.2^^18^224^85
 ;;^UTILITY(U,$J,358.3,3909,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3909,1,3,0)
 ;;=3^Occupational Exposure to Dust
 ;;^UTILITY(U,$J,358.3,3909,1,4,0)
 ;;=4^Z57.2
 ;;^UTILITY(U,$J,358.3,3909,2)
 ;;=^5063120
 ;;^UTILITY(U,$J,358.3,3910,0)
 ;;=Z57.31^^18^224^91
 ;;^UTILITY(U,$J,358.3,3910,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3910,1,3,0)
 ;;=3^Occupational Exposure to Tobacco Smoke,Environmental
 ;;^UTILITY(U,$J,358.3,3910,1,4,0)
 ;;=4^Z57.31
 ;;^UTILITY(U,$J,358.3,3910,2)
 ;;=^5063121
 ;;^UTILITY(U,$J,358.3,3911,0)
 ;;=Z57.6^^18^224^86
 ;;^UTILITY(U,$J,358.3,3911,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3911,1,3,0)
 ;;=3^Occupational Exposure to Extreme Temperature
 ;;^UTILITY(U,$J,358.3,3911,1,4,0)
 ;;=4^Z57.6
 ;;^UTILITY(U,$J,358.3,3911,2)
 ;;=^5063125
 ;;^UTILITY(U,$J,358.3,3912,0)
 ;;=Z57.0^^18^224^88
 ;;^UTILITY(U,$J,358.3,3912,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3912,1,3,0)
 ;;=3^Occupational Exposure to Noise
 ;;^UTILITY(U,$J,358.3,3912,1,4,0)
 ;;=4^Z57.0
 ;;^UTILITY(U,$J,358.3,3912,2)
 ;;=^5063118
 ;;^UTILITY(U,$J,358.3,3913,0)
 ;;=Z57.39^^18^224^84
 ;;^UTILITY(U,$J,358.3,3913,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3913,1,3,0)
 ;;=3^Occupational Exposure to Air Contaminants
 ;;^UTILITY(U,$J,358.3,3913,1,4,0)
 ;;=4^Z57.39
 ;;^UTILITY(U,$J,358.3,3913,2)
 ;;=^5063122
 ;;^UTILITY(U,$J,358.3,3914,0)
 ;;=Z57.8^^18^224^89
 ;;^UTILITY(U,$J,358.3,3914,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3914,1,3,0)
 ;;=3^Occupational Exposure to Other Risk Factors
 ;;^UTILITY(U,$J,358.3,3914,1,4,0)
 ;;=4^Z57.8
 ;;^UTILITY(U,$J,358.3,3914,2)
 ;;=^5063127
 ;;^UTILITY(U,$J,358.3,3915,0)
 ;;=Z57.1^^18^224^90
 ;;^UTILITY(U,$J,358.3,3915,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3915,1,3,0)
 ;;=3^Occupational Exposure to Radiation
 ;;^UTILITY(U,$J,358.3,3915,1,4,0)
 ;;=4^Z57.1
 ;;^UTILITY(U,$J,358.3,3915,2)
 ;;=^5063119
 ;;^UTILITY(U,$J,358.3,3916,0)
 ;;=Z57.4^^18^224^83
 ;;^UTILITY(U,$J,358.3,3916,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3916,1,3,0)
 ;;=3^Occupational Exposure to Agriculture Toxic Agents
 ;;^UTILITY(U,$J,358.3,3916,1,4,0)
 ;;=4^Z57.4
 ;;^UTILITY(U,$J,358.3,3916,2)
 ;;=^5063123

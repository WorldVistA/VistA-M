IBDEI0PL ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,11964,1,4,0)
 ;;=4^Z91.120
 ;;^UTILITY(U,$J,358.3,11964,2)
 ;;=^5063612
 ;;^UTILITY(U,$J,358.3,11965,0)
 ;;=Z91.128^^47^538^78
 ;;^UTILITY(U,$J,358.3,11965,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11965,1,3,0)
 ;;=3^Noncompliance w/ Med Regimen d/t Other Reasons
 ;;^UTILITY(U,$J,358.3,11965,1,4,0)
 ;;=4^Z91.128
 ;;^UTILITY(U,$J,358.3,11965,2)
 ;;=^5063613
 ;;^UTILITY(U,$J,358.3,11966,0)
 ;;=Z91.130^^47^538^76
 ;;^UTILITY(U,$J,358.3,11966,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11966,1,3,0)
 ;;=3^Noncompliance w/ Med Regimen d/t Age-Related Debility
 ;;^UTILITY(U,$J,358.3,11966,1,4,0)
 ;;=4^Z91.130
 ;;^UTILITY(U,$J,358.3,11966,2)
 ;;=^5063614
 ;;^UTILITY(U,$J,358.3,11967,0)
 ;;=Z91.138^^47^538^75
 ;;^UTILITY(U,$J,358.3,11967,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11967,1,3,0)
 ;;=3^Noncompliance w/ Med Regimen Unintentional
 ;;^UTILITY(U,$J,358.3,11967,1,4,0)
 ;;=4^Z91.138
 ;;^UTILITY(U,$J,358.3,11967,2)
 ;;=^5063615
 ;;^UTILITY(U,$J,358.3,11968,0)
 ;;=Z91.19^^47^538^79
 ;;^UTILITY(U,$J,358.3,11968,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11968,1,3,0)
 ;;=3^Noncompliance w/ Medical Treatment/Regimen
 ;;^UTILITY(U,$J,358.3,11968,1,4,0)
 ;;=4^Z91.19
 ;;^UTILITY(U,$J,358.3,11968,2)
 ;;=^5063618
 ;;^UTILITY(U,$J,358.3,11969,0)
 ;;=Z91.15^^47^538^80
 ;;^UTILITY(U,$J,358.3,11969,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11969,1,3,0)
 ;;=3^Noncompliance w/ Renal Dialysis
 ;;^UTILITY(U,$J,358.3,11969,1,4,0)
 ;;=4^Z91.15
 ;;^UTILITY(U,$J,358.3,11969,2)
 ;;=^5063617
 ;;^UTILITY(U,$J,358.3,11970,0)
 ;;=Z57.2^^47^538^85
 ;;^UTILITY(U,$J,358.3,11970,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11970,1,3,0)
 ;;=3^Occupational Exposure to Dust
 ;;^UTILITY(U,$J,358.3,11970,1,4,0)
 ;;=4^Z57.2
 ;;^UTILITY(U,$J,358.3,11970,2)
 ;;=^5063120
 ;;^UTILITY(U,$J,358.3,11971,0)
 ;;=Z57.31^^47^538^91
 ;;^UTILITY(U,$J,358.3,11971,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11971,1,3,0)
 ;;=3^Occupational Exposure to Tobacco Smoke,Environmental
 ;;^UTILITY(U,$J,358.3,11971,1,4,0)
 ;;=4^Z57.31
 ;;^UTILITY(U,$J,358.3,11971,2)
 ;;=^5063121
 ;;^UTILITY(U,$J,358.3,11972,0)
 ;;=Z57.6^^47^538^86
 ;;^UTILITY(U,$J,358.3,11972,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11972,1,3,0)
 ;;=3^Occupational Exposure to Extreme Temperature
 ;;^UTILITY(U,$J,358.3,11972,1,4,0)
 ;;=4^Z57.6
 ;;^UTILITY(U,$J,358.3,11972,2)
 ;;=^5063125
 ;;^UTILITY(U,$J,358.3,11973,0)
 ;;=Z57.0^^47^538^88
 ;;^UTILITY(U,$J,358.3,11973,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11973,1,3,0)
 ;;=3^Occupational Exposure to Noise
 ;;^UTILITY(U,$J,358.3,11973,1,4,0)
 ;;=4^Z57.0
 ;;^UTILITY(U,$J,358.3,11973,2)
 ;;=^5063118
 ;;^UTILITY(U,$J,358.3,11974,0)
 ;;=Z57.39^^47^538^84
 ;;^UTILITY(U,$J,358.3,11974,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11974,1,3,0)
 ;;=3^Occupational Exposure to Air Contaminants
 ;;^UTILITY(U,$J,358.3,11974,1,4,0)
 ;;=4^Z57.39
 ;;^UTILITY(U,$J,358.3,11974,2)
 ;;=^5063122
 ;;^UTILITY(U,$J,358.3,11975,0)
 ;;=Z57.8^^47^538^89
 ;;^UTILITY(U,$J,358.3,11975,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11975,1,3,0)
 ;;=3^Occupational Exposure to Other Risk Factors
 ;;^UTILITY(U,$J,358.3,11975,1,4,0)
 ;;=4^Z57.8
 ;;^UTILITY(U,$J,358.3,11975,2)
 ;;=^5063127
 ;;^UTILITY(U,$J,358.3,11976,0)
 ;;=Z57.1^^47^538^90
 ;;^UTILITY(U,$J,358.3,11976,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11976,1,3,0)
 ;;=3^Occupational Exposure to Radiation
 ;;^UTILITY(U,$J,358.3,11976,1,4,0)
 ;;=4^Z57.1
 ;;^UTILITY(U,$J,358.3,11976,2)
 ;;=^5063119
 ;;^UTILITY(U,$J,358.3,11977,0)
 ;;=Z57.4^^47^538^83
 ;;^UTILITY(U,$J,358.3,11977,1,0)
 ;;=^358.31IA^4^2

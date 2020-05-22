IBDEI32L ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,49022,2)
 ;;=^5063615
 ;;^UTILITY(U,$J,358.3,49023,0)
 ;;=Z91.19^^185^2428^79
 ;;^UTILITY(U,$J,358.3,49023,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49023,1,3,0)
 ;;=3^Noncompliance w/ Medical Treatment/Regimen
 ;;^UTILITY(U,$J,358.3,49023,1,4,0)
 ;;=4^Z91.19
 ;;^UTILITY(U,$J,358.3,49023,2)
 ;;=^5063618
 ;;^UTILITY(U,$J,358.3,49024,0)
 ;;=Z91.15^^185^2428^80
 ;;^UTILITY(U,$J,358.3,49024,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49024,1,3,0)
 ;;=3^Noncompliance w/ Renal Dialysis
 ;;^UTILITY(U,$J,358.3,49024,1,4,0)
 ;;=4^Z91.15
 ;;^UTILITY(U,$J,358.3,49024,2)
 ;;=^5063617
 ;;^UTILITY(U,$J,358.3,49025,0)
 ;;=Z57.2^^185^2428^85
 ;;^UTILITY(U,$J,358.3,49025,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49025,1,3,0)
 ;;=3^Occupational Exposure to Dust
 ;;^UTILITY(U,$J,358.3,49025,1,4,0)
 ;;=4^Z57.2
 ;;^UTILITY(U,$J,358.3,49025,2)
 ;;=^5063120
 ;;^UTILITY(U,$J,358.3,49026,0)
 ;;=Z57.31^^185^2428^91
 ;;^UTILITY(U,$J,358.3,49026,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49026,1,3,0)
 ;;=3^Occupational Exposure to Tobacco Smoke,Environmental
 ;;^UTILITY(U,$J,358.3,49026,1,4,0)
 ;;=4^Z57.31
 ;;^UTILITY(U,$J,358.3,49026,2)
 ;;=^5063121
 ;;^UTILITY(U,$J,358.3,49027,0)
 ;;=Z57.6^^185^2428^86
 ;;^UTILITY(U,$J,358.3,49027,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49027,1,3,0)
 ;;=3^Occupational Exposure to Extreme Temperature
 ;;^UTILITY(U,$J,358.3,49027,1,4,0)
 ;;=4^Z57.6
 ;;^UTILITY(U,$J,358.3,49027,2)
 ;;=^5063125
 ;;^UTILITY(U,$J,358.3,49028,0)
 ;;=Z57.0^^185^2428^88
 ;;^UTILITY(U,$J,358.3,49028,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49028,1,3,0)
 ;;=3^Occupational Exposure to Noise
 ;;^UTILITY(U,$J,358.3,49028,1,4,0)
 ;;=4^Z57.0
 ;;^UTILITY(U,$J,358.3,49028,2)
 ;;=^5063118
 ;;^UTILITY(U,$J,358.3,49029,0)
 ;;=Z57.39^^185^2428^84
 ;;^UTILITY(U,$J,358.3,49029,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49029,1,3,0)
 ;;=3^Occupational Exposure to Air Contaminants
 ;;^UTILITY(U,$J,358.3,49029,1,4,0)
 ;;=4^Z57.39
 ;;^UTILITY(U,$J,358.3,49029,2)
 ;;=^5063122
 ;;^UTILITY(U,$J,358.3,49030,0)
 ;;=Z57.8^^185^2428^89
 ;;^UTILITY(U,$J,358.3,49030,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49030,1,3,0)
 ;;=3^Occupational Exposure to Other Risk Factors
 ;;^UTILITY(U,$J,358.3,49030,1,4,0)
 ;;=4^Z57.8
 ;;^UTILITY(U,$J,358.3,49030,2)
 ;;=^5063127
 ;;^UTILITY(U,$J,358.3,49031,0)
 ;;=Z57.1^^185^2428^90
 ;;^UTILITY(U,$J,358.3,49031,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49031,1,3,0)
 ;;=3^Occupational Exposure to Radiation
 ;;^UTILITY(U,$J,358.3,49031,1,4,0)
 ;;=4^Z57.1
 ;;^UTILITY(U,$J,358.3,49031,2)
 ;;=^5063119
 ;;^UTILITY(U,$J,358.3,49032,0)
 ;;=Z57.4^^185^2428^83
 ;;^UTILITY(U,$J,358.3,49032,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49032,1,3,0)
 ;;=3^Occupational Exposure to Agriculture Toxic Agents
 ;;^UTILITY(U,$J,358.3,49032,1,4,0)
 ;;=4^Z57.4
 ;;^UTILITY(U,$J,358.3,49032,2)
 ;;=^5063123
 ;;^UTILITY(U,$J,358.3,49033,0)
 ;;=Z57.5^^185^2428^87
 ;;^UTILITY(U,$J,358.3,49033,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49033,1,3,0)
 ;;=3^Occupational Exposure to Industrial Toxic Agents
 ;;^UTILITY(U,$J,358.3,49033,1,4,0)
 ;;=4^Z57.5
 ;;^UTILITY(U,$J,358.3,49033,2)
 ;;=^5063124
 ;;^UTILITY(U,$J,358.3,49034,0)
 ;;=Z57.9^^185^2428^92
 ;;^UTILITY(U,$J,358.3,49034,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49034,1,3,0)
 ;;=3^Occupational Exposure to Unspec Risk Factor
 ;;^UTILITY(U,$J,358.3,49034,1,4,0)
 ;;=4^Z57.9

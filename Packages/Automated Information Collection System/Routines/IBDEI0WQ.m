IBDEI0WQ ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,14573,1,4,0)
 ;;=4^Z91.120
 ;;^UTILITY(U,$J,358.3,14573,2)
 ;;=^5063612
 ;;^UTILITY(U,$J,358.3,14574,0)
 ;;=Z91.128^^83^826^78
 ;;^UTILITY(U,$J,358.3,14574,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14574,1,3,0)
 ;;=3^Noncompliance w/ Med Regimen d/t Other Reasons
 ;;^UTILITY(U,$J,358.3,14574,1,4,0)
 ;;=4^Z91.128
 ;;^UTILITY(U,$J,358.3,14574,2)
 ;;=^5063613
 ;;^UTILITY(U,$J,358.3,14575,0)
 ;;=Z91.130^^83^826^76
 ;;^UTILITY(U,$J,358.3,14575,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14575,1,3,0)
 ;;=3^Noncompliance w/ Med Regimen d/t Age-Related Debility
 ;;^UTILITY(U,$J,358.3,14575,1,4,0)
 ;;=4^Z91.130
 ;;^UTILITY(U,$J,358.3,14575,2)
 ;;=^5063614
 ;;^UTILITY(U,$J,358.3,14576,0)
 ;;=Z91.138^^83^826^75
 ;;^UTILITY(U,$J,358.3,14576,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14576,1,3,0)
 ;;=3^Noncompliance w/ Med Regimen Unintentional
 ;;^UTILITY(U,$J,358.3,14576,1,4,0)
 ;;=4^Z91.138
 ;;^UTILITY(U,$J,358.3,14576,2)
 ;;=^5063615
 ;;^UTILITY(U,$J,358.3,14577,0)
 ;;=Z91.19^^83^826^79
 ;;^UTILITY(U,$J,358.3,14577,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14577,1,3,0)
 ;;=3^Noncompliance w/ Medical Treatment/Regimen
 ;;^UTILITY(U,$J,358.3,14577,1,4,0)
 ;;=4^Z91.19
 ;;^UTILITY(U,$J,358.3,14577,2)
 ;;=^5063618
 ;;^UTILITY(U,$J,358.3,14578,0)
 ;;=Z91.15^^83^826^80
 ;;^UTILITY(U,$J,358.3,14578,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14578,1,3,0)
 ;;=3^Noncompliance w/ Renal Dialysis
 ;;^UTILITY(U,$J,358.3,14578,1,4,0)
 ;;=4^Z91.15
 ;;^UTILITY(U,$J,358.3,14578,2)
 ;;=^5063617
 ;;^UTILITY(U,$J,358.3,14579,0)
 ;;=Z57.2^^83^826^85
 ;;^UTILITY(U,$J,358.3,14579,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14579,1,3,0)
 ;;=3^Occupational Exposure to Dust
 ;;^UTILITY(U,$J,358.3,14579,1,4,0)
 ;;=4^Z57.2
 ;;^UTILITY(U,$J,358.3,14579,2)
 ;;=^5063120
 ;;^UTILITY(U,$J,358.3,14580,0)
 ;;=Z57.31^^83^826^91
 ;;^UTILITY(U,$J,358.3,14580,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14580,1,3,0)
 ;;=3^Occupational Exposure to Tobacco Smoke,Environmental
 ;;^UTILITY(U,$J,358.3,14580,1,4,0)
 ;;=4^Z57.31
 ;;^UTILITY(U,$J,358.3,14580,2)
 ;;=^5063121
 ;;^UTILITY(U,$J,358.3,14581,0)
 ;;=Z57.6^^83^826^86
 ;;^UTILITY(U,$J,358.3,14581,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14581,1,3,0)
 ;;=3^Occupational Exposure to Extreme Temperature
 ;;^UTILITY(U,$J,358.3,14581,1,4,0)
 ;;=4^Z57.6
 ;;^UTILITY(U,$J,358.3,14581,2)
 ;;=^5063125
 ;;^UTILITY(U,$J,358.3,14582,0)
 ;;=Z57.0^^83^826^88
 ;;^UTILITY(U,$J,358.3,14582,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14582,1,3,0)
 ;;=3^Occupational Exposure to Noise
 ;;^UTILITY(U,$J,358.3,14582,1,4,0)
 ;;=4^Z57.0
 ;;^UTILITY(U,$J,358.3,14582,2)
 ;;=^5063118
 ;;^UTILITY(U,$J,358.3,14583,0)
 ;;=Z57.39^^83^826^84
 ;;^UTILITY(U,$J,358.3,14583,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14583,1,3,0)
 ;;=3^Occupational Exposure to Air Contaminants
 ;;^UTILITY(U,$J,358.3,14583,1,4,0)
 ;;=4^Z57.39
 ;;^UTILITY(U,$J,358.3,14583,2)
 ;;=^5063122
 ;;^UTILITY(U,$J,358.3,14584,0)
 ;;=Z57.8^^83^826^89
 ;;^UTILITY(U,$J,358.3,14584,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14584,1,3,0)
 ;;=3^Occupational Exposure to Other Risk Factors
 ;;^UTILITY(U,$J,358.3,14584,1,4,0)
 ;;=4^Z57.8
 ;;^UTILITY(U,$J,358.3,14584,2)
 ;;=^5063127
 ;;^UTILITY(U,$J,358.3,14585,0)
 ;;=Z57.1^^83^826^90
 ;;^UTILITY(U,$J,358.3,14585,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14585,1,3,0)
 ;;=3^Occupational Exposure to Radiation

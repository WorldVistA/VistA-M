IBDEI0ES ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6360,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6360,1,3,0)
 ;;=3^Biventricular Heart Failure
 ;;^UTILITY(U,$J,358.3,6360,1,4,0)
 ;;=4^I50.82
 ;;^UTILITY(U,$J,358.3,6360,2)
 ;;=^5151389
 ;;^UTILITY(U,$J,358.3,6361,0)
 ;;=I50.812^^53^406^20
 ;;^UTILITY(U,$J,358.3,6361,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6361,1,3,0)
 ;;=3^Chronic Right Heart Failure
 ;;^UTILITY(U,$J,358.3,6361,1,4,0)
 ;;=4^I50.812
 ;;^UTILITY(U,$J,358.3,6361,2)
 ;;=^5151386
 ;;^UTILITY(U,$J,358.3,6362,0)
 ;;=I50.84^^53^406^32
 ;;^UTILITY(U,$J,358.3,6362,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6362,1,3,0)
 ;;=3^End Stage Heart Failure
 ;;^UTILITY(U,$J,358.3,6362,1,4,0)
 ;;=4^I50.84
 ;;^UTILITY(U,$J,358.3,6362,2)
 ;;=^5151391
 ;;^UTILITY(U,$J,358.3,6363,0)
 ;;=I50.83^^53^406^44
 ;;^UTILITY(U,$J,358.3,6363,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6363,1,3,0)
 ;;=3^High Output Heart Failure
 ;;^UTILITY(U,$J,358.3,6363,1,4,0)
 ;;=4^I50.83
 ;;^UTILITY(U,$J,358.3,6363,2)
 ;;=^5151390
 ;;^UTILITY(U,$J,358.3,6364,0)
 ;;=I27.21^^53^406^62
 ;;^UTILITY(U,$J,358.3,6364,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6364,1,3,0)
 ;;=3^Pulmonary Arterial Hypertension
 ;;^UTILITY(U,$J,358.3,6364,1,4,0)
 ;;=4^I27.21
 ;;^UTILITY(U,$J,358.3,6364,2)
 ;;=^5151377
 ;;^UTILITY(U,$J,358.3,6365,0)
 ;;=I27.22^^53^406^65
 ;;^UTILITY(U,$J,358.3,6365,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6365,1,3,0)
 ;;=3^Pulmonary HTN d/t Left Heart Disease
 ;;^UTILITY(U,$J,358.3,6365,1,4,0)
 ;;=4^I27.22
 ;;^UTILITY(U,$J,358.3,6365,2)
 ;;=^5151378
 ;;^UTILITY(U,$J,358.3,6366,0)
 ;;=I50.814^^53^406^69
 ;;^UTILITY(U,$J,358.3,6366,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6366,1,3,0)
 ;;=3^Right Heart Failure d/t Left Heart Failure
 ;;^UTILITY(U,$J,358.3,6366,1,4,0)
 ;;=4^I50.814
 ;;^UTILITY(U,$J,358.3,6366,2)
 ;;=^5151388
 ;;^UTILITY(U,$J,358.3,6367,0)
 ;;=I25.10^^53^407^2
 ;;^UTILITY(U,$J,358.3,6367,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6367,1,3,0)
 ;;=3^Athscl Hrt Disease of Native Coronary Artery w/o Ang Pctrs
 ;;^UTILITY(U,$J,358.3,6367,1,4,0)
 ;;=4^I25.10
 ;;^UTILITY(U,$J,358.3,6367,2)
 ;;=^5007107
 ;;^UTILITY(U,$J,358.3,6368,0)
 ;;=I25.110^^53^407^3
 ;;^UTILITY(U,$J,358.3,6368,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6368,1,3,0)
 ;;=3^Athscl Hrt Disease of Native Coronary Artery w/ Unstable Ang Pctrs
 ;;^UTILITY(U,$J,358.3,6368,1,4,0)
 ;;=4^I25.110
 ;;^UTILITY(U,$J,358.3,6368,2)
 ;;=^5007108
 ;;^UTILITY(U,$J,358.3,6369,0)
 ;;=I25.111^^53^407^4
 ;;^UTILITY(U,$J,358.3,6369,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6369,1,3,0)
 ;;=3^Athscl Hrt Disease of Native Coronary Artery w/ Ang Pctrs w/ Spasm
 ;;^UTILITY(U,$J,358.3,6369,1,4,0)
 ;;=4^I25.111
 ;;^UTILITY(U,$J,358.3,6369,2)
 ;;=^5007109
 ;;^UTILITY(U,$J,358.3,6370,0)
 ;;=I25.118^^53^407^5
 ;;^UTILITY(U,$J,358.3,6370,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6370,1,3,0)
 ;;=3^Athscl Hrt Disease of Native Coronary Artery w/ Oth Ang Pctrs
 ;;^UTILITY(U,$J,358.3,6370,1,4,0)
 ;;=4^I25.118
 ;;^UTILITY(U,$J,358.3,6370,2)
 ;;=^5007110
 ;;^UTILITY(U,$J,358.3,6371,0)
 ;;=I25.119^^53^407^6
 ;;^UTILITY(U,$J,358.3,6371,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6371,1,3,0)
 ;;=3^Athscl Hrt Disease of Native Coronary Artery w/ Unspec Ang Pctrs
 ;;^UTILITY(U,$J,358.3,6371,1,4,0)
 ;;=4^I25.119
 ;;^UTILITY(U,$J,358.3,6371,2)
 ;;=^5007111
 ;;^UTILITY(U,$J,358.3,6372,0)
 ;;=I25.810^^53^407^1

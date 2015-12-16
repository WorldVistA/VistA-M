IBDEI1XR ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,33995,2)
 ;;=^5007111
 ;;^UTILITY(U,$J,358.3,33996,0)
 ;;=I25.110^^183^2014^10
 ;;^UTILITY(U,$J,358.3,33996,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33996,1,3,0)
 ;;=3^Athscl hrt disease of native cor art w unstable ang pctrs
 ;;^UTILITY(U,$J,358.3,33996,1,4,0)
 ;;=4^I25.110
 ;;^UTILITY(U,$J,358.3,33996,2)
 ;;=^5007108
 ;;^UTILITY(U,$J,358.3,33997,0)
 ;;=I25.10^^183^2014^11
 ;;^UTILITY(U,$J,358.3,33997,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33997,1,3,0)
 ;;=3^Athscl hrt disease of native cor art w/o ang pctrs
 ;;^UTILITY(U,$J,358.3,33997,1,4,0)
 ;;=4^I25.10
 ;;^UTILITY(U,$J,358.3,33997,2)
 ;;=^5007107
 ;;^UTILITY(U,$J,358.3,33998,0)
 ;;=I48.0^^183^2014^28
 ;;^UTILITY(U,$J,358.3,33998,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33998,1,3,0)
 ;;=3^Paroxysmal atrial fibrillation
 ;;^UTILITY(U,$J,358.3,33998,1,4,0)
 ;;=4^I48.0
 ;;^UTILITY(U,$J,358.3,33998,2)
 ;;=^90473
 ;;^UTILITY(U,$J,358.3,33999,0)
 ;;=I42.9^^183^2014^13
 ;;^UTILITY(U,$J,358.3,33999,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33999,1,3,0)
 ;;=3^Cardiomyopathy, unspecified
 ;;^UTILITY(U,$J,358.3,33999,1,4,0)
 ;;=4^I42.9
 ;;^UTILITY(U,$J,358.3,33999,2)
 ;;=^5007200
 ;;^UTILITY(U,$J,358.3,34000,0)
 ;;=I50.42^^183^2014^14
 ;;^UTILITY(U,$J,358.3,34000,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34000,1,3,0)
 ;;=3^Chronic combined systolic and diastolic hrt fail
 ;;^UTILITY(U,$J,358.3,34000,1,4,0)
 ;;=4^I50.42
 ;;^UTILITY(U,$J,358.3,34000,2)
 ;;=^5007249
 ;;^UTILITY(U,$J,358.3,34001,0)
 ;;=I50.32^^183^2014^15
 ;;^UTILITY(U,$J,358.3,34001,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34001,1,3,0)
 ;;=3^Chronic diastolic (congestive) heart failure
 ;;^UTILITY(U,$J,358.3,34001,1,4,0)
 ;;=4^I50.32
 ;;^UTILITY(U,$J,358.3,34001,2)
 ;;=^5007245
 ;;^UTILITY(U,$J,358.3,34002,0)
 ;;=J44.1^^183^2014^16
 ;;^UTILITY(U,$J,358.3,34002,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34002,1,3,0)
 ;;=3^Chronic obstructive pulmonary disease w (acute) exacerbation
 ;;^UTILITY(U,$J,358.3,34002,1,4,0)
 ;;=4^J44.1
 ;;^UTILITY(U,$J,358.3,34002,2)
 ;;=^5008240
 ;;^UTILITY(U,$J,358.3,34003,0)
 ;;=J44.9^^183^2014^17
 ;;^UTILITY(U,$J,358.3,34003,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34003,1,3,0)
 ;;=3^Chronic obstructive pulmonary disease, unspecified
 ;;^UTILITY(U,$J,358.3,34003,1,4,0)
 ;;=4^J44.9
 ;;^UTILITY(U,$J,358.3,34003,2)
 ;;=^5008241
 ;;^UTILITY(U,$J,358.3,34004,0)
 ;;=I50.22^^183^2014^18
 ;;^UTILITY(U,$J,358.3,34004,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34004,1,3,0)
 ;;=3^Chronic systolic (congestive) heart failure
 ;;^UTILITY(U,$J,358.3,34004,1,4,0)
 ;;=4^I50.22
 ;;^UTILITY(U,$J,358.3,34004,2)
 ;;=^5007241
 ;;^UTILITY(U,$J,358.3,34005,0)
 ;;=Z98.61^^183^2014^20
 ;;^UTILITY(U,$J,358.3,34005,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34005,1,3,0)
 ;;=3^Coronary angioplasty status
 ;;^UTILITY(U,$J,358.3,34005,1,4,0)
 ;;=4^Z98.61
 ;;^UTILITY(U,$J,358.3,34005,2)
 ;;=^5063742
 ;;^UTILITY(U,$J,358.3,34006,0)
 ;;=I42.0^^183^2014^22
 ;;^UTILITY(U,$J,358.3,34006,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34006,1,3,0)
 ;;=3^Dilated cardiomyopathy
 ;;^UTILITY(U,$J,358.3,34006,1,4,0)
 ;;=4^I42.0
 ;;^UTILITY(U,$J,358.3,34006,2)
 ;;=^5007194
 ;;^UTILITY(U,$J,358.3,34007,0)
 ;;=J43.9^^183^2014^23
 ;;^UTILITY(U,$J,358.3,34007,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34007,1,3,0)
 ;;=3^Emphysema, unspecified
 ;;^UTILITY(U,$J,358.3,34007,1,4,0)
 ;;=4^J43.9
 ;;^UTILITY(U,$J,358.3,34007,2)
 ;;=^5008238
 ;;^UTILITY(U,$J,358.3,34008,0)
 ;;=Z82.49^^183^2014^24
 ;;^UTILITY(U,$J,358.3,34008,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34008,1,3,0)
 ;;=3^Family hx of ischem heart dis and oth dis of the circ sys

IBDEI176 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,19236,1,3,0)
 ;;=3^Cardiomyopathy, unspecified
 ;;^UTILITY(U,$J,358.3,19236,1,4,0)
 ;;=4^I42.9
 ;;^UTILITY(U,$J,358.3,19236,2)
 ;;=^5007200
 ;;^UTILITY(U,$J,358.3,19237,0)
 ;;=I50.42^^93^990^14
 ;;^UTILITY(U,$J,358.3,19237,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19237,1,3,0)
 ;;=3^Chronic combined systolic and diastolic hrt fail
 ;;^UTILITY(U,$J,358.3,19237,1,4,0)
 ;;=4^I50.42
 ;;^UTILITY(U,$J,358.3,19237,2)
 ;;=^5007249
 ;;^UTILITY(U,$J,358.3,19238,0)
 ;;=I50.32^^93^990^15
 ;;^UTILITY(U,$J,358.3,19238,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19238,1,3,0)
 ;;=3^Chronic diastolic (congestive) heart failure
 ;;^UTILITY(U,$J,358.3,19238,1,4,0)
 ;;=4^I50.32
 ;;^UTILITY(U,$J,358.3,19238,2)
 ;;=^5007245
 ;;^UTILITY(U,$J,358.3,19239,0)
 ;;=J44.1^^93^990^16
 ;;^UTILITY(U,$J,358.3,19239,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19239,1,3,0)
 ;;=3^Chronic obstructive pulmonary disease w (acute) exacerbation
 ;;^UTILITY(U,$J,358.3,19239,1,4,0)
 ;;=4^J44.1
 ;;^UTILITY(U,$J,358.3,19239,2)
 ;;=^5008240
 ;;^UTILITY(U,$J,358.3,19240,0)
 ;;=J44.9^^93^990^17
 ;;^UTILITY(U,$J,358.3,19240,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19240,1,3,0)
 ;;=3^Chronic obstructive pulmonary disease, unspecified
 ;;^UTILITY(U,$J,358.3,19240,1,4,0)
 ;;=4^J44.9
 ;;^UTILITY(U,$J,358.3,19240,2)
 ;;=^5008241
 ;;^UTILITY(U,$J,358.3,19241,0)
 ;;=I50.22^^93^990^18
 ;;^UTILITY(U,$J,358.3,19241,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19241,1,3,0)
 ;;=3^Chronic systolic (congestive) heart failure
 ;;^UTILITY(U,$J,358.3,19241,1,4,0)
 ;;=4^I50.22
 ;;^UTILITY(U,$J,358.3,19241,2)
 ;;=^5007241
 ;;^UTILITY(U,$J,358.3,19242,0)
 ;;=Z98.61^^93^990^20
 ;;^UTILITY(U,$J,358.3,19242,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19242,1,3,0)
 ;;=3^Coronary angioplasty status
 ;;^UTILITY(U,$J,358.3,19242,1,4,0)
 ;;=4^Z98.61
 ;;^UTILITY(U,$J,358.3,19242,2)
 ;;=^5063742
 ;;^UTILITY(U,$J,358.3,19243,0)
 ;;=I42.0^^93^990^22
 ;;^UTILITY(U,$J,358.3,19243,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19243,1,3,0)
 ;;=3^Dilated cardiomyopathy
 ;;^UTILITY(U,$J,358.3,19243,1,4,0)
 ;;=4^I42.0
 ;;^UTILITY(U,$J,358.3,19243,2)
 ;;=^5007194
 ;;^UTILITY(U,$J,358.3,19244,0)
 ;;=J43.9^^93^990^23
 ;;^UTILITY(U,$J,358.3,19244,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19244,1,3,0)
 ;;=3^Emphysema, unspecified
 ;;^UTILITY(U,$J,358.3,19244,1,4,0)
 ;;=4^J43.9
 ;;^UTILITY(U,$J,358.3,19244,2)
 ;;=^5008238
 ;;^UTILITY(U,$J,358.3,19245,0)
 ;;=Z82.49^^93^990^24
 ;;^UTILITY(U,$J,358.3,19245,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19245,1,3,0)
 ;;=3^Family hx of ischem heart dis and oth dis of the circ sys
 ;;^UTILITY(U,$J,358.3,19245,1,4,0)
 ;;=4^Z82.49
 ;;^UTILITY(U,$J,358.3,19245,2)
 ;;=^5063369
 ;;^UTILITY(U,$J,358.3,19246,0)
 ;;=I50.9^^93^990^25
 ;;^UTILITY(U,$J,358.3,19246,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19246,1,3,0)
 ;;=3^Heart failure, unspecified
 ;;^UTILITY(U,$J,358.3,19246,1,4,0)
 ;;=4^I50.9
 ;;^UTILITY(U,$J,358.3,19246,2)
 ;;=^5007251
 ;;^UTILITY(U,$J,358.3,19247,0)
 ;;=I25.2^^93^990^27
 ;;^UTILITY(U,$J,358.3,19247,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19247,1,3,0)
 ;;=3^Old myocardial infarction
 ;;^UTILITY(U,$J,358.3,19247,1,4,0)
 ;;=4^I25.2
 ;;^UTILITY(U,$J,358.3,19247,2)
 ;;=^259884
 ;;^UTILITY(U,$J,358.3,19248,0)
 ;;=I42.8^^93^990^12
 ;;^UTILITY(U,$J,358.3,19248,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19248,1,3,0)
 ;;=3^Cardiomyopathies NEC

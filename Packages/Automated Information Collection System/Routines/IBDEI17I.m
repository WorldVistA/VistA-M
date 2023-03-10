IBDEI17I ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,19599,1,3,0)
 ;;=3^Acute on chronic systolic (congestive) heart failure
 ;;^UTILITY(U,$J,358.3,19599,1,4,0)
 ;;=4^I50.23
 ;;^UTILITY(U,$J,358.3,19599,2)
 ;;=^5007242
 ;;^UTILITY(U,$J,358.3,19600,0)
 ;;=I50.21^^67^878^6
 ;;^UTILITY(U,$J,358.3,19600,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19600,1,3,0)
 ;;=3^Acute systolic (congestive) heart failure
 ;;^UTILITY(U,$J,358.3,19600,1,4,0)
 ;;=4^I50.21
 ;;^UTILITY(U,$J,358.3,19600,2)
 ;;=^5007240
 ;;^UTILITY(U,$J,358.3,19601,0)
 ;;=I25.111^^67^878^7
 ;;^UTILITY(U,$J,358.3,19601,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19601,1,3,0)
 ;;=3^Athscl hrt disease of native cor art w ang pctrs w spasm
 ;;^UTILITY(U,$J,358.3,19601,1,4,0)
 ;;=4^I25.111
 ;;^UTILITY(U,$J,358.3,19601,2)
 ;;=^5007109
 ;;^UTILITY(U,$J,358.3,19602,0)
 ;;=I25.118^^67^878^8
 ;;^UTILITY(U,$J,358.3,19602,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19602,1,3,0)
 ;;=3^Athscl hrt disease of native cor art w oth ang pctrs
 ;;^UTILITY(U,$J,358.3,19602,1,4,0)
 ;;=4^I25.118
 ;;^UTILITY(U,$J,358.3,19602,2)
 ;;=^5007110
 ;;^UTILITY(U,$J,358.3,19603,0)
 ;;=I25.119^^67^878^9
 ;;^UTILITY(U,$J,358.3,19603,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19603,1,3,0)
 ;;=3^Athscl hrt disease of native cor art w unsp ang pctrs
 ;;^UTILITY(U,$J,358.3,19603,1,4,0)
 ;;=4^I25.119
 ;;^UTILITY(U,$J,358.3,19603,2)
 ;;=^5007111
 ;;^UTILITY(U,$J,358.3,19604,0)
 ;;=I25.110^^67^878^10
 ;;^UTILITY(U,$J,358.3,19604,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19604,1,3,0)
 ;;=3^Athscl hrt disease of native cor art w unstable ang pctrs
 ;;^UTILITY(U,$J,358.3,19604,1,4,0)
 ;;=4^I25.110
 ;;^UTILITY(U,$J,358.3,19604,2)
 ;;=^5007108
 ;;^UTILITY(U,$J,358.3,19605,0)
 ;;=I25.10^^67^878^11
 ;;^UTILITY(U,$J,358.3,19605,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19605,1,3,0)
 ;;=3^Athscl hrt disease of native cor art w/o ang pctrs
 ;;^UTILITY(U,$J,358.3,19605,1,4,0)
 ;;=4^I25.10
 ;;^UTILITY(U,$J,358.3,19605,2)
 ;;=^5007107
 ;;^UTILITY(U,$J,358.3,19606,0)
 ;;=I48.0^^67^878^28
 ;;^UTILITY(U,$J,358.3,19606,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19606,1,3,0)
 ;;=3^Paroxysmal atrial fibrillation
 ;;^UTILITY(U,$J,358.3,19606,1,4,0)
 ;;=4^I48.0
 ;;^UTILITY(U,$J,358.3,19606,2)
 ;;=^90473
 ;;^UTILITY(U,$J,358.3,19607,0)
 ;;=I42.9^^67^878^13
 ;;^UTILITY(U,$J,358.3,19607,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19607,1,3,0)
 ;;=3^Cardiomyopathy, unspecified
 ;;^UTILITY(U,$J,358.3,19607,1,4,0)
 ;;=4^I42.9
 ;;^UTILITY(U,$J,358.3,19607,2)
 ;;=^5007200
 ;;^UTILITY(U,$J,358.3,19608,0)
 ;;=I50.42^^67^878^14
 ;;^UTILITY(U,$J,358.3,19608,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19608,1,3,0)
 ;;=3^Chronic combined systolic and diastolic hrt fail
 ;;^UTILITY(U,$J,358.3,19608,1,4,0)
 ;;=4^I50.42
 ;;^UTILITY(U,$J,358.3,19608,2)
 ;;=^5007249
 ;;^UTILITY(U,$J,358.3,19609,0)
 ;;=I50.32^^67^878^15
 ;;^UTILITY(U,$J,358.3,19609,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19609,1,3,0)
 ;;=3^Chronic diastolic (congestive) heart failure
 ;;^UTILITY(U,$J,358.3,19609,1,4,0)
 ;;=4^I50.32
 ;;^UTILITY(U,$J,358.3,19609,2)
 ;;=^5007245
 ;;^UTILITY(U,$J,358.3,19610,0)
 ;;=J44.1^^67^878^16
 ;;^UTILITY(U,$J,358.3,19610,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19610,1,3,0)
 ;;=3^Chronic obstructive pulmonary disease w (acute) exacerbation
 ;;^UTILITY(U,$J,358.3,19610,1,4,0)
 ;;=4^J44.1
 ;;^UTILITY(U,$J,358.3,19610,2)
 ;;=^5008240

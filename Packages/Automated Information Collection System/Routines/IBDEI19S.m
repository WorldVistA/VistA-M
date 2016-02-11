IBDEI19S ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,21231,1,4,0)
 ;;=4^I50.23
 ;;^UTILITY(U,$J,358.3,21231,2)
 ;;=^5007242
 ;;^UTILITY(U,$J,358.3,21232,0)
 ;;=I50.21^^101^1028^6
 ;;^UTILITY(U,$J,358.3,21232,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21232,1,3,0)
 ;;=3^Acute systolic (congestive) heart failure
 ;;^UTILITY(U,$J,358.3,21232,1,4,0)
 ;;=4^I50.21
 ;;^UTILITY(U,$J,358.3,21232,2)
 ;;=^5007240
 ;;^UTILITY(U,$J,358.3,21233,0)
 ;;=I25.111^^101^1028^7
 ;;^UTILITY(U,$J,358.3,21233,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21233,1,3,0)
 ;;=3^Athscl hrt disease of native cor art w ang pctrs w spasm
 ;;^UTILITY(U,$J,358.3,21233,1,4,0)
 ;;=4^I25.111
 ;;^UTILITY(U,$J,358.3,21233,2)
 ;;=^5007109
 ;;^UTILITY(U,$J,358.3,21234,0)
 ;;=I25.118^^101^1028^8
 ;;^UTILITY(U,$J,358.3,21234,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21234,1,3,0)
 ;;=3^Athscl hrt disease of native cor art w oth ang pctrs
 ;;^UTILITY(U,$J,358.3,21234,1,4,0)
 ;;=4^I25.118
 ;;^UTILITY(U,$J,358.3,21234,2)
 ;;=^5007110
 ;;^UTILITY(U,$J,358.3,21235,0)
 ;;=I25.119^^101^1028^9
 ;;^UTILITY(U,$J,358.3,21235,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21235,1,3,0)
 ;;=3^Athscl hrt disease of native cor art w unsp ang pctrs
 ;;^UTILITY(U,$J,358.3,21235,1,4,0)
 ;;=4^I25.119
 ;;^UTILITY(U,$J,358.3,21235,2)
 ;;=^5007111
 ;;^UTILITY(U,$J,358.3,21236,0)
 ;;=I25.110^^101^1028^10
 ;;^UTILITY(U,$J,358.3,21236,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21236,1,3,0)
 ;;=3^Athscl hrt disease of native cor art w unstable ang pctrs
 ;;^UTILITY(U,$J,358.3,21236,1,4,0)
 ;;=4^I25.110
 ;;^UTILITY(U,$J,358.3,21236,2)
 ;;=^5007108
 ;;^UTILITY(U,$J,358.3,21237,0)
 ;;=I25.10^^101^1028^11
 ;;^UTILITY(U,$J,358.3,21237,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21237,1,3,0)
 ;;=3^Athscl hrt disease of native cor art w/o ang pctrs
 ;;^UTILITY(U,$J,358.3,21237,1,4,0)
 ;;=4^I25.10
 ;;^UTILITY(U,$J,358.3,21237,2)
 ;;=^5007107
 ;;^UTILITY(U,$J,358.3,21238,0)
 ;;=I48.0^^101^1028^28
 ;;^UTILITY(U,$J,358.3,21238,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21238,1,3,0)
 ;;=3^Paroxysmal atrial fibrillation
 ;;^UTILITY(U,$J,358.3,21238,1,4,0)
 ;;=4^I48.0
 ;;^UTILITY(U,$J,358.3,21238,2)
 ;;=^90473
 ;;^UTILITY(U,$J,358.3,21239,0)
 ;;=I42.9^^101^1028^13
 ;;^UTILITY(U,$J,358.3,21239,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21239,1,3,0)
 ;;=3^Cardiomyopathy, unspecified
 ;;^UTILITY(U,$J,358.3,21239,1,4,0)
 ;;=4^I42.9
 ;;^UTILITY(U,$J,358.3,21239,2)
 ;;=^5007200
 ;;^UTILITY(U,$J,358.3,21240,0)
 ;;=I50.42^^101^1028^14
 ;;^UTILITY(U,$J,358.3,21240,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21240,1,3,0)
 ;;=3^Chronic combined systolic and diastolic hrt fail
 ;;^UTILITY(U,$J,358.3,21240,1,4,0)
 ;;=4^I50.42
 ;;^UTILITY(U,$J,358.3,21240,2)
 ;;=^5007249
 ;;^UTILITY(U,$J,358.3,21241,0)
 ;;=I50.32^^101^1028^15
 ;;^UTILITY(U,$J,358.3,21241,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21241,1,3,0)
 ;;=3^Chronic diastolic (congestive) heart failure
 ;;^UTILITY(U,$J,358.3,21241,1,4,0)
 ;;=4^I50.32
 ;;^UTILITY(U,$J,358.3,21241,2)
 ;;=^5007245
 ;;^UTILITY(U,$J,358.3,21242,0)
 ;;=J44.1^^101^1028^16
 ;;^UTILITY(U,$J,358.3,21242,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21242,1,3,0)
 ;;=3^Chronic obstructive pulmonary disease w (acute) exacerbation
 ;;^UTILITY(U,$J,358.3,21242,1,4,0)
 ;;=4^J44.1
 ;;^UTILITY(U,$J,358.3,21242,2)
 ;;=^5008240
 ;;^UTILITY(U,$J,358.3,21243,0)
 ;;=J44.9^^101^1028^17
 ;;^UTILITY(U,$J,358.3,21243,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21243,1,3,0)
 ;;=3^Chronic obstructive pulmonary disease, unspecified
 ;;^UTILITY(U,$J,358.3,21243,1,4,0)
 ;;=4^J44.9
 ;;^UTILITY(U,$J,358.3,21243,2)
 ;;=^5008241

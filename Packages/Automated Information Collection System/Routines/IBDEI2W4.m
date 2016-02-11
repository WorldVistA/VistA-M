IBDEI2W4 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,48530,2)
 ;;=^5007248
 ;;^UTILITY(U,$J,358.3,48531,0)
 ;;=I50.31^^216^2408^2
 ;;^UTILITY(U,$J,358.3,48531,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48531,1,3,0)
 ;;=3^Acute diastolic (congestive) heart failure
 ;;^UTILITY(U,$J,358.3,48531,1,4,0)
 ;;=4^I50.31
 ;;^UTILITY(U,$J,358.3,48531,2)
 ;;=^5007244
 ;;^UTILITY(U,$J,358.3,48532,0)
 ;;=I50.43^^216^2408^3
 ;;^UTILITY(U,$J,358.3,48532,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48532,1,3,0)
 ;;=3^Acute on chronic combined systolic and diastolic hrt fail
 ;;^UTILITY(U,$J,358.3,48532,1,4,0)
 ;;=4^I50.43
 ;;^UTILITY(U,$J,358.3,48532,2)
 ;;=^5007250
 ;;^UTILITY(U,$J,358.3,48533,0)
 ;;=I50.33^^216^2408^4
 ;;^UTILITY(U,$J,358.3,48533,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48533,1,3,0)
 ;;=3^Acute on chronic diastolic (congestive) heart failure
 ;;^UTILITY(U,$J,358.3,48533,1,4,0)
 ;;=4^I50.33
 ;;^UTILITY(U,$J,358.3,48533,2)
 ;;=^5007246
 ;;^UTILITY(U,$J,358.3,48534,0)
 ;;=I50.23^^216^2408^5
 ;;^UTILITY(U,$J,358.3,48534,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48534,1,3,0)
 ;;=3^Acute on chronic systolic (congestive) heart failure
 ;;^UTILITY(U,$J,358.3,48534,1,4,0)
 ;;=4^I50.23
 ;;^UTILITY(U,$J,358.3,48534,2)
 ;;=^5007242
 ;;^UTILITY(U,$J,358.3,48535,0)
 ;;=I50.21^^216^2408^6
 ;;^UTILITY(U,$J,358.3,48535,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48535,1,3,0)
 ;;=3^Acute systolic (congestive) heart failure
 ;;^UTILITY(U,$J,358.3,48535,1,4,0)
 ;;=4^I50.21
 ;;^UTILITY(U,$J,358.3,48535,2)
 ;;=^5007240
 ;;^UTILITY(U,$J,358.3,48536,0)
 ;;=I25.111^^216^2408^7
 ;;^UTILITY(U,$J,358.3,48536,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48536,1,3,0)
 ;;=3^Athscl hrt disease of native cor art w ang pctrs w spasm
 ;;^UTILITY(U,$J,358.3,48536,1,4,0)
 ;;=4^I25.111
 ;;^UTILITY(U,$J,358.3,48536,2)
 ;;=^5007109
 ;;^UTILITY(U,$J,358.3,48537,0)
 ;;=I25.118^^216^2408^8
 ;;^UTILITY(U,$J,358.3,48537,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48537,1,3,0)
 ;;=3^Athscl hrt disease of native cor art w oth ang pctrs
 ;;^UTILITY(U,$J,358.3,48537,1,4,0)
 ;;=4^I25.118
 ;;^UTILITY(U,$J,358.3,48537,2)
 ;;=^5007110
 ;;^UTILITY(U,$J,358.3,48538,0)
 ;;=I25.119^^216^2408^9
 ;;^UTILITY(U,$J,358.3,48538,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48538,1,3,0)
 ;;=3^Athscl hrt disease of native cor art w unsp ang pctrs
 ;;^UTILITY(U,$J,358.3,48538,1,4,0)
 ;;=4^I25.119
 ;;^UTILITY(U,$J,358.3,48538,2)
 ;;=^5007111
 ;;^UTILITY(U,$J,358.3,48539,0)
 ;;=I25.110^^216^2408^10
 ;;^UTILITY(U,$J,358.3,48539,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48539,1,3,0)
 ;;=3^Athscl hrt disease of native cor art w unstable ang pctrs
 ;;^UTILITY(U,$J,358.3,48539,1,4,0)
 ;;=4^I25.110
 ;;^UTILITY(U,$J,358.3,48539,2)
 ;;=^5007108
 ;;^UTILITY(U,$J,358.3,48540,0)
 ;;=I25.10^^216^2408^11
 ;;^UTILITY(U,$J,358.3,48540,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48540,1,3,0)
 ;;=3^Athscl hrt disease of native cor art w/o ang pctrs
 ;;^UTILITY(U,$J,358.3,48540,1,4,0)
 ;;=4^I25.10
 ;;^UTILITY(U,$J,358.3,48540,2)
 ;;=^5007107
 ;;^UTILITY(U,$J,358.3,48541,0)
 ;;=I48.0^^216^2408^28
 ;;^UTILITY(U,$J,358.3,48541,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48541,1,3,0)
 ;;=3^Paroxysmal atrial fibrillation
 ;;^UTILITY(U,$J,358.3,48541,1,4,0)
 ;;=4^I48.0
 ;;^UTILITY(U,$J,358.3,48541,2)
 ;;=^90473
 ;;^UTILITY(U,$J,358.3,48542,0)
 ;;=I42.9^^216^2408^13
 ;;^UTILITY(U,$J,358.3,48542,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48542,1,3,0)
 ;;=3^Cardiomyopathy, unspecified
 ;;^UTILITY(U,$J,358.3,48542,1,4,0)
 ;;=4^I42.9
 ;;^UTILITY(U,$J,358.3,48542,2)
 ;;=^5007200
 ;;^UTILITY(U,$J,358.3,48543,0)
 ;;=I50.42^^216^2408^14

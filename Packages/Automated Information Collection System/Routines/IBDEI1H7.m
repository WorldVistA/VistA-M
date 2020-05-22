IBDEI1H7 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23603,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,23603,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,23604,0)
 ;;=F10.21^^105^1175^4
 ;;^UTILITY(U,$J,358.3,23604,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23604,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,23604,1,4,0)
 ;;=4^F10.21
 ;;^UTILITY(U,$J,358.3,23604,2)
 ;;=^5003082
 ;;^UTILITY(U,$J,358.3,23605,0)
 ;;=F10.230^^105^1175^5
 ;;^UTILITY(U,$J,358.3,23605,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23605,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,23605,1,4,0)
 ;;=4^F10.230
 ;;^UTILITY(U,$J,358.3,23605,2)
 ;;=^5003086
 ;;^UTILITY(U,$J,358.3,23606,0)
 ;;=F10.231^^105^1175^6
 ;;^UTILITY(U,$J,358.3,23606,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23606,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe w/ Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,23606,1,4,0)
 ;;=4^F10.231
 ;;^UTILITY(U,$J,358.3,23606,2)
 ;;=^5003087
 ;;^UTILITY(U,$J,358.3,23607,0)
 ;;=F10.232^^105^1175^7
 ;;^UTILITY(U,$J,358.3,23607,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23607,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe w/ Withdrawal Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,23607,1,4,0)
 ;;=4^F10.232
 ;;^UTILITY(U,$J,358.3,23607,2)
 ;;=^5003088
 ;;^UTILITY(U,$J,358.3,23608,0)
 ;;=F10.239^^105^1175^8
 ;;^UTILITY(U,$J,358.3,23608,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23608,1,3,0)
 ;;=3^Alcohol Withdrawal w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,23608,1,4,0)
 ;;=4^F10.239
 ;;^UTILITY(U,$J,358.3,23608,2)
 ;;=^5003089
 ;;^UTILITY(U,$J,358.3,23609,0)
 ;;=F10.24^^105^1175^10
 ;;^UTILITY(U,$J,358.3,23609,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23609,1,3,0)
 ;;=3^Alcohol-Induced Depressive & Related Disorder w/ Moderate-Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,23609,1,4,0)
 ;;=4^F10.24
 ;;^UTILITY(U,$J,358.3,23609,2)
 ;;=^5003090
 ;;^UTILITY(U,$J,358.3,23610,0)
 ;;=F10.29^^105^1175^12
 ;;^UTILITY(U,$J,358.3,23610,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23610,1,3,0)
 ;;=3^Alcohol-Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,23610,1,4,0)
 ;;=4^F10.29
 ;;^UTILITY(U,$J,358.3,23610,2)
 ;;=^5003100
 ;;^UTILITY(U,$J,358.3,23611,0)
 ;;=F10.11^^105^1175^1
 ;;^UTILITY(U,$J,358.3,23611,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23611,1,3,0)
 ;;=3^Alcohol Abuse,In Remission
 ;;^UTILITY(U,$J,358.3,23611,1,4,0)
 ;;=4^F10.11
 ;;^UTILITY(U,$J,358.3,23611,2)
 ;;=^268230
 ;;^UTILITY(U,$J,358.3,23612,0)
 ;;=F15.10^^105^1176^5
 ;;^UTILITY(U,$J,358.3,23612,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23612,1,3,0)
 ;;=3^Amphetamine-Type Disorder,Mild
 ;;^UTILITY(U,$J,358.3,23612,1,4,0)
 ;;=4^F15.10
 ;;^UTILITY(U,$J,358.3,23612,2)
 ;;=^5003282
 ;;^UTILITY(U,$J,358.3,23613,0)
 ;;=F15.14^^105^1176^3
 ;;^UTILITY(U,$J,358.3,23613,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23613,1,3,0)
 ;;=3^Amphetamine-Induced Depressive,Bipolar & Related Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,23613,1,4,0)
 ;;=4^F15.14
 ;;^UTILITY(U,$J,358.3,23613,2)
 ;;=^5003287
 ;;^UTILITY(U,$J,358.3,23614,0)
 ;;=F15.182^^105^1176^4
 ;;^UTILITY(U,$J,358.3,23614,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23614,1,3,0)
 ;;=3^Amphetamine-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,23614,1,4,0)
 ;;=4^F15.182
 ;;^UTILITY(U,$J,358.3,23614,2)
 ;;=^5003293
 ;;^UTILITY(U,$J,358.3,23615,0)
 ;;=F15.20^^105^1176^6

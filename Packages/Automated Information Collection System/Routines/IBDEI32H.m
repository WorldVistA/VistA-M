IBDEI32H ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,48974,1,3,0)
 ;;=3^Dental Prosthetic Device
 ;;^UTILITY(U,$J,358.3,48974,1,4,0)
 ;;=4^Z97.2
 ;;^UTILITY(U,$J,358.3,48974,2)
 ;;=^5063728
 ;;^UTILITY(U,$J,358.3,48975,0)
 ;;=Z99.89^^185^2428^39
 ;;^UTILITY(U,$J,358.3,48975,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48975,1,3,0)
 ;;=3^Dependence on Enabling Machines/Devices
 ;;^UTILITY(U,$J,358.3,48975,1,4,0)
 ;;=4^Z99.89
 ;;^UTILITY(U,$J,358.3,48975,2)
 ;;=^5063761
 ;;^UTILITY(U,$J,358.3,48976,0)
 ;;=Z66.^^185^2428^40
 ;;^UTILITY(U,$J,358.3,48976,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48976,1,3,0)
 ;;=3^Do Not Resuscitate
 ;;^UTILITY(U,$J,358.3,48976,1,4,0)
 ;;=4^Z66.
 ;;^UTILITY(U,$J,358.3,48976,2)
 ;;=^5063187
 ;;^UTILITY(U,$J,358.3,48977,0)
 ;;=Z79.2^^185^2428^41
 ;;^UTILITY(U,$J,358.3,48977,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48977,1,3,0)
 ;;=3^Drug Therapy,Antibiotics,Long Term Current Use
 ;;^UTILITY(U,$J,358.3,48977,1,4,0)
 ;;=4^Z79.2
 ;;^UTILITY(U,$J,358.3,48977,2)
 ;;=^321546
 ;;^UTILITY(U,$J,358.3,48978,0)
 ;;=Z79.01^^185^2428^42
 ;;^UTILITY(U,$J,358.3,48978,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48978,1,3,0)
 ;;=3^Drug Therapy,Anticoagulants,Long Term Current Use
 ;;^UTILITY(U,$J,358.3,48978,1,4,0)
 ;;=4^Z79.01
 ;;^UTILITY(U,$J,358.3,48978,2)
 ;;=^5063330
 ;;^UTILITY(U,$J,358.3,48979,0)
 ;;=Z79.02^^185^2428^43
 ;;^UTILITY(U,$J,358.3,48979,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48979,1,3,0)
 ;;=3^Drug Therapy,Antithrombotics/Antiplateletes,Long Term Current Use
 ;;^UTILITY(U,$J,358.3,48979,1,4,0)
 ;;=4^Z79.02
 ;;^UTILITY(U,$J,358.3,48979,2)
 ;;=^5063331
 ;;^UTILITY(U,$J,358.3,48980,0)
 ;;=Z79.82^^185^2428^44
 ;;^UTILITY(U,$J,358.3,48980,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48980,1,3,0)
 ;;=3^Drug Therapy,Aspirin,Long Term Current Use
 ;;^UTILITY(U,$J,358.3,48980,1,4,0)
 ;;=4^Z79.82
 ;;^UTILITY(U,$J,358.3,48980,2)
 ;;=^5063340
 ;;^UTILITY(U,$J,358.3,48981,0)
 ;;=Z79.83^^185^2428^45
 ;;^UTILITY(U,$J,358.3,48981,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48981,1,3,0)
 ;;=3^Drug Therapy,Bisphosphonates,Long Term Current Use
 ;;^UTILITY(U,$J,358.3,48981,1,4,0)
 ;;=4^Z79.83
 ;;^UTILITY(U,$J,358.3,48981,2)
 ;;=^5063341
 ;;^UTILITY(U,$J,358.3,48982,0)
 ;;=Z79.890^^185^2428^46
 ;;^UTILITY(U,$J,358.3,48982,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48982,1,3,0)
 ;;=3^Drug Therapy,Hormone Replacement Therapy
 ;;^UTILITY(U,$J,358.3,48982,1,4,0)
 ;;=4^Z79.890
 ;;^UTILITY(U,$J,358.3,48982,2)
 ;;=^331975
 ;;^UTILITY(U,$J,358.3,48983,0)
 ;;=Z79.4^^185^2428^48
 ;;^UTILITY(U,$J,358.3,48983,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48983,1,3,0)
 ;;=3^Drug Therapy,Insulin,Long Term Current Use
 ;;^UTILITY(U,$J,358.3,48983,1,4,0)
 ;;=4^Z79.4
 ;;^UTILITY(U,$J,358.3,48983,2)
 ;;=^5063334
 ;;^UTILITY(U,$J,358.3,48984,0)
 ;;=Z79.1^^185^2428^49
 ;;^UTILITY(U,$J,358.3,48984,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48984,1,3,0)
 ;;=3^Drug Therapy,NSAID,Long Term Current Use
 ;;^UTILITY(U,$J,358.3,48984,1,4,0)
 ;;=4^Z79.1
 ;;^UTILITY(U,$J,358.3,48984,2)
 ;;=^5063332
 ;;^UTILITY(U,$J,358.3,48985,0)
 ;;=Z79.891^^185^2428^50
 ;;^UTILITY(U,$J,358.3,48985,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48985,1,3,0)
 ;;=3^Drug Therapy,Opiate Analgesic,Long Term Current Use
 ;;^UTILITY(U,$J,358.3,48985,1,4,0)
 ;;=4^Z79.891
 ;;^UTILITY(U,$J,358.3,48985,2)
 ;;=^5063342
 ;;^UTILITY(U,$J,358.3,48986,0)
 ;;=Z79.899^^185^2428^51

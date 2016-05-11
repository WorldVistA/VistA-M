IBDEI08U ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3850,2)
 ;;=^5063251
 ;;^UTILITY(U,$J,358.3,3851,0)
 ;;=Z71.6^^18^224^35
 ;;^UTILITY(U,$J,358.3,3851,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3851,1,3,0)
 ;;=3^Counseling,Tobacco Abuse
 ;;^UTILITY(U,$J,358.3,3851,1,4,0)
 ;;=4^Z71.6
 ;;^UTILITY(U,$J,358.3,3851,2)
 ;;=^5063250
 ;;^UTILITY(U,$J,358.3,3852,0)
 ;;=Z71.41^^18^224^28
 ;;^UTILITY(U,$J,358.3,3852,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3852,1,3,0)
 ;;=3^Counseling,Alcohol Abuse
 ;;^UTILITY(U,$J,358.3,3852,1,4,0)
 ;;=4^Z71.41
 ;;^UTILITY(U,$J,358.3,3852,2)
 ;;=^5063246
 ;;^UTILITY(U,$J,358.3,3853,0)
 ;;=Z71.51^^18^224^30
 ;;^UTILITY(U,$J,358.3,3853,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3853,1,3,0)
 ;;=3^Counseling,Drug Abuser
 ;;^UTILITY(U,$J,358.3,3853,1,4,0)
 ;;=4^Z71.51
 ;;^UTILITY(U,$J,358.3,3853,2)
 ;;=^5063248
 ;;^UTILITY(U,$J,358.3,3854,0)
 ;;=Z71.3^^18^224^29
 ;;^UTILITY(U,$J,358.3,3854,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3854,1,3,0)
 ;;=3^Counseling,Dietary
 ;;^UTILITY(U,$J,358.3,3854,1,4,0)
 ;;=4^Z71.3
 ;;^UTILITY(U,$J,358.3,3854,2)
 ;;=^5063245
 ;;^UTILITY(U,$J,358.3,3855,0)
 ;;=Z71.81^^18^224^34
 ;;^UTILITY(U,$J,358.3,3855,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3855,1,3,0)
 ;;=3^Counseling,Spiritual/Religious
 ;;^UTILITY(U,$J,358.3,3855,1,4,0)
 ;;=4^Z71.81
 ;;^UTILITY(U,$J,358.3,3855,2)
 ;;=^5063252
 ;;^UTILITY(U,$J,358.3,3856,0)
 ;;=Z71.9^^18^224^36
 ;;^UTILITY(U,$J,358.3,3856,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3856,1,3,0)
 ;;=3^Counseling,Unspec
 ;;^UTILITY(U,$J,358.3,3856,1,4,0)
 ;;=4^Z71.9
 ;;^UTILITY(U,$J,358.3,3856,2)
 ;;=^5063254
 ;;^UTILITY(U,$J,358.3,3857,0)
 ;;=F05.^^18^224^37
 ;;^UTILITY(U,$J,358.3,3857,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3857,1,3,0)
 ;;=3^Delirium d/t Physiological Condition
 ;;^UTILITY(U,$J,358.3,3857,1,4,0)
 ;;=4^F05.
 ;;^UTILITY(U,$J,358.3,3857,2)
 ;;=^5003052
 ;;^UTILITY(U,$J,358.3,3858,0)
 ;;=Z97.2^^18^224^38
 ;;^UTILITY(U,$J,358.3,3858,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3858,1,3,0)
 ;;=3^Dental Prosthetic Device
 ;;^UTILITY(U,$J,358.3,3858,1,4,0)
 ;;=4^Z97.2
 ;;^UTILITY(U,$J,358.3,3858,2)
 ;;=^5063728
 ;;^UTILITY(U,$J,358.3,3859,0)
 ;;=Z99.89^^18^224^39
 ;;^UTILITY(U,$J,358.3,3859,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3859,1,3,0)
 ;;=3^Dependence on Enabling Machines/Devices
 ;;^UTILITY(U,$J,358.3,3859,1,4,0)
 ;;=4^Z99.89
 ;;^UTILITY(U,$J,358.3,3859,2)
 ;;=^5063761
 ;;^UTILITY(U,$J,358.3,3860,0)
 ;;=Z66.^^18^224^40
 ;;^UTILITY(U,$J,358.3,3860,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3860,1,3,0)
 ;;=3^Do Not Resuscitate
 ;;^UTILITY(U,$J,358.3,3860,1,4,0)
 ;;=4^Z66.
 ;;^UTILITY(U,$J,358.3,3860,2)
 ;;=^5063187
 ;;^UTILITY(U,$J,358.3,3861,0)
 ;;=Z79.2^^18^224^41
 ;;^UTILITY(U,$J,358.3,3861,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3861,1,3,0)
 ;;=3^Drug Therapy,Antibiotics,Long Term Current Use
 ;;^UTILITY(U,$J,358.3,3861,1,4,0)
 ;;=4^Z79.2
 ;;^UTILITY(U,$J,358.3,3861,2)
 ;;=^321546
 ;;^UTILITY(U,$J,358.3,3862,0)
 ;;=Z79.01^^18^224^42
 ;;^UTILITY(U,$J,358.3,3862,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3862,1,3,0)
 ;;=3^Drug Therapy,Anticoagulants,Long Term Current Use
 ;;^UTILITY(U,$J,358.3,3862,1,4,0)
 ;;=4^Z79.01
 ;;^UTILITY(U,$J,358.3,3862,2)
 ;;=^5063330
 ;;^UTILITY(U,$J,358.3,3863,0)
 ;;=Z79.02^^18^224^43
 ;;^UTILITY(U,$J,358.3,3863,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3863,1,3,0)
 ;;=3^Drug Therapy,Antithrombotics/Antiplateletes,Long Term Current Use
 ;;^UTILITY(U,$J,358.3,3863,1,4,0)
 ;;=4^Z79.02
 ;;^UTILITY(U,$J,358.3,3863,2)
 ;;=^5063331
 ;;^UTILITY(U,$J,358.3,3864,0)
 ;;=Z79.82^^18^224^44

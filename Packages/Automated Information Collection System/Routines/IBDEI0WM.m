IBDEI0WM ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,14524,1,4,0)
 ;;=4^Z71.3
 ;;^UTILITY(U,$J,358.3,14524,2)
 ;;=^5063245
 ;;^UTILITY(U,$J,358.3,14525,0)
 ;;=Z71.81^^83^826^34
 ;;^UTILITY(U,$J,358.3,14525,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14525,1,3,0)
 ;;=3^Counseling,Spiritual/Religious
 ;;^UTILITY(U,$J,358.3,14525,1,4,0)
 ;;=4^Z71.81
 ;;^UTILITY(U,$J,358.3,14525,2)
 ;;=^5063252
 ;;^UTILITY(U,$J,358.3,14526,0)
 ;;=Z71.9^^83^826^36
 ;;^UTILITY(U,$J,358.3,14526,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14526,1,3,0)
 ;;=3^Counseling,Unspec
 ;;^UTILITY(U,$J,358.3,14526,1,4,0)
 ;;=4^Z71.9
 ;;^UTILITY(U,$J,358.3,14526,2)
 ;;=^5063254
 ;;^UTILITY(U,$J,358.3,14527,0)
 ;;=F05.^^83^826^37
 ;;^UTILITY(U,$J,358.3,14527,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14527,1,3,0)
 ;;=3^Delirium d/t Physiological Condition
 ;;^UTILITY(U,$J,358.3,14527,1,4,0)
 ;;=4^F05.
 ;;^UTILITY(U,$J,358.3,14527,2)
 ;;=^5003052
 ;;^UTILITY(U,$J,358.3,14528,0)
 ;;=Z97.2^^83^826^38
 ;;^UTILITY(U,$J,358.3,14528,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14528,1,3,0)
 ;;=3^Dental Prosthetic Device
 ;;^UTILITY(U,$J,358.3,14528,1,4,0)
 ;;=4^Z97.2
 ;;^UTILITY(U,$J,358.3,14528,2)
 ;;=^5063728
 ;;^UTILITY(U,$J,358.3,14529,0)
 ;;=Z99.89^^83^826^39
 ;;^UTILITY(U,$J,358.3,14529,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14529,1,3,0)
 ;;=3^Dependence on Enabling Machines/Devices
 ;;^UTILITY(U,$J,358.3,14529,1,4,0)
 ;;=4^Z99.89
 ;;^UTILITY(U,$J,358.3,14529,2)
 ;;=^5063761
 ;;^UTILITY(U,$J,358.3,14530,0)
 ;;=Z66.^^83^826^40
 ;;^UTILITY(U,$J,358.3,14530,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14530,1,3,0)
 ;;=3^Do Not Resuscitate
 ;;^UTILITY(U,$J,358.3,14530,1,4,0)
 ;;=4^Z66.
 ;;^UTILITY(U,$J,358.3,14530,2)
 ;;=^5063187
 ;;^UTILITY(U,$J,358.3,14531,0)
 ;;=Z79.2^^83^826^41
 ;;^UTILITY(U,$J,358.3,14531,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14531,1,3,0)
 ;;=3^Drug Therapy,Antibiotics,Long Term Current Use
 ;;^UTILITY(U,$J,358.3,14531,1,4,0)
 ;;=4^Z79.2
 ;;^UTILITY(U,$J,358.3,14531,2)
 ;;=^321546
 ;;^UTILITY(U,$J,358.3,14532,0)
 ;;=Z79.01^^83^826^42
 ;;^UTILITY(U,$J,358.3,14532,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14532,1,3,0)
 ;;=3^Drug Therapy,Anticoagulants,Long Term Current Use
 ;;^UTILITY(U,$J,358.3,14532,1,4,0)
 ;;=4^Z79.01
 ;;^UTILITY(U,$J,358.3,14532,2)
 ;;=^5063330
 ;;^UTILITY(U,$J,358.3,14533,0)
 ;;=Z79.02^^83^826^43
 ;;^UTILITY(U,$J,358.3,14533,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14533,1,3,0)
 ;;=3^Drug Therapy,Antithrombotics/Antiplateletes,Long Term Current Use
 ;;^UTILITY(U,$J,358.3,14533,1,4,0)
 ;;=4^Z79.02
 ;;^UTILITY(U,$J,358.3,14533,2)
 ;;=^5063331
 ;;^UTILITY(U,$J,358.3,14534,0)
 ;;=Z79.82^^83^826^44
 ;;^UTILITY(U,$J,358.3,14534,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14534,1,3,0)
 ;;=3^Drug Therapy,Aspirin,Long Term Current Use
 ;;^UTILITY(U,$J,358.3,14534,1,4,0)
 ;;=4^Z79.82
 ;;^UTILITY(U,$J,358.3,14534,2)
 ;;=^5063340
 ;;^UTILITY(U,$J,358.3,14535,0)
 ;;=Z79.83^^83^826^45
 ;;^UTILITY(U,$J,358.3,14535,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14535,1,3,0)
 ;;=3^Drug Therapy,Bisphosphonates,Long Term Current Use
 ;;^UTILITY(U,$J,358.3,14535,1,4,0)
 ;;=4^Z79.83
 ;;^UTILITY(U,$J,358.3,14535,2)
 ;;=^5063341
 ;;^UTILITY(U,$J,358.3,14536,0)
 ;;=Z79.890^^83^826^46
 ;;^UTILITY(U,$J,358.3,14536,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14536,1,3,0)
 ;;=3^Drug Therapy,Hormone Replacement Therapy
 ;;^UTILITY(U,$J,358.3,14536,1,4,0)
 ;;=4^Z79.890

IBDEI0A0 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4153,1,4,0)
 ;;=4^F05.
 ;;^UTILITY(U,$J,358.3,4153,2)
 ;;=^5003052
 ;;^UTILITY(U,$J,358.3,4154,0)
 ;;=Z97.2^^28^263^38
 ;;^UTILITY(U,$J,358.3,4154,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4154,1,3,0)
 ;;=3^Dental Prosthetic Device
 ;;^UTILITY(U,$J,358.3,4154,1,4,0)
 ;;=4^Z97.2
 ;;^UTILITY(U,$J,358.3,4154,2)
 ;;=^5063728
 ;;^UTILITY(U,$J,358.3,4155,0)
 ;;=Z99.89^^28^263^39
 ;;^UTILITY(U,$J,358.3,4155,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4155,1,3,0)
 ;;=3^Dependence on Enabling Machines/Devices
 ;;^UTILITY(U,$J,358.3,4155,1,4,0)
 ;;=4^Z99.89
 ;;^UTILITY(U,$J,358.3,4155,2)
 ;;=^5063761
 ;;^UTILITY(U,$J,358.3,4156,0)
 ;;=Z66.^^28^263^40
 ;;^UTILITY(U,$J,358.3,4156,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4156,1,3,0)
 ;;=3^Do Not Resuscitate
 ;;^UTILITY(U,$J,358.3,4156,1,4,0)
 ;;=4^Z66.
 ;;^UTILITY(U,$J,358.3,4156,2)
 ;;=^5063187
 ;;^UTILITY(U,$J,358.3,4157,0)
 ;;=Z79.2^^28^263^41
 ;;^UTILITY(U,$J,358.3,4157,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4157,1,3,0)
 ;;=3^Drug Therapy,Antibiotics,Long Term Current Use
 ;;^UTILITY(U,$J,358.3,4157,1,4,0)
 ;;=4^Z79.2
 ;;^UTILITY(U,$J,358.3,4157,2)
 ;;=^321546
 ;;^UTILITY(U,$J,358.3,4158,0)
 ;;=Z79.01^^28^263^42
 ;;^UTILITY(U,$J,358.3,4158,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4158,1,3,0)
 ;;=3^Drug Therapy,Anticoagulants,Long Term Current Use
 ;;^UTILITY(U,$J,358.3,4158,1,4,0)
 ;;=4^Z79.01
 ;;^UTILITY(U,$J,358.3,4158,2)
 ;;=^5063330
 ;;^UTILITY(U,$J,358.3,4159,0)
 ;;=Z79.02^^28^263^43
 ;;^UTILITY(U,$J,358.3,4159,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4159,1,3,0)
 ;;=3^Drug Therapy,Antithrombotics/Antiplateletes,Long Term Current Use
 ;;^UTILITY(U,$J,358.3,4159,1,4,0)
 ;;=4^Z79.02
 ;;^UTILITY(U,$J,358.3,4159,2)
 ;;=^5063331
 ;;^UTILITY(U,$J,358.3,4160,0)
 ;;=Z79.82^^28^263^44
 ;;^UTILITY(U,$J,358.3,4160,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4160,1,3,0)
 ;;=3^Drug Therapy,Aspirin,Long Term Current Use
 ;;^UTILITY(U,$J,358.3,4160,1,4,0)
 ;;=4^Z79.82
 ;;^UTILITY(U,$J,358.3,4160,2)
 ;;=^5063340
 ;;^UTILITY(U,$J,358.3,4161,0)
 ;;=Z79.83^^28^263^45
 ;;^UTILITY(U,$J,358.3,4161,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4161,1,3,0)
 ;;=3^Drug Therapy,Bisphosphonates,Long Term Current Use
 ;;^UTILITY(U,$J,358.3,4161,1,4,0)
 ;;=4^Z79.83
 ;;^UTILITY(U,$J,358.3,4161,2)
 ;;=^5063341
 ;;^UTILITY(U,$J,358.3,4162,0)
 ;;=Z79.890^^28^263^46
 ;;^UTILITY(U,$J,358.3,4162,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4162,1,3,0)
 ;;=3^Drug Therapy,Hormone Replacement Therapy
 ;;^UTILITY(U,$J,358.3,4162,1,4,0)
 ;;=4^Z79.890
 ;;^UTILITY(U,$J,358.3,4162,2)
 ;;=^331975
 ;;^UTILITY(U,$J,358.3,4163,0)
 ;;=Z79.4^^28^263^48
 ;;^UTILITY(U,$J,358.3,4163,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4163,1,3,0)
 ;;=3^Drug Therapy,Insulin,Long Term Current Use
 ;;^UTILITY(U,$J,358.3,4163,1,4,0)
 ;;=4^Z79.4
 ;;^UTILITY(U,$J,358.3,4163,2)
 ;;=^5063334
 ;;^UTILITY(U,$J,358.3,4164,0)
 ;;=Z79.1^^28^263^49
 ;;^UTILITY(U,$J,358.3,4164,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4164,1,3,0)
 ;;=3^Drug Therapy,NSAID,Long Term Current Use
 ;;^UTILITY(U,$J,358.3,4164,1,4,0)
 ;;=4^Z79.1
 ;;^UTILITY(U,$J,358.3,4164,2)
 ;;=^5063332
 ;;^UTILITY(U,$J,358.3,4165,0)
 ;;=Z79.891^^28^263^50
 ;;^UTILITY(U,$J,358.3,4165,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4165,1,3,0)
 ;;=3^Drug Therapy,Opiate Analgesic,Long Term Current Use
 ;;^UTILITY(U,$J,358.3,4165,1,4,0)
 ;;=4^Z79.891
 ;;^UTILITY(U,$J,358.3,4165,2)
 ;;=^5063342
 ;;^UTILITY(U,$J,358.3,4166,0)
 ;;=Z79.899^^28^263^51
 ;;^UTILITY(U,$J,358.3,4166,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4166,1,3,0)
 ;;=3^Drug Therapy,Other Long Term Current Use

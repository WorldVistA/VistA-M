IBDEI03A ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1089,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1089,1,3,0)
 ;;=3^Urethritis,Nonspec
 ;;^UTILITY(U,$J,358.3,1089,1,4,0)
 ;;=4^N34.1
 ;;^UTILITY(U,$J,358.3,1089,2)
 ;;=^5015655
 ;;^UTILITY(U,$J,358.3,1090,0)
 ;;=N39.0^^6^112^11
 ;;^UTILITY(U,$J,358.3,1090,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1090,1,3,0)
 ;;=3^Urinary Tract Infection
 ;;^UTILITY(U,$J,358.3,1090,1,4,0)
 ;;=4^N39.0
 ;;^UTILITY(U,$J,358.3,1090,2)
 ;;=^124436
 ;;^UTILITY(U,$J,358.3,1091,0)
 ;;=R33.9^^6^112^12
 ;;^UTILITY(U,$J,358.3,1091,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1091,1,3,0)
 ;;=3^Urine Retention,Unspec
 ;;^UTILITY(U,$J,358.3,1091,1,4,0)
 ;;=4^R33.9
 ;;^UTILITY(U,$J,358.3,1091,2)
 ;;=^5019332
 ;;^UTILITY(U,$J,358.3,1092,0)
 ;;=R32.^^6^112^10
 ;;^UTILITY(U,$J,358.3,1092,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1092,1,3,0)
 ;;=3^Urinary Incontinence,Unspec
 ;;^UTILITY(U,$J,358.3,1092,1,4,0)
 ;;=4^R32.
 ;;^UTILITY(U,$J,358.3,1092,2)
 ;;=^5019329
 ;;^UTILITY(U,$J,358.3,1093,0)
 ;;=B97.89^^6^113^7
 ;;^UTILITY(U,$J,358.3,1093,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1093,1,3,0)
 ;;=3^Viral Agents as the Cause of Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,1093,1,4,0)
 ;;=4^B97.89
 ;;^UTILITY(U,$J,358.3,1093,2)
 ;;=^5000879
 ;;^UTILITY(U,$J,358.3,1094,0)
 ;;=H54.7^^6^113^8
 ;;^UTILITY(U,$J,358.3,1094,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1094,1,3,0)
 ;;=3^Visual Loss,Unspec
 ;;^UTILITY(U,$J,358.3,1094,1,4,0)
 ;;=4^H54.7
 ;;^UTILITY(U,$J,358.3,1094,2)
 ;;=^5006368
 ;;^UTILITY(U,$J,358.3,1095,0)
 ;;=I83.91^^6^113^5
 ;;^UTILITY(U,$J,358.3,1095,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1095,1,3,0)
 ;;=3^Varicose Veins,Asymptomatic,Right Lower Extremity
 ;;^UTILITY(U,$J,358.3,1095,1,4,0)
 ;;=4^I83.91
 ;;^UTILITY(U,$J,358.3,1095,2)
 ;;=^5008020
 ;;^UTILITY(U,$J,358.3,1096,0)
 ;;=I83.92^^6^113^4
 ;;^UTILITY(U,$J,358.3,1096,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1096,1,3,0)
 ;;=3^Varicose Veins,Asymptomatic,Left Lower Extremity
 ;;^UTILITY(U,$J,358.3,1096,1,4,0)
 ;;=4^I83.92
 ;;^UTILITY(U,$J,358.3,1096,2)
 ;;=^5008021
 ;;^UTILITY(U,$J,358.3,1097,0)
 ;;=I83.93^^6^113^3
 ;;^UTILITY(U,$J,358.3,1097,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1097,1,3,0)
 ;;=3^Varicose Veins,Asymptomatic,Bilateral Lower Extremities
 ;;^UTILITY(U,$J,358.3,1097,1,4,0)
 ;;=4^I83.93
 ;;^UTILITY(U,$J,358.3,1097,2)
 ;;=^5008022
 ;;^UTILITY(U,$J,358.3,1098,0)
 ;;=R53.1^^6^113^9
 ;;^UTILITY(U,$J,358.3,1098,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1098,1,3,0)
 ;;=3^Weakness
 ;;^UTILITY(U,$J,358.3,1098,1,4,0)
 ;;=4^R53.1
 ;;^UTILITY(U,$J,358.3,1098,2)
 ;;=^5019516
 ;;^UTILITY(U,$J,358.3,1099,0)
 ;;=R63.4^^6^113^10
 ;;^UTILITY(U,$J,358.3,1099,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1099,1,3,0)
 ;;=3^Weight Loss,Abnormal
 ;;^UTILITY(U,$J,358.3,1099,1,4,0)
 ;;=4^R63.4
 ;;^UTILITY(U,$J,358.3,1099,2)
 ;;=^5019542
 ;;^UTILITY(U,$J,358.3,1100,0)
 ;;=B02.9^^6^113^11
 ;;^UTILITY(U,$J,358.3,1100,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1100,1,3,0)
 ;;=3^Zoster w/o Complications
 ;;^UTILITY(U,$J,358.3,1100,1,4,0)
 ;;=4^B02.9
 ;;^UTILITY(U,$J,358.3,1100,2)
 ;;=^5000501
 ;;^UTILITY(U,$J,358.3,1101,0)
 ;;=I49.3^^6^113^6
 ;;^UTILITY(U,$J,358.3,1101,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1101,1,3,0)
 ;;=3^Vetricular Premature Depolarization
 ;;^UTILITY(U,$J,358.3,1101,1,4,0)
 ;;=4^I49.3
 ;;^UTILITY(U,$J,358.3,1101,2)
 ;;=^5007233
 ;;^UTILITY(U,$J,358.3,1102,0)
 ;;=I83.019^^6^113^2
 ;;^UTILITY(U,$J,358.3,1102,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1102,1,3,0)
 ;;=3^Varicose Veins Right Lower Extrem w/ Ulcer Unspec Site

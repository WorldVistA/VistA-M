IBDEI08V ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3864,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3864,1,3,0)
 ;;=3^Drug Therapy,Aspirin,Long Term Current Use
 ;;^UTILITY(U,$J,358.3,3864,1,4,0)
 ;;=4^Z79.82
 ;;^UTILITY(U,$J,358.3,3864,2)
 ;;=^5063340
 ;;^UTILITY(U,$J,358.3,3865,0)
 ;;=Z79.83^^18^224^45
 ;;^UTILITY(U,$J,358.3,3865,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3865,1,3,0)
 ;;=3^Drug Therapy,Bisphosphonates,Long Term Current Use
 ;;^UTILITY(U,$J,358.3,3865,1,4,0)
 ;;=4^Z79.83
 ;;^UTILITY(U,$J,358.3,3865,2)
 ;;=^5063341
 ;;^UTILITY(U,$J,358.3,3866,0)
 ;;=Z79.890^^18^224^46
 ;;^UTILITY(U,$J,358.3,3866,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3866,1,3,0)
 ;;=3^Drug Therapy,Hormone Replacement Therapy
 ;;^UTILITY(U,$J,358.3,3866,1,4,0)
 ;;=4^Z79.890
 ;;^UTILITY(U,$J,358.3,3866,2)
 ;;=^331975
 ;;^UTILITY(U,$J,358.3,3867,0)
 ;;=Z79.4^^18^224^48
 ;;^UTILITY(U,$J,358.3,3867,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3867,1,3,0)
 ;;=3^Drug Therapy,Insulin,Long Term Current Use
 ;;^UTILITY(U,$J,358.3,3867,1,4,0)
 ;;=4^Z79.4
 ;;^UTILITY(U,$J,358.3,3867,2)
 ;;=^5063334
 ;;^UTILITY(U,$J,358.3,3868,0)
 ;;=Z79.1^^18^224^49
 ;;^UTILITY(U,$J,358.3,3868,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3868,1,3,0)
 ;;=3^Drug Therapy,NSAID,Long Term Current Use
 ;;^UTILITY(U,$J,358.3,3868,1,4,0)
 ;;=4^Z79.1
 ;;^UTILITY(U,$J,358.3,3868,2)
 ;;=^5063332
 ;;^UTILITY(U,$J,358.3,3869,0)
 ;;=Z79.891^^18^224^50
 ;;^UTILITY(U,$J,358.3,3869,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3869,1,3,0)
 ;;=3^Drug Therapy,Opiate Analgesic,Long Term Current Use
 ;;^UTILITY(U,$J,358.3,3869,1,4,0)
 ;;=4^Z79.891
 ;;^UTILITY(U,$J,358.3,3869,2)
 ;;=^5063342
 ;;^UTILITY(U,$J,358.3,3870,0)
 ;;=Z79.899^^18^224^51
 ;;^UTILITY(U,$J,358.3,3870,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3870,1,3,0)
 ;;=3^Drug Therapy,Other Long Term Current Use
 ;;^UTILITY(U,$J,358.3,3870,1,4,0)
 ;;=4^Z79.899
 ;;^UTILITY(U,$J,358.3,3870,2)
 ;;=^5063343
 ;;^UTILITY(U,$J,358.3,3871,0)
 ;;=Z76.0^^18^224^71
 ;;^UTILITY(U,$J,358.3,3871,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3871,1,3,0)
 ;;=3^Issue of Repeat Prescription
 ;;^UTILITY(U,$J,358.3,3871,1,4,0)
 ;;=4^Z76.0
 ;;^UTILITY(U,$J,358.3,3871,2)
 ;;=^5063297
 ;;^UTILITY(U,$J,358.3,3872,0)
 ;;=Z79.810^^18^224^52
 ;;^UTILITY(U,$J,358.3,3872,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3872,1,3,0)
 ;;=3^Drug Therapy,SERMs,Long Term Current Use
 ;;^UTILITY(U,$J,358.3,3872,1,4,0)
 ;;=4^Z79.810
 ;;^UTILITY(U,$J,358.3,3872,2)
 ;;=^5063337
 ;;^UTILITY(U,$J,358.3,3873,0)
 ;;=Z79.51^^18^224^47
 ;;^UTILITY(U,$J,358.3,3873,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3873,1,3,0)
 ;;=3^Drug Therapy,Inhaled Steroids,Long Term Current Use
 ;;^UTILITY(U,$J,358.3,3873,1,4,0)
 ;;=4^Z79.51
 ;;^UTILITY(U,$J,358.3,3873,2)
 ;;=^5063335
 ;;^UTILITY(U,$J,358.3,3874,0)
 ;;=Z79.52^^18^224^53
 ;;^UTILITY(U,$J,358.3,3874,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3874,1,3,0)
 ;;=3^Drug Therapy,Systemic Steroids,Long Term Current Use
 ;;^UTILITY(U,$J,358.3,3874,1,4,0)
 ;;=4^Z79.52
 ;;^UTILITY(U,$J,358.3,3874,2)
 ;;=^5063336
 ;;^UTILITY(U,$J,358.3,3875,0)
 ;;=R68.2^^18^224^54
 ;;^UTILITY(U,$J,358.3,3875,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3875,1,3,0)
 ;;=3^Dry Mouth,Unspec
 ;;^UTILITY(U,$J,358.3,3875,1,4,0)
 ;;=4^R68.2
 ;;^UTILITY(U,$J,358.3,3875,2)
 ;;=^5019552
 ;;^UTILITY(U,$J,358.3,3876,0)
 ;;=Z02.89^^18^224^1
 ;;^UTILITY(U,$J,358.3,3876,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3876,1,3,0)
 ;;=3^Administrative Exam Encounter
 ;;^UTILITY(U,$J,358.3,3876,1,4,0)
 ;;=4^Z02.89
 ;;^UTILITY(U,$J,358.3,3876,2)
 ;;=^5062645
 ;;^UTILITY(U,$J,358.3,3877,0)
 ;;=Z09.^^18^224^56

IBDEI0A1 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4166,1,4,0)
 ;;=4^Z79.899
 ;;^UTILITY(U,$J,358.3,4166,2)
 ;;=^5063343
 ;;^UTILITY(U,$J,358.3,4167,0)
 ;;=Z76.0^^28^263^71
 ;;^UTILITY(U,$J,358.3,4167,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4167,1,3,0)
 ;;=3^Issue of Repeat Prescription
 ;;^UTILITY(U,$J,358.3,4167,1,4,0)
 ;;=4^Z76.0
 ;;^UTILITY(U,$J,358.3,4167,2)
 ;;=^5063297
 ;;^UTILITY(U,$J,358.3,4168,0)
 ;;=Z79.810^^28^263^52
 ;;^UTILITY(U,$J,358.3,4168,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4168,1,3,0)
 ;;=3^Drug Therapy,SERMs,Long Term Current Use
 ;;^UTILITY(U,$J,358.3,4168,1,4,0)
 ;;=4^Z79.810
 ;;^UTILITY(U,$J,358.3,4168,2)
 ;;=^5063337
 ;;^UTILITY(U,$J,358.3,4169,0)
 ;;=Z79.51^^28^263^47
 ;;^UTILITY(U,$J,358.3,4169,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4169,1,3,0)
 ;;=3^Drug Therapy,Inhaled Steroids,Long Term Current Use
 ;;^UTILITY(U,$J,358.3,4169,1,4,0)
 ;;=4^Z79.51
 ;;^UTILITY(U,$J,358.3,4169,2)
 ;;=^5063335
 ;;^UTILITY(U,$J,358.3,4170,0)
 ;;=Z79.52^^28^263^53
 ;;^UTILITY(U,$J,358.3,4170,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4170,1,3,0)
 ;;=3^Drug Therapy,Systemic Steroids,Long Term Current Use
 ;;^UTILITY(U,$J,358.3,4170,1,4,0)
 ;;=4^Z79.52
 ;;^UTILITY(U,$J,358.3,4170,2)
 ;;=^5063336
 ;;^UTILITY(U,$J,358.3,4171,0)
 ;;=R68.2^^28^263^54
 ;;^UTILITY(U,$J,358.3,4171,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4171,1,3,0)
 ;;=3^Dry Mouth,Unspec
 ;;^UTILITY(U,$J,358.3,4171,1,4,0)
 ;;=4^R68.2
 ;;^UTILITY(U,$J,358.3,4171,2)
 ;;=^5019552
 ;;^UTILITY(U,$J,358.3,4172,0)
 ;;=Z02.89^^28^263^1
 ;;^UTILITY(U,$J,358.3,4172,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4172,1,3,0)
 ;;=3^Administrative Exam Encounter
 ;;^UTILITY(U,$J,358.3,4172,1,4,0)
 ;;=4^Z02.89
 ;;^UTILITY(U,$J,358.3,4172,2)
 ;;=^5062645
 ;;^UTILITY(U,$J,358.3,4173,0)
 ;;=Z09.^^28^263^56
 ;;^UTILITY(U,$J,358.3,4173,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4173,1,3,0)
 ;;=3^F/U Exam After Treatment Encounter
 ;;^UTILITY(U,$J,358.3,4173,1,4,0)
 ;;=4^Z09.
 ;;^UTILITY(U,$J,358.3,4173,2)
 ;;=^5062668
 ;;^UTILITY(U,$J,358.3,4174,0)
 ;;=Z00.01^^28^263^60
 ;;^UTILITY(U,$J,358.3,4174,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4174,1,3,0)
 ;;=3^General Medical Exam w/ Abnormal Findings
 ;;^UTILITY(U,$J,358.3,4174,1,4,0)
 ;;=4^Z00.01
 ;;^UTILITY(U,$J,358.3,4174,2)
 ;;=^5062600
 ;;^UTILITY(U,$J,358.3,4175,0)
 ;;=Z00.00^^28^263^61
 ;;^UTILITY(U,$J,358.3,4175,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4175,1,3,0)
 ;;=3^General Medical Exam w/o Abnormal Findings
 ;;^UTILITY(U,$J,358.3,4175,1,4,0)
 ;;=4^Z00.00
 ;;^UTILITY(U,$J,358.3,4175,2)
 ;;=^5062599
 ;;^UTILITY(U,$J,358.3,4176,0)
 ;;=Z23.^^28^263^69
 ;;^UTILITY(U,$J,358.3,4176,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4176,1,3,0)
 ;;=3^Immunization Encounter
 ;;^UTILITY(U,$J,358.3,4176,1,4,0)
 ;;=4^Z23.
 ;;^UTILITY(U,$J,358.3,4176,2)
 ;;=^5062795
 ;;^UTILITY(U,$J,358.3,4177,0)
 ;;=Z03.89^^28^263^81
 ;;^UTILITY(U,$J,358.3,4177,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4177,1,3,0)
 ;;=3^Observation for Suspected Diseases/Ruled Out Conditions
 ;;^UTILITY(U,$J,358.3,4177,1,4,0)
 ;;=4^Z03.89
 ;;^UTILITY(U,$J,358.3,4177,2)
 ;;=^5062656
 ;;^UTILITY(U,$J,358.3,4178,0)
 ;;=Z04.9^^28^263^82
 ;;^UTILITY(U,$J,358.3,4178,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4178,1,3,0)
 ;;=3^Observation/Exam,Unspec Reason
 ;;^UTILITY(U,$J,358.3,4178,1,4,0)
 ;;=4^Z04.9
 ;;^UTILITY(U,$J,358.3,4178,2)
 ;;=^5062666
 ;;^UTILITY(U,$J,358.3,4179,0)
 ;;=Z51.5^^28^263^94
 ;;^UTILITY(U,$J,358.3,4179,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4179,1,3,0)
 ;;=3^Palliative Care Encounter
 ;;^UTILITY(U,$J,358.3,4179,1,4,0)
 ;;=4^Z51.5

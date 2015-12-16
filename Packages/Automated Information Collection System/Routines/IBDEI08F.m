IBDEI08F ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3466,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3466,1,2,0)
 ;;=2^290.40
 ;;^UTILITY(U,$J,358.3,3466,1,5,0)
 ;;=5^Vascular Dementia
 ;;^UTILITY(U,$J,358.3,3466,2)
 ;;=^303487
 ;;^UTILITY(U,$J,358.3,3467,0)
 ;;=291.2^^11^149^1
 ;;^UTILITY(U,$J,358.3,3467,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3467,1,2,0)
 ;;=2^291.2
 ;;^UTILITY(U,$J,358.3,3467,1,5,0)
 ;;=5^Alcoholic Dementia
 ;;^UTILITY(U,$J,358.3,3467,2)
 ;;=Alcoholic Dementia^268015
 ;;^UTILITY(U,$J,358.3,3468,0)
 ;;=290.0^^11^149^17
 ;;^UTILITY(U,$J,358.3,3468,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3468,1,2,0)
 ;;=2^290.0
 ;;^UTILITY(U,$J,358.3,3468,1,5,0)
 ;;=5^Senile Dementia, Uncomplicated
 ;;^UTILITY(U,$J,358.3,3468,2)
 ;;=^31700
 ;;^UTILITY(U,$J,358.3,3469,0)
 ;;=290.3^^11^149^15
 ;;^UTILITY(U,$J,358.3,3469,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3469,1,2,0)
 ;;=2^290.3
 ;;^UTILITY(U,$J,358.3,3469,1,5,0)
 ;;=5^Senile Dementia w/ Delirium
 ;;^UTILITY(U,$J,358.3,3469,2)
 ;;=^268009
 ;;^UTILITY(U,$J,358.3,3470,0)
 ;;=294.8^^11^149^13
 ;;^UTILITY(U,$J,358.3,3470,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3470,1,2,0)
 ;;=2^294.8
 ;;^UTILITY(U,$J,358.3,3470,1,5,0)
 ;;=5^Mental D/O d/t Oth Spec Condition
 ;;^UTILITY(U,$J,358.3,3470,2)
 ;;=^331843
 ;;^UTILITY(U,$J,358.3,3471,0)
 ;;=294.11^^11^149^7
 ;;^UTILITY(U,$J,358.3,3471,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3471,1,2,0)
 ;;=2^294.11
 ;;^UTILITY(U,$J,358.3,3471,1,5,0)
 ;;=5^Dementia d/t HIV w/ Behav Disturb
 ;;^UTILITY(U,$J,358.3,3471,2)
 ;;=^321982^042.
 ;;^UTILITY(U,$J,358.3,3472,0)
 ;;=294.20^^11^149^5
 ;;^UTILITY(U,$J,358.3,3472,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3472,1,2,0)
 ;;=2^294.20
 ;;^UTILITY(U,$J,358.3,3472,1,5,0)
 ;;=5^Dementia NOS w/o Behv Dstrb
 ;;^UTILITY(U,$J,358.3,3472,2)
 ;;=^340607
 ;;^UTILITY(U,$J,358.3,3473,0)
 ;;=294.21^^11^149^4
 ;;^UTILITY(U,$J,358.3,3473,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3473,1,2,0)
 ;;=2^294.21
 ;;^UTILITY(U,$J,358.3,3473,1,5,0)
 ;;=5^Dementia NOS w/ Behav Distrb
 ;;^UTILITY(U,$J,358.3,3473,2)
 ;;=^340505
 ;;^UTILITY(U,$J,358.3,3474,0)
 ;;=331.83^^11^149^14
 ;;^UTILITY(U,$J,358.3,3474,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3474,1,2,0)
 ;;=2^331.83
 ;;^UTILITY(U,$J,358.3,3474,1,5,0)
 ;;=5^Mild Cognitive Impairment
 ;;^UTILITY(U,$J,358.3,3474,2)
 ;;=^334065
 ;;^UTILITY(U,$J,358.3,3475,0)
 ;;=294.8^^11^149^6
 ;;^UTILITY(U,$J,358.3,3475,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3475,1,2,0)
 ;;=2^294.8
 ;;^UTILITY(U,$J,358.3,3475,1,5,0)
 ;;=5^Dementia d/t Brain Tumor
 ;;^UTILITY(U,$J,358.3,3475,2)
 ;;=^331843
 ;;^UTILITY(U,$J,358.3,3476,0)
 ;;=294.10^^11^149^8
 ;;^UTILITY(U,$J,358.3,3476,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3476,1,2,0)
 ;;=2^294.10
 ;;^UTILITY(U,$J,358.3,3476,1,5,0)
 ;;=5^Dementia d/t HIV w/o Behav Disturb
 ;;^UTILITY(U,$J,358.3,3476,2)
 ;;=^321980^042.
 ;;^UTILITY(U,$J,358.3,3477,0)
 ;;=294.11^^11^149^2
 ;;^UTILITY(U,$J,358.3,3477,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3477,1,2,0)
 ;;=2^294.11
 ;;^UTILITY(U,$J,358.3,3477,1,5,0)
 ;;=5^Alzheimers Dementia w/ Behav Disturb
 ;;^UTILITY(U,$J,358.3,3477,2)
 ;;=^321982^331.0
 ;;^UTILITY(U,$J,358.3,3478,0)
 ;;=294.10^^11^149^3
 ;;^UTILITY(U,$J,358.3,3478,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3478,1,2,0)
 ;;=2^294.10
 ;;^UTILITY(U,$J,358.3,3478,1,5,0)
 ;;=5^Alzheimers Dementia w/o Behav Disturb
 ;;^UTILITY(U,$J,358.3,3478,2)
 ;;=^321980^331.0
 ;;^UTILITY(U,$J,358.3,3479,0)
 ;;=294.10^^11^149^12
 ;;^UTILITY(U,$J,358.3,3479,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3479,1,2,0)
 ;;=2^294.10
 ;;^UTILITY(U,$J,358.3,3479,1,5,0)
 ;;=5^Dementia d/t Parkinson w/o Behav Disturb

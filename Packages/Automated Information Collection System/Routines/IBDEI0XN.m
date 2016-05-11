IBDEI0XN ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15775,1,3,0)
 ;;=3^Cocaine-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,15775,1,4,0)
 ;;=4^F14.182
 ;;^UTILITY(U,$J,358.3,15775,2)
 ;;=^5003250
 ;;^UTILITY(U,$J,358.3,15776,0)
 ;;=F14.20^^58^692^3
 ;;^UTILITY(U,$J,358.3,15776,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15776,1,3,0)
 ;;=3^Cocaine Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,15776,1,4,0)
 ;;=4^F14.20
 ;;^UTILITY(U,$J,358.3,15776,2)
 ;;=^5003253
 ;;^UTILITY(U,$J,358.3,15777,0)
 ;;=F14.21^^58^692^2
 ;;^UTILITY(U,$J,358.3,15777,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15777,1,3,0)
 ;;=3^Cocaine Use Disorder,Mod-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,15777,1,4,0)
 ;;=4^F14.21
 ;;^UTILITY(U,$J,358.3,15777,2)
 ;;=^5003254
 ;;^UTILITY(U,$J,358.3,15778,0)
 ;;=F14.23^^58^692^4
 ;;^UTILITY(U,$J,358.3,15778,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15778,1,3,0)
 ;;=3^Cocaine Withdrawal
 ;;^UTILITY(U,$J,358.3,15778,1,4,0)
 ;;=4^F14.23
 ;;^UTILITY(U,$J,358.3,15778,2)
 ;;=^5003259
 ;;^UTILITY(U,$J,358.3,15779,0)
 ;;=F43.0^^58^693^1
 ;;^UTILITY(U,$J,358.3,15779,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15779,1,3,0)
 ;;=3^Acute Stress Disorder
 ;;^UTILITY(U,$J,358.3,15779,1,4,0)
 ;;=4^F43.0
 ;;^UTILITY(U,$J,358.3,15779,2)
 ;;=^5003569
 ;;^UTILITY(U,$J,358.3,15780,0)
 ;;=F43.21^^58^693^3
 ;;^UTILITY(U,$J,358.3,15780,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15780,1,3,0)
 ;;=3^Adjustment Disorder w/ Depressed Mood
 ;;^UTILITY(U,$J,358.3,15780,1,4,0)
 ;;=4^F43.21
 ;;^UTILITY(U,$J,358.3,15780,2)
 ;;=^331948
 ;;^UTILITY(U,$J,358.3,15781,0)
 ;;=F43.22^^58^693^2
 ;;^UTILITY(U,$J,358.3,15781,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15781,1,3,0)
 ;;=3^Adjustment Disorder w/ Anxiety
 ;;^UTILITY(U,$J,358.3,15781,1,4,0)
 ;;=4^F43.22
 ;;^UTILITY(U,$J,358.3,15781,2)
 ;;=^331949
 ;;^UTILITY(U,$J,358.3,15782,0)
 ;;=F43.23^^58^693^5
 ;;^UTILITY(U,$J,358.3,15782,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15782,1,3,0)
 ;;=3^Adjustment Disorder w/ Mixed Anxiety & Depressed Mood
 ;;^UTILITY(U,$J,358.3,15782,1,4,0)
 ;;=4^F43.23
 ;;^UTILITY(U,$J,358.3,15782,2)
 ;;=^331950
 ;;^UTILITY(U,$J,358.3,15783,0)
 ;;=F43.24^^58^693^4
 ;;^UTILITY(U,$J,358.3,15783,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15783,1,3,0)
 ;;=3^Adjustment Disorder w/ Disturbance of Conduct
 ;;^UTILITY(U,$J,358.3,15783,1,4,0)
 ;;=4^F43.24
 ;;^UTILITY(U,$J,358.3,15783,2)
 ;;=^331951
 ;;^UTILITY(U,$J,358.3,15784,0)
 ;;=F43.25^^58^693^6
 ;;^UTILITY(U,$J,358.3,15784,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15784,1,3,0)
 ;;=3^Adjustment Disorder w/ Mixed Disturbance Emotions & Conduct
 ;;^UTILITY(U,$J,358.3,15784,1,4,0)
 ;;=4^F43.25
 ;;^UTILITY(U,$J,358.3,15784,2)
 ;;=^331952
 ;;^UTILITY(U,$J,358.3,15785,0)
 ;;=F43.8^^58^693^15
 ;;^UTILITY(U,$J,358.3,15785,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15785,1,3,0)
 ;;=3^Trauma/Stressor-Related Disorder NEC
 ;;^UTILITY(U,$J,358.3,15785,1,4,0)
 ;;=4^F43.8
 ;;^UTILITY(U,$J,358.3,15785,2)
 ;;=^5003575
 ;;^UTILITY(U,$J,358.3,15786,0)
 ;;=F43.20^^58^693^7
 ;;^UTILITY(U,$J,358.3,15786,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15786,1,3,0)
 ;;=3^Adjustment Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,15786,1,4,0)
 ;;=4^F43.20
 ;;^UTILITY(U,$J,358.3,15786,2)
 ;;=^5003573
 ;;^UTILITY(U,$J,358.3,15787,0)
 ;;=F43.9^^58^693^16
 ;;^UTILITY(U,$J,358.3,15787,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15787,1,3,0)
 ;;=3^Trauma/Stressor-Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,15787,1,4,0)
 ;;=4^F43.9
 ;;^UTILITY(U,$J,358.3,15787,2)
 ;;=^5003576
 ;;^UTILITY(U,$J,358.3,15788,0)
 ;;=F43.11^^58^693^9

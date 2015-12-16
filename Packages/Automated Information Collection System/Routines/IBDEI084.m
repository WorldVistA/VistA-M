IBDEI084 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3299,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3299,1,3,0)
 ;;=3^Nicotine Dependence,Oth Tobacco Product,Uncomplicated
 ;;^UTILITY(U,$J,358.3,3299,1,4,0)
 ;;=4^F17.290
 ;;^UTILITY(U,$J,358.3,3299,2)
 ;;=^5003375
 ;;^UTILITY(U,$J,358.3,3300,0)
 ;;=F17.291^^8^119^9
 ;;^UTILITY(U,$J,358.3,3300,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3300,1,3,0)
 ;;=3^Nicotine Dependence,Oth Tobacco Product,In Remission
 ;;^UTILITY(U,$J,358.3,3300,1,4,0)
 ;;=4^F17.291
 ;;^UTILITY(U,$J,358.3,3300,2)
 ;;=^5003376
 ;;^UTILITY(U,$J,358.3,3301,0)
 ;;=F14.10^^8^120^1
 ;;^UTILITY(U,$J,358.3,3301,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3301,1,3,0)
 ;;=3^Cocaine Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,3301,1,4,0)
 ;;=4^F14.10
 ;;^UTILITY(U,$J,358.3,3301,2)
 ;;=^5003239
 ;;^UTILITY(U,$J,358.3,3302,0)
 ;;=F14.14^^8^120^5
 ;;^UTILITY(U,$J,358.3,3302,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3302,1,3,0)
 ;;=3^Cocaine-Induced Depressive,Bipolar or Related Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,3302,1,4,0)
 ;;=4^F14.14
 ;;^UTILITY(U,$J,358.3,3302,2)
 ;;=^5003244
 ;;^UTILITY(U,$J,358.3,3303,0)
 ;;=F14.182^^8^120^6
 ;;^UTILITY(U,$J,358.3,3303,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3303,1,3,0)
 ;;=3^Cocaine-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,3303,1,4,0)
 ;;=4^F14.182
 ;;^UTILITY(U,$J,358.3,3303,2)
 ;;=^5003250
 ;;^UTILITY(U,$J,358.3,3304,0)
 ;;=F14.20^^8^120^3
 ;;^UTILITY(U,$J,358.3,3304,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3304,1,3,0)
 ;;=3^Cocaine Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,3304,1,4,0)
 ;;=4^F14.20
 ;;^UTILITY(U,$J,358.3,3304,2)
 ;;=^5003253
 ;;^UTILITY(U,$J,358.3,3305,0)
 ;;=F14.21^^8^120^2
 ;;^UTILITY(U,$J,358.3,3305,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3305,1,3,0)
 ;;=3^Cocaine Use Disorder,Mod-Sev,In Remission
 ;;^UTILITY(U,$J,358.3,3305,1,4,0)
 ;;=4^F14.21
 ;;^UTILITY(U,$J,358.3,3305,2)
 ;;=^5003254
 ;;^UTILITY(U,$J,358.3,3306,0)
 ;;=F14.23^^8^120^4
 ;;^UTILITY(U,$J,358.3,3306,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3306,1,3,0)
 ;;=3^Cocaine Withdrawal
 ;;^UTILITY(U,$J,358.3,3306,1,4,0)
 ;;=4^F14.23
 ;;^UTILITY(U,$J,358.3,3306,2)
 ;;=^5003259
 ;;^UTILITY(U,$J,358.3,3307,0)
 ;;=F43.0^^8^121^1
 ;;^UTILITY(U,$J,358.3,3307,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3307,1,3,0)
 ;;=3^Acute Stress Disorder
 ;;^UTILITY(U,$J,358.3,3307,1,4,0)
 ;;=4^F43.0
 ;;^UTILITY(U,$J,358.3,3307,2)
 ;;=^5003569
 ;;^UTILITY(U,$J,358.3,3308,0)
 ;;=F43.21^^8^121^3
 ;;^UTILITY(U,$J,358.3,3308,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3308,1,3,0)
 ;;=3^Adjustment Disorder w/ Depressed Mood
 ;;^UTILITY(U,$J,358.3,3308,1,4,0)
 ;;=4^F43.21
 ;;^UTILITY(U,$J,358.3,3308,2)
 ;;=^331948
 ;;^UTILITY(U,$J,358.3,3309,0)
 ;;=F43.22^^8^121^2
 ;;^UTILITY(U,$J,358.3,3309,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3309,1,3,0)
 ;;=3^Adjustment Disorder w/ Anxiety
 ;;^UTILITY(U,$J,358.3,3309,1,4,0)
 ;;=4^F43.22
 ;;^UTILITY(U,$J,358.3,3309,2)
 ;;=^331949
 ;;^UTILITY(U,$J,358.3,3310,0)
 ;;=F43.23^^8^121^5
 ;;^UTILITY(U,$J,358.3,3310,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3310,1,3,0)
 ;;=3^Adjustment Disorder w/ Mixed Anxiety & Depressed Mood
 ;;^UTILITY(U,$J,358.3,3310,1,4,0)
 ;;=4^F43.23
 ;;^UTILITY(U,$J,358.3,3310,2)
 ;;=^331950
 ;;^UTILITY(U,$J,358.3,3311,0)
 ;;=F43.24^^8^121^4
 ;;^UTILITY(U,$J,358.3,3311,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3311,1,3,0)
 ;;=3^Adjustment Disorder w/ Disturbance of Conduct
 ;;^UTILITY(U,$J,358.3,3311,1,4,0)
 ;;=4^F43.24
 ;;^UTILITY(U,$J,358.3,3311,2)
 ;;=^331951
 ;;^UTILITY(U,$J,358.3,3312,0)
 ;;=F43.25^^8^121^6

IBDEI1Y7 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,32611,1,3,0)
 ;;=3^Nicotine Dependence,Oth Tobacco Product,In Remission
 ;;^UTILITY(U,$J,358.3,32611,1,4,0)
 ;;=4^F17.291
 ;;^UTILITY(U,$J,358.3,32611,2)
 ;;=^5003376
 ;;^UTILITY(U,$J,358.3,32612,0)
 ;;=F14.10^^143^1551^1
 ;;^UTILITY(U,$J,358.3,32612,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32612,1,3,0)
 ;;=3^Cocaine Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,32612,1,4,0)
 ;;=4^F14.10
 ;;^UTILITY(U,$J,358.3,32612,2)
 ;;=^5003239
 ;;^UTILITY(U,$J,358.3,32613,0)
 ;;=F14.14^^143^1551^5
 ;;^UTILITY(U,$J,358.3,32613,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32613,1,3,0)
 ;;=3^Cocaine-Induced Depressive,Bipolar or Related Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,32613,1,4,0)
 ;;=4^F14.14
 ;;^UTILITY(U,$J,358.3,32613,2)
 ;;=^5003244
 ;;^UTILITY(U,$J,358.3,32614,0)
 ;;=F14.182^^143^1551^6
 ;;^UTILITY(U,$J,358.3,32614,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32614,1,3,0)
 ;;=3^Cocaine-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,32614,1,4,0)
 ;;=4^F14.182
 ;;^UTILITY(U,$J,358.3,32614,2)
 ;;=^5003250
 ;;^UTILITY(U,$J,358.3,32615,0)
 ;;=F14.20^^143^1551^3
 ;;^UTILITY(U,$J,358.3,32615,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32615,1,3,0)
 ;;=3^Cocaine Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,32615,1,4,0)
 ;;=4^F14.20
 ;;^UTILITY(U,$J,358.3,32615,2)
 ;;=^5003253
 ;;^UTILITY(U,$J,358.3,32616,0)
 ;;=F14.21^^143^1551^2
 ;;^UTILITY(U,$J,358.3,32616,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32616,1,3,0)
 ;;=3^Cocaine Use Disorder,Mod-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,32616,1,4,0)
 ;;=4^F14.21
 ;;^UTILITY(U,$J,358.3,32616,2)
 ;;=^5003254
 ;;^UTILITY(U,$J,358.3,32617,0)
 ;;=F14.23^^143^1551^4
 ;;^UTILITY(U,$J,358.3,32617,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32617,1,3,0)
 ;;=3^Cocaine Withdrawal
 ;;^UTILITY(U,$J,358.3,32617,1,4,0)
 ;;=4^F14.23
 ;;^UTILITY(U,$J,358.3,32617,2)
 ;;=^5003259
 ;;^UTILITY(U,$J,358.3,32618,0)
 ;;=F43.0^^143^1552^1
 ;;^UTILITY(U,$J,358.3,32618,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32618,1,3,0)
 ;;=3^Acute Stress Disorder
 ;;^UTILITY(U,$J,358.3,32618,1,4,0)
 ;;=4^F43.0
 ;;^UTILITY(U,$J,358.3,32618,2)
 ;;=^5003569
 ;;^UTILITY(U,$J,358.3,32619,0)
 ;;=F43.21^^143^1552^3
 ;;^UTILITY(U,$J,358.3,32619,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32619,1,3,0)
 ;;=3^Adjustment Disorder w/ Depressed Mood
 ;;^UTILITY(U,$J,358.3,32619,1,4,0)
 ;;=4^F43.21
 ;;^UTILITY(U,$J,358.3,32619,2)
 ;;=^331948
 ;;^UTILITY(U,$J,358.3,32620,0)
 ;;=F43.22^^143^1552^2
 ;;^UTILITY(U,$J,358.3,32620,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32620,1,3,0)
 ;;=3^Adjustment Disorder w/ Anxiety
 ;;^UTILITY(U,$J,358.3,32620,1,4,0)
 ;;=4^F43.22
 ;;^UTILITY(U,$J,358.3,32620,2)
 ;;=^331949
 ;;^UTILITY(U,$J,358.3,32621,0)
 ;;=F43.23^^143^1552^5
 ;;^UTILITY(U,$J,358.3,32621,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32621,1,3,0)
 ;;=3^Adjustment Disorder w/ Mixed Anxiety & Depressed Mood
 ;;^UTILITY(U,$J,358.3,32621,1,4,0)
 ;;=4^F43.23
 ;;^UTILITY(U,$J,358.3,32621,2)
 ;;=^331950
 ;;^UTILITY(U,$J,358.3,32622,0)
 ;;=F43.24^^143^1552^4
 ;;^UTILITY(U,$J,358.3,32622,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32622,1,3,0)
 ;;=3^Adjustment Disorder w/ Disturbance of Conduct
 ;;^UTILITY(U,$J,358.3,32622,1,4,0)
 ;;=4^F43.24
 ;;^UTILITY(U,$J,358.3,32622,2)
 ;;=^331951
 ;;^UTILITY(U,$J,358.3,32623,0)
 ;;=F43.25^^143^1552^6
 ;;^UTILITY(U,$J,358.3,32623,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32623,1,3,0)
 ;;=3^Adjustment Disorder w/ Mixed Disturbance Emotions & Conduct
 ;;^UTILITY(U,$J,358.3,32623,1,4,0)
 ;;=4^F43.25

IBDEI1FP ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24369,1,4,0)
 ;;=4^F17.211
 ;;^UTILITY(U,$J,358.3,24369,2)
 ;;=^5003366
 ;;^UTILITY(U,$J,358.3,24370,0)
 ;;=F17.220^^90^1068^2
 ;;^UTILITY(U,$J,358.3,24370,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24370,1,3,0)
 ;;=3^Nicotine Dependence,Chewing Tobacco,Uncomplicated
 ;;^UTILITY(U,$J,358.3,24370,1,4,0)
 ;;=4^F17.220
 ;;^UTILITY(U,$J,358.3,24370,2)
 ;;=^5003370
 ;;^UTILITY(U,$J,358.3,24371,0)
 ;;=F17.221^^90^1068^1
 ;;^UTILITY(U,$J,358.3,24371,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24371,1,3,0)
 ;;=3^Nicotine Dependence,Chewing Tobacco,In Remission
 ;;^UTILITY(U,$J,358.3,24371,1,4,0)
 ;;=4^F17.221
 ;;^UTILITY(U,$J,358.3,24371,2)
 ;;=^5003371
 ;;^UTILITY(U,$J,358.3,24372,0)
 ;;=F17.290^^90^1068^5
 ;;^UTILITY(U,$J,358.3,24372,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24372,1,3,0)
 ;;=3^Nicotine Dependence,Oth Tobacco Product,Uncomplicated
 ;;^UTILITY(U,$J,358.3,24372,1,4,0)
 ;;=4^F17.290
 ;;^UTILITY(U,$J,358.3,24372,2)
 ;;=^5003375
 ;;^UTILITY(U,$J,358.3,24373,0)
 ;;=F17.291^^90^1068^6
 ;;^UTILITY(U,$J,358.3,24373,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24373,1,3,0)
 ;;=3^Nicotine Dependence,Oth Tobacco Product,In Remission
 ;;^UTILITY(U,$J,358.3,24373,1,4,0)
 ;;=4^F17.291
 ;;^UTILITY(U,$J,358.3,24373,2)
 ;;=^5003376
 ;;^UTILITY(U,$J,358.3,24374,0)
 ;;=F17.208^^90^1068^7
 ;;^UTILITY(U,$J,358.3,24374,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24374,1,3,0)
 ;;=3^Nicotine Induced Sleep Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,24374,1,4,0)
 ;;=4^F17.208
 ;;^UTILITY(U,$J,358.3,24374,2)
 ;;=^5003363
 ;;^UTILITY(U,$J,358.3,24375,0)
 ;;=F17.209^^90^1068^8
 ;;^UTILITY(U,$J,358.3,24375,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24375,1,3,0)
 ;;=3^Nicotine Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,24375,1,4,0)
 ;;=4^F17.209
 ;;^UTILITY(U,$J,358.3,24375,2)
 ;;=^5003364
 ;;^UTILITY(U,$J,358.3,24376,0)
 ;;=F14.10^^90^1069^1
 ;;^UTILITY(U,$J,358.3,24376,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24376,1,3,0)
 ;;=3^Cocaine Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,24376,1,4,0)
 ;;=4^F14.10
 ;;^UTILITY(U,$J,358.3,24376,2)
 ;;=^5003239
 ;;^UTILITY(U,$J,358.3,24377,0)
 ;;=F14.14^^90^1069^5
 ;;^UTILITY(U,$J,358.3,24377,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24377,1,3,0)
 ;;=3^Cocaine-Induced Depressive,Bipolar or Related Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,24377,1,4,0)
 ;;=4^F14.14
 ;;^UTILITY(U,$J,358.3,24377,2)
 ;;=^5003244
 ;;^UTILITY(U,$J,358.3,24378,0)
 ;;=F14.182^^90^1069^6
 ;;^UTILITY(U,$J,358.3,24378,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24378,1,3,0)
 ;;=3^Cocaine-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,24378,1,4,0)
 ;;=4^F14.182
 ;;^UTILITY(U,$J,358.3,24378,2)
 ;;=^5003250
 ;;^UTILITY(U,$J,358.3,24379,0)
 ;;=F14.20^^90^1069^3
 ;;^UTILITY(U,$J,358.3,24379,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24379,1,3,0)
 ;;=3^Cocaine Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,24379,1,4,0)
 ;;=4^F14.20
 ;;^UTILITY(U,$J,358.3,24379,2)
 ;;=^5003253
 ;;^UTILITY(U,$J,358.3,24380,0)
 ;;=F14.21^^90^1069^2
 ;;^UTILITY(U,$J,358.3,24380,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24380,1,3,0)
 ;;=3^Cocaine Use Disorder,Mod-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,24380,1,4,0)
 ;;=4^F14.21
 ;;^UTILITY(U,$J,358.3,24380,2)
 ;;=^5003254
 ;;^UTILITY(U,$J,358.3,24381,0)
 ;;=F14.23^^90^1069^4
 ;;^UTILITY(U,$J,358.3,24381,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24381,1,3,0)
 ;;=3^Cocaine Withdrawal
 ;;^UTILITY(U,$J,358.3,24381,1,4,0)
 ;;=4^F14.23
 ;;^UTILITY(U,$J,358.3,24381,2)
 ;;=^5003259

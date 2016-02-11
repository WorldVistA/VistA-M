IBDEI2AA ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,38349,1,4,0)
 ;;=4^F17.201
 ;;^UTILITY(U,$J,358.3,38349,2)
 ;;=^5003361
 ;;^UTILITY(U,$J,358.3,38350,0)
 ;;=F17.203^^177^1947^3
 ;;^UTILITY(U,$J,358.3,38350,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38350,1,3,0)
 ;;=3^Tobacco Withdrawal
 ;;^UTILITY(U,$J,358.3,38350,1,4,0)
 ;;=4^F17.203
 ;;^UTILITY(U,$J,358.3,38350,2)
 ;;=^5003362
 ;;^UTILITY(U,$J,358.3,38351,0)
 ;;=F17.210^^177^1947^4
 ;;^UTILITY(U,$J,358.3,38351,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38351,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes,Uncomplicated
 ;;^UTILITY(U,$J,358.3,38351,1,4,0)
 ;;=4^F17.210
 ;;^UTILITY(U,$J,358.3,38351,2)
 ;;=^5003365
 ;;^UTILITY(U,$J,358.3,38352,0)
 ;;=F17.211^^177^1947^5
 ;;^UTILITY(U,$J,358.3,38352,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38352,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes,In Remission
 ;;^UTILITY(U,$J,358.3,38352,1,4,0)
 ;;=4^F17.211
 ;;^UTILITY(U,$J,358.3,38352,2)
 ;;=^5003366
 ;;^UTILITY(U,$J,358.3,38353,0)
 ;;=F17.220^^177^1947^6
 ;;^UTILITY(U,$J,358.3,38353,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38353,1,3,0)
 ;;=3^Nicotine Dependence,Chewing Tobacco,Uncomplicated
 ;;^UTILITY(U,$J,358.3,38353,1,4,0)
 ;;=4^F17.220
 ;;^UTILITY(U,$J,358.3,38353,2)
 ;;=^5003370
 ;;^UTILITY(U,$J,358.3,38354,0)
 ;;=F17.221^^177^1947^7
 ;;^UTILITY(U,$J,358.3,38354,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38354,1,3,0)
 ;;=3^Nicotine Dependence,Chewing Tobacco,In Remission
 ;;^UTILITY(U,$J,358.3,38354,1,4,0)
 ;;=4^F17.221
 ;;^UTILITY(U,$J,358.3,38354,2)
 ;;=^5003371
 ;;^UTILITY(U,$J,358.3,38355,0)
 ;;=F17.290^^177^1947^8
 ;;^UTILITY(U,$J,358.3,38355,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38355,1,3,0)
 ;;=3^Nicotine Dependence,Oth Tobacco Product,Uncomplicated
 ;;^UTILITY(U,$J,358.3,38355,1,4,0)
 ;;=4^F17.290
 ;;^UTILITY(U,$J,358.3,38355,2)
 ;;=^5003375
 ;;^UTILITY(U,$J,358.3,38356,0)
 ;;=F17.291^^177^1947^9
 ;;^UTILITY(U,$J,358.3,38356,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38356,1,3,0)
 ;;=3^Nicotine Dependence,Oth Tobacco Product,In Remission
 ;;^UTILITY(U,$J,358.3,38356,1,4,0)
 ;;=4^F17.291
 ;;^UTILITY(U,$J,358.3,38356,2)
 ;;=^5003376
 ;;^UTILITY(U,$J,358.3,38357,0)
 ;;=F14.10^^177^1948^1
 ;;^UTILITY(U,$J,358.3,38357,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38357,1,3,0)
 ;;=3^Cocaine Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,38357,1,4,0)
 ;;=4^F14.10
 ;;^UTILITY(U,$J,358.3,38357,2)
 ;;=^5003239
 ;;^UTILITY(U,$J,358.3,38358,0)
 ;;=F14.14^^177^1948^5
 ;;^UTILITY(U,$J,358.3,38358,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38358,1,3,0)
 ;;=3^Cocaine-Induced Depressive,Bipolar or Related Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,38358,1,4,0)
 ;;=4^F14.14
 ;;^UTILITY(U,$J,358.3,38358,2)
 ;;=^5003244
 ;;^UTILITY(U,$J,358.3,38359,0)
 ;;=F14.182^^177^1948^6
 ;;^UTILITY(U,$J,358.3,38359,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38359,1,3,0)
 ;;=3^Cocaine-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,38359,1,4,0)
 ;;=4^F14.182
 ;;^UTILITY(U,$J,358.3,38359,2)
 ;;=^5003250
 ;;^UTILITY(U,$J,358.3,38360,0)
 ;;=F14.20^^177^1948^3
 ;;^UTILITY(U,$J,358.3,38360,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38360,1,3,0)
 ;;=3^Cocaine Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,38360,1,4,0)
 ;;=4^F14.20
 ;;^UTILITY(U,$J,358.3,38360,2)
 ;;=^5003253
 ;;^UTILITY(U,$J,358.3,38361,0)
 ;;=F14.21^^177^1948^2
 ;;^UTILITY(U,$J,358.3,38361,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38361,1,3,0)
 ;;=3^Cocaine Use Disorder,Mod-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,38361,1,4,0)
 ;;=4^F14.21
 ;;^UTILITY(U,$J,358.3,38361,2)
 ;;=^5003254

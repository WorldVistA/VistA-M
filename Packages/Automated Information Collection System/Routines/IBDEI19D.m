IBDEI19D ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,21039,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,21039,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,21040,0)
 ;;=F17.201^^99^1014^2
 ;;^UTILITY(U,$J,358.3,21040,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21040,1,3,0)
 ;;=3^Tobacco Use Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,21040,1,4,0)
 ;;=4^F17.201
 ;;^UTILITY(U,$J,358.3,21040,2)
 ;;=^5003361
 ;;^UTILITY(U,$J,358.3,21041,0)
 ;;=F17.203^^99^1014^3
 ;;^UTILITY(U,$J,358.3,21041,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21041,1,3,0)
 ;;=3^Tobacco Withdrawal
 ;;^UTILITY(U,$J,358.3,21041,1,4,0)
 ;;=4^F17.203
 ;;^UTILITY(U,$J,358.3,21041,2)
 ;;=^5003362
 ;;^UTILITY(U,$J,358.3,21042,0)
 ;;=F17.210^^99^1014^4
 ;;^UTILITY(U,$J,358.3,21042,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21042,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes,Uncomplicated
 ;;^UTILITY(U,$J,358.3,21042,1,4,0)
 ;;=4^F17.210
 ;;^UTILITY(U,$J,358.3,21042,2)
 ;;=^5003365
 ;;^UTILITY(U,$J,358.3,21043,0)
 ;;=F17.211^^99^1014^5
 ;;^UTILITY(U,$J,358.3,21043,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21043,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes,In Remission
 ;;^UTILITY(U,$J,358.3,21043,1,4,0)
 ;;=4^F17.211
 ;;^UTILITY(U,$J,358.3,21043,2)
 ;;=^5003366
 ;;^UTILITY(U,$J,358.3,21044,0)
 ;;=F17.220^^99^1014^6
 ;;^UTILITY(U,$J,358.3,21044,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21044,1,3,0)
 ;;=3^Nicotine Dependence,Chewing Tobacco,Uncomplicated
 ;;^UTILITY(U,$J,358.3,21044,1,4,0)
 ;;=4^F17.220
 ;;^UTILITY(U,$J,358.3,21044,2)
 ;;=^5003370
 ;;^UTILITY(U,$J,358.3,21045,0)
 ;;=F17.221^^99^1014^7
 ;;^UTILITY(U,$J,358.3,21045,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21045,1,3,0)
 ;;=3^Nicotine Dependence,Chewing Tobacco,In Remission
 ;;^UTILITY(U,$J,358.3,21045,1,4,0)
 ;;=4^F17.221
 ;;^UTILITY(U,$J,358.3,21045,2)
 ;;=^5003371
 ;;^UTILITY(U,$J,358.3,21046,0)
 ;;=F17.290^^99^1014^8
 ;;^UTILITY(U,$J,358.3,21046,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21046,1,3,0)
 ;;=3^Nicotine Dependence,Oth Tobacco Product,Uncomplicated
 ;;^UTILITY(U,$J,358.3,21046,1,4,0)
 ;;=4^F17.290
 ;;^UTILITY(U,$J,358.3,21046,2)
 ;;=^5003375
 ;;^UTILITY(U,$J,358.3,21047,0)
 ;;=F17.291^^99^1014^9
 ;;^UTILITY(U,$J,358.3,21047,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21047,1,3,0)
 ;;=3^Nicotine Dependence,Oth Tobacco Product,In Remission
 ;;^UTILITY(U,$J,358.3,21047,1,4,0)
 ;;=4^F17.291
 ;;^UTILITY(U,$J,358.3,21047,2)
 ;;=^5003376
 ;;^UTILITY(U,$J,358.3,21048,0)
 ;;=F14.10^^99^1015^1
 ;;^UTILITY(U,$J,358.3,21048,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21048,1,3,0)
 ;;=3^Cocaine Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,21048,1,4,0)
 ;;=4^F14.10
 ;;^UTILITY(U,$J,358.3,21048,2)
 ;;=^5003239
 ;;^UTILITY(U,$J,358.3,21049,0)
 ;;=F14.14^^99^1015^5
 ;;^UTILITY(U,$J,358.3,21049,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21049,1,3,0)
 ;;=3^Cocaine-Induced Depressive,Bipolar or Related Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,21049,1,4,0)
 ;;=4^F14.14
 ;;^UTILITY(U,$J,358.3,21049,2)
 ;;=^5003244
 ;;^UTILITY(U,$J,358.3,21050,0)
 ;;=F14.182^^99^1015^6
 ;;^UTILITY(U,$J,358.3,21050,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21050,1,3,0)
 ;;=3^Cocaine-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,21050,1,4,0)
 ;;=4^F14.182
 ;;^UTILITY(U,$J,358.3,21050,2)
 ;;=^5003250
 ;;^UTILITY(U,$J,358.3,21051,0)
 ;;=F14.20^^99^1015^3
 ;;^UTILITY(U,$J,358.3,21051,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21051,1,3,0)
 ;;=3^Cocaine Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,21051,1,4,0)
 ;;=4^F14.20
 ;;^UTILITY(U,$J,358.3,21051,2)
 ;;=^5003253

IBDEI1WE ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31782,1,3,0)
 ;;=3^Tobacco Withdrawal
 ;;^UTILITY(U,$J,358.3,31782,1,4,0)
 ;;=4^F17.203
 ;;^UTILITY(U,$J,358.3,31782,2)
 ;;=^5003362
 ;;^UTILITY(U,$J,358.3,31783,0)
 ;;=F17.210^^138^1458^4
 ;;^UTILITY(U,$J,358.3,31783,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31783,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes,Uncomplicated
 ;;^UTILITY(U,$J,358.3,31783,1,4,0)
 ;;=4^F17.210
 ;;^UTILITY(U,$J,358.3,31783,2)
 ;;=^5003365
 ;;^UTILITY(U,$J,358.3,31784,0)
 ;;=F17.211^^138^1458^5
 ;;^UTILITY(U,$J,358.3,31784,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31784,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes,In Remission
 ;;^UTILITY(U,$J,358.3,31784,1,4,0)
 ;;=4^F17.211
 ;;^UTILITY(U,$J,358.3,31784,2)
 ;;=^5003366
 ;;^UTILITY(U,$J,358.3,31785,0)
 ;;=F17.220^^138^1458^6
 ;;^UTILITY(U,$J,358.3,31785,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31785,1,3,0)
 ;;=3^Nicotine Dependence,Chewing Tobacco,Uncomplicated
 ;;^UTILITY(U,$J,358.3,31785,1,4,0)
 ;;=4^F17.220
 ;;^UTILITY(U,$J,358.3,31785,2)
 ;;=^5003370
 ;;^UTILITY(U,$J,358.3,31786,0)
 ;;=F17.221^^138^1458^7
 ;;^UTILITY(U,$J,358.3,31786,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31786,1,3,0)
 ;;=3^Nicotine Dependence,Chewing Tobacco,In Remission
 ;;^UTILITY(U,$J,358.3,31786,1,4,0)
 ;;=4^F17.221
 ;;^UTILITY(U,$J,358.3,31786,2)
 ;;=^5003371
 ;;^UTILITY(U,$J,358.3,31787,0)
 ;;=F17.290^^138^1458^8
 ;;^UTILITY(U,$J,358.3,31787,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31787,1,3,0)
 ;;=3^Nicotine Dependence,Oth Tobacco Product,Uncomplicated
 ;;^UTILITY(U,$J,358.3,31787,1,4,0)
 ;;=4^F17.290
 ;;^UTILITY(U,$J,358.3,31787,2)
 ;;=^5003375
 ;;^UTILITY(U,$J,358.3,31788,0)
 ;;=F17.291^^138^1458^9
 ;;^UTILITY(U,$J,358.3,31788,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31788,1,3,0)
 ;;=3^Nicotine Dependence,Oth Tobacco Product,In Remission
 ;;^UTILITY(U,$J,358.3,31788,1,4,0)
 ;;=4^F17.291
 ;;^UTILITY(U,$J,358.3,31788,2)
 ;;=^5003376
 ;;^UTILITY(U,$J,358.3,31789,0)
 ;;=F14.10^^138^1459^1
 ;;^UTILITY(U,$J,358.3,31789,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31789,1,3,0)
 ;;=3^Cocaine Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,31789,1,4,0)
 ;;=4^F14.10
 ;;^UTILITY(U,$J,358.3,31789,2)
 ;;=^5003239
 ;;^UTILITY(U,$J,358.3,31790,0)
 ;;=F14.14^^138^1459^5
 ;;^UTILITY(U,$J,358.3,31790,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31790,1,3,0)
 ;;=3^Cocaine-Induced Depressive,Bipolar or Related Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,31790,1,4,0)
 ;;=4^F14.14
 ;;^UTILITY(U,$J,358.3,31790,2)
 ;;=^5003244
 ;;^UTILITY(U,$J,358.3,31791,0)
 ;;=F14.182^^138^1459^6
 ;;^UTILITY(U,$J,358.3,31791,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31791,1,3,0)
 ;;=3^Cocaine-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,31791,1,4,0)
 ;;=4^F14.182
 ;;^UTILITY(U,$J,358.3,31791,2)
 ;;=^5003250
 ;;^UTILITY(U,$J,358.3,31792,0)
 ;;=F14.20^^138^1459^3
 ;;^UTILITY(U,$J,358.3,31792,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31792,1,3,0)
 ;;=3^Cocaine Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,31792,1,4,0)
 ;;=4^F14.20
 ;;^UTILITY(U,$J,358.3,31792,2)
 ;;=^5003253
 ;;^UTILITY(U,$J,358.3,31793,0)
 ;;=F14.21^^138^1459^2
 ;;^UTILITY(U,$J,358.3,31793,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31793,1,3,0)
 ;;=3^Cocaine Use Disorder,Mod-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,31793,1,4,0)
 ;;=4^F14.21
 ;;^UTILITY(U,$J,358.3,31793,2)
 ;;=^5003254
 ;;^UTILITY(U,$J,358.3,31794,0)
 ;;=F14.23^^138^1459^4
 ;;^UTILITY(U,$J,358.3,31794,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31794,1,3,0)
 ;;=3^Cocaine Withdrawal
 ;;^UTILITY(U,$J,358.3,31794,1,4,0)
 ;;=4^F14.23

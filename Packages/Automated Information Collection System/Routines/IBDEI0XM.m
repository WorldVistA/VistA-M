IBDEI0XM ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15763,0)
 ;;=F17.201^^58^691^10
 ;;^UTILITY(U,$J,358.3,15763,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15763,1,3,0)
 ;;=3^Nicotine Use Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,15763,1,4,0)
 ;;=4^F17.201
 ;;^UTILITY(U,$J,358.3,15763,2)
 ;;=^5003361
 ;;^UTILITY(U,$J,358.3,15764,0)
 ;;=F17.203^^58^691^11
 ;;^UTILITY(U,$J,358.3,15764,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15764,1,3,0)
 ;;=3^Nicotine Withdrawal
 ;;^UTILITY(U,$J,358.3,15764,1,4,0)
 ;;=4^F17.203
 ;;^UTILITY(U,$J,358.3,15764,2)
 ;;=^5003362
 ;;^UTILITY(U,$J,358.3,15765,0)
 ;;=F17.210^^58^691^4
 ;;^UTILITY(U,$J,358.3,15765,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15765,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes,Uncomplicated
 ;;^UTILITY(U,$J,358.3,15765,1,4,0)
 ;;=4^F17.210
 ;;^UTILITY(U,$J,358.3,15765,2)
 ;;=^5003365
 ;;^UTILITY(U,$J,358.3,15766,0)
 ;;=F17.211^^58^691^3
 ;;^UTILITY(U,$J,358.3,15766,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15766,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes,In Remission
 ;;^UTILITY(U,$J,358.3,15766,1,4,0)
 ;;=4^F17.211
 ;;^UTILITY(U,$J,358.3,15766,2)
 ;;=^5003366
 ;;^UTILITY(U,$J,358.3,15767,0)
 ;;=F17.220^^58^691^2
 ;;^UTILITY(U,$J,358.3,15767,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15767,1,3,0)
 ;;=3^Nicotine Dependence,Chewing Tobacco,Uncomplicated
 ;;^UTILITY(U,$J,358.3,15767,1,4,0)
 ;;=4^F17.220
 ;;^UTILITY(U,$J,358.3,15767,2)
 ;;=^5003370
 ;;^UTILITY(U,$J,358.3,15768,0)
 ;;=F17.221^^58^691^1
 ;;^UTILITY(U,$J,358.3,15768,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15768,1,3,0)
 ;;=3^Nicotine Dependence,Chewing Tobacco,In Remission
 ;;^UTILITY(U,$J,358.3,15768,1,4,0)
 ;;=4^F17.221
 ;;^UTILITY(U,$J,358.3,15768,2)
 ;;=^5003371
 ;;^UTILITY(U,$J,358.3,15769,0)
 ;;=F17.290^^58^691^5
 ;;^UTILITY(U,$J,358.3,15769,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15769,1,3,0)
 ;;=3^Nicotine Dependence,Oth Tobacco Product,Uncomplicated
 ;;^UTILITY(U,$J,358.3,15769,1,4,0)
 ;;=4^F17.290
 ;;^UTILITY(U,$J,358.3,15769,2)
 ;;=^5003375
 ;;^UTILITY(U,$J,358.3,15770,0)
 ;;=F17.291^^58^691^6
 ;;^UTILITY(U,$J,358.3,15770,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15770,1,3,0)
 ;;=3^Nicotine Dependence,Oth Tobacco Product,In Remission
 ;;^UTILITY(U,$J,358.3,15770,1,4,0)
 ;;=4^F17.291
 ;;^UTILITY(U,$J,358.3,15770,2)
 ;;=^5003376
 ;;^UTILITY(U,$J,358.3,15771,0)
 ;;=F17.208^^58^691^7
 ;;^UTILITY(U,$J,358.3,15771,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15771,1,3,0)
 ;;=3^Nicotine Induced Sleep Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,15771,1,4,0)
 ;;=4^F17.208
 ;;^UTILITY(U,$J,358.3,15771,2)
 ;;=^5003363
 ;;^UTILITY(U,$J,358.3,15772,0)
 ;;=F17.209^^58^691^8
 ;;^UTILITY(U,$J,358.3,15772,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15772,1,3,0)
 ;;=3^Nicotine Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,15772,1,4,0)
 ;;=4^F17.209
 ;;^UTILITY(U,$J,358.3,15772,2)
 ;;=^5003364
 ;;^UTILITY(U,$J,358.3,15773,0)
 ;;=F14.10^^58^692^1
 ;;^UTILITY(U,$J,358.3,15773,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15773,1,3,0)
 ;;=3^Cocaine Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,15773,1,4,0)
 ;;=4^F14.10
 ;;^UTILITY(U,$J,358.3,15773,2)
 ;;=^5003239
 ;;^UTILITY(U,$J,358.3,15774,0)
 ;;=F14.14^^58^692^5
 ;;^UTILITY(U,$J,358.3,15774,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15774,1,3,0)
 ;;=3^Cocaine-Induced Depressive,Bipolar or Related Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,15774,1,4,0)
 ;;=4^F14.14
 ;;^UTILITY(U,$J,358.3,15774,2)
 ;;=^5003244
 ;;^UTILITY(U,$J,358.3,15775,0)
 ;;=F14.182^^58^692^6
 ;;^UTILITY(U,$J,358.3,15775,1,0)
 ;;=^358.31IA^4^2

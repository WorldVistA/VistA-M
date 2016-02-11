IBDEI16U ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,19853,1,4,0)
 ;;=4^F14.222
 ;;^UTILITY(U,$J,358.3,19853,2)
 ;;=^5003257
 ;;^UTILITY(U,$J,358.3,19854,0)
 ;;=F14.221^^94^930^16
 ;;^UTILITY(U,$J,358.3,19854,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19854,1,3,0)
 ;;=3^Cocaine Dependence w/ Intoxication Delirium
 ;;^UTILITY(U,$J,358.3,19854,1,4,0)
 ;;=4^F14.221
 ;;^UTILITY(U,$J,358.3,19854,2)
 ;;=^5003256
 ;;^UTILITY(U,$J,358.3,19855,0)
 ;;=F14.220^^94^930^18
 ;;^UTILITY(U,$J,358.3,19855,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19855,1,3,0)
 ;;=3^Cocaine Dependence w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,19855,1,4,0)
 ;;=4^F14.220
 ;;^UTILITY(U,$J,358.3,19855,2)
 ;;=^5003255
 ;;^UTILITY(U,$J,358.3,19856,0)
 ;;=F14.20^^94^930^23
 ;;^UTILITY(U,$J,358.3,19856,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19856,1,3,0)
 ;;=3^Cocaine Dependence,Uncompicated
 ;;^UTILITY(U,$J,358.3,19856,1,4,0)
 ;;=4^F14.20
 ;;^UTILITY(U,$J,358.3,19856,2)
 ;;=^5003253
 ;;^UTILITY(U,$J,358.3,19857,0)
 ;;=F10.120^^94^930^1
 ;;^UTILITY(U,$J,358.3,19857,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19857,1,3,0)
 ;;=3^Alcohol Abuse w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,19857,1,4,0)
 ;;=4^F10.120
 ;;^UTILITY(U,$J,358.3,19857,2)
 ;;=^5003069
 ;;^UTILITY(U,$J,358.3,19858,0)
 ;;=F10.10^^94^930^2
 ;;^UTILITY(U,$J,358.3,19858,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19858,1,3,0)
 ;;=3^Alcohol Abuse,Uncomplicated
 ;;^UTILITY(U,$J,358.3,19858,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,19858,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,19859,0)
 ;;=F17.201^^94^930^28
 ;;^UTILITY(U,$J,358.3,19859,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19859,1,3,0)
 ;;=3^Nicotine Dependence In Remission,Unspec
 ;;^UTILITY(U,$J,358.3,19859,1,4,0)
 ;;=4^F17.201
 ;;^UTILITY(U,$J,358.3,19859,2)
 ;;=^5003361
 ;;^UTILITY(U,$J,358.3,19860,0)
 ;;=F17.210^^94^930^27
 ;;^UTILITY(U,$J,358.3,19860,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19860,1,3,0)
 ;;=3^Nicotine Dependence Cigarettes,Uncomplicated
 ;;^UTILITY(U,$J,358.3,19860,1,4,0)
 ;;=4^F17.210
 ;;^UTILITY(U,$J,358.3,19860,2)
 ;;=^5003365
 ;;^UTILITY(U,$J,358.3,19861,0)
 ;;=F17.291^^94^930^29
 ;;^UTILITY(U,$J,358.3,19861,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19861,1,3,0)
 ;;=3^Nicotine Dependence Oth Tobacco Product,In Remission
 ;;^UTILITY(U,$J,358.3,19861,1,4,0)
 ;;=4^F17.291
 ;;^UTILITY(U,$J,358.3,19861,2)
 ;;=^5003376
 ;;^UTILITY(U,$J,358.3,19862,0)
 ;;=F17.290^^94^930^30
 ;;^UTILITY(U,$J,358.3,19862,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19862,1,3,0)
 ;;=3^Nicotine Dependence Oth Tobacco Product,Uncomplicated
 ;;^UTILITY(U,$J,358.3,19862,1,4,0)
 ;;=4^F17.290
 ;;^UTILITY(U,$J,358.3,19862,2)
 ;;=^5003375
 ;;^UTILITY(U,$J,358.3,19863,0)
 ;;=F17.221^^94^930^24
 ;;^UTILITY(U,$J,358.3,19863,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19863,1,3,0)
 ;;=3^Nicotine Dependence Chewing Tobacco,In Remission
 ;;^UTILITY(U,$J,358.3,19863,1,4,0)
 ;;=4^F17.221
 ;;^UTILITY(U,$J,358.3,19863,2)
 ;;=^5003371
 ;;^UTILITY(U,$J,358.3,19864,0)
 ;;=F17.220^^94^930^25
 ;;^UTILITY(U,$J,358.3,19864,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19864,1,3,0)
 ;;=3^Nicotine Dependence Chewing Tobacco,Uncomplicated
 ;;^UTILITY(U,$J,358.3,19864,1,4,0)
 ;;=4^F17.220
 ;;^UTILITY(U,$J,358.3,19864,2)
 ;;=^5003370
 ;;^UTILITY(U,$J,358.3,19865,0)
 ;;=F17.211^^94^930^26
 ;;^UTILITY(U,$J,358.3,19865,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19865,1,3,0)
 ;;=3^Nicotine Dependence Cigarettes,In Remission
 ;;^UTILITY(U,$J,358.3,19865,1,4,0)
 ;;=4^F17.211
 ;;^UTILITY(U,$J,358.3,19865,2)
 ;;=^5003366
 ;;^UTILITY(U,$J,358.3,19866,0)
 ;;=F17.200^^94^930^31

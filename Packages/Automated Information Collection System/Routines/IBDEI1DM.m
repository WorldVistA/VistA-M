IBDEI1DM ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23390,2)
 ;;=^5003256
 ;;^UTILITY(U,$J,358.3,23391,0)
 ;;=F14.220^^87^995^18
 ;;^UTILITY(U,$J,358.3,23391,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23391,1,3,0)
 ;;=3^Cocaine Dependence w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,23391,1,4,0)
 ;;=4^F14.220
 ;;^UTILITY(U,$J,358.3,23391,2)
 ;;=^5003255
 ;;^UTILITY(U,$J,358.3,23392,0)
 ;;=F14.20^^87^995^23
 ;;^UTILITY(U,$J,358.3,23392,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23392,1,3,0)
 ;;=3^Cocaine Dependence,Uncompicated
 ;;^UTILITY(U,$J,358.3,23392,1,4,0)
 ;;=4^F14.20
 ;;^UTILITY(U,$J,358.3,23392,2)
 ;;=^5003253
 ;;^UTILITY(U,$J,358.3,23393,0)
 ;;=F10.120^^87^995^1
 ;;^UTILITY(U,$J,358.3,23393,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23393,1,3,0)
 ;;=3^Alcohol Abuse w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,23393,1,4,0)
 ;;=4^F10.120
 ;;^UTILITY(U,$J,358.3,23393,2)
 ;;=^5003069
 ;;^UTILITY(U,$J,358.3,23394,0)
 ;;=F10.10^^87^995^2
 ;;^UTILITY(U,$J,358.3,23394,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23394,1,3,0)
 ;;=3^Alcohol Abuse,Uncomplicated
 ;;^UTILITY(U,$J,358.3,23394,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,23394,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,23395,0)
 ;;=F17.201^^87^995^28
 ;;^UTILITY(U,$J,358.3,23395,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23395,1,3,0)
 ;;=3^Nicotine Dependence In Remission,Unspec
 ;;^UTILITY(U,$J,358.3,23395,1,4,0)
 ;;=4^F17.201
 ;;^UTILITY(U,$J,358.3,23395,2)
 ;;=^5003361
 ;;^UTILITY(U,$J,358.3,23396,0)
 ;;=F17.210^^87^995^27
 ;;^UTILITY(U,$J,358.3,23396,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23396,1,3,0)
 ;;=3^Nicotine Dependence Cigarettes,Uncomplicated
 ;;^UTILITY(U,$J,358.3,23396,1,4,0)
 ;;=4^F17.210
 ;;^UTILITY(U,$J,358.3,23396,2)
 ;;=^5003365
 ;;^UTILITY(U,$J,358.3,23397,0)
 ;;=F17.291^^87^995^29
 ;;^UTILITY(U,$J,358.3,23397,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23397,1,3,0)
 ;;=3^Nicotine Dependence Oth Tobacco Product,In Remission
 ;;^UTILITY(U,$J,358.3,23397,1,4,0)
 ;;=4^F17.291
 ;;^UTILITY(U,$J,358.3,23397,2)
 ;;=^5003376
 ;;^UTILITY(U,$J,358.3,23398,0)
 ;;=F17.290^^87^995^30
 ;;^UTILITY(U,$J,358.3,23398,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23398,1,3,0)
 ;;=3^Nicotine Dependence Oth Tobacco Product,Uncomplicated
 ;;^UTILITY(U,$J,358.3,23398,1,4,0)
 ;;=4^F17.290
 ;;^UTILITY(U,$J,358.3,23398,2)
 ;;=^5003375
 ;;^UTILITY(U,$J,358.3,23399,0)
 ;;=F17.221^^87^995^24
 ;;^UTILITY(U,$J,358.3,23399,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23399,1,3,0)
 ;;=3^Nicotine Dependence Chewing Tobacco,In Remission
 ;;^UTILITY(U,$J,358.3,23399,1,4,0)
 ;;=4^F17.221
 ;;^UTILITY(U,$J,358.3,23399,2)
 ;;=^5003371
 ;;^UTILITY(U,$J,358.3,23400,0)
 ;;=F17.220^^87^995^25
 ;;^UTILITY(U,$J,358.3,23400,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23400,1,3,0)
 ;;=3^Nicotine Dependence Chewing Tobacco,Uncomplicated
 ;;^UTILITY(U,$J,358.3,23400,1,4,0)
 ;;=4^F17.220
 ;;^UTILITY(U,$J,358.3,23400,2)
 ;;=^5003370
 ;;^UTILITY(U,$J,358.3,23401,0)
 ;;=F17.211^^87^995^26
 ;;^UTILITY(U,$J,358.3,23401,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23401,1,3,0)
 ;;=3^Nicotine Dependence Cigarettes,In Remission
 ;;^UTILITY(U,$J,358.3,23401,1,4,0)
 ;;=4^F17.211
 ;;^UTILITY(U,$J,358.3,23401,2)
 ;;=^5003366
 ;;^UTILITY(U,$J,358.3,23402,0)
 ;;=F17.200^^87^995^31
 ;;^UTILITY(U,$J,358.3,23402,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23402,1,3,0)
 ;;=3^Nicotine Dependence,Unspec,Uncomplicated
 ;;^UTILITY(U,$J,358.3,23402,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,23402,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,23403,0)
 ;;=F11.120^^87^995^32
 ;;^UTILITY(U,$J,358.3,23403,1,0)
 ;;=^358.31IA^4^2

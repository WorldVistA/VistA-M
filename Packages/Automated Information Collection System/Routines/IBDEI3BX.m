IBDEI3BX ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,55944,1,4,0)
 ;;=4^F14.220
 ;;^UTILITY(U,$J,358.3,55944,2)
 ;;=^5003255
 ;;^UTILITY(U,$J,358.3,55945,0)
 ;;=F14.20^^256^2789^23
 ;;^UTILITY(U,$J,358.3,55945,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,55945,1,3,0)
 ;;=3^Cocaine Dependence,Uncompicated
 ;;^UTILITY(U,$J,358.3,55945,1,4,0)
 ;;=4^F14.20
 ;;^UTILITY(U,$J,358.3,55945,2)
 ;;=^5003253
 ;;^UTILITY(U,$J,358.3,55946,0)
 ;;=F10.120^^256^2789^1
 ;;^UTILITY(U,$J,358.3,55946,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,55946,1,3,0)
 ;;=3^Alcohol Abuse w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,55946,1,4,0)
 ;;=4^F10.120
 ;;^UTILITY(U,$J,358.3,55946,2)
 ;;=^5003069
 ;;^UTILITY(U,$J,358.3,55947,0)
 ;;=F10.10^^256^2789^2
 ;;^UTILITY(U,$J,358.3,55947,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,55947,1,3,0)
 ;;=3^Alcohol Abuse,Uncomplicated
 ;;^UTILITY(U,$J,358.3,55947,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,55947,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,55948,0)
 ;;=F17.201^^256^2789^28
 ;;^UTILITY(U,$J,358.3,55948,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,55948,1,3,0)
 ;;=3^Nicotine Dependence In Remission,Unspec
 ;;^UTILITY(U,$J,358.3,55948,1,4,0)
 ;;=4^F17.201
 ;;^UTILITY(U,$J,358.3,55948,2)
 ;;=^5003361
 ;;^UTILITY(U,$J,358.3,55949,0)
 ;;=F17.210^^256^2789^27
 ;;^UTILITY(U,$J,358.3,55949,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,55949,1,3,0)
 ;;=3^Nicotine Dependence Cigarettes,Uncomplicated
 ;;^UTILITY(U,$J,358.3,55949,1,4,0)
 ;;=4^F17.210
 ;;^UTILITY(U,$J,358.3,55949,2)
 ;;=^5003365
 ;;^UTILITY(U,$J,358.3,55950,0)
 ;;=F17.291^^256^2789^29
 ;;^UTILITY(U,$J,358.3,55950,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,55950,1,3,0)
 ;;=3^Nicotine Dependence Oth Tobacco Product,In Remission
 ;;^UTILITY(U,$J,358.3,55950,1,4,0)
 ;;=4^F17.291
 ;;^UTILITY(U,$J,358.3,55950,2)
 ;;=^5003376
 ;;^UTILITY(U,$J,358.3,55951,0)
 ;;=F17.290^^256^2789^30
 ;;^UTILITY(U,$J,358.3,55951,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,55951,1,3,0)
 ;;=3^Nicotine Dependence Oth Tobacco Product,Uncomplicated
 ;;^UTILITY(U,$J,358.3,55951,1,4,0)
 ;;=4^F17.290
 ;;^UTILITY(U,$J,358.3,55951,2)
 ;;=^5003375
 ;;^UTILITY(U,$J,358.3,55952,0)
 ;;=F17.221^^256^2789^24
 ;;^UTILITY(U,$J,358.3,55952,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,55952,1,3,0)
 ;;=3^Nicotine Dependence Chewing Tobacco,In Remission
 ;;^UTILITY(U,$J,358.3,55952,1,4,0)
 ;;=4^F17.221
 ;;^UTILITY(U,$J,358.3,55952,2)
 ;;=^5003371
 ;;^UTILITY(U,$J,358.3,55953,0)
 ;;=F17.220^^256^2789^25
 ;;^UTILITY(U,$J,358.3,55953,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,55953,1,3,0)
 ;;=3^Nicotine Dependence Chewing Tobacco,Uncomplicated
 ;;^UTILITY(U,$J,358.3,55953,1,4,0)
 ;;=4^F17.220
 ;;^UTILITY(U,$J,358.3,55953,2)
 ;;=^5003370
 ;;^UTILITY(U,$J,358.3,55954,0)
 ;;=F17.211^^256^2789^26
 ;;^UTILITY(U,$J,358.3,55954,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,55954,1,3,0)
 ;;=3^Nicotine Dependence Cigarettes,In Remission
 ;;^UTILITY(U,$J,358.3,55954,1,4,0)
 ;;=4^F17.211
 ;;^UTILITY(U,$J,358.3,55954,2)
 ;;=^5003366
 ;;^UTILITY(U,$J,358.3,55955,0)
 ;;=F17.200^^256^2789^31
 ;;^UTILITY(U,$J,358.3,55955,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,55955,1,3,0)
 ;;=3^Nicotine Dependence,Unspec,Uncomplicated
 ;;^UTILITY(U,$J,358.3,55955,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,55955,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,55956,0)
 ;;=F11.120^^256^2789^32
 ;;^UTILITY(U,$J,358.3,55956,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,55956,1,3,0)
 ;;=3^Opioid Abuse w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,55956,1,4,0)
 ;;=4^F11.120
 ;;^UTILITY(U,$J,358.3,55956,2)
 ;;=^5003115

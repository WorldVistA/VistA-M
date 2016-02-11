IBDEI1UM ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30947,1,4,0)
 ;;=4^F14.220
 ;;^UTILITY(U,$J,358.3,30947,2)
 ;;=^5003255
 ;;^UTILITY(U,$J,358.3,30948,0)
 ;;=F14.20^^135^1386^23
 ;;^UTILITY(U,$J,358.3,30948,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30948,1,3,0)
 ;;=3^Cocaine Dependence,Uncompicated
 ;;^UTILITY(U,$J,358.3,30948,1,4,0)
 ;;=4^F14.20
 ;;^UTILITY(U,$J,358.3,30948,2)
 ;;=^5003253
 ;;^UTILITY(U,$J,358.3,30949,0)
 ;;=F10.120^^135^1386^1
 ;;^UTILITY(U,$J,358.3,30949,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30949,1,3,0)
 ;;=3^Alcohol Abuse w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,30949,1,4,0)
 ;;=4^F10.120
 ;;^UTILITY(U,$J,358.3,30949,2)
 ;;=^5003069
 ;;^UTILITY(U,$J,358.3,30950,0)
 ;;=F10.10^^135^1386^2
 ;;^UTILITY(U,$J,358.3,30950,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30950,1,3,0)
 ;;=3^Alcohol Abuse,Uncomplicated
 ;;^UTILITY(U,$J,358.3,30950,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,30950,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,30951,0)
 ;;=F17.201^^135^1386^28
 ;;^UTILITY(U,$J,358.3,30951,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30951,1,3,0)
 ;;=3^Nicotine Dependence In Remission,Unspec
 ;;^UTILITY(U,$J,358.3,30951,1,4,0)
 ;;=4^F17.201
 ;;^UTILITY(U,$J,358.3,30951,2)
 ;;=^5003361
 ;;^UTILITY(U,$J,358.3,30952,0)
 ;;=F17.210^^135^1386^27
 ;;^UTILITY(U,$J,358.3,30952,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30952,1,3,0)
 ;;=3^Nicotine Dependence Cigarettes,Uncomplicated
 ;;^UTILITY(U,$J,358.3,30952,1,4,0)
 ;;=4^F17.210
 ;;^UTILITY(U,$J,358.3,30952,2)
 ;;=^5003365
 ;;^UTILITY(U,$J,358.3,30953,0)
 ;;=F17.291^^135^1386^29
 ;;^UTILITY(U,$J,358.3,30953,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30953,1,3,0)
 ;;=3^Nicotine Dependence Oth Tobacco Product,In Remission
 ;;^UTILITY(U,$J,358.3,30953,1,4,0)
 ;;=4^F17.291
 ;;^UTILITY(U,$J,358.3,30953,2)
 ;;=^5003376
 ;;^UTILITY(U,$J,358.3,30954,0)
 ;;=F17.290^^135^1386^30
 ;;^UTILITY(U,$J,358.3,30954,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30954,1,3,0)
 ;;=3^Nicotine Dependence Oth Tobacco Product,Uncomplicated
 ;;^UTILITY(U,$J,358.3,30954,1,4,0)
 ;;=4^F17.290
 ;;^UTILITY(U,$J,358.3,30954,2)
 ;;=^5003375
 ;;^UTILITY(U,$J,358.3,30955,0)
 ;;=F17.221^^135^1386^24
 ;;^UTILITY(U,$J,358.3,30955,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30955,1,3,0)
 ;;=3^Nicotine Dependence Chewing Tobacco,In Remission
 ;;^UTILITY(U,$J,358.3,30955,1,4,0)
 ;;=4^F17.221
 ;;^UTILITY(U,$J,358.3,30955,2)
 ;;=^5003371
 ;;^UTILITY(U,$J,358.3,30956,0)
 ;;=F17.220^^135^1386^25
 ;;^UTILITY(U,$J,358.3,30956,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30956,1,3,0)
 ;;=3^Nicotine Dependence Chewing Tobacco,Uncomplicated
 ;;^UTILITY(U,$J,358.3,30956,1,4,0)
 ;;=4^F17.220
 ;;^UTILITY(U,$J,358.3,30956,2)
 ;;=^5003370
 ;;^UTILITY(U,$J,358.3,30957,0)
 ;;=F17.211^^135^1386^26
 ;;^UTILITY(U,$J,358.3,30957,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30957,1,3,0)
 ;;=3^Nicotine Dependence Cigarettes,In Remission
 ;;^UTILITY(U,$J,358.3,30957,1,4,0)
 ;;=4^F17.211
 ;;^UTILITY(U,$J,358.3,30957,2)
 ;;=^5003366
 ;;^UTILITY(U,$J,358.3,30958,0)
 ;;=F17.200^^135^1386^31
 ;;^UTILITY(U,$J,358.3,30958,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30958,1,3,0)
 ;;=3^Nicotine Dependence,Unspec,Uncomplicated
 ;;^UTILITY(U,$J,358.3,30958,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,30958,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,30959,0)
 ;;=F11.120^^135^1386^32
 ;;^UTILITY(U,$J,358.3,30959,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30959,1,3,0)
 ;;=3^Opioid Abuse w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,30959,1,4,0)
 ;;=4^F11.120
 ;;^UTILITY(U,$J,358.3,30959,2)
 ;;=^5003115

IBDEI13D ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,17541,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17541,1,3,0)
 ;;=3^Cocaine Dependence w/ Intoxication Delirium
 ;;^UTILITY(U,$J,358.3,17541,1,4,0)
 ;;=4^F14.221
 ;;^UTILITY(U,$J,358.3,17541,2)
 ;;=^5003256
 ;;^UTILITY(U,$J,358.3,17542,0)
 ;;=F14.220^^88^893^21
 ;;^UTILITY(U,$J,358.3,17542,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17542,1,3,0)
 ;;=3^Cocaine Dependence w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,17542,1,4,0)
 ;;=4^F14.220
 ;;^UTILITY(U,$J,358.3,17542,2)
 ;;=^5003255
 ;;^UTILITY(U,$J,358.3,17543,0)
 ;;=F14.20^^88^893^26
 ;;^UTILITY(U,$J,358.3,17543,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17543,1,3,0)
 ;;=3^Cocaine Dependence,Uncompicated
 ;;^UTILITY(U,$J,358.3,17543,1,4,0)
 ;;=4^F14.20
 ;;^UTILITY(U,$J,358.3,17543,2)
 ;;=^5003253
 ;;^UTILITY(U,$J,358.3,17544,0)
 ;;=F10.120^^88^893^1
 ;;^UTILITY(U,$J,358.3,17544,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17544,1,3,0)
 ;;=3^Alcohol Abuse w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,17544,1,4,0)
 ;;=4^F10.120
 ;;^UTILITY(U,$J,358.3,17544,2)
 ;;=^5003069
 ;;^UTILITY(U,$J,358.3,17545,0)
 ;;=F10.10^^88^893^3
 ;;^UTILITY(U,$J,358.3,17545,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17545,1,3,0)
 ;;=3^Alcohol Abuse,Uncomplicated
 ;;^UTILITY(U,$J,358.3,17545,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,17545,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,17546,0)
 ;;=F17.201^^88^893^31
 ;;^UTILITY(U,$J,358.3,17546,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17546,1,3,0)
 ;;=3^Nicotine Dependence In Remission,Unspec
 ;;^UTILITY(U,$J,358.3,17546,1,4,0)
 ;;=4^F17.201
 ;;^UTILITY(U,$J,358.3,17546,2)
 ;;=^5003361
 ;;^UTILITY(U,$J,358.3,17547,0)
 ;;=F17.210^^88^893^30
 ;;^UTILITY(U,$J,358.3,17547,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17547,1,3,0)
 ;;=3^Nicotine Dependence Cigarettes,Uncomplicated
 ;;^UTILITY(U,$J,358.3,17547,1,4,0)
 ;;=4^F17.210
 ;;^UTILITY(U,$J,358.3,17547,2)
 ;;=^5003365
 ;;^UTILITY(U,$J,358.3,17548,0)
 ;;=F17.291^^88^893^32
 ;;^UTILITY(U,$J,358.3,17548,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17548,1,3,0)
 ;;=3^Nicotine Dependence Oth Tobacco Product,In Remission
 ;;^UTILITY(U,$J,358.3,17548,1,4,0)
 ;;=4^F17.291
 ;;^UTILITY(U,$J,358.3,17548,2)
 ;;=^5003376
 ;;^UTILITY(U,$J,358.3,17549,0)
 ;;=F17.290^^88^893^33
 ;;^UTILITY(U,$J,358.3,17549,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17549,1,3,0)
 ;;=3^Nicotine Dependence Oth Tobacco Product,Uncomplicated
 ;;^UTILITY(U,$J,358.3,17549,1,4,0)
 ;;=4^F17.290
 ;;^UTILITY(U,$J,358.3,17549,2)
 ;;=^5003375
 ;;^UTILITY(U,$J,358.3,17550,0)
 ;;=F17.221^^88^893^27
 ;;^UTILITY(U,$J,358.3,17550,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17550,1,3,0)
 ;;=3^Nicotine Dependence Chewing Tobacco,In Remission
 ;;^UTILITY(U,$J,358.3,17550,1,4,0)
 ;;=4^F17.221
 ;;^UTILITY(U,$J,358.3,17550,2)
 ;;=^5003371
 ;;^UTILITY(U,$J,358.3,17551,0)
 ;;=F17.220^^88^893^28
 ;;^UTILITY(U,$J,358.3,17551,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17551,1,3,0)
 ;;=3^Nicotine Dependence Chewing Tobacco,Uncomplicated
 ;;^UTILITY(U,$J,358.3,17551,1,4,0)
 ;;=4^F17.220
 ;;^UTILITY(U,$J,358.3,17551,2)
 ;;=^5003370
 ;;^UTILITY(U,$J,358.3,17552,0)
 ;;=F17.211^^88^893^29
 ;;^UTILITY(U,$J,358.3,17552,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17552,1,3,0)
 ;;=3^Nicotine Dependence Cigarettes,In Remission
 ;;^UTILITY(U,$J,358.3,17552,1,4,0)
 ;;=4^F17.211
 ;;^UTILITY(U,$J,358.3,17552,2)
 ;;=^5003366

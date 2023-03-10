IBDEI0LF ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9639,1,3,0)
 ;;=3^Cocaine Dependence w/ Intoxication Delirium
 ;;^UTILITY(U,$J,358.3,9639,1,4,0)
 ;;=4^F14.221
 ;;^UTILITY(U,$J,358.3,9639,2)
 ;;=^5003256
 ;;^UTILITY(U,$J,358.3,9640,0)
 ;;=F14.220^^39^415^31
 ;;^UTILITY(U,$J,358.3,9640,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9640,1,3,0)
 ;;=3^Cocaine Dependence w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,9640,1,4,0)
 ;;=4^F14.220
 ;;^UTILITY(U,$J,358.3,9640,2)
 ;;=^5003255
 ;;^UTILITY(U,$J,358.3,9641,0)
 ;;=F14.20^^39^415^36
 ;;^UTILITY(U,$J,358.3,9641,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9641,1,3,0)
 ;;=3^Cocaine Dependence,Uncompicated
 ;;^UTILITY(U,$J,358.3,9641,1,4,0)
 ;;=4^F14.20
 ;;^UTILITY(U,$J,358.3,9641,2)
 ;;=^5003253
 ;;^UTILITY(U,$J,358.3,9642,0)
 ;;=F10.120^^39^415^1
 ;;^UTILITY(U,$J,358.3,9642,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9642,1,3,0)
 ;;=3^Alcohol Abuse w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,9642,1,4,0)
 ;;=4^F10.120
 ;;^UTILITY(U,$J,358.3,9642,2)
 ;;=^5003069
 ;;^UTILITY(U,$J,358.3,9643,0)
 ;;=F10.10^^39^415^7
 ;;^UTILITY(U,$J,358.3,9643,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9643,1,3,0)
 ;;=3^Alcohol Abuse,Uncomplicated
 ;;^UTILITY(U,$J,358.3,9643,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,9643,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,9644,0)
 ;;=F17.201^^39^415^41
 ;;^UTILITY(U,$J,358.3,9644,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9644,1,3,0)
 ;;=3^Nicotine Dependence In Remission,Unspec
 ;;^UTILITY(U,$J,358.3,9644,1,4,0)
 ;;=4^F17.201
 ;;^UTILITY(U,$J,358.3,9644,2)
 ;;=^5003361
 ;;^UTILITY(U,$J,358.3,9645,0)
 ;;=F17.210^^39^415^40
 ;;^UTILITY(U,$J,358.3,9645,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9645,1,3,0)
 ;;=3^Nicotine Dependence Cigarettes,Uncomplicated
 ;;^UTILITY(U,$J,358.3,9645,1,4,0)
 ;;=4^F17.210
 ;;^UTILITY(U,$J,358.3,9645,2)
 ;;=^5003365
 ;;^UTILITY(U,$J,358.3,9646,0)
 ;;=F17.291^^39^415^42
 ;;^UTILITY(U,$J,358.3,9646,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9646,1,3,0)
 ;;=3^Nicotine Dependence Oth Tobacco Product,In Remission
 ;;^UTILITY(U,$J,358.3,9646,1,4,0)
 ;;=4^F17.291
 ;;^UTILITY(U,$J,358.3,9646,2)
 ;;=^5003376
 ;;^UTILITY(U,$J,358.3,9647,0)
 ;;=F17.290^^39^415^43
 ;;^UTILITY(U,$J,358.3,9647,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9647,1,3,0)
 ;;=3^Nicotine Dependence Oth Tobacco Product,Uncomplicated
 ;;^UTILITY(U,$J,358.3,9647,1,4,0)
 ;;=4^F17.290
 ;;^UTILITY(U,$J,358.3,9647,2)
 ;;=^5003375
 ;;^UTILITY(U,$J,358.3,9648,0)
 ;;=F17.221^^39^415^37
 ;;^UTILITY(U,$J,358.3,9648,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9648,1,3,0)
 ;;=3^Nicotine Dependence Chewing Tobacco,In Remission
 ;;^UTILITY(U,$J,358.3,9648,1,4,0)
 ;;=4^F17.221
 ;;^UTILITY(U,$J,358.3,9648,2)
 ;;=^5003371
 ;;^UTILITY(U,$J,358.3,9649,0)
 ;;=F17.220^^39^415^38
 ;;^UTILITY(U,$J,358.3,9649,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9649,1,3,0)
 ;;=3^Nicotine Dependence Chewing Tobacco,Uncomplicated
 ;;^UTILITY(U,$J,358.3,9649,1,4,0)
 ;;=4^F17.220
 ;;^UTILITY(U,$J,358.3,9649,2)
 ;;=^5003370
 ;;^UTILITY(U,$J,358.3,9650,0)
 ;;=F17.211^^39^415^39
 ;;^UTILITY(U,$J,358.3,9650,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9650,1,3,0)
 ;;=3^Nicotine Dependence Cigarettes,In Remission
 ;;^UTILITY(U,$J,358.3,9650,1,4,0)
 ;;=4^F17.211
 ;;^UTILITY(U,$J,358.3,9650,2)
 ;;=^5003366
 ;;^UTILITY(U,$J,358.3,9651,0)
 ;;=F17.200^^39^415^44
 ;;^UTILITY(U,$J,358.3,9651,1,0)
 ;;=^358.31IA^4^2

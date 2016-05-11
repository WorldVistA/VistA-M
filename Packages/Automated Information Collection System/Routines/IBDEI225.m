IBDEI225 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,34901,1,4,0)
 ;;=4^F14.220
 ;;^UTILITY(U,$J,358.3,34901,2)
 ;;=^5003255
 ;;^UTILITY(U,$J,358.3,34902,0)
 ;;=F14.20^^131^1694^23
 ;;^UTILITY(U,$J,358.3,34902,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34902,1,3,0)
 ;;=3^Cocaine Dependence,Uncompicated
 ;;^UTILITY(U,$J,358.3,34902,1,4,0)
 ;;=4^F14.20
 ;;^UTILITY(U,$J,358.3,34902,2)
 ;;=^5003253
 ;;^UTILITY(U,$J,358.3,34903,0)
 ;;=F10.120^^131^1694^1
 ;;^UTILITY(U,$J,358.3,34903,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34903,1,3,0)
 ;;=3^Alcohol Abuse w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,34903,1,4,0)
 ;;=4^F10.120
 ;;^UTILITY(U,$J,358.3,34903,2)
 ;;=^5003069
 ;;^UTILITY(U,$J,358.3,34904,0)
 ;;=F10.10^^131^1694^2
 ;;^UTILITY(U,$J,358.3,34904,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34904,1,3,0)
 ;;=3^Alcohol Abuse,Uncomplicated
 ;;^UTILITY(U,$J,358.3,34904,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,34904,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,34905,0)
 ;;=F17.201^^131^1694^28
 ;;^UTILITY(U,$J,358.3,34905,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34905,1,3,0)
 ;;=3^Nicotine Dependence In Remission,Unspec
 ;;^UTILITY(U,$J,358.3,34905,1,4,0)
 ;;=4^F17.201
 ;;^UTILITY(U,$J,358.3,34905,2)
 ;;=^5003361
 ;;^UTILITY(U,$J,358.3,34906,0)
 ;;=F17.210^^131^1694^27
 ;;^UTILITY(U,$J,358.3,34906,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34906,1,3,0)
 ;;=3^Nicotine Dependence Cigarettes,Uncomplicated
 ;;^UTILITY(U,$J,358.3,34906,1,4,0)
 ;;=4^F17.210
 ;;^UTILITY(U,$J,358.3,34906,2)
 ;;=^5003365
 ;;^UTILITY(U,$J,358.3,34907,0)
 ;;=F17.291^^131^1694^29
 ;;^UTILITY(U,$J,358.3,34907,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34907,1,3,0)
 ;;=3^Nicotine Dependence Oth Tobacco Product,In Remission
 ;;^UTILITY(U,$J,358.3,34907,1,4,0)
 ;;=4^F17.291
 ;;^UTILITY(U,$J,358.3,34907,2)
 ;;=^5003376
 ;;^UTILITY(U,$J,358.3,34908,0)
 ;;=F17.290^^131^1694^30
 ;;^UTILITY(U,$J,358.3,34908,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34908,1,3,0)
 ;;=3^Nicotine Dependence Oth Tobacco Product,Uncomplicated
 ;;^UTILITY(U,$J,358.3,34908,1,4,0)
 ;;=4^F17.290
 ;;^UTILITY(U,$J,358.3,34908,2)
 ;;=^5003375
 ;;^UTILITY(U,$J,358.3,34909,0)
 ;;=F17.221^^131^1694^24
 ;;^UTILITY(U,$J,358.3,34909,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34909,1,3,0)
 ;;=3^Nicotine Dependence Chewing Tobacco,In Remission
 ;;^UTILITY(U,$J,358.3,34909,1,4,0)
 ;;=4^F17.221
 ;;^UTILITY(U,$J,358.3,34909,2)
 ;;=^5003371
 ;;^UTILITY(U,$J,358.3,34910,0)
 ;;=F17.220^^131^1694^25
 ;;^UTILITY(U,$J,358.3,34910,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34910,1,3,0)
 ;;=3^Nicotine Dependence Chewing Tobacco,Uncomplicated
 ;;^UTILITY(U,$J,358.3,34910,1,4,0)
 ;;=4^F17.220
 ;;^UTILITY(U,$J,358.3,34910,2)
 ;;=^5003370
 ;;^UTILITY(U,$J,358.3,34911,0)
 ;;=F17.211^^131^1694^26
 ;;^UTILITY(U,$J,358.3,34911,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34911,1,3,0)
 ;;=3^Nicotine Dependence Cigarettes,In Remission
 ;;^UTILITY(U,$J,358.3,34911,1,4,0)
 ;;=4^F17.211
 ;;^UTILITY(U,$J,358.3,34911,2)
 ;;=^5003366
 ;;^UTILITY(U,$J,358.3,34912,0)
 ;;=F17.200^^131^1694^31
 ;;^UTILITY(U,$J,358.3,34912,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34912,1,3,0)
 ;;=3^Nicotine Dependence,Unspec,Uncomplicated
 ;;^UTILITY(U,$J,358.3,34912,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,34912,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,34913,0)
 ;;=F11.120^^131^1694^32
 ;;^UTILITY(U,$J,358.3,34913,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34913,1,3,0)
 ;;=3^Opioid Abuse w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,34913,1,4,0)
 ;;=4^F11.120
 ;;^UTILITY(U,$J,358.3,34913,2)
 ;;=^5003115

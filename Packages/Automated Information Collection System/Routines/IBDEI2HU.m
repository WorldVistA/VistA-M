IBDEI2HU ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,42285,1,4,0)
 ;;=4^F14.220
 ;;^UTILITY(U,$J,358.3,42285,2)
 ;;=^5003255
 ;;^UTILITY(U,$J,358.3,42286,0)
 ;;=F14.20^^159^2018^23
 ;;^UTILITY(U,$J,358.3,42286,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42286,1,3,0)
 ;;=3^Cocaine Dependence,Uncompicated
 ;;^UTILITY(U,$J,358.3,42286,1,4,0)
 ;;=4^F14.20
 ;;^UTILITY(U,$J,358.3,42286,2)
 ;;=^5003253
 ;;^UTILITY(U,$J,358.3,42287,0)
 ;;=F10.120^^159^2018^1
 ;;^UTILITY(U,$J,358.3,42287,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42287,1,3,0)
 ;;=3^Alcohol Abuse w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,42287,1,4,0)
 ;;=4^F10.120
 ;;^UTILITY(U,$J,358.3,42287,2)
 ;;=^5003069
 ;;^UTILITY(U,$J,358.3,42288,0)
 ;;=F10.10^^159^2018^2
 ;;^UTILITY(U,$J,358.3,42288,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42288,1,3,0)
 ;;=3^Alcohol Abuse,Uncomplicated
 ;;^UTILITY(U,$J,358.3,42288,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,42288,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,42289,0)
 ;;=F17.201^^159^2018^28
 ;;^UTILITY(U,$J,358.3,42289,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42289,1,3,0)
 ;;=3^Nicotine Dependence In Remission,Unspec
 ;;^UTILITY(U,$J,358.3,42289,1,4,0)
 ;;=4^F17.201
 ;;^UTILITY(U,$J,358.3,42289,2)
 ;;=^5003361
 ;;^UTILITY(U,$J,358.3,42290,0)
 ;;=F17.210^^159^2018^27
 ;;^UTILITY(U,$J,358.3,42290,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42290,1,3,0)
 ;;=3^Nicotine Dependence Cigarettes,Uncomplicated
 ;;^UTILITY(U,$J,358.3,42290,1,4,0)
 ;;=4^F17.210
 ;;^UTILITY(U,$J,358.3,42290,2)
 ;;=^5003365
 ;;^UTILITY(U,$J,358.3,42291,0)
 ;;=F17.291^^159^2018^29
 ;;^UTILITY(U,$J,358.3,42291,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42291,1,3,0)
 ;;=3^Nicotine Dependence Oth Tobacco Product,In Remission
 ;;^UTILITY(U,$J,358.3,42291,1,4,0)
 ;;=4^F17.291
 ;;^UTILITY(U,$J,358.3,42291,2)
 ;;=^5003376
 ;;^UTILITY(U,$J,358.3,42292,0)
 ;;=F17.290^^159^2018^30
 ;;^UTILITY(U,$J,358.3,42292,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42292,1,3,0)
 ;;=3^Nicotine Dependence Oth Tobacco Product,Uncomplicated
 ;;^UTILITY(U,$J,358.3,42292,1,4,0)
 ;;=4^F17.290
 ;;^UTILITY(U,$J,358.3,42292,2)
 ;;=^5003375
 ;;^UTILITY(U,$J,358.3,42293,0)
 ;;=F17.221^^159^2018^24
 ;;^UTILITY(U,$J,358.3,42293,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42293,1,3,0)
 ;;=3^Nicotine Dependence Chewing Tobacco,In Remission
 ;;^UTILITY(U,$J,358.3,42293,1,4,0)
 ;;=4^F17.221
 ;;^UTILITY(U,$J,358.3,42293,2)
 ;;=^5003371
 ;;^UTILITY(U,$J,358.3,42294,0)
 ;;=F17.220^^159^2018^25
 ;;^UTILITY(U,$J,358.3,42294,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42294,1,3,0)
 ;;=3^Nicotine Dependence Chewing Tobacco,Uncomplicated
 ;;^UTILITY(U,$J,358.3,42294,1,4,0)
 ;;=4^F17.220
 ;;^UTILITY(U,$J,358.3,42294,2)
 ;;=^5003370
 ;;^UTILITY(U,$J,358.3,42295,0)
 ;;=F17.211^^159^2018^26
 ;;^UTILITY(U,$J,358.3,42295,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42295,1,3,0)
 ;;=3^Nicotine Dependence Cigarettes,In Remission
 ;;^UTILITY(U,$J,358.3,42295,1,4,0)
 ;;=4^F17.211
 ;;^UTILITY(U,$J,358.3,42295,2)
 ;;=^5003366
 ;;^UTILITY(U,$J,358.3,42296,0)
 ;;=F17.200^^159^2018^31
 ;;^UTILITY(U,$J,358.3,42296,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42296,1,3,0)
 ;;=3^Nicotine Dependence,Unspec,Uncomplicated
 ;;^UTILITY(U,$J,358.3,42296,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,42296,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,42297,0)
 ;;=F11.120^^159^2018^32
 ;;^UTILITY(U,$J,358.3,42297,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42297,1,3,0)
 ;;=3^Opioid Abuse w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,42297,1,4,0)
 ;;=4^F11.120
 ;;^UTILITY(U,$J,358.3,42297,2)
 ;;=^5003115

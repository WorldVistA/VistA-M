IBDEI1TZ ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,32663,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32663,1,3,0)
 ;;=3^Alcohol Abuse w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,32663,1,4,0)
 ;;=4^F10.120
 ;;^UTILITY(U,$J,358.3,32663,2)
 ;;=^5003069
 ;;^UTILITY(U,$J,358.3,32664,0)
 ;;=F10.10^^190^1957^2
 ;;^UTILITY(U,$J,358.3,32664,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32664,1,3,0)
 ;;=3^Alcohol Abuse,Uncomplicated
 ;;^UTILITY(U,$J,358.3,32664,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,32664,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,32665,0)
 ;;=F17.201^^190^1957^28
 ;;^UTILITY(U,$J,358.3,32665,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32665,1,3,0)
 ;;=3^Nicotine Dependence In Remission,Unspec
 ;;^UTILITY(U,$J,358.3,32665,1,4,0)
 ;;=4^F17.201
 ;;^UTILITY(U,$J,358.3,32665,2)
 ;;=^5003361
 ;;^UTILITY(U,$J,358.3,32666,0)
 ;;=F17.210^^190^1957^27
 ;;^UTILITY(U,$J,358.3,32666,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32666,1,3,0)
 ;;=3^Nicotine Dependence Cigarettes,Uncomplicated
 ;;^UTILITY(U,$J,358.3,32666,1,4,0)
 ;;=4^F17.210
 ;;^UTILITY(U,$J,358.3,32666,2)
 ;;=^5003365
 ;;^UTILITY(U,$J,358.3,32667,0)
 ;;=F17.291^^190^1957^29
 ;;^UTILITY(U,$J,358.3,32667,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32667,1,3,0)
 ;;=3^Nicotine Dependence Oth Tobacco Product,In Remission
 ;;^UTILITY(U,$J,358.3,32667,1,4,0)
 ;;=4^F17.291
 ;;^UTILITY(U,$J,358.3,32667,2)
 ;;=^5003376
 ;;^UTILITY(U,$J,358.3,32668,0)
 ;;=F17.290^^190^1957^30
 ;;^UTILITY(U,$J,358.3,32668,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32668,1,3,0)
 ;;=3^Nicotine Dependence Oth Tobacco Product,Uncomplicated
 ;;^UTILITY(U,$J,358.3,32668,1,4,0)
 ;;=4^F17.290
 ;;^UTILITY(U,$J,358.3,32668,2)
 ;;=^5003375
 ;;^UTILITY(U,$J,358.3,32669,0)
 ;;=F17.221^^190^1957^24
 ;;^UTILITY(U,$J,358.3,32669,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32669,1,3,0)
 ;;=3^Nicotine Dependence Chewing Tobacco,In Remission
 ;;^UTILITY(U,$J,358.3,32669,1,4,0)
 ;;=4^F17.221
 ;;^UTILITY(U,$J,358.3,32669,2)
 ;;=^5003371
 ;;^UTILITY(U,$J,358.3,32670,0)
 ;;=F17.220^^190^1957^25
 ;;^UTILITY(U,$J,358.3,32670,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32670,1,3,0)
 ;;=3^Nicotine Dependence Chewing Tobacco,Uncomplicated
 ;;^UTILITY(U,$J,358.3,32670,1,4,0)
 ;;=4^F17.220
 ;;^UTILITY(U,$J,358.3,32670,2)
 ;;=^5003370
 ;;^UTILITY(U,$J,358.3,32671,0)
 ;;=F17.211^^190^1957^26
 ;;^UTILITY(U,$J,358.3,32671,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32671,1,3,0)
 ;;=3^Nicotine Dependence Cigarettes,In Remission
 ;;^UTILITY(U,$J,358.3,32671,1,4,0)
 ;;=4^F17.211
 ;;^UTILITY(U,$J,358.3,32671,2)
 ;;=^5003366
 ;;^UTILITY(U,$J,358.3,32672,0)
 ;;=F17.200^^190^1957^31
 ;;^UTILITY(U,$J,358.3,32672,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32672,1,3,0)
 ;;=3^Nicotine Dependence,Unspec,Uncomplicated
 ;;^UTILITY(U,$J,358.3,32672,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,32672,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,32673,0)
 ;;=F11.120^^190^1957^32
 ;;^UTILITY(U,$J,358.3,32673,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32673,1,3,0)
 ;;=3^Opioid Abuse w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,32673,1,4,0)
 ;;=4^F11.120
 ;;^UTILITY(U,$J,358.3,32673,2)
 ;;=^5003115
 ;;^UTILITY(U,$J,358.3,32674,0)
 ;;=F11.10^^190^1957^34
 ;;^UTILITY(U,$J,358.3,32674,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32674,1,3,0)
 ;;=3^Opioid Abuse,Uncomplicated
 ;;^UTILITY(U,$J,358.3,32674,1,4,0)
 ;;=4^F11.10
 ;;^UTILITY(U,$J,358.3,32674,2)
 ;;=^5003114
 ;;^UTILITY(U,$J,358.3,32675,0)
 ;;=F11.129^^190^1957^33
 ;;^UTILITY(U,$J,358.3,32675,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32675,1,3,0)
 ;;=3^Opioid Abuse w/ Intoxication,Unspec

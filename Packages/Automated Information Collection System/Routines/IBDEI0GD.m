IBDEI0GD ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7566,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7566,1,3,0)
 ;;=3^Cocaine Dependence,Uncompicated
 ;;^UTILITY(U,$J,358.3,7566,1,4,0)
 ;;=4^F14.20
 ;;^UTILITY(U,$J,358.3,7566,2)
 ;;=^5003253
 ;;^UTILITY(U,$J,358.3,7567,0)
 ;;=F10.120^^30^410^1
 ;;^UTILITY(U,$J,358.3,7567,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7567,1,3,0)
 ;;=3^Alcohol Abuse w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,7567,1,4,0)
 ;;=4^F10.120
 ;;^UTILITY(U,$J,358.3,7567,2)
 ;;=^5003069
 ;;^UTILITY(U,$J,358.3,7568,0)
 ;;=F10.10^^30^410^2
 ;;^UTILITY(U,$J,358.3,7568,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7568,1,3,0)
 ;;=3^Alcohol Abuse,Uncomplicated
 ;;^UTILITY(U,$J,358.3,7568,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,7568,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,7569,0)
 ;;=F17.201^^30^410^28
 ;;^UTILITY(U,$J,358.3,7569,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7569,1,3,0)
 ;;=3^Nicotine Dependence In Remission,Unspec
 ;;^UTILITY(U,$J,358.3,7569,1,4,0)
 ;;=4^F17.201
 ;;^UTILITY(U,$J,358.3,7569,2)
 ;;=^5003361
 ;;^UTILITY(U,$J,358.3,7570,0)
 ;;=F17.210^^30^410^27
 ;;^UTILITY(U,$J,358.3,7570,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7570,1,3,0)
 ;;=3^Nicotine Dependence Cigarettes,Uncomplicated
 ;;^UTILITY(U,$J,358.3,7570,1,4,0)
 ;;=4^F17.210
 ;;^UTILITY(U,$J,358.3,7570,2)
 ;;=^5003365
 ;;^UTILITY(U,$J,358.3,7571,0)
 ;;=F17.291^^30^410^29
 ;;^UTILITY(U,$J,358.3,7571,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7571,1,3,0)
 ;;=3^Nicotine Dependence Oth Tobacco Product,In Remission
 ;;^UTILITY(U,$J,358.3,7571,1,4,0)
 ;;=4^F17.291
 ;;^UTILITY(U,$J,358.3,7571,2)
 ;;=^5003376
 ;;^UTILITY(U,$J,358.3,7572,0)
 ;;=F17.290^^30^410^30
 ;;^UTILITY(U,$J,358.3,7572,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7572,1,3,0)
 ;;=3^Nicotine Dependence Oth Tobacco Product,Uncomplicated
 ;;^UTILITY(U,$J,358.3,7572,1,4,0)
 ;;=4^F17.290
 ;;^UTILITY(U,$J,358.3,7572,2)
 ;;=^5003375
 ;;^UTILITY(U,$J,358.3,7573,0)
 ;;=F17.221^^30^410^24
 ;;^UTILITY(U,$J,358.3,7573,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7573,1,3,0)
 ;;=3^Nicotine Dependence Chewing Tobacco,In Remission
 ;;^UTILITY(U,$J,358.3,7573,1,4,0)
 ;;=4^F17.221
 ;;^UTILITY(U,$J,358.3,7573,2)
 ;;=^5003371
 ;;^UTILITY(U,$J,358.3,7574,0)
 ;;=F17.220^^30^410^25
 ;;^UTILITY(U,$J,358.3,7574,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7574,1,3,0)
 ;;=3^Nicotine Dependence Chewing Tobacco,Uncomplicated
 ;;^UTILITY(U,$J,358.3,7574,1,4,0)
 ;;=4^F17.220
 ;;^UTILITY(U,$J,358.3,7574,2)
 ;;=^5003370
 ;;^UTILITY(U,$J,358.3,7575,0)
 ;;=F17.211^^30^410^26
 ;;^UTILITY(U,$J,358.3,7575,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7575,1,3,0)
 ;;=3^Nicotine Dependence Cigarettes,In Remission
 ;;^UTILITY(U,$J,358.3,7575,1,4,0)
 ;;=4^F17.211
 ;;^UTILITY(U,$J,358.3,7575,2)
 ;;=^5003366
 ;;^UTILITY(U,$J,358.3,7576,0)
 ;;=F17.200^^30^410^31
 ;;^UTILITY(U,$J,358.3,7576,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7576,1,3,0)
 ;;=3^Nicotine Dependence,Unspec,Uncomplicated
 ;;^UTILITY(U,$J,358.3,7576,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,7576,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,7577,0)
 ;;=F11.120^^30^410^32
 ;;^UTILITY(U,$J,358.3,7577,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7577,1,3,0)
 ;;=3^Opioid Abuse w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,7577,1,4,0)
 ;;=4^F11.120
 ;;^UTILITY(U,$J,358.3,7577,2)
 ;;=^5003115
 ;;^UTILITY(U,$J,358.3,7578,0)
 ;;=F11.10^^30^410^34
 ;;^UTILITY(U,$J,358.3,7578,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7578,1,3,0)
 ;;=3^Opioid Abuse,Uncomplicated
 ;;^UTILITY(U,$J,358.3,7578,1,4,0)
 ;;=4^F11.10
 ;;^UTILITY(U,$J,358.3,7578,2)
 ;;=^5003114

IBDEI0PN ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,11745,1,4,0)
 ;;=4^F17.290
 ;;^UTILITY(U,$J,358.3,11745,2)
 ;;=^5003375
 ;;^UTILITY(U,$J,358.3,11746,0)
 ;;=F17.221^^68^689^24
 ;;^UTILITY(U,$J,358.3,11746,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11746,1,3,0)
 ;;=3^Nicotine Dependence Chewing Tobacco,In Remission
 ;;^UTILITY(U,$J,358.3,11746,1,4,0)
 ;;=4^F17.221
 ;;^UTILITY(U,$J,358.3,11746,2)
 ;;=^5003371
 ;;^UTILITY(U,$J,358.3,11747,0)
 ;;=F17.220^^68^689^25
 ;;^UTILITY(U,$J,358.3,11747,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11747,1,3,0)
 ;;=3^Nicotine Dependence Chewing Tobacco,Uncomplicated
 ;;^UTILITY(U,$J,358.3,11747,1,4,0)
 ;;=4^F17.220
 ;;^UTILITY(U,$J,358.3,11747,2)
 ;;=^5003370
 ;;^UTILITY(U,$J,358.3,11748,0)
 ;;=F17.211^^68^689^26
 ;;^UTILITY(U,$J,358.3,11748,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11748,1,3,0)
 ;;=3^Nicotine Dependence Cigarettes,In Remission
 ;;^UTILITY(U,$J,358.3,11748,1,4,0)
 ;;=4^F17.211
 ;;^UTILITY(U,$J,358.3,11748,2)
 ;;=^5003366
 ;;^UTILITY(U,$J,358.3,11749,0)
 ;;=F17.200^^68^689^31
 ;;^UTILITY(U,$J,358.3,11749,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11749,1,3,0)
 ;;=3^Nicotine Dependence,Unspec,Uncomplicated
 ;;^UTILITY(U,$J,358.3,11749,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,11749,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,11750,0)
 ;;=F11.120^^68^689^32
 ;;^UTILITY(U,$J,358.3,11750,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11750,1,3,0)
 ;;=3^Opioid Abuse w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,11750,1,4,0)
 ;;=4^F11.120
 ;;^UTILITY(U,$J,358.3,11750,2)
 ;;=^5003115
 ;;^UTILITY(U,$J,358.3,11751,0)
 ;;=F11.10^^68^689^34
 ;;^UTILITY(U,$J,358.3,11751,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11751,1,3,0)
 ;;=3^Opioid Abuse,Uncomplicated
 ;;^UTILITY(U,$J,358.3,11751,1,4,0)
 ;;=4^F11.10
 ;;^UTILITY(U,$J,358.3,11751,2)
 ;;=^5003114
 ;;^UTILITY(U,$J,358.3,11752,0)
 ;;=F11.129^^68^689^33
 ;;^UTILITY(U,$J,358.3,11752,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11752,1,3,0)
 ;;=3^Opioid Abuse w/ Intoxication,Unspec
 ;;^UTILITY(U,$J,358.3,11752,1,4,0)
 ;;=4^F11.129
 ;;^UTILITY(U,$J,358.3,11752,2)
 ;;=^5003118
 ;;^UTILITY(U,$J,358.3,11753,0)
 ;;=F10.21^^68^689^3
 ;;^UTILITY(U,$J,358.3,11753,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11753,1,3,0)
 ;;=3^Alcohol Dependence,In Remission
 ;;^UTILITY(U,$J,358.3,11753,1,4,0)
 ;;=4^F10.21
 ;;^UTILITY(U,$J,358.3,11753,2)
 ;;=^5003082
 ;;^UTILITY(U,$J,358.3,11754,0)
 ;;=F12.10^^68^689^5
 ;;^UTILITY(U,$J,358.3,11754,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11754,1,3,0)
 ;;=3^Cannabis Abuse,Uncomplicated
 ;;^UTILITY(U,$J,358.3,11754,1,4,0)
 ;;=4^F12.10
 ;;^UTILITY(U,$J,358.3,11754,2)
 ;;=^5003155
 ;;^UTILITY(U,$J,358.3,11755,0)
 ;;=F12.20^^68^689^7
 ;;^UTILITY(U,$J,358.3,11755,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11755,1,3,0)
 ;;=3^Cannabis Dependence,Uncomplicated
 ;;^UTILITY(U,$J,358.3,11755,1,4,0)
 ;;=4^F12.20
 ;;^UTILITY(U,$J,358.3,11755,2)
 ;;=^5003166
 ;;^UTILITY(U,$J,358.3,11756,0)
 ;;=F12.21^^68^689^6
 ;;^UTILITY(U,$J,358.3,11756,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11756,1,3,0)
 ;;=3^Cannabis Dependence,In Remission
 ;;^UTILITY(U,$J,358.3,11756,1,4,0)
 ;;=4^F12.21
 ;;^UTILITY(U,$J,358.3,11756,2)
 ;;=^5003167
 ;;^UTILITY(U,$J,358.3,11757,0)
 ;;=F12.90^^68^689^8
 ;;^UTILITY(U,$J,358.3,11757,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11757,1,3,0)
 ;;=3^Cannabis Use,Unspec,Uncomplicated
 ;;^UTILITY(U,$J,358.3,11757,1,4,0)
 ;;=4^F12.90
 ;;^UTILITY(U,$J,358.3,11757,2)
 ;;=^5003178
 ;;^UTILITY(U,$J,358.3,11758,0)
 ;;=I83.019^^68^690^3
 ;;^UTILITY(U,$J,358.3,11758,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11758,1,3,0)
 ;;=3^Varicose Veins Right Lower Extrem w/ Ulcer,Unspec

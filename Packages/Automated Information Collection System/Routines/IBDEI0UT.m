IBDEI0UT ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,14448,1,4,0)
 ;;=4^F17.290
 ;;^UTILITY(U,$J,358.3,14448,2)
 ;;=^5003375
 ;;^UTILITY(U,$J,358.3,14449,0)
 ;;=F17.221^^53^607^24
 ;;^UTILITY(U,$J,358.3,14449,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14449,1,3,0)
 ;;=3^Nicotine Dependence Chewing Tobacco,In Remission
 ;;^UTILITY(U,$J,358.3,14449,1,4,0)
 ;;=4^F17.221
 ;;^UTILITY(U,$J,358.3,14449,2)
 ;;=^5003371
 ;;^UTILITY(U,$J,358.3,14450,0)
 ;;=F17.220^^53^607^25
 ;;^UTILITY(U,$J,358.3,14450,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14450,1,3,0)
 ;;=3^Nicotine Dependence Chewing Tobacco,Uncomplicated
 ;;^UTILITY(U,$J,358.3,14450,1,4,0)
 ;;=4^F17.220
 ;;^UTILITY(U,$J,358.3,14450,2)
 ;;=^5003370
 ;;^UTILITY(U,$J,358.3,14451,0)
 ;;=F17.211^^53^607^26
 ;;^UTILITY(U,$J,358.3,14451,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14451,1,3,0)
 ;;=3^Nicotine Dependence Cigarettes,In Remission
 ;;^UTILITY(U,$J,358.3,14451,1,4,0)
 ;;=4^F17.211
 ;;^UTILITY(U,$J,358.3,14451,2)
 ;;=^5003366
 ;;^UTILITY(U,$J,358.3,14452,0)
 ;;=F17.200^^53^607^31
 ;;^UTILITY(U,$J,358.3,14452,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14452,1,3,0)
 ;;=3^Nicotine Dependence,Unspec,Uncomplicated
 ;;^UTILITY(U,$J,358.3,14452,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,14452,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,14453,0)
 ;;=F11.120^^53^607^32
 ;;^UTILITY(U,$J,358.3,14453,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14453,1,3,0)
 ;;=3^Opioid Abuse w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,14453,1,4,0)
 ;;=4^F11.120
 ;;^UTILITY(U,$J,358.3,14453,2)
 ;;=^5003115
 ;;^UTILITY(U,$J,358.3,14454,0)
 ;;=F11.10^^53^607^34
 ;;^UTILITY(U,$J,358.3,14454,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14454,1,3,0)
 ;;=3^Opioid Abuse,Uncomplicated
 ;;^UTILITY(U,$J,358.3,14454,1,4,0)
 ;;=4^F11.10
 ;;^UTILITY(U,$J,358.3,14454,2)
 ;;=^5003114
 ;;^UTILITY(U,$J,358.3,14455,0)
 ;;=F11.129^^53^607^33
 ;;^UTILITY(U,$J,358.3,14455,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14455,1,3,0)
 ;;=3^Opioid Abuse w/ Intoxication,Unspec
 ;;^UTILITY(U,$J,358.3,14455,1,4,0)
 ;;=4^F11.129
 ;;^UTILITY(U,$J,358.3,14455,2)
 ;;=^5003118
 ;;^UTILITY(U,$J,358.3,14456,0)
 ;;=F10.21^^53^607^3
 ;;^UTILITY(U,$J,358.3,14456,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14456,1,3,0)
 ;;=3^Alcohol Dependence,In Remission
 ;;^UTILITY(U,$J,358.3,14456,1,4,0)
 ;;=4^F10.21
 ;;^UTILITY(U,$J,358.3,14456,2)
 ;;=^5003082
 ;;^UTILITY(U,$J,358.3,14457,0)
 ;;=F12.10^^53^607^5
 ;;^UTILITY(U,$J,358.3,14457,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14457,1,3,0)
 ;;=3^Cannabis Abuse,Uncomplicated
 ;;^UTILITY(U,$J,358.3,14457,1,4,0)
 ;;=4^F12.10
 ;;^UTILITY(U,$J,358.3,14457,2)
 ;;=^5003155
 ;;^UTILITY(U,$J,358.3,14458,0)
 ;;=F12.20^^53^607^7
 ;;^UTILITY(U,$J,358.3,14458,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14458,1,3,0)
 ;;=3^Cannabis Dependence,Uncomplicated
 ;;^UTILITY(U,$J,358.3,14458,1,4,0)
 ;;=4^F12.20
 ;;^UTILITY(U,$J,358.3,14458,2)
 ;;=^5003166
 ;;^UTILITY(U,$J,358.3,14459,0)
 ;;=F12.21^^53^607^6
 ;;^UTILITY(U,$J,358.3,14459,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14459,1,3,0)
 ;;=3^Cannabis Dependence,In Remission
 ;;^UTILITY(U,$J,358.3,14459,1,4,0)
 ;;=4^F12.21
 ;;^UTILITY(U,$J,358.3,14459,2)
 ;;=^5003167
 ;;^UTILITY(U,$J,358.3,14460,0)
 ;;=F12.90^^53^607^8
 ;;^UTILITY(U,$J,358.3,14460,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14460,1,3,0)
 ;;=3^Cannabis Use,Unspec,Uncomplicated
 ;;^UTILITY(U,$J,358.3,14460,1,4,0)
 ;;=4^F12.90
 ;;^UTILITY(U,$J,358.3,14460,2)
 ;;=^5003178
 ;;^UTILITY(U,$J,358.3,14461,0)
 ;;=I83.019^^53^608^3
 ;;^UTILITY(U,$J,358.3,14461,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14461,1,3,0)
 ;;=3^Varicose Veins Right Lower Extrem w/ Ulcer,Unspec

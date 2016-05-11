IBDEI18P ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,21074,1,4,0)
 ;;=4^F17.290
 ;;^UTILITY(U,$J,358.3,21074,2)
 ;;=^5003375
 ;;^UTILITY(U,$J,358.3,21075,0)
 ;;=F17.221^^84^943^24
 ;;^UTILITY(U,$J,358.3,21075,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21075,1,3,0)
 ;;=3^Nicotine Dependence Chewing Tobacco,In Remission
 ;;^UTILITY(U,$J,358.3,21075,1,4,0)
 ;;=4^F17.221
 ;;^UTILITY(U,$J,358.3,21075,2)
 ;;=^5003371
 ;;^UTILITY(U,$J,358.3,21076,0)
 ;;=F17.220^^84^943^25
 ;;^UTILITY(U,$J,358.3,21076,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21076,1,3,0)
 ;;=3^Nicotine Dependence Chewing Tobacco,Uncomplicated
 ;;^UTILITY(U,$J,358.3,21076,1,4,0)
 ;;=4^F17.220
 ;;^UTILITY(U,$J,358.3,21076,2)
 ;;=^5003370
 ;;^UTILITY(U,$J,358.3,21077,0)
 ;;=F17.211^^84^943^26
 ;;^UTILITY(U,$J,358.3,21077,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21077,1,3,0)
 ;;=3^Nicotine Dependence Cigarettes,In Remission
 ;;^UTILITY(U,$J,358.3,21077,1,4,0)
 ;;=4^F17.211
 ;;^UTILITY(U,$J,358.3,21077,2)
 ;;=^5003366
 ;;^UTILITY(U,$J,358.3,21078,0)
 ;;=F17.200^^84^943^31
 ;;^UTILITY(U,$J,358.3,21078,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21078,1,3,0)
 ;;=3^Nicotine Dependence,Unspec,Uncomplicated
 ;;^UTILITY(U,$J,358.3,21078,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,21078,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,21079,0)
 ;;=F11.120^^84^943^32
 ;;^UTILITY(U,$J,358.3,21079,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21079,1,3,0)
 ;;=3^Opioid Abuse w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,21079,1,4,0)
 ;;=4^F11.120
 ;;^UTILITY(U,$J,358.3,21079,2)
 ;;=^5003115
 ;;^UTILITY(U,$J,358.3,21080,0)
 ;;=F11.10^^84^943^34
 ;;^UTILITY(U,$J,358.3,21080,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21080,1,3,0)
 ;;=3^Opioid Abuse,Uncomplicated
 ;;^UTILITY(U,$J,358.3,21080,1,4,0)
 ;;=4^F11.10
 ;;^UTILITY(U,$J,358.3,21080,2)
 ;;=^5003114
 ;;^UTILITY(U,$J,358.3,21081,0)
 ;;=F11.129^^84^943^33
 ;;^UTILITY(U,$J,358.3,21081,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21081,1,3,0)
 ;;=3^Opioid Abuse w/ Intoxication,Unspec
 ;;^UTILITY(U,$J,358.3,21081,1,4,0)
 ;;=4^F11.129
 ;;^UTILITY(U,$J,358.3,21081,2)
 ;;=^5003118
 ;;^UTILITY(U,$J,358.3,21082,0)
 ;;=F10.21^^84^943^3
 ;;^UTILITY(U,$J,358.3,21082,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21082,1,3,0)
 ;;=3^Alcohol Dependence,In Remission
 ;;^UTILITY(U,$J,358.3,21082,1,4,0)
 ;;=4^F10.21
 ;;^UTILITY(U,$J,358.3,21082,2)
 ;;=^5003082
 ;;^UTILITY(U,$J,358.3,21083,0)
 ;;=F12.10^^84^943^5
 ;;^UTILITY(U,$J,358.3,21083,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21083,1,3,0)
 ;;=3^Cannabis Abuse,Uncomplicated
 ;;^UTILITY(U,$J,358.3,21083,1,4,0)
 ;;=4^F12.10
 ;;^UTILITY(U,$J,358.3,21083,2)
 ;;=^5003155
 ;;^UTILITY(U,$J,358.3,21084,0)
 ;;=F12.20^^84^943^7
 ;;^UTILITY(U,$J,358.3,21084,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21084,1,3,0)
 ;;=3^Cannabis Dependence,Uncomplicated
 ;;^UTILITY(U,$J,358.3,21084,1,4,0)
 ;;=4^F12.20
 ;;^UTILITY(U,$J,358.3,21084,2)
 ;;=^5003166
 ;;^UTILITY(U,$J,358.3,21085,0)
 ;;=F12.21^^84^943^6
 ;;^UTILITY(U,$J,358.3,21085,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21085,1,3,0)
 ;;=3^Cannabis Dependence,In Remission
 ;;^UTILITY(U,$J,358.3,21085,1,4,0)
 ;;=4^F12.21
 ;;^UTILITY(U,$J,358.3,21085,2)
 ;;=^5003167
 ;;^UTILITY(U,$J,358.3,21086,0)
 ;;=F12.90^^84^943^8
 ;;^UTILITY(U,$J,358.3,21086,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21086,1,3,0)
 ;;=3^Cannabis Use,Unspec,Uncomplicated
 ;;^UTILITY(U,$J,358.3,21086,1,4,0)
 ;;=4^F12.90
 ;;^UTILITY(U,$J,358.3,21086,2)
 ;;=^5003178
 ;;^UTILITY(U,$J,358.3,21087,0)
 ;;=I83.019^^84^944^3
 ;;^UTILITY(U,$J,358.3,21087,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21087,1,3,0)
 ;;=3^Varicose Veins Right Lower Extrem w/ Ulcer,Unspec

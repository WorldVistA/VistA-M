IBDEI1DN ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23403,1,3,0)
 ;;=3^Opioid Abuse w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,23403,1,4,0)
 ;;=4^F11.120
 ;;^UTILITY(U,$J,358.3,23403,2)
 ;;=^5003115
 ;;^UTILITY(U,$J,358.3,23404,0)
 ;;=F11.10^^87^995^34
 ;;^UTILITY(U,$J,358.3,23404,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23404,1,3,0)
 ;;=3^Opioid Abuse,Uncomplicated
 ;;^UTILITY(U,$J,358.3,23404,1,4,0)
 ;;=4^F11.10
 ;;^UTILITY(U,$J,358.3,23404,2)
 ;;=^5003114
 ;;^UTILITY(U,$J,358.3,23405,0)
 ;;=F11.129^^87^995^33
 ;;^UTILITY(U,$J,358.3,23405,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23405,1,3,0)
 ;;=3^Opioid Abuse w/ Intoxication,Unspec
 ;;^UTILITY(U,$J,358.3,23405,1,4,0)
 ;;=4^F11.129
 ;;^UTILITY(U,$J,358.3,23405,2)
 ;;=^5003118
 ;;^UTILITY(U,$J,358.3,23406,0)
 ;;=F10.21^^87^995^3
 ;;^UTILITY(U,$J,358.3,23406,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23406,1,3,0)
 ;;=3^Alcohol Dependence,In Remission
 ;;^UTILITY(U,$J,358.3,23406,1,4,0)
 ;;=4^F10.21
 ;;^UTILITY(U,$J,358.3,23406,2)
 ;;=^5003082
 ;;^UTILITY(U,$J,358.3,23407,0)
 ;;=F12.10^^87^995^5
 ;;^UTILITY(U,$J,358.3,23407,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23407,1,3,0)
 ;;=3^Cannabis Abuse,Uncomplicated
 ;;^UTILITY(U,$J,358.3,23407,1,4,0)
 ;;=4^F12.10
 ;;^UTILITY(U,$J,358.3,23407,2)
 ;;=^5003155
 ;;^UTILITY(U,$J,358.3,23408,0)
 ;;=F12.20^^87^995^7
 ;;^UTILITY(U,$J,358.3,23408,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23408,1,3,0)
 ;;=3^Cannabis Dependence,Uncomplicated
 ;;^UTILITY(U,$J,358.3,23408,1,4,0)
 ;;=4^F12.20
 ;;^UTILITY(U,$J,358.3,23408,2)
 ;;=^5003166
 ;;^UTILITY(U,$J,358.3,23409,0)
 ;;=F12.21^^87^995^6
 ;;^UTILITY(U,$J,358.3,23409,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23409,1,3,0)
 ;;=3^Cannabis Dependence,In Remission
 ;;^UTILITY(U,$J,358.3,23409,1,4,0)
 ;;=4^F12.21
 ;;^UTILITY(U,$J,358.3,23409,2)
 ;;=^5003167
 ;;^UTILITY(U,$J,358.3,23410,0)
 ;;=F12.90^^87^995^8
 ;;^UTILITY(U,$J,358.3,23410,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23410,1,3,0)
 ;;=3^Cannabis Use,Unspec,Uncomplicated
 ;;^UTILITY(U,$J,358.3,23410,1,4,0)
 ;;=4^F12.90
 ;;^UTILITY(U,$J,358.3,23410,2)
 ;;=^5003178
 ;;^UTILITY(U,$J,358.3,23411,0)
 ;;=I83.019^^87^996^3
 ;;^UTILITY(U,$J,358.3,23411,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23411,1,3,0)
 ;;=3^Varicose Veins Right Lower Extrem w/ Ulcer,Unspec
 ;;^UTILITY(U,$J,358.3,23411,1,4,0)
 ;;=4^I83.019
 ;;^UTILITY(U,$J,358.3,23411,2)
 ;;=^5007979
 ;;^UTILITY(U,$J,358.3,23412,0)
 ;;=I83.219^^87^996^4
 ;;^UTILITY(U,$J,358.3,23412,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23412,1,3,0)
 ;;=3^Varicose Veins Right Lower Extrem w/ Ulcer & Inflam,Unspec
 ;;^UTILITY(U,$J,358.3,23412,1,4,0)
 ;;=4^I83.219
 ;;^UTILITY(U,$J,358.3,23412,2)
 ;;=^5008003
 ;;^UTILITY(U,$J,358.3,23413,0)
 ;;=I83.029^^87^996^1
 ;;^UTILITY(U,$J,358.3,23413,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23413,1,3,0)
 ;;=3^Varicose Veins Left Lower Extrem w/ Ulcer,Unspec
 ;;^UTILITY(U,$J,358.3,23413,1,4,0)
 ;;=4^I83.029
 ;;^UTILITY(U,$J,358.3,23413,2)
 ;;=^5007986
 ;;^UTILITY(U,$J,358.3,23414,0)
 ;;=I83.229^^87^996^2
 ;;^UTILITY(U,$J,358.3,23414,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23414,1,3,0)
 ;;=3^Varicose Veins Left Lower Extrem w/ Ulcer & Inflam,Unspec
 ;;^UTILITY(U,$J,358.3,23414,1,4,0)
 ;;=4^I83.229
 ;;^UTILITY(U,$J,358.3,23414,2)
 ;;=^5008010
 ;;^UTILITY(U,$J,358.3,23415,0)
 ;;=B00.81^^87^997^25
 ;;^UTILITY(U,$J,358.3,23415,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23415,1,3,0)
 ;;=3^Herpesviral Hepatitis
 ;;^UTILITY(U,$J,358.3,23415,1,4,0)
 ;;=4^B00.81
 ;;^UTILITY(U,$J,358.3,23415,2)
 ;;=^5000478
 ;;^UTILITY(U,$J,358.3,23416,0)
 ;;=D25.9^^87^997^31

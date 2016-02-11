IBDEI16V ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,19866,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19866,1,3,0)
 ;;=3^Nicotine Dependence,Unspec,Uncomplicated
 ;;^UTILITY(U,$J,358.3,19866,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,19866,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,19867,0)
 ;;=F11.120^^94^930^32
 ;;^UTILITY(U,$J,358.3,19867,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19867,1,3,0)
 ;;=3^Opioid Abuse w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,19867,1,4,0)
 ;;=4^F11.120
 ;;^UTILITY(U,$J,358.3,19867,2)
 ;;=^5003115
 ;;^UTILITY(U,$J,358.3,19868,0)
 ;;=F11.10^^94^930^34
 ;;^UTILITY(U,$J,358.3,19868,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19868,1,3,0)
 ;;=3^Opioid Abuse,Uncomplicated
 ;;^UTILITY(U,$J,358.3,19868,1,4,0)
 ;;=4^F11.10
 ;;^UTILITY(U,$J,358.3,19868,2)
 ;;=^5003114
 ;;^UTILITY(U,$J,358.3,19869,0)
 ;;=F11.129^^94^930^33
 ;;^UTILITY(U,$J,358.3,19869,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19869,1,3,0)
 ;;=3^Opioid Abuse w/ Intoxication,Unspec
 ;;^UTILITY(U,$J,358.3,19869,1,4,0)
 ;;=4^F11.129
 ;;^UTILITY(U,$J,358.3,19869,2)
 ;;=^5003118
 ;;^UTILITY(U,$J,358.3,19870,0)
 ;;=F10.21^^94^930^3
 ;;^UTILITY(U,$J,358.3,19870,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19870,1,3,0)
 ;;=3^Alcohol Dependence,In Remission
 ;;^UTILITY(U,$J,358.3,19870,1,4,0)
 ;;=4^F10.21
 ;;^UTILITY(U,$J,358.3,19870,2)
 ;;=^5003082
 ;;^UTILITY(U,$J,358.3,19871,0)
 ;;=F12.10^^94^930^5
 ;;^UTILITY(U,$J,358.3,19871,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19871,1,3,0)
 ;;=3^Cannabis Abuse,Uncomplicated
 ;;^UTILITY(U,$J,358.3,19871,1,4,0)
 ;;=4^F12.10
 ;;^UTILITY(U,$J,358.3,19871,2)
 ;;=^5003155
 ;;^UTILITY(U,$J,358.3,19872,0)
 ;;=F12.20^^94^930^7
 ;;^UTILITY(U,$J,358.3,19872,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19872,1,3,0)
 ;;=3^Cannabis Dependence,Uncomplicated
 ;;^UTILITY(U,$J,358.3,19872,1,4,0)
 ;;=4^F12.20
 ;;^UTILITY(U,$J,358.3,19872,2)
 ;;=^5003166
 ;;^UTILITY(U,$J,358.3,19873,0)
 ;;=F12.21^^94^930^6
 ;;^UTILITY(U,$J,358.3,19873,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19873,1,3,0)
 ;;=3^Cannabis Dependence,In Remission
 ;;^UTILITY(U,$J,358.3,19873,1,4,0)
 ;;=4^F12.21
 ;;^UTILITY(U,$J,358.3,19873,2)
 ;;=^5003167
 ;;^UTILITY(U,$J,358.3,19874,0)
 ;;=F12.90^^94^930^8
 ;;^UTILITY(U,$J,358.3,19874,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19874,1,3,0)
 ;;=3^Cannabis Use,Unspec,Uncomplicated
 ;;^UTILITY(U,$J,358.3,19874,1,4,0)
 ;;=4^F12.90
 ;;^UTILITY(U,$J,358.3,19874,2)
 ;;=^5003178
 ;;^UTILITY(U,$J,358.3,19875,0)
 ;;=I83.019^^94^931^3
 ;;^UTILITY(U,$J,358.3,19875,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19875,1,3,0)
 ;;=3^Varicose Veins Right Lower Extrem w/ Ulcer,Unspec
 ;;^UTILITY(U,$J,358.3,19875,1,4,0)
 ;;=4^I83.019
 ;;^UTILITY(U,$J,358.3,19875,2)
 ;;=^5007979
 ;;^UTILITY(U,$J,358.3,19876,0)
 ;;=I83.219^^94^931^4
 ;;^UTILITY(U,$J,358.3,19876,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19876,1,3,0)
 ;;=3^Varicose Veins Right Lower Extrem w/ Ulcer & Inflam,Unspec
 ;;^UTILITY(U,$J,358.3,19876,1,4,0)
 ;;=4^I83.219
 ;;^UTILITY(U,$J,358.3,19876,2)
 ;;=^5008003
 ;;^UTILITY(U,$J,358.3,19877,0)
 ;;=I83.029^^94^931^1
 ;;^UTILITY(U,$J,358.3,19877,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19877,1,3,0)
 ;;=3^Varicose Veins Left Lower Extrem w/ Ulcer,Unspec
 ;;^UTILITY(U,$J,358.3,19877,1,4,0)
 ;;=4^I83.029
 ;;^UTILITY(U,$J,358.3,19877,2)
 ;;=^5007986
 ;;^UTILITY(U,$J,358.3,19878,0)
 ;;=I83.229^^94^931^2
 ;;^UTILITY(U,$J,358.3,19878,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19878,1,3,0)
 ;;=3^Varicose Veins Left Lower Extrem w/ Ulcer & Inflam,Unspec
 ;;^UTILITY(U,$J,358.3,19878,1,4,0)
 ;;=4^I83.229

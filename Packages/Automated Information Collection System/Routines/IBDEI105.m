IBDEI105 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,16998,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,16998,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,16999,0)
 ;;=F10.229^^70^804^2
 ;;^UTILITY(U,$J,358.3,16999,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16999,1,3,0)
 ;;=3^Alcohol dependence w/ intoxctn, unspec
 ;;^UTILITY(U,$J,358.3,16999,1,4,0)
 ;;=4^F10.229
 ;;^UTILITY(U,$J,358.3,16999,2)
 ;;=^5003085
 ;;^UTILITY(U,$J,358.3,17000,0)
 ;;=F12.10^^70^804^4
 ;;^UTILITY(U,$J,358.3,17000,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17000,1,3,0)
 ;;=3^Cannabis abuse, uncomplicated
 ;;^UTILITY(U,$J,358.3,17000,1,4,0)
 ;;=4^F12.10
 ;;^UTILITY(U,$J,358.3,17000,2)
 ;;=^5003155
 ;;^UTILITY(U,$J,358.3,17001,0)
 ;;=F12.20^^70^804^5
 ;;^UTILITY(U,$J,358.3,17001,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17001,1,3,0)
 ;;=3^Cannabis dependence, uncomplicated
 ;;^UTILITY(U,$J,358.3,17001,1,4,0)
 ;;=4^F12.20
 ;;^UTILITY(U,$J,358.3,17001,2)
 ;;=^5003166
 ;;^UTILITY(U,$J,358.3,17002,0)
 ;;=F14.10^^70^804^6
 ;;^UTILITY(U,$J,358.3,17002,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17002,1,3,0)
 ;;=3^Cocaine abuse, uncomplicated
 ;;^UTILITY(U,$J,358.3,17002,1,4,0)
 ;;=4^F14.10
 ;;^UTILITY(U,$J,358.3,17002,2)
 ;;=^5003239
 ;;^UTILITY(U,$J,358.3,17003,0)
 ;;=F14.20^^70^804^7
 ;;^UTILITY(U,$J,358.3,17003,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17003,1,3,0)
 ;;=3^Cocaine dependence, uncomplicated
 ;;^UTILITY(U,$J,358.3,17003,1,4,0)
 ;;=4^F14.20
 ;;^UTILITY(U,$J,358.3,17003,2)
 ;;=^5003253
 ;;^UTILITY(U,$J,358.3,17004,0)
 ;;=F16.10^^70^804^8
 ;;^UTILITY(U,$J,358.3,17004,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17004,1,3,0)
 ;;=3^Hallucinogen abuse, uncomplicated
 ;;^UTILITY(U,$J,358.3,17004,1,4,0)
 ;;=4^F16.10
 ;;^UTILITY(U,$J,358.3,17004,2)
 ;;=^5003323
 ;;^UTILITY(U,$J,358.3,17005,0)
 ;;=F16.20^^70^804^9
 ;;^UTILITY(U,$J,358.3,17005,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17005,1,3,0)
 ;;=3^Hallucinogen dependence, uncomplicated
 ;;^UTILITY(U,$J,358.3,17005,1,4,0)
 ;;=4^F16.20
 ;;^UTILITY(U,$J,358.3,17005,2)
 ;;=^5003336
 ;;^UTILITY(U,$J,358.3,17006,0)
 ;;=F18.10^^70^804^10
 ;;^UTILITY(U,$J,358.3,17006,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17006,1,3,0)
 ;;=3^Inhalant abuse, uncomplicated
 ;;^UTILITY(U,$J,358.3,17006,1,4,0)
 ;;=4^F18.10
 ;;^UTILITY(U,$J,358.3,17006,2)
 ;;=^5003380
 ;;^UTILITY(U,$J,358.3,17007,0)
 ;;=F17.200^^70^804^11
 ;;^UTILITY(U,$J,358.3,17007,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17007,1,3,0)
 ;;=3^Nicotine dependence, unspec, uncomp
 ;;^UTILITY(U,$J,358.3,17007,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,17007,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,17008,0)
 ;;=F11.10^^70^804^12
 ;;^UTILITY(U,$J,358.3,17008,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17008,1,3,0)
 ;;=3^Opioid abuse, uncomplicated
 ;;^UTILITY(U,$J,358.3,17008,1,4,0)
 ;;=4^F11.10
 ;;^UTILITY(U,$J,358.3,17008,2)
 ;;=^5003114
 ;;^UTILITY(U,$J,358.3,17009,0)
 ;;=F11.20^^70^804^13
 ;;^UTILITY(U,$J,358.3,17009,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17009,1,3,0)
 ;;=3^Opioid dependence, uncomplicated
 ;;^UTILITY(U,$J,358.3,17009,1,4,0)
 ;;=4^F11.20
 ;;^UTILITY(U,$J,358.3,17009,2)
 ;;=^5003127
 ;;^UTILITY(U,$J,358.3,17010,0)
 ;;=F13.10^^70^804^16
 ;;^UTILITY(U,$J,358.3,17010,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17010,1,3,0)
 ;;=3^Sedative, hypnotic or anxiolytic abuse, uncomp
 ;;^UTILITY(U,$J,358.3,17010,1,4,0)
 ;;=4^F13.10
 ;;^UTILITY(U,$J,358.3,17010,2)
 ;;=^5003189
 ;;^UTILITY(U,$J,358.3,17011,0)
 ;;=F13.20^^70^804^17
 ;;^UTILITY(U,$J,358.3,17011,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17011,1,3,0)
 ;;=3^Sedative, hypnotic or anxiolytic dependence, uncomp

IBDEI1FZ ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24083,0)
 ;;=F10.10^^116^1182^1
 ;;^UTILITY(U,$J,358.3,24083,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24083,1,3,0)
 ;;=3^Alcohol abuse, uncomplicated
 ;;^UTILITY(U,$J,358.3,24083,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,24083,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,24084,0)
 ;;=F10.20^^116^1182^3
 ;;^UTILITY(U,$J,358.3,24084,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24084,1,3,0)
 ;;=3^Alcohol dependence, uncomplicated
 ;;^UTILITY(U,$J,358.3,24084,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,24084,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,24085,0)
 ;;=F10.229^^116^1182^2
 ;;^UTILITY(U,$J,358.3,24085,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24085,1,3,0)
 ;;=3^Alcohol dependence w/ intoxctn, unspec
 ;;^UTILITY(U,$J,358.3,24085,1,4,0)
 ;;=4^F10.229
 ;;^UTILITY(U,$J,358.3,24085,2)
 ;;=^5003085
 ;;^UTILITY(U,$J,358.3,24086,0)
 ;;=F12.10^^116^1182^4
 ;;^UTILITY(U,$J,358.3,24086,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24086,1,3,0)
 ;;=3^Cannabis abuse, uncomplicated
 ;;^UTILITY(U,$J,358.3,24086,1,4,0)
 ;;=4^F12.10
 ;;^UTILITY(U,$J,358.3,24086,2)
 ;;=^5003155
 ;;^UTILITY(U,$J,358.3,24087,0)
 ;;=F12.20^^116^1182^5
 ;;^UTILITY(U,$J,358.3,24087,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24087,1,3,0)
 ;;=3^Cannabis dependence, uncomplicated
 ;;^UTILITY(U,$J,358.3,24087,1,4,0)
 ;;=4^F12.20
 ;;^UTILITY(U,$J,358.3,24087,2)
 ;;=^5003166
 ;;^UTILITY(U,$J,358.3,24088,0)
 ;;=F14.10^^116^1182^6
 ;;^UTILITY(U,$J,358.3,24088,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24088,1,3,0)
 ;;=3^Cocaine abuse, uncomplicated
 ;;^UTILITY(U,$J,358.3,24088,1,4,0)
 ;;=4^F14.10
 ;;^UTILITY(U,$J,358.3,24088,2)
 ;;=^5003239
 ;;^UTILITY(U,$J,358.3,24089,0)
 ;;=F14.20^^116^1182^7
 ;;^UTILITY(U,$J,358.3,24089,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24089,1,3,0)
 ;;=3^Cocaine dependence, uncomplicated
 ;;^UTILITY(U,$J,358.3,24089,1,4,0)
 ;;=4^F14.20
 ;;^UTILITY(U,$J,358.3,24089,2)
 ;;=^5003253
 ;;^UTILITY(U,$J,358.3,24090,0)
 ;;=F16.10^^116^1182^8
 ;;^UTILITY(U,$J,358.3,24090,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24090,1,3,0)
 ;;=3^Hallucinogen abuse, uncomplicated
 ;;^UTILITY(U,$J,358.3,24090,1,4,0)
 ;;=4^F16.10
 ;;^UTILITY(U,$J,358.3,24090,2)
 ;;=^5003323
 ;;^UTILITY(U,$J,358.3,24091,0)
 ;;=F16.20^^116^1182^9
 ;;^UTILITY(U,$J,358.3,24091,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24091,1,3,0)
 ;;=3^Hallucinogen dependence, uncomplicated
 ;;^UTILITY(U,$J,358.3,24091,1,4,0)
 ;;=4^F16.20
 ;;^UTILITY(U,$J,358.3,24091,2)
 ;;=^5003336
 ;;^UTILITY(U,$J,358.3,24092,0)
 ;;=F18.10^^116^1182^10
 ;;^UTILITY(U,$J,358.3,24092,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24092,1,3,0)
 ;;=3^Inhalant abuse, uncomplicated
 ;;^UTILITY(U,$J,358.3,24092,1,4,0)
 ;;=4^F18.10
 ;;^UTILITY(U,$J,358.3,24092,2)
 ;;=^5003380
 ;;^UTILITY(U,$J,358.3,24093,0)
 ;;=F17.200^^116^1182^11
 ;;^UTILITY(U,$J,358.3,24093,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24093,1,3,0)
 ;;=3^Nicotine dependence, unspec, uncomp
 ;;^UTILITY(U,$J,358.3,24093,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,24093,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,24094,0)
 ;;=F11.10^^116^1182^12
 ;;^UTILITY(U,$J,358.3,24094,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24094,1,3,0)
 ;;=3^Opioid abuse, uncomplicated
 ;;^UTILITY(U,$J,358.3,24094,1,4,0)
 ;;=4^F11.10
 ;;^UTILITY(U,$J,358.3,24094,2)
 ;;=^5003114
 ;;^UTILITY(U,$J,358.3,24095,0)
 ;;=F11.20^^116^1182^13
 ;;^UTILITY(U,$J,358.3,24095,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24095,1,3,0)
 ;;=3^Opioid dependence, uncomplicated
 ;;^UTILITY(U,$J,358.3,24095,1,4,0)
 ;;=4^F11.20
 ;;^UTILITY(U,$J,358.3,24095,2)
 ;;=^5003127

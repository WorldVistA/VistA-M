IBDEI1DK ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,21972,1,3,0)
 ;;=3^Cannabis dependence, uncomplicated
 ;;^UTILITY(U,$J,358.3,21972,1,4,0)
 ;;=4^F12.20
 ;;^UTILITY(U,$J,358.3,21972,2)
 ;;=^5003166
 ;;^UTILITY(U,$J,358.3,21973,0)
 ;;=F14.10^^99^1120^9
 ;;^UTILITY(U,$J,358.3,21973,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21973,1,3,0)
 ;;=3^Cocaine abuse, uncomplicated
 ;;^UTILITY(U,$J,358.3,21973,1,4,0)
 ;;=4^F14.10
 ;;^UTILITY(U,$J,358.3,21973,2)
 ;;=^5003239
 ;;^UTILITY(U,$J,358.3,21974,0)
 ;;=F14.20^^99^1120^10
 ;;^UTILITY(U,$J,358.3,21974,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21974,1,3,0)
 ;;=3^Cocaine dependence, uncomplicated
 ;;^UTILITY(U,$J,358.3,21974,1,4,0)
 ;;=4^F14.20
 ;;^UTILITY(U,$J,358.3,21974,2)
 ;;=^5003253
 ;;^UTILITY(U,$J,358.3,21975,0)
 ;;=F16.10^^99^1120^12
 ;;^UTILITY(U,$J,358.3,21975,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21975,1,3,0)
 ;;=3^Hallucinogen abuse, uncomplicated
 ;;^UTILITY(U,$J,358.3,21975,1,4,0)
 ;;=4^F16.10
 ;;^UTILITY(U,$J,358.3,21975,2)
 ;;=^5003323
 ;;^UTILITY(U,$J,358.3,21976,0)
 ;;=F16.20^^99^1120^13
 ;;^UTILITY(U,$J,358.3,21976,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21976,1,3,0)
 ;;=3^Hallucinogen dependence, uncomplicated
 ;;^UTILITY(U,$J,358.3,21976,1,4,0)
 ;;=4^F16.20
 ;;^UTILITY(U,$J,358.3,21976,2)
 ;;=^5003336
 ;;^UTILITY(U,$J,358.3,21977,0)
 ;;=F18.10^^99^1120^15
 ;;^UTILITY(U,$J,358.3,21977,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21977,1,3,0)
 ;;=3^Inhalant abuse, uncomplicated
 ;;^UTILITY(U,$J,358.3,21977,1,4,0)
 ;;=4^F18.10
 ;;^UTILITY(U,$J,358.3,21977,2)
 ;;=^5003380
 ;;^UTILITY(U,$J,358.3,21978,0)
 ;;=F17.200^^99^1120^18
 ;;^UTILITY(U,$J,358.3,21978,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21978,1,3,0)
 ;;=3^Nicotine dependence, unspec, uncomp
 ;;^UTILITY(U,$J,358.3,21978,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,21978,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,21979,0)
 ;;=F11.10^^99^1120^20
 ;;^UTILITY(U,$J,358.3,21979,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21979,1,3,0)
 ;;=3^Opioid abuse, uncomplicated
 ;;^UTILITY(U,$J,358.3,21979,1,4,0)
 ;;=4^F11.10
 ;;^UTILITY(U,$J,358.3,21979,2)
 ;;=^5003114
 ;;^UTILITY(U,$J,358.3,21980,0)
 ;;=F11.20^^99^1120^21
 ;;^UTILITY(U,$J,358.3,21980,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21980,1,3,0)
 ;;=3^Opioid dependence, uncomplicated
 ;;^UTILITY(U,$J,358.3,21980,1,4,0)
 ;;=4^F11.20
 ;;^UTILITY(U,$J,358.3,21980,2)
 ;;=^5003127
 ;;^UTILITY(U,$J,358.3,21981,0)
 ;;=F13.10^^99^1120^25
 ;;^UTILITY(U,$J,358.3,21981,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21981,1,3,0)
 ;;=3^Sedative, hypnotic or anxiolytic abuse, uncomp
 ;;^UTILITY(U,$J,358.3,21981,1,4,0)
 ;;=4^F13.10
 ;;^UTILITY(U,$J,358.3,21981,2)
 ;;=^5003189
 ;;^UTILITY(U,$J,358.3,21982,0)
 ;;=F13.20^^99^1120^26
 ;;^UTILITY(U,$J,358.3,21982,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21982,1,3,0)
 ;;=3^Sedative, hypnotic or anxiolytic dependence, uncomp
 ;;^UTILITY(U,$J,358.3,21982,1,4,0)
 ;;=4^F13.20
 ;;^UTILITY(U,$J,358.3,21982,2)
 ;;=^5003202
 ;;^UTILITY(U,$J,358.3,21983,0)
 ;;=F19.20^^99^1120^24
 ;;^UTILITY(U,$J,358.3,21983,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21983,1,3,0)
 ;;=3^Psychoactive Substance Dependence,Uncomp
 ;;^UTILITY(U,$J,358.3,21983,1,4,0)
 ;;=4^F19.20
 ;;^UTILITY(U,$J,358.3,21983,2)
 ;;=^5003431
 ;;^UTILITY(U,$J,358.3,21984,0)
 ;;=F15.10^^99^1120^29
 ;;^UTILITY(U,$J,358.3,21984,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21984,1,3,0)
 ;;=3^Stimulant Abuse,Uncomp

IBDEI0LG ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9651,1,3,0)
 ;;=3^Nicotine Dependence,Unspec,Uncomplicated
 ;;^UTILITY(U,$J,358.3,9651,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,9651,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,9652,0)
 ;;=F11.120^^39^415^45
 ;;^UTILITY(U,$J,358.3,9652,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9652,1,3,0)
 ;;=3^Opioid Abuse w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,9652,1,4,0)
 ;;=4^F11.120
 ;;^UTILITY(U,$J,358.3,9652,2)
 ;;=^5003115
 ;;^UTILITY(U,$J,358.3,9653,0)
 ;;=F11.10^^39^415^49
 ;;^UTILITY(U,$J,358.3,9653,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9653,1,3,0)
 ;;=3^Opioid Abuse,Uncomplicated
 ;;^UTILITY(U,$J,358.3,9653,1,4,0)
 ;;=4^F11.10
 ;;^UTILITY(U,$J,358.3,9653,2)
 ;;=^5003114
 ;;^UTILITY(U,$J,358.3,9654,0)
 ;;=F11.129^^39^415^46
 ;;^UTILITY(U,$J,358.3,9654,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9654,1,3,0)
 ;;=3^Opioid Abuse w/ Intoxication,Unspec
 ;;^UTILITY(U,$J,358.3,9654,1,4,0)
 ;;=4^F11.129
 ;;^UTILITY(U,$J,358.3,9654,2)
 ;;=^5003118
 ;;^UTILITY(U,$J,358.3,9655,0)
 ;;=F10.21^^39^415^8
 ;;^UTILITY(U,$J,358.3,9655,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9655,1,3,0)
 ;;=3^Alcohol Dependence,In Remission
 ;;^UTILITY(U,$J,358.3,9655,1,4,0)
 ;;=4^F10.21
 ;;^UTILITY(U,$J,358.3,9655,2)
 ;;=^5003082
 ;;^UTILITY(U,$J,358.3,9656,0)
 ;;=F12.10^^39^415^16
 ;;^UTILITY(U,$J,358.3,9656,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9656,1,3,0)
 ;;=3^Cannabis Abuse,Uncomplicated
 ;;^UTILITY(U,$J,358.3,9656,1,4,0)
 ;;=4^F12.10
 ;;^UTILITY(U,$J,358.3,9656,2)
 ;;=^5003155
 ;;^UTILITY(U,$J,358.3,9657,0)
 ;;=F12.20^^39^415^18
 ;;^UTILITY(U,$J,358.3,9657,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9657,1,3,0)
 ;;=3^Cannabis Dependence,Uncomplicated
 ;;^UTILITY(U,$J,358.3,9657,1,4,0)
 ;;=4^F12.20
 ;;^UTILITY(U,$J,358.3,9657,2)
 ;;=^5003166
 ;;^UTILITY(U,$J,358.3,9658,0)
 ;;=F12.21^^39^415^17
 ;;^UTILITY(U,$J,358.3,9658,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9658,1,3,0)
 ;;=3^Cannabis Dependence,In Remission
 ;;^UTILITY(U,$J,358.3,9658,1,4,0)
 ;;=4^F12.21
 ;;^UTILITY(U,$J,358.3,9658,2)
 ;;=^5003167
 ;;^UTILITY(U,$J,358.3,9659,0)
 ;;=F12.90^^39^415^20
 ;;^UTILITY(U,$J,358.3,9659,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9659,1,3,0)
 ;;=3^Cannabis Use,Unspec,Uncomplicated
 ;;^UTILITY(U,$J,358.3,9659,1,4,0)
 ;;=4^F12.90
 ;;^UTILITY(U,$J,358.3,9659,2)
 ;;=^5003178
 ;;^UTILITY(U,$J,358.3,9660,0)
 ;;=F10.11^^39^415^6
 ;;^UTILITY(U,$J,358.3,9660,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9660,1,3,0)
 ;;=3^Alcohol Abuse,In Remission
 ;;^UTILITY(U,$J,358.3,9660,1,4,0)
 ;;=4^F10.11
 ;;^UTILITY(U,$J,358.3,9660,2)
 ;;=^268230
 ;;^UTILITY(U,$J,358.3,9661,0)
 ;;=F12.11^^39^415^15
 ;;^UTILITY(U,$J,358.3,9661,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9661,1,3,0)
 ;;=3^Cannabis Abuse,In Remission
 ;;^UTILITY(U,$J,358.3,9661,1,4,0)
 ;;=4^F12.11
 ;;^UTILITY(U,$J,358.3,9661,2)
 ;;=^268236
 ;;^UTILITY(U,$J,358.3,9662,0)
 ;;=F14.11^^39^415^21
 ;;^UTILITY(U,$J,358.3,9662,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9662,1,3,0)
 ;;=3^Cocaine Abuse,In Remission
 ;;^UTILITY(U,$J,358.3,9662,1,4,0)
 ;;=4^F14.11
 ;;^UTILITY(U,$J,358.3,9662,2)
 ;;=^268249
 ;;^UTILITY(U,$J,358.3,9663,0)
 ;;=F11.11^^39^415^48
 ;;^UTILITY(U,$J,358.3,9663,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9663,1,3,0)
 ;;=3^Opioid Abuse,In Remission
 ;;^UTILITY(U,$J,358.3,9663,1,4,0)
 ;;=4^F11.11
 ;;^UTILITY(U,$J,358.3,9663,2)
 ;;=^268246

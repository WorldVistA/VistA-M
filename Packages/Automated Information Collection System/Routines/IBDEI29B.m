IBDEI29B ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,38281,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38281,1,3,0)
 ;;=3^Alcohol Intoxication w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,38281,1,4,0)
 ;;=4^F10.929
 ;;^UTILITY(U,$J,358.3,38281,2)
 ;;=^5003103
 ;;^UTILITY(U,$J,358.3,38282,0)
 ;;=F10.99^^145^1854^26
 ;;^UTILITY(U,$J,358.3,38282,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38282,1,3,0)
 ;;=3^Alcohol Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,38282,1,4,0)
 ;;=4^F10.99
 ;;^UTILITY(U,$J,358.3,38282,2)
 ;;=^5133351
 ;;^UTILITY(U,$J,358.3,38283,0)
 ;;=F15.10^^145^1855^4
 ;;^UTILITY(U,$J,358.3,38283,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38283,1,3,0)
 ;;=3^Amphetamine-Type Disorder,Mild
 ;;^UTILITY(U,$J,358.3,38283,1,4,0)
 ;;=4^F15.10
 ;;^UTILITY(U,$J,358.3,38283,2)
 ;;=^5003282
 ;;^UTILITY(U,$J,358.3,38284,0)
 ;;=F15.14^^145^1855^2
 ;;^UTILITY(U,$J,358.3,38284,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38284,1,3,0)
 ;;=3^Amphetamine-Induced Depressive,Bipolar & Related Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,38284,1,4,0)
 ;;=4^F15.14
 ;;^UTILITY(U,$J,358.3,38284,2)
 ;;=^5003287
 ;;^UTILITY(U,$J,358.3,38285,0)
 ;;=F15.182^^145^1855^3
 ;;^UTILITY(U,$J,358.3,38285,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38285,1,3,0)
 ;;=3^Amphetamine-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,38285,1,4,0)
 ;;=4^F15.182
 ;;^UTILITY(U,$J,358.3,38285,2)
 ;;=^5003293
 ;;^UTILITY(U,$J,358.3,38286,0)
 ;;=F15.20^^145^1855^5
 ;;^UTILITY(U,$J,358.3,38286,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38286,1,3,0)
 ;;=3^Amphetamine-Type Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,38286,1,4,0)
 ;;=4^F15.20
 ;;^UTILITY(U,$J,358.3,38286,2)
 ;;=^5003295
 ;;^UTILITY(U,$J,358.3,38287,0)
 ;;=F15.21^^145^1855^6
 ;;^UTILITY(U,$J,358.3,38287,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38287,1,3,0)
 ;;=3^Amphetamine-Type Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,38287,1,4,0)
 ;;=4^F15.21
 ;;^UTILITY(U,$J,358.3,38287,2)
 ;;=^5003296
 ;;^UTILITY(U,$J,358.3,38288,0)
 ;;=F15.23^^145^1855^1
 ;;^UTILITY(U,$J,358.3,38288,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38288,1,3,0)
 ;;=3^Amphetamine or Other Stimulant Withdrawal
 ;;^UTILITY(U,$J,358.3,38288,1,4,0)
 ;;=4^F15.23
 ;;^UTILITY(U,$J,358.3,38288,2)
 ;;=^5003301
 ;;^UTILITY(U,$J,358.3,38289,0)
 ;;=F12.10^^145^1856^16
 ;;^UTILITY(U,$J,358.3,38289,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38289,1,3,0)
 ;;=3^Cannabis Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,38289,1,4,0)
 ;;=4^F12.10
 ;;^UTILITY(U,$J,358.3,38289,2)
 ;;=^5003155
 ;;^UTILITY(U,$J,358.3,38290,0)
 ;;=F12.180^^145^1856^20
 ;;^UTILITY(U,$J,358.3,38290,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38290,1,3,0)
 ;;=3^Cannabis-Induced Anxiety Disorder w/ Mild Use Disorders
 ;;^UTILITY(U,$J,358.3,38290,1,4,0)
 ;;=4^F12.180
 ;;^UTILITY(U,$J,358.3,38290,2)
 ;;=^5003163
 ;;^UTILITY(U,$J,358.3,38291,0)
 ;;=F12.188^^145^1856^22
 ;;^UTILITY(U,$J,358.3,38291,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38291,1,3,0)
 ;;=3^Cannabis-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,38291,1,4,0)
 ;;=4^F12.188
 ;;^UTILITY(U,$J,358.3,38291,2)
 ;;=^5003164
 ;;^UTILITY(U,$J,358.3,38292,0)
 ;;=F12.20^^145^1856^17
 ;;^UTILITY(U,$J,358.3,38292,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38292,1,3,0)
 ;;=3^Cannabis Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,38292,1,4,0)
 ;;=4^F12.20
 ;;^UTILITY(U,$J,358.3,38292,2)
 ;;=^5003166
 ;;^UTILITY(U,$J,358.3,38293,0)
 ;;=F12.21^^145^1856^18
 ;;^UTILITY(U,$J,358.3,38293,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38293,1,3,0)
 ;;=3^Cannabis Use Disorder,Moderate-Severe,In Remission

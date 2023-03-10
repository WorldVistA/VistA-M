IBDEI0GD ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7342,1,4,0)
 ;;=4^J96.02
 ;;^UTILITY(U,$J,358.3,7342,2)
 ;;=^5008349
 ;;^UTILITY(U,$J,358.3,7343,0)
 ;;=J96.01^^36^365^76
 ;;^UTILITY(U,$J,358.3,7343,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7343,1,3,0)
 ;;=3^Respiratory failure,Acute w/ Hypoxia
 ;;^UTILITY(U,$J,358.3,7343,1,4,0)
 ;;=4^J96.01
 ;;^UTILITY(U,$J,358.3,7343,2)
 ;;=^5008348
 ;;^UTILITY(U,$J,358.3,7344,0)
 ;;=J96.22^^36^365^73
 ;;^UTILITY(U,$J,358.3,7344,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7344,1,3,0)
 ;;=3^Respiratory failure,Acute & Chronic w/ Hypercapnia
 ;;^UTILITY(U,$J,358.3,7344,1,4,0)
 ;;=4^J96.22
 ;;^UTILITY(U,$J,358.3,7344,2)
 ;;=^5008355
 ;;^UTILITY(U,$J,358.3,7345,0)
 ;;=J96.21^^36^365^74
 ;;^UTILITY(U,$J,358.3,7345,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7345,1,3,0)
 ;;=3^Respiratory failure,Acute & Chronic w/ Hypoxia
 ;;^UTILITY(U,$J,358.3,7345,1,4,0)
 ;;=4^J96.21
 ;;^UTILITY(U,$J,358.3,7345,2)
 ;;=^5008354
 ;;^UTILITY(U,$J,358.3,7346,0)
 ;;=J96.12^^36^365^77
 ;;^UTILITY(U,$J,358.3,7346,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7346,1,3,0)
 ;;=3^Respiratory failure,Chronic w/ Hypercapnia
 ;;^UTILITY(U,$J,358.3,7346,1,4,0)
 ;;=4^J96.12
 ;;^UTILITY(U,$J,358.3,7346,2)
 ;;=^5008352
 ;;^UTILITY(U,$J,358.3,7347,0)
 ;;=J96.11^^36^365^78
 ;;^UTILITY(U,$J,358.3,7347,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7347,1,3,0)
 ;;=3^Respiratory failure,Chronic w/ Hypoxia
 ;;^UTILITY(U,$J,358.3,7347,1,4,0)
 ;;=4^J96.11
 ;;^UTILITY(U,$J,358.3,7347,2)
 ;;=^5008351
 ;;^UTILITY(U,$J,358.3,7348,0)
 ;;=F10.188^^36^365^83
 ;;^UTILITY(U,$J,358.3,7348,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7348,1,3,0)
 ;;=3^Substance abuse,Alcohol w/ ETOH Induced Disorder
 ;;^UTILITY(U,$J,358.3,7348,1,4,0)
 ;;=4^F10.188
 ;;^UTILITY(U,$J,358.3,7348,2)
 ;;=^5003079
 ;;^UTILITY(U,$J,358.3,7349,0)
 ;;=F10.10^^36^365^84
 ;;^UTILITY(U,$J,358.3,7349,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7349,1,3,0)
 ;;=3^Substance abuse,Alcohol,Uncomplicated
 ;;^UTILITY(U,$J,358.3,7349,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,7349,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,7350,0)
 ;;=F12.120^^36^365^85
 ;;^UTILITY(U,$J,358.3,7350,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7350,1,3,0)
 ;;=3^Substance abuse,Cannabis w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,7350,1,4,0)
 ;;=4^F12.120
 ;;^UTILITY(U,$J,358.3,7350,2)
 ;;=^5003156
 ;;^UTILITY(U,$J,358.3,7351,0)
 ;;=F14.120^^36^365^86
 ;;^UTILITY(U,$J,358.3,7351,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7351,1,3,0)
 ;;=3^Substance abuse,Cocaine w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,7351,1,4,0)
 ;;=4^F14.120
 ;;^UTILITY(U,$J,358.3,7351,2)
 ;;=^5003240
 ;;^UTILITY(U,$J,358.3,7352,0)
 ;;=F16.120^^36^365^87
 ;;^UTILITY(U,$J,358.3,7352,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7352,1,3,0)
 ;;=3^Substance abuse,Hallucinogen w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,7352,1,4,0)
 ;;=4^F16.120
 ;;^UTILITY(U,$J,358.3,7352,2)
 ;;=^5003324
 ;;^UTILITY(U,$J,358.3,7353,0)
 ;;=F11.10^^36^365^88
 ;;^UTILITY(U,$J,358.3,7353,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7353,1,3,0)
 ;;=3^Substance abuse,Opioid,Uncomplicated
 ;;^UTILITY(U,$J,358.3,7353,1,4,0)
 ;;=4^F11.10
 ;;^UTILITY(U,$J,358.3,7353,2)
 ;;=^5003114
 ;;^UTILITY(U,$J,358.3,7354,0)
 ;;=F19.120^^36^365^89
 ;;^UTILITY(U,$J,358.3,7354,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7354,1,3,0)
 ;;=3^Substance abuse,Psychoactive w/ Intoxication,Uncomplicated

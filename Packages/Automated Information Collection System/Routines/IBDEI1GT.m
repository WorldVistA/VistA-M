IBDEI1GT ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24884,2)
 ;;=^5003084
 ;;^UTILITY(U,$J,358.3,24885,0)
 ;;=F10.921^^93^1116^22
 ;;^UTILITY(U,$J,358.3,24885,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24885,1,3,0)
 ;;=3^Alcohol Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,24885,1,4,0)
 ;;=4^F10.921
 ;;^UTILITY(U,$J,358.3,24885,2)
 ;;=^5003102
 ;;^UTILITY(U,$J,358.3,24886,0)
 ;;=F10.129^^93^1116^23
 ;;^UTILITY(U,$J,358.3,24886,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24886,1,3,0)
 ;;=3^Alcohol Intoxication w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,24886,1,4,0)
 ;;=4^F10.129
 ;;^UTILITY(U,$J,358.3,24886,2)
 ;;=^5003071
 ;;^UTILITY(U,$J,358.3,24887,0)
 ;;=F10.229^^93^1116^24
 ;;^UTILITY(U,$J,358.3,24887,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24887,1,3,0)
 ;;=3^Alcohol Intoxication w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,24887,1,4,0)
 ;;=4^F10.229
 ;;^UTILITY(U,$J,358.3,24887,2)
 ;;=^5003085
 ;;^UTILITY(U,$J,358.3,24888,0)
 ;;=F10.929^^93^1116^25
 ;;^UTILITY(U,$J,358.3,24888,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24888,1,3,0)
 ;;=3^Alcohol Intoxication w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,24888,1,4,0)
 ;;=4^F10.929
 ;;^UTILITY(U,$J,358.3,24888,2)
 ;;=^5003103
 ;;^UTILITY(U,$J,358.3,24889,0)
 ;;=F10.99^^93^1116^26
 ;;^UTILITY(U,$J,358.3,24889,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24889,1,3,0)
 ;;=3^Alcohol Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,24889,1,4,0)
 ;;=4^F10.99
 ;;^UTILITY(U,$J,358.3,24889,2)
 ;;=^5133351
 ;;^UTILITY(U,$J,358.3,24890,0)
 ;;=F15.10^^93^1117^4
 ;;^UTILITY(U,$J,358.3,24890,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24890,1,3,0)
 ;;=3^Amphetamine-Type Disorder,Mild
 ;;^UTILITY(U,$J,358.3,24890,1,4,0)
 ;;=4^F15.10
 ;;^UTILITY(U,$J,358.3,24890,2)
 ;;=^5003282
 ;;^UTILITY(U,$J,358.3,24891,0)
 ;;=F15.14^^93^1117^2
 ;;^UTILITY(U,$J,358.3,24891,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24891,1,3,0)
 ;;=3^Amphetamine-Induced Depressive,Bipolar & Related Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,24891,1,4,0)
 ;;=4^F15.14
 ;;^UTILITY(U,$J,358.3,24891,2)
 ;;=^5003287
 ;;^UTILITY(U,$J,358.3,24892,0)
 ;;=F15.182^^93^1117^3
 ;;^UTILITY(U,$J,358.3,24892,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24892,1,3,0)
 ;;=3^Amphetamine-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,24892,1,4,0)
 ;;=4^F15.182
 ;;^UTILITY(U,$J,358.3,24892,2)
 ;;=^5003293
 ;;^UTILITY(U,$J,358.3,24893,0)
 ;;=F15.20^^93^1117^5
 ;;^UTILITY(U,$J,358.3,24893,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24893,1,3,0)
 ;;=3^Amphetamine-Type Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,24893,1,4,0)
 ;;=4^F15.20
 ;;^UTILITY(U,$J,358.3,24893,2)
 ;;=^5003295
 ;;^UTILITY(U,$J,358.3,24894,0)
 ;;=F15.21^^93^1117^6
 ;;^UTILITY(U,$J,358.3,24894,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24894,1,3,0)
 ;;=3^Amphetamine-Type Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,24894,1,4,0)
 ;;=4^F15.21
 ;;^UTILITY(U,$J,358.3,24894,2)
 ;;=^5003296
 ;;^UTILITY(U,$J,358.3,24895,0)
 ;;=F15.23^^93^1117^1
 ;;^UTILITY(U,$J,358.3,24895,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24895,1,3,0)
 ;;=3^Amphetamine or Other Stimulant Withdrawal
 ;;^UTILITY(U,$J,358.3,24895,1,4,0)
 ;;=4^F15.23
 ;;^UTILITY(U,$J,358.3,24895,2)
 ;;=^5003301
 ;;^UTILITY(U,$J,358.3,24896,0)
 ;;=F12.10^^93^1118^16
 ;;^UTILITY(U,$J,358.3,24896,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24896,1,3,0)
 ;;=3^Cannabis Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,24896,1,4,0)
 ;;=4^F12.10
 ;;^UTILITY(U,$J,358.3,24896,2)
 ;;=^5003155
 ;;^UTILITY(U,$J,358.3,24897,0)
 ;;=F12.180^^93^1118^20
 ;;^UTILITY(U,$J,358.3,24897,1,0)
 ;;=^358.31IA^4^2

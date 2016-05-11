IBDEI0XE ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15666,0)
 ;;=F10.129^^58^684^23
 ;;^UTILITY(U,$J,358.3,15666,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15666,1,3,0)
 ;;=3^Alcohol Intoxication w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,15666,1,4,0)
 ;;=4^F10.129
 ;;^UTILITY(U,$J,358.3,15666,2)
 ;;=^5003071
 ;;^UTILITY(U,$J,358.3,15667,0)
 ;;=F10.229^^58^684^24
 ;;^UTILITY(U,$J,358.3,15667,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15667,1,3,0)
 ;;=3^Alcohol Intoxication w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,15667,1,4,0)
 ;;=4^F10.229
 ;;^UTILITY(U,$J,358.3,15667,2)
 ;;=^5003085
 ;;^UTILITY(U,$J,358.3,15668,0)
 ;;=F10.929^^58^684^25
 ;;^UTILITY(U,$J,358.3,15668,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15668,1,3,0)
 ;;=3^Alcohol Intoxication w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,15668,1,4,0)
 ;;=4^F10.929
 ;;^UTILITY(U,$J,358.3,15668,2)
 ;;=^5003103
 ;;^UTILITY(U,$J,358.3,15669,0)
 ;;=F10.99^^58^684^26
 ;;^UTILITY(U,$J,358.3,15669,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15669,1,3,0)
 ;;=3^Alcohol Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,15669,1,4,0)
 ;;=4^F10.99
 ;;^UTILITY(U,$J,358.3,15669,2)
 ;;=^5133351
 ;;^UTILITY(U,$J,358.3,15670,0)
 ;;=F15.10^^58^685^4
 ;;^UTILITY(U,$J,358.3,15670,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15670,1,3,0)
 ;;=3^Amphetamine-Type Disorder,Mild
 ;;^UTILITY(U,$J,358.3,15670,1,4,0)
 ;;=4^F15.10
 ;;^UTILITY(U,$J,358.3,15670,2)
 ;;=^5003282
 ;;^UTILITY(U,$J,358.3,15671,0)
 ;;=F15.14^^58^685^2
 ;;^UTILITY(U,$J,358.3,15671,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15671,1,3,0)
 ;;=3^Amphetamine-Induced Depressive,Bipolar & Related Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,15671,1,4,0)
 ;;=4^F15.14
 ;;^UTILITY(U,$J,358.3,15671,2)
 ;;=^5003287
 ;;^UTILITY(U,$J,358.3,15672,0)
 ;;=F15.182^^58^685^3
 ;;^UTILITY(U,$J,358.3,15672,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15672,1,3,0)
 ;;=3^Amphetamine-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,15672,1,4,0)
 ;;=4^F15.182
 ;;^UTILITY(U,$J,358.3,15672,2)
 ;;=^5003293
 ;;^UTILITY(U,$J,358.3,15673,0)
 ;;=F15.20^^58^685^5
 ;;^UTILITY(U,$J,358.3,15673,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15673,1,3,0)
 ;;=3^Amphetamine-Type Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,15673,1,4,0)
 ;;=4^F15.20
 ;;^UTILITY(U,$J,358.3,15673,2)
 ;;=^5003295
 ;;^UTILITY(U,$J,358.3,15674,0)
 ;;=F15.21^^58^685^6
 ;;^UTILITY(U,$J,358.3,15674,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15674,1,3,0)
 ;;=3^Amphetamine-Type Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,15674,1,4,0)
 ;;=4^F15.21
 ;;^UTILITY(U,$J,358.3,15674,2)
 ;;=^5003296
 ;;^UTILITY(U,$J,358.3,15675,0)
 ;;=F15.23^^58^685^1
 ;;^UTILITY(U,$J,358.3,15675,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15675,1,3,0)
 ;;=3^Amphetamine or Other Stimulant Withdrawal
 ;;^UTILITY(U,$J,358.3,15675,1,4,0)
 ;;=4^F15.23
 ;;^UTILITY(U,$J,358.3,15675,2)
 ;;=^5003301
 ;;^UTILITY(U,$J,358.3,15676,0)
 ;;=F12.10^^58^686^16
 ;;^UTILITY(U,$J,358.3,15676,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15676,1,3,0)
 ;;=3^Cannabis Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,15676,1,4,0)
 ;;=4^F12.10
 ;;^UTILITY(U,$J,358.3,15676,2)
 ;;=^5003155
 ;;^UTILITY(U,$J,358.3,15677,0)
 ;;=F12.180^^58^686^20
 ;;^UTILITY(U,$J,358.3,15677,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15677,1,3,0)
 ;;=3^Cannabis-Induced Anxiety Disorder w/ Mild Use Disorders
 ;;^UTILITY(U,$J,358.3,15677,1,4,0)
 ;;=4^F12.180
 ;;^UTILITY(U,$J,358.3,15677,2)
 ;;=^5003163
 ;;^UTILITY(U,$J,358.3,15678,0)
 ;;=F12.188^^58^686^22
 ;;^UTILITY(U,$J,358.3,15678,1,0)
 ;;=^358.31IA^4^2

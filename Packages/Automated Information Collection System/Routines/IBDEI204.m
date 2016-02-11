IBDEI204 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,33512,1,4,0)
 ;;=4^F15.14
 ;;^UTILITY(U,$J,358.3,33512,2)
 ;;=^5003287
 ;;^UTILITY(U,$J,358.3,33513,0)
 ;;=F15.182^^148^1658^3
 ;;^UTILITY(U,$J,358.3,33513,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33513,1,3,0)
 ;;=3^Amphetamine-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,33513,1,4,0)
 ;;=4^F15.182
 ;;^UTILITY(U,$J,358.3,33513,2)
 ;;=^5003293
 ;;^UTILITY(U,$J,358.3,33514,0)
 ;;=F15.20^^148^1658^5
 ;;^UTILITY(U,$J,358.3,33514,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33514,1,3,0)
 ;;=3^Amphetamine-Type Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,33514,1,4,0)
 ;;=4^F15.20
 ;;^UTILITY(U,$J,358.3,33514,2)
 ;;=^5003295
 ;;^UTILITY(U,$J,358.3,33515,0)
 ;;=F15.21^^148^1658^6
 ;;^UTILITY(U,$J,358.3,33515,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33515,1,3,0)
 ;;=3^Amphetamine-Type Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,33515,1,4,0)
 ;;=4^F15.21
 ;;^UTILITY(U,$J,358.3,33515,2)
 ;;=^5003296
 ;;^UTILITY(U,$J,358.3,33516,0)
 ;;=F15.23^^148^1658^1
 ;;^UTILITY(U,$J,358.3,33516,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33516,1,3,0)
 ;;=3^Amphetamine or Other Stimulant Withdrawal
 ;;^UTILITY(U,$J,358.3,33516,1,4,0)
 ;;=4^F15.23
 ;;^UTILITY(U,$J,358.3,33516,2)
 ;;=^5003301
 ;;^UTILITY(U,$J,358.3,33517,0)
 ;;=F12.10^^148^1659^1
 ;;^UTILITY(U,$J,358.3,33517,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33517,1,3,0)
 ;;=3^Cannabis Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,33517,1,4,0)
 ;;=4^F12.10
 ;;^UTILITY(U,$J,358.3,33517,2)
 ;;=^5003155
 ;;^UTILITY(U,$J,358.3,33518,0)
 ;;=F12.180^^148^1659^2
 ;;^UTILITY(U,$J,358.3,33518,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33518,1,3,0)
 ;;=3^Cannabis-Induced Anxiety Disorder w/ Mild Use Disorders
 ;;^UTILITY(U,$J,358.3,33518,1,4,0)
 ;;=4^F12.180
 ;;^UTILITY(U,$J,358.3,33518,2)
 ;;=^5003163
 ;;^UTILITY(U,$J,358.3,33519,0)
 ;;=F12.188^^148^1659^3
 ;;^UTILITY(U,$J,358.3,33519,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33519,1,3,0)
 ;;=3^Cannabis-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,33519,1,4,0)
 ;;=4^F12.188
 ;;^UTILITY(U,$J,358.3,33519,2)
 ;;=^5003164
 ;;^UTILITY(U,$J,358.3,33520,0)
 ;;=F12.20^^148^1659^4
 ;;^UTILITY(U,$J,358.3,33520,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33520,1,3,0)
 ;;=3^Cannabis Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,33520,1,4,0)
 ;;=4^F12.20
 ;;^UTILITY(U,$J,358.3,33520,2)
 ;;=^5003166
 ;;^UTILITY(U,$J,358.3,33521,0)
 ;;=F12.21^^148^1659^5
 ;;^UTILITY(U,$J,358.3,33521,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33521,1,3,0)
 ;;=3^Cannabis Use Disorder,Moderate-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,33521,1,4,0)
 ;;=4^F12.21
 ;;^UTILITY(U,$J,358.3,33521,2)
 ;;=^5003167
 ;;^UTILITY(U,$J,358.3,33522,0)
 ;;=F12.288^^148^1659^6
 ;;^UTILITY(U,$J,358.3,33522,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33522,1,3,0)
 ;;=3^Cannabis Withdrawal
 ;;^UTILITY(U,$J,358.3,33522,1,4,0)
 ;;=4^F12.288
 ;;^UTILITY(U,$J,358.3,33522,2)
 ;;=^5003176
 ;;^UTILITY(U,$J,358.3,33523,0)
 ;;=F12.280^^148^1659^7
 ;;^UTILITY(U,$J,358.3,33523,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33523,1,3,0)
 ;;=3^Cannabis-Induced Anxiety Disorder w/ Moderate-Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,33523,1,4,0)
 ;;=4^F12.280
 ;;^UTILITY(U,$J,358.3,33523,2)
 ;;=^5003175
 ;;^UTILITY(U,$J,358.3,33524,0)
 ;;=F16.10^^148^1660^1
 ;;^UTILITY(U,$J,358.3,33524,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33524,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,33524,1,4,0)
 ;;=4^F16.10
 ;;^UTILITY(U,$J,358.3,33524,2)
 ;;=^5003323
 ;;^UTILITY(U,$J,358.3,33525,0)
 ;;=F16.20^^148^1660^2

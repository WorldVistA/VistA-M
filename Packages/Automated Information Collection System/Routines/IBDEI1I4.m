IBDEI1I4 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25478,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25478,1,3,0)
 ;;=3^Alcohol Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,25478,1,4,0)
 ;;=4^F10.99
 ;;^UTILITY(U,$J,358.3,25478,2)
 ;;=^5133351
 ;;^UTILITY(U,$J,358.3,25479,0)
 ;;=F15.10^^95^1166^4
 ;;^UTILITY(U,$J,358.3,25479,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25479,1,3,0)
 ;;=3^Amphetamine-Type Disorder,Mild
 ;;^UTILITY(U,$J,358.3,25479,1,4,0)
 ;;=4^F15.10
 ;;^UTILITY(U,$J,358.3,25479,2)
 ;;=^5003282
 ;;^UTILITY(U,$J,358.3,25480,0)
 ;;=F15.14^^95^1166^2
 ;;^UTILITY(U,$J,358.3,25480,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25480,1,3,0)
 ;;=3^Amphetamine-Induced Depressive,Bipolar & Related Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25480,1,4,0)
 ;;=4^F15.14
 ;;^UTILITY(U,$J,358.3,25480,2)
 ;;=^5003287
 ;;^UTILITY(U,$J,358.3,25481,0)
 ;;=F15.182^^95^1166^3
 ;;^UTILITY(U,$J,358.3,25481,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25481,1,3,0)
 ;;=3^Amphetamine-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25481,1,4,0)
 ;;=4^F15.182
 ;;^UTILITY(U,$J,358.3,25481,2)
 ;;=^5003293
 ;;^UTILITY(U,$J,358.3,25482,0)
 ;;=F15.20^^95^1166^5
 ;;^UTILITY(U,$J,358.3,25482,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25482,1,3,0)
 ;;=3^Amphetamine-Type Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,25482,1,4,0)
 ;;=4^F15.20
 ;;^UTILITY(U,$J,358.3,25482,2)
 ;;=^5003295
 ;;^UTILITY(U,$J,358.3,25483,0)
 ;;=F15.21^^95^1166^6
 ;;^UTILITY(U,$J,358.3,25483,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25483,1,3,0)
 ;;=3^Amphetamine-Type Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,25483,1,4,0)
 ;;=4^F15.21
 ;;^UTILITY(U,$J,358.3,25483,2)
 ;;=^5003296
 ;;^UTILITY(U,$J,358.3,25484,0)
 ;;=F15.23^^95^1166^1
 ;;^UTILITY(U,$J,358.3,25484,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25484,1,3,0)
 ;;=3^Amphetamine or Other Stimulant Withdrawal
 ;;^UTILITY(U,$J,358.3,25484,1,4,0)
 ;;=4^F15.23
 ;;^UTILITY(U,$J,358.3,25484,2)
 ;;=^5003301
 ;;^UTILITY(U,$J,358.3,25485,0)
 ;;=F12.10^^95^1167^16
 ;;^UTILITY(U,$J,358.3,25485,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25485,1,3,0)
 ;;=3^Cannabis Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,25485,1,4,0)
 ;;=4^F12.10
 ;;^UTILITY(U,$J,358.3,25485,2)
 ;;=^5003155
 ;;^UTILITY(U,$J,358.3,25486,0)
 ;;=F12.180^^95^1167^20
 ;;^UTILITY(U,$J,358.3,25486,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25486,1,3,0)
 ;;=3^Cannabis-Induced Anxiety Disorder w/ Mild Use Disorders
 ;;^UTILITY(U,$J,358.3,25486,1,4,0)
 ;;=4^F12.180
 ;;^UTILITY(U,$J,358.3,25486,2)
 ;;=^5003163
 ;;^UTILITY(U,$J,358.3,25487,0)
 ;;=F12.188^^95^1167^22
 ;;^UTILITY(U,$J,358.3,25487,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25487,1,3,0)
 ;;=3^Cannabis-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25487,1,4,0)
 ;;=4^F12.188
 ;;^UTILITY(U,$J,358.3,25487,2)
 ;;=^5003164
 ;;^UTILITY(U,$J,358.3,25488,0)
 ;;=F12.20^^95^1167^17
 ;;^UTILITY(U,$J,358.3,25488,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25488,1,3,0)
 ;;=3^Cannabis Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,25488,1,4,0)
 ;;=4^F12.20
 ;;^UTILITY(U,$J,358.3,25488,2)
 ;;=^5003166
 ;;^UTILITY(U,$J,358.3,25489,0)
 ;;=F12.21^^95^1167^18
 ;;^UTILITY(U,$J,358.3,25489,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25489,1,3,0)
 ;;=3^Cannabis Use Disorder,Moderate-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,25489,1,4,0)
 ;;=4^F12.21
 ;;^UTILITY(U,$J,358.3,25489,2)
 ;;=^5003167
 ;;^UTILITY(U,$J,358.3,25490,0)
 ;;=F12.288^^95^1167^19
 ;;^UTILITY(U,$J,358.3,25490,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25490,1,3,0)
 ;;=3^Cannabis Withdrawal

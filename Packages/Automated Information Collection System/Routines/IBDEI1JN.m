IBDEI1JN ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,26195,1,4,0)
 ;;=4^F15.10
 ;;^UTILITY(U,$J,358.3,26195,2)
 ;;=^5003282
 ;;^UTILITY(U,$J,358.3,26196,0)
 ;;=F15.14^^98^1236^2
 ;;^UTILITY(U,$J,358.3,26196,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26196,1,3,0)
 ;;=3^Amphetamine-Induced Depressive,Bipolar & Related Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,26196,1,4,0)
 ;;=4^F15.14
 ;;^UTILITY(U,$J,358.3,26196,2)
 ;;=^5003287
 ;;^UTILITY(U,$J,358.3,26197,0)
 ;;=F15.182^^98^1236^3
 ;;^UTILITY(U,$J,358.3,26197,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26197,1,3,0)
 ;;=3^Amphetamine-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,26197,1,4,0)
 ;;=4^F15.182
 ;;^UTILITY(U,$J,358.3,26197,2)
 ;;=^5003293
 ;;^UTILITY(U,$J,358.3,26198,0)
 ;;=F15.20^^98^1236^5
 ;;^UTILITY(U,$J,358.3,26198,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26198,1,3,0)
 ;;=3^Amphetamine-Type Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,26198,1,4,0)
 ;;=4^F15.20
 ;;^UTILITY(U,$J,358.3,26198,2)
 ;;=^5003295
 ;;^UTILITY(U,$J,358.3,26199,0)
 ;;=F15.21^^98^1236^6
 ;;^UTILITY(U,$J,358.3,26199,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26199,1,3,0)
 ;;=3^Amphetamine-Type Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,26199,1,4,0)
 ;;=4^F15.21
 ;;^UTILITY(U,$J,358.3,26199,2)
 ;;=^5003296
 ;;^UTILITY(U,$J,358.3,26200,0)
 ;;=F15.23^^98^1236^1
 ;;^UTILITY(U,$J,358.3,26200,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26200,1,3,0)
 ;;=3^Amphetamine or Other Stimulant Withdrawal
 ;;^UTILITY(U,$J,358.3,26200,1,4,0)
 ;;=4^F15.23
 ;;^UTILITY(U,$J,358.3,26200,2)
 ;;=^5003301
 ;;^UTILITY(U,$J,358.3,26201,0)
 ;;=F12.10^^98^1237^16
 ;;^UTILITY(U,$J,358.3,26201,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26201,1,3,0)
 ;;=3^Cannabis Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,26201,1,4,0)
 ;;=4^F12.10
 ;;^UTILITY(U,$J,358.3,26201,2)
 ;;=^5003155
 ;;^UTILITY(U,$J,358.3,26202,0)
 ;;=F12.180^^98^1237^20
 ;;^UTILITY(U,$J,358.3,26202,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26202,1,3,0)
 ;;=3^Cannabis-Induced Anxiety Disorder w/ Mild Use Disorders
 ;;^UTILITY(U,$J,358.3,26202,1,4,0)
 ;;=4^F12.180
 ;;^UTILITY(U,$J,358.3,26202,2)
 ;;=^5003163
 ;;^UTILITY(U,$J,358.3,26203,0)
 ;;=F12.188^^98^1237^22
 ;;^UTILITY(U,$J,358.3,26203,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26203,1,3,0)
 ;;=3^Cannabis-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,26203,1,4,0)
 ;;=4^F12.188
 ;;^UTILITY(U,$J,358.3,26203,2)
 ;;=^5003164
 ;;^UTILITY(U,$J,358.3,26204,0)
 ;;=F12.20^^98^1237^17
 ;;^UTILITY(U,$J,358.3,26204,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26204,1,3,0)
 ;;=3^Cannabis Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,26204,1,4,0)
 ;;=4^F12.20
 ;;^UTILITY(U,$J,358.3,26204,2)
 ;;=^5003166
 ;;^UTILITY(U,$J,358.3,26205,0)
 ;;=F12.21^^98^1237^18
 ;;^UTILITY(U,$J,358.3,26205,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26205,1,3,0)
 ;;=3^Cannabis Use Disorder,Moderate-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,26205,1,4,0)
 ;;=4^F12.21
 ;;^UTILITY(U,$J,358.3,26205,2)
 ;;=^5003167
 ;;^UTILITY(U,$J,358.3,26206,0)
 ;;=F12.288^^98^1237^19
 ;;^UTILITY(U,$J,358.3,26206,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26206,1,3,0)
 ;;=3^Cannabis Withdrawal
 ;;^UTILITY(U,$J,358.3,26206,1,4,0)
 ;;=4^F12.288
 ;;^UTILITY(U,$J,358.3,26206,2)
 ;;=^5003176
 ;;^UTILITY(U,$J,358.3,26207,0)
 ;;=F12.280^^98^1237^21
 ;;^UTILITY(U,$J,358.3,26207,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26207,1,3,0)
 ;;=3^Cannabis-Induced Anxiety Disorder w/ Moderate-Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,26207,1,4,0)
 ;;=4^F12.280
 ;;^UTILITY(U,$J,358.3,26207,2)
 ;;=^5003175

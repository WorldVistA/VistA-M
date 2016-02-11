IBDEI34S ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,52549,1,4,0)
 ;;=4^F15.14
 ;;^UTILITY(U,$J,358.3,52549,2)
 ;;=^5003287
 ;;^UTILITY(U,$J,358.3,52550,0)
 ;;=F15.182^^237^2615^3
 ;;^UTILITY(U,$J,358.3,52550,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52550,1,3,0)
 ;;=3^Amphetamine-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,52550,1,4,0)
 ;;=4^F15.182
 ;;^UTILITY(U,$J,358.3,52550,2)
 ;;=^5003293
 ;;^UTILITY(U,$J,358.3,52551,0)
 ;;=F15.20^^237^2615^5
 ;;^UTILITY(U,$J,358.3,52551,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52551,1,3,0)
 ;;=3^Amphetamine-Type Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,52551,1,4,0)
 ;;=4^F15.20
 ;;^UTILITY(U,$J,358.3,52551,2)
 ;;=^5003295
 ;;^UTILITY(U,$J,358.3,52552,0)
 ;;=F15.21^^237^2615^6
 ;;^UTILITY(U,$J,358.3,52552,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52552,1,3,0)
 ;;=3^Amphetamine-Type Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,52552,1,4,0)
 ;;=4^F15.21
 ;;^UTILITY(U,$J,358.3,52552,2)
 ;;=^5003296
 ;;^UTILITY(U,$J,358.3,52553,0)
 ;;=F15.23^^237^2615^1
 ;;^UTILITY(U,$J,358.3,52553,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52553,1,3,0)
 ;;=3^Amphetamine or Other Stimulant Withdrawal
 ;;^UTILITY(U,$J,358.3,52553,1,4,0)
 ;;=4^F15.23
 ;;^UTILITY(U,$J,358.3,52553,2)
 ;;=^5003301
 ;;^UTILITY(U,$J,358.3,52554,0)
 ;;=F12.10^^237^2616^1
 ;;^UTILITY(U,$J,358.3,52554,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52554,1,3,0)
 ;;=3^Cannabis Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,52554,1,4,0)
 ;;=4^F12.10
 ;;^UTILITY(U,$J,358.3,52554,2)
 ;;=^5003155
 ;;^UTILITY(U,$J,358.3,52555,0)
 ;;=F12.180^^237^2616^2
 ;;^UTILITY(U,$J,358.3,52555,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52555,1,3,0)
 ;;=3^Cannabis-Induced Anxiety Disorder w/ Mild Use Disorders
 ;;^UTILITY(U,$J,358.3,52555,1,4,0)
 ;;=4^F12.180
 ;;^UTILITY(U,$J,358.3,52555,2)
 ;;=^5003163
 ;;^UTILITY(U,$J,358.3,52556,0)
 ;;=F12.188^^237^2616^3
 ;;^UTILITY(U,$J,358.3,52556,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52556,1,3,0)
 ;;=3^Cannabis-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,52556,1,4,0)
 ;;=4^F12.188
 ;;^UTILITY(U,$J,358.3,52556,2)
 ;;=^5003164
 ;;^UTILITY(U,$J,358.3,52557,0)
 ;;=F12.20^^237^2616^4
 ;;^UTILITY(U,$J,358.3,52557,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52557,1,3,0)
 ;;=3^Cannabis Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,52557,1,4,0)
 ;;=4^F12.20
 ;;^UTILITY(U,$J,358.3,52557,2)
 ;;=^5003166
 ;;^UTILITY(U,$J,358.3,52558,0)
 ;;=F12.21^^237^2616^5
 ;;^UTILITY(U,$J,358.3,52558,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52558,1,3,0)
 ;;=3^Cannabis Use Disorder,Moderate-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,52558,1,4,0)
 ;;=4^F12.21
 ;;^UTILITY(U,$J,358.3,52558,2)
 ;;=^5003167
 ;;^UTILITY(U,$J,358.3,52559,0)
 ;;=F12.288^^237^2616^6
 ;;^UTILITY(U,$J,358.3,52559,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52559,1,3,0)
 ;;=3^Cannabis Withdrawal
 ;;^UTILITY(U,$J,358.3,52559,1,4,0)
 ;;=4^F12.288
 ;;^UTILITY(U,$J,358.3,52559,2)
 ;;=^5003176
 ;;^UTILITY(U,$J,358.3,52560,0)
 ;;=F12.280^^237^2616^7
 ;;^UTILITY(U,$J,358.3,52560,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52560,1,3,0)
 ;;=3^Cannabis-Induced Anxiety Disorder w/ Moderate-Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,52560,1,4,0)
 ;;=4^F12.280
 ;;^UTILITY(U,$J,358.3,52560,2)
 ;;=^5003175
 ;;^UTILITY(U,$J,358.3,52561,0)
 ;;=F16.10^^237^2617^1
 ;;^UTILITY(U,$J,358.3,52561,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52561,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,52561,1,4,0)
 ;;=4^F16.10
 ;;^UTILITY(U,$J,358.3,52561,2)
 ;;=^5003323
 ;;^UTILITY(U,$J,358.3,52562,0)
 ;;=F16.20^^237^2617^2

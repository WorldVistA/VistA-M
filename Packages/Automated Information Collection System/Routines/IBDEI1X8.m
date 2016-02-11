IBDEI1X8 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,32169,1,4,0)
 ;;=4^F15.14
 ;;^UTILITY(U,$J,358.3,32169,2)
 ;;=^5003287
 ;;^UTILITY(U,$J,358.3,32170,0)
 ;;=F15.182^^141^1501^3
 ;;^UTILITY(U,$J,358.3,32170,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32170,1,3,0)
 ;;=3^Amphetamine-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,32170,1,4,0)
 ;;=4^F15.182
 ;;^UTILITY(U,$J,358.3,32170,2)
 ;;=^5003293
 ;;^UTILITY(U,$J,358.3,32171,0)
 ;;=F15.20^^141^1501^5
 ;;^UTILITY(U,$J,358.3,32171,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32171,1,3,0)
 ;;=3^Amphetamine-Type Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,32171,1,4,0)
 ;;=4^F15.20
 ;;^UTILITY(U,$J,358.3,32171,2)
 ;;=^5003295
 ;;^UTILITY(U,$J,358.3,32172,0)
 ;;=F15.21^^141^1501^6
 ;;^UTILITY(U,$J,358.3,32172,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32172,1,3,0)
 ;;=3^Amphetamine-Type Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,32172,1,4,0)
 ;;=4^F15.21
 ;;^UTILITY(U,$J,358.3,32172,2)
 ;;=^5003296
 ;;^UTILITY(U,$J,358.3,32173,0)
 ;;=F15.23^^141^1501^1
 ;;^UTILITY(U,$J,358.3,32173,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32173,1,3,0)
 ;;=3^Amphetamine or Other Stimulant Withdrawal
 ;;^UTILITY(U,$J,358.3,32173,1,4,0)
 ;;=4^F15.23
 ;;^UTILITY(U,$J,358.3,32173,2)
 ;;=^5003301
 ;;^UTILITY(U,$J,358.3,32174,0)
 ;;=F12.10^^141^1502^1
 ;;^UTILITY(U,$J,358.3,32174,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32174,1,3,0)
 ;;=3^Cannabis Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,32174,1,4,0)
 ;;=4^F12.10
 ;;^UTILITY(U,$J,358.3,32174,2)
 ;;=^5003155
 ;;^UTILITY(U,$J,358.3,32175,0)
 ;;=F12.180^^141^1502^2
 ;;^UTILITY(U,$J,358.3,32175,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32175,1,3,0)
 ;;=3^Cannabis-Induced Anxiety Disorder w/ Mild Use Disorders
 ;;^UTILITY(U,$J,358.3,32175,1,4,0)
 ;;=4^F12.180
 ;;^UTILITY(U,$J,358.3,32175,2)
 ;;=^5003163
 ;;^UTILITY(U,$J,358.3,32176,0)
 ;;=F12.188^^141^1502^3
 ;;^UTILITY(U,$J,358.3,32176,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32176,1,3,0)
 ;;=3^Cannabis-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,32176,1,4,0)
 ;;=4^F12.188
 ;;^UTILITY(U,$J,358.3,32176,2)
 ;;=^5003164
 ;;^UTILITY(U,$J,358.3,32177,0)
 ;;=F12.20^^141^1502^4
 ;;^UTILITY(U,$J,358.3,32177,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32177,1,3,0)
 ;;=3^Cannabis Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,32177,1,4,0)
 ;;=4^F12.20
 ;;^UTILITY(U,$J,358.3,32177,2)
 ;;=^5003166
 ;;^UTILITY(U,$J,358.3,32178,0)
 ;;=F12.21^^141^1502^5
 ;;^UTILITY(U,$J,358.3,32178,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32178,1,3,0)
 ;;=3^Cannabis Use Disorder,Moderate-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,32178,1,4,0)
 ;;=4^F12.21
 ;;^UTILITY(U,$J,358.3,32178,2)
 ;;=^5003167
 ;;^UTILITY(U,$J,358.3,32179,0)
 ;;=F12.288^^141^1502^6
 ;;^UTILITY(U,$J,358.3,32179,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32179,1,3,0)
 ;;=3^Cannabis Withdrawal
 ;;^UTILITY(U,$J,358.3,32179,1,4,0)
 ;;=4^F12.288
 ;;^UTILITY(U,$J,358.3,32179,2)
 ;;=^5003176
 ;;^UTILITY(U,$J,358.3,32180,0)
 ;;=F12.280^^141^1502^7
 ;;^UTILITY(U,$J,358.3,32180,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32180,1,3,0)
 ;;=3^Cannabis-Induced Anxiety Disorder w/ Moderate-Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,32180,1,4,0)
 ;;=4^F12.280
 ;;^UTILITY(U,$J,358.3,32180,2)
 ;;=^5003175
 ;;^UTILITY(U,$J,358.3,32181,0)
 ;;=F16.10^^141^1503^1
 ;;^UTILITY(U,$J,358.3,32181,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32181,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,32181,1,4,0)
 ;;=4^F16.10
 ;;^UTILITY(U,$J,358.3,32181,2)
 ;;=^5003323
 ;;^UTILITY(U,$J,358.3,32182,0)
 ;;=F16.20^^141^1503^2

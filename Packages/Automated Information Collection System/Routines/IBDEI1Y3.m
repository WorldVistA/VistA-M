IBDEI1Y3 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,32563,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32563,1,3,0)
 ;;=3^Amphetamine-Induced Depressive,Bipolar & Related Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,32563,1,4,0)
 ;;=4^F15.14
 ;;^UTILITY(U,$J,358.3,32563,2)
 ;;=^5003287
 ;;^UTILITY(U,$J,358.3,32564,0)
 ;;=F15.182^^143^1544^3
 ;;^UTILITY(U,$J,358.3,32564,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32564,1,3,0)
 ;;=3^Amphetamine-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,32564,1,4,0)
 ;;=4^F15.182
 ;;^UTILITY(U,$J,358.3,32564,2)
 ;;=^5003293
 ;;^UTILITY(U,$J,358.3,32565,0)
 ;;=F15.20^^143^1544^5
 ;;^UTILITY(U,$J,358.3,32565,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32565,1,3,0)
 ;;=3^Amphetamine-Type Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,32565,1,4,0)
 ;;=4^F15.20
 ;;^UTILITY(U,$J,358.3,32565,2)
 ;;=^5003295
 ;;^UTILITY(U,$J,358.3,32566,0)
 ;;=F15.21^^143^1544^6
 ;;^UTILITY(U,$J,358.3,32566,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32566,1,3,0)
 ;;=3^Amphetamine-Type Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,32566,1,4,0)
 ;;=4^F15.21
 ;;^UTILITY(U,$J,358.3,32566,2)
 ;;=^5003296
 ;;^UTILITY(U,$J,358.3,32567,0)
 ;;=F15.23^^143^1544^1
 ;;^UTILITY(U,$J,358.3,32567,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32567,1,3,0)
 ;;=3^Amphetamine or Other Stimulant Withdrawal
 ;;^UTILITY(U,$J,358.3,32567,1,4,0)
 ;;=4^F15.23
 ;;^UTILITY(U,$J,358.3,32567,2)
 ;;=^5003301
 ;;^UTILITY(U,$J,358.3,32568,0)
 ;;=F12.10^^143^1545^1
 ;;^UTILITY(U,$J,358.3,32568,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32568,1,3,0)
 ;;=3^Cannabis Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,32568,1,4,0)
 ;;=4^F12.10
 ;;^UTILITY(U,$J,358.3,32568,2)
 ;;=^5003155
 ;;^UTILITY(U,$J,358.3,32569,0)
 ;;=F12.180^^143^1545^2
 ;;^UTILITY(U,$J,358.3,32569,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32569,1,3,0)
 ;;=3^Cannabis-Induced Anxiety Disorder w/ Mild Use Disorders
 ;;^UTILITY(U,$J,358.3,32569,1,4,0)
 ;;=4^F12.180
 ;;^UTILITY(U,$J,358.3,32569,2)
 ;;=^5003163
 ;;^UTILITY(U,$J,358.3,32570,0)
 ;;=F12.188^^143^1545^3
 ;;^UTILITY(U,$J,358.3,32570,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32570,1,3,0)
 ;;=3^Cannabis-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,32570,1,4,0)
 ;;=4^F12.188
 ;;^UTILITY(U,$J,358.3,32570,2)
 ;;=^5003164
 ;;^UTILITY(U,$J,358.3,32571,0)
 ;;=F12.20^^143^1545^4
 ;;^UTILITY(U,$J,358.3,32571,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32571,1,3,0)
 ;;=3^Cannabis Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,32571,1,4,0)
 ;;=4^F12.20
 ;;^UTILITY(U,$J,358.3,32571,2)
 ;;=^5003166
 ;;^UTILITY(U,$J,358.3,32572,0)
 ;;=F12.21^^143^1545^5
 ;;^UTILITY(U,$J,358.3,32572,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32572,1,3,0)
 ;;=3^Cannabis Use Disorder,Moderate-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,32572,1,4,0)
 ;;=4^F12.21
 ;;^UTILITY(U,$J,358.3,32572,2)
 ;;=^5003167
 ;;^UTILITY(U,$J,358.3,32573,0)
 ;;=F12.288^^143^1545^6
 ;;^UTILITY(U,$J,358.3,32573,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32573,1,3,0)
 ;;=3^Cannabis Withdrawal
 ;;^UTILITY(U,$J,358.3,32573,1,4,0)
 ;;=4^F12.288
 ;;^UTILITY(U,$J,358.3,32573,2)
 ;;=^5003176
 ;;^UTILITY(U,$J,358.3,32574,0)
 ;;=F12.280^^143^1545^7
 ;;^UTILITY(U,$J,358.3,32574,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32574,1,3,0)
 ;;=3^Cannabis-Induced Anxiety Disorder w/ Moderate-Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,32574,1,4,0)
 ;;=4^F12.280
 ;;^UTILITY(U,$J,358.3,32574,2)
 ;;=^5003175
 ;;^UTILITY(U,$J,358.3,32575,0)
 ;;=F16.10^^143^1546^1
 ;;^UTILITY(U,$J,358.3,32575,1,0)
 ;;=^358.31IA^4^2

IBDEI1Y2 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,32551,0)
 ;;=F10.10^^143^1543^1
 ;;^UTILITY(U,$J,358.3,32551,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32551,1,3,0)
 ;;=3^Alcohol Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,32551,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,32551,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,32552,0)
 ;;=F10.14^^143^1543^8
 ;;^UTILITY(U,$J,358.3,32552,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32552,1,3,0)
 ;;=3^Alcohol-Induced Bipolar & Related Disorder/Depressive Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,32552,1,4,0)
 ;;=4^F10.14
 ;;^UTILITY(U,$J,358.3,32552,2)
 ;;=^5003072
 ;;^UTILITY(U,$J,358.3,32553,0)
 ;;=F10.182^^143^1543^10
 ;;^UTILITY(U,$J,358.3,32553,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32553,1,3,0)
 ;;=3^Alcohol-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,32553,1,4,0)
 ;;=4^F10.182
 ;;^UTILITY(U,$J,358.3,32553,2)
 ;;=^5003078
 ;;^UTILITY(U,$J,358.3,32554,0)
 ;;=F10.20^^143^1543^2
 ;;^UTILITY(U,$J,358.3,32554,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32554,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,32554,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,32554,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,32555,0)
 ;;=F10.21^^143^1543^3
 ;;^UTILITY(U,$J,358.3,32555,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32555,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,32555,1,4,0)
 ;;=4^F10.21
 ;;^UTILITY(U,$J,358.3,32555,2)
 ;;=^5003082
 ;;^UTILITY(U,$J,358.3,32556,0)
 ;;=F10.230^^143^1543^4
 ;;^UTILITY(U,$J,358.3,32556,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32556,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,32556,1,4,0)
 ;;=4^F10.230
 ;;^UTILITY(U,$J,358.3,32556,2)
 ;;=^5003086
 ;;^UTILITY(U,$J,358.3,32557,0)
 ;;=F10.231^^143^1543^5
 ;;^UTILITY(U,$J,358.3,32557,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32557,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe w/ Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,32557,1,4,0)
 ;;=4^F10.231
 ;;^UTILITY(U,$J,358.3,32557,2)
 ;;=^5003087
 ;;^UTILITY(U,$J,358.3,32558,0)
 ;;=F10.232^^143^1543^6
 ;;^UTILITY(U,$J,358.3,32558,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32558,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe w/ Withdrawal Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,32558,1,4,0)
 ;;=4^F10.232
 ;;^UTILITY(U,$J,358.3,32558,2)
 ;;=^5003088
 ;;^UTILITY(U,$J,358.3,32559,0)
 ;;=F10.239^^143^1543^7
 ;;^UTILITY(U,$J,358.3,32559,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32559,1,3,0)
 ;;=3^Alcohol Withdrawal w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,32559,1,4,0)
 ;;=4^F10.239
 ;;^UTILITY(U,$J,358.3,32559,2)
 ;;=^5003089
 ;;^UTILITY(U,$J,358.3,32560,0)
 ;;=F10.24^^143^1543^9
 ;;^UTILITY(U,$J,358.3,32560,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32560,1,3,0)
 ;;=3^Alcohol-Induced Depressive & Related Disorder w/ Moderate-Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,32560,1,4,0)
 ;;=4^F10.24
 ;;^UTILITY(U,$J,358.3,32560,2)
 ;;=^5003090
 ;;^UTILITY(U,$J,358.3,32561,0)
 ;;=F10.29^^143^1543^11
 ;;^UTILITY(U,$J,358.3,32561,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32561,1,3,0)
 ;;=3^Alcohol-Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,32561,1,4,0)
 ;;=4^F10.29
 ;;^UTILITY(U,$J,358.3,32561,2)
 ;;=^5003100
 ;;^UTILITY(U,$J,358.3,32562,0)
 ;;=F15.10^^143^1544^4
 ;;^UTILITY(U,$J,358.3,32562,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32562,1,3,0)
 ;;=3^Amphetamine-Type Disorder,Mild
 ;;^UTILITY(U,$J,358.3,32562,1,4,0)
 ;;=4^F15.10
 ;;^UTILITY(U,$J,358.3,32562,2)
 ;;=^5003282
 ;;^UTILITY(U,$J,358.3,32563,0)
 ;;=F15.14^^143^1544^2

IBDEI1X7 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,32157,1,3,0)
 ;;=3^Alcohol Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,32157,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,32157,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,32158,0)
 ;;=F10.14^^141^1500^8
 ;;^UTILITY(U,$J,358.3,32158,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32158,1,3,0)
 ;;=3^Alcohol-Induced Bipolar & Related Disorder/Depressive Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,32158,1,4,0)
 ;;=4^F10.14
 ;;^UTILITY(U,$J,358.3,32158,2)
 ;;=^5003072
 ;;^UTILITY(U,$J,358.3,32159,0)
 ;;=F10.182^^141^1500^10
 ;;^UTILITY(U,$J,358.3,32159,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32159,1,3,0)
 ;;=3^Alcohol-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,32159,1,4,0)
 ;;=4^F10.182
 ;;^UTILITY(U,$J,358.3,32159,2)
 ;;=^5003078
 ;;^UTILITY(U,$J,358.3,32160,0)
 ;;=F10.20^^141^1500^2
 ;;^UTILITY(U,$J,358.3,32160,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32160,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,32160,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,32160,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,32161,0)
 ;;=F10.21^^141^1500^3
 ;;^UTILITY(U,$J,358.3,32161,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32161,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,32161,1,4,0)
 ;;=4^F10.21
 ;;^UTILITY(U,$J,358.3,32161,2)
 ;;=^5003082
 ;;^UTILITY(U,$J,358.3,32162,0)
 ;;=F10.230^^141^1500^4
 ;;^UTILITY(U,$J,358.3,32162,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32162,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,32162,1,4,0)
 ;;=4^F10.230
 ;;^UTILITY(U,$J,358.3,32162,2)
 ;;=^5003086
 ;;^UTILITY(U,$J,358.3,32163,0)
 ;;=F10.231^^141^1500^5
 ;;^UTILITY(U,$J,358.3,32163,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32163,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe w/ Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,32163,1,4,0)
 ;;=4^F10.231
 ;;^UTILITY(U,$J,358.3,32163,2)
 ;;=^5003087
 ;;^UTILITY(U,$J,358.3,32164,0)
 ;;=F10.232^^141^1500^6
 ;;^UTILITY(U,$J,358.3,32164,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32164,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe w/ Withdrawal Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,32164,1,4,0)
 ;;=4^F10.232
 ;;^UTILITY(U,$J,358.3,32164,2)
 ;;=^5003088
 ;;^UTILITY(U,$J,358.3,32165,0)
 ;;=F10.239^^141^1500^7
 ;;^UTILITY(U,$J,358.3,32165,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32165,1,3,0)
 ;;=3^Alcohol Withdrawal w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,32165,1,4,0)
 ;;=4^F10.239
 ;;^UTILITY(U,$J,358.3,32165,2)
 ;;=^5003089
 ;;^UTILITY(U,$J,358.3,32166,0)
 ;;=F10.24^^141^1500^9
 ;;^UTILITY(U,$J,358.3,32166,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32166,1,3,0)
 ;;=3^Alcohol-Induced Depressive & Related Disorder w/ Moderate-Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,32166,1,4,0)
 ;;=4^F10.24
 ;;^UTILITY(U,$J,358.3,32166,2)
 ;;=^5003090
 ;;^UTILITY(U,$J,358.3,32167,0)
 ;;=F10.29^^141^1500^11
 ;;^UTILITY(U,$J,358.3,32167,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32167,1,3,0)
 ;;=3^Alcohol-Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,32167,1,4,0)
 ;;=4^F10.29
 ;;^UTILITY(U,$J,358.3,32167,2)
 ;;=^5003100
 ;;^UTILITY(U,$J,358.3,32168,0)
 ;;=F15.10^^141^1501^4
 ;;^UTILITY(U,$J,358.3,32168,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32168,1,3,0)
 ;;=3^Amphetamine-Type Disorder,Mild
 ;;^UTILITY(U,$J,358.3,32168,1,4,0)
 ;;=4^F15.10
 ;;^UTILITY(U,$J,358.3,32168,2)
 ;;=^5003282
 ;;^UTILITY(U,$J,358.3,32169,0)
 ;;=F15.14^^141^1501^2
 ;;^UTILITY(U,$J,358.3,32169,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32169,1,3,0)
 ;;=3^Amphetamine-Induced Depressive,Bipolar & Related Disorder w/ Mild Use Disorder

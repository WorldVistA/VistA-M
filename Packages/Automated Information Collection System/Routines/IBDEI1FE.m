IBDEI1FE ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24237,1,3,0)
 ;;=3^Alcohol-Induced Bipolar & Related Disorder/Depressive Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,24237,1,4,0)
 ;;=4^F10.14
 ;;^UTILITY(U,$J,358.3,24237,2)
 ;;=^5003072
 ;;^UTILITY(U,$J,358.3,24238,0)
 ;;=F10.182^^90^1061^36
 ;;^UTILITY(U,$J,358.3,24238,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24238,1,3,0)
 ;;=3^Alcohol-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,24238,1,4,0)
 ;;=4^F10.182
 ;;^UTILITY(U,$J,358.3,24238,2)
 ;;=^5003078
 ;;^UTILITY(U,$J,358.3,24239,0)
 ;;=F10.20^^90^1061^28
 ;;^UTILITY(U,$J,358.3,24239,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24239,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,24239,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,24239,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,24240,0)
 ;;=F10.21^^90^1061^29
 ;;^UTILITY(U,$J,358.3,24240,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24240,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,24240,1,4,0)
 ;;=4^F10.21
 ;;^UTILITY(U,$J,358.3,24240,2)
 ;;=^5003082
 ;;^UTILITY(U,$J,358.3,24241,0)
 ;;=F10.230^^90^1061^30
 ;;^UTILITY(U,$J,358.3,24241,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24241,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,24241,1,4,0)
 ;;=4^F10.230
 ;;^UTILITY(U,$J,358.3,24241,2)
 ;;=^5003086
 ;;^UTILITY(U,$J,358.3,24242,0)
 ;;=F10.231^^90^1061^31
 ;;^UTILITY(U,$J,358.3,24242,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24242,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe w/ Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,24242,1,4,0)
 ;;=4^F10.231
 ;;^UTILITY(U,$J,358.3,24242,2)
 ;;=^5003087
 ;;^UTILITY(U,$J,358.3,24243,0)
 ;;=F10.232^^90^1061^32
 ;;^UTILITY(U,$J,358.3,24243,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24243,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe w/ Withdrawal Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,24243,1,4,0)
 ;;=4^F10.232
 ;;^UTILITY(U,$J,358.3,24243,2)
 ;;=^5003088
 ;;^UTILITY(U,$J,358.3,24244,0)
 ;;=F10.239^^90^1061^33
 ;;^UTILITY(U,$J,358.3,24244,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24244,1,3,0)
 ;;=3^Alcohol Withdrawal w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,24244,1,4,0)
 ;;=4^F10.239
 ;;^UTILITY(U,$J,358.3,24244,2)
 ;;=^5003089
 ;;^UTILITY(U,$J,358.3,24245,0)
 ;;=F10.24^^90^1061^35
 ;;^UTILITY(U,$J,358.3,24245,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24245,1,3,0)
 ;;=3^Alcohol-Induced Depressive & Related Disorder w/ Moderate-Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,24245,1,4,0)
 ;;=4^F10.24
 ;;^UTILITY(U,$J,358.3,24245,2)
 ;;=^5003090
 ;;^UTILITY(U,$J,358.3,24246,0)
 ;;=F10.29^^90^1061^37
 ;;^UTILITY(U,$J,358.3,24246,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24246,1,3,0)
 ;;=3^Alcohol-Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,24246,1,4,0)
 ;;=4^F10.29
 ;;^UTILITY(U,$J,358.3,24246,2)
 ;;=^5003100
 ;;^UTILITY(U,$J,358.3,24247,0)
 ;;=F10.180^^90^1061^1
 ;;^UTILITY(U,$J,358.3,24247,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24247,1,3,0)
 ;;=3^Alcohol Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,24247,1,4,0)
 ;;=4^F10.180
 ;;^UTILITY(U,$J,358.3,24247,2)
 ;;=^5003076
 ;;^UTILITY(U,$J,358.3,24248,0)
 ;;=F10.280^^90^1061^2
 ;;^UTILITY(U,$J,358.3,24248,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24248,1,3,0)
 ;;=3^Alcohol Induced Anxiety Disorder w/ Moderate/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,24248,1,4,0)
 ;;=4^F10.280
 ;;^UTILITY(U,$J,358.3,24248,2)
 ;;=^5003096
 ;;^UTILITY(U,$J,358.3,24249,0)
 ;;=F10.980^^90^1061^3

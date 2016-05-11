IBDEI298 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,38245,1,3,0)
 ;;=3^Sleep-Wake Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,38245,1,4,0)
 ;;=4^G47.9
 ;;^UTILITY(U,$J,358.3,38245,2)
 ;;=^5003990
 ;;^UTILITY(U,$J,358.3,38246,0)
 ;;=F10.10^^145^1854^27
 ;;^UTILITY(U,$J,358.3,38246,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38246,1,3,0)
 ;;=3^Alcohol Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,38246,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,38246,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,38247,0)
 ;;=F10.14^^145^1854^34
 ;;^UTILITY(U,$J,358.3,38247,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38247,1,3,0)
 ;;=3^Alcohol-Induced Bipolar & Related Disorder/Depressive Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,38247,1,4,0)
 ;;=4^F10.14
 ;;^UTILITY(U,$J,358.3,38247,2)
 ;;=^5003072
 ;;^UTILITY(U,$J,358.3,38248,0)
 ;;=F10.182^^145^1854^36
 ;;^UTILITY(U,$J,358.3,38248,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38248,1,3,0)
 ;;=3^Alcohol-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,38248,1,4,0)
 ;;=4^F10.182
 ;;^UTILITY(U,$J,358.3,38248,2)
 ;;=^5003078
 ;;^UTILITY(U,$J,358.3,38249,0)
 ;;=F10.20^^145^1854^28
 ;;^UTILITY(U,$J,358.3,38249,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38249,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,38249,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,38249,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,38250,0)
 ;;=F10.21^^145^1854^29
 ;;^UTILITY(U,$J,358.3,38250,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38250,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,38250,1,4,0)
 ;;=4^F10.21
 ;;^UTILITY(U,$J,358.3,38250,2)
 ;;=^5003082
 ;;^UTILITY(U,$J,358.3,38251,0)
 ;;=F10.230^^145^1854^30
 ;;^UTILITY(U,$J,358.3,38251,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38251,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,38251,1,4,0)
 ;;=4^F10.230
 ;;^UTILITY(U,$J,358.3,38251,2)
 ;;=^5003086
 ;;^UTILITY(U,$J,358.3,38252,0)
 ;;=F10.231^^145^1854^31
 ;;^UTILITY(U,$J,358.3,38252,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38252,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe w/ Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,38252,1,4,0)
 ;;=4^F10.231
 ;;^UTILITY(U,$J,358.3,38252,2)
 ;;=^5003087
 ;;^UTILITY(U,$J,358.3,38253,0)
 ;;=F10.232^^145^1854^32
 ;;^UTILITY(U,$J,358.3,38253,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38253,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe w/ Withdrawal Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,38253,1,4,0)
 ;;=4^F10.232
 ;;^UTILITY(U,$J,358.3,38253,2)
 ;;=^5003088
 ;;^UTILITY(U,$J,358.3,38254,0)
 ;;=F10.239^^145^1854^33
 ;;^UTILITY(U,$J,358.3,38254,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38254,1,3,0)
 ;;=3^Alcohol Withdrawal w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,38254,1,4,0)
 ;;=4^F10.239
 ;;^UTILITY(U,$J,358.3,38254,2)
 ;;=^5003089
 ;;^UTILITY(U,$J,358.3,38255,0)
 ;;=F10.24^^145^1854^35
 ;;^UTILITY(U,$J,358.3,38255,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38255,1,3,0)
 ;;=3^Alcohol-Induced Depressive & Related Disorder w/ Moderate-Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,38255,1,4,0)
 ;;=4^F10.24
 ;;^UTILITY(U,$J,358.3,38255,2)
 ;;=^5003090
 ;;^UTILITY(U,$J,358.3,38256,0)
 ;;=F10.29^^145^1854^37
 ;;^UTILITY(U,$J,358.3,38256,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38256,1,3,0)
 ;;=3^Alcohol-Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,38256,1,4,0)
 ;;=4^F10.29
 ;;^UTILITY(U,$J,358.3,38256,2)
 ;;=^5003100
 ;;^UTILITY(U,$J,358.3,38257,0)
 ;;=F10.180^^145^1854^1
 ;;^UTILITY(U,$J,358.3,38257,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38257,1,3,0)
 ;;=3^Alcohol Induced Anxiety Disorder w/ Mild Use Disorder

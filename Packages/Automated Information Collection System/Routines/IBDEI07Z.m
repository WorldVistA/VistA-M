IBDEI07Z ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3236,1,4,0)
 ;;=4^F51.5
 ;;^UTILITY(U,$J,358.3,3236,2)
 ;;=^5003615
 ;;^UTILITY(U,$J,358.3,3237,0)
 ;;=G47.52^^8^111^17
 ;;^UTILITY(U,$J,358.3,3237,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3237,1,3,0)
 ;;=3^Rapid Eye Movement Sleep Behavior Disorder
 ;;^UTILITY(U,$J,358.3,3237,1,4,0)
 ;;=4^G47.52
 ;;^UTILITY(U,$J,358.3,3237,2)
 ;;=^332778
 ;;^UTILITY(U,$J,358.3,3238,0)
 ;;=G25.81^^8^111^18
 ;;^UTILITY(U,$J,358.3,3238,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3238,1,3,0)
 ;;=3^Restless Legs Syndrome
 ;;^UTILITY(U,$J,358.3,3238,1,4,0)
 ;;=4^G25.81
 ;;^UTILITY(U,$J,358.3,3238,2)
 ;;=^5003801
 ;;^UTILITY(U,$J,358.3,3239,0)
 ;;=G47.19^^8^111^8
 ;;^UTILITY(U,$J,358.3,3239,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3239,1,3,0)
 ;;=3^Hypersomnolence Disorder NEC
 ;;^UTILITY(U,$J,358.3,3239,1,4,0)
 ;;=4^G47.19
 ;;^UTILITY(U,$J,358.3,3239,2)
 ;;=^5003973
 ;;^UTILITY(U,$J,358.3,3240,0)
 ;;=G47.8^^8^111^19
 ;;^UTILITY(U,$J,358.3,3240,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3240,1,3,0)
 ;;=3^Sleep-Wake Disorder NEC
 ;;^UTILITY(U,$J,358.3,3240,1,4,0)
 ;;=4^G47.8
 ;;^UTILITY(U,$J,358.3,3240,2)
 ;;=^5003989
 ;;^UTILITY(U,$J,358.3,3241,0)
 ;;=F10.10^^8^112^1
 ;;^UTILITY(U,$J,358.3,3241,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3241,1,3,0)
 ;;=3^Alcohol Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,3241,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,3241,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,3242,0)
 ;;=F10.14^^8^112^8
 ;;^UTILITY(U,$J,358.3,3242,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3242,1,3,0)
 ;;=3^Alcohol-Induced Bipolar & Related Disorder/Depressive Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,3242,1,4,0)
 ;;=4^F10.14
 ;;^UTILITY(U,$J,358.3,3242,2)
 ;;=^5003072
 ;;^UTILITY(U,$J,358.3,3243,0)
 ;;=F10.182^^8^112^10
 ;;^UTILITY(U,$J,358.3,3243,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3243,1,3,0)
 ;;=3^Alcohol-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,3243,1,4,0)
 ;;=4^F10.182
 ;;^UTILITY(U,$J,358.3,3243,2)
 ;;=^5003078
 ;;^UTILITY(U,$J,358.3,3244,0)
 ;;=F10.20^^8^112^2
 ;;^UTILITY(U,$J,358.3,3244,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3244,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,3244,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,3244,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,3245,0)
 ;;=F10.21^^8^112^3
 ;;^UTILITY(U,$J,358.3,3245,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3245,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,3245,1,4,0)
 ;;=4^F10.21
 ;;^UTILITY(U,$J,358.3,3245,2)
 ;;=^5003082
 ;;^UTILITY(U,$J,358.3,3246,0)
 ;;=F10.230^^8^112^4
 ;;^UTILITY(U,$J,358.3,3246,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3246,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,3246,1,4,0)
 ;;=4^F10.230
 ;;^UTILITY(U,$J,358.3,3246,2)
 ;;=^5003086
 ;;^UTILITY(U,$J,358.3,3247,0)
 ;;=F10.231^^8^112^5
 ;;^UTILITY(U,$J,358.3,3247,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3247,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe w/ Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,3247,1,4,0)
 ;;=4^F10.231
 ;;^UTILITY(U,$J,358.3,3247,2)
 ;;=^5003087
 ;;^UTILITY(U,$J,358.3,3248,0)
 ;;=F10.232^^8^112^6
 ;;^UTILITY(U,$J,358.3,3248,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3248,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe w/ Withdrawal Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,3248,1,4,0)
 ;;=4^F10.232
 ;;^UTILITY(U,$J,358.3,3248,2)
 ;;=^5003088
 ;;^UTILITY(U,$J,358.3,3249,0)
 ;;=F10.239^^8^112^7
 ;;^UTILITY(U,$J,358.3,3249,1,0)
 ;;=^358.31IA^4^2

IBDEI203 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,33500,1,3,0)
 ;;=3^Alcohol Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,33500,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,33500,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,33501,0)
 ;;=F10.14^^148^1657^8
 ;;^UTILITY(U,$J,358.3,33501,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33501,1,3,0)
 ;;=3^Alcohol-Induced Bipolar & Related Disorder/Depressive Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,33501,1,4,0)
 ;;=4^F10.14
 ;;^UTILITY(U,$J,358.3,33501,2)
 ;;=^5003072
 ;;^UTILITY(U,$J,358.3,33502,0)
 ;;=F10.182^^148^1657^10
 ;;^UTILITY(U,$J,358.3,33502,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33502,1,3,0)
 ;;=3^Alcohol-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,33502,1,4,0)
 ;;=4^F10.182
 ;;^UTILITY(U,$J,358.3,33502,2)
 ;;=^5003078
 ;;^UTILITY(U,$J,358.3,33503,0)
 ;;=F10.20^^148^1657^2
 ;;^UTILITY(U,$J,358.3,33503,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33503,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,33503,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,33503,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,33504,0)
 ;;=F10.21^^148^1657^3
 ;;^UTILITY(U,$J,358.3,33504,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33504,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,33504,1,4,0)
 ;;=4^F10.21
 ;;^UTILITY(U,$J,358.3,33504,2)
 ;;=^5003082
 ;;^UTILITY(U,$J,358.3,33505,0)
 ;;=F10.230^^148^1657^4
 ;;^UTILITY(U,$J,358.3,33505,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33505,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,33505,1,4,0)
 ;;=4^F10.230
 ;;^UTILITY(U,$J,358.3,33505,2)
 ;;=^5003086
 ;;^UTILITY(U,$J,358.3,33506,0)
 ;;=F10.231^^148^1657^5
 ;;^UTILITY(U,$J,358.3,33506,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33506,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe w/ Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,33506,1,4,0)
 ;;=4^F10.231
 ;;^UTILITY(U,$J,358.3,33506,2)
 ;;=^5003087
 ;;^UTILITY(U,$J,358.3,33507,0)
 ;;=F10.232^^148^1657^6
 ;;^UTILITY(U,$J,358.3,33507,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33507,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe w/ Withdrawal Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,33507,1,4,0)
 ;;=4^F10.232
 ;;^UTILITY(U,$J,358.3,33507,2)
 ;;=^5003088
 ;;^UTILITY(U,$J,358.3,33508,0)
 ;;=F10.239^^148^1657^7
 ;;^UTILITY(U,$J,358.3,33508,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33508,1,3,0)
 ;;=3^Alcohol Withdrawal w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,33508,1,4,0)
 ;;=4^F10.239
 ;;^UTILITY(U,$J,358.3,33508,2)
 ;;=^5003089
 ;;^UTILITY(U,$J,358.3,33509,0)
 ;;=F10.24^^148^1657^9
 ;;^UTILITY(U,$J,358.3,33509,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33509,1,3,0)
 ;;=3^Alcohol-Induced Depressive & Related Disorder w/ Moderate-Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,33509,1,4,0)
 ;;=4^F10.24
 ;;^UTILITY(U,$J,358.3,33509,2)
 ;;=^5003090
 ;;^UTILITY(U,$J,358.3,33510,0)
 ;;=F10.29^^148^1657^11
 ;;^UTILITY(U,$J,358.3,33510,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33510,1,3,0)
 ;;=3^Alcohol-Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,33510,1,4,0)
 ;;=4^F10.29
 ;;^UTILITY(U,$J,358.3,33510,2)
 ;;=^5003100
 ;;^UTILITY(U,$J,358.3,33511,0)
 ;;=F15.10^^148^1658^4
 ;;^UTILITY(U,$J,358.3,33511,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33511,1,3,0)
 ;;=3^Amphetamine-Type Disorder,Mild
 ;;^UTILITY(U,$J,358.3,33511,1,4,0)
 ;;=4^F15.10
 ;;^UTILITY(U,$J,358.3,33511,2)
 ;;=^5003282
 ;;^UTILITY(U,$J,358.3,33512,0)
 ;;=F15.14^^148^1658^2
 ;;^UTILITY(U,$J,358.3,33512,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33512,1,3,0)
 ;;=3^Amphetamine-Induced Depressive,Bipolar & Related Disorder w/ Mild Use Disorder

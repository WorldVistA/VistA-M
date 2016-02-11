IBDEI34R ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,52537,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,52538,0)
 ;;=F10.14^^237^2614^8
 ;;^UTILITY(U,$J,358.3,52538,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52538,1,3,0)
 ;;=3^Alcohol-Induced Bipolar & Related Disorder/Depressive Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,52538,1,4,0)
 ;;=4^F10.14
 ;;^UTILITY(U,$J,358.3,52538,2)
 ;;=^5003072
 ;;^UTILITY(U,$J,358.3,52539,0)
 ;;=F10.182^^237^2614^10
 ;;^UTILITY(U,$J,358.3,52539,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52539,1,3,0)
 ;;=3^Alcohol-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,52539,1,4,0)
 ;;=4^F10.182
 ;;^UTILITY(U,$J,358.3,52539,2)
 ;;=^5003078
 ;;^UTILITY(U,$J,358.3,52540,0)
 ;;=F10.20^^237^2614^2
 ;;^UTILITY(U,$J,358.3,52540,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52540,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,52540,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,52540,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,52541,0)
 ;;=F10.21^^237^2614^3
 ;;^UTILITY(U,$J,358.3,52541,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52541,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,52541,1,4,0)
 ;;=4^F10.21
 ;;^UTILITY(U,$J,358.3,52541,2)
 ;;=^5003082
 ;;^UTILITY(U,$J,358.3,52542,0)
 ;;=F10.230^^237^2614^4
 ;;^UTILITY(U,$J,358.3,52542,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52542,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,52542,1,4,0)
 ;;=4^F10.230
 ;;^UTILITY(U,$J,358.3,52542,2)
 ;;=^5003086
 ;;^UTILITY(U,$J,358.3,52543,0)
 ;;=F10.231^^237^2614^5
 ;;^UTILITY(U,$J,358.3,52543,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52543,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe w/ Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,52543,1,4,0)
 ;;=4^F10.231
 ;;^UTILITY(U,$J,358.3,52543,2)
 ;;=^5003087
 ;;^UTILITY(U,$J,358.3,52544,0)
 ;;=F10.232^^237^2614^6
 ;;^UTILITY(U,$J,358.3,52544,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52544,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe w/ Withdrawal Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,52544,1,4,0)
 ;;=4^F10.232
 ;;^UTILITY(U,$J,358.3,52544,2)
 ;;=^5003088
 ;;^UTILITY(U,$J,358.3,52545,0)
 ;;=F10.239^^237^2614^7
 ;;^UTILITY(U,$J,358.3,52545,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52545,1,3,0)
 ;;=3^Alcohol Withdrawal w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,52545,1,4,0)
 ;;=4^F10.239
 ;;^UTILITY(U,$J,358.3,52545,2)
 ;;=^5003089
 ;;^UTILITY(U,$J,358.3,52546,0)
 ;;=F10.24^^237^2614^9
 ;;^UTILITY(U,$J,358.3,52546,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52546,1,3,0)
 ;;=3^Alcohol-Induced Depressive & Related Disorder w/ Moderate-Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,52546,1,4,0)
 ;;=4^F10.24
 ;;^UTILITY(U,$J,358.3,52546,2)
 ;;=^5003090
 ;;^UTILITY(U,$J,358.3,52547,0)
 ;;=F10.29^^237^2614^11
 ;;^UTILITY(U,$J,358.3,52547,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52547,1,3,0)
 ;;=3^Alcohol-Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,52547,1,4,0)
 ;;=4^F10.29
 ;;^UTILITY(U,$J,358.3,52547,2)
 ;;=^5003100
 ;;^UTILITY(U,$J,358.3,52548,0)
 ;;=F15.10^^237^2615^4
 ;;^UTILITY(U,$J,358.3,52548,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52548,1,3,0)
 ;;=3^Amphetamine-Type Disorder,Mild
 ;;^UTILITY(U,$J,358.3,52548,1,4,0)
 ;;=4^F15.10
 ;;^UTILITY(U,$J,358.3,52548,2)
 ;;=^5003282
 ;;^UTILITY(U,$J,358.3,52549,0)
 ;;=F15.14^^237^2615^2
 ;;^UTILITY(U,$J,358.3,52549,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52549,1,3,0)
 ;;=3^Amphetamine-Induced Depressive,Bipolar & Related Disorder w/ Mild Use Disorder

IBDEI199 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,20991,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20991,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,20991,1,4,0)
 ;;=4^F10.21
 ;;^UTILITY(U,$J,358.3,20991,2)
 ;;=^5003082
 ;;^UTILITY(U,$J,358.3,20992,0)
 ;;=F10.230^^99^1007^4
 ;;^UTILITY(U,$J,358.3,20992,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20992,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,20992,1,4,0)
 ;;=4^F10.230
 ;;^UTILITY(U,$J,358.3,20992,2)
 ;;=^5003086
 ;;^UTILITY(U,$J,358.3,20993,0)
 ;;=F10.231^^99^1007^5
 ;;^UTILITY(U,$J,358.3,20993,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20993,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe w/ Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,20993,1,4,0)
 ;;=4^F10.231
 ;;^UTILITY(U,$J,358.3,20993,2)
 ;;=^5003087
 ;;^UTILITY(U,$J,358.3,20994,0)
 ;;=F10.232^^99^1007^6
 ;;^UTILITY(U,$J,358.3,20994,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20994,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe w/ Withdrawal Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,20994,1,4,0)
 ;;=4^F10.232
 ;;^UTILITY(U,$J,358.3,20994,2)
 ;;=^5003088
 ;;^UTILITY(U,$J,358.3,20995,0)
 ;;=F10.239^^99^1007^7
 ;;^UTILITY(U,$J,358.3,20995,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20995,1,3,0)
 ;;=3^Alcohol Withdrawal w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,20995,1,4,0)
 ;;=4^F10.239
 ;;^UTILITY(U,$J,358.3,20995,2)
 ;;=^5003089
 ;;^UTILITY(U,$J,358.3,20996,0)
 ;;=F10.24^^99^1007^9
 ;;^UTILITY(U,$J,358.3,20996,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20996,1,3,0)
 ;;=3^Alcohol-Induced Depressive & Related Disorder w/ Moderate-Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,20996,1,4,0)
 ;;=4^F10.24
 ;;^UTILITY(U,$J,358.3,20996,2)
 ;;=^5003090
 ;;^UTILITY(U,$J,358.3,20997,0)
 ;;=F10.29^^99^1007^11
 ;;^UTILITY(U,$J,358.3,20997,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20997,1,3,0)
 ;;=3^Alcohol-Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,20997,1,4,0)
 ;;=4^F10.29
 ;;^UTILITY(U,$J,358.3,20997,2)
 ;;=^5003100
 ;;^UTILITY(U,$J,358.3,20998,0)
 ;;=F15.10^^99^1008^4
 ;;^UTILITY(U,$J,358.3,20998,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20998,1,3,0)
 ;;=3^Amphetamine-Type Disorder,Mild
 ;;^UTILITY(U,$J,358.3,20998,1,4,0)
 ;;=4^F15.10
 ;;^UTILITY(U,$J,358.3,20998,2)
 ;;=^5003282
 ;;^UTILITY(U,$J,358.3,20999,0)
 ;;=F15.14^^99^1008^2
 ;;^UTILITY(U,$J,358.3,20999,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20999,1,3,0)
 ;;=3^Amphetamine-Induced Depressive,Bipolar & Related Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,20999,1,4,0)
 ;;=4^F15.14
 ;;^UTILITY(U,$J,358.3,20999,2)
 ;;=^5003287
 ;;^UTILITY(U,$J,358.3,21000,0)
 ;;=F15.182^^99^1008^3
 ;;^UTILITY(U,$J,358.3,21000,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21000,1,3,0)
 ;;=3^Amphetamine-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,21000,1,4,0)
 ;;=4^F15.182
 ;;^UTILITY(U,$J,358.3,21000,2)
 ;;=^5003293
 ;;^UTILITY(U,$J,358.3,21001,0)
 ;;=F15.20^^99^1008^5
 ;;^UTILITY(U,$J,358.3,21001,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21001,1,3,0)
 ;;=3^Amphetamine-Type Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,21001,1,4,0)
 ;;=4^F15.20
 ;;^UTILITY(U,$J,358.3,21001,2)
 ;;=^5003295
 ;;^UTILITY(U,$J,358.3,21002,0)
 ;;=F15.21^^99^1008^6
 ;;^UTILITY(U,$J,358.3,21002,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21002,1,3,0)
 ;;=3^Amphetamine-Type Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,21002,1,4,0)
 ;;=4^F15.21
 ;;^UTILITY(U,$J,358.3,21002,2)
 ;;=^5003296
 ;;^UTILITY(U,$J,358.3,21003,0)
 ;;=F15.23^^99^1008^1

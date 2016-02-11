IBDEI1Z4 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,33048,1,4,0)
 ;;=4^G47.52
 ;;^UTILITY(U,$J,358.3,33048,2)
 ;;=^332778
 ;;^UTILITY(U,$J,358.3,33049,0)
 ;;=G25.81^^146^1606^18
 ;;^UTILITY(U,$J,358.3,33049,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33049,1,3,0)
 ;;=3^Restless Legs Syndrome
 ;;^UTILITY(U,$J,358.3,33049,1,4,0)
 ;;=4^G25.81
 ;;^UTILITY(U,$J,358.3,33049,2)
 ;;=^5003801
 ;;^UTILITY(U,$J,358.3,33050,0)
 ;;=G47.19^^146^1606^8
 ;;^UTILITY(U,$J,358.3,33050,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33050,1,3,0)
 ;;=3^Hypersomnolence Disorder NEC
 ;;^UTILITY(U,$J,358.3,33050,1,4,0)
 ;;=4^G47.19
 ;;^UTILITY(U,$J,358.3,33050,2)
 ;;=^5003973
 ;;^UTILITY(U,$J,358.3,33051,0)
 ;;=G47.8^^146^1606^19
 ;;^UTILITY(U,$J,358.3,33051,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33051,1,3,0)
 ;;=3^Sleep-Wake Disorder NEC
 ;;^UTILITY(U,$J,358.3,33051,1,4,0)
 ;;=4^G47.8
 ;;^UTILITY(U,$J,358.3,33051,2)
 ;;=^5003989
 ;;^UTILITY(U,$J,358.3,33052,0)
 ;;=F10.10^^146^1607^1
 ;;^UTILITY(U,$J,358.3,33052,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33052,1,3,0)
 ;;=3^Alcohol Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,33052,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,33052,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,33053,0)
 ;;=F10.14^^146^1607^8
 ;;^UTILITY(U,$J,358.3,33053,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33053,1,3,0)
 ;;=3^Alcohol-Induced Bipolar & Related Disorder/Depressive Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,33053,1,4,0)
 ;;=4^F10.14
 ;;^UTILITY(U,$J,358.3,33053,2)
 ;;=^5003072
 ;;^UTILITY(U,$J,358.3,33054,0)
 ;;=F10.182^^146^1607^10
 ;;^UTILITY(U,$J,358.3,33054,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33054,1,3,0)
 ;;=3^Alcohol-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,33054,1,4,0)
 ;;=4^F10.182
 ;;^UTILITY(U,$J,358.3,33054,2)
 ;;=^5003078
 ;;^UTILITY(U,$J,358.3,33055,0)
 ;;=F10.20^^146^1607^2
 ;;^UTILITY(U,$J,358.3,33055,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33055,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,33055,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,33055,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,33056,0)
 ;;=F10.21^^146^1607^3
 ;;^UTILITY(U,$J,358.3,33056,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33056,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,33056,1,4,0)
 ;;=4^F10.21
 ;;^UTILITY(U,$J,358.3,33056,2)
 ;;=^5003082
 ;;^UTILITY(U,$J,358.3,33057,0)
 ;;=F10.230^^146^1607^4
 ;;^UTILITY(U,$J,358.3,33057,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33057,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,33057,1,4,0)
 ;;=4^F10.230
 ;;^UTILITY(U,$J,358.3,33057,2)
 ;;=^5003086
 ;;^UTILITY(U,$J,358.3,33058,0)
 ;;=F10.231^^146^1607^5
 ;;^UTILITY(U,$J,358.3,33058,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33058,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe w/ Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,33058,1,4,0)
 ;;=4^F10.231
 ;;^UTILITY(U,$J,358.3,33058,2)
 ;;=^5003087
 ;;^UTILITY(U,$J,358.3,33059,0)
 ;;=F10.232^^146^1607^6
 ;;^UTILITY(U,$J,358.3,33059,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33059,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe w/ Withdrawal Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,33059,1,4,0)
 ;;=4^F10.232
 ;;^UTILITY(U,$J,358.3,33059,2)
 ;;=^5003088
 ;;^UTILITY(U,$J,358.3,33060,0)
 ;;=F10.239^^146^1607^7
 ;;^UTILITY(U,$J,358.3,33060,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33060,1,3,0)
 ;;=3^Alcohol Withdrawal w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,33060,1,4,0)
 ;;=4^F10.239
 ;;^UTILITY(U,$J,358.3,33060,2)
 ;;=^5003089

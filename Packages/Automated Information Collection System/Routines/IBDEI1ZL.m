IBDEI1ZL ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,33269,1,4,0)
 ;;=4^F31.5
 ;;^UTILITY(U,$J,358.3,33269,2)
 ;;=^5003504
 ;;^UTILITY(U,$J,358.3,33270,0)
 ;;=F31.75^^148^1633^14
 ;;^UTILITY(U,$J,358.3,33270,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33270,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,In Partial Remission
 ;;^UTILITY(U,$J,358.3,33270,1,4,0)
 ;;=4^F31.75
 ;;^UTILITY(U,$J,358.3,33270,2)
 ;;=^5003515
 ;;^UTILITY(U,$J,358.3,33271,0)
 ;;=F31.76^^148^1633^15
 ;;^UTILITY(U,$J,358.3,33271,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33271,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,In Full Remission
 ;;^UTILITY(U,$J,358.3,33271,1,4,0)
 ;;=4^F31.76
 ;;^UTILITY(U,$J,358.3,33271,2)
 ;;=^5003516
 ;;^UTILITY(U,$J,358.3,33272,0)
 ;;=F31.9^^148^1633^16
 ;;^UTILITY(U,$J,358.3,33272,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33272,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Unspec
 ;;^UTILITY(U,$J,358.3,33272,1,4,0)
 ;;=4^F31.9
 ;;^UTILITY(U,$J,358.3,33272,2)
 ;;=^331892
 ;;^UTILITY(U,$J,358.3,33273,0)
 ;;=F31.81^^148^1633^17
 ;;^UTILITY(U,$J,358.3,33273,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33273,1,3,0)
 ;;=3^Bipolar II Disorder
 ;;^UTILITY(U,$J,358.3,33273,1,4,0)
 ;;=4^F31.81
 ;;^UTILITY(U,$J,358.3,33273,2)
 ;;=^5003519
 ;;^UTILITY(U,$J,358.3,33274,0)
 ;;=F34.0^^148^1633^18
 ;;^UTILITY(U,$J,358.3,33274,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33274,1,3,0)
 ;;=3^Cyclothymic Disorder
 ;;^UTILITY(U,$J,358.3,33274,1,4,0)
 ;;=4^F34.0
 ;;^UTILITY(U,$J,358.3,33274,2)
 ;;=^5003538
 ;;^UTILITY(U,$J,358.3,33275,0)
 ;;=F10.232^^148^1634^2
 ;;^UTILITY(U,$J,358.3,33275,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33275,1,3,0)
 ;;=3^Alcohol Withdrawal Delirium w/ Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,33275,1,4,0)
 ;;=4^F10.232
 ;;^UTILITY(U,$J,358.3,33275,2)
 ;;=^5003088
 ;;^UTILITY(U,$J,358.3,33276,0)
 ;;=F10.231^^148^1634^3
 ;;^UTILITY(U,$J,358.3,33276,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33276,1,3,0)
 ;;=3^Alcohol Withdrawal Delirium w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,33276,1,4,0)
 ;;=4^F10.231
 ;;^UTILITY(U,$J,358.3,33276,2)
 ;;=^5003087
 ;;^UTILITY(U,$J,358.3,33277,0)
 ;;=F10.121^^148^1634^6
 ;;^UTILITY(U,$J,358.3,33277,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33277,1,3,0)
 ;;=3^Mild Alcohol Use Disorder w/ Intoxication Delirium
 ;;^UTILITY(U,$J,358.3,33277,1,4,0)
 ;;=4^F10.121
 ;;^UTILITY(U,$J,358.3,33277,2)
 ;;=^5003070
 ;;^UTILITY(U,$J,358.3,33278,0)
 ;;=F10.221^^148^1634^7
 ;;^UTILITY(U,$J,358.3,33278,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33278,1,3,0)
 ;;=3^Moderate/Severe Alcohol Use Disorder w/ Intoxication Delirium
 ;;^UTILITY(U,$J,358.3,33278,1,4,0)
 ;;=4^F10.221
 ;;^UTILITY(U,$J,358.3,33278,2)
 ;;=^5003084
 ;;^UTILITY(U,$J,358.3,33279,0)
 ;;=F10.921^^148^1634^1
 ;;^UTILITY(U,$J,358.3,33279,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33279,1,3,0)
 ;;=3^Alcohol Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,33279,1,4,0)
 ;;=4^F10.921
 ;;^UTILITY(U,$J,358.3,33279,2)
 ;;=^5003102
 ;;^UTILITY(U,$J,358.3,33280,0)
 ;;=F05.^^148^1634^4
 ;;^UTILITY(U,$J,358.3,33280,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33280,1,3,0)
 ;;=3^Delirium d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,33280,1,4,0)
 ;;=4^F05.
 ;;^UTILITY(U,$J,358.3,33280,2)
 ;;=^5003052
 ;;^UTILITY(U,$J,358.3,33281,0)
 ;;=F05.^^148^1634^5
 ;;^UTILITY(U,$J,358.3,33281,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33281,1,3,0)
 ;;=3^Delirium d/t Multiple Etiologies
 ;;^UTILITY(U,$J,358.3,33281,1,4,0)
 ;;=4^F05.
 ;;^UTILITY(U,$J,358.3,33281,2)
 ;;=^5003052

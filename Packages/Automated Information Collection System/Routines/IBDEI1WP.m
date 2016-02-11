IBDEI1WP ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31926,1,4,0)
 ;;=4^F31.5
 ;;^UTILITY(U,$J,358.3,31926,2)
 ;;=^5003504
 ;;^UTILITY(U,$J,358.3,31927,0)
 ;;=F31.75^^141^1476^14
 ;;^UTILITY(U,$J,358.3,31927,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31927,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,In Partial Remission
 ;;^UTILITY(U,$J,358.3,31927,1,4,0)
 ;;=4^F31.75
 ;;^UTILITY(U,$J,358.3,31927,2)
 ;;=^5003515
 ;;^UTILITY(U,$J,358.3,31928,0)
 ;;=F31.76^^141^1476^15
 ;;^UTILITY(U,$J,358.3,31928,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31928,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,In Full Remission
 ;;^UTILITY(U,$J,358.3,31928,1,4,0)
 ;;=4^F31.76
 ;;^UTILITY(U,$J,358.3,31928,2)
 ;;=^5003516
 ;;^UTILITY(U,$J,358.3,31929,0)
 ;;=F31.9^^141^1476^16
 ;;^UTILITY(U,$J,358.3,31929,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31929,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Unspec
 ;;^UTILITY(U,$J,358.3,31929,1,4,0)
 ;;=4^F31.9
 ;;^UTILITY(U,$J,358.3,31929,2)
 ;;=^331892
 ;;^UTILITY(U,$J,358.3,31930,0)
 ;;=F31.81^^141^1476^17
 ;;^UTILITY(U,$J,358.3,31930,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31930,1,3,0)
 ;;=3^Bipolar II Disorder
 ;;^UTILITY(U,$J,358.3,31930,1,4,0)
 ;;=4^F31.81
 ;;^UTILITY(U,$J,358.3,31930,2)
 ;;=^5003519
 ;;^UTILITY(U,$J,358.3,31931,0)
 ;;=F34.0^^141^1476^18
 ;;^UTILITY(U,$J,358.3,31931,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31931,1,3,0)
 ;;=3^Cyclothymic Disorder
 ;;^UTILITY(U,$J,358.3,31931,1,4,0)
 ;;=4^F34.0
 ;;^UTILITY(U,$J,358.3,31931,2)
 ;;=^5003538
 ;;^UTILITY(U,$J,358.3,31932,0)
 ;;=F10.232^^141^1477^2
 ;;^UTILITY(U,$J,358.3,31932,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31932,1,3,0)
 ;;=3^Alcohol Withdrawal Delirium w/ Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,31932,1,4,0)
 ;;=4^F10.232
 ;;^UTILITY(U,$J,358.3,31932,2)
 ;;=^5003088
 ;;^UTILITY(U,$J,358.3,31933,0)
 ;;=F10.231^^141^1477^3
 ;;^UTILITY(U,$J,358.3,31933,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31933,1,3,0)
 ;;=3^Alcohol Withdrawal Delirium w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,31933,1,4,0)
 ;;=4^F10.231
 ;;^UTILITY(U,$J,358.3,31933,2)
 ;;=^5003087
 ;;^UTILITY(U,$J,358.3,31934,0)
 ;;=F10.121^^141^1477^6
 ;;^UTILITY(U,$J,358.3,31934,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31934,1,3,0)
 ;;=3^Mild Alcohol Use Disorder w/ Intoxication Delirium
 ;;^UTILITY(U,$J,358.3,31934,1,4,0)
 ;;=4^F10.121
 ;;^UTILITY(U,$J,358.3,31934,2)
 ;;=^5003070
 ;;^UTILITY(U,$J,358.3,31935,0)
 ;;=F10.221^^141^1477^7
 ;;^UTILITY(U,$J,358.3,31935,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31935,1,3,0)
 ;;=3^Moderate/Severe Alcohol Use Disorder w/ Intoxication Delirium
 ;;^UTILITY(U,$J,358.3,31935,1,4,0)
 ;;=4^F10.221
 ;;^UTILITY(U,$J,358.3,31935,2)
 ;;=^5003084
 ;;^UTILITY(U,$J,358.3,31936,0)
 ;;=F10.921^^141^1477^1
 ;;^UTILITY(U,$J,358.3,31936,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31936,1,3,0)
 ;;=3^Alcohol Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,31936,1,4,0)
 ;;=4^F10.921
 ;;^UTILITY(U,$J,358.3,31936,2)
 ;;=^5003102
 ;;^UTILITY(U,$J,358.3,31937,0)
 ;;=F05.^^141^1477^4
 ;;^UTILITY(U,$J,358.3,31937,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31937,1,3,0)
 ;;=3^Delirium d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,31937,1,4,0)
 ;;=4^F05.
 ;;^UTILITY(U,$J,358.3,31937,2)
 ;;=^5003052
 ;;^UTILITY(U,$J,358.3,31938,0)
 ;;=F05.^^141^1477^5
 ;;^UTILITY(U,$J,358.3,31938,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31938,1,3,0)
 ;;=3^Delirium d/t Multiple Etiologies
 ;;^UTILITY(U,$J,358.3,31938,1,4,0)
 ;;=4^F05.
 ;;^UTILITY(U,$J,358.3,31938,2)
 ;;=^5003052

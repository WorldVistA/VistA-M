IBDEI349 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,52307,1,4,0)
 ;;=4^F31.75
 ;;^UTILITY(U,$J,358.3,52307,2)
 ;;=^5003515
 ;;^UTILITY(U,$J,358.3,52308,0)
 ;;=F31.76^^237^2590^15
 ;;^UTILITY(U,$J,358.3,52308,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52308,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,In Full Remission
 ;;^UTILITY(U,$J,358.3,52308,1,4,0)
 ;;=4^F31.76
 ;;^UTILITY(U,$J,358.3,52308,2)
 ;;=^5003516
 ;;^UTILITY(U,$J,358.3,52309,0)
 ;;=F31.9^^237^2590^16
 ;;^UTILITY(U,$J,358.3,52309,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52309,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Unspec
 ;;^UTILITY(U,$J,358.3,52309,1,4,0)
 ;;=4^F31.9
 ;;^UTILITY(U,$J,358.3,52309,2)
 ;;=^331892
 ;;^UTILITY(U,$J,358.3,52310,0)
 ;;=F31.81^^237^2590^17
 ;;^UTILITY(U,$J,358.3,52310,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52310,1,3,0)
 ;;=3^Bipolar II Disorder
 ;;^UTILITY(U,$J,358.3,52310,1,4,0)
 ;;=4^F31.81
 ;;^UTILITY(U,$J,358.3,52310,2)
 ;;=^5003519
 ;;^UTILITY(U,$J,358.3,52311,0)
 ;;=F34.0^^237^2590^18
 ;;^UTILITY(U,$J,358.3,52311,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52311,1,3,0)
 ;;=3^Cyclothymic Disorder
 ;;^UTILITY(U,$J,358.3,52311,1,4,0)
 ;;=4^F34.0
 ;;^UTILITY(U,$J,358.3,52311,2)
 ;;=^5003538
 ;;^UTILITY(U,$J,358.3,52312,0)
 ;;=F10.232^^237^2591^2
 ;;^UTILITY(U,$J,358.3,52312,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52312,1,3,0)
 ;;=3^Alcohol Withdrawal Delirium w/ Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,52312,1,4,0)
 ;;=4^F10.232
 ;;^UTILITY(U,$J,358.3,52312,2)
 ;;=^5003088
 ;;^UTILITY(U,$J,358.3,52313,0)
 ;;=F10.231^^237^2591^3
 ;;^UTILITY(U,$J,358.3,52313,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52313,1,3,0)
 ;;=3^Alcohol Withdrawal Delirium w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,52313,1,4,0)
 ;;=4^F10.231
 ;;^UTILITY(U,$J,358.3,52313,2)
 ;;=^5003087
 ;;^UTILITY(U,$J,358.3,52314,0)
 ;;=F10.121^^237^2591^6
 ;;^UTILITY(U,$J,358.3,52314,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52314,1,3,0)
 ;;=3^Mild Alcohol Use Disorder w/ Intoxication Delirium
 ;;^UTILITY(U,$J,358.3,52314,1,4,0)
 ;;=4^F10.121
 ;;^UTILITY(U,$J,358.3,52314,2)
 ;;=^5003070
 ;;^UTILITY(U,$J,358.3,52315,0)
 ;;=F10.221^^237^2591^7
 ;;^UTILITY(U,$J,358.3,52315,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52315,1,3,0)
 ;;=3^Moderate/Severe Alcohol Use Disorder w/ Intoxication Delirium
 ;;^UTILITY(U,$J,358.3,52315,1,4,0)
 ;;=4^F10.221
 ;;^UTILITY(U,$J,358.3,52315,2)
 ;;=^5003084
 ;;^UTILITY(U,$J,358.3,52316,0)
 ;;=F10.921^^237^2591^1
 ;;^UTILITY(U,$J,358.3,52316,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52316,1,3,0)
 ;;=3^Alcohol Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,52316,1,4,0)
 ;;=4^F10.921
 ;;^UTILITY(U,$J,358.3,52316,2)
 ;;=^5003102
 ;;^UTILITY(U,$J,358.3,52317,0)
 ;;=F05.^^237^2591^4
 ;;^UTILITY(U,$J,358.3,52317,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52317,1,3,0)
 ;;=3^Delirium d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,52317,1,4,0)
 ;;=4^F05.
 ;;^UTILITY(U,$J,358.3,52317,2)
 ;;=^5003052
 ;;^UTILITY(U,$J,358.3,52318,0)
 ;;=F05.^^237^2591^5
 ;;^UTILITY(U,$J,358.3,52318,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52318,1,3,0)
 ;;=3^Delirium d/t Multiple Etiologies
 ;;^UTILITY(U,$J,358.3,52318,1,4,0)
 ;;=4^F05.
 ;;^UTILITY(U,$J,358.3,52318,2)
 ;;=^5003052
 ;;^UTILITY(U,$J,358.3,52319,0)
 ;;=A81.00^^237^2592^9
 ;;^UTILITY(U,$J,358.3,52319,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52319,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Unspec
 ;;^UTILITY(U,$J,358.3,52319,1,4,0)
 ;;=4^A81.00
 ;;^UTILITY(U,$J,358.3,52319,2)
 ;;=^5000409
 ;;^UTILITY(U,$J,358.3,52320,0)
 ;;=A81.01^^237^2592^38

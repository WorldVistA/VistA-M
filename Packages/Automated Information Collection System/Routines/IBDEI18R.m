IBDEI18R ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,20759,0)
 ;;=F31.9^^99^983^16
 ;;^UTILITY(U,$J,358.3,20759,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20759,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Unspec
 ;;^UTILITY(U,$J,358.3,20759,1,4,0)
 ;;=4^F31.9
 ;;^UTILITY(U,$J,358.3,20759,2)
 ;;=^331892
 ;;^UTILITY(U,$J,358.3,20760,0)
 ;;=F31.81^^99^983^17
 ;;^UTILITY(U,$J,358.3,20760,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20760,1,3,0)
 ;;=3^Bipolar II Disorder
 ;;^UTILITY(U,$J,358.3,20760,1,4,0)
 ;;=4^F31.81
 ;;^UTILITY(U,$J,358.3,20760,2)
 ;;=^5003519
 ;;^UTILITY(U,$J,358.3,20761,0)
 ;;=F34.0^^99^983^18
 ;;^UTILITY(U,$J,358.3,20761,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20761,1,3,0)
 ;;=3^Cyclothymic Disorder
 ;;^UTILITY(U,$J,358.3,20761,1,4,0)
 ;;=4^F34.0
 ;;^UTILITY(U,$J,358.3,20761,2)
 ;;=^5003538
 ;;^UTILITY(U,$J,358.3,20762,0)
 ;;=F10.232^^99^984^2
 ;;^UTILITY(U,$J,358.3,20762,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20762,1,3,0)
 ;;=3^Alcohol Withdrawal Delirium w/ Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,20762,1,4,0)
 ;;=4^F10.232
 ;;^UTILITY(U,$J,358.3,20762,2)
 ;;=^5003088
 ;;^UTILITY(U,$J,358.3,20763,0)
 ;;=F10.231^^99^984^3
 ;;^UTILITY(U,$J,358.3,20763,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20763,1,3,0)
 ;;=3^Alcohol Withdrawal Delirium w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,20763,1,4,0)
 ;;=4^F10.231
 ;;^UTILITY(U,$J,358.3,20763,2)
 ;;=^5003087
 ;;^UTILITY(U,$J,358.3,20764,0)
 ;;=F10.121^^99^984^6
 ;;^UTILITY(U,$J,358.3,20764,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20764,1,3,0)
 ;;=3^Mild Alcohol Use Disorder w/ Intoxication Delirium
 ;;^UTILITY(U,$J,358.3,20764,1,4,0)
 ;;=4^F10.121
 ;;^UTILITY(U,$J,358.3,20764,2)
 ;;=^5003070
 ;;^UTILITY(U,$J,358.3,20765,0)
 ;;=F10.221^^99^984^7
 ;;^UTILITY(U,$J,358.3,20765,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20765,1,3,0)
 ;;=3^Moderate/Severe Alcohol Use Disorder w/ Intoxication Delirium
 ;;^UTILITY(U,$J,358.3,20765,1,4,0)
 ;;=4^F10.221
 ;;^UTILITY(U,$J,358.3,20765,2)
 ;;=^5003084
 ;;^UTILITY(U,$J,358.3,20766,0)
 ;;=F10.921^^99^984^1
 ;;^UTILITY(U,$J,358.3,20766,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20766,1,3,0)
 ;;=3^Alcohol Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,20766,1,4,0)
 ;;=4^F10.921
 ;;^UTILITY(U,$J,358.3,20766,2)
 ;;=^5003102
 ;;^UTILITY(U,$J,358.3,20767,0)
 ;;=F05.^^99^984^4
 ;;^UTILITY(U,$J,358.3,20767,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20767,1,3,0)
 ;;=3^Delirium d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,20767,1,4,0)
 ;;=4^F05.
 ;;^UTILITY(U,$J,358.3,20767,2)
 ;;=^5003052
 ;;^UTILITY(U,$J,358.3,20768,0)
 ;;=F05.^^99^984^5
 ;;^UTILITY(U,$J,358.3,20768,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20768,1,3,0)
 ;;=3^Delirium d/t Multiple Etiologies
 ;;^UTILITY(U,$J,358.3,20768,1,4,0)
 ;;=4^F05.
 ;;^UTILITY(U,$J,358.3,20768,2)
 ;;=^5003052
 ;;^UTILITY(U,$J,358.3,20769,0)
 ;;=A81.00^^99^985^9
 ;;^UTILITY(U,$J,358.3,20769,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20769,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Unspec
 ;;^UTILITY(U,$J,358.3,20769,1,4,0)
 ;;=4^A81.00
 ;;^UTILITY(U,$J,358.3,20769,2)
 ;;=^5000409
 ;;^UTILITY(U,$J,358.3,20770,0)
 ;;=A81.01^^99^985^38
 ;;^UTILITY(U,$J,358.3,20770,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20770,1,3,0)
 ;;=3^Variant Creutzfeldt-Jakob Disease
 ;;^UTILITY(U,$J,358.3,20770,1,4,0)
 ;;=4^A81.01
 ;;^UTILITY(U,$J,358.3,20770,2)
 ;;=^336701
 ;;^UTILITY(U,$J,358.3,20771,0)
 ;;=A81.09^^99^985^8
 ;;^UTILITY(U,$J,358.3,20771,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20771,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Other

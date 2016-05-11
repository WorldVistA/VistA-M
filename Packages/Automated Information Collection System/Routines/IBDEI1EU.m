IBDEI1EU ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23979,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23979,1,3,0)
 ;;=3^Bipolar Disorder,Current/Recent Episode Hypomanic,In Partial Remission
 ;;^UTILITY(U,$J,358.3,23979,1,4,0)
 ;;=4^F31.71
 ;;^UTILITY(U,$J,358.3,23979,2)
 ;;=^5003511
 ;;^UTILITY(U,$J,358.3,23980,0)
 ;;=F31.72^^90^1037^5
 ;;^UTILITY(U,$J,358.3,23980,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23980,1,3,0)
 ;;=3^Bipolar Disorder,Current/Recent Episode Hypomanic,In Full Remission
 ;;^UTILITY(U,$J,358.3,23980,1,4,0)
 ;;=4^F31.72
 ;;^UTILITY(U,$J,358.3,23980,2)
 ;;=^5003512
 ;;^UTILITY(U,$J,358.3,23981,0)
 ;;=F31.89^^90^1037^21
 ;;^UTILITY(U,$J,358.3,23981,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23981,1,3,0)
 ;;=3^Bipolar and Other Related Disorder,Oth Specified
 ;;^UTILITY(U,$J,358.3,23981,1,4,0)
 ;;=4^F31.89
 ;;^UTILITY(U,$J,358.3,23981,2)
 ;;=^5003520
 ;;^UTILITY(U,$J,358.3,23982,0)
 ;;=F10.232^^90^1038^2
 ;;^UTILITY(U,$J,358.3,23982,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23982,1,3,0)
 ;;=3^Alcohol Withdrawal Delirium w/ Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,23982,1,4,0)
 ;;=4^F10.232
 ;;^UTILITY(U,$J,358.3,23982,2)
 ;;=^5003088
 ;;^UTILITY(U,$J,358.3,23983,0)
 ;;=F10.231^^90^1038^3
 ;;^UTILITY(U,$J,358.3,23983,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23983,1,3,0)
 ;;=3^Alcohol Withdrawal Delirium w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,23983,1,4,0)
 ;;=4^F10.231
 ;;^UTILITY(U,$J,358.3,23983,2)
 ;;=^5003087
 ;;^UTILITY(U,$J,358.3,23984,0)
 ;;=F10.121^^90^1038^6
 ;;^UTILITY(U,$J,358.3,23984,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23984,1,3,0)
 ;;=3^Mild Alcohol Use Disorder w/ Intoxication Delirium
 ;;^UTILITY(U,$J,358.3,23984,1,4,0)
 ;;=4^F10.121
 ;;^UTILITY(U,$J,358.3,23984,2)
 ;;=^5003070
 ;;^UTILITY(U,$J,358.3,23985,0)
 ;;=F10.221^^90^1038^7
 ;;^UTILITY(U,$J,358.3,23985,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23985,1,3,0)
 ;;=3^Moderate/Severe Alcohol Use Disorder w/ Intoxication Delirium
 ;;^UTILITY(U,$J,358.3,23985,1,4,0)
 ;;=4^F10.221
 ;;^UTILITY(U,$J,358.3,23985,2)
 ;;=^5003084
 ;;^UTILITY(U,$J,358.3,23986,0)
 ;;=F10.921^^90^1038^1
 ;;^UTILITY(U,$J,358.3,23986,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23986,1,3,0)
 ;;=3^Alcohol Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,23986,1,4,0)
 ;;=4^F10.921
 ;;^UTILITY(U,$J,358.3,23986,2)
 ;;=^5003102
 ;;^UTILITY(U,$J,358.3,23987,0)
 ;;=F05.^^90^1038^4
 ;;^UTILITY(U,$J,358.3,23987,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23987,1,3,0)
 ;;=3^Delirium d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,23987,1,4,0)
 ;;=4^F05.
 ;;^UTILITY(U,$J,358.3,23987,2)
 ;;=^5003052
 ;;^UTILITY(U,$J,358.3,23988,0)
 ;;=F05.^^90^1038^5
 ;;^UTILITY(U,$J,358.3,23988,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23988,1,3,0)
 ;;=3^Delirium d/t Multiple Etiologies
 ;;^UTILITY(U,$J,358.3,23988,1,4,0)
 ;;=4^F05.
 ;;^UTILITY(U,$J,358.3,23988,2)
 ;;=^5003052
 ;;^UTILITY(U,$J,358.3,23989,0)
 ;;=A81.00^^90^1039^9
 ;;^UTILITY(U,$J,358.3,23989,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23989,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Unspec
 ;;^UTILITY(U,$J,358.3,23989,1,4,0)
 ;;=4^A81.00
 ;;^UTILITY(U,$J,358.3,23989,2)
 ;;=^5000409
 ;;^UTILITY(U,$J,358.3,23990,0)
 ;;=A81.01^^90^1039^38
 ;;^UTILITY(U,$J,358.3,23990,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23990,1,3,0)
 ;;=3^Variant Creutzfeldt-Jakob Disease
 ;;^UTILITY(U,$J,358.3,23990,1,4,0)
 ;;=4^A81.01
 ;;^UTILITY(U,$J,358.3,23990,2)
 ;;=^336701
 ;;^UTILITY(U,$J,358.3,23991,0)
 ;;=A81.09^^90^1039^8
 ;;^UTILITY(U,$J,358.3,23991,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23991,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Other

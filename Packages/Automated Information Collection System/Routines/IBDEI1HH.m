IBDEI1HH ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25184,1,4,0)
 ;;=4^F31.0
 ;;^UTILITY(U,$J,358.3,25184,2)
 ;;=^5003494
 ;;^UTILITY(U,$J,358.3,25185,0)
 ;;=F31.71^^95^1141^4
 ;;^UTILITY(U,$J,358.3,25185,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25185,1,3,0)
 ;;=3^Bipolar Disorder,Current/Recent Episode Hypomanic,In Partial Remission
 ;;^UTILITY(U,$J,358.3,25185,1,4,0)
 ;;=4^F31.71
 ;;^UTILITY(U,$J,358.3,25185,2)
 ;;=^5003511
 ;;^UTILITY(U,$J,358.3,25186,0)
 ;;=F31.72^^95^1141^5
 ;;^UTILITY(U,$J,358.3,25186,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25186,1,3,0)
 ;;=3^Bipolar Disorder,Current/Recent Episode Hypomanic,In Full Remission
 ;;^UTILITY(U,$J,358.3,25186,1,4,0)
 ;;=4^F31.72
 ;;^UTILITY(U,$J,358.3,25186,2)
 ;;=^5003512
 ;;^UTILITY(U,$J,358.3,25187,0)
 ;;=F31.89^^95^1141^21
 ;;^UTILITY(U,$J,358.3,25187,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25187,1,3,0)
 ;;=3^Bipolar and Other Related Disorder,Oth Specified
 ;;^UTILITY(U,$J,358.3,25187,1,4,0)
 ;;=4^F31.89
 ;;^UTILITY(U,$J,358.3,25187,2)
 ;;=^5003520
 ;;^UTILITY(U,$J,358.3,25188,0)
 ;;=F10.232^^95^1142^2
 ;;^UTILITY(U,$J,358.3,25188,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25188,1,3,0)
 ;;=3^Alcohol Withdrawal Delirium w/ Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,25188,1,4,0)
 ;;=4^F10.232
 ;;^UTILITY(U,$J,358.3,25188,2)
 ;;=^5003088
 ;;^UTILITY(U,$J,358.3,25189,0)
 ;;=F10.231^^95^1142^3
 ;;^UTILITY(U,$J,358.3,25189,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25189,1,3,0)
 ;;=3^Alcohol Withdrawal Delirium w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,25189,1,4,0)
 ;;=4^F10.231
 ;;^UTILITY(U,$J,358.3,25189,2)
 ;;=^5003087
 ;;^UTILITY(U,$J,358.3,25190,0)
 ;;=F10.121^^95^1142^6
 ;;^UTILITY(U,$J,358.3,25190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25190,1,3,0)
 ;;=3^Mild Alcohol Use Disorder w/ Intoxication Delirium
 ;;^UTILITY(U,$J,358.3,25190,1,4,0)
 ;;=4^F10.121
 ;;^UTILITY(U,$J,358.3,25190,2)
 ;;=^5003070
 ;;^UTILITY(U,$J,358.3,25191,0)
 ;;=F10.221^^95^1142^7
 ;;^UTILITY(U,$J,358.3,25191,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25191,1,3,0)
 ;;=3^Moderate/Severe Alcohol Use Disorder w/ Intoxication Delirium
 ;;^UTILITY(U,$J,358.3,25191,1,4,0)
 ;;=4^F10.221
 ;;^UTILITY(U,$J,358.3,25191,2)
 ;;=^5003084
 ;;^UTILITY(U,$J,358.3,25192,0)
 ;;=F10.921^^95^1142^1
 ;;^UTILITY(U,$J,358.3,25192,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25192,1,3,0)
 ;;=3^Alcohol Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25192,1,4,0)
 ;;=4^F10.921
 ;;^UTILITY(U,$J,358.3,25192,2)
 ;;=^5003102
 ;;^UTILITY(U,$J,358.3,25193,0)
 ;;=F05.^^95^1142^4
 ;;^UTILITY(U,$J,358.3,25193,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25193,1,3,0)
 ;;=3^Delirium d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,25193,1,4,0)
 ;;=4^F05.
 ;;^UTILITY(U,$J,358.3,25193,2)
 ;;=^5003052
 ;;^UTILITY(U,$J,358.3,25194,0)
 ;;=F05.^^95^1142^5
 ;;^UTILITY(U,$J,358.3,25194,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25194,1,3,0)
 ;;=3^Delirium d/t Multiple Etiologies
 ;;^UTILITY(U,$J,358.3,25194,1,4,0)
 ;;=4^F05.
 ;;^UTILITY(U,$J,358.3,25194,2)
 ;;=^5003052
 ;;^UTILITY(U,$J,358.3,25195,0)
 ;;=A81.00^^95^1143^9
 ;;^UTILITY(U,$J,358.3,25195,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25195,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Unspec
 ;;^UTILITY(U,$J,358.3,25195,1,4,0)
 ;;=4^A81.00
 ;;^UTILITY(U,$J,358.3,25195,2)
 ;;=^5000409
 ;;^UTILITY(U,$J,358.3,25196,0)
 ;;=A81.01^^95^1143^38
 ;;^UTILITY(U,$J,358.3,25196,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25196,1,3,0)
 ;;=3^Variant Creutzfeldt-Jakob Disease
 ;;^UTILITY(U,$J,358.3,25196,1,4,0)
 ;;=4^A81.01
 ;;^UTILITY(U,$J,358.3,25196,2)
 ;;=^336701

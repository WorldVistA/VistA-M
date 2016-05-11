IBDEI1KF ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,26557,0)
 ;;=F34.0^^100^1267^22
 ;;^UTILITY(U,$J,358.3,26557,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26557,1,3,0)
 ;;=3^Cyclothymic Disorder
 ;;^UTILITY(U,$J,358.3,26557,1,4,0)
 ;;=4^F34.0
 ;;^UTILITY(U,$J,358.3,26557,2)
 ;;=^5003538
 ;;^UTILITY(U,$J,358.3,26558,0)
 ;;=F31.0^^100^1267^3
 ;;^UTILITY(U,$J,358.3,26558,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26558,1,3,0)
 ;;=3^Bipolar Disorder,Current/Recent Episode Hypomanic
 ;;^UTILITY(U,$J,358.3,26558,1,4,0)
 ;;=4^F31.0
 ;;^UTILITY(U,$J,358.3,26558,2)
 ;;=^5003494
 ;;^UTILITY(U,$J,358.3,26559,0)
 ;;=F31.71^^100^1267^4
 ;;^UTILITY(U,$J,358.3,26559,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26559,1,3,0)
 ;;=3^Bipolar Disorder,Current/Recent Episode Hypomanic,In Partial Remission
 ;;^UTILITY(U,$J,358.3,26559,1,4,0)
 ;;=4^F31.71
 ;;^UTILITY(U,$J,358.3,26559,2)
 ;;=^5003511
 ;;^UTILITY(U,$J,358.3,26560,0)
 ;;=F31.72^^100^1267^5
 ;;^UTILITY(U,$J,358.3,26560,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26560,1,3,0)
 ;;=3^Bipolar Disorder,Current/Recent Episode Hypomanic,In Full Remission
 ;;^UTILITY(U,$J,358.3,26560,1,4,0)
 ;;=4^F31.72
 ;;^UTILITY(U,$J,358.3,26560,2)
 ;;=^5003512
 ;;^UTILITY(U,$J,358.3,26561,0)
 ;;=F31.89^^100^1267^21
 ;;^UTILITY(U,$J,358.3,26561,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26561,1,3,0)
 ;;=3^Bipolar and Other Related Disorder,Oth Specified
 ;;^UTILITY(U,$J,358.3,26561,1,4,0)
 ;;=4^F31.89
 ;;^UTILITY(U,$J,358.3,26561,2)
 ;;=^5003520
 ;;^UTILITY(U,$J,358.3,26562,0)
 ;;=F10.232^^100^1268^2
 ;;^UTILITY(U,$J,358.3,26562,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26562,1,3,0)
 ;;=3^Alcohol Withdrawal Delirium w/ Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,26562,1,4,0)
 ;;=4^F10.232
 ;;^UTILITY(U,$J,358.3,26562,2)
 ;;=^5003088
 ;;^UTILITY(U,$J,358.3,26563,0)
 ;;=F10.231^^100^1268^3
 ;;^UTILITY(U,$J,358.3,26563,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26563,1,3,0)
 ;;=3^Alcohol Withdrawal Delirium w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,26563,1,4,0)
 ;;=4^F10.231
 ;;^UTILITY(U,$J,358.3,26563,2)
 ;;=^5003087
 ;;^UTILITY(U,$J,358.3,26564,0)
 ;;=F10.121^^100^1268^6
 ;;^UTILITY(U,$J,358.3,26564,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26564,1,3,0)
 ;;=3^Mild Alcohol Use Disorder w/ Intoxication Delirium
 ;;^UTILITY(U,$J,358.3,26564,1,4,0)
 ;;=4^F10.121
 ;;^UTILITY(U,$J,358.3,26564,2)
 ;;=^5003070
 ;;^UTILITY(U,$J,358.3,26565,0)
 ;;=F10.221^^100^1268^7
 ;;^UTILITY(U,$J,358.3,26565,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26565,1,3,0)
 ;;=3^Moderate/Severe Alcohol Use Disorder w/ Intoxication Delirium
 ;;^UTILITY(U,$J,358.3,26565,1,4,0)
 ;;=4^F10.221
 ;;^UTILITY(U,$J,358.3,26565,2)
 ;;=^5003084
 ;;^UTILITY(U,$J,358.3,26566,0)
 ;;=F10.921^^100^1268^1
 ;;^UTILITY(U,$J,358.3,26566,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26566,1,3,0)
 ;;=3^Alcohol Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,26566,1,4,0)
 ;;=4^F10.921
 ;;^UTILITY(U,$J,358.3,26566,2)
 ;;=^5003102
 ;;^UTILITY(U,$J,358.3,26567,0)
 ;;=F05.^^100^1268^4
 ;;^UTILITY(U,$J,358.3,26567,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26567,1,3,0)
 ;;=3^Delirium d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,26567,1,4,0)
 ;;=4^F05.
 ;;^UTILITY(U,$J,358.3,26567,2)
 ;;=^5003052
 ;;^UTILITY(U,$J,358.3,26568,0)
 ;;=F05.^^100^1268^5
 ;;^UTILITY(U,$J,358.3,26568,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26568,1,3,0)
 ;;=3^Delirium d/t Multiple Etiologies
 ;;^UTILITY(U,$J,358.3,26568,1,4,0)
 ;;=4^F05.
 ;;^UTILITY(U,$J,358.3,26568,2)
 ;;=^5003052
 ;;^UTILITY(U,$J,358.3,26569,0)
 ;;=A81.00^^100^1269^9

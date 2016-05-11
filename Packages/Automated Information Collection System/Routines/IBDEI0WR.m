IBDEI0WR ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15371,1,4,0)
 ;;=4^F31.76
 ;;^UTILITY(U,$J,358.3,15371,2)
 ;;=^5003516
 ;;^UTILITY(U,$J,358.3,15372,0)
 ;;=F31.9^^58^660^19
 ;;^UTILITY(U,$J,358.3,15372,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15372,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Unspec
 ;;^UTILITY(U,$J,358.3,15372,1,4,0)
 ;;=4^F31.9
 ;;^UTILITY(U,$J,358.3,15372,2)
 ;;=^331892
 ;;^UTILITY(U,$J,358.3,15373,0)
 ;;=F31.81^^58^660^20
 ;;^UTILITY(U,$J,358.3,15373,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15373,1,3,0)
 ;;=3^Bipolar II Disorder
 ;;^UTILITY(U,$J,358.3,15373,1,4,0)
 ;;=4^F31.81
 ;;^UTILITY(U,$J,358.3,15373,2)
 ;;=^5003519
 ;;^UTILITY(U,$J,358.3,15374,0)
 ;;=F34.0^^58^660^22
 ;;^UTILITY(U,$J,358.3,15374,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15374,1,3,0)
 ;;=3^Cyclothymic Disorder
 ;;^UTILITY(U,$J,358.3,15374,1,4,0)
 ;;=4^F34.0
 ;;^UTILITY(U,$J,358.3,15374,2)
 ;;=^5003538
 ;;^UTILITY(U,$J,358.3,15375,0)
 ;;=F31.0^^58^660^3
 ;;^UTILITY(U,$J,358.3,15375,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15375,1,3,0)
 ;;=3^Bipolar Disorder,Current/Recent Episode Hypomanic
 ;;^UTILITY(U,$J,358.3,15375,1,4,0)
 ;;=4^F31.0
 ;;^UTILITY(U,$J,358.3,15375,2)
 ;;=^5003494
 ;;^UTILITY(U,$J,358.3,15376,0)
 ;;=F31.71^^58^660^4
 ;;^UTILITY(U,$J,358.3,15376,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15376,1,3,0)
 ;;=3^Bipolar Disorder,Current/Recent Episode Hypomanic,In Partial Remission
 ;;^UTILITY(U,$J,358.3,15376,1,4,0)
 ;;=4^F31.71
 ;;^UTILITY(U,$J,358.3,15376,2)
 ;;=^5003511
 ;;^UTILITY(U,$J,358.3,15377,0)
 ;;=F31.72^^58^660^5
 ;;^UTILITY(U,$J,358.3,15377,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15377,1,3,0)
 ;;=3^Bipolar Disorder,Current/Recent Episode Hypomanic,In Full Remission
 ;;^UTILITY(U,$J,358.3,15377,1,4,0)
 ;;=4^F31.72
 ;;^UTILITY(U,$J,358.3,15377,2)
 ;;=^5003512
 ;;^UTILITY(U,$J,358.3,15378,0)
 ;;=F31.89^^58^660^21
 ;;^UTILITY(U,$J,358.3,15378,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15378,1,3,0)
 ;;=3^Bipolar and Other Related Disorder,Oth Specified
 ;;^UTILITY(U,$J,358.3,15378,1,4,0)
 ;;=4^F31.89
 ;;^UTILITY(U,$J,358.3,15378,2)
 ;;=^5003520
 ;;^UTILITY(U,$J,358.3,15379,0)
 ;;=F10.232^^58^661^2
 ;;^UTILITY(U,$J,358.3,15379,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15379,1,3,0)
 ;;=3^Alcohol Withdrawal Delirium w/ Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,15379,1,4,0)
 ;;=4^F10.232
 ;;^UTILITY(U,$J,358.3,15379,2)
 ;;=^5003088
 ;;^UTILITY(U,$J,358.3,15380,0)
 ;;=F10.231^^58^661^3
 ;;^UTILITY(U,$J,358.3,15380,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15380,1,3,0)
 ;;=3^Alcohol Withdrawal Delirium w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,15380,1,4,0)
 ;;=4^F10.231
 ;;^UTILITY(U,$J,358.3,15380,2)
 ;;=^5003087
 ;;^UTILITY(U,$J,358.3,15381,0)
 ;;=F10.121^^58^661^6
 ;;^UTILITY(U,$J,358.3,15381,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15381,1,3,0)
 ;;=3^Mild Alcohol Use Disorder w/ Intoxication Delirium
 ;;^UTILITY(U,$J,358.3,15381,1,4,0)
 ;;=4^F10.121
 ;;^UTILITY(U,$J,358.3,15381,2)
 ;;=^5003070
 ;;^UTILITY(U,$J,358.3,15382,0)
 ;;=F10.221^^58^661^7
 ;;^UTILITY(U,$J,358.3,15382,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15382,1,3,0)
 ;;=3^Moderate/Severe Alcohol Use Disorder w/ Intoxication Delirium
 ;;^UTILITY(U,$J,358.3,15382,1,4,0)
 ;;=4^F10.221
 ;;^UTILITY(U,$J,358.3,15382,2)
 ;;=^5003084
 ;;^UTILITY(U,$J,358.3,15383,0)
 ;;=F10.921^^58^661^1
 ;;^UTILITY(U,$J,358.3,15383,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15383,1,3,0)
 ;;=3^Alcohol Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,15383,1,4,0)
 ;;=4^F10.921
 ;;^UTILITY(U,$J,358.3,15383,2)
 ;;=^5003102

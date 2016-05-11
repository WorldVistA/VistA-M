IBDEI01F ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,165,2)
 ;;=^5003501
 ;;^UTILITY(U,$J,358.3,166,0)
 ;;=F31.32^^3^25^14
 ;;^UTILITY(U,$J,358.3,166,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,166,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,Moderate
 ;;^UTILITY(U,$J,358.3,166,1,4,0)
 ;;=4^F31.32
 ;;^UTILITY(U,$J,358.3,166,2)
 ;;=^5003502
 ;;^UTILITY(U,$J,358.3,167,0)
 ;;=F31.4^^3^25^15
 ;;^UTILITY(U,$J,358.3,167,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,167,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,Severe
 ;;^UTILITY(U,$J,358.3,167,1,4,0)
 ;;=4^F31.4
 ;;^UTILITY(U,$J,358.3,167,2)
 ;;=^5003503
 ;;^UTILITY(U,$J,358.3,168,0)
 ;;=F31.5^^3^25^16
 ;;^UTILITY(U,$J,358.3,168,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,168,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,w/ Psychotic Features
 ;;^UTILITY(U,$J,358.3,168,1,4,0)
 ;;=4^F31.5
 ;;^UTILITY(U,$J,358.3,168,2)
 ;;=^5003504
 ;;^UTILITY(U,$J,358.3,169,0)
 ;;=F31.75^^3^25^17
 ;;^UTILITY(U,$J,358.3,169,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,169,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,In Partial Remission
 ;;^UTILITY(U,$J,358.3,169,1,4,0)
 ;;=4^F31.75
 ;;^UTILITY(U,$J,358.3,169,2)
 ;;=^5003515
 ;;^UTILITY(U,$J,358.3,170,0)
 ;;=F31.76^^3^25^18
 ;;^UTILITY(U,$J,358.3,170,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,170,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,In Full Remission
 ;;^UTILITY(U,$J,358.3,170,1,4,0)
 ;;=4^F31.76
 ;;^UTILITY(U,$J,358.3,170,2)
 ;;=^5003516
 ;;^UTILITY(U,$J,358.3,171,0)
 ;;=F31.9^^3^25^19
 ;;^UTILITY(U,$J,358.3,171,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,171,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Unspec
 ;;^UTILITY(U,$J,358.3,171,1,4,0)
 ;;=4^F31.9
 ;;^UTILITY(U,$J,358.3,171,2)
 ;;=^331892
 ;;^UTILITY(U,$J,358.3,172,0)
 ;;=F31.81^^3^25^20
 ;;^UTILITY(U,$J,358.3,172,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,172,1,3,0)
 ;;=3^Bipolar II Disorder
 ;;^UTILITY(U,$J,358.3,172,1,4,0)
 ;;=4^F31.81
 ;;^UTILITY(U,$J,358.3,172,2)
 ;;=^5003519
 ;;^UTILITY(U,$J,358.3,173,0)
 ;;=F34.0^^3^25^22
 ;;^UTILITY(U,$J,358.3,173,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,173,1,3,0)
 ;;=3^Cyclothymic Disorder
 ;;^UTILITY(U,$J,358.3,173,1,4,0)
 ;;=4^F34.0
 ;;^UTILITY(U,$J,358.3,173,2)
 ;;=^5003538
 ;;^UTILITY(U,$J,358.3,174,0)
 ;;=F31.0^^3^25^3
 ;;^UTILITY(U,$J,358.3,174,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,174,1,3,0)
 ;;=3^Bipolar Disorder,Current/Recent Episode Hypomanic
 ;;^UTILITY(U,$J,358.3,174,1,4,0)
 ;;=4^F31.0
 ;;^UTILITY(U,$J,358.3,174,2)
 ;;=^5003494
 ;;^UTILITY(U,$J,358.3,175,0)
 ;;=F31.71^^3^25^4
 ;;^UTILITY(U,$J,358.3,175,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,175,1,3,0)
 ;;=3^Bipolar Disorder,Current/Recent Episode Hypomanic,In Partial Remission
 ;;^UTILITY(U,$J,358.3,175,1,4,0)
 ;;=4^F31.71
 ;;^UTILITY(U,$J,358.3,175,2)
 ;;=^5003511
 ;;^UTILITY(U,$J,358.3,176,0)
 ;;=F31.72^^3^25^5
 ;;^UTILITY(U,$J,358.3,176,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,176,1,3,0)
 ;;=3^Bipolar Disorder,Current/Recent Episode Hypomanic,In Full Remission
 ;;^UTILITY(U,$J,358.3,176,1,4,0)
 ;;=4^F31.72
 ;;^UTILITY(U,$J,358.3,176,2)
 ;;=^5003512
 ;;^UTILITY(U,$J,358.3,177,0)
 ;;=F31.89^^3^25^21
 ;;^UTILITY(U,$J,358.3,177,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,177,1,3,0)
 ;;=3^Bipolar and Other Related Disorder,Oth Specified
 ;;^UTILITY(U,$J,358.3,177,1,4,0)
 ;;=4^F31.89
 ;;^UTILITY(U,$J,358.3,177,2)
 ;;=^5003520
 ;;^UTILITY(U,$J,358.3,178,0)
 ;;=F10.232^^3^26^2
 ;;^UTILITY(U,$J,358.3,178,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,178,1,3,0)
 ;;=3^Alcohol Withdrawal Delirium w/ Perceptual Disturbances

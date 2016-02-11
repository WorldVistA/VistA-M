IBDEI01Z ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,151,1,4,0)
 ;;=4^F31.73
 ;;^UTILITY(U,$J,358.3,151,2)
 ;;=^5003513
 ;;^UTILITY(U,$J,358.3,152,0)
 ;;=F31.74^^3^25^8
 ;;^UTILITY(U,$J,358.3,152,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,152,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,In Full Remission
 ;;^UTILITY(U,$J,358.3,152,1,4,0)
 ;;=4^F31.74
 ;;^UTILITY(U,$J,358.3,152,2)
 ;;=^5003514
 ;;^UTILITY(U,$J,358.3,153,0)
 ;;=F31.30^^3^25^9
 ;;^UTILITY(U,$J,358.3,153,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,153,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,Unspec
 ;;^UTILITY(U,$J,358.3,153,1,4,0)
 ;;=4^F31.30
 ;;^UTILITY(U,$J,358.3,153,2)
 ;;=^5003500
 ;;^UTILITY(U,$J,358.3,154,0)
 ;;=F31.31^^3^25^10
 ;;^UTILITY(U,$J,358.3,154,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,154,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,Mild
 ;;^UTILITY(U,$J,358.3,154,1,4,0)
 ;;=4^F31.31
 ;;^UTILITY(U,$J,358.3,154,2)
 ;;=^5003501
 ;;^UTILITY(U,$J,358.3,155,0)
 ;;=F31.32^^3^25^11
 ;;^UTILITY(U,$J,358.3,155,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,155,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,Moderate
 ;;^UTILITY(U,$J,358.3,155,1,4,0)
 ;;=4^F31.32
 ;;^UTILITY(U,$J,358.3,155,2)
 ;;=^5003502
 ;;^UTILITY(U,$J,358.3,156,0)
 ;;=F31.4^^3^25^12
 ;;^UTILITY(U,$J,358.3,156,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,156,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,Severe
 ;;^UTILITY(U,$J,358.3,156,1,4,0)
 ;;=4^F31.4
 ;;^UTILITY(U,$J,358.3,156,2)
 ;;=^5003503
 ;;^UTILITY(U,$J,358.3,157,0)
 ;;=F31.5^^3^25^13
 ;;^UTILITY(U,$J,358.3,157,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,157,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,w/ Psychotic Features
 ;;^UTILITY(U,$J,358.3,157,1,4,0)
 ;;=4^F31.5
 ;;^UTILITY(U,$J,358.3,157,2)
 ;;=^5003504
 ;;^UTILITY(U,$J,358.3,158,0)
 ;;=F31.75^^3^25^14
 ;;^UTILITY(U,$J,358.3,158,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,158,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,In Partial Remission
 ;;^UTILITY(U,$J,358.3,158,1,4,0)
 ;;=4^F31.75
 ;;^UTILITY(U,$J,358.3,158,2)
 ;;=^5003515
 ;;^UTILITY(U,$J,358.3,159,0)
 ;;=F31.76^^3^25^15
 ;;^UTILITY(U,$J,358.3,159,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,159,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,In Full Remission
 ;;^UTILITY(U,$J,358.3,159,1,4,0)
 ;;=4^F31.76
 ;;^UTILITY(U,$J,358.3,159,2)
 ;;=^5003516
 ;;^UTILITY(U,$J,358.3,160,0)
 ;;=F31.9^^3^25^16
 ;;^UTILITY(U,$J,358.3,160,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,160,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Unspec
 ;;^UTILITY(U,$J,358.3,160,1,4,0)
 ;;=4^F31.9
 ;;^UTILITY(U,$J,358.3,160,2)
 ;;=^331892
 ;;^UTILITY(U,$J,358.3,161,0)
 ;;=F31.81^^3^25^17
 ;;^UTILITY(U,$J,358.3,161,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,161,1,3,0)
 ;;=3^Bipolar II Disorder
 ;;^UTILITY(U,$J,358.3,161,1,4,0)
 ;;=4^F31.81
 ;;^UTILITY(U,$J,358.3,161,2)
 ;;=^5003519
 ;;^UTILITY(U,$J,358.3,162,0)
 ;;=F34.0^^3^25^18
 ;;^UTILITY(U,$J,358.3,162,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,162,1,3,0)
 ;;=3^Cyclothymic Disorder
 ;;^UTILITY(U,$J,358.3,162,1,4,0)
 ;;=4^F34.0
 ;;^UTILITY(U,$J,358.3,162,2)
 ;;=^5003538
 ;;^UTILITY(U,$J,358.3,163,0)
 ;;=F10.232^^3^26^2
 ;;^UTILITY(U,$J,358.3,163,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,163,1,3,0)
 ;;=3^Alcohol Withdrawal Delirium w/ Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,163,1,4,0)
 ;;=4^F10.232
 ;;^UTILITY(U,$J,358.3,163,2)
 ;;=^5003088
 ;;^UTILITY(U,$J,358.3,164,0)
 ;;=F10.231^^3^26^3
 ;;^UTILITY(U,$J,358.3,164,1,0)
 ;;=^358.31IA^4^2

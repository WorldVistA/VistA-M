IBDEI1AP ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,20715,1,4,0)
 ;;=4^F31.12
 ;;^UTILITY(U,$J,358.3,20715,2)
 ;;=^5003497
 ;;^UTILITY(U,$J,358.3,20716,0)
 ;;=F31.13^^95^1022^8
 ;;^UTILITY(U,$J,358.3,20716,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20716,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,Severe
 ;;^UTILITY(U,$J,358.3,20716,1,4,0)
 ;;=4^F31.13
 ;;^UTILITY(U,$J,358.3,20716,2)
 ;;=^5003498
 ;;^UTILITY(U,$J,358.3,20717,0)
 ;;=F31.2^^95^1022^9
 ;;^UTILITY(U,$J,358.3,20717,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20717,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,w/ Psychotic Features
 ;;^UTILITY(U,$J,358.3,20717,1,4,0)
 ;;=4^F31.2
 ;;^UTILITY(U,$J,358.3,20717,2)
 ;;=^5003499
 ;;^UTILITY(U,$J,358.3,20718,0)
 ;;=F31.73^^95^1022^10
 ;;^UTILITY(U,$J,358.3,20718,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20718,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,In Partial Remission
 ;;^UTILITY(U,$J,358.3,20718,1,4,0)
 ;;=4^F31.73
 ;;^UTILITY(U,$J,358.3,20718,2)
 ;;=^5003513
 ;;^UTILITY(U,$J,358.3,20719,0)
 ;;=F31.74^^95^1022^11
 ;;^UTILITY(U,$J,358.3,20719,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20719,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,In Full Remission
 ;;^UTILITY(U,$J,358.3,20719,1,4,0)
 ;;=4^F31.74
 ;;^UTILITY(U,$J,358.3,20719,2)
 ;;=^5003514
 ;;^UTILITY(U,$J,358.3,20720,0)
 ;;=F31.31^^95^1022^13
 ;;^UTILITY(U,$J,358.3,20720,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20720,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,Mild
 ;;^UTILITY(U,$J,358.3,20720,1,4,0)
 ;;=4^F31.31
 ;;^UTILITY(U,$J,358.3,20720,2)
 ;;=^5003501
 ;;^UTILITY(U,$J,358.3,20721,0)
 ;;=F31.32^^95^1022^14
 ;;^UTILITY(U,$J,358.3,20721,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20721,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,Moderate
 ;;^UTILITY(U,$J,358.3,20721,1,4,0)
 ;;=4^F31.32
 ;;^UTILITY(U,$J,358.3,20721,2)
 ;;=^5003502
 ;;^UTILITY(U,$J,358.3,20722,0)
 ;;=F31.4^^95^1022^15
 ;;^UTILITY(U,$J,358.3,20722,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20722,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,Severe
 ;;^UTILITY(U,$J,358.3,20722,1,4,0)
 ;;=4^F31.4
 ;;^UTILITY(U,$J,358.3,20722,2)
 ;;=^5003503
 ;;^UTILITY(U,$J,358.3,20723,0)
 ;;=F31.5^^95^1022^16
 ;;^UTILITY(U,$J,358.3,20723,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20723,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,w/ Psychotic Features
 ;;^UTILITY(U,$J,358.3,20723,1,4,0)
 ;;=4^F31.5
 ;;^UTILITY(U,$J,358.3,20723,2)
 ;;=^5003504
 ;;^UTILITY(U,$J,358.3,20724,0)
 ;;=F31.75^^95^1022^18
 ;;^UTILITY(U,$J,358.3,20724,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20724,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,In Partial Remission
 ;;^UTILITY(U,$J,358.3,20724,1,4,0)
 ;;=4^F31.75
 ;;^UTILITY(U,$J,358.3,20724,2)
 ;;=^5003515
 ;;^UTILITY(U,$J,358.3,20725,0)
 ;;=F31.76^^95^1022^17
 ;;^UTILITY(U,$J,358.3,20725,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20725,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,In Full Remission
 ;;^UTILITY(U,$J,358.3,20725,1,4,0)
 ;;=4^F31.76
 ;;^UTILITY(U,$J,358.3,20725,2)
 ;;=^5003516
 ;;^UTILITY(U,$J,358.3,20726,0)
 ;;=F31.81^^95^1022^23
 ;;^UTILITY(U,$J,358.3,20726,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20726,1,3,0)
 ;;=3^Bipolar II Disorder
 ;;^UTILITY(U,$J,358.3,20726,1,4,0)
 ;;=4^F31.81

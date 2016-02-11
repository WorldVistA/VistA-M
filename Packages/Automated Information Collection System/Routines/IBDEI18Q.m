IBDEI18Q ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,20747,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,Moderate
 ;;^UTILITY(U,$J,358.3,20747,1,4,0)
 ;;=4^F31.12
 ;;^UTILITY(U,$J,358.3,20747,2)
 ;;=^5003497
 ;;^UTILITY(U,$J,358.3,20748,0)
 ;;=F31.13^^99^983^5
 ;;^UTILITY(U,$J,358.3,20748,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20748,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,Severe
 ;;^UTILITY(U,$J,358.3,20748,1,4,0)
 ;;=4^F31.13
 ;;^UTILITY(U,$J,358.3,20748,2)
 ;;=^5003498
 ;;^UTILITY(U,$J,358.3,20749,0)
 ;;=F31.2^^99^983^6
 ;;^UTILITY(U,$J,358.3,20749,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20749,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,w/ Psychotic Features
 ;;^UTILITY(U,$J,358.3,20749,1,4,0)
 ;;=4^F31.2
 ;;^UTILITY(U,$J,358.3,20749,2)
 ;;=^5003499
 ;;^UTILITY(U,$J,358.3,20750,0)
 ;;=F31.73^^99^983^7
 ;;^UTILITY(U,$J,358.3,20750,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20750,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,In Partial Remission
 ;;^UTILITY(U,$J,358.3,20750,1,4,0)
 ;;=4^F31.73
 ;;^UTILITY(U,$J,358.3,20750,2)
 ;;=^5003513
 ;;^UTILITY(U,$J,358.3,20751,0)
 ;;=F31.74^^99^983^8
 ;;^UTILITY(U,$J,358.3,20751,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20751,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,In Full Remission
 ;;^UTILITY(U,$J,358.3,20751,1,4,0)
 ;;=4^F31.74
 ;;^UTILITY(U,$J,358.3,20751,2)
 ;;=^5003514
 ;;^UTILITY(U,$J,358.3,20752,0)
 ;;=F31.30^^99^983^9
 ;;^UTILITY(U,$J,358.3,20752,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20752,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,Unspec
 ;;^UTILITY(U,$J,358.3,20752,1,4,0)
 ;;=4^F31.30
 ;;^UTILITY(U,$J,358.3,20752,2)
 ;;=^5003500
 ;;^UTILITY(U,$J,358.3,20753,0)
 ;;=F31.31^^99^983^10
 ;;^UTILITY(U,$J,358.3,20753,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20753,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,Mild
 ;;^UTILITY(U,$J,358.3,20753,1,4,0)
 ;;=4^F31.31
 ;;^UTILITY(U,$J,358.3,20753,2)
 ;;=^5003501
 ;;^UTILITY(U,$J,358.3,20754,0)
 ;;=F31.32^^99^983^11
 ;;^UTILITY(U,$J,358.3,20754,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20754,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,Moderate
 ;;^UTILITY(U,$J,358.3,20754,1,4,0)
 ;;=4^F31.32
 ;;^UTILITY(U,$J,358.3,20754,2)
 ;;=^5003502
 ;;^UTILITY(U,$J,358.3,20755,0)
 ;;=F31.4^^99^983^12
 ;;^UTILITY(U,$J,358.3,20755,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20755,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,Severe
 ;;^UTILITY(U,$J,358.3,20755,1,4,0)
 ;;=4^F31.4
 ;;^UTILITY(U,$J,358.3,20755,2)
 ;;=^5003503
 ;;^UTILITY(U,$J,358.3,20756,0)
 ;;=F31.5^^99^983^13
 ;;^UTILITY(U,$J,358.3,20756,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20756,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,w/ Psychotic Features
 ;;^UTILITY(U,$J,358.3,20756,1,4,0)
 ;;=4^F31.5
 ;;^UTILITY(U,$J,358.3,20756,2)
 ;;=^5003504
 ;;^UTILITY(U,$J,358.3,20757,0)
 ;;=F31.75^^99^983^14
 ;;^UTILITY(U,$J,358.3,20757,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20757,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,In Partial Remission
 ;;^UTILITY(U,$J,358.3,20757,1,4,0)
 ;;=4^F31.75
 ;;^UTILITY(U,$J,358.3,20757,2)
 ;;=^5003515
 ;;^UTILITY(U,$J,358.3,20758,0)
 ;;=F31.76^^99^983^15
 ;;^UTILITY(U,$J,358.3,20758,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20758,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,In Full Remission
 ;;^UTILITY(U,$J,358.3,20758,1,4,0)
 ;;=4^F31.76
 ;;^UTILITY(U,$J,358.3,20758,2)
 ;;=^5003516

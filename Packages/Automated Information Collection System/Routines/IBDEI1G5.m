IBDEI1G5 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24579,0)
 ;;=F31.11^^93^1092^6
 ;;^UTILITY(U,$J,358.3,24579,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24579,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,Mild
 ;;^UTILITY(U,$J,358.3,24579,1,4,0)
 ;;=4^F31.11
 ;;^UTILITY(U,$J,358.3,24579,2)
 ;;=^5003496
 ;;^UTILITY(U,$J,358.3,24580,0)
 ;;=F31.12^^93^1092^7
 ;;^UTILITY(U,$J,358.3,24580,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24580,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,Moderate
 ;;^UTILITY(U,$J,358.3,24580,1,4,0)
 ;;=4^F31.12
 ;;^UTILITY(U,$J,358.3,24580,2)
 ;;=^5003497
 ;;^UTILITY(U,$J,358.3,24581,0)
 ;;=F31.13^^93^1092^8
 ;;^UTILITY(U,$J,358.3,24581,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24581,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,Severe
 ;;^UTILITY(U,$J,358.3,24581,1,4,0)
 ;;=4^F31.13
 ;;^UTILITY(U,$J,358.3,24581,2)
 ;;=^5003498
 ;;^UTILITY(U,$J,358.3,24582,0)
 ;;=F31.2^^93^1092^9
 ;;^UTILITY(U,$J,358.3,24582,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24582,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,w/ Psychotic Features
 ;;^UTILITY(U,$J,358.3,24582,1,4,0)
 ;;=4^F31.2
 ;;^UTILITY(U,$J,358.3,24582,2)
 ;;=^5003499
 ;;^UTILITY(U,$J,358.3,24583,0)
 ;;=F31.73^^93^1092^10
 ;;^UTILITY(U,$J,358.3,24583,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24583,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,In Partial Remission
 ;;^UTILITY(U,$J,358.3,24583,1,4,0)
 ;;=4^F31.73
 ;;^UTILITY(U,$J,358.3,24583,2)
 ;;=^5003513
 ;;^UTILITY(U,$J,358.3,24584,0)
 ;;=F31.74^^93^1092^11
 ;;^UTILITY(U,$J,358.3,24584,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24584,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,In Full Remission
 ;;^UTILITY(U,$J,358.3,24584,1,4,0)
 ;;=4^F31.74
 ;;^UTILITY(U,$J,358.3,24584,2)
 ;;=^5003514
 ;;^UTILITY(U,$J,358.3,24585,0)
 ;;=F31.30^^93^1092^12
 ;;^UTILITY(U,$J,358.3,24585,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24585,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,Unspec
 ;;^UTILITY(U,$J,358.3,24585,1,4,0)
 ;;=4^F31.30
 ;;^UTILITY(U,$J,358.3,24585,2)
 ;;=^5003500
 ;;^UTILITY(U,$J,358.3,24586,0)
 ;;=F31.31^^93^1092^13
 ;;^UTILITY(U,$J,358.3,24586,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24586,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,Mild
 ;;^UTILITY(U,$J,358.3,24586,1,4,0)
 ;;=4^F31.31
 ;;^UTILITY(U,$J,358.3,24586,2)
 ;;=^5003501
 ;;^UTILITY(U,$J,358.3,24587,0)
 ;;=F31.32^^93^1092^14
 ;;^UTILITY(U,$J,358.3,24587,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24587,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,Moderate
 ;;^UTILITY(U,$J,358.3,24587,1,4,0)
 ;;=4^F31.32
 ;;^UTILITY(U,$J,358.3,24587,2)
 ;;=^5003502
 ;;^UTILITY(U,$J,358.3,24588,0)
 ;;=F31.4^^93^1092^15
 ;;^UTILITY(U,$J,358.3,24588,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24588,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,Severe
 ;;^UTILITY(U,$J,358.3,24588,1,4,0)
 ;;=4^F31.4
 ;;^UTILITY(U,$J,358.3,24588,2)
 ;;=^5003503
 ;;^UTILITY(U,$J,358.3,24589,0)
 ;;=F31.5^^93^1092^16
 ;;^UTILITY(U,$J,358.3,24589,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24589,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,w/ Psychotic Features
 ;;^UTILITY(U,$J,358.3,24589,1,4,0)
 ;;=4^F31.5
 ;;^UTILITY(U,$J,358.3,24589,2)
 ;;=^5003504
 ;;^UTILITY(U,$J,358.3,24590,0)
 ;;=F31.75^^93^1092^17
 ;;^UTILITY(U,$J,358.3,24590,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24590,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,In Partial Remission

IBDEI0WQ ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15359,1,4,0)
 ;;=4^F31.11
 ;;^UTILITY(U,$J,358.3,15359,2)
 ;;=^5003496
 ;;^UTILITY(U,$J,358.3,15360,0)
 ;;=F31.12^^58^660^7
 ;;^UTILITY(U,$J,358.3,15360,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15360,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,Moderate
 ;;^UTILITY(U,$J,358.3,15360,1,4,0)
 ;;=4^F31.12
 ;;^UTILITY(U,$J,358.3,15360,2)
 ;;=^5003497
 ;;^UTILITY(U,$J,358.3,15361,0)
 ;;=F31.13^^58^660^8
 ;;^UTILITY(U,$J,358.3,15361,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15361,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,Severe
 ;;^UTILITY(U,$J,358.3,15361,1,4,0)
 ;;=4^F31.13
 ;;^UTILITY(U,$J,358.3,15361,2)
 ;;=^5003498
 ;;^UTILITY(U,$J,358.3,15362,0)
 ;;=F31.2^^58^660^9
 ;;^UTILITY(U,$J,358.3,15362,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15362,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,w/ Psychotic Features
 ;;^UTILITY(U,$J,358.3,15362,1,4,0)
 ;;=4^F31.2
 ;;^UTILITY(U,$J,358.3,15362,2)
 ;;=^5003499
 ;;^UTILITY(U,$J,358.3,15363,0)
 ;;=F31.73^^58^660^10
 ;;^UTILITY(U,$J,358.3,15363,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15363,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,In Partial Remission
 ;;^UTILITY(U,$J,358.3,15363,1,4,0)
 ;;=4^F31.73
 ;;^UTILITY(U,$J,358.3,15363,2)
 ;;=^5003513
 ;;^UTILITY(U,$J,358.3,15364,0)
 ;;=F31.74^^58^660^11
 ;;^UTILITY(U,$J,358.3,15364,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15364,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,In Full Remission
 ;;^UTILITY(U,$J,358.3,15364,1,4,0)
 ;;=4^F31.74
 ;;^UTILITY(U,$J,358.3,15364,2)
 ;;=^5003514
 ;;^UTILITY(U,$J,358.3,15365,0)
 ;;=F31.30^^58^660^12
 ;;^UTILITY(U,$J,358.3,15365,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15365,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,Unspec
 ;;^UTILITY(U,$J,358.3,15365,1,4,0)
 ;;=4^F31.30
 ;;^UTILITY(U,$J,358.3,15365,2)
 ;;=^5003500
 ;;^UTILITY(U,$J,358.3,15366,0)
 ;;=F31.31^^58^660^13
 ;;^UTILITY(U,$J,358.3,15366,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15366,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,Mild
 ;;^UTILITY(U,$J,358.3,15366,1,4,0)
 ;;=4^F31.31
 ;;^UTILITY(U,$J,358.3,15366,2)
 ;;=^5003501
 ;;^UTILITY(U,$J,358.3,15367,0)
 ;;=F31.32^^58^660^14
 ;;^UTILITY(U,$J,358.3,15367,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15367,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,Moderate
 ;;^UTILITY(U,$J,358.3,15367,1,4,0)
 ;;=4^F31.32
 ;;^UTILITY(U,$J,358.3,15367,2)
 ;;=^5003502
 ;;^UTILITY(U,$J,358.3,15368,0)
 ;;=F31.4^^58^660^15
 ;;^UTILITY(U,$J,358.3,15368,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15368,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,Severe
 ;;^UTILITY(U,$J,358.3,15368,1,4,0)
 ;;=4^F31.4
 ;;^UTILITY(U,$J,358.3,15368,2)
 ;;=^5003503
 ;;^UTILITY(U,$J,358.3,15369,0)
 ;;=F31.5^^58^660^16
 ;;^UTILITY(U,$J,358.3,15369,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15369,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,w/ Psychotic Features
 ;;^UTILITY(U,$J,358.3,15369,1,4,0)
 ;;=4^F31.5
 ;;^UTILITY(U,$J,358.3,15369,2)
 ;;=^5003504
 ;;^UTILITY(U,$J,358.3,15370,0)
 ;;=F31.75^^58^660^17
 ;;^UTILITY(U,$J,358.3,15370,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15370,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,In Partial Remission
 ;;^UTILITY(U,$J,358.3,15370,1,4,0)
 ;;=4^F31.75
 ;;^UTILITY(U,$J,358.3,15370,2)
 ;;=^5003515
 ;;^UTILITY(U,$J,358.3,15371,0)
 ;;=F31.76^^58^660^18
 ;;^UTILITY(U,$J,358.3,15371,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15371,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,In Full Remission

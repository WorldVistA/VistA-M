IBDEI1IY ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25878,0)
 ;;=F40.01^^98^1210^3
 ;;^UTILITY(U,$J,358.3,25878,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25878,1,3,0)
 ;;=3^Agoraphobia w/ Panic Disorder
 ;;^UTILITY(U,$J,358.3,25878,1,4,0)
 ;;=4^F40.01
 ;;^UTILITY(U,$J,358.3,25878,2)
 ;;=^331911
 ;;^UTILITY(U,$J,358.3,25879,0)
 ;;=F40.298^^98^1210^16
 ;;^UTILITY(U,$J,358.3,25879,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25879,1,3,0)
 ;;=3^Phobia,Oth Specified
 ;;^UTILITY(U,$J,358.3,25879,1,4,0)
 ;;=4^F40.298
 ;;^UTILITY(U,$J,358.3,25879,2)
 ;;=^5003561
 ;;^UTILITY(U,$J,358.3,25880,0)
 ;;=F93.0^^98^1210^17
 ;;^UTILITY(U,$J,358.3,25880,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25880,1,3,0)
 ;;=3^Separation Anxiety Disorder
 ;;^UTILITY(U,$J,358.3,25880,1,4,0)
 ;;=4^F93.0
 ;;^UTILITY(U,$J,358.3,25880,2)
 ;;=^5003702
 ;;^UTILITY(U,$J,358.3,25881,0)
 ;;=F41.8^^98^1210^7
 ;;^UTILITY(U,$J,358.3,25881,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25881,1,3,0)
 ;;=3^Anxiety Disorder,Oth Specified
 ;;^UTILITY(U,$J,358.3,25881,1,4,0)
 ;;=4^F41.8
 ;;^UTILITY(U,$J,358.3,25881,2)
 ;;=^5003566
 ;;^UTILITY(U,$J,358.3,25882,0)
 ;;=F06.33^^98^1211^1
 ;;^UTILITY(U,$J,358.3,25882,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25882,1,3,0)
 ;;=3^Bipolar & Related Disorder d/t Medical Condition w/ Manic Features
 ;;^UTILITY(U,$J,358.3,25882,1,4,0)
 ;;=4^F06.33
 ;;^UTILITY(U,$J,358.3,25882,2)
 ;;=^5003059
 ;;^UTILITY(U,$J,358.3,25883,0)
 ;;=F06.34^^98^1211^2
 ;;^UTILITY(U,$J,358.3,25883,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25883,1,3,0)
 ;;=3^Bipolar & Related Disorder d/t Medical Condition w/ Mixed Features
 ;;^UTILITY(U,$J,358.3,25883,1,4,0)
 ;;=4^F06.34
 ;;^UTILITY(U,$J,358.3,25883,2)
 ;;=^5003060
 ;;^UTILITY(U,$J,358.3,25884,0)
 ;;=F31.11^^98^1211^6
 ;;^UTILITY(U,$J,358.3,25884,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25884,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,Mild
 ;;^UTILITY(U,$J,358.3,25884,1,4,0)
 ;;=4^F31.11
 ;;^UTILITY(U,$J,358.3,25884,2)
 ;;=^5003496
 ;;^UTILITY(U,$J,358.3,25885,0)
 ;;=F31.12^^98^1211^7
 ;;^UTILITY(U,$J,358.3,25885,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25885,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,Moderate
 ;;^UTILITY(U,$J,358.3,25885,1,4,0)
 ;;=4^F31.12
 ;;^UTILITY(U,$J,358.3,25885,2)
 ;;=^5003497
 ;;^UTILITY(U,$J,358.3,25886,0)
 ;;=F31.13^^98^1211^8
 ;;^UTILITY(U,$J,358.3,25886,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25886,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,Severe
 ;;^UTILITY(U,$J,358.3,25886,1,4,0)
 ;;=4^F31.13
 ;;^UTILITY(U,$J,358.3,25886,2)
 ;;=^5003498
 ;;^UTILITY(U,$J,358.3,25887,0)
 ;;=F31.2^^98^1211^9
 ;;^UTILITY(U,$J,358.3,25887,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25887,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,w/ Psychotic Features
 ;;^UTILITY(U,$J,358.3,25887,1,4,0)
 ;;=4^F31.2
 ;;^UTILITY(U,$J,358.3,25887,2)
 ;;=^5003499
 ;;^UTILITY(U,$J,358.3,25888,0)
 ;;=F31.73^^98^1211^10
 ;;^UTILITY(U,$J,358.3,25888,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25888,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,In Partial Remission
 ;;^UTILITY(U,$J,358.3,25888,1,4,0)
 ;;=4^F31.73
 ;;^UTILITY(U,$J,358.3,25888,2)
 ;;=^5003513
 ;;^UTILITY(U,$J,358.3,25889,0)
 ;;=F31.74^^98^1211^11
 ;;^UTILITY(U,$J,358.3,25889,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25889,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,In Full Remission
 ;;^UTILITY(U,$J,358.3,25889,1,4,0)
 ;;=4^F31.74
 ;;^UTILITY(U,$J,358.3,25889,2)
 ;;=^5003514
 ;;^UTILITY(U,$J,358.3,25890,0)
 ;;=F31.30^^98^1211^12

IBDEI01E ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,153,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,153,1,3,0)
 ;;=3^Phobia,Oth Specified
 ;;^UTILITY(U,$J,358.3,153,1,4,0)
 ;;=4^F40.298
 ;;^UTILITY(U,$J,358.3,153,2)
 ;;=^5003561
 ;;^UTILITY(U,$J,358.3,154,0)
 ;;=F93.0^^3^24^17
 ;;^UTILITY(U,$J,358.3,154,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,154,1,3,0)
 ;;=3^Separation Anxiety Disorder
 ;;^UTILITY(U,$J,358.3,154,1,4,0)
 ;;=4^F93.0
 ;;^UTILITY(U,$J,358.3,154,2)
 ;;=^5003702
 ;;^UTILITY(U,$J,358.3,155,0)
 ;;=F41.8^^3^24^7
 ;;^UTILITY(U,$J,358.3,155,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,155,1,3,0)
 ;;=3^Anxiety Disorder,Oth Specified
 ;;^UTILITY(U,$J,358.3,155,1,4,0)
 ;;=4^F41.8
 ;;^UTILITY(U,$J,358.3,155,2)
 ;;=^5003566
 ;;^UTILITY(U,$J,358.3,156,0)
 ;;=F06.33^^3^25^1
 ;;^UTILITY(U,$J,358.3,156,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,156,1,3,0)
 ;;=3^Bipolar & Related Disorder d/t Medical Condition w/ Manic Features
 ;;^UTILITY(U,$J,358.3,156,1,4,0)
 ;;=4^F06.33
 ;;^UTILITY(U,$J,358.3,156,2)
 ;;=^5003059
 ;;^UTILITY(U,$J,358.3,157,0)
 ;;=F06.34^^3^25^2
 ;;^UTILITY(U,$J,358.3,157,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,157,1,3,0)
 ;;=3^Bipolar & Related Disorder d/t Medical Condition w/ Mixed Features
 ;;^UTILITY(U,$J,358.3,157,1,4,0)
 ;;=4^F06.34
 ;;^UTILITY(U,$J,358.3,157,2)
 ;;=^5003060
 ;;^UTILITY(U,$J,358.3,158,0)
 ;;=F31.11^^3^25^6
 ;;^UTILITY(U,$J,358.3,158,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,158,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,Mild
 ;;^UTILITY(U,$J,358.3,158,1,4,0)
 ;;=4^F31.11
 ;;^UTILITY(U,$J,358.3,158,2)
 ;;=^5003496
 ;;^UTILITY(U,$J,358.3,159,0)
 ;;=F31.12^^3^25^7
 ;;^UTILITY(U,$J,358.3,159,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,159,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,Moderate
 ;;^UTILITY(U,$J,358.3,159,1,4,0)
 ;;=4^F31.12
 ;;^UTILITY(U,$J,358.3,159,2)
 ;;=^5003497
 ;;^UTILITY(U,$J,358.3,160,0)
 ;;=F31.13^^3^25^8
 ;;^UTILITY(U,$J,358.3,160,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,160,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,Severe
 ;;^UTILITY(U,$J,358.3,160,1,4,0)
 ;;=4^F31.13
 ;;^UTILITY(U,$J,358.3,160,2)
 ;;=^5003498
 ;;^UTILITY(U,$J,358.3,161,0)
 ;;=F31.2^^3^25^9
 ;;^UTILITY(U,$J,358.3,161,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,161,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,w/ Psychotic Features
 ;;^UTILITY(U,$J,358.3,161,1,4,0)
 ;;=4^F31.2
 ;;^UTILITY(U,$J,358.3,161,2)
 ;;=^5003499
 ;;^UTILITY(U,$J,358.3,162,0)
 ;;=F31.73^^3^25^10
 ;;^UTILITY(U,$J,358.3,162,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,162,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,In Partial Remission
 ;;^UTILITY(U,$J,358.3,162,1,4,0)
 ;;=4^F31.73
 ;;^UTILITY(U,$J,358.3,162,2)
 ;;=^5003513
 ;;^UTILITY(U,$J,358.3,163,0)
 ;;=F31.74^^3^25^11
 ;;^UTILITY(U,$J,358.3,163,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,163,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,In Full Remission
 ;;^UTILITY(U,$J,358.3,163,1,4,0)
 ;;=4^F31.74
 ;;^UTILITY(U,$J,358.3,163,2)
 ;;=^5003514
 ;;^UTILITY(U,$J,358.3,164,0)
 ;;=F31.30^^3^25^12
 ;;^UTILITY(U,$J,358.3,164,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,164,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,Unspec
 ;;^UTILITY(U,$J,358.3,164,1,4,0)
 ;;=4^F31.30
 ;;^UTILITY(U,$J,358.3,164,2)
 ;;=^5003500
 ;;^UTILITY(U,$J,358.3,165,0)
 ;;=F31.31^^3^25^13
 ;;^UTILITY(U,$J,358.3,165,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,165,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,Mild
 ;;^UTILITY(U,$J,358.3,165,1,4,0)
 ;;=4^F31.31

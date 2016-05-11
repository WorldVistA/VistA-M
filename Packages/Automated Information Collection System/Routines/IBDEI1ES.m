IBDEI1ES ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23954,2)
 ;;=^5003555
 ;;^UTILITY(U,$J,358.3,23955,0)
 ;;=F40.248^^90^1036^18
 ;;^UTILITY(U,$J,358.3,23955,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23955,1,3,0)
 ;;=3^Situational Type Phobia NEC
 ;;^UTILITY(U,$J,358.3,23955,1,4,0)
 ;;=4^F40.248
 ;;^UTILITY(U,$J,358.3,23955,2)
 ;;=^5003558
 ;;^UTILITY(U,$J,358.3,23956,0)
 ;;=F40.01^^90^1036^3
 ;;^UTILITY(U,$J,358.3,23956,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23956,1,3,0)
 ;;=3^Agoraphobia w/ Panic Disorder
 ;;^UTILITY(U,$J,358.3,23956,1,4,0)
 ;;=4^F40.01
 ;;^UTILITY(U,$J,358.3,23956,2)
 ;;=^331911
 ;;^UTILITY(U,$J,358.3,23957,0)
 ;;=F40.298^^90^1036^16
 ;;^UTILITY(U,$J,358.3,23957,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23957,1,3,0)
 ;;=3^Phobia,Oth Specified
 ;;^UTILITY(U,$J,358.3,23957,1,4,0)
 ;;=4^F40.298
 ;;^UTILITY(U,$J,358.3,23957,2)
 ;;=^5003561
 ;;^UTILITY(U,$J,358.3,23958,0)
 ;;=F93.0^^90^1036^17
 ;;^UTILITY(U,$J,358.3,23958,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23958,1,3,0)
 ;;=3^Separation Anxiety Disorder
 ;;^UTILITY(U,$J,358.3,23958,1,4,0)
 ;;=4^F93.0
 ;;^UTILITY(U,$J,358.3,23958,2)
 ;;=^5003702
 ;;^UTILITY(U,$J,358.3,23959,0)
 ;;=F41.8^^90^1036^7
 ;;^UTILITY(U,$J,358.3,23959,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23959,1,3,0)
 ;;=3^Anxiety Disorder,Oth Specified
 ;;^UTILITY(U,$J,358.3,23959,1,4,0)
 ;;=4^F41.8
 ;;^UTILITY(U,$J,358.3,23959,2)
 ;;=^5003566
 ;;^UTILITY(U,$J,358.3,23960,0)
 ;;=F06.33^^90^1037^1
 ;;^UTILITY(U,$J,358.3,23960,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23960,1,3,0)
 ;;=3^Bipolar & Related Disorder d/t Medical Condition w/ Manic Features
 ;;^UTILITY(U,$J,358.3,23960,1,4,0)
 ;;=4^F06.33
 ;;^UTILITY(U,$J,358.3,23960,2)
 ;;=^5003059
 ;;^UTILITY(U,$J,358.3,23961,0)
 ;;=F06.34^^90^1037^2
 ;;^UTILITY(U,$J,358.3,23961,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23961,1,3,0)
 ;;=3^Bipolar & Related Disorder d/t Medical Condition w/ Mixed Features
 ;;^UTILITY(U,$J,358.3,23961,1,4,0)
 ;;=4^F06.34
 ;;^UTILITY(U,$J,358.3,23961,2)
 ;;=^5003060
 ;;^UTILITY(U,$J,358.3,23962,0)
 ;;=F31.11^^90^1037^6
 ;;^UTILITY(U,$J,358.3,23962,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23962,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,Mild
 ;;^UTILITY(U,$J,358.3,23962,1,4,0)
 ;;=4^F31.11
 ;;^UTILITY(U,$J,358.3,23962,2)
 ;;=^5003496
 ;;^UTILITY(U,$J,358.3,23963,0)
 ;;=F31.12^^90^1037^7
 ;;^UTILITY(U,$J,358.3,23963,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23963,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,Moderate
 ;;^UTILITY(U,$J,358.3,23963,1,4,0)
 ;;=4^F31.12
 ;;^UTILITY(U,$J,358.3,23963,2)
 ;;=^5003497
 ;;^UTILITY(U,$J,358.3,23964,0)
 ;;=F31.13^^90^1037^8
 ;;^UTILITY(U,$J,358.3,23964,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23964,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,Severe
 ;;^UTILITY(U,$J,358.3,23964,1,4,0)
 ;;=4^F31.13
 ;;^UTILITY(U,$J,358.3,23964,2)
 ;;=^5003498
 ;;^UTILITY(U,$J,358.3,23965,0)
 ;;=F31.2^^90^1037^9
 ;;^UTILITY(U,$J,358.3,23965,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23965,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,w/ Psychotic Features
 ;;^UTILITY(U,$J,358.3,23965,1,4,0)
 ;;=4^F31.2
 ;;^UTILITY(U,$J,358.3,23965,2)
 ;;=^5003499
 ;;^UTILITY(U,$J,358.3,23966,0)
 ;;=F31.73^^90^1037^10
 ;;^UTILITY(U,$J,358.3,23966,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23966,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,In Partial Remission
 ;;^UTILITY(U,$J,358.3,23966,1,4,0)
 ;;=4^F31.73
 ;;^UTILITY(U,$J,358.3,23966,2)
 ;;=^5003513
 ;;^UTILITY(U,$J,358.3,23967,0)
 ;;=F31.74^^90^1037^11

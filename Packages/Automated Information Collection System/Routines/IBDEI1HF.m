IBDEI1HF ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25160,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25160,1,3,0)
 ;;=3^Acrophobia
 ;;^UTILITY(U,$J,358.3,25160,1,4,0)
 ;;=4^F40.241
 ;;^UTILITY(U,$J,358.3,25160,2)
 ;;=^5003555
 ;;^UTILITY(U,$J,358.3,25161,0)
 ;;=F40.248^^95^1140^18
 ;;^UTILITY(U,$J,358.3,25161,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25161,1,3,0)
 ;;=3^Situational Type Phobia NEC
 ;;^UTILITY(U,$J,358.3,25161,1,4,0)
 ;;=4^F40.248
 ;;^UTILITY(U,$J,358.3,25161,2)
 ;;=^5003558
 ;;^UTILITY(U,$J,358.3,25162,0)
 ;;=F40.01^^95^1140^3
 ;;^UTILITY(U,$J,358.3,25162,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25162,1,3,0)
 ;;=3^Agoraphobia w/ Panic Disorder
 ;;^UTILITY(U,$J,358.3,25162,1,4,0)
 ;;=4^F40.01
 ;;^UTILITY(U,$J,358.3,25162,2)
 ;;=^331911
 ;;^UTILITY(U,$J,358.3,25163,0)
 ;;=F40.298^^95^1140^16
 ;;^UTILITY(U,$J,358.3,25163,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25163,1,3,0)
 ;;=3^Phobia,Oth Specified
 ;;^UTILITY(U,$J,358.3,25163,1,4,0)
 ;;=4^F40.298
 ;;^UTILITY(U,$J,358.3,25163,2)
 ;;=^5003561
 ;;^UTILITY(U,$J,358.3,25164,0)
 ;;=F93.0^^95^1140^17
 ;;^UTILITY(U,$J,358.3,25164,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25164,1,3,0)
 ;;=3^Separation Anxiety Disorder
 ;;^UTILITY(U,$J,358.3,25164,1,4,0)
 ;;=4^F93.0
 ;;^UTILITY(U,$J,358.3,25164,2)
 ;;=^5003702
 ;;^UTILITY(U,$J,358.3,25165,0)
 ;;=F41.8^^95^1140^7
 ;;^UTILITY(U,$J,358.3,25165,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25165,1,3,0)
 ;;=3^Anxiety Disorder,Oth Specified
 ;;^UTILITY(U,$J,358.3,25165,1,4,0)
 ;;=4^F41.8
 ;;^UTILITY(U,$J,358.3,25165,2)
 ;;=^5003566
 ;;^UTILITY(U,$J,358.3,25166,0)
 ;;=F06.33^^95^1141^1
 ;;^UTILITY(U,$J,358.3,25166,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25166,1,3,0)
 ;;=3^Bipolar & Related Disorder d/t Medical Condition w/ Manic Features
 ;;^UTILITY(U,$J,358.3,25166,1,4,0)
 ;;=4^F06.33
 ;;^UTILITY(U,$J,358.3,25166,2)
 ;;=^5003059
 ;;^UTILITY(U,$J,358.3,25167,0)
 ;;=F06.34^^95^1141^2
 ;;^UTILITY(U,$J,358.3,25167,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25167,1,3,0)
 ;;=3^Bipolar & Related Disorder d/t Medical Condition w/ Mixed Features
 ;;^UTILITY(U,$J,358.3,25167,1,4,0)
 ;;=4^F06.34
 ;;^UTILITY(U,$J,358.3,25167,2)
 ;;=^5003060
 ;;^UTILITY(U,$J,358.3,25168,0)
 ;;=F31.11^^95^1141^6
 ;;^UTILITY(U,$J,358.3,25168,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25168,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,Mild
 ;;^UTILITY(U,$J,358.3,25168,1,4,0)
 ;;=4^F31.11
 ;;^UTILITY(U,$J,358.3,25168,2)
 ;;=^5003496
 ;;^UTILITY(U,$J,358.3,25169,0)
 ;;=F31.12^^95^1141^7
 ;;^UTILITY(U,$J,358.3,25169,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25169,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,Moderate
 ;;^UTILITY(U,$J,358.3,25169,1,4,0)
 ;;=4^F31.12
 ;;^UTILITY(U,$J,358.3,25169,2)
 ;;=^5003497
 ;;^UTILITY(U,$J,358.3,25170,0)
 ;;=F31.13^^95^1141^8
 ;;^UTILITY(U,$J,358.3,25170,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25170,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,Severe
 ;;^UTILITY(U,$J,358.3,25170,1,4,0)
 ;;=4^F31.13
 ;;^UTILITY(U,$J,358.3,25170,2)
 ;;=^5003498
 ;;^UTILITY(U,$J,358.3,25171,0)
 ;;=F31.2^^95^1141^9
 ;;^UTILITY(U,$J,358.3,25171,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25171,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,w/ Psychotic Features
 ;;^UTILITY(U,$J,358.3,25171,1,4,0)
 ;;=4^F31.2
 ;;^UTILITY(U,$J,358.3,25171,2)
 ;;=^5003499
 ;;^UTILITY(U,$J,358.3,25172,0)
 ;;=F31.73^^95^1141^10
 ;;^UTILITY(U,$J,358.3,25172,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25172,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,In Partial Remission

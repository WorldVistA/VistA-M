IBDEI0Q5 ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,26299,0)
 ;;=F40.232^^100^1264^9
 ;;^UTILITY(U,$J,358.3,26299,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26299,1,3,0)
 ;;=3^Fear of Other Medical Care
 ;;^UTILITY(U,$J,358.3,26299,1,4,0)
 ;;=4^F40.232
 ;;^UTILITY(U,$J,358.3,26299,2)
 ;;=^5003552
 ;;^UTILITY(U,$J,358.3,26300,0)
 ;;=F40.233^^100^1264^8
 ;;^UTILITY(U,$J,358.3,26300,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26300,1,3,0)
 ;;=3^Fear of Injury
 ;;^UTILITY(U,$J,358.3,26300,1,4,0)
 ;;=4^F40.233
 ;;^UTILITY(U,$J,358.3,26300,2)
 ;;=^5003553
 ;;^UTILITY(U,$J,358.3,26301,0)
 ;;=F40.248^^100^1264^16
 ;;^UTILITY(U,$J,358.3,26301,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26301,1,3,0)
 ;;=3^Situational Phobia 
 ;;^UTILITY(U,$J,358.3,26301,1,4,0)
 ;;=4^F40.248
 ;;^UTILITY(U,$J,358.3,26301,2)
 ;;=^5003558
 ;;^UTILITY(U,$J,358.3,26302,0)
 ;;=F93.0^^100^1264^15
 ;;^UTILITY(U,$J,358.3,26302,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26302,1,3,0)
 ;;=3^Separation Anxiety Disorder
 ;;^UTILITY(U,$J,358.3,26302,1,4,0)
 ;;=4^F93.0
 ;;^UTILITY(U,$J,358.3,26302,2)
 ;;=^5003702
 ;;^UTILITY(U,$J,358.3,26303,0)
 ;;=F40.00^^100^1264^1
 ;;^UTILITY(U,$J,358.3,26303,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26303,1,3,0)
 ;;=3^Agoraphobia,Unsp
 ;;^UTILITY(U,$J,358.3,26303,1,4,0)
 ;;=4^F40.00
 ;;^UTILITY(U,$J,358.3,26303,2)
 ;;=^5003542
 ;;^UTILITY(U,$J,358.3,26304,0)
 ;;=F41.8^^100^1264^4
 ;;^UTILITY(U,$J,358.3,26304,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26304,1,3,0)
 ;;=3^Anxiety Disorder,Other Specified
 ;;^UTILITY(U,$J,358.3,26304,1,4,0)
 ;;=4^F41.8
 ;;^UTILITY(U,$J,358.3,26304,2)
 ;;=^5003566
 ;;^UTILITY(U,$J,358.3,26305,0)
 ;;=F40.298^^100^1264^13
 ;;^UTILITY(U,$J,358.3,26305,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26305,1,3,0)
 ;;=3^Phobia,Other Specified
 ;;^UTILITY(U,$J,358.3,26305,1,4,0)
 ;;=4^F40.298
 ;;^UTILITY(U,$J,358.3,26305,2)
 ;;=^5003561
 ;;^UTILITY(U,$J,358.3,26306,0)
 ;;=F41.9^^100^1264^5
 ;;^UTILITY(U,$J,358.3,26306,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26306,1,3,0)
 ;;=3^Anxiety Disorder,Unsp
 ;;^UTILITY(U,$J,358.3,26306,1,4,0)
 ;;=4^F41.9
 ;;^UTILITY(U,$J,358.3,26306,2)
 ;;=^5003567
 ;;^UTILITY(U,$J,358.3,26307,0)
 ;;=F94.0^^100^1264^14
 ;;^UTILITY(U,$J,358.3,26307,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26307,1,3,0)
 ;;=3^Selective Mutism
 ;;^UTILITY(U,$J,358.3,26307,1,4,0)
 ;;=4^F94.0
 ;;^UTILITY(U,$J,358.3,26307,2)
 ;;=^331954
 ;;^UTILITY(U,$J,358.3,26308,0)
 ;;=F06.33^^100^1265^1
 ;;^UTILITY(U,$J,358.3,26308,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26308,1,3,0)
 ;;=3^Bipolar & Related Disorder d/t Med Cond w/ Manic Features
 ;;^UTILITY(U,$J,358.3,26308,1,4,0)
 ;;=4^F06.33
 ;;^UTILITY(U,$J,358.3,26308,2)
 ;;=^5003059
 ;;^UTILITY(U,$J,358.3,26309,0)
 ;;=F06.34^^100^1265^2
 ;;^UTILITY(U,$J,358.3,26309,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26309,1,3,0)
 ;;=3^Bipolar & Related Disorder d/t Med Cond w/ Mixed Features
 ;;^UTILITY(U,$J,358.3,26309,1,4,0)
 ;;=4^F06.34
 ;;^UTILITY(U,$J,358.3,26309,2)
 ;;=^5003060
 ;;^UTILITY(U,$J,358.3,26310,0)
 ;;=F31.11^^100^1265^6
 ;;^UTILITY(U,$J,358.3,26310,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26310,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,Mild
 ;;^UTILITY(U,$J,358.3,26310,1,4,0)
 ;;=4^F31.11
 ;;^UTILITY(U,$J,358.3,26310,2)
 ;;=^5003496
 ;;^UTILITY(U,$J,358.3,26311,0)
 ;;=F31.12^^100^1265^7
 ;;^UTILITY(U,$J,358.3,26311,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26311,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,Moderate
 ;;^UTILITY(U,$J,358.3,26311,1,4,0)
 ;;=4^F31.12
 ;;^UTILITY(U,$J,358.3,26311,2)
 ;;=^5003497
 ;;^UTILITY(U,$J,358.3,26312,0)
 ;;=F31.13^^100^1265^8
 ;;^UTILITY(U,$J,358.3,26312,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26312,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,Severe
 ;;^UTILITY(U,$J,358.3,26312,1,4,0)
 ;;=4^F31.13
 ;;^UTILITY(U,$J,358.3,26312,2)
 ;;=^5003498
 ;;^UTILITY(U,$J,358.3,26313,0)
 ;;=F31.2^^100^1265^9
 ;;^UTILITY(U,$J,358.3,26313,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26313,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,w/ Psychotic Features
 ;;^UTILITY(U,$J,358.3,26313,1,4,0)
 ;;=4^F31.2
 ;;^UTILITY(U,$J,358.3,26313,2)
 ;;=^5003499
 ;;^UTILITY(U,$J,358.3,26314,0)
 ;;=F31.73^^100^1265^10
 ;;^UTILITY(U,$J,358.3,26314,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26314,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,In Partial Remission
 ;;^UTILITY(U,$J,358.3,26314,1,4,0)
 ;;=4^F31.73
 ;;^UTILITY(U,$J,358.3,26314,2)
 ;;=^5003513
 ;;^UTILITY(U,$J,358.3,26315,0)
 ;;=F31.74^^100^1265^11
 ;;^UTILITY(U,$J,358.3,26315,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26315,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,In Full Remission
 ;;^UTILITY(U,$J,358.3,26315,1,4,0)
 ;;=4^F31.74
 ;;^UTILITY(U,$J,358.3,26315,2)
 ;;=^5003514
 ;;^UTILITY(U,$J,358.3,26316,0)
 ;;=F31.31^^100^1265^13
 ;;^UTILITY(U,$J,358.3,26316,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26316,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,Mild
 ;;^UTILITY(U,$J,358.3,26316,1,4,0)
 ;;=4^F31.31
 ;;^UTILITY(U,$J,358.3,26316,2)
 ;;=^5003501
 ;;^UTILITY(U,$J,358.3,26317,0)
 ;;=F31.32^^100^1265^14
 ;;^UTILITY(U,$J,358.3,26317,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26317,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,Moderate
 ;;^UTILITY(U,$J,358.3,26317,1,4,0)
 ;;=4^F31.32
 ;;^UTILITY(U,$J,358.3,26317,2)
 ;;=^5003502
 ;;^UTILITY(U,$J,358.3,26318,0)
 ;;=F31.4^^100^1265^15
 ;;^UTILITY(U,$J,358.3,26318,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26318,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,Severe
 ;;^UTILITY(U,$J,358.3,26318,1,4,0)
 ;;=4^F31.4
 ;;^UTILITY(U,$J,358.3,26318,2)
 ;;=^5003503
 ;;^UTILITY(U,$J,358.3,26319,0)
 ;;=F31.5^^100^1265^16
 ;;^UTILITY(U,$J,358.3,26319,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26319,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,w/ Psychotic Features
 ;;^UTILITY(U,$J,358.3,26319,1,4,0)
 ;;=4^F31.5
 ;;^UTILITY(U,$J,358.3,26319,2)
 ;;=^5003504
 ;;^UTILITY(U,$J,358.3,26320,0)
 ;;=F31.75^^100^1265^18
 ;;^UTILITY(U,$J,358.3,26320,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26320,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,In Partial Remission
 ;;^UTILITY(U,$J,358.3,26320,1,4,0)
 ;;=4^F31.75
 ;;^UTILITY(U,$J,358.3,26320,2)
 ;;=^5003515
 ;;^UTILITY(U,$J,358.3,26321,0)
 ;;=F31.76^^100^1265^17
 ;;^UTILITY(U,$J,358.3,26321,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26321,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,In Full Remission
 ;;^UTILITY(U,$J,358.3,26321,1,4,0)
 ;;=4^F31.76
 ;;^UTILITY(U,$J,358.3,26321,2)
 ;;=^5003516
 ;;^UTILITY(U,$J,358.3,26322,0)
 ;;=F31.81^^100^1265^23
 ;;^UTILITY(U,$J,358.3,26322,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26322,1,3,0)
 ;;=3^Bipolar II Disorder
 ;;^UTILITY(U,$J,358.3,26322,1,4,0)
 ;;=4^F31.81
 ;;^UTILITY(U,$J,358.3,26322,2)
 ;;=^5003519
 ;;^UTILITY(U,$J,358.3,26323,0)
 ;;=F34.0^^100^1265^24
 ;;^UTILITY(U,$J,358.3,26323,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26323,1,3,0)
 ;;=3^Cyclothymic Disorder
 ;;^UTILITY(U,$J,358.3,26323,1,4,0)
 ;;=4^F34.0
 ;;^UTILITY(U,$J,358.3,26323,2)
 ;;=^5003538
 ;;^UTILITY(U,$J,358.3,26324,0)
 ;;=F31.0^^100^1265^20
 ;;^UTILITY(U,$J,358.3,26324,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26324,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Hypomanic
 ;;^UTILITY(U,$J,358.3,26324,1,4,0)
 ;;=4^F31.0
 ;;^UTILITY(U,$J,358.3,26324,2)
 ;;=^5003494
 ;;^UTILITY(U,$J,358.3,26325,0)
 ;;=F31.71^^100^1265^22
 ;;^UTILITY(U,$J,358.3,26325,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26325,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Hypomanic,In Partial Remission

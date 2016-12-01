IBDEI0KC ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25751,1,4,0)
 ;;=4^Z62.810
 ;;^UTILITY(U,$J,358.3,25751,2)
 ;;=^5063153
 ;;^UTILITY(U,$J,358.3,25752,0)
 ;;=Z62.810^^69^1060^39
 ;;^UTILITY(U,$J,358.3,25752,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25752,1,3,0)
 ;;=3^Personal Past Hx of Childhood Sexual Abuse
 ;;^UTILITY(U,$J,358.3,25752,1,4,0)
 ;;=4^Z62.810
 ;;^UTILITY(U,$J,358.3,25752,2)
 ;;=^5063153
 ;;^UTILITY(U,$J,358.3,25753,0)
 ;;=Z62.811^^69^1060^38
 ;;^UTILITY(U,$J,358.3,25753,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25753,1,3,0)
 ;;=3^Personal Past Hx of Childhood Psychological Abuse
 ;;^UTILITY(U,$J,358.3,25753,1,4,0)
 ;;=4^Z62.811
 ;;^UTILITY(U,$J,358.3,25753,2)
 ;;=^5063154
 ;;^UTILITY(U,$J,358.3,25754,0)
 ;;=Z91.410^^69^1060^42
 ;;^UTILITY(U,$J,358.3,25754,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25754,1,3,0)
 ;;=3^Personal Past Hx of Spouse or Partner Violence,Sexual
 ;;^UTILITY(U,$J,358.3,25754,1,4,0)
 ;;=4^Z91.410
 ;;^UTILITY(U,$J,358.3,25754,2)
 ;;=^5063619
 ;;^UTILITY(U,$J,358.3,25755,0)
 ;;=F06.4^^69^1061^3
 ;;^UTILITY(U,$J,358.3,25755,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25755,1,3,0)
 ;;=3^Anxiety Disorder d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,25755,1,4,0)
 ;;=4^F06.4
 ;;^UTILITY(U,$J,358.3,25755,2)
 ;;=^5003061
 ;;^UTILITY(U,$J,358.3,25756,0)
 ;;=F41.0^^69^1061^12
 ;;^UTILITY(U,$J,358.3,25756,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25756,1,3,0)
 ;;=3^Panic Disorder
 ;;^UTILITY(U,$J,358.3,25756,1,4,0)
 ;;=4^F41.0
 ;;^UTILITY(U,$J,358.3,25756,2)
 ;;=^5003564
 ;;^UTILITY(U,$J,358.3,25757,0)
 ;;=F41.1^^69^1061^10
 ;;^UTILITY(U,$J,358.3,25757,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25757,1,3,0)
 ;;=3^Generalized Anxiety Disorder
 ;;^UTILITY(U,$J,358.3,25757,1,4,0)
 ;;=4^F41.1
 ;;^UTILITY(U,$J,358.3,25757,2)
 ;;=^50059
 ;;^UTILITY(U,$J,358.3,25758,0)
 ;;=F40.10^^69^1061^17
 ;;^UTILITY(U,$J,358.3,25758,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25758,1,3,0)
 ;;=3^Social Anxiety Disorder (Social Phobia)
 ;;^UTILITY(U,$J,358.3,25758,1,4,0)
 ;;=4^F40.10
 ;;^UTILITY(U,$J,358.3,25758,2)
 ;;=^5003544
 ;;^UTILITY(U,$J,358.3,25759,0)
 ;;=F40.218^^69^1061^2
 ;;^UTILITY(U,$J,358.3,25759,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25759,1,3,0)
 ;;=3^Animal Phobia
 ;;^UTILITY(U,$J,358.3,25759,1,4,0)
 ;;=4^F40.218
 ;;^UTILITY(U,$J,358.3,25759,2)
 ;;=^5003547
 ;;^UTILITY(U,$J,358.3,25760,0)
 ;;=F40.228^^69^1061^11
 ;;^UTILITY(U,$J,358.3,25760,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25760,1,3,0)
 ;;=3^Natural Environment Phobia
 ;;^UTILITY(U,$J,358.3,25760,1,4,0)
 ;;=4^F40.228
 ;;^UTILITY(U,$J,358.3,25760,2)
 ;;=^5003549
 ;;^UTILITY(U,$J,358.3,25761,0)
 ;;=F40.230^^69^1061^6
 ;;^UTILITY(U,$J,358.3,25761,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25761,1,3,0)
 ;;=3^Fear of Blood
 ;;^UTILITY(U,$J,358.3,25761,1,4,0)
 ;;=4^F40.230
 ;;^UTILITY(U,$J,358.3,25761,2)
 ;;=^5003550
 ;;^UTILITY(U,$J,358.3,25762,0)
 ;;=F40.231^^69^1061^7
 ;;^UTILITY(U,$J,358.3,25762,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25762,1,3,0)
 ;;=3^Fear of Injections & Transfusions
 ;;^UTILITY(U,$J,358.3,25762,1,4,0)
 ;;=4^F40.231
 ;;^UTILITY(U,$J,358.3,25762,2)
 ;;=^5003551
 ;;^UTILITY(U,$J,358.3,25763,0)
 ;;=F40.232^^69^1061^9
 ;;^UTILITY(U,$J,358.3,25763,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25763,1,3,0)
 ;;=3^Fear of Other Medical Care
 ;;^UTILITY(U,$J,358.3,25763,1,4,0)
 ;;=4^F40.232
 ;;^UTILITY(U,$J,358.3,25763,2)
 ;;=^5003552
 ;;^UTILITY(U,$J,358.3,25764,0)
 ;;=F40.233^^69^1061^8
 ;;^UTILITY(U,$J,358.3,25764,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25764,1,3,0)
 ;;=3^Fear of Injury
 ;;^UTILITY(U,$J,358.3,25764,1,4,0)
 ;;=4^F40.233
 ;;^UTILITY(U,$J,358.3,25764,2)
 ;;=^5003553
 ;;^UTILITY(U,$J,358.3,25765,0)
 ;;=F40.248^^69^1061^16
 ;;^UTILITY(U,$J,358.3,25765,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25765,1,3,0)
 ;;=3^Situational Phobia 
 ;;^UTILITY(U,$J,358.3,25765,1,4,0)
 ;;=4^F40.248
 ;;^UTILITY(U,$J,358.3,25765,2)
 ;;=^5003558
 ;;^UTILITY(U,$J,358.3,25766,0)
 ;;=F93.0^^69^1061^15
 ;;^UTILITY(U,$J,358.3,25766,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25766,1,3,0)
 ;;=3^Separation Anxiety Disorder
 ;;^UTILITY(U,$J,358.3,25766,1,4,0)
 ;;=4^F93.0
 ;;^UTILITY(U,$J,358.3,25766,2)
 ;;=^5003702
 ;;^UTILITY(U,$J,358.3,25767,0)
 ;;=F40.00^^69^1061^1
 ;;^UTILITY(U,$J,358.3,25767,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25767,1,3,0)
 ;;=3^Agoraphobia,Unsp
 ;;^UTILITY(U,$J,358.3,25767,1,4,0)
 ;;=4^F40.00
 ;;^UTILITY(U,$J,358.3,25767,2)
 ;;=^5003542
 ;;^UTILITY(U,$J,358.3,25768,0)
 ;;=F41.8^^69^1061^4
 ;;^UTILITY(U,$J,358.3,25768,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25768,1,3,0)
 ;;=3^Anxiety Disorder,Other Specified
 ;;^UTILITY(U,$J,358.3,25768,1,4,0)
 ;;=4^F41.8
 ;;^UTILITY(U,$J,358.3,25768,2)
 ;;=^5003566
 ;;^UTILITY(U,$J,358.3,25769,0)
 ;;=F40.298^^69^1061^13
 ;;^UTILITY(U,$J,358.3,25769,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25769,1,3,0)
 ;;=3^Phobia,Other Specified
 ;;^UTILITY(U,$J,358.3,25769,1,4,0)
 ;;=4^F40.298
 ;;^UTILITY(U,$J,358.3,25769,2)
 ;;=^5003561
 ;;^UTILITY(U,$J,358.3,25770,0)
 ;;=F41.9^^69^1061^5
 ;;^UTILITY(U,$J,358.3,25770,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25770,1,3,0)
 ;;=3^Anxiety Disorder,Unsp
 ;;^UTILITY(U,$J,358.3,25770,1,4,0)
 ;;=4^F41.9
 ;;^UTILITY(U,$J,358.3,25770,2)
 ;;=^5003567
 ;;^UTILITY(U,$J,358.3,25771,0)
 ;;=F94.0^^69^1061^14
 ;;^UTILITY(U,$J,358.3,25771,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25771,1,3,0)
 ;;=3^Selective Mutism
 ;;^UTILITY(U,$J,358.3,25771,1,4,0)
 ;;=4^F94.0
 ;;^UTILITY(U,$J,358.3,25771,2)
 ;;=^331954
 ;;^UTILITY(U,$J,358.3,25772,0)
 ;;=F06.33^^69^1062^1
 ;;^UTILITY(U,$J,358.3,25772,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25772,1,3,0)
 ;;=3^Bipolar & Related Disorder d/t Med Cond w/ Manic Features
 ;;^UTILITY(U,$J,358.3,25772,1,4,0)
 ;;=4^F06.33
 ;;^UTILITY(U,$J,358.3,25772,2)
 ;;=^5003059
 ;;^UTILITY(U,$J,358.3,25773,0)
 ;;=F06.34^^69^1062^2
 ;;^UTILITY(U,$J,358.3,25773,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25773,1,3,0)
 ;;=3^Bipolar & Related Disorder d/t Med Cond w/ Mixed Features
 ;;^UTILITY(U,$J,358.3,25773,1,4,0)
 ;;=4^F06.34
 ;;^UTILITY(U,$J,358.3,25773,2)
 ;;=^5003060
 ;;^UTILITY(U,$J,358.3,25774,0)
 ;;=F31.11^^69^1062^6
 ;;^UTILITY(U,$J,358.3,25774,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25774,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,Mild
 ;;^UTILITY(U,$J,358.3,25774,1,4,0)
 ;;=4^F31.11
 ;;^UTILITY(U,$J,358.3,25774,2)
 ;;=^5003496
 ;;^UTILITY(U,$J,358.3,25775,0)
 ;;=F31.12^^69^1062^7
 ;;^UTILITY(U,$J,358.3,25775,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25775,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,Moderate
 ;;^UTILITY(U,$J,358.3,25775,1,4,0)
 ;;=4^F31.12
 ;;^UTILITY(U,$J,358.3,25775,2)
 ;;=^5003497
 ;;^UTILITY(U,$J,358.3,25776,0)
 ;;=F31.13^^69^1062^8
 ;;^UTILITY(U,$J,358.3,25776,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25776,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,Severe
 ;;^UTILITY(U,$J,358.3,25776,1,4,0)
 ;;=4^F31.13
 ;;^UTILITY(U,$J,358.3,25776,2)
 ;;=^5003498
 ;;^UTILITY(U,$J,358.3,25777,0)
 ;;=F31.2^^69^1062^9
 ;;^UTILITY(U,$J,358.3,25777,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25777,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,w/ Psychotic Features
 ;;^UTILITY(U,$J,358.3,25777,1,4,0)
 ;;=4^F31.2
 ;;^UTILITY(U,$J,358.3,25777,2)
 ;;=^5003499
 ;;^UTILITY(U,$J,358.3,25778,0)
 ;;=F31.73^^69^1062^10
 ;;^UTILITY(U,$J,358.3,25778,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25778,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,In Partial Remission
 ;;^UTILITY(U,$J,358.3,25778,1,4,0)
 ;;=4^F31.73
 ;;^UTILITY(U,$J,358.3,25778,2)
 ;;=^5003513
 ;;^UTILITY(U,$J,358.3,25779,0)
 ;;=F31.74^^69^1062^11
 ;;^UTILITY(U,$J,358.3,25779,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25779,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,In Full Remission
 ;;^UTILITY(U,$J,358.3,25779,1,4,0)
 ;;=4^F31.74
 ;;^UTILITY(U,$J,358.3,25779,2)
 ;;=^5003514
 ;;^UTILITY(U,$J,358.3,25780,0)
 ;;=F31.31^^69^1062^13
 ;;^UTILITY(U,$J,358.3,25780,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25780,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,Mild
 ;;^UTILITY(U,$J,358.3,25780,1,4,0)
 ;;=4^F31.31
 ;;^UTILITY(U,$J,358.3,25780,2)
 ;;=^5003501
 ;;^UTILITY(U,$J,358.3,25781,0)
 ;;=F31.32^^69^1062^14
 ;;^UTILITY(U,$J,358.3,25781,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25781,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,Moderate
 ;;^UTILITY(U,$J,358.3,25781,1,4,0)
 ;;=4^F31.32
 ;;^UTILITY(U,$J,358.3,25781,2)
 ;;=^5003502
 ;;^UTILITY(U,$J,358.3,25782,0)
 ;;=F31.4^^69^1062^15
 ;;^UTILITY(U,$J,358.3,25782,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25782,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,Severe
 ;;^UTILITY(U,$J,358.3,25782,1,4,0)
 ;;=4^F31.4
 ;;^UTILITY(U,$J,358.3,25782,2)
 ;;=^5003503
 ;;^UTILITY(U,$J,358.3,25783,0)
 ;;=F31.5^^69^1062^16
 ;;^UTILITY(U,$J,358.3,25783,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25783,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,w/ Psychotic Features
 ;;^UTILITY(U,$J,358.3,25783,1,4,0)
 ;;=4^F31.5
 ;;^UTILITY(U,$J,358.3,25783,2)
 ;;=^5003504
 ;;^UTILITY(U,$J,358.3,25784,0)
 ;;=F31.75^^69^1062^18
 ;;^UTILITY(U,$J,358.3,25784,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25784,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,In Partial Remission
 ;;^UTILITY(U,$J,358.3,25784,1,4,0)
 ;;=4^F31.75
 ;;^UTILITY(U,$J,358.3,25784,2)
 ;;=^5003515
 ;;^UTILITY(U,$J,358.3,25785,0)
 ;;=F31.76^^69^1062^17
 ;;^UTILITY(U,$J,358.3,25785,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25785,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,In Full Remission
 ;;^UTILITY(U,$J,358.3,25785,1,4,0)
 ;;=4^F31.76
 ;;^UTILITY(U,$J,358.3,25785,2)
 ;;=^5003516

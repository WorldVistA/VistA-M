IBDEI00K ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,167,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,167,1,3,0)
 ;;=3^Personal Past Hx of Spouse or Partner Violence,Sexual
 ;;^UTILITY(U,$J,358.3,167,1,4,0)
 ;;=4^Z91.410
 ;;^UTILITY(U,$J,358.3,167,2)
 ;;=^5063619
 ;;^UTILITY(U,$J,358.3,168,0)
 ;;=F06.4^^3^24^3
 ;;^UTILITY(U,$J,358.3,168,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,168,1,3,0)
 ;;=3^Anxiety Disorder d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,168,1,4,0)
 ;;=4^F06.4
 ;;^UTILITY(U,$J,358.3,168,2)
 ;;=^5003061
 ;;^UTILITY(U,$J,358.3,169,0)
 ;;=F41.0^^3^24^12
 ;;^UTILITY(U,$J,358.3,169,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,169,1,3,0)
 ;;=3^Panic Disorder
 ;;^UTILITY(U,$J,358.3,169,1,4,0)
 ;;=4^F41.0
 ;;^UTILITY(U,$J,358.3,169,2)
 ;;=^5003564
 ;;^UTILITY(U,$J,358.3,170,0)
 ;;=F41.1^^3^24^10
 ;;^UTILITY(U,$J,358.3,170,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,170,1,3,0)
 ;;=3^Generalized Anxiety Disorder
 ;;^UTILITY(U,$J,358.3,170,1,4,0)
 ;;=4^F41.1
 ;;^UTILITY(U,$J,358.3,170,2)
 ;;=^50059
 ;;^UTILITY(U,$J,358.3,171,0)
 ;;=F40.10^^3^24^17
 ;;^UTILITY(U,$J,358.3,171,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,171,1,3,0)
 ;;=3^Social Anxiety Disorder (Social Phobia)
 ;;^UTILITY(U,$J,358.3,171,1,4,0)
 ;;=4^F40.10
 ;;^UTILITY(U,$J,358.3,171,2)
 ;;=^5003544
 ;;^UTILITY(U,$J,358.3,172,0)
 ;;=F40.218^^3^24^2
 ;;^UTILITY(U,$J,358.3,172,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,172,1,3,0)
 ;;=3^Animal Phobia
 ;;^UTILITY(U,$J,358.3,172,1,4,0)
 ;;=4^F40.218
 ;;^UTILITY(U,$J,358.3,172,2)
 ;;=^5003547
 ;;^UTILITY(U,$J,358.3,173,0)
 ;;=F40.228^^3^24^11
 ;;^UTILITY(U,$J,358.3,173,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,173,1,3,0)
 ;;=3^Natural Environment Phobia
 ;;^UTILITY(U,$J,358.3,173,1,4,0)
 ;;=4^F40.228
 ;;^UTILITY(U,$J,358.3,173,2)
 ;;=^5003549
 ;;^UTILITY(U,$J,358.3,174,0)
 ;;=F40.230^^3^24^6
 ;;^UTILITY(U,$J,358.3,174,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,174,1,3,0)
 ;;=3^Fear of Blood
 ;;^UTILITY(U,$J,358.3,174,1,4,0)
 ;;=4^F40.230
 ;;^UTILITY(U,$J,358.3,174,2)
 ;;=^5003550
 ;;^UTILITY(U,$J,358.3,175,0)
 ;;=F40.231^^3^24^7
 ;;^UTILITY(U,$J,358.3,175,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,175,1,3,0)
 ;;=3^Fear of Injections & Transfusions
 ;;^UTILITY(U,$J,358.3,175,1,4,0)
 ;;=4^F40.231
 ;;^UTILITY(U,$J,358.3,175,2)
 ;;=^5003551
 ;;^UTILITY(U,$J,358.3,176,0)
 ;;=F40.232^^3^24^9
 ;;^UTILITY(U,$J,358.3,176,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,176,1,3,0)
 ;;=3^Fear of Other Medical Care
 ;;^UTILITY(U,$J,358.3,176,1,4,0)
 ;;=4^F40.232
 ;;^UTILITY(U,$J,358.3,176,2)
 ;;=^5003552
 ;;^UTILITY(U,$J,358.3,177,0)
 ;;=F40.233^^3^24^8
 ;;^UTILITY(U,$J,358.3,177,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,177,1,3,0)
 ;;=3^Fear of Injury
 ;;^UTILITY(U,$J,358.3,177,1,4,0)
 ;;=4^F40.233
 ;;^UTILITY(U,$J,358.3,177,2)
 ;;=^5003553
 ;;^UTILITY(U,$J,358.3,178,0)
 ;;=F40.248^^3^24^16
 ;;^UTILITY(U,$J,358.3,178,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,178,1,3,0)
 ;;=3^Situational Phobia 
 ;;^UTILITY(U,$J,358.3,178,1,4,0)
 ;;=4^F40.248
 ;;^UTILITY(U,$J,358.3,178,2)
 ;;=^5003558
 ;;^UTILITY(U,$J,358.3,179,0)
 ;;=F93.0^^3^24^15
 ;;^UTILITY(U,$J,358.3,179,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,179,1,3,0)
 ;;=3^Separation Anxiety Disorder
 ;;^UTILITY(U,$J,358.3,179,1,4,0)
 ;;=4^F93.0
 ;;^UTILITY(U,$J,358.3,179,2)
 ;;=^5003702
 ;;^UTILITY(U,$J,358.3,180,0)
 ;;=F40.00^^3^24^1
 ;;^UTILITY(U,$J,358.3,180,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,180,1,3,0)
 ;;=3^Agoraphobia,Unsp
 ;;^UTILITY(U,$J,358.3,180,1,4,0)
 ;;=4^F40.00
 ;;^UTILITY(U,$J,358.3,180,2)
 ;;=^5003542
 ;;^UTILITY(U,$J,358.3,181,0)
 ;;=F41.8^^3^24^4
 ;;^UTILITY(U,$J,358.3,181,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,181,1,3,0)
 ;;=3^Anxiety Disorder,Other Specified
 ;;^UTILITY(U,$J,358.3,181,1,4,0)
 ;;=4^F41.8
 ;;^UTILITY(U,$J,358.3,181,2)
 ;;=^5003566
 ;;^UTILITY(U,$J,358.3,182,0)
 ;;=F40.298^^3^24^13
 ;;^UTILITY(U,$J,358.3,182,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,182,1,3,0)
 ;;=3^Phobia,Other Specified
 ;;^UTILITY(U,$J,358.3,182,1,4,0)
 ;;=4^F40.298
 ;;^UTILITY(U,$J,358.3,182,2)
 ;;=^5003561
 ;;^UTILITY(U,$J,358.3,183,0)
 ;;=F41.9^^3^24^5
 ;;^UTILITY(U,$J,358.3,183,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,183,1,3,0)
 ;;=3^Anxiety Disorder,Unsp
 ;;^UTILITY(U,$J,358.3,183,1,4,0)
 ;;=4^F41.9
 ;;^UTILITY(U,$J,358.3,183,2)
 ;;=^5003567
 ;;^UTILITY(U,$J,358.3,184,0)
 ;;=F94.0^^3^24^14
 ;;^UTILITY(U,$J,358.3,184,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,184,1,3,0)
 ;;=3^Selective Mutism
 ;;^UTILITY(U,$J,358.3,184,1,4,0)
 ;;=4^F94.0
 ;;^UTILITY(U,$J,358.3,184,2)
 ;;=^331954
 ;;^UTILITY(U,$J,358.3,185,0)
 ;;=F06.33^^3^25^1
 ;;^UTILITY(U,$J,358.3,185,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,185,1,3,0)
 ;;=3^Bipolar & Related Disorder d/t Med Cond w/ Manic Features
 ;;^UTILITY(U,$J,358.3,185,1,4,0)
 ;;=4^F06.33
 ;;^UTILITY(U,$J,358.3,185,2)
 ;;=^5003059
 ;;^UTILITY(U,$J,358.3,186,0)
 ;;=F06.34^^3^25^2
 ;;^UTILITY(U,$J,358.3,186,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,186,1,3,0)
 ;;=3^Bipolar & Related Disorder d/t Med Cond w/ Mixed Features
 ;;^UTILITY(U,$J,358.3,186,1,4,0)
 ;;=4^F06.34
 ;;^UTILITY(U,$J,358.3,186,2)
 ;;=^5003060
 ;;^UTILITY(U,$J,358.3,187,0)
 ;;=F31.11^^3^25^6
 ;;^UTILITY(U,$J,358.3,187,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,187,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,Mild
 ;;^UTILITY(U,$J,358.3,187,1,4,0)
 ;;=4^F31.11
 ;;^UTILITY(U,$J,358.3,187,2)
 ;;=^5003496
 ;;^UTILITY(U,$J,358.3,188,0)
 ;;=F31.12^^3^25^7
 ;;^UTILITY(U,$J,358.3,188,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,188,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,Moderate
 ;;^UTILITY(U,$J,358.3,188,1,4,0)
 ;;=4^F31.12
 ;;^UTILITY(U,$J,358.3,188,2)
 ;;=^5003497
 ;;^UTILITY(U,$J,358.3,189,0)
 ;;=F31.13^^3^25^8
 ;;^UTILITY(U,$J,358.3,189,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,189,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,Severe
 ;;^UTILITY(U,$J,358.3,189,1,4,0)
 ;;=4^F31.13
 ;;^UTILITY(U,$J,358.3,189,2)
 ;;=^5003498
 ;;^UTILITY(U,$J,358.3,190,0)
 ;;=F31.2^^3^25^9
 ;;^UTILITY(U,$J,358.3,190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,190,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,w/ Psychotic Features
 ;;^UTILITY(U,$J,358.3,190,1,4,0)
 ;;=4^F31.2
 ;;^UTILITY(U,$J,358.3,190,2)
 ;;=^5003499
 ;;^UTILITY(U,$J,358.3,191,0)
 ;;=F31.73^^3^25^10
 ;;^UTILITY(U,$J,358.3,191,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,191,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,In Partial Remission
 ;;^UTILITY(U,$J,358.3,191,1,4,0)
 ;;=4^F31.73
 ;;^UTILITY(U,$J,358.3,191,2)
 ;;=^5003513
 ;;^UTILITY(U,$J,358.3,192,0)
 ;;=F31.74^^3^25^11
 ;;^UTILITY(U,$J,358.3,192,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,192,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,In Full Remission
 ;;^UTILITY(U,$J,358.3,192,1,4,0)
 ;;=4^F31.74
 ;;^UTILITY(U,$J,358.3,192,2)
 ;;=^5003514
 ;;^UTILITY(U,$J,358.3,193,0)
 ;;=F31.31^^3^25^13
 ;;^UTILITY(U,$J,358.3,193,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,193,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,Mild
 ;;^UTILITY(U,$J,358.3,193,1,4,0)
 ;;=4^F31.31
 ;;^UTILITY(U,$J,358.3,193,2)
 ;;=^5003501
 ;;^UTILITY(U,$J,358.3,194,0)
 ;;=F31.32^^3^25^14
 ;;^UTILITY(U,$J,358.3,194,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,194,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,Moderate
 ;;^UTILITY(U,$J,358.3,194,1,4,0)
 ;;=4^F31.32
 ;;^UTILITY(U,$J,358.3,194,2)
 ;;=^5003502
 ;;^UTILITY(U,$J,358.3,195,0)
 ;;=F31.4^^3^25^15
 ;;^UTILITY(U,$J,358.3,195,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,195,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,Severe
 ;;^UTILITY(U,$J,358.3,195,1,4,0)
 ;;=4^F31.4
 ;;^UTILITY(U,$J,358.3,195,2)
 ;;=^5003503
 ;;^UTILITY(U,$J,358.3,196,0)
 ;;=F31.5^^3^25^16
 ;;^UTILITY(U,$J,358.3,196,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,196,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,w/ Psychotic Features
 ;;^UTILITY(U,$J,358.3,196,1,4,0)
 ;;=4^F31.5
 ;;^UTILITY(U,$J,358.3,196,2)
 ;;=^5003504
 ;;^UTILITY(U,$J,358.3,197,0)
 ;;=F31.75^^3^25^18
 ;;^UTILITY(U,$J,358.3,197,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,197,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,In Partial Remission
 ;;^UTILITY(U,$J,358.3,197,1,4,0)
 ;;=4^F31.75
 ;;^UTILITY(U,$J,358.3,197,2)
 ;;=^5003515
 ;;^UTILITY(U,$J,358.3,198,0)
 ;;=F31.76^^3^25^17
 ;;^UTILITY(U,$J,358.3,198,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,198,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,In Full Remission
 ;;^UTILITY(U,$J,358.3,198,1,4,0)
 ;;=4^F31.76
 ;;^UTILITY(U,$J,358.3,198,2)
 ;;=^5003516
 ;;^UTILITY(U,$J,358.3,199,0)
 ;;=F31.81^^3^25^23
 ;;^UTILITY(U,$J,358.3,199,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,199,1,3,0)
 ;;=3^Bipolar II Disorder
 ;;^UTILITY(U,$J,358.3,199,1,4,0)
 ;;=4^F31.81
 ;;^UTILITY(U,$J,358.3,199,2)
 ;;=^5003519
 ;;^UTILITY(U,$J,358.3,200,0)
 ;;=F34.0^^3^25^24
 ;;^UTILITY(U,$J,358.3,200,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,200,1,3,0)
 ;;=3^Cyclothymic Disorder
 ;;^UTILITY(U,$J,358.3,200,1,4,0)
 ;;=4^F34.0
 ;;^UTILITY(U,$J,358.3,200,2)
 ;;=^5003538
 ;;^UTILITY(U,$J,358.3,201,0)
 ;;=F31.0^^3^25^20
 ;;^UTILITY(U,$J,358.3,201,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,201,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Hypomanic
 ;;^UTILITY(U,$J,358.3,201,1,4,0)
 ;;=4^F31.0
 ;;^UTILITY(U,$J,358.3,201,2)
 ;;=^5003494
 ;;^UTILITY(U,$J,358.3,202,0)
 ;;=F31.71^^3^25^22
 ;;^UTILITY(U,$J,358.3,202,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,202,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Hypomanic,In Partial Remission
 ;;^UTILITY(U,$J,358.3,202,1,4,0)
 ;;=4^F31.71
 ;;^UTILITY(U,$J,358.3,202,2)
 ;;=^5003511
 ;;^UTILITY(U,$J,358.3,203,0)
 ;;=F31.72^^3^25^21
 ;;^UTILITY(U,$J,358.3,203,1,0)
 ;;=^358.31IA^4^2

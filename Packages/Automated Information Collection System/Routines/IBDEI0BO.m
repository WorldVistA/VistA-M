IBDEI0BO ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,14812,1,4,0)
 ;;=4^Z91.410
 ;;^UTILITY(U,$J,358.3,14812,2)
 ;;=^5063619
 ;;^UTILITY(U,$J,358.3,14813,0)
 ;;=F06.4^^45^655^3
 ;;^UTILITY(U,$J,358.3,14813,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14813,1,3,0)
 ;;=3^Anxiety Disorder d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,14813,1,4,0)
 ;;=4^F06.4
 ;;^UTILITY(U,$J,358.3,14813,2)
 ;;=^5003061
 ;;^UTILITY(U,$J,358.3,14814,0)
 ;;=F41.0^^45^655^12
 ;;^UTILITY(U,$J,358.3,14814,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14814,1,3,0)
 ;;=3^Panic Disorder
 ;;^UTILITY(U,$J,358.3,14814,1,4,0)
 ;;=4^F41.0
 ;;^UTILITY(U,$J,358.3,14814,2)
 ;;=^5003564
 ;;^UTILITY(U,$J,358.3,14815,0)
 ;;=F41.1^^45^655^10
 ;;^UTILITY(U,$J,358.3,14815,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14815,1,3,0)
 ;;=3^Generalized Anxiety Disorder
 ;;^UTILITY(U,$J,358.3,14815,1,4,0)
 ;;=4^F41.1
 ;;^UTILITY(U,$J,358.3,14815,2)
 ;;=^50059
 ;;^UTILITY(U,$J,358.3,14816,0)
 ;;=F40.10^^45^655^17
 ;;^UTILITY(U,$J,358.3,14816,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14816,1,3,0)
 ;;=3^Social Anxiety Disorder (Social Phobia)
 ;;^UTILITY(U,$J,358.3,14816,1,4,0)
 ;;=4^F40.10
 ;;^UTILITY(U,$J,358.3,14816,2)
 ;;=^5003544
 ;;^UTILITY(U,$J,358.3,14817,0)
 ;;=F40.218^^45^655^2
 ;;^UTILITY(U,$J,358.3,14817,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14817,1,3,0)
 ;;=3^Animal Phobia
 ;;^UTILITY(U,$J,358.3,14817,1,4,0)
 ;;=4^F40.218
 ;;^UTILITY(U,$J,358.3,14817,2)
 ;;=^5003547
 ;;^UTILITY(U,$J,358.3,14818,0)
 ;;=F40.228^^45^655^11
 ;;^UTILITY(U,$J,358.3,14818,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14818,1,3,0)
 ;;=3^Natural Environment Phobia
 ;;^UTILITY(U,$J,358.3,14818,1,4,0)
 ;;=4^F40.228
 ;;^UTILITY(U,$J,358.3,14818,2)
 ;;=^5003549
 ;;^UTILITY(U,$J,358.3,14819,0)
 ;;=F40.230^^45^655^6
 ;;^UTILITY(U,$J,358.3,14819,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14819,1,3,0)
 ;;=3^Fear of Blood
 ;;^UTILITY(U,$J,358.3,14819,1,4,0)
 ;;=4^F40.230
 ;;^UTILITY(U,$J,358.3,14819,2)
 ;;=^5003550
 ;;^UTILITY(U,$J,358.3,14820,0)
 ;;=F40.231^^45^655^7
 ;;^UTILITY(U,$J,358.3,14820,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14820,1,3,0)
 ;;=3^Fear of Injections & Transfusions
 ;;^UTILITY(U,$J,358.3,14820,1,4,0)
 ;;=4^F40.231
 ;;^UTILITY(U,$J,358.3,14820,2)
 ;;=^5003551
 ;;^UTILITY(U,$J,358.3,14821,0)
 ;;=F40.232^^45^655^9
 ;;^UTILITY(U,$J,358.3,14821,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14821,1,3,0)
 ;;=3^Fear of Other Medical Care
 ;;^UTILITY(U,$J,358.3,14821,1,4,0)
 ;;=4^F40.232
 ;;^UTILITY(U,$J,358.3,14821,2)
 ;;=^5003552
 ;;^UTILITY(U,$J,358.3,14822,0)
 ;;=F40.233^^45^655^8
 ;;^UTILITY(U,$J,358.3,14822,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14822,1,3,0)
 ;;=3^Fear of Injury
 ;;^UTILITY(U,$J,358.3,14822,1,4,0)
 ;;=4^F40.233
 ;;^UTILITY(U,$J,358.3,14822,2)
 ;;=^5003553
 ;;^UTILITY(U,$J,358.3,14823,0)
 ;;=F40.248^^45^655^16
 ;;^UTILITY(U,$J,358.3,14823,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14823,1,3,0)
 ;;=3^Situational Phobia 
 ;;^UTILITY(U,$J,358.3,14823,1,4,0)
 ;;=4^F40.248
 ;;^UTILITY(U,$J,358.3,14823,2)
 ;;=^5003558
 ;;^UTILITY(U,$J,358.3,14824,0)
 ;;=F93.0^^45^655^15
 ;;^UTILITY(U,$J,358.3,14824,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14824,1,3,0)
 ;;=3^Separation Anxiety Disorder
 ;;^UTILITY(U,$J,358.3,14824,1,4,0)
 ;;=4^F93.0
 ;;^UTILITY(U,$J,358.3,14824,2)
 ;;=^5003702
 ;;^UTILITY(U,$J,358.3,14825,0)
 ;;=F40.00^^45^655^1
 ;;^UTILITY(U,$J,358.3,14825,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14825,1,3,0)
 ;;=3^Agoraphobia,Unsp
 ;;^UTILITY(U,$J,358.3,14825,1,4,0)
 ;;=4^F40.00
 ;;^UTILITY(U,$J,358.3,14825,2)
 ;;=^5003542
 ;;^UTILITY(U,$J,358.3,14826,0)
 ;;=F41.8^^45^655^4
 ;;^UTILITY(U,$J,358.3,14826,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14826,1,3,0)
 ;;=3^Anxiety Disorder,Other Specified
 ;;^UTILITY(U,$J,358.3,14826,1,4,0)
 ;;=4^F41.8
 ;;^UTILITY(U,$J,358.3,14826,2)
 ;;=^5003566
 ;;^UTILITY(U,$J,358.3,14827,0)
 ;;=F40.298^^45^655^13
 ;;^UTILITY(U,$J,358.3,14827,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14827,1,3,0)
 ;;=3^Phobia,Other Specified
 ;;^UTILITY(U,$J,358.3,14827,1,4,0)
 ;;=4^F40.298
 ;;^UTILITY(U,$J,358.3,14827,2)
 ;;=^5003561
 ;;^UTILITY(U,$J,358.3,14828,0)
 ;;=F41.9^^45^655^5
 ;;^UTILITY(U,$J,358.3,14828,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14828,1,3,0)
 ;;=3^Anxiety Disorder,Unsp
 ;;^UTILITY(U,$J,358.3,14828,1,4,0)
 ;;=4^F41.9
 ;;^UTILITY(U,$J,358.3,14828,2)
 ;;=^5003567
 ;;^UTILITY(U,$J,358.3,14829,0)
 ;;=F94.0^^45^655^14
 ;;^UTILITY(U,$J,358.3,14829,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14829,1,3,0)
 ;;=3^Selective Mutism
 ;;^UTILITY(U,$J,358.3,14829,1,4,0)
 ;;=4^F94.0
 ;;^UTILITY(U,$J,358.3,14829,2)
 ;;=^331954
 ;;^UTILITY(U,$J,358.3,14830,0)
 ;;=F06.33^^45^656^1
 ;;^UTILITY(U,$J,358.3,14830,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14830,1,3,0)
 ;;=3^Bipolar & Related Disorder d/t Med Cond w/ Manic Features
 ;;^UTILITY(U,$J,358.3,14830,1,4,0)
 ;;=4^F06.33
 ;;^UTILITY(U,$J,358.3,14830,2)
 ;;=^5003059
 ;;^UTILITY(U,$J,358.3,14831,0)
 ;;=F06.34^^45^656^2
 ;;^UTILITY(U,$J,358.3,14831,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14831,1,3,0)
 ;;=3^Bipolar & Related Disorder d/t Med Cond w/ Mixed Features
 ;;^UTILITY(U,$J,358.3,14831,1,4,0)
 ;;=4^F06.34
 ;;^UTILITY(U,$J,358.3,14831,2)
 ;;=^5003060
 ;;^UTILITY(U,$J,358.3,14832,0)
 ;;=F31.11^^45^656^6
 ;;^UTILITY(U,$J,358.3,14832,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14832,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,Mild
 ;;^UTILITY(U,$J,358.3,14832,1,4,0)
 ;;=4^F31.11
 ;;^UTILITY(U,$J,358.3,14832,2)
 ;;=^5003496
 ;;^UTILITY(U,$J,358.3,14833,0)
 ;;=F31.12^^45^656^7
 ;;^UTILITY(U,$J,358.3,14833,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14833,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,Moderate
 ;;^UTILITY(U,$J,358.3,14833,1,4,0)
 ;;=4^F31.12
 ;;^UTILITY(U,$J,358.3,14833,2)
 ;;=^5003497
 ;;^UTILITY(U,$J,358.3,14834,0)
 ;;=F31.13^^45^656^8
 ;;^UTILITY(U,$J,358.3,14834,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14834,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,Severe
 ;;^UTILITY(U,$J,358.3,14834,1,4,0)
 ;;=4^F31.13
 ;;^UTILITY(U,$J,358.3,14834,2)
 ;;=^5003498
 ;;^UTILITY(U,$J,358.3,14835,0)
 ;;=F31.2^^45^656^9
 ;;^UTILITY(U,$J,358.3,14835,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14835,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,w/ Psychotic Features
 ;;^UTILITY(U,$J,358.3,14835,1,4,0)
 ;;=4^F31.2
 ;;^UTILITY(U,$J,358.3,14835,2)
 ;;=^5003499
 ;;^UTILITY(U,$J,358.3,14836,0)
 ;;=F31.73^^45^656^10
 ;;^UTILITY(U,$J,358.3,14836,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14836,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,In Partial Remission
 ;;^UTILITY(U,$J,358.3,14836,1,4,0)
 ;;=4^F31.73
 ;;^UTILITY(U,$J,358.3,14836,2)
 ;;=^5003513
 ;;^UTILITY(U,$J,358.3,14837,0)
 ;;=F31.74^^45^656^11
 ;;^UTILITY(U,$J,358.3,14837,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14837,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,In Full Remission
 ;;^UTILITY(U,$J,358.3,14837,1,4,0)
 ;;=4^F31.74
 ;;^UTILITY(U,$J,358.3,14837,2)
 ;;=^5003514
 ;;^UTILITY(U,$J,358.3,14838,0)
 ;;=F31.31^^45^656^13
 ;;^UTILITY(U,$J,358.3,14838,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14838,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,Mild
 ;;^UTILITY(U,$J,358.3,14838,1,4,0)
 ;;=4^F31.31
 ;;^UTILITY(U,$J,358.3,14838,2)
 ;;=^5003501
 ;;^UTILITY(U,$J,358.3,14839,0)
 ;;=F31.32^^45^656^14
 ;;^UTILITY(U,$J,358.3,14839,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14839,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,Moderate
 ;;^UTILITY(U,$J,358.3,14839,1,4,0)
 ;;=4^F31.32
 ;;^UTILITY(U,$J,358.3,14839,2)
 ;;=^5003502
 ;;^UTILITY(U,$J,358.3,14840,0)
 ;;=F31.4^^45^656^15
 ;;^UTILITY(U,$J,358.3,14840,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14840,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,Severe
 ;;^UTILITY(U,$J,358.3,14840,1,4,0)
 ;;=4^F31.4
 ;;^UTILITY(U,$J,358.3,14840,2)
 ;;=^5003503
 ;;^UTILITY(U,$J,358.3,14841,0)
 ;;=F31.5^^45^656^16
 ;;^UTILITY(U,$J,358.3,14841,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14841,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,w/ Psychotic Features
 ;;^UTILITY(U,$J,358.3,14841,1,4,0)
 ;;=4^F31.5
 ;;^UTILITY(U,$J,358.3,14841,2)
 ;;=^5003504
 ;;^UTILITY(U,$J,358.3,14842,0)
 ;;=F31.75^^45^656^18
 ;;^UTILITY(U,$J,358.3,14842,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14842,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,In Partial Remission
 ;;^UTILITY(U,$J,358.3,14842,1,4,0)
 ;;=4^F31.75
 ;;^UTILITY(U,$J,358.3,14842,2)
 ;;=^5003515
 ;;^UTILITY(U,$J,358.3,14843,0)
 ;;=F31.76^^45^656^17
 ;;^UTILITY(U,$J,358.3,14843,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14843,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,In Full Remission
 ;;^UTILITY(U,$J,358.3,14843,1,4,0)
 ;;=4^F31.76
 ;;^UTILITY(U,$J,358.3,14843,2)
 ;;=^5003516
 ;;^UTILITY(U,$J,358.3,14844,0)
 ;;=F31.81^^45^656^23
 ;;^UTILITY(U,$J,358.3,14844,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14844,1,3,0)
 ;;=3^Bipolar II Disorder
 ;;^UTILITY(U,$J,358.3,14844,1,4,0)
 ;;=4^F31.81
 ;;^UTILITY(U,$J,358.3,14844,2)
 ;;=^5003519
 ;;^UTILITY(U,$J,358.3,14845,0)
 ;;=F34.0^^45^656^24
 ;;^UTILITY(U,$J,358.3,14845,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14845,1,3,0)
 ;;=3^Cyclothymic Disorder
 ;;^UTILITY(U,$J,358.3,14845,1,4,0)
 ;;=4^F34.0
 ;;^UTILITY(U,$J,358.3,14845,2)
 ;;=^5003538
 ;;^UTILITY(U,$J,358.3,14846,0)
 ;;=F31.0^^45^656^20
 ;;^UTILITY(U,$J,358.3,14846,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14846,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Hypomanic
 ;;^UTILITY(U,$J,358.3,14846,1,4,0)
 ;;=4^F31.0
 ;;^UTILITY(U,$J,358.3,14846,2)
 ;;=^5003494
 ;;^UTILITY(U,$J,358.3,14847,0)
 ;;=F31.71^^45^656^22
 ;;^UTILITY(U,$J,358.3,14847,1,0)
 ;;=^358.31IA^4^2

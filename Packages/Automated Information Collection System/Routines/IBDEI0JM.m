IBDEI0JM ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24843,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24843,1,3,0)
 ;;=3^Anxiety Disorder d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,24843,1,4,0)
 ;;=4^F06.4
 ;;^UTILITY(U,$J,358.3,24843,2)
 ;;=^5003061
 ;;^UTILITY(U,$J,358.3,24844,0)
 ;;=F41.0^^66^994^12
 ;;^UTILITY(U,$J,358.3,24844,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24844,1,3,0)
 ;;=3^Panic Disorder
 ;;^UTILITY(U,$J,358.3,24844,1,4,0)
 ;;=4^F41.0
 ;;^UTILITY(U,$J,358.3,24844,2)
 ;;=^5003564
 ;;^UTILITY(U,$J,358.3,24845,0)
 ;;=F41.1^^66^994^10
 ;;^UTILITY(U,$J,358.3,24845,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24845,1,3,0)
 ;;=3^Generalized Anxiety Disorder
 ;;^UTILITY(U,$J,358.3,24845,1,4,0)
 ;;=4^F41.1
 ;;^UTILITY(U,$J,358.3,24845,2)
 ;;=^50059
 ;;^UTILITY(U,$J,358.3,24846,0)
 ;;=F40.10^^66^994^17
 ;;^UTILITY(U,$J,358.3,24846,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24846,1,3,0)
 ;;=3^Social Anxiety Disorder (Social Phobia)
 ;;^UTILITY(U,$J,358.3,24846,1,4,0)
 ;;=4^F40.10
 ;;^UTILITY(U,$J,358.3,24846,2)
 ;;=^5003544
 ;;^UTILITY(U,$J,358.3,24847,0)
 ;;=F40.218^^66^994^2
 ;;^UTILITY(U,$J,358.3,24847,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24847,1,3,0)
 ;;=3^Animal Phobia
 ;;^UTILITY(U,$J,358.3,24847,1,4,0)
 ;;=4^F40.218
 ;;^UTILITY(U,$J,358.3,24847,2)
 ;;=^5003547
 ;;^UTILITY(U,$J,358.3,24848,0)
 ;;=F40.228^^66^994^11
 ;;^UTILITY(U,$J,358.3,24848,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24848,1,3,0)
 ;;=3^Natural Environment Phobia
 ;;^UTILITY(U,$J,358.3,24848,1,4,0)
 ;;=4^F40.228
 ;;^UTILITY(U,$J,358.3,24848,2)
 ;;=^5003549
 ;;^UTILITY(U,$J,358.3,24849,0)
 ;;=F40.230^^66^994^6
 ;;^UTILITY(U,$J,358.3,24849,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24849,1,3,0)
 ;;=3^Fear of Blood
 ;;^UTILITY(U,$J,358.3,24849,1,4,0)
 ;;=4^F40.230
 ;;^UTILITY(U,$J,358.3,24849,2)
 ;;=^5003550
 ;;^UTILITY(U,$J,358.3,24850,0)
 ;;=F40.231^^66^994^7
 ;;^UTILITY(U,$J,358.3,24850,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24850,1,3,0)
 ;;=3^Fear of Injections & Transfusions
 ;;^UTILITY(U,$J,358.3,24850,1,4,0)
 ;;=4^F40.231
 ;;^UTILITY(U,$J,358.3,24850,2)
 ;;=^5003551
 ;;^UTILITY(U,$J,358.3,24851,0)
 ;;=F40.232^^66^994^9
 ;;^UTILITY(U,$J,358.3,24851,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24851,1,3,0)
 ;;=3^Fear of Other Medical Care
 ;;^UTILITY(U,$J,358.3,24851,1,4,0)
 ;;=4^F40.232
 ;;^UTILITY(U,$J,358.3,24851,2)
 ;;=^5003552
 ;;^UTILITY(U,$J,358.3,24852,0)
 ;;=F40.233^^66^994^8
 ;;^UTILITY(U,$J,358.3,24852,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24852,1,3,0)
 ;;=3^Fear of Injury
 ;;^UTILITY(U,$J,358.3,24852,1,4,0)
 ;;=4^F40.233
 ;;^UTILITY(U,$J,358.3,24852,2)
 ;;=^5003553
 ;;^UTILITY(U,$J,358.3,24853,0)
 ;;=F40.248^^66^994^16
 ;;^UTILITY(U,$J,358.3,24853,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24853,1,3,0)
 ;;=3^Situational Phobia 
 ;;^UTILITY(U,$J,358.3,24853,1,4,0)
 ;;=4^F40.248
 ;;^UTILITY(U,$J,358.3,24853,2)
 ;;=^5003558
 ;;^UTILITY(U,$J,358.3,24854,0)
 ;;=F93.0^^66^994^15
 ;;^UTILITY(U,$J,358.3,24854,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24854,1,3,0)
 ;;=3^Separation Anxiety Disorder
 ;;^UTILITY(U,$J,358.3,24854,1,4,0)
 ;;=4^F93.0
 ;;^UTILITY(U,$J,358.3,24854,2)
 ;;=^5003702
 ;;^UTILITY(U,$J,358.3,24855,0)
 ;;=F40.00^^66^994^1
 ;;^UTILITY(U,$J,358.3,24855,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24855,1,3,0)
 ;;=3^Agoraphobia,Unsp
 ;;^UTILITY(U,$J,358.3,24855,1,4,0)
 ;;=4^F40.00
 ;;^UTILITY(U,$J,358.3,24855,2)
 ;;=^5003542
 ;;^UTILITY(U,$J,358.3,24856,0)
 ;;=F41.8^^66^994^4
 ;;^UTILITY(U,$J,358.3,24856,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24856,1,3,0)
 ;;=3^Anxiety Disorder,Other Specified
 ;;^UTILITY(U,$J,358.3,24856,1,4,0)
 ;;=4^F41.8
 ;;^UTILITY(U,$J,358.3,24856,2)
 ;;=^5003566
 ;;^UTILITY(U,$J,358.3,24857,0)
 ;;=F40.298^^66^994^13
 ;;^UTILITY(U,$J,358.3,24857,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24857,1,3,0)
 ;;=3^Phobia,Other Specified
 ;;^UTILITY(U,$J,358.3,24857,1,4,0)
 ;;=4^F40.298
 ;;^UTILITY(U,$J,358.3,24857,2)
 ;;=^5003561
 ;;^UTILITY(U,$J,358.3,24858,0)
 ;;=F41.9^^66^994^5
 ;;^UTILITY(U,$J,358.3,24858,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24858,1,3,0)
 ;;=3^Anxiety Disorder,Unsp
 ;;^UTILITY(U,$J,358.3,24858,1,4,0)
 ;;=4^F41.9
 ;;^UTILITY(U,$J,358.3,24858,2)
 ;;=^5003567
 ;;^UTILITY(U,$J,358.3,24859,0)
 ;;=F94.0^^66^994^14
 ;;^UTILITY(U,$J,358.3,24859,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24859,1,3,0)
 ;;=3^Selective Mutism
 ;;^UTILITY(U,$J,358.3,24859,1,4,0)
 ;;=4^F94.0
 ;;^UTILITY(U,$J,358.3,24859,2)
 ;;=^331954
 ;;^UTILITY(U,$J,358.3,24860,0)
 ;;=F06.33^^66^995^1
 ;;^UTILITY(U,$J,358.3,24860,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24860,1,3,0)
 ;;=3^Bipolar & Related Disorder d/t Med Cond w/ Manic Features
 ;;^UTILITY(U,$J,358.3,24860,1,4,0)
 ;;=4^F06.33
 ;;^UTILITY(U,$J,358.3,24860,2)
 ;;=^5003059
 ;;^UTILITY(U,$J,358.3,24861,0)
 ;;=F06.34^^66^995^2
 ;;^UTILITY(U,$J,358.3,24861,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24861,1,3,0)
 ;;=3^Bipolar & Related Disorder d/t Med Cond w/ Mixed Features
 ;;^UTILITY(U,$J,358.3,24861,1,4,0)
 ;;=4^F06.34
 ;;^UTILITY(U,$J,358.3,24861,2)
 ;;=^5003060
 ;;^UTILITY(U,$J,358.3,24862,0)
 ;;=F31.11^^66^995^6
 ;;^UTILITY(U,$J,358.3,24862,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24862,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,Mild
 ;;^UTILITY(U,$J,358.3,24862,1,4,0)
 ;;=4^F31.11
 ;;^UTILITY(U,$J,358.3,24862,2)
 ;;=^5003496
 ;;^UTILITY(U,$J,358.3,24863,0)
 ;;=F31.12^^66^995^7
 ;;^UTILITY(U,$J,358.3,24863,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24863,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,Moderate
 ;;^UTILITY(U,$J,358.3,24863,1,4,0)
 ;;=4^F31.12
 ;;^UTILITY(U,$J,358.3,24863,2)
 ;;=^5003497
 ;;^UTILITY(U,$J,358.3,24864,0)
 ;;=F31.13^^66^995^8
 ;;^UTILITY(U,$J,358.3,24864,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24864,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,Severe
 ;;^UTILITY(U,$J,358.3,24864,1,4,0)
 ;;=4^F31.13
 ;;^UTILITY(U,$J,358.3,24864,2)
 ;;=^5003498
 ;;^UTILITY(U,$J,358.3,24865,0)
 ;;=F31.2^^66^995^9
 ;;^UTILITY(U,$J,358.3,24865,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24865,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,w/ Psychotic Features
 ;;^UTILITY(U,$J,358.3,24865,1,4,0)
 ;;=4^F31.2
 ;;^UTILITY(U,$J,358.3,24865,2)
 ;;=^5003499
 ;;^UTILITY(U,$J,358.3,24866,0)
 ;;=F31.73^^66^995^10
 ;;^UTILITY(U,$J,358.3,24866,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24866,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,In Partial Remission
 ;;^UTILITY(U,$J,358.3,24866,1,4,0)
 ;;=4^F31.73
 ;;^UTILITY(U,$J,358.3,24866,2)
 ;;=^5003513
 ;;^UTILITY(U,$J,358.3,24867,0)
 ;;=F31.74^^66^995^11
 ;;^UTILITY(U,$J,358.3,24867,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24867,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,In Full Remission
 ;;^UTILITY(U,$J,358.3,24867,1,4,0)
 ;;=4^F31.74
 ;;^UTILITY(U,$J,358.3,24867,2)
 ;;=^5003514
 ;;^UTILITY(U,$J,358.3,24868,0)
 ;;=F31.31^^66^995^13
 ;;^UTILITY(U,$J,358.3,24868,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24868,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,Mild
 ;;^UTILITY(U,$J,358.3,24868,1,4,0)
 ;;=4^F31.31
 ;;^UTILITY(U,$J,358.3,24868,2)
 ;;=^5003501
 ;;^UTILITY(U,$J,358.3,24869,0)
 ;;=F31.32^^66^995^14
 ;;^UTILITY(U,$J,358.3,24869,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24869,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,Moderate
 ;;^UTILITY(U,$J,358.3,24869,1,4,0)
 ;;=4^F31.32
 ;;^UTILITY(U,$J,358.3,24869,2)
 ;;=^5003502
 ;;^UTILITY(U,$J,358.3,24870,0)
 ;;=F31.4^^66^995^15
 ;;^UTILITY(U,$J,358.3,24870,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24870,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,Severe
 ;;^UTILITY(U,$J,358.3,24870,1,4,0)
 ;;=4^F31.4
 ;;^UTILITY(U,$J,358.3,24870,2)
 ;;=^5003503
 ;;^UTILITY(U,$J,358.3,24871,0)
 ;;=F31.5^^66^995^16
 ;;^UTILITY(U,$J,358.3,24871,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24871,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,w/ Psychotic Features
 ;;^UTILITY(U,$J,358.3,24871,1,4,0)
 ;;=4^F31.5
 ;;^UTILITY(U,$J,358.3,24871,2)
 ;;=^5003504
 ;;^UTILITY(U,$J,358.3,24872,0)
 ;;=F31.75^^66^995^18
 ;;^UTILITY(U,$J,358.3,24872,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24872,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,In Partial Remission
 ;;^UTILITY(U,$J,358.3,24872,1,4,0)
 ;;=4^F31.75
 ;;^UTILITY(U,$J,358.3,24872,2)
 ;;=^5003515
 ;;^UTILITY(U,$J,358.3,24873,0)
 ;;=F31.76^^66^995^17
 ;;^UTILITY(U,$J,358.3,24873,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24873,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,In Full Remission
 ;;^UTILITY(U,$J,358.3,24873,1,4,0)
 ;;=4^F31.76
 ;;^UTILITY(U,$J,358.3,24873,2)
 ;;=^5003516
 ;;^UTILITY(U,$J,358.3,24874,0)
 ;;=F31.81^^66^995^23
 ;;^UTILITY(U,$J,358.3,24874,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24874,1,3,0)
 ;;=3^Bipolar II Disorder
 ;;^UTILITY(U,$J,358.3,24874,1,4,0)
 ;;=4^F31.81
 ;;^UTILITY(U,$J,358.3,24874,2)
 ;;=^5003519
 ;;^UTILITY(U,$J,358.3,24875,0)
 ;;=F34.0^^66^995^24
 ;;^UTILITY(U,$J,358.3,24875,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24875,1,3,0)
 ;;=3^Cyclothymic Disorder
 ;;^UTILITY(U,$J,358.3,24875,1,4,0)
 ;;=4^F34.0
 ;;^UTILITY(U,$J,358.3,24875,2)
 ;;=^5003538
 ;;^UTILITY(U,$J,358.3,24876,0)
 ;;=F31.0^^66^995^20
 ;;^UTILITY(U,$J,358.3,24876,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24876,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Hypomanic
 ;;^UTILITY(U,$J,358.3,24876,1,4,0)
 ;;=4^F31.0
 ;;^UTILITY(U,$J,358.3,24876,2)
 ;;=^5003494
 ;;^UTILITY(U,$J,358.3,24877,0)
 ;;=F31.71^^66^995^22
 ;;^UTILITY(U,$J,358.3,24877,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24877,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Hypomanic,In Partial Remission
 ;;^UTILITY(U,$J,358.3,24877,1,4,0)
 ;;=4^F31.71

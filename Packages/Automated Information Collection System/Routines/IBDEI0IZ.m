IBDEI0IZ ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24058,1,4,0)
 ;;=4^Z62.811
 ;;^UTILITY(U,$J,358.3,24058,2)
 ;;=^5063154
 ;;^UTILITY(U,$J,358.3,24059,0)
 ;;=Z91.410^^64^947^42
 ;;^UTILITY(U,$J,358.3,24059,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24059,1,3,0)
 ;;=3^Personal Past Hx of Spouse or Partner Violence,Sexual
 ;;^UTILITY(U,$J,358.3,24059,1,4,0)
 ;;=4^Z91.410
 ;;^UTILITY(U,$J,358.3,24059,2)
 ;;=^5063619
 ;;^UTILITY(U,$J,358.3,24060,0)
 ;;=F06.4^^64^948^3
 ;;^UTILITY(U,$J,358.3,24060,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24060,1,3,0)
 ;;=3^Anxiety Disorder d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,24060,1,4,0)
 ;;=4^F06.4
 ;;^UTILITY(U,$J,358.3,24060,2)
 ;;=^5003061
 ;;^UTILITY(U,$J,358.3,24061,0)
 ;;=F41.0^^64^948^12
 ;;^UTILITY(U,$J,358.3,24061,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24061,1,3,0)
 ;;=3^Panic Disorder
 ;;^UTILITY(U,$J,358.3,24061,1,4,0)
 ;;=4^F41.0
 ;;^UTILITY(U,$J,358.3,24061,2)
 ;;=^5003564
 ;;^UTILITY(U,$J,358.3,24062,0)
 ;;=F41.1^^64^948^10
 ;;^UTILITY(U,$J,358.3,24062,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24062,1,3,0)
 ;;=3^Generalized Anxiety Disorder
 ;;^UTILITY(U,$J,358.3,24062,1,4,0)
 ;;=4^F41.1
 ;;^UTILITY(U,$J,358.3,24062,2)
 ;;=^50059
 ;;^UTILITY(U,$J,358.3,24063,0)
 ;;=F40.10^^64^948^17
 ;;^UTILITY(U,$J,358.3,24063,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24063,1,3,0)
 ;;=3^Social Anxiety Disorder (Social Phobia)
 ;;^UTILITY(U,$J,358.3,24063,1,4,0)
 ;;=4^F40.10
 ;;^UTILITY(U,$J,358.3,24063,2)
 ;;=^5003544
 ;;^UTILITY(U,$J,358.3,24064,0)
 ;;=F40.218^^64^948^2
 ;;^UTILITY(U,$J,358.3,24064,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24064,1,3,0)
 ;;=3^Animal Phobia
 ;;^UTILITY(U,$J,358.3,24064,1,4,0)
 ;;=4^F40.218
 ;;^UTILITY(U,$J,358.3,24064,2)
 ;;=^5003547
 ;;^UTILITY(U,$J,358.3,24065,0)
 ;;=F40.228^^64^948^11
 ;;^UTILITY(U,$J,358.3,24065,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24065,1,3,0)
 ;;=3^Natural Environment Phobia
 ;;^UTILITY(U,$J,358.3,24065,1,4,0)
 ;;=4^F40.228
 ;;^UTILITY(U,$J,358.3,24065,2)
 ;;=^5003549
 ;;^UTILITY(U,$J,358.3,24066,0)
 ;;=F40.230^^64^948^6
 ;;^UTILITY(U,$J,358.3,24066,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24066,1,3,0)
 ;;=3^Fear of Blood
 ;;^UTILITY(U,$J,358.3,24066,1,4,0)
 ;;=4^F40.230
 ;;^UTILITY(U,$J,358.3,24066,2)
 ;;=^5003550
 ;;^UTILITY(U,$J,358.3,24067,0)
 ;;=F40.231^^64^948^7
 ;;^UTILITY(U,$J,358.3,24067,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24067,1,3,0)
 ;;=3^Fear of Injections & Transfusions
 ;;^UTILITY(U,$J,358.3,24067,1,4,0)
 ;;=4^F40.231
 ;;^UTILITY(U,$J,358.3,24067,2)
 ;;=^5003551
 ;;^UTILITY(U,$J,358.3,24068,0)
 ;;=F40.232^^64^948^9
 ;;^UTILITY(U,$J,358.3,24068,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24068,1,3,0)
 ;;=3^Fear of Other Medical Care
 ;;^UTILITY(U,$J,358.3,24068,1,4,0)
 ;;=4^F40.232
 ;;^UTILITY(U,$J,358.3,24068,2)
 ;;=^5003552
 ;;^UTILITY(U,$J,358.3,24069,0)
 ;;=F40.233^^64^948^8
 ;;^UTILITY(U,$J,358.3,24069,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24069,1,3,0)
 ;;=3^Fear of Injury
 ;;^UTILITY(U,$J,358.3,24069,1,4,0)
 ;;=4^F40.233
 ;;^UTILITY(U,$J,358.3,24069,2)
 ;;=^5003553
 ;;^UTILITY(U,$J,358.3,24070,0)
 ;;=F40.248^^64^948^16
 ;;^UTILITY(U,$J,358.3,24070,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24070,1,3,0)
 ;;=3^Situational Phobia 
 ;;^UTILITY(U,$J,358.3,24070,1,4,0)
 ;;=4^F40.248
 ;;^UTILITY(U,$J,358.3,24070,2)
 ;;=^5003558
 ;;^UTILITY(U,$J,358.3,24071,0)
 ;;=F93.0^^64^948^15
 ;;^UTILITY(U,$J,358.3,24071,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24071,1,3,0)
 ;;=3^Separation Anxiety Disorder
 ;;^UTILITY(U,$J,358.3,24071,1,4,0)
 ;;=4^F93.0
 ;;^UTILITY(U,$J,358.3,24071,2)
 ;;=^5003702
 ;;^UTILITY(U,$J,358.3,24072,0)
 ;;=F40.00^^64^948^1
 ;;^UTILITY(U,$J,358.3,24072,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24072,1,3,0)
 ;;=3^Agoraphobia,Unsp
 ;;^UTILITY(U,$J,358.3,24072,1,4,0)
 ;;=4^F40.00
 ;;^UTILITY(U,$J,358.3,24072,2)
 ;;=^5003542
 ;;^UTILITY(U,$J,358.3,24073,0)
 ;;=F41.8^^64^948^4
 ;;^UTILITY(U,$J,358.3,24073,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24073,1,3,0)
 ;;=3^Anxiety Disorder,Other Specified
 ;;^UTILITY(U,$J,358.3,24073,1,4,0)
 ;;=4^F41.8
 ;;^UTILITY(U,$J,358.3,24073,2)
 ;;=^5003566
 ;;^UTILITY(U,$J,358.3,24074,0)
 ;;=F40.298^^64^948^13
 ;;^UTILITY(U,$J,358.3,24074,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24074,1,3,0)
 ;;=3^Phobia,Other Specified
 ;;^UTILITY(U,$J,358.3,24074,1,4,0)
 ;;=4^F40.298
 ;;^UTILITY(U,$J,358.3,24074,2)
 ;;=^5003561
 ;;^UTILITY(U,$J,358.3,24075,0)
 ;;=F41.9^^64^948^5
 ;;^UTILITY(U,$J,358.3,24075,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24075,1,3,0)
 ;;=3^Anxiety Disorder,Unsp
 ;;^UTILITY(U,$J,358.3,24075,1,4,0)
 ;;=4^F41.9
 ;;^UTILITY(U,$J,358.3,24075,2)
 ;;=^5003567
 ;;^UTILITY(U,$J,358.3,24076,0)
 ;;=F94.0^^64^948^14
 ;;^UTILITY(U,$J,358.3,24076,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24076,1,3,0)
 ;;=3^Selective Mutism
 ;;^UTILITY(U,$J,358.3,24076,1,4,0)
 ;;=4^F94.0
 ;;^UTILITY(U,$J,358.3,24076,2)
 ;;=^331954
 ;;^UTILITY(U,$J,358.3,24077,0)
 ;;=F06.33^^64^949^1
 ;;^UTILITY(U,$J,358.3,24077,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24077,1,3,0)
 ;;=3^Bipolar & Related Disorder d/t Med Cond w/ Manic Features
 ;;^UTILITY(U,$J,358.3,24077,1,4,0)
 ;;=4^F06.33
 ;;^UTILITY(U,$J,358.3,24077,2)
 ;;=^5003059
 ;;^UTILITY(U,$J,358.3,24078,0)
 ;;=F06.34^^64^949^2
 ;;^UTILITY(U,$J,358.3,24078,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24078,1,3,0)
 ;;=3^Bipolar & Related Disorder d/t Med Cond w/ Mixed Features
 ;;^UTILITY(U,$J,358.3,24078,1,4,0)
 ;;=4^F06.34
 ;;^UTILITY(U,$J,358.3,24078,2)
 ;;=^5003060
 ;;^UTILITY(U,$J,358.3,24079,0)
 ;;=F31.11^^64^949^6
 ;;^UTILITY(U,$J,358.3,24079,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24079,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,Mild
 ;;^UTILITY(U,$J,358.3,24079,1,4,0)
 ;;=4^F31.11
 ;;^UTILITY(U,$J,358.3,24079,2)
 ;;=^5003496
 ;;^UTILITY(U,$J,358.3,24080,0)
 ;;=F31.12^^64^949^7
 ;;^UTILITY(U,$J,358.3,24080,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24080,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,Moderate
 ;;^UTILITY(U,$J,358.3,24080,1,4,0)
 ;;=4^F31.12
 ;;^UTILITY(U,$J,358.3,24080,2)
 ;;=^5003497
 ;;^UTILITY(U,$J,358.3,24081,0)
 ;;=F31.13^^64^949^8
 ;;^UTILITY(U,$J,358.3,24081,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24081,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,Severe
 ;;^UTILITY(U,$J,358.3,24081,1,4,0)
 ;;=4^F31.13
 ;;^UTILITY(U,$J,358.3,24081,2)
 ;;=^5003498
 ;;^UTILITY(U,$J,358.3,24082,0)
 ;;=F31.2^^64^949^9
 ;;^UTILITY(U,$J,358.3,24082,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24082,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,w/ Psychotic Features
 ;;^UTILITY(U,$J,358.3,24082,1,4,0)
 ;;=4^F31.2
 ;;^UTILITY(U,$J,358.3,24082,2)
 ;;=^5003499
 ;;^UTILITY(U,$J,358.3,24083,0)
 ;;=F31.73^^64^949^10
 ;;^UTILITY(U,$J,358.3,24083,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24083,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,In Partial Remission
 ;;^UTILITY(U,$J,358.3,24083,1,4,0)
 ;;=4^F31.73
 ;;^UTILITY(U,$J,358.3,24083,2)
 ;;=^5003513
 ;;^UTILITY(U,$J,358.3,24084,0)
 ;;=F31.74^^64^949^11
 ;;^UTILITY(U,$J,358.3,24084,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24084,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,In Full Remission
 ;;^UTILITY(U,$J,358.3,24084,1,4,0)
 ;;=4^F31.74
 ;;^UTILITY(U,$J,358.3,24084,2)
 ;;=^5003514
 ;;^UTILITY(U,$J,358.3,24085,0)
 ;;=F31.31^^64^949^13
 ;;^UTILITY(U,$J,358.3,24085,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24085,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,Mild
 ;;^UTILITY(U,$J,358.3,24085,1,4,0)
 ;;=4^F31.31
 ;;^UTILITY(U,$J,358.3,24085,2)
 ;;=^5003501
 ;;^UTILITY(U,$J,358.3,24086,0)
 ;;=F31.32^^64^949^14
 ;;^UTILITY(U,$J,358.3,24086,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24086,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,Moderate
 ;;^UTILITY(U,$J,358.3,24086,1,4,0)
 ;;=4^F31.32
 ;;^UTILITY(U,$J,358.3,24086,2)
 ;;=^5003502
 ;;^UTILITY(U,$J,358.3,24087,0)
 ;;=F31.4^^64^949^15
 ;;^UTILITY(U,$J,358.3,24087,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24087,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,Severe
 ;;^UTILITY(U,$J,358.3,24087,1,4,0)
 ;;=4^F31.4
 ;;^UTILITY(U,$J,358.3,24087,2)
 ;;=^5003503
 ;;^UTILITY(U,$J,358.3,24088,0)
 ;;=F31.5^^64^949^16
 ;;^UTILITY(U,$J,358.3,24088,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24088,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,w/ Psychotic Features
 ;;^UTILITY(U,$J,358.3,24088,1,4,0)
 ;;=4^F31.5
 ;;^UTILITY(U,$J,358.3,24088,2)
 ;;=^5003504
 ;;^UTILITY(U,$J,358.3,24089,0)
 ;;=F31.75^^64^949^18
 ;;^UTILITY(U,$J,358.3,24089,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24089,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,In Partial Remission
 ;;^UTILITY(U,$J,358.3,24089,1,4,0)
 ;;=4^F31.75
 ;;^UTILITY(U,$J,358.3,24089,2)
 ;;=^5003515
 ;;^UTILITY(U,$J,358.3,24090,0)
 ;;=F31.76^^64^949^17
 ;;^UTILITY(U,$J,358.3,24090,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24090,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,In Full Remission
 ;;^UTILITY(U,$J,358.3,24090,1,4,0)
 ;;=4^F31.76
 ;;^UTILITY(U,$J,358.3,24090,2)
 ;;=^5003516
 ;;^UTILITY(U,$J,358.3,24091,0)
 ;;=F31.81^^64^949^23
 ;;^UTILITY(U,$J,358.3,24091,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24091,1,3,0)
 ;;=3^Bipolar II Disorder
 ;;^UTILITY(U,$J,358.3,24091,1,4,0)
 ;;=4^F31.81
 ;;^UTILITY(U,$J,358.3,24091,2)
 ;;=^5003519
 ;;^UTILITY(U,$J,358.3,24092,0)
 ;;=F34.0^^64^949^24
 ;;^UTILITY(U,$J,358.3,24092,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24092,1,3,0)
 ;;=3^Cyclothymic Disorder
 ;;^UTILITY(U,$J,358.3,24092,1,4,0)
 ;;=4^F34.0
 ;;^UTILITY(U,$J,358.3,24092,2)
 ;;=^5003538
 ;;^UTILITY(U,$J,358.3,24093,0)
 ;;=F31.0^^64^949^20
 ;;^UTILITY(U,$J,358.3,24093,1,0)
 ;;=^358.31IA^4^2

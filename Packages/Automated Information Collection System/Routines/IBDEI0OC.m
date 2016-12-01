IBDEI0OC ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30872,1,3,0)
 ;;=3^MH Svc for Perpetrator of Spousal/Partner Psychological Abuse
 ;;^UTILITY(U,$J,358.3,30872,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,30872,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,30873,0)
 ;;=Z69.12^^91^1334^29
 ;;^UTILITY(U,$J,358.3,30873,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30873,1,3,0)
 ;;=3^MH Svc for Perpetrator of Spousal/Partner Violence,Sexual
 ;;^UTILITY(U,$J,358.3,30873,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,30873,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,30874,0)
 ;;=Z69.11^^91^1334^32
 ;;^UTILITY(U,$J,358.3,30874,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30874,1,3,0)
 ;;=3^MH Svc for Victim of Spousal/Partner Psychological Abuse
 ;;^UTILITY(U,$J,358.3,30874,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,30874,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,30875,0)
 ;;=Z69.11^^91^1334^33
 ;;^UTILITY(U,$J,358.3,30875,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30875,1,3,0)
 ;;=3^MH Svc for Victim of Spousal/Partner Violence,Physical
 ;;^UTILITY(U,$J,358.3,30875,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,30875,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,30876,0)
 ;;=Z69.11^^91^1334^34
 ;;^UTILITY(U,$J,358.3,30876,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30876,1,3,0)
 ;;=3^MH Svc for Victim of Spousal/Partner Violence,Sexual
 ;;^UTILITY(U,$J,358.3,30876,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,30876,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,30877,0)
 ;;=Z62.812^^91^1334^36
 ;;^UTILITY(U,$J,358.3,30877,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30877,1,3,0)
 ;;=3^Personal Past Hx of Childhood Neglect
 ;;^UTILITY(U,$J,358.3,30877,1,4,0)
 ;;=4^Z62.812
 ;;^UTILITY(U,$J,358.3,30877,2)
 ;;=^5063155
 ;;^UTILITY(U,$J,358.3,30878,0)
 ;;=Z62.810^^91^1334^37
 ;;^UTILITY(U,$J,358.3,30878,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30878,1,3,0)
 ;;=3^Personal Past Hx of Childhood Physical Abuse
 ;;^UTILITY(U,$J,358.3,30878,1,4,0)
 ;;=4^Z62.810
 ;;^UTILITY(U,$J,358.3,30878,2)
 ;;=^5063153
 ;;^UTILITY(U,$J,358.3,30879,0)
 ;;=Z62.810^^91^1334^39
 ;;^UTILITY(U,$J,358.3,30879,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30879,1,3,0)
 ;;=3^Personal Past Hx of Childhood Sexual Abuse
 ;;^UTILITY(U,$J,358.3,30879,1,4,0)
 ;;=4^Z62.810
 ;;^UTILITY(U,$J,358.3,30879,2)
 ;;=^5063153
 ;;^UTILITY(U,$J,358.3,30880,0)
 ;;=Z62.811^^91^1334^38
 ;;^UTILITY(U,$J,358.3,30880,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30880,1,3,0)
 ;;=3^Personal Past Hx of Childhood Psychological Abuse
 ;;^UTILITY(U,$J,358.3,30880,1,4,0)
 ;;=4^Z62.811
 ;;^UTILITY(U,$J,358.3,30880,2)
 ;;=^5063154
 ;;^UTILITY(U,$J,358.3,30881,0)
 ;;=Z91.410^^91^1334^42
 ;;^UTILITY(U,$J,358.3,30881,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30881,1,3,0)
 ;;=3^Personal Past Hx of Spouse or Partner Violence,Sexual
 ;;^UTILITY(U,$J,358.3,30881,1,4,0)
 ;;=4^Z91.410
 ;;^UTILITY(U,$J,358.3,30881,2)
 ;;=^5063619
 ;;^UTILITY(U,$J,358.3,30882,0)
 ;;=F06.4^^91^1335^3
 ;;^UTILITY(U,$J,358.3,30882,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30882,1,3,0)
 ;;=3^Anxiety Disorder d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,30882,1,4,0)
 ;;=4^F06.4
 ;;^UTILITY(U,$J,358.3,30882,2)
 ;;=^5003061
 ;;^UTILITY(U,$J,358.3,30883,0)
 ;;=F41.0^^91^1335^12
 ;;^UTILITY(U,$J,358.3,30883,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30883,1,3,0)
 ;;=3^Panic Disorder
 ;;^UTILITY(U,$J,358.3,30883,1,4,0)
 ;;=4^F41.0
 ;;^UTILITY(U,$J,358.3,30883,2)
 ;;=^5003564
 ;;^UTILITY(U,$J,358.3,30884,0)
 ;;=F41.1^^91^1335^10
 ;;^UTILITY(U,$J,358.3,30884,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30884,1,3,0)
 ;;=3^Generalized Anxiety Disorder
 ;;^UTILITY(U,$J,358.3,30884,1,4,0)
 ;;=4^F41.1
 ;;^UTILITY(U,$J,358.3,30884,2)
 ;;=^50059
 ;;^UTILITY(U,$J,358.3,30885,0)
 ;;=F40.10^^91^1335^17
 ;;^UTILITY(U,$J,358.3,30885,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30885,1,3,0)
 ;;=3^Social Anxiety Disorder (Social Phobia)
 ;;^UTILITY(U,$J,358.3,30885,1,4,0)
 ;;=4^F40.10
 ;;^UTILITY(U,$J,358.3,30885,2)
 ;;=^5003544
 ;;^UTILITY(U,$J,358.3,30886,0)
 ;;=F40.218^^91^1335^2
 ;;^UTILITY(U,$J,358.3,30886,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30886,1,3,0)
 ;;=3^Animal Phobia
 ;;^UTILITY(U,$J,358.3,30886,1,4,0)
 ;;=4^F40.218
 ;;^UTILITY(U,$J,358.3,30886,2)
 ;;=^5003547
 ;;^UTILITY(U,$J,358.3,30887,0)
 ;;=F40.228^^91^1335^11
 ;;^UTILITY(U,$J,358.3,30887,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30887,1,3,0)
 ;;=3^Natural Environment Phobia
 ;;^UTILITY(U,$J,358.3,30887,1,4,0)
 ;;=4^F40.228
 ;;^UTILITY(U,$J,358.3,30887,2)
 ;;=^5003549
 ;;^UTILITY(U,$J,358.3,30888,0)
 ;;=F40.230^^91^1335^6
 ;;^UTILITY(U,$J,358.3,30888,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30888,1,3,0)
 ;;=3^Fear of Blood
 ;;^UTILITY(U,$J,358.3,30888,1,4,0)
 ;;=4^F40.230
 ;;^UTILITY(U,$J,358.3,30888,2)
 ;;=^5003550
 ;;^UTILITY(U,$J,358.3,30889,0)
 ;;=F40.231^^91^1335^7
 ;;^UTILITY(U,$J,358.3,30889,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30889,1,3,0)
 ;;=3^Fear of Injections & Transfusions
 ;;^UTILITY(U,$J,358.3,30889,1,4,0)
 ;;=4^F40.231
 ;;^UTILITY(U,$J,358.3,30889,2)
 ;;=^5003551
 ;;^UTILITY(U,$J,358.3,30890,0)
 ;;=F40.232^^91^1335^9
 ;;^UTILITY(U,$J,358.3,30890,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30890,1,3,0)
 ;;=3^Fear of Other Medical Care
 ;;^UTILITY(U,$J,358.3,30890,1,4,0)
 ;;=4^F40.232
 ;;^UTILITY(U,$J,358.3,30890,2)
 ;;=^5003552
 ;;^UTILITY(U,$J,358.3,30891,0)
 ;;=F40.233^^91^1335^8
 ;;^UTILITY(U,$J,358.3,30891,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30891,1,3,0)
 ;;=3^Fear of Injury
 ;;^UTILITY(U,$J,358.3,30891,1,4,0)
 ;;=4^F40.233
 ;;^UTILITY(U,$J,358.3,30891,2)
 ;;=^5003553
 ;;^UTILITY(U,$J,358.3,30892,0)
 ;;=F40.248^^91^1335^16
 ;;^UTILITY(U,$J,358.3,30892,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30892,1,3,0)
 ;;=3^Situational Phobia 
 ;;^UTILITY(U,$J,358.3,30892,1,4,0)
 ;;=4^F40.248
 ;;^UTILITY(U,$J,358.3,30892,2)
 ;;=^5003558
 ;;^UTILITY(U,$J,358.3,30893,0)
 ;;=F93.0^^91^1335^15
 ;;^UTILITY(U,$J,358.3,30893,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30893,1,3,0)
 ;;=3^Separation Anxiety Disorder
 ;;^UTILITY(U,$J,358.3,30893,1,4,0)
 ;;=4^F93.0
 ;;^UTILITY(U,$J,358.3,30893,2)
 ;;=^5003702
 ;;^UTILITY(U,$J,358.3,30894,0)
 ;;=F40.00^^91^1335^1
 ;;^UTILITY(U,$J,358.3,30894,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30894,1,3,0)
 ;;=3^Agoraphobia,Unsp
 ;;^UTILITY(U,$J,358.3,30894,1,4,0)
 ;;=4^F40.00
 ;;^UTILITY(U,$J,358.3,30894,2)
 ;;=^5003542
 ;;^UTILITY(U,$J,358.3,30895,0)
 ;;=F41.8^^91^1335^4
 ;;^UTILITY(U,$J,358.3,30895,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30895,1,3,0)
 ;;=3^Anxiety Disorder,Other Specified
 ;;^UTILITY(U,$J,358.3,30895,1,4,0)
 ;;=4^F41.8
 ;;^UTILITY(U,$J,358.3,30895,2)
 ;;=^5003566
 ;;^UTILITY(U,$J,358.3,30896,0)
 ;;=F40.298^^91^1335^13
 ;;^UTILITY(U,$J,358.3,30896,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30896,1,3,0)
 ;;=3^Phobia,Other Specified
 ;;^UTILITY(U,$J,358.3,30896,1,4,0)
 ;;=4^F40.298
 ;;^UTILITY(U,$J,358.3,30896,2)
 ;;=^5003561
 ;;^UTILITY(U,$J,358.3,30897,0)
 ;;=F41.9^^91^1335^5
 ;;^UTILITY(U,$J,358.3,30897,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30897,1,3,0)
 ;;=3^Anxiety Disorder,Unsp
 ;;^UTILITY(U,$J,358.3,30897,1,4,0)
 ;;=4^F41.9
 ;;^UTILITY(U,$J,358.3,30897,2)
 ;;=^5003567
 ;;^UTILITY(U,$J,358.3,30898,0)
 ;;=F94.0^^91^1335^14
 ;;^UTILITY(U,$J,358.3,30898,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30898,1,3,0)
 ;;=3^Selective Mutism
 ;;^UTILITY(U,$J,358.3,30898,1,4,0)
 ;;=4^F94.0
 ;;^UTILITY(U,$J,358.3,30898,2)
 ;;=^331954
 ;;^UTILITY(U,$J,358.3,30899,0)
 ;;=F06.33^^91^1336^1
 ;;^UTILITY(U,$J,358.3,30899,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30899,1,3,0)
 ;;=3^Bipolar & Related Disorder d/t Med Cond w/ Manic Features
 ;;^UTILITY(U,$J,358.3,30899,1,4,0)
 ;;=4^F06.33
 ;;^UTILITY(U,$J,358.3,30899,2)
 ;;=^5003059
 ;;^UTILITY(U,$J,358.3,30900,0)
 ;;=F06.34^^91^1336^2
 ;;^UTILITY(U,$J,358.3,30900,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30900,1,3,0)
 ;;=3^Bipolar & Related Disorder d/t Med Cond w/ Mixed Features
 ;;^UTILITY(U,$J,358.3,30900,1,4,0)
 ;;=4^F06.34
 ;;^UTILITY(U,$J,358.3,30900,2)
 ;;=^5003060
 ;;^UTILITY(U,$J,358.3,30901,0)
 ;;=F31.11^^91^1336^6
 ;;^UTILITY(U,$J,358.3,30901,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30901,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,Mild
 ;;^UTILITY(U,$J,358.3,30901,1,4,0)
 ;;=4^F31.11
 ;;^UTILITY(U,$J,358.3,30901,2)
 ;;=^5003496
 ;;^UTILITY(U,$J,358.3,30902,0)
 ;;=F31.12^^91^1336^7
 ;;^UTILITY(U,$J,358.3,30902,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30902,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,Moderate
 ;;^UTILITY(U,$J,358.3,30902,1,4,0)
 ;;=4^F31.12
 ;;^UTILITY(U,$J,358.3,30902,2)
 ;;=^5003497
 ;;^UTILITY(U,$J,358.3,30903,0)
 ;;=F31.13^^91^1336^8
 ;;^UTILITY(U,$J,358.3,30903,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30903,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,Severe
 ;;^UTILITY(U,$J,358.3,30903,1,4,0)
 ;;=4^F31.13
 ;;^UTILITY(U,$J,358.3,30903,2)
 ;;=^5003498
 ;;^UTILITY(U,$J,358.3,30904,0)
 ;;=F31.2^^91^1336^9
 ;;^UTILITY(U,$J,358.3,30904,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30904,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,w/ Psychotic Features
 ;;^UTILITY(U,$J,358.3,30904,1,4,0)
 ;;=4^F31.2
 ;;^UTILITY(U,$J,358.3,30904,2)
 ;;=^5003499
 ;;^UTILITY(U,$J,358.3,30905,0)
 ;;=F31.73^^91^1336^10
 ;;^UTILITY(U,$J,358.3,30905,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30905,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,In Partial Remission
 ;;^UTILITY(U,$J,358.3,30905,1,4,0)
 ;;=4^F31.73
 ;;^UTILITY(U,$J,358.3,30905,2)
 ;;=^5003513
 ;;^UTILITY(U,$J,358.3,30906,0)
 ;;=F31.74^^91^1336^11
 ;;^UTILITY(U,$J,358.3,30906,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30906,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,In Full Remission
 ;;^UTILITY(U,$J,358.3,30906,1,4,0)
 ;;=4^F31.74
 ;;^UTILITY(U,$J,358.3,30906,2)
 ;;=^5003514

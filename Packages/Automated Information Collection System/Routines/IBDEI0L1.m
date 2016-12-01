IBDEI0L1 ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,26613,2)
 ;;=^5003549
 ;;^UTILITY(U,$J,358.3,26614,0)
 ;;=F40.230^^71^1114^6
 ;;^UTILITY(U,$J,358.3,26614,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26614,1,3,0)
 ;;=3^Fear of Blood
 ;;^UTILITY(U,$J,358.3,26614,1,4,0)
 ;;=4^F40.230
 ;;^UTILITY(U,$J,358.3,26614,2)
 ;;=^5003550
 ;;^UTILITY(U,$J,358.3,26615,0)
 ;;=F40.231^^71^1114^7
 ;;^UTILITY(U,$J,358.3,26615,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26615,1,3,0)
 ;;=3^Fear of Injections & Transfusions
 ;;^UTILITY(U,$J,358.3,26615,1,4,0)
 ;;=4^F40.231
 ;;^UTILITY(U,$J,358.3,26615,2)
 ;;=^5003551
 ;;^UTILITY(U,$J,358.3,26616,0)
 ;;=F40.232^^71^1114^9
 ;;^UTILITY(U,$J,358.3,26616,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26616,1,3,0)
 ;;=3^Fear of Other Medical Care
 ;;^UTILITY(U,$J,358.3,26616,1,4,0)
 ;;=4^F40.232
 ;;^UTILITY(U,$J,358.3,26616,2)
 ;;=^5003552
 ;;^UTILITY(U,$J,358.3,26617,0)
 ;;=F40.233^^71^1114^8
 ;;^UTILITY(U,$J,358.3,26617,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26617,1,3,0)
 ;;=3^Fear of Injury
 ;;^UTILITY(U,$J,358.3,26617,1,4,0)
 ;;=4^F40.233
 ;;^UTILITY(U,$J,358.3,26617,2)
 ;;=^5003553
 ;;^UTILITY(U,$J,358.3,26618,0)
 ;;=F40.248^^71^1114^16
 ;;^UTILITY(U,$J,358.3,26618,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26618,1,3,0)
 ;;=3^Situational Phobia 
 ;;^UTILITY(U,$J,358.3,26618,1,4,0)
 ;;=4^F40.248
 ;;^UTILITY(U,$J,358.3,26618,2)
 ;;=^5003558
 ;;^UTILITY(U,$J,358.3,26619,0)
 ;;=F93.0^^71^1114^15
 ;;^UTILITY(U,$J,358.3,26619,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26619,1,3,0)
 ;;=3^Separation Anxiety Disorder
 ;;^UTILITY(U,$J,358.3,26619,1,4,0)
 ;;=4^F93.0
 ;;^UTILITY(U,$J,358.3,26619,2)
 ;;=^5003702
 ;;^UTILITY(U,$J,358.3,26620,0)
 ;;=F40.00^^71^1114^1
 ;;^UTILITY(U,$J,358.3,26620,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26620,1,3,0)
 ;;=3^Agoraphobia,Unsp
 ;;^UTILITY(U,$J,358.3,26620,1,4,0)
 ;;=4^F40.00
 ;;^UTILITY(U,$J,358.3,26620,2)
 ;;=^5003542
 ;;^UTILITY(U,$J,358.3,26621,0)
 ;;=F41.8^^71^1114^4
 ;;^UTILITY(U,$J,358.3,26621,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26621,1,3,0)
 ;;=3^Anxiety Disorder,Other Specified
 ;;^UTILITY(U,$J,358.3,26621,1,4,0)
 ;;=4^F41.8
 ;;^UTILITY(U,$J,358.3,26621,2)
 ;;=^5003566
 ;;^UTILITY(U,$J,358.3,26622,0)
 ;;=F40.298^^71^1114^13
 ;;^UTILITY(U,$J,358.3,26622,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26622,1,3,0)
 ;;=3^Phobia,Other Specified
 ;;^UTILITY(U,$J,358.3,26622,1,4,0)
 ;;=4^F40.298
 ;;^UTILITY(U,$J,358.3,26622,2)
 ;;=^5003561
 ;;^UTILITY(U,$J,358.3,26623,0)
 ;;=F41.9^^71^1114^5
 ;;^UTILITY(U,$J,358.3,26623,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26623,1,3,0)
 ;;=3^Anxiety Disorder,Unsp
 ;;^UTILITY(U,$J,358.3,26623,1,4,0)
 ;;=4^F41.9
 ;;^UTILITY(U,$J,358.3,26623,2)
 ;;=^5003567
 ;;^UTILITY(U,$J,358.3,26624,0)
 ;;=F94.0^^71^1114^14
 ;;^UTILITY(U,$J,358.3,26624,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26624,1,3,0)
 ;;=3^Selective Mutism
 ;;^UTILITY(U,$J,358.3,26624,1,4,0)
 ;;=4^F94.0
 ;;^UTILITY(U,$J,358.3,26624,2)
 ;;=^331954
 ;;^UTILITY(U,$J,358.3,26625,0)
 ;;=F06.33^^71^1115^1
 ;;^UTILITY(U,$J,358.3,26625,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26625,1,3,0)
 ;;=3^Bipolar & Related Disorder d/t Med Cond w/ Manic Features
 ;;^UTILITY(U,$J,358.3,26625,1,4,0)
 ;;=4^F06.33
 ;;^UTILITY(U,$J,358.3,26625,2)
 ;;=^5003059
 ;;^UTILITY(U,$J,358.3,26626,0)
 ;;=F06.34^^71^1115^2
 ;;^UTILITY(U,$J,358.3,26626,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26626,1,3,0)
 ;;=3^Bipolar & Related Disorder d/t Med Cond w/ Mixed Features
 ;;^UTILITY(U,$J,358.3,26626,1,4,0)
 ;;=4^F06.34
 ;;^UTILITY(U,$J,358.3,26626,2)
 ;;=^5003060
 ;;^UTILITY(U,$J,358.3,26627,0)
 ;;=F31.11^^71^1115^6
 ;;^UTILITY(U,$J,358.3,26627,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26627,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,Mild
 ;;^UTILITY(U,$J,358.3,26627,1,4,0)
 ;;=4^F31.11
 ;;^UTILITY(U,$J,358.3,26627,2)
 ;;=^5003496
 ;;^UTILITY(U,$J,358.3,26628,0)
 ;;=F31.12^^71^1115^7
 ;;^UTILITY(U,$J,358.3,26628,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26628,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,Moderate
 ;;^UTILITY(U,$J,358.3,26628,1,4,0)
 ;;=4^F31.12
 ;;^UTILITY(U,$J,358.3,26628,2)
 ;;=^5003497
 ;;^UTILITY(U,$J,358.3,26629,0)
 ;;=F31.13^^71^1115^8
 ;;^UTILITY(U,$J,358.3,26629,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26629,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,Severe
 ;;^UTILITY(U,$J,358.3,26629,1,4,0)
 ;;=4^F31.13
 ;;^UTILITY(U,$J,358.3,26629,2)
 ;;=^5003498
 ;;^UTILITY(U,$J,358.3,26630,0)
 ;;=F31.2^^71^1115^9
 ;;^UTILITY(U,$J,358.3,26630,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26630,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,w/ Psychotic Features
 ;;^UTILITY(U,$J,358.3,26630,1,4,0)
 ;;=4^F31.2
 ;;^UTILITY(U,$J,358.3,26630,2)
 ;;=^5003499
 ;;^UTILITY(U,$J,358.3,26631,0)
 ;;=F31.73^^71^1115^10
 ;;^UTILITY(U,$J,358.3,26631,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26631,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,In Partial Remission
 ;;^UTILITY(U,$J,358.3,26631,1,4,0)
 ;;=4^F31.73
 ;;^UTILITY(U,$J,358.3,26631,2)
 ;;=^5003513
 ;;^UTILITY(U,$J,358.3,26632,0)
 ;;=F31.74^^71^1115^11
 ;;^UTILITY(U,$J,358.3,26632,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26632,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,In Full Remission
 ;;^UTILITY(U,$J,358.3,26632,1,4,0)
 ;;=4^F31.74
 ;;^UTILITY(U,$J,358.3,26632,2)
 ;;=^5003514
 ;;^UTILITY(U,$J,358.3,26633,0)
 ;;=F31.31^^71^1115^13
 ;;^UTILITY(U,$J,358.3,26633,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26633,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,Mild
 ;;^UTILITY(U,$J,358.3,26633,1,4,0)
 ;;=4^F31.31
 ;;^UTILITY(U,$J,358.3,26633,2)
 ;;=^5003501
 ;;^UTILITY(U,$J,358.3,26634,0)
 ;;=F31.32^^71^1115^14
 ;;^UTILITY(U,$J,358.3,26634,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26634,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,Moderate
 ;;^UTILITY(U,$J,358.3,26634,1,4,0)
 ;;=4^F31.32
 ;;^UTILITY(U,$J,358.3,26634,2)
 ;;=^5003502
 ;;^UTILITY(U,$J,358.3,26635,0)
 ;;=F31.4^^71^1115^15
 ;;^UTILITY(U,$J,358.3,26635,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26635,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,Severe
 ;;^UTILITY(U,$J,358.3,26635,1,4,0)
 ;;=4^F31.4
 ;;^UTILITY(U,$J,358.3,26635,2)
 ;;=^5003503
 ;;^UTILITY(U,$J,358.3,26636,0)
 ;;=F31.5^^71^1115^16
 ;;^UTILITY(U,$J,358.3,26636,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26636,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,w/ Psychotic Features
 ;;^UTILITY(U,$J,358.3,26636,1,4,0)
 ;;=4^F31.5
 ;;^UTILITY(U,$J,358.3,26636,2)
 ;;=^5003504
 ;;^UTILITY(U,$J,358.3,26637,0)
 ;;=F31.75^^71^1115^18
 ;;^UTILITY(U,$J,358.3,26637,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26637,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,In Partial Remission
 ;;^UTILITY(U,$J,358.3,26637,1,4,0)
 ;;=4^F31.75
 ;;^UTILITY(U,$J,358.3,26637,2)
 ;;=^5003515
 ;;^UTILITY(U,$J,358.3,26638,0)
 ;;=F31.76^^71^1115^17
 ;;^UTILITY(U,$J,358.3,26638,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26638,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,In Full Remission
 ;;^UTILITY(U,$J,358.3,26638,1,4,0)
 ;;=4^F31.76
 ;;^UTILITY(U,$J,358.3,26638,2)
 ;;=^5003516
 ;;^UTILITY(U,$J,358.3,26639,0)
 ;;=F31.81^^71^1115^23
 ;;^UTILITY(U,$J,358.3,26639,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26639,1,3,0)
 ;;=3^Bipolar II Disorder
 ;;^UTILITY(U,$J,358.3,26639,1,4,0)
 ;;=4^F31.81
 ;;^UTILITY(U,$J,358.3,26639,2)
 ;;=^5003519
 ;;^UTILITY(U,$J,358.3,26640,0)
 ;;=F34.0^^71^1115^24
 ;;^UTILITY(U,$J,358.3,26640,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26640,1,3,0)
 ;;=3^Cyclothymic Disorder
 ;;^UTILITY(U,$J,358.3,26640,1,4,0)
 ;;=4^F34.0
 ;;^UTILITY(U,$J,358.3,26640,2)
 ;;=^5003538
 ;;^UTILITY(U,$J,358.3,26641,0)
 ;;=F31.0^^71^1115^20
 ;;^UTILITY(U,$J,358.3,26641,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26641,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Hypomanic
 ;;^UTILITY(U,$J,358.3,26641,1,4,0)
 ;;=4^F31.0
 ;;^UTILITY(U,$J,358.3,26641,2)
 ;;=^5003494
 ;;^UTILITY(U,$J,358.3,26642,0)
 ;;=F31.71^^71^1115^22
 ;;^UTILITY(U,$J,358.3,26642,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26642,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Hypomanic,In Partial Remission
 ;;^UTILITY(U,$J,358.3,26642,1,4,0)
 ;;=4^F31.71
 ;;^UTILITY(U,$J,358.3,26642,2)
 ;;=^5003511
 ;;^UTILITY(U,$J,358.3,26643,0)
 ;;=F31.72^^71^1115^21
 ;;^UTILITY(U,$J,358.3,26643,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26643,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Hypomanic,In Full Remission
 ;;^UTILITY(U,$J,358.3,26643,1,4,0)
 ;;=4^F31.72
 ;;^UTILITY(U,$J,358.3,26643,2)
 ;;=^5003512
 ;;^UTILITY(U,$J,358.3,26644,0)
 ;;=F06.33^^71^1115^3
 ;;^UTILITY(U,$J,358.3,26644,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26644,1,3,0)
 ;;=3^Bipolar & Related Disorder d/t Med Cond w/ Manic/Hypomanic-Like Episode
 ;;^UTILITY(U,$J,358.3,26644,1,4,0)
 ;;=4^F06.33
 ;;^UTILITY(U,$J,358.3,26644,2)
 ;;=^5003059
 ;;^UTILITY(U,$J,358.3,26645,0)
 ;;=F31.9^^71^1115^12
 ;;^UTILITY(U,$J,358.3,26645,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26645,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,Unsp
 ;;^UTILITY(U,$J,358.3,26645,1,4,0)
 ;;=4^F31.9
 ;;^UTILITY(U,$J,358.3,26645,2)
 ;;=^331892
 ;;^UTILITY(U,$J,358.3,26646,0)
 ;;=F31.9^^71^1115^19
 ;;^UTILITY(U,$J,358.3,26646,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26646,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,Unsp
 ;;^UTILITY(U,$J,358.3,26646,1,4,0)
 ;;=4^F31.9
 ;;^UTILITY(U,$J,358.3,26646,2)
 ;;=^331892
 ;;^UTILITY(U,$J,358.3,26647,0)
 ;;=F31.89^^71^1115^4
 ;;^UTILITY(U,$J,358.3,26647,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26647,1,3,0)
 ;;=3^Bipolar & Related Disorder,Other Specified

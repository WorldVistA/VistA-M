IBDEI00V ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,336,2)
 ;;=^5003786
 ;;^UTILITY(U,$J,358.3,337,0)
 ;;=G25.1^^3^33^11
 ;;^UTILITY(U,$J,358.3,337,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,337,1,3,0)
 ;;=3^Medication-Induced Postural Tremor
 ;;^UTILITY(U,$J,358.3,337,1,4,0)
 ;;=4^G25.1
 ;;^UTILITY(U,$J,358.3,337,2)
 ;;=^5003792
 ;;^UTILITY(U,$J,358.3,338,0)
 ;;=G25.71^^3^33^14
 ;;^UTILITY(U,$J,358.3,338,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,338,1,3,0)
 ;;=3^Tardive Akathisia
 ;;^UTILITY(U,$J,358.3,338,1,4,0)
 ;;=4^G25.71
 ;;^UTILITY(U,$J,358.3,338,2)
 ;;=^5003799
 ;;^UTILITY(U,$J,358.3,339,0)
 ;;=G25.79^^3^33^9
 ;;^UTILITY(U,$J,358.3,339,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,339,1,3,0)
 ;;=3^Medication-Induced Movement Disorder,Other
 ;;^UTILITY(U,$J,358.3,339,1,4,0)
 ;;=4^G25.79
 ;;^UTILITY(U,$J,358.3,339,2)
 ;;=^5003800
 ;;^UTILITY(U,$J,358.3,340,0)
 ;;=T43.205A^^3^33^4
 ;;^UTILITY(U,$J,358.3,340,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,340,1,3,0)
 ;;=3^Antidepressant Discontinuation Syndrome,Init Encntr
 ;;^UTILITY(U,$J,358.3,340,1,4,0)
 ;;=4^T43.205A
 ;;^UTILITY(U,$J,358.3,340,2)
 ;;=^5050540
 ;;^UTILITY(U,$J,358.3,341,0)
 ;;=T43.205D^^3^33^5
 ;;^UTILITY(U,$J,358.3,341,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,341,1,3,0)
 ;;=3^Antidepressant Discontinuation Syndrome,Subseq Encntr
 ;;^UTILITY(U,$J,358.3,341,1,4,0)
 ;;=4^T43.205D
 ;;^UTILITY(U,$J,358.3,341,2)
 ;;=^5050541
 ;;^UTILITY(U,$J,358.3,342,0)
 ;;=T43.205S^^3^33^6
 ;;^UTILITY(U,$J,358.3,342,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,342,1,3,0)
 ;;=3^Antidepressant Discontinuation Syndrome,Sequela
 ;;^UTILITY(U,$J,358.3,342,1,4,0)
 ;;=4^T43.205S
 ;;^UTILITY(U,$J,358.3,342,2)
 ;;=^5050542
 ;;^UTILITY(U,$J,358.3,343,0)
 ;;=G25.71^^3^33^7
 ;;^UTILITY(U,$J,358.3,343,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,343,1,3,0)
 ;;=3^Medication-Induced Acute Akathisia
 ;;^UTILITY(U,$J,358.3,343,1,4,0)
 ;;=4^G25.71
 ;;^UTILITY(U,$J,358.3,343,2)
 ;;=^5003799
 ;;^UTILITY(U,$J,358.3,344,0)
 ;;=G24.02^^3^33^8
 ;;^UTILITY(U,$J,358.3,344,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,344,1,3,0)
 ;;=3^Medication-Induced Acute Dystonia
 ;;^UTILITY(U,$J,358.3,344,1,4,0)
 ;;=4^G24.02
 ;;^UTILITY(U,$J,358.3,344,2)
 ;;=^5003785
 ;;^UTILITY(U,$J,358.3,345,0)
 ;;=G21.0^^3^33^12
 ;;^UTILITY(U,$J,358.3,345,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,345,1,3,0)
 ;;=3^Neuroleptic Malignant Syndrome
 ;;^UTILITY(U,$J,358.3,345,1,4,0)
 ;;=4^G21.0
 ;;^UTILITY(U,$J,358.3,345,2)
 ;;=^5003771
 ;;^UTILITY(U,$J,358.3,346,0)
 ;;=T50.905A^^3^33^1
 ;;^UTILITY(U,$J,358.3,346,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,346,1,3,0)
 ;;=3^Adverse Effect of Medication,Other,Init Encntr
 ;;^UTILITY(U,$J,358.3,346,1,4,0)
 ;;=4^T50.905A
 ;;^UTILITY(U,$J,358.3,346,2)
 ;;=^5052160
 ;;^UTILITY(U,$J,358.3,347,0)
 ;;=T50.905S^^3^33^2
 ;;^UTILITY(U,$J,358.3,347,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,347,1,3,0)
 ;;=3^Adverse Effect of Medication,Other,Sequela
 ;;^UTILITY(U,$J,358.3,347,1,4,0)
 ;;=4^T50.905S
 ;;^UTILITY(U,$J,358.3,347,2)
 ;;=^5052162
 ;;^UTILITY(U,$J,358.3,348,0)
 ;;=T50.905D^^3^33^3
 ;;^UTILITY(U,$J,358.3,348,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,348,1,3,0)
 ;;=3^Adverse Effect of Medication,Other,Subseq Encntr
 ;;^UTILITY(U,$J,358.3,348,1,4,0)
 ;;=4^T50.905D
 ;;^UTILITY(U,$J,358.3,348,2)
 ;;=^5052161
 ;;^UTILITY(U,$J,358.3,349,0)
 ;;=F42.^^3^34^5
 ;;^UTILITY(U,$J,358.3,349,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,349,1,3,0)
 ;;=3^Obsessive-Compulsive Disorder
 ;;^UTILITY(U,$J,358.3,349,1,4,0)
 ;;=4^F42.
 ;;^UTILITY(U,$J,358.3,349,2)
 ;;=^5003568
 ;;^UTILITY(U,$J,358.3,350,0)
 ;;=F45.22^^3^34^1
 ;;^UTILITY(U,$J,358.3,350,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,350,1,3,0)
 ;;=3^Body Dysmorphic Disorder
 ;;^UTILITY(U,$J,358.3,350,1,4,0)
 ;;=4^F45.22
 ;;^UTILITY(U,$J,358.3,350,2)
 ;;=^5003588
 ;;^UTILITY(U,$J,358.3,351,0)
 ;;=F63.3^^3^34^6
 ;;^UTILITY(U,$J,358.3,351,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,351,1,3,0)
 ;;=3^Trichotillomania (Hair-Pulling Disorder)
 ;;^UTILITY(U,$J,358.3,351,1,4,0)
 ;;=4^F63.3
 ;;^UTILITY(U,$J,358.3,351,2)
 ;;=^5003643
 ;;^UTILITY(U,$J,358.3,352,0)
 ;;=L98.1^^3^34^2
 ;;^UTILITY(U,$J,358.3,352,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,352,1,3,0)
 ;;=3^Excoriation (Skin-Picking) Disorder
 ;;^UTILITY(U,$J,358.3,352,1,4,0)
 ;;=4^L98.1
 ;;^UTILITY(U,$J,358.3,352,2)
 ;;=^186781
 ;;^UTILITY(U,$J,358.3,353,0)
 ;;=F42.^^3^34^3
 ;;^UTILITY(U,$J,358.3,353,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,353,1,3,0)
 ;;=3^Hoarding Disorder
 ;;^UTILITY(U,$J,358.3,353,1,4,0)
 ;;=4^F42.
 ;;^UTILITY(U,$J,358.3,353,2)
 ;;=^5003568
 ;;^UTILITY(U,$J,358.3,354,0)
 ;;=F06.8^^3^34^4
 ;;^UTILITY(U,$J,358.3,354,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,354,1,3,0)
 ;;=3^Obsessive-Compulsive & Related Disorder d/t Another Med Condition
 ;;^UTILITY(U,$J,358.3,354,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,354,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,355,0)
 ;;=Z91.49^^3^35^12
 ;;^UTILITY(U,$J,358.3,355,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,355,1,3,0)
 ;;=3^Personal Hx of Psychological Trauma
 ;;^UTILITY(U,$J,358.3,355,1,4,0)
 ;;=4^Z91.49
 ;;^UTILITY(U,$J,358.3,355,2)
 ;;=^5063623
 ;;^UTILITY(U,$J,358.3,356,0)
 ;;=Z91.5^^3^35^13
 ;;^UTILITY(U,$J,358.3,356,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,356,1,3,0)
 ;;=3^Personal Hx of Self-Harm
 ;;^UTILITY(U,$J,358.3,356,1,4,0)
 ;;=4^Z91.5
 ;;^UTILITY(U,$J,358.3,356,2)
 ;;=^5063624
 ;;^UTILITY(U,$J,358.3,357,0)
 ;;=Z91.82^^3^35^11
 ;;^UTILITY(U,$J,358.3,357,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,357,1,3,0)
 ;;=3^Personal Hx of Military Deployment
 ;;^UTILITY(U,$J,358.3,357,1,4,0)
 ;;=4^Z91.82
 ;;^UTILITY(U,$J,358.3,357,2)
 ;;=^5063626
 ;;^UTILITY(U,$J,358.3,358,0)
 ;;=Z91.89^^3^35^18
 ;;^UTILITY(U,$J,358.3,358,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,358,1,3,0)
 ;;=3^Personal Risk Factors
 ;;^UTILITY(U,$J,358.3,358,1,4,0)
 ;;=4^Z91.89
 ;;^UTILITY(U,$J,358.3,358,2)
 ;;=^5063628
 ;;^UTILITY(U,$J,358.3,359,0)
 ;;=Z72.9^^3^35^19
 ;;^UTILITY(U,$J,358.3,359,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,359,1,3,0)
 ;;=3^Problem Related to Lifestyle
 ;;^UTILITY(U,$J,358.3,359,1,4,0)
 ;;=4^Z72.9
 ;;^UTILITY(U,$J,358.3,359,2)
 ;;=^5063267
 ;;^UTILITY(U,$J,358.3,360,0)
 ;;=Z72.811^^3^35^1
 ;;^UTILITY(U,$J,358.3,360,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,360,1,3,0)
 ;;=3^Adult Antisocial Behavior
 ;;^UTILITY(U,$J,358.3,360,1,4,0)
 ;;=4^Z72.811
 ;;^UTILITY(U,$J,358.3,360,2)
 ;;=^5063263
 ;;^UTILITY(U,$J,358.3,361,0)
 ;;=Z91.19^^3^35^5
 ;;^UTILITY(U,$J,358.3,361,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,361,1,3,0)
 ;;=3^Nonadherence to Medical Treatment
 ;;^UTILITY(U,$J,358.3,361,1,4,0)
 ;;=4^Z91.19
 ;;^UTILITY(U,$J,358.3,361,2)
 ;;=^5063618
 ;;^UTILITY(U,$J,358.3,362,0)
 ;;=E66.9^^3^35^6
 ;;^UTILITY(U,$J,358.3,362,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,362,1,3,0)
 ;;=3^Overweight or Obesity
 ;;^UTILITY(U,$J,358.3,362,1,4,0)
 ;;=4^E66.9
 ;;^UTILITY(U,$J,358.3,362,2)
 ;;=^5002832
 ;;^UTILITY(U,$J,358.3,363,0)
 ;;=Z76.5^^3^35^3
 ;;^UTILITY(U,$J,358.3,363,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,363,1,3,0)
 ;;=3^Malingering
 ;;^UTILITY(U,$J,358.3,363,1,4,0)
 ;;=4^Z76.5
 ;;^UTILITY(U,$J,358.3,363,2)
 ;;=^5063302
 ;;^UTILITY(U,$J,358.3,364,0)
 ;;=R41.83^^3^35^2
 ;;^UTILITY(U,$J,358.3,364,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,364,1,3,0)
 ;;=3^Borderline Intellectual Functioning
 ;;^UTILITY(U,$J,358.3,364,1,4,0)
 ;;=4^R41.83
 ;;^UTILITY(U,$J,358.3,364,2)
 ;;=^5019442
 ;;^UTILITY(U,$J,358.3,365,0)
 ;;=Z56.82^^3^35^4
 ;;^UTILITY(U,$J,358.3,365,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,365,1,3,0)
 ;;=3^Military Deployment Status,Current
 ;;^UTILITY(U,$J,358.3,365,1,4,0)
 ;;=4^Z56.82
 ;;^UTILITY(U,$J,358.3,365,2)
 ;;=^5063115
 ;;^UTILITY(U,$J,358.3,366,0)
 ;;=Z62.811^^3^35^9

IBDEI0O5 ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24344,0)
 ;;=F43.21^^92^1130^3
 ;;^UTILITY(U,$J,358.3,24344,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24344,1,3,0)
 ;;=3^Adjustment Disorder w/ Depressed Mood
 ;;^UTILITY(U,$J,358.3,24344,1,4,0)
 ;;=4^F43.21
 ;;^UTILITY(U,$J,358.3,24344,2)
 ;;=^331948
 ;;^UTILITY(U,$J,358.3,24345,0)
 ;;=F43.22^^92^1130^2
 ;;^UTILITY(U,$J,358.3,24345,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24345,1,3,0)
 ;;=3^Adjustment Disorder w/ Anxiety
 ;;^UTILITY(U,$J,358.3,24345,1,4,0)
 ;;=4^F43.22
 ;;^UTILITY(U,$J,358.3,24345,2)
 ;;=^331949
 ;;^UTILITY(U,$J,358.3,24346,0)
 ;;=F43.23^^92^1130^5
 ;;^UTILITY(U,$J,358.3,24346,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24346,1,3,0)
 ;;=3^Adjustment Disorder w/ Mixed Anxiety & Depressed Mood
 ;;^UTILITY(U,$J,358.3,24346,1,4,0)
 ;;=4^F43.23
 ;;^UTILITY(U,$J,358.3,24346,2)
 ;;=^331950
 ;;^UTILITY(U,$J,358.3,24347,0)
 ;;=F43.24^^92^1130^4
 ;;^UTILITY(U,$J,358.3,24347,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24347,1,3,0)
 ;;=3^Adjustment Disorder w/ Disturbance of Conduct
 ;;^UTILITY(U,$J,358.3,24347,1,4,0)
 ;;=4^F43.24
 ;;^UTILITY(U,$J,358.3,24347,2)
 ;;=^331951
 ;;^UTILITY(U,$J,358.3,24348,0)
 ;;=F43.25^^92^1130^6
 ;;^UTILITY(U,$J,358.3,24348,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24348,1,3,0)
 ;;=3^Adjustment Disorder w/ Mixed Disturbance Emotions & Conduct
 ;;^UTILITY(U,$J,358.3,24348,1,4,0)
 ;;=4^F43.25
 ;;^UTILITY(U,$J,358.3,24348,2)
 ;;=^331952
 ;;^UTILITY(U,$J,358.3,24349,0)
 ;;=F43.20^^92^1130^7
 ;;^UTILITY(U,$J,358.3,24349,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24349,1,3,0)
 ;;=3^Adjustment Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,24349,1,4,0)
 ;;=4^F43.20
 ;;^UTILITY(U,$J,358.3,24349,2)
 ;;=^5003573
 ;;^UTILITY(U,$J,358.3,24350,0)
 ;;=F43.9^^92^1130^12
 ;;^UTILITY(U,$J,358.3,24350,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24350,1,3,0)
 ;;=3^Trauma/Stressor-Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,24350,1,4,0)
 ;;=4^F43.9
 ;;^UTILITY(U,$J,358.3,24350,2)
 ;;=^5003576
 ;;^UTILITY(U,$J,358.3,24351,0)
 ;;=F94.1^^92^1130^10
 ;;^UTILITY(U,$J,358.3,24351,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24351,1,3,0)
 ;;=3^Reactive Attachment Disorder
 ;;^UTILITY(U,$J,358.3,24351,1,4,0)
 ;;=4^F94.1
 ;;^UTILITY(U,$J,358.3,24351,2)
 ;;=^5003705
 ;;^UTILITY(U,$J,358.3,24352,0)
 ;;=F94.2^^92^1130^8
 ;;^UTILITY(U,$J,358.3,24352,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24352,1,3,0)
 ;;=3^Disinhibited Social Engagement Disorder
 ;;^UTILITY(U,$J,358.3,24352,1,4,0)
 ;;=4^F94.2
 ;;^UTILITY(U,$J,358.3,24352,2)
 ;;=^5003706
 ;;^UTILITY(U,$J,358.3,24353,0)
 ;;=F43.8^^92^1130^11
 ;;^UTILITY(U,$J,358.3,24353,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24353,1,3,0)
 ;;=3^Trauma/Stressor-Related Disorder,Other Specified
 ;;^UTILITY(U,$J,358.3,24353,1,4,0)
 ;;=4^F43.8
 ;;^UTILITY(U,$J,358.3,24353,2)
 ;;=^5003575
 ;;^UTILITY(U,$J,358.3,24354,0)
 ;;=F43.10^^92^1130^9
 ;;^UTILITY(U,$J,358.3,24354,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24354,1,3,0)
 ;;=3^Post-traumatic Stress Disorder
 ;;^UTILITY(U,$J,358.3,24354,1,4,0)
 ;;=4^F43.10
 ;;^UTILITY(U,$J,358.3,24354,2)
 ;;=^5003570
 ;;^UTILITY(U,$J,358.3,24355,0)
 ;;=F18.10^^92^1131^23
 ;;^UTILITY(U,$J,358.3,24355,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24355,1,3,0)
 ;;=3^Inhalant Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,24355,1,4,0)
 ;;=4^F18.10
 ;;^UTILITY(U,$J,358.3,24355,2)
 ;;=^5003380
 ;;^UTILITY(U,$J,358.3,24356,0)
 ;;=F18.20^^92^1131^24
 ;;^UTILITY(U,$J,358.3,24356,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24356,1,3,0)
 ;;=3^Inhalant Use Disorder,Moderate
 ;;^UTILITY(U,$J,358.3,24356,1,4,0)
 ;;=4^F18.20
 ;;^UTILITY(U,$J,358.3,24356,2)
 ;;=^5003392
 ;;^UTILITY(U,$J,358.3,24357,0)
 ;;=F18.14^^92^1131^4
 ;;^UTILITY(U,$J,358.3,24357,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24357,1,3,0)
 ;;=3^Inhalant Induced Depressive Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,24357,1,4,0)
 ;;=4^F18.14
 ;;^UTILITY(U,$J,358.3,24357,2)
 ;;=^5003384
 ;;^UTILITY(U,$J,358.3,24358,0)
 ;;=F18.24^^92^1131^5
 ;;^UTILITY(U,$J,358.3,24358,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24358,1,3,0)
 ;;=3^Inhalant Induced Depressive Disorder w/ Moderate to Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,24358,1,4,0)
 ;;=4^F18.24
 ;;^UTILITY(U,$J,358.3,24358,2)
 ;;=^5003397
 ;;^UTILITY(U,$J,358.3,24359,0)
 ;;=F18.121^^92^1131^16
 ;;^UTILITY(U,$J,358.3,24359,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24359,1,3,0)
 ;;=3^Inhalant Intoxication Delirium w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,24359,1,4,0)
 ;;=4^F18.121
 ;;^UTILITY(U,$J,358.3,24359,2)
 ;;=^5003382
 ;;^UTILITY(U,$J,358.3,24360,0)
 ;;=F18.221^^92^1131^17
 ;;^UTILITY(U,$J,358.3,24360,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24360,1,3,0)
 ;;=3^Inhalant Intoxication Delirium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,24360,1,4,0)
 ;;=4^F18.221
 ;;^UTILITY(U,$J,358.3,24360,2)
 ;;=^5003395
 ;;^UTILITY(U,$J,358.3,24361,0)
 ;;=F18.921^^92^1131^18
 ;;^UTILITY(U,$J,358.3,24361,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24361,1,3,0)
 ;;=3^Inhalant Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,24361,1,4,0)
 ;;=4^F18.921
 ;;^UTILITY(U,$J,358.3,24361,2)
 ;;=^5003407
 ;;^UTILITY(U,$J,358.3,24362,0)
 ;;=F18.129^^92^1131^19
 ;;^UTILITY(U,$J,358.3,24362,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24362,1,3,0)
 ;;=3^Inhalant Intoxication w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,24362,1,4,0)
 ;;=4^F18.129
 ;;^UTILITY(U,$J,358.3,24362,2)
 ;;=^5003383
 ;;^UTILITY(U,$J,358.3,24363,0)
 ;;=F18.229^^92^1131^20
 ;;^UTILITY(U,$J,358.3,24363,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24363,1,3,0)
 ;;=3^Inhalant Intoxication w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,24363,1,4,0)
 ;;=4^F18.229
 ;;^UTILITY(U,$J,358.3,24363,2)
 ;;=^5003396
 ;;^UTILITY(U,$J,358.3,24364,0)
 ;;=F18.929^^92^1131^21
 ;;^UTILITY(U,$J,358.3,24364,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24364,1,3,0)
 ;;=3^Inhalant Intoxication w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,24364,1,4,0)
 ;;=4^F18.929
 ;;^UTILITY(U,$J,358.3,24364,2)
 ;;=^5003408
 ;;^UTILITY(U,$J,358.3,24365,0)
 ;;=F18.180^^92^1131^1
 ;;^UTILITY(U,$J,358.3,24365,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24365,1,3,0)
 ;;=3^Inhalant Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,24365,1,4,0)
 ;;=4^F18.180
 ;;^UTILITY(U,$J,358.3,24365,2)
 ;;=^5003389
 ;;^UTILITY(U,$J,358.3,24366,0)
 ;;=F18.280^^92^1131^2
 ;;^UTILITY(U,$J,358.3,24366,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24366,1,3,0)
 ;;=3^Inhalant Induced Anxiety Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,24366,1,4,0)
 ;;=4^F18.280
 ;;^UTILITY(U,$J,358.3,24366,2)
 ;;=^5003402
 ;;^UTILITY(U,$J,358.3,24367,0)
 ;;=F18.980^^92^1131^3
 ;;^UTILITY(U,$J,358.3,24367,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24367,1,3,0)
 ;;=3^Inhalant Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,24367,1,4,0)
 ;;=4^F18.980
 ;;^UTILITY(U,$J,358.3,24367,2)
 ;;=^5003414
 ;;^UTILITY(U,$J,358.3,24368,0)
 ;;=F18.94^^92^1131^6
 ;;^UTILITY(U,$J,358.3,24368,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24368,1,3,0)
 ;;=3^Inhalant Induced Depressive Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,24368,1,4,0)
 ;;=4^F18.94
 ;;^UTILITY(U,$J,358.3,24368,2)
 ;;=^5003409
 ;;^UTILITY(U,$J,358.3,24369,0)
 ;;=F18.17^^92^1131^7
 ;;^UTILITY(U,$J,358.3,24369,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24369,1,3,0)
 ;;=3^Inhalant Induced Major Neurocog Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,24369,1,4,0)
 ;;=4^F18.17
 ;;^UTILITY(U,$J,358.3,24369,2)
 ;;=^5003388
 ;;^UTILITY(U,$J,358.3,24370,0)
 ;;=F18.27^^92^1131^8
 ;;^UTILITY(U,$J,358.3,24370,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24370,1,3,0)
 ;;=3^Inhalant Induced Major Neurocog Disorder w/ Mod/Severe Use Disorder

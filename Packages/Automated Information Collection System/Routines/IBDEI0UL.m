IBDEI0UL ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,40201,2)
 ;;=^331948
 ;;^UTILITY(U,$J,358.3,40202,0)
 ;;=F43.22^^114^1697^2
 ;;^UTILITY(U,$J,358.3,40202,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40202,1,3,0)
 ;;=3^Adjustment Disorder w/ Anxiety
 ;;^UTILITY(U,$J,358.3,40202,1,4,0)
 ;;=4^F43.22
 ;;^UTILITY(U,$J,358.3,40202,2)
 ;;=^331949
 ;;^UTILITY(U,$J,358.3,40203,0)
 ;;=F43.23^^114^1697^5
 ;;^UTILITY(U,$J,358.3,40203,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40203,1,3,0)
 ;;=3^Adjustment Disorder w/ Mixed Anxiety & Depressed Mood
 ;;^UTILITY(U,$J,358.3,40203,1,4,0)
 ;;=4^F43.23
 ;;^UTILITY(U,$J,358.3,40203,2)
 ;;=^331950
 ;;^UTILITY(U,$J,358.3,40204,0)
 ;;=F43.24^^114^1697^4
 ;;^UTILITY(U,$J,358.3,40204,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40204,1,3,0)
 ;;=3^Adjustment Disorder w/ Disturbance of Conduct
 ;;^UTILITY(U,$J,358.3,40204,1,4,0)
 ;;=4^F43.24
 ;;^UTILITY(U,$J,358.3,40204,2)
 ;;=^331951
 ;;^UTILITY(U,$J,358.3,40205,0)
 ;;=F43.25^^114^1697^6
 ;;^UTILITY(U,$J,358.3,40205,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40205,1,3,0)
 ;;=3^Adjustment Disorder w/ Mixed Disturbance Emotions & Conduct
 ;;^UTILITY(U,$J,358.3,40205,1,4,0)
 ;;=4^F43.25
 ;;^UTILITY(U,$J,358.3,40205,2)
 ;;=^331952
 ;;^UTILITY(U,$J,358.3,40206,0)
 ;;=F43.20^^114^1697^7
 ;;^UTILITY(U,$J,358.3,40206,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40206,1,3,0)
 ;;=3^Adjustment Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,40206,1,4,0)
 ;;=4^F43.20
 ;;^UTILITY(U,$J,358.3,40206,2)
 ;;=^5003573
 ;;^UTILITY(U,$J,358.3,40207,0)
 ;;=F43.9^^114^1697^12
 ;;^UTILITY(U,$J,358.3,40207,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40207,1,3,0)
 ;;=3^Trauma/Stressor-Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,40207,1,4,0)
 ;;=4^F43.9
 ;;^UTILITY(U,$J,358.3,40207,2)
 ;;=^5003576
 ;;^UTILITY(U,$J,358.3,40208,0)
 ;;=F94.1^^114^1697^10
 ;;^UTILITY(U,$J,358.3,40208,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40208,1,3,0)
 ;;=3^Reactive Attachment Disorder
 ;;^UTILITY(U,$J,358.3,40208,1,4,0)
 ;;=4^F94.1
 ;;^UTILITY(U,$J,358.3,40208,2)
 ;;=^5003705
 ;;^UTILITY(U,$J,358.3,40209,0)
 ;;=F94.2^^114^1697^8
 ;;^UTILITY(U,$J,358.3,40209,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40209,1,3,0)
 ;;=3^Disinhibited Social Engagement Disorder
 ;;^UTILITY(U,$J,358.3,40209,1,4,0)
 ;;=4^F94.2
 ;;^UTILITY(U,$J,358.3,40209,2)
 ;;=^5003706
 ;;^UTILITY(U,$J,358.3,40210,0)
 ;;=F43.8^^114^1697^11
 ;;^UTILITY(U,$J,358.3,40210,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40210,1,3,0)
 ;;=3^Trauma/Stressor-Related Disorder,Other Specified
 ;;^UTILITY(U,$J,358.3,40210,1,4,0)
 ;;=4^F43.8
 ;;^UTILITY(U,$J,358.3,40210,2)
 ;;=^5003575
 ;;^UTILITY(U,$J,358.3,40211,0)
 ;;=F43.10^^114^1697^9
 ;;^UTILITY(U,$J,358.3,40211,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40211,1,3,0)
 ;;=3^Post-traumatic Stress Disorder
 ;;^UTILITY(U,$J,358.3,40211,1,4,0)
 ;;=4^F43.10
 ;;^UTILITY(U,$J,358.3,40211,2)
 ;;=^5003570
 ;;^UTILITY(U,$J,358.3,40212,0)
 ;;=F18.10^^114^1698^23
 ;;^UTILITY(U,$J,358.3,40212,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40212,1,3,0)
 ;;=3^Inhalant Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,40212,1,4,0)
 ;;=4^F18.10
 ;;^UTILITY(U,$J,358.3,40212,2)
 ;;=^5003380
 ;;^UTILITY(U,$J,358.3,40213,0)
 ;;=F18.20^^114^1698^24
 ;;^UTILITY(U,$J,358.3,40213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40213,1,3,0)
 ;;=3^Inhalant Use Disorder,Moderate
 ;;^UTILITY(U,$J,358.3,40213,1,4,0)
 ;;=4^F18.20
 ;;^UTILITY(U,$J,358.3,40213,2)
 ;;=^5003392
 ;;^UTILITY(U,$J,358.3,40214,0)
 ;;=F18.14^^114^1698^4
 ;;^UTILITY(U,$J,358.3,40214,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40214,1,3,0)
 ;;=3^Inhalant Induced Depressive Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,40214,1,4,0)
 ;;=4^F18.14
 ;;^UTILITY(U,$J,358.3,40214,2)
 ;;=^5003384
 ;;^UTILITY(U,$J,358.3,40215,0)
 ;;=F18.24^^114^1698^5
 ;;^UTILITY(U,$J,358.3,40215,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40215,1,3,0)
 ;;=3^Inhalant Induced Depressive Disorder w/ Moderate to Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,40215,1,4,0)
 ;;=4^F18.24
 ;;^UTILITY(U,$J,358.3,40215,2)
 ;;=^5003397
 ;;^UTILITY(U,$J,358.3,40216,0)
 ;;=F18.121^^114^1698^16
 ;;^UTILITY(U,$J,358.3,40216,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40216,1,3,0)
 ;;=3^Inhalant Intoxication Delirium w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,40216,1,4,0)
 ;;=4^F18.121
 ;;^UTILITY(U,$J,358.3,40216,2)
 ;;=^5003382
 ;;^UTILITY(U,$J,358.3,40217,0)
 ;;=F18.221^^114^1698^17
 ;;^UTILITY(U,$J,358.3,40217,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40217,1,3,0)
 ;;=3^Inhalant Intoxication Delirium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,40217,1,4,0)
 ;;=4^F18.221
 ;;^UTILITY(U,$J,358.3,40217,2)
 ;;=^5003395
 ;;^UTILITY(U,$J,358.3,40218,0)
 ;;=F18.921^^114^1698^18
 ;;^UTILITY(U,$J,358.3,40218,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40218,1,3,0)
 ;;=3^Inhalant Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,40218,1,4,0)
 ;;=4^F18.921
 ;;^UTILITY(U,$J,358.3,40218,2)
 ;;=^5003407
 ;;^UTILITY(U,$J,358.3,40219,0)
 ;;=F18.129^^114^1698^19
 ;;^UTILITY(U,$J,358.3,40219,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40219,1,3,0)
 ;;=3^Inhalant Intoxication w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,40219,1,4,0)
 ;;=4^F18.129
 ;;^UTILITY(U,$J,358.3,40219,2)
 ;;=^5003383
 ;;^UTILITY(U,$J,358.3,40220,0)
 ;;=F18.229^^114^1698^20
 ;;^UTILITY(U,$J,358.3,40220,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40220,1,3,0)
 ;;=3^Inhalant Intoxication w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,40220,1,4,0)
 ;;=4^F18.229
 ;;^UTILITY(U,$J,358.3,40220,2)
 ;;=^5003396
 ;;^UTILITY(U,$J,358.3,40221,0)
 ;;=F18.929^^114^1698^21
 ;;^UTILITY(U,$J,358.3,40221,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40221,1,3,0)
 ;;=3^Inhalant Intoxication w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,40221,1,4,0)
 ;;=4^F18.929
 ;;^UTILITY(U,$J,358.3,40221,2)
 ;;=^5003408
 ;;^UTILITY(U,$J,358.3,40222,0)
 ;;=F18.180^^114^1698^1
 ;;^UTILITY(U,$J,358.3,40222,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40222,1,3,0)
 ;;=3^Inhalant Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,40222,1,4,0)
 ;;=4^F18.180
 ;;^UTILITY(U,$J,358.3,40222,2)
 ;;=^5003389
 ;;^UTILITY(U,$J,358.3,40223,0)
 ;;=F18.280^^114^1698^2
 ;;^UTILITY(U,$J,358.3,40223,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40223,1,3,0)
 ;;=3^Inhalant Induced Anxiety Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,40223,1,4,0)
 ;;=4^F18.280
 ;;^UTILITY(U,$J,358.3,40223,2)
 ;;=^5003402
 ;;^UTILITY(U,$J,358.3,40224,0)
 ;;=F18.980^^114^1698^3
 ;;^UTILITY(U,$J,358.3,40224,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40224,1,3,0)
 ;;=3^Inhalant Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,40224,1,4,0)
 ;;=4^F18.980
 ;;^UTILITY(U,$J,358.3,40224,2)
 ;;=^5003414
 ;;^UTILITY(U,$J,358.3,40225,0)
 ;;=F18.94^^114^1698^6
 ;;^UTILITY(U,$J,358.3,40225,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40225,1,3,0)
 ;;=3^Inhalant Induced Depressive Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,40225,1,4,0)
 ;;=4^F18.94
 ;;^UTILITY(U,$J,358.3,40225,2)
 ;;=^5003409
 ;;^UTILITY(U,$J,358.3,40226,0)
 ;;=F18.17^^114^1698^7
 ;;^UTILITY(U,$J,358.3,40226,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40226,1,3,0)
 ;;=3^Inhalant Induced Major Neurocog Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,40226,1,4,0)
 ;;=4^F18.17
 ;;^UTILITY(U,$J,358.3,40226,2)
 ;;=^5003388
 ;;^UTILITY(U,$J,358.3,40227,0)
 ;;=F18.27^^114^1698^8
 ;;^UTILITY(U,$J,358.3,40227,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40227,1,3,0)
 ;;=3^Inhalant Induced Major Neurocog Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,40227,1,4,0)
 ;;=4^F18.27
 ;;^UTILITY(U,$J,358.3,40227,2)
 ;;=^5003401
 ;;^UTILITY(U,$J,358.3,40228,0)
 ;;=F18.97^^114^1698^9
 ;;^UTILITY(U,$J,358.3,40228,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40228,1,3,0)
 ;;=3^Inhalant Induced Major Neurocog Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,40228,1,4,0)
 ;;=4^F18.97
 ;;^UTILITY(U,$J,358.3,40228,2)
 ;;=^5003413
 ;;^UTILITY(U,$J,358.3,40229,0)
 ;;=F18.188^^114^1698^10
 ;;^UTILITY(U,$J,358.3,40229,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40229,1,3,0)
 ;;=3^Inhalant Induced Mild Neurocog Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,40229,1,4,0)
 ;;=4^F18.188
 ;;^UTILITY(U,$J,358.3,40229,2)
 ;;=^5003390
 ;;^UTILITY(U,$J,358.3,40230,0)
 ;;=F18.288^^114^1698^11
 ;;^UTILITY(U,$J,358.3,40230,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40230,1,3,0)
 ;;=3^Inhalant Induced Mild Neurocog Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,40230,1,4,0)
 ;;=4^F18.288
 ;;^UTILITY(U,$J,358.3,40230,2)
 ;;=^5003403
 ;;^UTILITY(U,$J,358.3,40231,0)
 ;;=F18.988^^114^1698^12
 ;;^UTILITY(U,$J,358.3,40231,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40231,1,3,0)
 ;;=3^Inhalant Induced Mild Neurocog Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,40231,1,4,0)
 ;;=4^F18.988
 ;;^UTILITY(U,$J,358.3,40231,2)
 ;;=^5003415
 ;;^UTILITY(U,$J,358.3,40232,0)
 ;;=F18.159^^114^1698^13
 ;;^UTILITY(U,$J,358.3,40232,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40232,1,3,0)
 ;;=3^Inhalant Induced Psychotic Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,40232,1,4,0)
 ;;=4^F18.159
 ;;^UTILITY(U,$J,358.3,40232,2)
 ;;=^5003387
 ;;^UTILITY(U,$J,358.3,40233,0)
 ;;=F18.259^^114^1698^14
 ;;^UTILITY(U,$J,358.3,40233,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40233,1,3,0)
 ;;=3^Inhalant Induced Psychotic Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,40233,1,4,0)
 ;;=4^F18.259
 ;;^UTILITY(U,$J,358.3,40233,2)
 ;;=^5003400
 ;;^UTILITY(U,$J,358.3,40234,0)
 ;;=F18.959^^114^1698^15
 ;;^UTILITY(U,$J,358.3,40234,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40234,1,3,0)
 ;;=3^Inhalant Induced Psychotic Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,40234,1,4,0)
 ;;=4^F18.959
 ;;^UTILITY(U,$J,358.3,40234,2)
 ;;=^5003412
 ;;^UTILITY(U,$J,358.3,40235,0)
 ;;=F18.99^^114^1698^22

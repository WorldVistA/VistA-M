IBDEI10R ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,36971,0)
 ;;=F13.231^^135^1824^36
 ;;^UTILITY(U,$J,358.3,36971,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36971,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,36971,1,4,0)
 ;;=4^F13.231
 ;;^UTILITY(U,$J,358.3,36971,2)
 ;;=^5003207
 ;;^UTILITY(U,$J,358.3,36972,0)
 ;;=F13.99^^135^1824^30
 ;;^UTILITY(U,$J,358.3,36972,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36972,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Related D/O,Unspec
 ;;^UTILITY(U,$J,358.3,36972,1,4,0)
 ;;=4^F13.99
 ;;^UTILITY(U,$J,358.3,36972,2)
 ;;=^5133353
 ;;^UTILITY(U,$J,358.3,36973,0)
 ;;=F17.200^^135^1825^4
 ;;^UTILITY(U,$J,358.3,36973,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36973,1,3,0)
 ;;=3^Tobacco Use Disorder,Moderate
 ;;^UTILITY(U,$J,358.3,36973,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,36973,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,36974,0)
 ;;=F17.203^^135^1825^6
 ;;^UTILITY(U,$J,358.3,36974,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36974,1,3,0)
 ;;=3^Tobacco Withdrawal
 ;;^UTILITY(U,$J,358.3,36974,1,4,0)
 ;;=4^F17.203
 ;;^UTILITY(U,$J,358.3,36974,2)
 ;;=^5003362
 ;;^UTILITY(U,$J,358.3,36975,0)
 ;;=F17.208^^135^1825^1
 ;;^UTILITY(U,$J,358.3,36975,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36975,1,3,0)
 ;;=3^Nicotine Induced Sleep Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,36975,1,4,0)
 ;;=4^F17.208
 ;;^UTILITY(U,$J,358.3,36975,2)
 ;;=^5003363
 ;;^UTILITY(U,$J,358.3,36976,0)
 ;;=F17.209^^135^1825^2
 ;;^UTILITY(U,$J,358.3,36976,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36976,1,3,0)
 ;;=3^Nicotine Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,36976,1,4,0)
 ;;=4^F17.209
 ;;^UTILITY(U,$J,358.3,36976,2)
 ;;=^5003364
 ;;^UTILITY(U,$J,358.3,36977,0)
 ;;=Z72.0^^135^1825^3
 ;;^UTILITY(U,$J,358.3,36977,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36977,1,3,0)
 ;;=3^Tobacco Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,36977,1,4,0)
 ;;=4^Z72.0
 ;;^UTILITY(U,$J,358.3,36977,2)
 ;;=^5063255
 ;;^UTILITY(U,$J,358.3,36978,0)
 ;;=F17.200^^135^1825^5
 ;;^UTILITY(U,$J,358.3,36978,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36978,1,3,0)
 ;;=3^Tobacco Use Disorder,Severe
 ;;^UTILITY(U,$J,358.3,36978,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,36978,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,36979,0)
 ;;=F43.0^^135^1826^1
 ;;^UTILITY(U,$J,358.3,36979,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36979,1,3,0)
 ;;=3^Acute Stress Disorder
 ;;^UTILITY(U,$J,358.3,36979,1,4,0)
 ;;=4^F43.0
 ;;^UTILITY(U,$J,358.3,36979,2)
 ;;=^5003569
 ;;^UTILITY(U,$J,358.3,36980,0)
 ;;=F43.21^^135^1826^3
 ;;^UTILITY(U,$J,358.3,36980,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36980,1,3,0)
 ;;=3^Adjustment Disorder w/ Depressed Mood
 ;;^UTILITY(U,$J,358.3,36980,1,4,0)
 ;;=4^F43.21
 ;;^UTILITY(U,$J,358.3,36980,2)
 ;;=^331948
 ;;^UTILITY(U,$J,358.3,36981,0)
 ;;=F43.22^^135^1826^2
 ;;^UTILITY(U,$J,358.3,36981,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36981,1,3,0)
 ;;=3^Adjustment Disorder w/ Anxiety
 ;;^UTILITY(U,$J,358.3,36981,1,4,0)
 ;;=4^F43.22
 ;;^UTILITY(U,$J,358.3,36981,2)
 ;;=^331949
 ;;^UTILITY(U,$J,358.3,36982,0)
 ;;=F43.23^^135^1826^5
 ;;^UTILITY(U,$J,358.3,36982,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36982,1,3,0)
 ;;=3^Adjustment Disorder w/ Mixed Anxiety & Depressed Mood
 ;;^UTILITY(U,$J,358.3,36982,1,4,0)
 ;;=4^F43.23
 ;;^UTILITY(U,$J,358.3,36982,2)
 ;;=^331950
 ;;^UTILITY(U,$J,358.3,36983,0)
 ;;=F43.24^^135^1826^4
 ;;^UTILITY(U,$J,358.3,36983,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36983,1,3,0)
 ;;=3^Adjustment Disorder w/ Disturbance of Conduct
 ;;^UTILITY(U,$J,358.3,36983,1,4,0)
 ;;=4^F43.24
 ;;^UTILITY(U,$J,358.3,36983,2)
 ;;=^331951
 ;;^UTILITY(U,$J,358.3,36984,0)
 ;;=F43.25^^135^1826^6
 ;;^UTILITY(U,$J,358.3,36984,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36984,1,3,0)
 ;;=3^Adjustment Disorder w/ Mixed Disturbance Emotions & Conduct
 ;;^UTILITY(U,$J,358.3,36984,1,4,0)
 ;;=4^F43.25
 ;;^UTILITY(U,$J,358.3,36984,2)
 ;;=^331952
 ;;^UTILITY(U,$J,358.3,36985,0)
 ;;=F43.20^^135^1826^7
 ;;^UTILITY(U,$J,358.3,36985,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36985,1,3,0)
 ;;=3^Adjustment Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,36985,1,4,0)
 ;;=4^F43.20
 ;;^UTILITY(U,$J,358.3,36985,2)
 ;;=^5003573
 ;;^UTILITY(U,$J,358.3,36986,0)
 ;;=F43.9^^135^1826^12
 ;;^UTILITY(U,$J,358.3,36986,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36986,1,3,0)
 ;;=3^Trauma/Stressor-Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,36986,1,4,0)
 ;;=4^F43.9
 ;;^UTILITY(U,$J,358.3,36986,2)
 ;;=^5003576
 ;;^UTILITY(U,$J,358.3,36987,0)
 ;;=F94.1^^135^1826^10
 ;;^UTILITY(U,$J,358.3,36987,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36987,1,3,0)
 ;;=3^Reactive Attachment Disorder
 ;;^UTILITY(U,$J,358.3,36987,1,4,0)
 ;;=4^F94.1
 ;;^UTILITY(U,$J,358.3,36987,2)
 ;;=^5003705
 ;;^UTILITY(U,$J,358.3,36988,0)
 ;;=F94.2^^135^1826^8
 ;;^UTILITY(U,$J,358.3,36988,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36988,1,3,0)
 ;;=3^Disinhibited Social Engagement Disorder
 ;;^UTILITY(U,$J,358.3,36988,1,4,0)
 ;;=4^F94.2
 ;;^UTILITY(U,$J,358.3,36988,2)
 ;;=^5003706
 ;;^UTILITY(U,$J,358.3,36989,0)
 ;;=F43.8^^135^1826^11
 ;;^UTILITY(U,$J,358.3,36989,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36989,1,3,0)
 ;;=3^Trauma/Stressor-Related Disorder,Other Specified
 ;;^UTILITY(U,$J,358.3,36989,1,4,0)
 ;;=4^F43.8
 ;;^UTILITY(U,$J,358.3,36989,2)
 ;;=^5003575
 ;;^UTILITY(U,$J,358.3,36990,0)
 ;;=F43.10^^135^1826^9
 ;;^UTILITY(U,$J,358.3,36990,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36990,1,3,0)
 ;;=3^Post-traumatic Stress Disorder
 ;;^UTILITY(U,$J,358.3,36990,1,4,0)
 ;;=4^F43.10
 ;;^UTILITY(U,$J,358.3,36990,2)
 ;;=^5003570
 ;;^UTILITY(U,$J,358.3,36991,0)
 ;;=F18.10^^135^1827^23
 ;;^UTILITY(U,$J,358.3,36991,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36991,1,3,0)
 ;;=3^Inhalant Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,36991,1,4,0)
 ;;=4^F18.10
 ;;^UTILITY(U,$J,358.3,36991,2)
 ;;=^5003380
 ;;^UTILITY(U,$J,358.3,36992,0)
 ;;=F18.20^^135^1827^24
 ;;^UTILITY(U,$J,358.3,36992,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36992,1,3,0)
 ;;=3^Inhalant Use Disorder,Moderate
 ;;^UTILITY(U,$J,358.3,36992,1,4,0)
 ;;=4^F18.20
 ;;^UTILITY(U,$J,358.3,36992,2)
 ;;=^5003392
 ;;^UTILITY(U,$J,358.3,36993,0)
 ;;=F18.14^^135^1827^4
 ;;^UTILITY(U,$J,358.3,36993,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36993,1,3,0)
 ;;=3^Inhalant Induced Depressive Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,36993,1,4,0)
 ;;=4^F18.14
 ;;^UTILITY(U,$J,358.3,36993,2)
 ;;=^5003384
 ;;^UTILITY(U,$J,358.3,36994,0)
 ;;=F18.24^^135^1827^5
 ;;^UTILITY(U,$J,358.3,36994,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36994,1,3,0)
 ;;=3^Inhalant Induced Depressive Disorder w/ Moderate to Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,36994,1,4,0)
 ;;=4^F18.24
 ;;^UTILITY(U,$J,358.3,36994,2)
 ;;=^5003397
 ;;^UTILITY(U,$J,358.3,36995,0)
 ;;=F18.121^^135^1827^16
 ;;^UTILITY(U,$J,358.3,36995,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36995,1,3,0)
 ;;=3^Inhalant Intoxication Delirium w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,36995,1,4,0)
 ;;=4^F18.121
 ;;^UTILITY(U,$J,358.3,36995,2)
 ;;=^5003382
 ;;^UTILITY(U,$J,358.3,36996,0)
 ;;=F18.221^^135^1827^17
 ;;^UTILITY(U,$J,358.3,36996,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36996,1,3,0)
 ;;=3^Inhalant Intoxication Delirium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,36996,1,4,0)
 ;;=4^F18.221
 ;;^UTILITY(U,$J,358.3,36996,2)
 ;;=^5003395
 ;;^UTILITY(U,$J,358.3,36997,0)
 ;;=F18.921^^135^1827^18
 ;;^UTILITY(U,$J,358.3,36997,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36997,1,3,0)
 ;;=3^Inhalant Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,36997,1,4,0)
 ;;=4^F18.921
 ;;^UTILITY(U,$J,358.3,36997,2)
 ;;=^5003407
 ;;^UTILITY(U,$J,358.3,36998,0)
 ;;=F18.129^^135^1827^19

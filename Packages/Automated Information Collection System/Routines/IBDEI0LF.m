IBDEI0LF ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,27091,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Withdrawal w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,27091,1,4,0)
 ;;=4^F13.239
 ;;^UTILITY(U,$J,358.3,27091,2)
 ;;=^5003209
 ;;^UTILITY(U,$J,358.3,27092,0)
 ;;=F13.231^^71^1140^36
 ;;^UTILITY(U,$J,358.3,27092,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27092,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,27092,1,4,0)
 ;;=4^F13.231
 ;;^UTILITY(U,$J,358.3,27092,2)
 ;;=^5003207
 ;;^UTILITY(U,$J,358.3,27093,0)
 ;;=F13.99^^71^1140^30
 ;;^UTILITY(U,$J,358.3,27093,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27093,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Related D/O,Unspec
 ;;^UTILITY(U,$J,358.3,27093,1,4,0)
 ;;=4^F13.99
 ;;^UTILITY(U,$J,358.3,27093,2)
 ;;=^5133353
 ;;^UTILITY(U,$J,358.3,27094,0)
 ;;=F17.200^^71^1141^4
 ;;^UTILITY(U,$J,358.3,27094,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27094,1,3,0)
 ;;=3^Tobacco Use Disorder,Moderate
 ;;^UTILITY(U,$J,358.3,27094,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,27094,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,27095,0)
 ;;=F17.203^^71^1141^6
 ;;^UTILITY(U,$J,358.3,27095,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27095,1,3,0)
 ;;=3^Tobacco Withdrawal
 ;;^UTILITY(U,$J,358.3,27095,1,4,0)
 ;;=4^F17.203
 ;;^UTILITY(U,$J,358.3,27095,2)
 ;;=^5003362
 ;;^UTILITY(U,$J,358.3,27096,0)
 ;;=F17.208^^71^1141^1
 ;;^UTILITY(U,$J,358.3,27096,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27096,1,3,0)
 ;;=3^Nicotine Induced Sleep Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,27096,1,4,0)
 ;;=4^F17.208
 ;;^UTILITY(U,$J,358.3,27096,2)
 ;;=^5003363
 ;;^UTILITY(U,$J,358.3,27097,0)
 ;;=F17.209^^71^1141^2
 ;;^UTILITY(U,$J,358.3,27097,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27097,1,3,0)
 ;;=3^Nicotine Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,27097,1,4,0)
 ;;=4^F17.209
 ;;^UTILITY(U,$J,358.3,27097,2)
 ;;=^5003364
 ;;^UTILITY(U,$J,358.3,27098,0)
 ;;=Z72.0^^71^1141^3
 ;;^UTILITY(U,$J,358.3,27098,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27098,1,3,0)
 ;;=3^Tobacco Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,27098,1,4,0)
 ;;=4^Z72.0
 ;;^UTILITY(U,$J,358.3,27098,2)
 ;;=^5063255
 ;;^UTILITY(U,$J,358.3,27099,0)
 ;;=F17.200^^71^1141^5
 ;;^UTILITY(U,$J,358.3,27099,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27099,1,3,0)
 ;;=3^Tobacco Use Disorder,Severe
 ;;^UTILITY(U,$J,358.3,27099,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,27099,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,27100,0)
 ;;=F43.0^^71^1142^1
 ;;^UTILITY(U,$J,358.3,27100,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27100,1,3,0)
 ;;=3^Acute Stress Disorder
 ;;^UTILITY(U,$J,358.3,27100,1,4,0)
 ;;=4^F43.0
 ;;^UTILITY(U,$J,358.3,27100,2)
 ;;=^5003569
 ;;^UTILITY(U,$J,358.3,27101,0)
 ;;=F43.21^^71^1142^3
 ;;^UTILITY(U,$J,358.3,27101,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27101,1,3,0)
 ;;=3^Adjustment Disorder w/ Depressed Mood
 ;;^UTILITY(U,$J,358.3,27101,1,4,0)
 ;;=4^F43.21
 ;;^UTILITY(U,$J,358.3,27101,2)
 ;;=^331948
 ;;^UTILITY(U,$J,358.3,27102,0)
 ;;=F43.22^^71^1142^2
 ;;^UTILITY(U,$J,358.3,27102,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27102,1,3,0)
 ;;=3^Adjustment Disorder w/ Anxiety
 ;;^UTILITY(U,$J,358.3,27102,1,4,0)
 ;;=4^F43.22
 ;;^UTILITY(U,$J,358.3,27102,2)
 ;;=^331949
 ;;^UTILITY(U,$J,358.3,27103,0)
 ;;=F43.23^^71^1142^5
 ;;^UTILITY(U,$J,358.3,27103,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27103,1,3,0)
 ;;=3^Adjustment Disorder w/ Mixed Anxiety & Depressed Mood
 ;;^UTILITY(U,$J,358.3,27103,1,4,0)
 ;;=4^F43.23
 ;;^UTILITY(U,$J,358.3,27103,2)
 ;;=^331950
 ;;^UTILITY(U,$J,358.3,27104,0)
 ;;=F43.24^^71^1142^4
 ;;^UTILITY(U,$J,358.3,27104,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27104,1,3,0)
 ;;=3^Adjustment Disorder w/ Disturbance of Conduct
 ;;^UTILITY(U,$J,358.3,27104,1,4,0)
 ;;=4^F43.24
 ;;^UTILITY(U,$J,358.3,27104,2)
 ;;=^331951
 ;;^UTILITY(U,$J,358.3,27105,0)
 ;;=F43.25^^71^1142^6
 ;;^UTILITY(U,$J,358.3,27105,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27105,1,3,0)
 ;;=3^Adjustment Disorder w/ Mixed Disturbance Emotions & Conduct
 ;;^UTILITY(U,$J,358.3,27105,1,4,0)
 ;;=4^F43.25
 ;;^UTILITY(U,$J,358.3,27105,2)
 ;;=^331952
 ;;^UTILITY(U,$J,358.3,27106,0)
 ;;=F43.20^^71^1142^7
 ;;^UTILITY(U,$J,358.3,27106,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27106,1,3,0)
 ;;=3^Adjustment Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,27106,1,4,0)
 ;;=4^F43.20
 ;;^UTILITY(U,$J,358.3,27106,2)
 ;;=^5003573
 ;;^UTILITY(U,$J,358.3,27107,0)
 ;;=F43.9^^71^1142^12
 ;;^UTILITY(U,$J,358.3,27107,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27107,1,3,0)
 ;;=3^Trauma/Stressor-Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,27107,1,4,0)
 ;;=4^F43.9
 ;;^UTILITY(U,$J,358.3,27107,2)
 ;;=^5003576
 ;;^UTILITY(U,$J,358.3,27108,0)
 ;;=F94.1^^71^1142^10
 ;;^UTILITY(U,$J,358.3,27108,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27108,1,3,0)
 ;;=3^Reactive Attachment Disorder
 ;;^UTILITY(U,$J,358.3,27108,1,4,0)
 ;;=4^F94.1
 ;;^UTILITY(U,$J,358.3,27108,2)
 ;;=^5003705
 ;;^UTILITY(U,$J,358.3,27109,0)
 ;;=F94.2^^71^1142^8
 ;;^UTILITY(U,$J,358.3,27109,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27109,1,3,0)
 ;;=3^Disinhibited Social Engagement Disorder
 ;;^UTILITY(U,$J,358.3,27109,1,4,0)
 ;;=4^F94.2
 ;;^UTILITY(U,$J,358.3,27109,2)
 ;;=^5003706
 ;;^UTILITY(U,$J,358.3,27110,0)
 ;;=F43.8^^71^1142^11
 ;;^UTILITY(U,$J,358.3,27110,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27110,1,3,0)
 ;;=3^Trauma/Stressor-Related Disorder,Other Specified
 ;;^UTILITY(U,$J,358.3,27110,1,4,0)
 ;;=4^F43.8
 ;;^UTILITY(U,$J,358.3,27110,2)
 ;;=^5003575
 ;;^UTILITY(U,$J,358.3,27111,0)
 ;;=F43.10^^71^1142^9
 ;;^UTILITY(U,$J,358.3,27111,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27111,1,3,0)
 ;;=3^Post-traumatic Stress Disorder
 ;;^UTILITY(U,$J,358.3,27111,1,4,0)
 ;;=4^F43.10
 ;;^UTILITY(U,$J,358.3,27111,2)
 ;;=^5003570
 ;;^UTILITY(U,$J,358.3,27112,0)
 ;;=F18.10^^71^1143^23
 ;;^UTILITY(U,$J,358.3,27112,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27112,1,3,0)
 ;;=3^Inhalant Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,27112,1,4,0)
 ;;=4^F18.10
 ;;^UTILITY(U,$J,358.3,27112,2)
 ;;=^5003380
 ;;^UTILITY(U,$J,358.3,27113,0)
 ;;=F18.20^^71^1143^24
 ;;^UTILITY(U,$J,358.3,27113,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27113,1,3,0)
 ;;=3^Inhalant Use Disorder,Moderate
 ;;^UTILITY(U,$J,358.3,27113,1,4,0)
 ;;=4^F18.20
 ;;^UTILITY(U,$J,358.3,27113,2)
 ;;=^5003392
 ;;^UTILITY(U,$J,358.3,27114,0)
 ;;=F18.14^^71^1143^4
 ;;^UTILITY(U,$J,358.3,27114,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27114,1,3,0)
 ;;=3^Inhalant Induced Depressive Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,27114,1,4,0)
 ;;=4^F18.14
 ;;^UTILITY(U,$J,358.3,27114,2)
 ;;=^5003384
 ;;^UTILITY(U,$J,358.3,27115,0)
 ;;=F18.24^^71^1143^5
 ;;^UTILITY(U,$J,358.3,27115,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27115,1,3,0)
 ;;=3^Inhalant Induced Depressive Disorder w/ Moderate to Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,27115,1,4,0)
 ;;=4^F18.24
 ;;^UTILITY(U,$J,358.3,27115,2)
 ;;=^5003397
 ;;^UTILITY(U,$J,358.3,27116,0)
 ;;=F18.121^^71^1143^16
 ;;^UTILITY(U,$J,358.3,27116,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27116,1,3,0)
 ;;=3^Inhalant Intoxication Delirium w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,27116,1,4,0)
 ;;=4^F18.121
 ;;^UTILITY(U,$J,358.3,27116,2)
 ;;=^5003382
 ;;^UTILITY(U,$J,358.3,27117,0)
 ;;=F18.221^^71^1143^17
 ;;^UTILITY(U,$J,358.3,27117,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27117,1,3,0)
 ;;=3^Inhalant Intoxication Delirium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,27117,1,4,0)
 ;;=4^F18.221
 ;;^UTILITY(U,$J,358.3,27117,2)
 ;;=^5003395
 ;;^UTILITY(U,$J,358.3,27118,0)
 ;;=F18.921^^71^1143^18
 ;;^UTILITY(U,$J,358.3,27118,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27118,1,3,0)
 ;;=3^Inhalant Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,27118,1,4,0)
 ;;=4^F18.921
 ;;^UTILITY(U,$J,358.3,27118,2)
 ;;=^5003407
 ;;^UTILITY(U,$J,358.3,27119,0)
 ;;=F18.129^^71^1143^19
 ;;^UTILITY(U,$J,358.3,27119,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27119,1,3,0)
 ;;=3^Inhalant Intoxication w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,27119,1,4,0)
 ;;=4^F18.129
 ;;^UTILITY(U,$J,358.3,27119,2)
 ;;=^5003383
 ;;^UTILITY(U,$J,358.3,27120,0)
 ;;=F18.229^^71^1143^20
 ;;^UTILITY(U,$J,358.3,27120,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27120,1,3,0)
 ;;=3^Inhalant Intoxication w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,27120,1,4,0)
 ;;=4^F18.229
 ;;^UTILITY(U,$J,358.3,27120,2)
 ;;=^5003396
 ;;^UTILITY(U,$J,358.3,27121,0)
 ;;=F18.929^^71^1143^21
 ;;^UTILITY(U,$J,358.3,27121,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27121,1,3,0)
 ;;=3^Inhalant Intoxication w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,27121,1,4,0)
 ;;=4^F18.929
 ;;^UTILITY(U,$J,358.3,27121,2)
 ;;=^5003408
 ;;^UTILITY(U,$J,358.3,27122,0)
 ;;=F18.180^^71^1143^1
 ;;^UTILITY(U,$J,358.3,27122,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27122,1,3,0)
 ;;=3^Inhalant Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,27122,1,4,0)
 ;;=4^F18.180
 ;;^UTILITY(U,$J,358.3,27122,2)
 ;;=^5003389
 ;;^UTILITY(U,$J,358.3,27123,0)
 ;;=F18.280^^71^1143^2
 ;;^UTILITY(U,$J,358.3,27123,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27123,1,3,0)
 ;;=3^Inhalant Induced Anxiety Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,27123,1,4,0)
 ;;=4^F18.280
 ;;^UTILITY(U,$J,358.3,27123,2)
 ;;=^5003402
 ;;^UTILITY(U,$J,358.3,27124,0)
 ;;=F18.980^^71^1143^3
 ;;^UTILITY(U,$J,358.3,27124,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27124,1,3,0)
 ;;=3^Inhalant Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,27124,1,4,0)
 ;;=4^F18.980
 ;;^UTILITY(U,$J,358.3,27124,2)
 ;;=^5003414
 ;;^UTILITY(U,$J,358.3,27125,0)
 ;;=F18.94^^71^1143^6
 ;;^UTILITY(U,$J,358.3,27125,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27125,1,3,0)
 ;;=3^Inhalant Induced Depressive Disorder w/o Use Disorder

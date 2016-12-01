IBDEI0C2 ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15292,2)
 ;;=^5003189
 ;;^UTILITY(U,$J,358.3,15293,0)
 ;;=F13.20^^45^681^32
 ;;^UTILITY(U,$J,358.3,15293,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15293,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Use D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,15293,1,4,0)
 ;;=4^F13.20
 ;;^UTILITY(U,$J,358.3,15293,2)
 ;;=^5003202
 ;;^UTILITY(U,$J,358.3,15294,0)
 ;;=F13.20^^45^681^33
 ;;^UTILITY(U,$J,358.3,15294,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15294,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Use D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,15294,1,4,0)
 ;;=4^F13.20
 ;;^UTILITY(U,$J,358.3,15294,2)
 ;;=^5003202
 ;;^UTILITY(U,$J,358.3,15295,0)
 ;;=F13.232^^45^681^34
 ;;^UTILITY(U,$J,358.3,15295,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15295,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Withdrawal w/ Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,15295,1,4,0)
 ;;=4^F13.232
 ;;^UTILITY(U,$J,358.3,15295,2)
 ;;=^5003208
 ;;^UTILITY(U,$J,358.3,15296,0)
 ;;=F13.239^^45^681^35
 ;;^UTILITY(U,$J,358.3,15296,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15296,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Withdrawal w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,15296,1,4,0)
 ;;=4^F13.239
 ;;^UTILITY(U,$J,358.3,15296,2)
 ;;=^5003209
 ;;^UTILITY(U,$J,358.3,15297,0)
 ;;=F13.231^^45^681^36
 ;;^UTILITY(U,$J,358.3,15297,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15297,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,15297,1,4,0)
 ;;=4^F13.231
 ;;^UTILITY(U,$J,358.3,15297,2)
 ;;=^5003207
 ;;^UTILITY(U,$J,358.3,15298,0)
 ;;=F13.99^^45^681^30
 ;;^UTILITY(U,$J,358.3,15298,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15298,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Related D/O,Unspec
 ;;^UTILITY(U,$J,358.3,15298,1,4,0)
 ;;=4^F13.99
 ;;^UTILITY(U,$J,358.3,15298,2)
 ;;=^5133353
 ;;^UTILITY(U,$J,358.3,15299,0)
 ;;=F17.200^^45^682^4
 ;;^UTILITY(U,$J,358.3,15299,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15299,1,3,0)
 ;;=3^Tobacco Use Disorder,Moderate
 ;;^UTILITY(U,$J,358.3,15299,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,15299,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,15300,0)
 ;;=F17.203^^45^682^6
 ;;^UTILITY(U,$J,358.3,15300,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15300,1,3,0)
 ;;=3^Tobacco Withdrawal
 ;;^UTILITY(U,$J,358.3,15300,1,4,0)
 ;;=4^F17.203
 ;;^UTILITY(U,$J,358.3,15300,2)
 ;;=^5003362
 ;;^UTILITY(U,$J,358.3,15301,0)
 ;;=F17.208^^45^682^1
 ;;^UTILITY(U,$J,358.3,15301,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15301,1,3,0)
 ;;=3^Nicotine Induced Sleep Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,15301,1,4,0)
 ;;=4^F17.208
 ;;^UTILITY(U,$J,358.3,15301,2)
 ;;=^5003363
 ;;^UTILITY(U,$J,358.3,15302,0)
 ;;=F17.209^^45^682^2
 ;;^UTILITY(U,$J,358.3,15302,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15302,1,3,0)
 ;;=3^Nicotine Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,15302,1,4,0)
 ;;=4^F17.209
 ;;^UTILITY(U,$J,358.3,15302,2)
 ;;=^5003364
 ;;^UTILITY(U,$J,358.3,15303,0)
 ;;=Z72.0^^45^682^3
 ;;^UTILITY(U,$J,358.3,15303,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15303,1,3,0)
 ;;=3^Tobacco Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,15303,1,4,0)
 ;;=4^Z72.0
 ;;^UTILITY(U,$J,358.3,15303,2)
 ;;=^5063255
 ;;^UTILITY(U,$J,358.3,15304,0)
 ;;=F17.200^^45^682^5
 ;;^UTILITY(U,$J,358.3,15304,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15304,1,3,0)
 ;;=3^Tobacco Use Disorder,Severe
 ;;^UTILITY(U,$J,358.3,15304,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,15304,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,15305,0)
 ;;=F43.0^^45^683^1
 ;;^UTILITY(U,$J,358.3,15305,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15305,1,3,0)
 ;;=3^Acute Stress Disorder
 ;;^UTILITY(U,$J,358.3,15305,1,4,0)
 ;;=4^F43.0
 ;;^UTILITY(U,$J,358.3,15305,2)
 ;;=^5003569
 ;;^UTILITY(U,$J,358.3,15306,0)
 ;;=F43.21^^45^683^3
 ;;^UTILITY(U,$J,358.3,15306,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15306,1,3,0)
 ;;=3^Adjustment Disorder w/ Depressed Mood
 ;;^UTILITY(U,$J,358.3,15306,1,4,0)
 ;;=4^F43.21
 ;;^UTILITY(U,$J,358.3,15306,2)
 ;;=^331948
 ;;^UTILITY(U,$J,358.3,15307,0)
 ;;=F43.22^^45^683^2
 ;;^UTILITY(U,$J,358.3,15307,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15307,1,3,0)
 ;;=3^Adjustment Disorder w/ Anxiety
 ;;^UTILITY(U,$J,358.3,15307,1,4,0)
 ;;=4^F43.22
 ;;^UTILITY(U,$J,358.3,15307,2)
 ;;=^331949
 ;;^UTILITY(U,$J,358.3,15308,0)
 ;;=F43.23^^45^683^5
 ;;^UTILITY(U,$J,358.3,15308,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15308,1,3,0)
 ;;=3^Adjustment Disorder w/ Mixed Anxiety & Depressed Mood
 ;;^UTILITY(U,$J,358.3,15308,1,4,0)
 ;;=4^F43.23
 ;;^UTILITY(U,$J,358.3,15308,2)
 ;;=^331950
 ;;^UTILITY(U,$J,358.3,15309,0)
 ;;=F43.24^^45^683^4
 ;;^UTILITY(U,$J,358.3,15309,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15309,1,3,0)
 ;;=3^Adjustment Disorder w/ Disturbance of Conduct
 ;;^UTILITY(U,$J,358.3,15309,1,4,0)
 ;;=4^F43.24
 ;;^UTILITY(U,$J,358.3,15309,2)
 ;;=^331951
 ;;^UTILITY(U,$J,358.3,15310,0)
 ;;=F43.25^^45^683^6
 ;;^UTILITY(U,$J,358.3,15310,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15310,1,3,0)
 ;;=3^Adjustment Disorder w/ Mixed Disturbance Emotions & Conduct
 ;;^UTILITY(U,$J,358.3,15310,1,4,0)
 ;;=4^F43.25
 ;;^UTILITY(U,$J,358.3,15310,2)
 ;;=^331952
 ;;^UTILITY(U,$J,358.3,15311,0)
 ;;=F43.20^^45^683^7
 ;;^UTILITY(U,$J,358.3,15311,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15311,1,3,0)
 ;;=3^Adjustment Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,15311,1,4,0)
 ;;=4^F43.20
 ;;^UTILITY(U,$J,358.3,15311,2)
 ;;=^5003573
 ;;^UTILITY(U,$J,358.3,15312,0)
 ;;=F43.9^^45^683^12
 ;;^UTILITY(U,$J,358.3,15312,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15312,1,3,0)
 ;;=3^Trauma/Stressor-Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,15312,1,4,0)
 ;;=4^F43.9
 ;;^UTILITY(U,$J,358.3,15312,2)
 ;;=^5003576
 ;;^UTILITY(U,$J,358.3,15313,0)
 ;;=F94.1^^45^683^10
 ;;^UTILITY(U,$J,358.3,15313,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15313,1,3,0)
 ;;=3^Reactive Attachment Disorder
 ;;^UTILITY(U,$J,358.3,15313,1,4,0)
 ;;=4^F94.1
 ;;^UTILITY(U,$J,358.3,15313,2)
 ;;=^5003705
 ;;^UTILITY(U,$J,358.3,15314,0)
 ;;=F94.2^^45^683^8
 ;;^UTILITY(U,$J,358.3,15314,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15314,1,3,0)
 ;;=3^Disinhibited Social Engagement Disorder
 ;;^UTILITY(U,$J,358.3,15314,1,4,0)
 ;;=4^F94.2
 ;;^UTILITY(U,$J,358.3,15314,2)
 ;;=^5003706
 ;;^UTILITY(U,$J,358.3,15315,0)
 ;;=F43.8^^45^683^11
 ;;^UTILITY(U,$J,358.3,15315,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15315,1,3,0)
 ;;=3^Trauma/Stressor-Related Disorder,Other Specified
 ;;^UTILITY(U,$J,358.3,15315,1,4,0)
 ;;=4^F43.8
 ;;^UTILITY(U,$J,358.3,15315,2)
 ;;=^5003575
 ;;^UTILITY(U,$J,358.3,15316,0)
 ;;=F43.10^^45^683^9
 ;;^UTILITY(U,$J,358.3,15316,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15316,1,3,0)
 ;;=3^Post-traumatic Stress Disorder
 ;;^UTILITY(U,$J,358.3,15316,1,4,0)
 ;;=4^F43.10
 ;;^UTILITY(U,$J,358.3,15316,2)
 ;;=^5003570
 ;;^UTILITY(U,$J,358.3,15317,0)
 ;;=F18.10^^45^684^23
 ;;^UTILITY(U,$J,358.3,15317,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15317,1,3,0)
 ;;=3^Inhalant Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,15317,1,4,0)
 ;;=4^F18.10
 ;;^UTILITY(U,$J,358.3,15317,2)
 ;;=^5003380
 ;;^UTILITY(U,$J,358.3,15318,0)
 ;;=F18.20^^45^684^24
 ;;^UTILITY(U,$J,358.3,15318,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15318,1,3,0)
 ;;=3^Inhalant Use Disorder,Moderate
 ;;^UTILITY(U,$J,358.3,15318,1,4,0)
 ;;=4^F18.20
 ;;^UTILITY(U,$J,358.3,15318,2)
 ;;=^5003392
 ;;^UTILITY(U,$J,358.3,15319,0)
 ;;=F18.14^^45^684^4
 ;;^UTILITY(U,$J,358.3,15319,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15319,1,3,0)
 ;;=3^Inhalant Induced Depressive Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,15319,1,4,0)
 ;;=4^F18.14
 ;;^UTILITY(U,$J,358.3,15319,2)
 ;;=^5003384
 ;;^UTILITY(U,$J,358.3,15320,0)
 ;;=F18.24^^45^684^5
 ;;^UTILITY(U,$J,358.3,15320,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15320,1,3,0)
 ;;=3^Inhalant Induced Depressive Disorder w/ Moderate to Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,15320,1,4,0)
 ;;=4^F18.24
 ;;^UTILITY(U,$J,358.3,15320,2)
 ;;=^5003397
 ;;^UTILITY(U,$J,358.3,15321,0)
 ;;=F18.121^^45^684^16
 ;;^UTILITY(U,$J,358.3,15321,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15321,1,3,0)
 ;;=3^Inhalant Intoxication Delirium w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,15321,1,4,0)
 ;;=4^F18.121
 ;;^UTILITY(U,$J,358.3,15321,2)
 ;;=^5003382
 ;;^UTILITY(U,$J,358.3,15322,0)
 ;;=F18.221^^45^684^17
 ;;^UTILITY(U,$J,358.3,15322,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15322,1,3,0)
 ;;=3^Inhalant Intoxication Delirium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,15322,1,4,0)
 ;;=4^F18.221
 ;;^UTILITY(U,$J,358.3,15322,2)
 ;;=^5003395
 ;;^UTILITY(U,$J,358.3,15323,0)
 ;;=F18.921^^45^684^18
 ;;^UTILITY(U,$J,358.3,15323,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15323,1,3,0)
 ;;=3^Inhalant Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,15323,1,4,0)
 ;;=4^F18.921
 ;;^UTILITY(U,$J,358.3,15323,2)
 ;;=^5003407
 ;;^UTILITY(U,$J,358.3,15324,0)
 ;;=F18.129^^45^684^19
 ;;^UTILITY(U,$J,358.3,15324,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15324,1,3,0)
 ;;=3^Inhalant Intoxication w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,15324,1,4,0)
 ;;=4^F18.129
 ;;^UTILITY(U,$J,358.3,15324,2)
 ;;=^5003383
 ;;^UTILITY(U,$J,358.3,15325,0)
 ;;=F18.229^^45^684^20
 ;;^UTILITY(U,$J,358.3,15325,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15325,1,3,0)
 ;;=3^Inhalant Intoxication w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,15325,1,4,0)
 ;;=4^F18.229
 ;;^UTILITY(U,$J,358.3,15325,2)
 ;;=^5003396
 ;;^UTILITY(U,$J,358.3,15326,0)
 ;;=F18.929^^45^684^21
 ;;^UTILITY(U,$J,358.3,15326,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15326,1,3,0)
 ;;=3^Inhalant Intoxication w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,15326,1,4,0)
 ;;=4^F18.929
 ;;^UTILITY(U,$J,358.3,15326,2)
 ;;=^5003408
 ;;^UTILITY(U,$J,358.3,15327,0)
 ;;=F18.180^^45^684^1

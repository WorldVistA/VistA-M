IBDEI0K0 ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25322,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25322,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Use D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,25322,1,4,0)
 ;;=4^F13.10
 ;;^UTILITY(U,$J,358.3,25322,2)
 ;;=^5003189
 ;;^UTILITY(U,$J,358.3,25323,0)
 ;;=F13.20^^66^1020^32
 ;;^UTILITY(U,$J,358.3,25323,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25323,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Use D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,25323,1,4,0)
 ;;=4^F13.20
 ;;^UTILITY(U,$J,358.3,25323,2)
 ;;=^5003202
 ;;^UTILITY(U,$J,358.3,25324,0)
 ;;=F13.20^^66^1020^33
 ;;^UTILITY(U,$J,358.3,25324,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25324,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Use D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,25324,1,4,0)
 ;;=4^F13.20
 ;;^UTILITY(U,$J,358.3,25324,2)
 ;;=^5003202
 ;;^UTILITY(U,$J,358.3,25325,0)
 ;;=F13.232^^66^1020^34
 ;;^UTILITY(U,$J,358.3,25325,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25325,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Withdrawal w/ Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,25325,1,4,0)
 ;;=4^F13.232
 ;;^UTILITY(U,$J,358.3,25325,2)
 ;;=^5003208
 ;;^UTILITY(U,$J,358.3,25326,0)
 ;;=F13.239^^66^1020^35
 ;;^UTILITY(U,$J,358.3,25326,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25326,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Withdrawal w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,25326,1,4,0)
 ;;=4^F13.239
 ;;^UTILITY(U,$J,358.3,25326,2)
 ;;=^5003209
 ;;^UTILITY(U,$J,358.3,25327,0)
 ;;=F13.231^^66^1020^36
 ;;^UTILITY(U,$J,358.3,25327,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25327,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,25327,1,4,0)
 ;;=4^F13.231
 ;;^UTILITY(U,$J,358.3,25327,2)
 ;;=^5003207
 ;;^UTILITY(U,$J,358.3,25328,0)
 ;;=F13.99^^66^1020^30
 ;;^UTILITY(U,$J,358.3,25328,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25328,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Related D/O,Unspec
 ;;^UTILITY(U,$J,358.3,25328,1,4,0)
 ;;=4^F13.99
 ;;^UTILITY(U,$J,358.3,25328,2)
 ;;=^5133353
 ;;^UTILITY(U,$J,358.3,25329,0)
 ;;=F17.200^^66^1021^4
 ;;^UTILITY(U,$J,358.3,25329,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25329,1,3,0)
 ;;=3^Tobacco Use Disorder,Moderate
 ;;^UTILITY(U,$J,358.3,25329,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,25329,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,25330,0)
 ;;=F17.203^^66^1021^6
 ;;^UTILITY(U,$J,358.3,25330,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25330,1,3,0)
 ;;=3^Tobacco Withdrawal
 ;;^UTILITY(U,$J,358.3,25330,1,4,0)
 ;;=4^F17.203
 ;;^UTILITY(U,$J,358.3,25330,2)
 ;;=^5003362
 ;;^UTILITY(U,$J,358.3,25331,0)
 ;;=F17.208^^66^1021^1
 ;;^UTILITY(U,$J,358.3,25331,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25331,1,3,0)
 ;;=3^Nicotine Induced Sleep Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25331,1,4,0)
 ;;=4^F17.208
 ;;^UTILITY(U,$J,358.3,25331,2)
 ;;=^5003363
 ;;^UTILITY(U,$J,358.3,25332,0)
 ;;=F17.209^^66^1021^2
 ;;^UTILITY(U,$J,358.3,25332,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25332,1,3,0)
 ;;=3^Nicotine Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,25332,1,4,0)
 ;;=4^F17.209
 ;;^UTILITY(U,$J,358.3,25332,2)
 ;;=^5003364
 ;;^UTILITY(U,$J,358.3,25333,0)
 ;;=Z72.0^^66^1021^3
 ;;^UTILITY(U,$J,358.3,25333,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25333,1,3,0)
 ;;=3^Tobacco Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,25333,1,4,0)
 ;;=4^Z72.0
 ;;^UTILITY(U,$J,358.3,25333,2)
 ;;=^5063255
 ;;^UTILITY(U,$J,358.3,25334,0)
 ;;=F17.200^^66^1021^5
 ;;^UTILITY(U,$J,358.3,25334,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25334,1,3,0)
 ;;=3^Tobacco Use Disorder,Severe
 ;;^UTILITY(U,$J,358.3,25334,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,25334,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,25335,0)
 ;;=F43.0^^66^1022^1
 ;;^UTILITY(U,$J,358.3,25335,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25335,1,3,0)
 ;;=3^Acute Stress Disorder
 ;;^UTILITY(U,$J,358.3,25335,1,4,0)
 ;;=4^F43.0
 ;;^UTILITY(U,$J,358.3,25335,2)
 ;;=^5003569
 ;;^UTILITY(U,$J,358.3,25336,0)
 ;;=F43.21^^66^1022^3
 ;;^UTILITY(U,$J,358.3,25336,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25336,1,3,0)
 ;;=3^Adjustment Disorder w/ Depressed Mood
 ;;^UTILITY(U,$J,358.3,25336,1,4,0)
 ;;=4^F43.21
 ;;^UTILITY(U,$J,358.3,25336,2)
 ;;=^331948
 ;;^UTILITY(U,$J,358.3,25337,0)
 ;;=F43.22^^66^1022^2
 ;;^UTILITY(U,$J,358.3,25337,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25337,1,3,0)
 ;;=3^Adjustment Disorder w/ Anxiety
 ;;^UTILITY(U,$J,358.3,25337,1,4,0)
 ;;=4^F43.22
 ;;^UTILITY(U,$J,358.3,25337,2)
 ;;=^331949
 ;;^UTILITY(U,$J,358.3,25338,0)
 ;;=F43.23^^66^1022^5
 ;;^UTILITY(U,$J,358.3,25338,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25338,1,3,0)
 ;;=3^Adjustment Disorder w/ Mixed Anxiety & Depressed Mood
 ;;^UTILITY(U,$J,358.3,25338,1,4,0)
 ;;=4^F43.23
 ;;^UTILITY(U,$J,358.3,25338,2)
 ;;=^331950
 ;;^UTILITY(U,$J,358.3,25339,0)
 ;;=F43.24^^66^1022^4
 ;;^UTILITY(U,$J,358.3,25339,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25339,1,3,0)
 ;;=3^Adjustment Disorder w/ Disturbance of Conduct
 ;;^UTILITY(U,$J,358.3,25339,1,4,0)
 ;;=4^F43.24
 ;;^UTILITY(U,$J,358.3,25339,2)
 ;;=^331951
 ;;^UTILITY(U,$J,358.3,25340,0)
 ;;=F43.25^^66^1022^6
 ;;^UTILITY(U,$J,358.3,25340,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25340,1,3,0)
 ;;=3^Adjustment Disorder w/ Mixed Disturbance Emotions & Conduct
 ;;^UTILITY(U,$J,358.3,25340,1,4,0)
 ;;=4^F43.25
 ;;^UTILITY(U,$J,358.3,25340,2)
 ;;=^331952
 ;;^UTILITY(U,$J,358.3,25341,0)
 ;;=F43.20^^66^1022^7
 ;;^UTILITY(U,$J,358.3,25341,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25341,1,3,0)
 ;;=3^Adjustment Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,25341,1,4,0)
 ;;=4^F43.20
 ;;^UTILITY(U,$J,358.3,25341,2)
 ;;=^5003573
 ;;^UTILITY(U,$J,358.3,25342,0)
 ;;=F43.9^^66^1022^12
 ;;^UTILITY(U,$J,358.3,25342,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25342,1,3,0)
 ;;=3^Trauma/Stressor-Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,25342,1,4,0)
 ;;=4^F43.9
 ;;^UTILITY(U,$J,358.3,25342,2)
 ;;=^5003576
 ;;^UTILITY(U,$J,358.3,25343,0)
 ;;=F94.1^^66^1022^10
 ;;^UTILITY(U,$J,358.3,25343,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25343,1,3,0)
 ;;=3^Reactive Attachment Disorder
 ;;^UTILITY(U,$J,358.3,25343,1,4,0)
 ;;=4^F94.1
 ;;^UTILITY(U,$J,358.3,25343,2)
 ;;=^5003705
 ;;^UTILITY(U,$J,358.3,25344,0)
 ;;=F94.2^^66^1022^8
 ;;^UTILITY(U,$J,358.3,25344,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25344,1,3,0)
 ;;=3^Disinhibited Social Engagement Disorder
 ;;^UTILITY(U,$J,358.3,25344,1,4,0)
 ;;=4^F94.2
 ;;^UTILITY(U,$J,358.3,25344,2)
 ;;=^5003706
 ;;^UTILITY(U,$J,358.3,25345,0)
 ;;=F43.8^^66^1022^11
 ;;^UTILITY(U,$J,358.3,25345,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25345,1,3,0)
 ;;=3^Trauma/Stressor-Related Disorder,Other Specified
 ;;^UTILITY(U,$J,358.3,25345,1,4,0)
 ;;=4^F43.8
 ;;^UTILITY(U,$J,358.3,25345,2)
 ;;=^5003575
 ;;^UTILITY(U,$J,358.3,25346,0)
 ;;=F43.10^^66^1022^9
 ;;^UTILITY(U,$J,358.3,25346,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25346,1,3,0)
 ;;=3^Post-traumatic Stress Disorder
 ;;^UTILITY(U,$J,358.3,25346,1,4,0)
 ;;=4^F43.10
 ;;^UTILITY(U,$J,358.3,25346,2)
 ;;=^5003570
 ;;^UTILITY(U,$J,358.3,25347,0)
 ;;=F18.10^^66^1023^23
 ;;^UTILITY(U,$J,358.3,25347,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25347,1,3,0)
 ;;=3^Inhalant Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,25347,1,4,0)
 ;;=4^F18.10
 ;;^UTILITY(U,$J,358.3,25347,2)
 ;;=^5003380
 ;;^UTILITY(U,$J,358.3,25348,0)
 ;;=F18.20^^66^1023^24
 ;;^UTILITY(U,$J,358.3,25348,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25348,1,3,0)
 ;;=3^Inhalant Use Disorder,Moderate
 ;;^UTILITY(U,$J,358.3,25348,1,4,0)
 ;;=4^F18.20
 ;;^UTILITY(U,$J,358.3,25348,2)
 ;;=^5003392
 ;;^UTILITY(U,$J,358.3,25349,0)
 ;;=F18.14^^66^1023^4
 ;;^UTILITY(U,$J,358.3,25349,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25349,1,3,0)
 ;;=3^Inhalant Induced Depressive Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25349,1,4,0)
 ;;=4^F18.14
 ;;^UTILITY(U,$J,358.3,25349,2)
 ;;=^5003384
 ;;^UTILITY(U,$J,358.3,25350,0)
 ;;=F18.24^^66^1023^5
 ;;^UTILITY(U,$J,358.3,25350,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25350,1,3,0)
 ;;=3^Inhalant Induced Depressive Disorder w/ Moderate to Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25350,1,4,0)
 ;;=4^F18.24
 ;;^UTILITY(U,$J,358.3,25350,2)
 ;;=^5003397
 ;;^UTILITY(U,$J,358.3,25351,0)
 ;;=F18.121^^66^1023^16
 ;;^UTILITY(U,$J,358.3,25351,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25351,1,3,0)
 ;;=3^Inhalant Intoxication Delirium w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25351,1,4,0)
 ;;=4^F18.121
 ;;^UTILITY(U,$J,358.3,25351,2)
 ;;=^5003382
 ;;^UTILITY(U,$J,358.3,25352,0)
 ;;=F18.221^^66^1023^17
 ;;^UTILITY(U,$J,358.3,25352,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25352,1,3,0)
 ;;=3^Inhalant Intoxication Delirium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25352,1,4,0)
 ;;=4^F18.221
 ;;^UTILITY(U,$J,358.3,25352,2)
 ;;=^5003395
 ;;^UTILITY(U,$J,358.3,25353,0)
 ;;=F18.921^^66^1023^18
 ;;^UTILITY(U,$J,358.3,25353,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25353,1,3,0)
 ;;=3^Inhalant Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25353,1,4,0)
 ;;=4^F18.921
 ;;^UTILITY(U,$J,358.3,25353,2)
 ;;=^5003407
 ;;^UTILITY(U,$J,358.3,25354,0)
 ;;=F18.129^^66^1023^19
 ;;^UTILITY(U,$J,358.3,25354,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25354,1,3,0)
 ;;=3^Inhalant Intoxication w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25354,1,4,0)
 ;;=4^F18.129
 ;;^UTILITY(U,$J,358.3,25354,2)
 ;;=^5003383
 ;;^UTILITY(U,$J,358.3,25355,0)
 ;;=F18.229^^66^1023^20
 ;;^UTILITY(U,$J,358.3,25355,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25355,1,3,0)
 ;;=3^Inhalant Intoxication w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25355,1,4,0)
 ;;=4^F18.229
 ;;^UTILITY(U,$J,358.3,25355,2)
 ;;=^5003396
 ;;^UTILITY(U,$J,358.3,25356,0)
 ;;=F18.929^^66^1023^21
 ;;^UTILITY(U,$J,358.3,25356,1,0)
 ;;=^358.31IA^4^2

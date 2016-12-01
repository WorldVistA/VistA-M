IBDEI0IP ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23715,0)
 ;;=F13.181^^61^922^18
 ;;^UTILITY(U,$J,358.3,23715,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23715,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Sexual Dysfunction w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,23715,1,4,0)
 ;;=4^F13.181
 ;;^UTILITY(U,$J,358.3,23715,2)
 ;;=^5003198
 ;;^UTILITY(U,$J,358.3,23716,0)
 ;;=F13.281^^61^922^19
 ;;^UTILITY(U,$J,358.3,23716,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23716,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Sexual Dysfunction w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,23716,1,4,0)
 ;;=4^F13.281
 ;;^UTILITY(U,$J,358.3,23716,2)
 ;;=^5003217
 ;;^UTILITY(U,$J,358.3,23717,0)
 ;;=F13.981^^61^922^20
 ;;^UTILITY(U,$J,358.3,23717,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23717,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Sexual Dysfunction w/o Use D/O
 ;;^UTILITY(U,$J,358.3,23717,1,4,0)
 ;;=4^F13.981
 ;;^UTILITY(U,$J,358.3,23717,2)
 ;;=^5003236
 ;;^UTILITY(U,$J,358.3,23718,0)
 ;;=F13.182^^61^922^21
 ;;^UTILITY(U,$J,358.3,23718,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23718,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Sleep D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,23718,1,4,0)
 ;;=4^F13.182
 ;;^UTILITY(U,$J,358.3,23718,2)
 ;;=^5003199
 ;;^UTILITY(U,$J,358.3,23719,0)
 ;;=F13.282^^61^922^22
 ;;^UTILITY(U,$J,358.3,23719,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23719,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Sleep D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,23719,1,4,0)
 ;;=4^F13.282
 ;;^UTILITY(U,$J,358.3,23719,2)
 ;;=^5003218
 ;;^UTILITY(U,$J,358.3,23720,0)
 ;;=F13.982^^61^922^23
 ;;^UTILITY(U,$J,358.3,23720,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23720,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Sleep D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,23720,1,4,0)
 ;;=4^F13.982
 ;;^UTILITY(U,$J,358.3,23720,2)
 ;;=^5003237
 ;;^UTILITY(U,$J,358.3,23721,0)
 ;;=F13.129^^61^922^24
 ;;^UTILITY(U,$J,358.3,23721,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23721,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Intoxication w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,23721,1,4,0)
 ;;=4^F13.129
 ;;^UTILITY(U,$J,358.3,23721,2)
 ;;=^5003192
 ;;^UTILITY(U,$J,358.3,23722,0)
 ;;=F13.229^^61^922^25
 ;;^UTILITY(U,$J,358.3,23722,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23722,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Intoxication w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,23722,1,4,0)
 ;;=4^F13.229
 ;;^UTILITY(U,$J,358.3,23722,2)
 ;;=^5003205
 ;;^UTILITY(U,$J,358.3,23723,0)
 ;;=F13.929^^61^922^26
 ;;^UTILITY(U,$J,358.3,23723,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23723,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Intoxication w/o Use D/O
 ;;^UTILITY(U,$J,358.3,23723,1,4,0)
 ;;=4^F13.929
 ;;^UTILITY(U,$J,358.3,23723,2)
 ;;=^5003224
 ;;^UTILITY(U,$J,358.3,23724,0)
 ;;=F13.121^^61^922^27
 ;;^UTILITY(U,$J,358.3,23724,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23724,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Intoxication Delirium w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,23724,1,4,0)
 ;;=4^F13.121
 ;;^UTILITY(U,$J,358.3,23724,2)
 ;;=^5003191
 ;;^UTILITY(U,$J,358.3,23725,0)
 ;;=F13.221^^61^922^28
 ;;^UTILITY(U,$J,358.3,23725,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23725,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Intoxication Delirium w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,23725,1,4,0)
 ;;=4^F13.221
 ;;^UTILITY(U,$J,358.3,23725,2)
 ;;=^5003204
 ;;^UTILITY(U,$J,358.3,23726,0)
 ;;=F13.921^^61^922^29
 ;;^UTILITY(U,$J,358.3,23726,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23726,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Intoxication Delirium w/o Use D/O
 ;;^UTILITY(U,$J,358.3,23726,1,4,0)
 ;;=4^F13.921
 ;;^UTILITY(U,$J,358.3,23726,2)
 ;;=^5003223
 ;;^UTILITY(U,$J,358.3,23727,0)
 ;;=F13.10^^61^922^31
 ;;^UTILITY(U,$J,358.3,23727,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23727,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Use D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,23727,1,4,0)
 ;;=4^F13.10
 ;;^UTILITY(U,$J,358.3,23727,2)
 ;;=^5003189
 ;;^UTILITY(U,$J,358.3,23728,0)
 ;;=F13.20^^61^922^32
 ;;^UTILITY(U,$J,358.3,23728,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23728,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Use D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,23728,1,4,0)
 ;;=4^F13.20
 ;;^UTILITY(U,$J,358.3,23728,2)
 ;;=^5003202
 ;;^UTILITY(U,$J,358.3,23729,0)
 ;;=F13.20^^61^922^33
 ;;^UTILITY(U,$J,358.3,23729,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23729,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Use D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,23729,1,4,0)
 ;;=4^F13.20
 ;;^UTILITY(U,$J,358.3,23729,2)
 ;;=^5003202
 ;;^UTILITY(U,$J,358.3,23730,0)
 ;;=F13.232^^61^922^34
 ;;^UTILITY(U,$J,358.3,23730,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23730,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Withdrawal w/ Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,23730,1,4,0)
 ;;=4^F13.232
 ;;^UTILITY(U,$J,358.3,23730,2)
 ;;=^5003208
 ;;^UTILITY(U,$J,358.3,23731,0)
 ;;=F13.239^^61^922^35
 ;;^UTILITY(U,$J,358.3,23731,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23731,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Withdrawal w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,23731,1,4,0)
 ;;=4^F13.239
 ;;^UTILITY(U,$J,358.3,23731,2)
 ;;=^5003209
 ;;^UTILITY(U,$J,358.3,23732,0)
 ;;=F13.231^^61^922^36
 ;;^UTILITY(U,$J,358.3,23732,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23732,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,23732,1,4,0)
 ;;=4^F13.231
 ;;^UTILITY(U,$J,358.3,23732,2)
 ;;=^5003207
 ;;^UTILITY(U,$J,358.3,23733,0)
 ;;=F13.99^^61^922^30
 ;;^UTILITY(U,$J,358.3,23733,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23733,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Related D/O,Unspec
 ;;^UTILITY(U,$J,358.3,23733,1,4,0)
 ;;=4^F13.99
 ;;^UTILITY(U,$J,358.3,23733,2)
 ;;=^5133353
 ;;^UTILITY(U,$J,358.3,23734,0)
 ;;=F17.200^^61^923^4
 ;;^UTILITY(U,$J,358.3,23734,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23734,1,3,0)
 ;;=3^Tobacco Use Disorder,Moderate
 ;;^UTILITY(U,$J,358.3,23734,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,23734,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,23735,0)
 ;;=F17.203^^61^923^6
 ;;^UTILITY(U,$J,358.3,23735,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23735,1,3,0)
 ;;=3^Tobacco Withdrawal
 ;;^UTILITY(U,$J,358.3,23735,1,4,0)
 ;;=4^F17.203
 ;;^UTILITY(U,$J,358.3,23735,2)
 ;;=^5003362
 ;;^UTILITY(U,$J,358.3,23736,0)
 ;;=F17.208^^61^923^1
 ;;^UTILITY(U,$J,358.3,23736,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23736,1,3,0)
 ;;=3^Nicotine Induced Sleep Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,23736,1,4,0)
 ;;=4^F17.208
 ;;^UTILITY(U,$J,358.3,23736,2)
 ;;=^5003363
 ;;^UTILITY(U,$J,358.3,23737,0)
 ;;=F17.209^^61^923^2
 ;;^UTILITY(U,$J,358.3,23737,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23737,1,3,0)
 ;;=3^Nicotine Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,23737,1,4,0)
 ;;=4^F17.209
 ;;^UTILITY(U,$J,358.3,23737,2)
 ;;=^5003364
 ;;^UTILITY(U,$J,358.3,23738,0)
 ;;=Z72.0^^61^923^3
 ;;^UTILITY(U,$J,358.3,23738,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23738,1,3,0)
 ;;=3^Tobacco Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,23738,1,4,0)
 ;;=4^Z72.0
 ;;^UTILITY(U,$J,358.3,23738,2)
 ;;=^5063255
 ;;^UTILITY(U,$J,358.3,23739,0)
 ;;=F17.200^^61^923^5
 ;;^UTILITY(U,$J,358.3,23739,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23739,1,3,0)
 ;;=3^Tobacco Use Disorder,Severe
 ;;^UTILITY(U,$J,358.3,23739,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,23739,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,23740,0)
 ;;=F43.0^^61^924^1
 ;;^UTILITY(U,$J,358.3,23740,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23740,1,3,0)
 ;;=3^Acute Stress Disorder
 ;;^UTILITY(U,$J,358.3,23740,1,4,0)
 ;;=4^F43.0
 ;;^UTILITY(U,$J,358.3,23740,2)
 ;;=^5003569
 ;;^UTILITY(U,$J,358.3,23741,0)
 ;;=F43.21^^61^924^3
 ;;^UTILITY(U,$J,358.3,23741,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23741,1,3,0)
 ;;=3^Adjustment Disorder w/ Depressed Mood
 ;;^UTILITY(U,$J,358.3,23741,1,4,0)
 ;;=4^F43.21
 ;;^UTILITY(U,$J,358.3,23741,2)
 ;;=^331948
 ;;^UTILITY(U,$J,358.3,23742,0)
 ;;=F43.22^^61^924^2
 ;;^UTILITY(U,$J,358.3,23742,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23742,1,3,0)
 ;;=3^Adjustment Disorder w/ Anxiety
 ;;^UTILITY(U,$J,358.3,23742,1,4,0)
 ;;=4^F43.22
 ;;^UTILITY(U,$J,358.3,23742,2)
 ;;=^331949
 ;;^UTILITY(U,$J,358.3,23743,0)
 ;;=F43.23^^61^924^5
 ;;^UTILITY(U,$J,358.3,23743,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23743,1,3,0)
 ;;=3^Adjustment Disorder w/ Mixed Anxiety & Depressed Mood
 ;;^UTILITY(U,$J,358.3,23743,1,4,0)
 ;;=4^F43.23
 ;;^UTILITY(U,$J,358.3,23743,2)
 ;;=^331950
 ;;^UTILITY(U,$J,358.3,23744,0)
 ;;=F43.24^^61^924^4
 ;;^UTILITY(U,$J,358.3,23744,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23744,1,3,0)
 ;;=3^Adjustment Disorder w/ Disturbance of Conduct
 ;;^UTILITY(U,$J,358.3,23744,1,4,0)
 ;;=4^F43.24
 ;;^UTILITY(U,$J,358.3,23744,2)
 ;;=^331951
 ;;^UTILITY(U,$J,358.3,23745,0)
 ;;=F43.25^^61^924^6
 ;;^UTILITY(U,$J,358.3,23745,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23745,1,3,0)
 ;;=3^Adjustment Disorder w/ Mixed Disturbance Emotions & Conduct
 ;;^UTILITY(U,$J,358.3,23745,1,4,0)
 ;;=4^F43.25
 ;;^UTILITY(U,$J,358.3,23745,2)
 ;;=^331952
 ;;^UTILITY(U,$J,358.3,23746,0)
 ;;=F43.20^^61^924^7
 ;;^UTILITY(U,$J,358.3,23746,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23746,1,3,0)
 ;;=3^Adjustment Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,23746,1,4,0)
 ;;=4^F43.20
 ;;^UTILITY(U,$J,358.3,23746,2)
 ;;=^5003573
 ;;^UTILITY(U,$J,358.3,23747,0)
 ;;=F43.9^^61^924^12
 ;;^UTILITY(U,$J,358.3,23747,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23747,1,3,0)
 ;;=3^Trauma/Stressor-Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,23747,1,4,0)
 ;;=4^F43.9
 ;;^UTILITY(U,$J,358.3,23747,2)
 ;;=^5003576
 ;;^UTILITY(U,$J,358.3,23748,0)
 ;;=F94.1^^61^924^10
 ;;^UTILITY(U,$J,358.3,23748,1,0)
 ;;=^358.31IA^4^2

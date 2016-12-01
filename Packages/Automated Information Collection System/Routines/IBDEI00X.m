IBDEI00X ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,634,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,634,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Psychotic D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,634,1,4,0)
 ;;=4^F13.959
 ;;^UTILITY(U,$J,358.3,634,2)
 ;;=^5003232
 ;;^UTILITY(U,$J,358.3,635,0)
 ;;=F13.181^^3^50^18
 ;;^UTILITY(U,$J,358.3,635,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,635,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Sexual Dysfunction w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,635,1,4,0)
 ;;=4^F13.181
 ;;^UTILITY(U,$J,358.3,635,2)
 ;;=^5003198
 ;;^UTILITY(U,$J,358.3,636,0)
 ;;=F13.281^^3^50^19
 ;;^UTILITY(U,$J,358.3,636,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,636,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Sexual Dysfunction w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,636,1,4,0)
 ;;=4^F13.281
 ;;^UTILITY(U,$J,358.3,636,2)
 ;;=^5003217
 ;;^UTILITY(U,$J,358.3,637,0)
 ;;=F13.981^^3^50^20
 ;;^UTILITY(U,$J,358.3,637,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,637,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Sexual Dysfunction w/o Use D/O
 ;;^UTILITY(U,$J,358.3,637,1,4,0)
 ;;=4^F13.981
 ;;^UTILITY(U,$J,358.3,637,2)
 ;;=^5003236
 ;;^UTILITY(U,$J,358.3,638,0)
 ;;=F13.182^^3^50^21
 ;;^UTILITY(U,$J,358.3,638,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,638,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Sleep D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,638,1,4,0)
 ;;=4^F13.182
 ;;^UTILITY(U,$J,358.3,638,2)
 ;;=^5003199
 ;;^UTILITY(U,$J,358.3,639,0)
 ;;=F13.282^^3^50^22
 ;;^UTILITY(U,$J,358.3,639,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,639,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Sleep D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,639,1,4,0)
 ;;=4^F13.282
 ;;^UTILITY(U,$J,358.3,639,2)
 ;;=^5003218
 ;;^UTILITY(U,$J,358.3,640,0)
 ;;=F13.982^^3^50^23
 ;;^UTILITY(U,$J,358.3,640,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,640,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Sleep D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,640,1,4,0)
 ;;=4^F13.982
 ;;^UTILITY(U,$J,358.3,640,2)
 ;;=^5003237
 ;;^UTILITY(U,$J,358.3,641,0)
 ;;=F13.129^^3^50^24
 ;;^UTILITY(U,$J,358.3,641,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,641,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Intoxication w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,641,1,4,0)
 ;;=4^F13.129
 ;;^UTILITY(U,$J,358.3,641,2)
 ;;=^5003192
 ;;^UTILITY(U,$J,358.3,642,0)
 ;;=F13.229^^3^50^25
 ;;^UTILITY(U,$J,358.3,642,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,642,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Intoxication w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,642,1,4,0)
 ;;=4^F13.229
 ;;^UTILITY(U,$J,358.3,642,2)
 ;;=^5003205
 ;;^UTILITY(U,$J,358.3,643,0)
 ;;=F13.929^^3^50^26
 ;;^UTILITY(U,$J,358.3,643,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,643,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Intoxication w/o Use D/O
 ;;^UTILITY(U,$J,358.3,643,1,4,0)
 ;;=4^F13.929
 ;;^UTILITY(U,$J,358.3,643,2)
 ;;=^5003224
 ;;^UTILITY(U,$J,358.3,644,0)
 ;;=F13.121^^3^50^27
 ;;^UTILITY(U,$J,358.3,644,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,644,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Intoxication Delirium w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,644,1,4,0)
 ;;=4^F13.121
 ;;^UTILITY(U,$J,358.3,644,2)
 ;;=^5003191
 ;;^UTILITY(U,$J,358.3,645,0)
 ;;=F13.221^^3^50^28
 ;;^UTILITY(U,$J,358.3,645,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,645,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Intoxication Delirium w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,645,1,4,0)
 ;;=4^F13.221
 ;;^UTILITY(U,$J,358.3,645,2)
 ;;=^5003204
 ;;^UTILITY(U,$J,358.3,646,0)
 ;;=F13.921^^3^50^29
 ;;^UTILITY(U,$J,358.3,646,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,646,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Intoxication Delirium w/o Use D/O
 ;;^UTILITY(U,$J,358.3,646,1,4,0)
 ;;=4^F13.921
 ;;^UTILITY(U,$J,358.3,646,2)
 ;;=^5003223
 ;;^UTILITY(U,$J,358.3,647,0)
 ;;=F13.10^^3^50^31
 ;;^UTILITY(U,$J,358.3,647,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,647,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Use D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,647,1,4,0)
 ;;=4^F13.10
 ;;^UTILITY(U,$J,358.3,647,2)
 ;;=^5003189
 ;;^UTILITY(U,$J,358.3,648,0)
 ;;=F13.20^^3^50^32
 ;;^UTILITY(U,$J,358.3,648,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,648,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Use D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,648,1,4,0)
 ;;=4^F13.20
 ;;^UTILITY(U,$J,358.3,648,2)
 ;;=^5003202
 ;;^UTILITY(U,$J,358.3,649,0)
 ;;=F13.20^^3^50^33
 ;;^UTILITY(U,$J,358.3,649,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,649,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Use D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,649,1,4,0)
 ;;=4^F13.20
 ;;^UTILITY(U,$J,358.3,649,2)
 ;;=^5003202
 ;;^UTILITY(U,$J,358.3,650,0)
 ;;=F13.232^^3^50^34
 ;;^UTILITY(U,$J,358.3,650,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,650,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Withdrawal w/ Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,650,1,4,0)
 ;;=4^F13.232
 ;;^UTILITY(U,$J,358.3,650,2)
 ;;=^5003208
 ;;^UTILITY(U,$J,358.3,651,0)
 ;;=F13.239^^3^50^35
 ;;^UTILITY(U,$J,358.3,651,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,651,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Withdrawal w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,651,1,4,0)
 ;;=4^F13.239
 ;;^UTILITY(U,$J,358.3,651,2)
 ;;=^5003209
 ;;^UTILITY(U,$J,358.3,652,0)
 ;;=F13.231^^3^50^36
 ;;^UTILITY(U,$J,358.3,652,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,652,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,652,1,4,0)
 ;;=4^F13.231
 ;;^UTILITY(U,$J,358.3,652,2)
 ;;=^5003207
 ;;^UTILITY(U,$J,358.3,653,0)
 ;;=F13.99^^3^50^30
 ;;^UTILITY(U,$J,358.3,653,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,653,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Related D/O,Unspec
 ;;^UTILITY(U,$J,358.3,653,1,4,0)
 ;;=4^F13.99
 ;;^UTILITY(U,$J,358.3,653,2)
 ;;=^5133353
 ;;^UTILITY(U,$J,358.3,654,0)
 ;;=F17.200^^3^51^4
 ;;^UTILITY(U,$J,358.3,654,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,654,1,3,0)
 ;;=3^Tobacco Use Disorder,Moderate
 ;;^UTILITY(U,$J,358.3,654,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,654,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,655,0)
 ;;=F17.203^^3^51^6
 ;;^UTILITY(U,$J,358.3,655,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,655,1,3,0)
 ;;=3^Tobacco Withdrawal
 ;;^UTILITY(U,$J,358.3,655,1,4,0)
 ;;=4^F17.203
 ;;^UTILITY(U,$J,358.3,655,2)
 ;;=^5003362
 ;;^UTILITY(U,$J,358.3,656,0)
 ;;=F17.208^^3^51^1
 ;;^UTILITY(U,$J,358.3,656,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,656,1,3,0)
 ;;=3^Nicotine Induced Sleep Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,656,1,4,0)
 ;;=4^F17.208
 ;;^UTILITY(U,$J,358.3,656,2)
 ;;=^5003363
 ;;^UTILITY(U,$J,358.3,657,0)
 ;;=F17.209^^3^51^2
 ;;^UTILITY(U,$J,358.3,657,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,657,1,3,0)
 ;;=3^Nicotine Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,657,1,4,0)
 ;;=4^F17.209
 ;;^UTILITY(U,$J,358.3,657,2)
 ;;=^5003364
 ;;^UTILITY(U,$J,358.3,658,0)
 ;;=Z72.0^^3^51^3
 ;;^UTILITY(U,$J,358.3,658,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,658,1,3,0)
 ;;=3^Tobacco Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,658,1,4,0)
 ;;=4^Z72.0
 ;;^UTILITY(U,$J,358.3,658,2)
 ;;=^5063255
 ;;^UTILITY(U,$J,358.3,659,0)
 ;;=F17.200^^3^51^5
 ;;^UTILITY(U,$J,358.3,659,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,659,1,3,0)
 ;;=3^Tobacco Use Disorder,Severe
 ;;^UTILITY(U,$J,358.3,659,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,659,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,660,0)
 ;;=F43.0^^3^52^1
 ;;^UTILITY(U,$J,358.3,660,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,660,1,3,0)
 ;;=3^Acute Stress Disorder
 ;;^UTILITY(U,$J,358.3,660,1,4,0)
 ;;=4^F43.0
 ;;^UTILITY(U,$J,358.3,660,2)
 ;;=^5003569
 ;;^UTILITY(U,$J,358.3,661,0)
 ;;=F43.21^^3^52^3
 ;;^UTILITY(U,$J,358.3,661,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,661,1,3,0)
 ;;=3^Adjustment Disorder w/ Depressed Mood
 ;;^UTILITY(U,$J,358.3,661,1,4,0)
 ;;=4^F43.21
 ;;^UTILITY(U,$J,358.3,661,2)
 ;;=^331948
 ;;^UTILITY(U,$J,358.3,662,0)
 ;;=F43.22^^3^52^2
 ;;^UTILITY(U,$J,358.3,662,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,662,1,3,0)
 ;;=3^Adjustment Disorder w/ Anxiety
 ;;^UTILITY(U,$J,358.3,662,1,4,0)
 ;;=4^F43.22
 ;;^UTILITY(U,$J,358.3,662,2)
 ;;=^331949
 ;;^UTILITY(U,$J,358.3,663,0)
 ;;=F43.23^^3^52^5
 ;;^UTILITY(U,$J,358.3,663,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,663,1,3,0)
 ;;=3^Adjustment Disorder w/ Mixed Anxiety & Depressed Mood
 ;;^UTILITY(U,$J,358.3,663,1,4,0)
 ;;=4^F43.23
 ;;^UTILITY(U,$J,358.3,663,2)
 ;;=^331950
 ;;^UTILITY(U,$J,358.3,664,0)
 ;;=F43.24^^3^52^4
 ;;^UTILITY(U,$J,358.3,664,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,664,1,3,0)
 ;;=3^Adjustment Disorder w/ Disturbance of Conduct
 ;;^UTILITY(U,$J,358.3,664,1,4,0)
 ;;=4^F43.24
 ;;^UTILITY(U,$J,358.3,664,2)
 ;;=^331951
 ;;^UTILITY(U,$J,358.3,665,0)
 ;;=F43.25^^3^52^6
 ;;^UTILITY(U,$J,358.3,665,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,665,1,3,0)
 ;;=3^Adjustment Disorder w/ Mixed Disturbance Emotions & Conduct
 ;;^UTILITY(U,$J,358.3,665,1,4,0)
 ;;=4^F43.25
 ;;^UTILITY(U,$J,358.3,665,2)
 ;;=^331952
 ;;^UTILITY(U,$J,358.3,666,0)
 ;;=F43.20^^3^52^7
 ;;^UTILITY(U,$J,358.3,666,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,666,1,3,0)
 ;;=3^Adjustment Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,666,1,4,0)
 ;;=4^F43.20
 ;;^UTILITY(U,$J,358.3,666,2)
 ;;=^5003573
 ;;^UTILITY(U,$J,358.3,667,0)
 ;;=F43.9^^3^52^12
 ;;^UTILITY(U,$J,358.3,667,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,667,1,3,0)
 ;;=3^Trauma/Stressor-Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,667,1,4,0)
 ;;=4^F43.9
 ;;^UTILITY(U,$J,358.3,667,2)
 ;;=^5003576
 ;;^UTILITY(U,$J,358.3,668,0)
 ;;=F94.1^^3^52^10
 ;;^UTILITY(U,$J,358.3,668,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,668,1,3,0)
 ;;=3^Reactive Attachment Disorder
 ;;^UTILITY(U,$J,358.3,668,1,4,0)
 ;;=4^F94.1
 ;;^UTILITY(U,$J,358.3,668,2)
 ;;=^5003705

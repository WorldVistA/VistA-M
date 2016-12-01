IBDEI0IO ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23682,1,4,0)
 ;;=4^F11.181
 ;;^UTILITY(U,$J,358.3,23682,2)
 ;;=^5003123
 ;;^UTILITY(U,$J,358.3,23683,0)
 ;;=F11.281^^61^921^9
 ;;^UTILITY(U,$J,358.3,23683,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23683,1,3,0)
 ;;=3^Opioid Induced Sexual Dysfunction w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,23683,1,4,0)
 ;;=4^F11.281
 ;;^UTILITY(U,$J,358.3,23683,2)
 ;;=^5003138
 ;;^UTILITY(U,$J,358.3,23684,0)
 ;;=F11.981^^61^921^10
 ;;^UTILITY(U,$J,358.3,23684,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23684,1,3,0)
 ;;=3^Opioid Induced Sexual Dysfunction w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,23684,1,4,0)
 ;;=4^F11.981
 ;;^UTILITY(U,$J,358.3,23684,2)
 ;;=^5003152
 ;;^UTILITY(U,$J,358.3,23685,0)
 ;;=F11.282^^61^921^12
 ;;^UTILITY(U,$J,358.3,23685,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23685,1,3,0)
 ;;=3^Opioid Induced Sleep Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,23685,1,4,0)
 ;;=4^F11.282
 ;;^UTILITY(U,$J,358.3,23685,2)
 ;;=^5003139
 ;;^UTILITY(U,$J,358.3,23686,0)
 ;;=F11.982^^61^921^13
 ;;^UTILITY(U,$J,358.3,23686,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23686,1,3,0)
 ;;=3^Opioid Induced Sleep Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,23686,1,4,0)
 ;;=4^F11.982
 ;;^UTILITY(U,$J,358.3,23686,2)
 ;;=^5003153
 ;;^UTILITY(U,$J,358.3,23687,0)
 ;;=F11.121^^61^921^14
 ;;^UTILITY(U,$J,358.3,23687,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23687,1,3,0)
 ;;=3^Opioid Intoxication Delirium w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,23687,1,4,0)
 ;;=4^F11.121
 ;;^UTILITY(U,$J,358.3,23687,2)
 ;;=^5003116
 ;;^UTILITY(U,$J,358.3,23688,0)
 ;;=F11.221^^61^921^15
 ;;^UTILITY(U,$J,358.3,23688,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23688,1,3,0)
 ;;=3^Opioid Intoxication Delirium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,23688,1,4,0)
 ;;=4^F11.221
 ;;^UTILITY(U,$J,358.3,23688,2)
 ;;=^5003130
 ;;^UTILITY(U,$J,358.3,23689,0)
 ;;=F11.921^^61^921^16
 ;;^UTILITY(U,$J,358.3,23689,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23689,1,3,0)
 ;;=3^Opioid Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,23689,1,4,0)
 ;;=4^F11.921
 ;;^UTILITY(U,$J,358.3,23689,2)
 ;;=^5003144
 ;;^UTILITY(U,$J,358.3,23690,0)
 ;;=F11.229^^61^921^21
 ;;^UTILITY(U,$J,358.3,23690,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23690,1,3,0)
 ;;=3^Opioid Intoxication w/o Perceptual Disturbance w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,23690,1,4,0)
 ;;=4^F11.229
 ;;^UTILITY(U,$J,358.3,23690,2)
 ;;=^5003132
 ;;^UTILITY(U,$J,358.3,23691,0)
 ;;=F11.929^^61^921^22
 ;;^UTILITY(U,$J,358.3,23691,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23691,1,3,0)
 ;;=3^Opioid Intoxication w/o Perceptual Disturbance w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,23691,1,4,0)
 ;;=4^F11.929
 ;;^UTILITY(U,$J,358.3,23691,2)
 ;;=^5003146
 ;;^UTILITY(U,$J,358.3,23692,0)
 ;;=F11.122^^61^921^17
 ;;^UTILITY(U,$J,358.3,23692,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23692,1,3,0)
 ;;=3^Opioid Intoxication w/ Perceptual Disturbance w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,23692,1,4,0)
 ;;=4^F11.122
 ;;^UTILITY(U,$J,358.3,23692,2)
 ;;=^5003117
 ;;^UTILITY(U,$J,358.3,23693,0)
 ;;=F11.222^^61^921^18
 ;;^UTILITY(U,$J,358.3,23693,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23693,1,3,0)
 ;;=3^Opioid Intoxication w/ Perceptual Disturbance w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,23693,1,4,0)
 ;;=4^F11.222
 ;;^UTILITY(U,$J,358.3,23693,2)
 ;;=^5003131
 ;;^UTILITY(U,$J,358.3,23694,0)
 ;;=F11.922^^61^921^19
 ;;^UTILITY(U,$J,358.3,23694,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23694,1,3,0)
 ;;=3^Opioid Intoxication w/ Perceptual Disturbance w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,23694,1,4,0)
 ;;=4^F11.922
 ;;^UTILITY(U,$J,358.3,23694,2)
 ;;=^5003145
 ;;^UTILITY(U,$J,358.3,23695,0)
 ;;=F11.99^^61^921^23
 ;;^UTILITY(U,$J,358.3,23695,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23695,1,3,0)
 ;;=3^Opioid Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,23695,1,4,0)
 ;;=4^F11.99
 ;;^UTILITY(U,$J,358.3,23695,2)
 ;;=^5133352
 ;;^UTILITY(U,$J,358.3,23696,0)
 ;;=F11.20^^61^921^26
 ;;^UTILITY(U,$J,358.3,23696,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23696,1,3,0)
 ;;=3^Opioid Use Disorder,Severe
 ;;^UTILITY(U,$J,358.3,23696,1,4,0)
 ;;=4^F11.20
 ;;^UTILITY(U,$J,358.3,23696,2)
 ;;=^5003127
 ;;^UTILITY(U,$J,358.3,23697,0)
 ;;=F11.23^^61^921^28
 ;;^UTILITY(U,$J,358.3,23697,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23697,1,3,0)
 ;;=3^Opioid Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,23697,1,4,0)
 ;;=4^F11.23
 ;;^UTILITY(U,$J,358.3,23697,2)
 ;;=^5003133
 ;;^UTILITY(U,$J,358.3,23698,0)
 ;;=F13.180^^61^922^1
 ;;^UTILITY(U,$J,358.3,23698,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23698,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Anxiety D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,23698,1,4,0)
 ;;=4^F13.180
 ;;^UTILITY(U,$J,358.3,23698,2)
 ;;=^5003197
 ;;^UTILITY(U,$J,358.3,23699,0)
 ;;=F13.280^^61^922^2
 ;;^UTILITY(U,$J,358.3,23699,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23699,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Anxiety D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,23699,1,4,0)
 ;;=4^F13.280
 ;;^UTILITY(U,$J,358.3,23699,2)
 ;;=^5003216
 ;;^UTILITY(U,$J,358.3,23700,0)
 ;;=F13.980^^61^922^3
 ;;^UTILITY(U,$J,358.3,23700,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23700,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Anxiety D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,23700,1,4,0)
 ;;=4^F13.980
 ;;^UTILITY(U,$J,358.3,23700,2)
 ;;=^5003235
 ;;^UTILITY(U,$J,358.3,23701,0)
 ;;=F13.14^^61^922^4
 ;;^UTILITY(U,$J,358.3,23701,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23701,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Bipolar & Rel D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,23701,1,4,0)
 ;;=4^F13.14
 ;;^UTILITY(U,$J,358.3,23701,2)
 ;;=^5003193
 ;;^UTILITY(U,$J,358.3,23702,0)
 ;;=F13.24^^61^922^5
 ;;^UTILITY(U,$J,358.3,23702,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23702,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Bipolar & Rel D/O w/ Mod-Sev Use D/O 
 ;;^UTILITY(U,$J,358.3,23702,1,4,0)
 ;;=4^F13.24
 ;;^UTILITY(U,$J,358.3,23702,2)
 ;;=^5003210
 ;;^UTILITY(U,$J,358.3,23703,0)
 ;;=F13.94^^61^922^6
 ;;^UTILITY(U,$J,358.3,23703,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23703,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Bipolar & Rel D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,23703,1,4,0)
 ;;=4^F13.94
 ;;^UTILITY(U,$J,358.3,23703,2)
 ;;=^5003229
 ;;^UTILITY(U,$J,358.3,23704,0)
 ;;=F13.921^^61^922^7
 ;;^UTILITY(U,$J,358.3,23704,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23704,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Delirium
 ;;^UTILITY(U,$J,358.3,23704,1,4,0)
 ;;=4^F13.921
 ;;^UTILITY(U,$J,358.3,23704,2)
 ;;=^5003223
 ;;^UTILITY(U,$J,358.3,23705,0)
 ;;=F13.14^^61^922^8
 ;;^UTILITY(U,$J,358.3,23705,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23705,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Depressive D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,23705,1,4,0)
 ;;=4^F13.14
 ;;^UTILITY(U,$J,358.3,23705,2)
 ;;=^5003193
 ;;^UTILITY(U,$J,358.3,23706,0)
 ;;=F13.24^^61^922^9
 ;;^UTILITY(U,$J,358.3,23706,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23706,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Depressive D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,23706,1,4,0)
 ;;=4^F13.24
 ;;^UTILITY(U,$J,358.3,23706,2)
 ;;=^5003210
 ;;^UTILITY(U,$J,358.3,23707,0)
 ;;=F13.94^^61^922^10
 ;;^UTILITY(U,$J,358.3,23707,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23707,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Depressive D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,23707,1,4,0)
 ;;=4^F13.94
 ;;^UTILITY(U,$J,358.3,23707,2)
 ;;=^5003229
 ;;^UTILITY(U,$J,358.3,23708,0)
 ;;=F13.27^^61^922^11
 ;;^UTILITY(U,$J,358.3,23708,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23708,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Maj Neurocog D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,23708,1,4,0)
 ;;=4^F13.27
 ;;^UTILITY(U,$J,358.3,23708,2)
 ;;=^5003215
 ;;^UTILITY(U,$J,358.3,23709,0)
 ;;=F13.97^^61^922^12
 ;;^UTILITY(U,$J,358.3,23709,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23709,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Maj Neurocog D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,23709,1,4,0)
 ;;=4^F13.97
 ;;^UTILITY(U,$J,358.3,23709,2)
 ;;=^5003234
 ;;^UTILITY(U,$J,358.3,23710,0)
 ;;=F13.288^^61^922^13
 ;;^UTILITY(U,$J,358.3,23710,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23710,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Mild Neurocog D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,23710,1,4,0)
 ;;=4^F13.288
 ;;^UTILITY(U,$J,358.3,23710,2)
 ;;=^5003219
 ;;^UTILITY(U,$J,358.3,23711,0)
 ;;=F13.988^^61^922^14
 ;;^UTILITY(U,$J,358.3,23711,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23711,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Mild Neurocog D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,23711,1,4,0)
 ;;=4^F13.988
 ;;^UTILITY(U,$J,358.3,23711,2)
 ;;=^5003238
 ;;^UTILITY(U,$J,358.3,23712,0)
 ;;=F13.159^^61^922^15
 ;;^UTILITY(U,$J,358.3,23712,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23712,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Psychotic D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,23712,1,4,0)
 ;;=4^F13.159
 ;;^UTILITY(U,$J,358.3,23712,2)
 ;;=^5003196
 ;;^UTILITY(U,$J,358.3,23713,0)
 ;;=F13.259^^61^922^16
 ;;^UTILITY(U,$J,358.3,23713,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23713,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Psychotic D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,23713,1,4,0)
 ;;=4^F13.259
 ;;^UTILITY(U,$J,358.3,23713,2)
 ;;=^5003213
 ;;^UTILITY(U,$J,358.3,23714,0)
 ;;=F13.959^^61^922^17
 ;;^UTILITY(U,$J,358.3,23714,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23714,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Psychotic D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,23714,1,4,0)
 ;;=4^F13.959
 ;;^UTILITY(U,$J,358.3,23714,2)
 ;;=^5003232

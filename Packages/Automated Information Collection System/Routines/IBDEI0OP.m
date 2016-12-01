IBDEI0OP ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31318,2)
 ;;=^5003152
 ;;^UTILITY(U,$J,358.3,31319,0)
 ;;=F11.282^^91^1360^12
 ;;^UTILITY(U,$J,358.3,31319,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31319,1,3,0)
 ;;=3^Opioid Induced Sleep Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,31319,1,4,0)
 ;;=4^F11.282
 ;;^UTILITY(U,$J,358.3,31319,2)
 ;;=^5003139
 ;;^UTILITY(U,$J,358.3,31320,0)
 ;;=F11.982^^91^1360^13
 ;;^UTILITY(U,$J,358.3,31320,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31320,1,3,0)
 ;;=3^Opioid Induced Sleep Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,31320,1,4,0)
 ;;=4^F11.982
 ;;^UTILITY(U,$J,358.3,31320,2)
 ;;=^5003153
 ;;^UTILITY(U,$J,358.3,31321,0)
 ;;=F11.121^^91^1360^14
 ;;^UTILITY(U,$J,358.3,31321,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31321,1,3,0)
 ;;=3^Opioid Intoxication Delirium w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,31321,1,4,0)
 ;;=4^F11.121
 ;;^UTILITY(U,$J,358.3,31321,2)
 ;;=^5003116
 ;;^UTILITY(U,$J,358.3,31322,0)
 ;;=F11.221^^91^1360^15
 ;;^UTILITY(U,$J,358.3,31322,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31322,1,3,0)
 ;;=3^Opioid Intoxication Delirium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,31322,1,4,0)
 ;;=4^F11.221
 ;;^UTILITY(U,$J,358.3,31322,2)
 ;;=^5003130
 ;;^UTILITY(U,$J,358.3,31323,0)
 ;;=F11.921^^91^1360^16
 ;;^UTILITY(U,$J,358.3,31323,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31323,1,3,0)
 ;;=3^Opioid Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,31323,1,4,0)
 ;;=4^F11.921
 ;;^UTILITY(U,$J,358.3,31323,2)
 ;;=^5003144
 ;;^UTILITY(U,$J,358.3,31324,0)
 ;;=F11.229^^91^1360^21
 ;;^UTILITY(U,$J,358.3,31324,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31324,1,3,0)
 ;;=3^Opioid Intoxication w/o Perceptual Disturbance w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,31324,1,4,0)
 ;;=4^F11.229
 ;;^UTILITY(U,$J,358.3,31324,2)
 ;;=^5003132
 ;;^UTILITY(U,$J,358.3,31325,0)
 ;;=F11.929^^91^1360^22
 ;;^UTILITY(U,$J,358.3,31325,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31325,1,3,0)
 ;;=3^Opioid Intoxication w/o Perceptual Disturbance w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,31325,1,4,0)
 ;;=4^F11.929
 ;;^UTILITY(U,$J,358.3,31325,2)
 ;;=^5003146
 ;;^UTILITY(U,$J,358.3,31326,0)
 ;;=F11.122^^91^1360^17
 ;;^UTILITY(U,$J,358.3,31326,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31326,1,3,0)
 ;;=3^Opioid Intoxication w/ Perceptual Disturbance w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,31326,1,4,0)
 ;;=4^F11.122
 ;;^UTILITY(U,$J,358.3,31326,2)
 ;;=^5003117
 ;;^UTILITY(U,$J,358.3,31327,0)
 ;;=F11.222^^91^1360^18
 ;;^UTILITY(U,$J,358.3,31327,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31327,1,3,0)
 ;;=3^Opioid Intoxication w/ Perceptual Disturbance w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,31327,1,4,0)
 ;;=4^F11.222
 ;;^UTILITY(U,$J,358.3,31327,2)
 ;;=^5003131
 ;;^UTILITY(U,$J,358.3,31328,0)
 ;;=F11.922^^91^1360^19
 ;;^UTILITY(U,$J,358.3,31328,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31328,1,3,0)
 ;;=3^Opioid Intoxication w/ Perceptual Disturbance w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,31328,1,4,0)
 ;;=4^F11.922
 ;;^UTILITY(U,$J,358.3,31328,2)
 ;;=^5003145
 ;;^UTILITY(U,$J,358.3,31329,0)
 ;;=F11.99^^91^1360^23
 ;;^UTILITY(U,$J,358.3,31329,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31329,1,3,0)
 ;;=3^Opioid Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,31329,1,4,0)
 ;;=4^F11.99
 ;;^UTILITY(U,$J,358.3,31329,2)
 ;;=^5133352
 ;;^UTILITY(U,$J,358.3,31330,0)
 ;;=F11.20^^91^1360^26
 ;;^UTILITY(U,$J,358.3,31330,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31330,1,3,0)
 ;;=3^Opioid Use Disorder,Severe
 ;;^UTILITY(U,$J,358.3,31330,1,4,0)
 ;;=4^F11.20
 ;;^UTILITY(U,$J,358.3,31330,2)
 ;;=^5003127
 ;;^UTILITY(U,$J,358.3,31331,0)
 ;;=F11.23^^91^1360^28
 ;;^UTILITY(U,$J,358.3,31331,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31331,1,3,0)
 ;;=3^Opioid Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,31331,1,4,0)
 ;;=4^F11.23
 ;;^UTILITY(U,$J,358.3,31331,2)
 ;;=^5003133
 ;;^UTILITY(U,$J,358.3,31332,0)
 ;;=F13.180^^91^1361^1
 ;;^UTILITY(U,$J,358.3,31332,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31332,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Anxiety D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,31332,1,4,0)
 ;;=4^F13.180
 ;;^UTILITY(U,$J,358.3,31332,2)
 ;;=^5003197
 ;;^UTILITY(U,$J,358.3,31333,0)
 ;;=F13.280^^91^1361^2
 ;;^UTILITY(U,$J,358.3,31333,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31333,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Anxiety D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,31333,1,4,0)
 ;;=4^F13.280
 ;;^UTILITY(U,$J,358.3,31333,2)
 ;;=^5003216
 ;;^UTILITY(U,$J,358.3,31334,0)
 ;;=F13.980^^91^1361^3
 ;;^UTILITY(U,$J,358.3,31334,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31334,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Anxiety D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,31334,1,4,0)
 ;;=4^F13.980
 ;;^UTILITY(U,$J,358.3,31334,2)
 ;;=^5003235
 ;;^UTILITY(U,$J,358.3,31335,0)
 ;;=F13.14^^91^1361^4
 ;;^UTILITY(U,$J,358.3,31335,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31335,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Bipolar & Rel D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,31335,1,4,0)
 ;;=4^F13.14
 ;;^UTILITY(U,$J,358.3,31335,2)
 ;;=^5003193
 ;;^UTILITY(U,$J,358.3,31336,0)
 ;;=F13.24^^91^1361^5
 ;;^UTILITY(U,$J,358.3,31336,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31336,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Bipolar & Rel D/O w/ Mod-Sev Use D/O 
 ;;^UTILITY(U,$J,358.3,31336,1,4,0)
 ;;=4^F13.24
 ;;^UTILITY(U,$J,358.3,31336,2)
 ;;=^5003210
 ;;^UTILITY(U,$J,358.3,31337,0)
 ;;=F13.94^^91^1361^6
 ;;^UTILITY(U,$J,358.3,31337,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31337,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Bipolar & Rel D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,31337,1,4,0)
 ;;=4^F13.94
 ;;^UTILITY(U,$J,358.3,31337,2)
 ;;=^5003229
 ;;^UTILITY(U,$J,358.3,31338,0)
 ;;=F13.921^^91^1361^7
 ;;^UTILITY(U,$J,358.3,31338,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31338,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Delirium
 ;;^UTILITY(U,$J,358.3,31338,1,4,0)
 ;;=4^F13.921
 ;;^UTILITY(U,$J,358.3,31338,2)
 ;;=^5003223
 ;;^UTILITY(U,$J,358.3,31339,0)
 ;;=F13.14^^91^1361^8
 ;;^UTILITY(U,$J,358.3,31339,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31339,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Depressive D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,31339,1,4,0)
 ;;=4^F13.14
 ;;^UTILITY(U,$J,358.3,31339,2)
 ;;=^5003193
 ;;^UTILITY(U,$J,358.3,31340,0)
 ;;=F13.24^^91^1361^9
 ;;^UTILITY(U,$J,358.3,31340,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31340,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Depressive D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,31340,1,4,0)
 ;;=4^F13.24
 ;;^UTILITY(U,$J,358.3,31340,2)
 ;;=^5003210
 ;;^UTILITY(U,$J,358.3,31341,0)
 ;;=F13.94^^91^1361^10
 ;;^UTILITY(U,$J,358.3,31341,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31341,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Depressive D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,31341,1,4,0)
 ;;=4^F13.94
 ;;^UTILITY(U,$J,358.3,31341,2)
 ;;=^5003229
 ;;^UTILITY(U,$J,358.3,31342,0)
 ;;=F13.27^^91^1361^11
 ;;^UTILITY(U,$J,358.3,31342,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31342,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Maj Neurocog D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,31342,1,4,0)
 ;;=4^F13.27
 ;;^UTILITY(U,$J,358.3,31342,2)
 ;;=^5003215
 ;;^UTILITY(U,$J,358.3,31343,0)
 ;;=F13.97^^91^1361^12
 ;;^UTILITY(U,$J,358.3,31343,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31343,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Maj Neurocog D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,31343,1,4,0)
 ;;=4^F13.97
 ;;^UTILITY(U,$J,358.3,31343,2)
 ;;=^5003234
 ;;^UTILITY(U,$J,358.3,31344,0)
 ;;=F13.288^^91^1361^13
 ;;^UTILITY(U,$J,358.3,31344,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31344,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Mild Neurocog D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,31344,1,4,0)
 ;;=4^F13.288
 ;;^UTILITY(U,$J,358.3,31344,2)
 ;;=^5003219
 ;;^UTILITY(U,$J,358.3,31345,0)
 ;;=F13.988^^91^1361^14
 ;;^UTILITY(U,$J,358.3,31345,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31345,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Mild Neurocog D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,31345,1,4,0)
 ;;=4^F13.988
 ;;^UTILITY(U,$J,358.3,31345,2)
 ;;=^5003238
 ;;^UTILITY(U,$J,358.3,31346,0)
 ;;=F13.159^^91^1361^15
 ;;^UTILITY(U,$J,358.3,31346,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31346,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Psychotic D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,31346,1,4,0)
 ;;=4^F13.159
 ;;^UTILITY(U,$J,358.3,31346,2)
 ;;=^5003196
 ;;^UTILITY(U,$J,358.3,31347,0)
 ;;=F13.259^^91^1361^16
 ;;^UTILITY(U,$J,358.3,31347,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31347,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Psychotic D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,31347,1,4,0)
 ;;=4^F13.259
 ;;^UTILITY(U,$J,358.3,31347,2)
 ;;=^5003213
 ;;^UTILITY(U,$J,358.3,31348,0)
 ;;=F13.959^^91^1361^17
 ;;^UTILITY(U,$J,358.3,31348,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31348,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Psychotic D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,31348,1,4,0)
 ;;=4^F13.959
 ;;^UTILITY(U,$J,358.3,31348,2)
 ;;=^5003232
 ;;^UTILITY(U,$J,358.3,31349,0)
 ;;=F13.181^^91^1361^18
 ;;^UTILITY(U,$J,358.3,31349,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31349,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Sexual Dysfunction w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,31349,1,4,0)
 ;;=4^F13.181
 ;;^UTILITY(U,$J,358.3,31349,2)
 ;;=^5003198
 ;;^UTILITY(U,$J,358.3,31350,0)
 ;;=F13.281^^91^1361^19
 ;;^UTILITY(U,$J,358.3,31350,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31350,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Sexual Dysfunction w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,31350,1,4,0)
 ;;=4^F13.281

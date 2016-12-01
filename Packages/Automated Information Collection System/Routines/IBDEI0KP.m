IBDEI0KP ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,26198,1,4,0)
 ;;=4^F11.929
 ;;^UTILITY(U,$J,358.3,26198,2)
 ;;=^5003146
 ;;^UTILITY(U,$J,358.3,26199,0)
 ;;=F11.122^^69^1086^17
 ;;^UTILITY(U,$J,358.3,26199,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26199,1,3,0)
 ;;=3^Opioid Intoxication w/ Perceptual Disturbance w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,26199,1,4,0)
 ;;=4^F11.122
 ;;^UTILITY(U,$J,358.3,26199,2)
 ;;=^5003117
 ;;^UTILITY(U,$J,358.3,26200,0)
 ;;=F11.222^^69^1086^18
 ;;^UTILITY(U,$J,358.3,26200,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26200,1,3,0)
 ;;=3^Opioid Intoxication w/ Perceptual Disturbance w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,26200,1,4,0)
 ;;=4^F11.222
 ;;^UTILITY(U,$J,358.3,26200,2)
 ;;=^5003131
 ;;^UTILITY(U,$J,358.3,26201,0)
 ;;=F11.922^^69^1086^19
 ;;^UTILITY(U,$J,358.3,26201,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26201,1,3,0)
 ;;=3^Opioid Intoxication w/ Perceptual Disturbance w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,26201,1,4,0)
 ;;=4^F11.922
 ;;^UTILITY(U,$J,358.3,26201,2)
 ;;=^5003145
 ;;^UTILITY(U,$J,358.3,26202,0)
 ;;=F11.99^^69^1086^23
 ;;^UTILITY(U,$J,358.3,26202,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26202,1,3,0)
 ;;=3^Opioid Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,26202,1,4,0)
 ;;=4^F11.99
 ;;^UTILITY(U,$J,358.3,26202,2)
 ;;=^5133352
 ;;^UTILITY(U,$J,358.3,26203,0)
 ;;=F11.20^^69^1086^26
 ;;^UTILITY(U,$J,358.3,26203,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26203,1,3,0)
 ;;=3^Opioid Use Disorder,Severe
 ;;^UTILITY(U,$J,358.3,26203,1,4,0)
 ;;=4^F11.20
 ;;^UTILITY(U,$J,358.3,26203,2)
 ;;=^5003127
 ;;^UTILITY(U,$J,358.3,26204,0)
 ;;=F11.23^^69^1086^28
 ;;^UTILITY(U,$J,358.3,26204,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26204,1,3,0)
 ;;=3^Opioid Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,26204,1,4,0)
 ;;=4^F11.23
 ;;^UTILITY(U,$J,358.3,26204,2)
 ;;=^5003133
 ;;^UTILITY(U,$J,358.3,26205,0)
 ;;=F13.180^^69^1087^1
 ;;^UTILITY(U,$J,358.3,26205,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26205,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Anxiety D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,26205,1,4,0)
 ;;=4^F13.180
 ;;^UTILITY(U,$J,358.3,26205,2)
 ;;=^5003197
 ;;^UTILITY(U,$J,358.3,26206,0)
 ;;=F13.280^^69^1087^2
 ;;^UTILITY(U,$J,358.3,26206,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26206,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Anxiety D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,26206,1,4,0)
 ;;=4^F13.280
 ;;^UTILITY(U,$J,358.3,26206,2)
 ;;=^5003216
 ;;^UTILITY(U,$J,358.3,26207,0)
 ;;=F13.980^^69^1087^3
 ;;^UTILITY(U,$J,358.3,26207,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26207,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Anxiety D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,26207,1,4,0)
 ;;=4^F13.980
 ;;^UTILITY(U,$J,358.3,26207,2)
 ;;=^5003235
 ;;^UTILITY(U,$J,358.3,26208,0)
 ;;=F13.14^^69^1087^4
 ;;^UTILITY(U,$J,358.3,26208,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26208,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Bipolar & Rel D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,26208,1,4,0)
 ;;=4^F13.14
 ;;^UTILITY(U,$J,358.3,26208,2)
 ;;=^5003193
 ;;^UTILITY(U,$J,358.3,26209,0)
 ;;=F13.24^^69^1087^5
 ;;^UTILITY(U,$J,358.3,26209,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26209,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Bipolar & Rel D/O w/ Mod-Sev Use D/O 
 ;;^UTILITY(U,$J,358.3,26209,1,4,0)
 ;;=4^F13.24
 ;;^UTILITY(U,$J,358.3,26209,2)
 ;;=^5003210
 ;;^UTILITY(U,$J,358.3,26210,0)
 ;;=F13.94^^69^1087^6
 ;;^UTILITY(U,$J,358.3,26210,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26210,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Bipolar & Rel D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,26210,1,4,0)
 ;;=4^F13.94
 ;;^UTILITY(U,$J,358.3,26210,2)
 ;;=^5003229
 ;;^UTILITY(U,$J,358.3,26211,0)
 ;;=F13.921^^69^1087^7
 ;;^UTILITY(U,$J,358.3,26211,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26211,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Delirium
 ;;^UTILITY(U,$J,358.3,26211,1,4,0)
 ;;=4^F13.921
 ;;^UTILITY(U,$J,358.3,26211,2)
 ;;=^5003223
 ;;^UTILITY(U,$J,358.3,26212,0)
 ;;=F13.14^^69^1087^8
 ;;^UTILITY(U,$J,358.3,26212,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26212,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Depressive D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,26212,1,4,0)
 ;;=4^F13.14
 ;;^UTILITY(U,$J,358.3,26212,2)
 ;;=^5003193
 ;;^UTILITY(U,$J,358.3,26213,0)
 ;;=F13.24^^69^1087^9
 ;;^UTILITY(U,$J,358.3,26213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26213,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Depressive D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,26213,1,4,0)
 ;;=4^F13.24
 ;;^UTILITY(U,$J,358.3,26213,2)
 ;;=^5003210
 ;;^UTILITY(U,$J,358.3,26214,0)
 ;;=F13.94^^69^1087^10
 ;;^UTILITY(U,$J,358.3,26214,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26214,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Depressive D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,26214,1,4,0)
 ;;=4^F13.94
 ;;^UTILITY(U,$J,358.3,26214,2)
 ;;=^5003229
 ;;^UTILITY(U,$J,358.3,26215,0)
 ;;=F13.27^^69^1087^11
 ;;^UTILITY(U,$J,358.3,26215,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26215,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Maj Neurocog D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,26215,1,4,0)
 ;;=4^F13.27
 ;;^UTILITY(U,$J,358.3,26215,2)
 ;;=^5003215
 ;;^UTILITY(U,$J,358.3,26216,0)
 ;;=F13.97^^69^1087^12
 ;;^UTILITY(U,$J,358.3,26216,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26216,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Maj Neurocog D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,26216,1,4,0)
 ;;=4^F13.97
 ;;^UTILITY(U,$J,358.3,26216,2)
 ;;=^5003234
 ;;^UTILITY(U,$J,358.3,26217,0)
 ;;=F13.288^^69^1087^13
 ;;^UTILITY(U,$J,358.3,26217,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26217,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Mild Neurocog D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,26217,1,4,0)
 ;;=4^F13.288
 ;;^UTILITY(U,$J,358.3,26217,2)
 ;;=^5003219
 ;;^UTILITY(U,$J,358.3,26218,0)
 ;;=F13.988^^69^1087^14
 ;;^UTILITY(U,$J,358.3,26218,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26218,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Mild Neurocog D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,26218,1,4,0)
 ;;=4^F13.988
 ;;^UTILITY(U,$J,358.3,26218,2)
 ;;=^5003238
 ;;^UTILITY(U,$J,358.3,26219,0)
 ;;=F13.159^^69^1087^15
 ;;^UTILITY(U,$J,358.3,26219,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26219,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Psychotic D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,26219,1,4,0)
 ;;=4^F13.159
 ;;^UTILITY(U,$J,358.3,26219,2)
 ;;=^5003196
 ;;^UTILITY(U,$J,358.3,26220,0)
 ;;=F13.259^^69^1087^16
 ;;^UTILITY(U,$J,358.3,26220,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26220,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Psychotic D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,26220,1,4,0)
 ;;=4^F13.259
 ;;^UTILITY(U,$J,358.3,26220,2)
 ;;=^5003213
 ;;^UTILITY(U,$J,358.3,26221,0)
 ;;=F13.959^^69^1087^17
 ;;^UTILITY(U,$J,358.3,26221,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26221,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Psychotic D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,26221,1,4,0)
 ;;=4^F13.959
 ;;^UTILITY(U,$J,358.3,26221,2)
 ;;=^5003232
 ;;^UTILITY(U,$J,358.3,26222,0)
 ;;=F13.181^^69^1087^18
 ;;^UTILITY(U,$J,358.3,26222,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26222,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Sexual Dysfunction w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,26222,1,4,0)
 ;;=4^F13.181
 ;;^UTILITY(U,$J,358.3,26222,2)
 ;;=^5003198
 ;;^UTILITY(U,$J,358.3,26223,0)
 ;;=F13.281^^69^1087^19
 ;;^UTILITY(U,$J,358.3,26223,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26223,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Sexual Dysfunction w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,26223,1,4,0)
 ;;=4^F13.281
 ;;^UTILITY(U,$J,358.3,26223,2)
 ;;=^5003217
 ;;^UTILITY(U,$J,358.3,26224,0)
 ;;=F13.981^^69^1087^20
 ;;^UTILITY(U,$J,358.3,26224,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26224,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Sexual Dysfunction w/o Use D/O
 ;;^UTILITY(U,$J,358.3,26224,1,4,0)
 ;;=4^F13.981
 ;;^UTILITY(U,$J,358.3,26224,2)
 ;;=^5003236
 ;;^UTILITY(U,$J,358.3,26225,0)
 ;;=F13.182^^69^1087^21
 ;;^UTILITY(U,$J,358.3,26225,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26225,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Sleep D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,26225,1,4,0)
 ;;=4^F13.182
 ;;^UTILITY(U,$J,358.3,26225,2)
 ;;=^5003199
 ;;^UTILITY(U,$J,358.3,26226,0)
 ;;=F13.282^^69^1087^22
 ;;^UTILITY(U,$J,358.3,26226,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26226,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Sleep D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,26226,1,4,0)
 ;;=4^F13.282
 ;;^UTILITY(U,$J,358.3,26226,2)
 ;;=^5003218
 ;;^UTILITY(U,$J,358.3,26227,0)
 ;;=F13.982^^69^1087^23
 ;;^UTILITY(U,$J,358.3,26227,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26227,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Sleep D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,26227,1,4,0)
 ;;=4^F13.982
 ;;^UTILITY(U,$J,358.3,26227,2)
 ;;=^5003237
 ;;^UTILITY(U,$J,358.3,26228,0)
 ;;=F13.129^^69^1087^24
 ;;^UTILITY(U,$J,358.3,26228,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26228,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Intoxication w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,26228,1,4,0)
 ;;=4^F13.129
 ;;^UTILITY(U,$J,358.3,26228,2)
 ;;=^5003192
 ;;^UTILITY(U,$J,358.3,26229,0)
 ;;=F13.229^^69^1087^25
 ;;^UTILITY(U,$J,358.3,26229,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26229,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Intoxication w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,26229,1,4,0)
 ;;=4^F13.229
 ;;^UTILITY(U,$J,358.3,26229,2)
 ;;=^5003205
 ;;^UTILITY(U,$J,358.3,26230,0)
 ;;=F13.929^^69^1087^26
 ;;^UTILITY(U,$J,358.3,26230,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26230,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Intoxication w/o Use D/O

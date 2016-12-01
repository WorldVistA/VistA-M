IBDEI00W ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,600,1,3,0)
 ;;=3^Opioid Induced Delirium
 ;;^UTILITY(U,$J,358.3,600,1,4,0)
 ;;=4^F11.921
 ;;^UTILITY(U,$J,358.3,600,2)
 ;;=^5003144
 ;;^UTILITY(U,$J,358.3,601,0)
 ;;=F11.94^^3^49^7
 ;;^UTILITY(U,$J,358.3,601,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,601,1,3,0)
 ;;=3^Opioid Induced Depressive Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,601,1,4,0)
 ;;=4^F11.94
 ;;^UTILITY(U,$J,358.3,601,2)
 ;;=^5003148
 ;;^UTILITY(U,$J,358.3,602,0)
 ;;=F11.181^^3^49^8
 ;;^UTILITY(U,$J,358.3,602,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,602,1,3,0)
 ;;=3^Opioid Induced Sexual Dysfunction w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,602,1,4,0)
 ;;=4^F11.181
 ;;^UTILITY(U,$J,358.3,602,2)
 ;;=^5003123
 ;;^UTILITY(U,$J,358.3,603,0)
 ;;=F11.281^^3^49^9
 ;;^UTILITY(U,$J,358.3,603,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,603,1,3,0)
 ;;=3^Opioid Induced Sexual Dysfunction w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,603,1,4,0)
 ;;=4^F11.281
 ;;^UTILITY(U,$J,358.3,603,2)
 ;;=^5003138
 ;;^UTILITY(U,$J,358.3,604,0)
 ;;=F11.981^^3^49^10
 ;;^UTILITY(U,$J,358.3,604,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,604,1,3,0)
 ;;=3^Opioid Induced Sexual Dysfunction w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,604,1,4,0)
 ;;=4^F11.981
 ;;^UTILITY(U,$J,358.3,604,2)
 ;;=^5003152
 ;;^UTILITY(U,$J,358.3,605,0)
 ;;=F11.282^^3^49^12
 ;;^UTILITY(U,$J,358.3,605,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,605,1,3,0)
 ;;=3^Opioid Induced Sleep Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,605,1,4,0)
 ;;=4^F11.282
 ;;^UTILITY(U,$J,358.3,605,2)
 ;;=^5003139
 ;;^UTILITY(U,$J,358.3,606,0)
 ;;=F11.982^^3^49^13
 ;;^UTILITY(U,$J,358.3,606,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,606,1,3,0)
 ;;=3^Opioid Induced Sleep Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,606,1,4,0)
 ;;=4^F11.982
 ;;^UTILITY(U,$J,358.3,606,2)
 ;;=^5003153
 ;;^UTILITY(U,$J,358.3,607,0)
 ;;=F11.121^^3^49^14
 ;;^UTILITY(U,$J,358.3,607,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,607,1,3,0)
 ;;=3^Opioid Intoxication Delirium w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,607,1,4,0)
 ;;=4^F11.121
 ;;^UTILITY(U,$J,358.3,607,2)
 ;;=^5003116
 ;;^UTILITY(U,$J,358.3,608,0)
 ;;=F11.221^^3^49^15
 ;;^UTILITY(U,$J,358.3,608,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,608,1,3,0)
 ;;=3^Opioid Intoxication Delirium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,608,1,4,0)
 ;;=4^F11.221
 ;;^UTILITY(U,$J,358.3,608,2)
 ;;=^5003130
 ;;^UTILITY(U,$J,358.3,609,0)
 ;;=F11.921^^3^49^16
 ;;^UTILITY(U,$J,358.3,609,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,609,1,3,0)
 ;;=3^Opioid Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,609,1,4,0)
 ;;=4^F11.921
 ;;^UTILITY(U,$J,358.3,609,2)
 ;;=^5003144
 ;;^UTILITY(U,$J,358.3,610,0)
 ;;=F11.229^^3^49^21
 ;;^UTILITY(U,$J,358.3,610,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,610,1,3,0)
 ;;=3^Opioid Intoxication w/o Perceptual Disturbance w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,610,1,4,0)
 ;;=4^F11.229
 ;;^UTILITY(U,$J,358.3,610,2)
 ;;=^5003132
 ;;^UTILITY(U,$J,358.3,611,0)
 ;;=F11.929^^3^49^22
 ;;^UTILITY(U,$J,358.3,611,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,611,1,3,0)
 ;;=3^Opioid Intoxication w/o Perceptual Disturbance w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,611,1,4,0)
 ;;=4^F11.929
 ;;^UTILITY(U,$J,358.3,611,2)
 ;;=^5003146
 ;;^UTILITY(U,$J,358.3,612,0)
 ;;=F11.122^^3^49^17
 ;;^UTILITY(U,$J,358.3,612,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,612,1,3,0)
 ;;=3^Opioid Intoxication w/ Perceptual Disturbance w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,612,1,4,0)
 ;;=4^F11.122
 ;;^UTILITY(U,$J,358.3,612,2)
 ;;=^5003117
 ;;^UTILITY(U,$J,358.3,613,0)
 ;;=F11.222^^3^49^18
 ;;^UTILITY(U,$J,358.3,613,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,613,1,3,0)
 ;;=3^Opioid Intoxication w/ Perceptual Disturbance w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,613,1,4,0)
 ;;=4^F11.222
 ;;^UTILITY(U,$J,358.3,613,2)
 ;;=^5003131
 ;;^UTILITY(U,$J,358.3,614,0)
 ;;=F11.922^^3^49^19
 ;;^UTILITY(U,$J,358.3,614,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,614,1,3,0)
 ;;=3^Opioid Intoxication w/ Perceptual Disturbance w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,614,1,4,0)
 ;;=4^F11.922
 ;;^UTILITY(U,$J,358.3,614,2)
 ;;=^5003145
 ;;^UTILITY(U,$J,358.3,615,0)
 ;;=F11.99^^3^49^23
 ;;^UTILITY(U,$J,358.3,615,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,615,1,3,0)
 ;;=3^Opioid Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,615,1,4,0)
 ;;=4^F11.99
 ;;^UTILITY(U,$J,358.3,615,2)
 ;;=^5133352
 ;;^UTILITY(U,$J,358.3,616,0)
 ;;=F11.20^^3^49^26
 ;;^UTILITY(U,$J,358.3,616,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,616,1,3,0)
 ;;=3^Opioid Use Disorder,Severe
 ;;^UTILITY(U,$J,358.3,616,1,4,0)
 ;;=4^F11.20
 ;;^UTILITY(U,$J,358.3,616,2)
 ;;=^5003127
 ;;^UTILITY(U,$J,358.3,617,0)
 ;;=F11.23^^3^49^28
 ;;^UTILITY(U,$J,358.3,617,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,617,1,3,0)
 ;;=3^Opioid Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,617,1,4,0)
 ;;=4^F11.23
 ;;^UTILITY(U,$J,358.3,617,2)
 ;;=^5003133
 ;;^UTILITY(U,$J,358.3,618,0)
 ;;=F13.180^^3^50^1
 ;;^UTILITY(U,$J,358.3,618,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,618,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Anxiety D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,618,1,4,0)
 ;;=4^F13.180
 ;;^UTILITY(U,$J,358.3,618,2)
 ;;=^5003197
 ;;^UTILITY(U,$J,358.3,619,0)
 ;;=F13.280^^3^50^2
 ;;^UTILITY(U,$J,358.3,619,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,619,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Anxiety D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,619,1,4,0)
 ;;=4^F13.280
 ;;^UTILITY(U,$J,358.3,619,2)
 ;;=^5003216
 ;;^UTILITY(U,$J,358.3,620,0)
 ;;=F13.980^^3^50^3
 ;;^UTILITY(U,$J,358.3,620,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,620,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Anxiety D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,620,1,4,0)
 ;;=4^F13.980
 ;;^UTILITY(U,$J,358.3,620,2)
 ;;=^5003235
 ;;^UTILITY(U,$J,358.3,621,0)
 ;;=F13.14^^3^50^4
 ;;^UTILITY(U,$J,358.3,621,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,621,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Bipolar & Rel D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,621,1,4,0)
 ;;=4^F13.14
 ;;^UTILITY(U,$J,358.3,621,2)
 ;;=^5003193
 ;;^UTILITY(U,$J,358.3,622,0)
 ;;=F13.24^^3^50^5
 ;;^UTILITY(U,$J,358.3,622,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,622,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Bipolar & Rel D/O w/ Mod-Sev Use D/O 
 ;;^UTILITY(U,$J,358.3,622,1,4,0)
 ;;=4^F13.24
 ;;^UTILITY(U,$J,358.3,622,2)
 ;;=^5003210
 ;;^UTILITY(U,$J,358.3,623,0)
 ;;=F13.94^^3^50^6
 ;;^UTILITY(U,$J,358.3,623,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,623,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Bipolar & Rel D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,623,1,4,0)
 ;;=4^F13.94
 ;;^UTILITY(U,$J,358.3,623,2)
 ;;=^5003229
 ;;^UTILITY(U,$J,358.3,624,0)
 ;;=F13.921^^3^50^7
 ;;^UTILITY(U,$J,358.3,624,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,624,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Delirium
 ;;^UTILITY(U,$J,358.3,624,1,4,0)
 ;;=4^F13.921
 ;;^UTILITY(U,$J,358.3,624,2)
 ;;=^5003223
 ;;^UTILITY(U,$J,358.3,625,0)
 ;;=F13.14^^3^50^8
 ;;^UTILITY(U,$J,358.3,625,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,625,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Depressive D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,625,1,4,0)
 ;;=4^F13.14
 ;;^UTILITY(U,$J,358.3,625,2)
 ;;=^5003193
 ;;^UTILITY(U,$J,358.3,626,0)
 ;;=F13.24^^3^50^9
 ;;^UTILITY(U,$J,358.3,626,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,626,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Depressive D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,626,1,4,0)
 ;;=4^F13.24
 ;;^UTILITY(U,$J,358.3,626,2)
 ;;=^5003210
 ;;^UTILITY(U,$J,358.3,627,0)
 ;;=F13.94^^3^50^10
 ;;^UTILITY(U,$J,358.3,627,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,627,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Depressive D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,627,1,4,0)
 ;;=4^F13.94
 ;;^UTILITY(U,$J,358.3,627,2)
 ;;=^5003229
 ;;^UTILITY(U,$J,358.3,628,0)
 ;;=F13.27^^3^50^11
 ;;^UTILITY(U,$J,358.3,628,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,628,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Maj Neurocog D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,628,1,4,0)
 ;;=4^F13.27
 ;;^UTILITY(U,$J,358.3,628,2)
 ;;=^5003215
 ;;^UTILITY(U,$J,358.3,629,0)
 ;;=F13.97^^3^50^12
 ;;^UTILITY(U,$J,358.3,629,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,629,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Maj Neurocog D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,629,1,4,0)
 ;;=4^F13.97
 ;;^UTILITY(U,$J,358.3,629,2)
 ;;=^5003234
 ;;^UTILITY(U,$J,358.3,630,0)
 ;;=F13.288^^3^50^13
 ;;^UTILITY(U,$J,358.3,630,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,630,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Mild Neurocog D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,630,1,4,0)
 ;;=4^F13.288
 ;;^UTILITY(U,$J,358.3,630,2)
 ;;=^5003219
 ;;^UTILITY(U,$J,358.3,631,0)
 ;;=F13.988^^3^50^14
 ;;^UTILITY(U,$J,358.3,631,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,631,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Mild Neurocog D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,631,1,4,0)
 ;;=4^F13.988
 ;;^UTILITY(U,$J,358.3,631,2)
 ;;=^5003238
 ;;^UTILITY(U,$J,358.3,632,0)
 ;;=F13.159^^3^50^15
 ;;^UTILITY(U,$J,358.3,632,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,632,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Psychotic D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,632,1,4,0)
 ;;=4^F13.159
 ;;^UTILITY(U,$J,358.3,632,2)
 ;;=^5003196
 ;;^UTILITY(U,$J,358.3,633,0)
 ;;=F13.259^^3^50^16
 ;;^UTILITY(U,$J,358.3,633,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,633,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Psychotic D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,633,1,4,0)
 ;;=4^F13.259
 ;;^UTILITY(U,$J,358.3,633,2)
 ;;=^5003213
 ;;^UTILITY(U,$J,358.3,634,0)
 ;;=F13.959^^3^50^17

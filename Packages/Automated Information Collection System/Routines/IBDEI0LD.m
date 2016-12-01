IBDEI0LD ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,27026,1,4,0)
 ;;=4^F16.929
 ;;^UTILITY(U,$J,358.3,27026,2)
 ;;=^5003352
 ;;^UTILITY(U,$J,358.3,27027,0)
 ;;=F16.121^^71^1138^29
 ;;^UTILITY(U,$J,358.3,27027,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27027,1,3,0)
 ;;=3^Phencyclidine Intoxication Delirium w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,27027,1,4,0)
 ;;=4^F16.121
 ;;^UTILITY(U,$J,358.3,27027,2)
 ;;=^5003325
 ;;^UTILITY(U,$J,358.3,27028,0)
 ;;=F16.221^^71^1138^30
 ;;^UTILITY(U,$J,358.3,27028,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27028,1,3,0)
 ;;=3^Phencyclidine Intoxication Delirium w/ Moderate/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,27028,1,4,0)
 ;;=4^F16.221
 ;;^UTILITY(U,$J,358.3,27028,2)
 ;;=^5003339
 ;;^UTILITY(U,$J,358.3,27029,0)
 ;;=F16.921^^71^1138^31
 ;;^UTILITY(U,$J,358.3,27029,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27029,1,3,0)
 ;;=3^Phencyclidine Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,27029,1,4,0)
 ;;=4^F16.921
 ;;^UTILITY(U,$J,358.3,27029,2)
 ;;=^5003351
 ;;^UTILITY(U,$J,358.3,27030,0)
 ;;=F11.10^^71^1139^24
 ;;^UTILITY(U,$J,358.3,27030,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27030,1,3,0)
 ;;=3^Opioid Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,27030,1,4,0)
 ;;=4^F11.10
 ;;^UTILITY(U,$J,358.3,27030,2)
 ;;=^5003114
 ;;^UTILITY(U,$J,358.3,27031,0)
 ;;=F11.129^^71^1139^20
 ;;^UTILITY(U,$J,358.3,27031,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27031,1,3,0)
 ;;=3^Opioid Intoxication w/o Perceptual Disturbances w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,27031,1,4,0)
 ;;=4^F11.129
 ;;^UTILITY(U,$J,358.3,27031,2)
 ;;=^5003118
 ;;^UTILITY(U,$J,358.3,27032,0)
 ;;=F11.14^^71^1139^5
 ;;^UTILITY(U,$J,358.3,27032,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27032,1,3,0)
 ;;=3^Opioid Induced Depressive Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,27032,1,4,0)
 ;;=4^F11.14
 ;;^UTILITY(U,$J,358.3,27032,2)
 ;;=^5003119
 ;;^UTILITY(U,$J,358.3,27033,0)
 ;;=F11.182^^71^1139^11
 ;;^UTILITY(U,$J,358.3,27033,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27033,1,3,0)
 ;;=3^Opioid Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,27033,1,4,0)
 ;;=4^F11.182
 ;;^UTILITY(U,$J,358.3,27033,2)
 ;;=^5003124
 ;;^UTILITY(U,$J,358.3,27034,0)
 ;;=F11.20^^71^1139^25
 ;;^UTILITY(U,$J,358.3,27034,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27034,1,3,0)
 ;;=3^Opioid Use Disorder,Moderate
 ;;^UTILITY(U,$J,358.3,27034,1,4,0)
 ;;=4^F11.20
 ;;^UTILITY(U,$J,358.3,27034,2)
 ;;=^5003127
 ;;^UTILITY(U,$J,358.3,27035,0)
 ;;=F11.23^^71^1139^27
 ;;^UTILITY(U,$J,358.3,27035,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27035,1,3,0)
 ;;=3^Opioid Withdrawal
 ;;^UTILITY(U,$J,358.3,27035,1,4,0)
 ;;=4^F11.23
 ;;^UTILITY(U,$J,358.3,27035,2)
 ;;=^5003133
 ;;^UTILITY(U,$J,358.3,27036,0)
 ;;=F11.24^^71^1139^6
 ;;^UTILITY(U,$J,358.3,27036,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27036,1,3,0)
 ;;=3^Opioid Induced Depressive Disorder w/ Moderate-Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,27036,1,4,0)
 ;;=4^F11.24
 ;;^UTILITY(U,$J,358.3,27036,2)
 ;;=^5003134
 ;;^UTILITY(U,$J,358.3,27037,0)
 ;;=F11.188^^71^1139^1
 ;;^UTILITY(U,$J,358.3,27037,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27037,1,3,0)
 ;;=3^Opioid Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,27037,1,4,0)
 ;;=4^F11.188
 ;;^UTILITY(U,$J,358.3,27037,2)
 ;;=^5003125
 ;;^UTILITY(U,$J,358.3,27038,0)
 ;;=F11.288^^71^1139^2
 ;;^UTILITY(U,$J,358.3,27038,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27038,1,3,0)
 ;;=3^Opioid Induced Anxiety Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,27038,1,4,0)
 ;;=4^F11.288
 ;;^UTILITY(U,$J,358.3,27038,2)
 ;;=^5003140
 ;;^UTILITY(U,$J,358.3,27039,0)
 ;;=F11.988^^71^1139^3
 ;;^UTILITY(U,$J,358.3,27039,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27039,1,3,0)
 ;;=3^Opioid Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,27039,1,4,0)
 ;;=4^F11.988
 ;;^UTILITY(U,$J,358.3,27039,2)
 ;;=^5003154
 ;;^UTILITY(U,$J,358.3,27040,0)
 ;;=F11.921^^71^1139^4
 ;;^UTILITY(U,$J,358.3,27040,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27040,1,3,0)
 ;;=3^Opioid Induced Delirium
 ;;^UTILITY(U,$J,358.3,27040,1,4,0)
 ;;=4^F11.921
 ;;^UTILITY(U,$J,358.3,27040,2)
 ;;=^5003144
 ;;^UTILITY(U,$J,358.3,27041,0)
 ;;=F11.94^^71^1139^7
 ;;^UTILITY(U,$J,358.3,27041,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27041,1,3,0)
 ;;=3^Opioid Induced Depressive Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,27041,1,4,0)
 ;;=4^F11.94
 ;;^UTILITY(U,$J,358.3,27041,2)
 ;;=^5003148
 ;;^UTILITY(U,$J,358.3,27042,0)
 ;;=F11.181^^71^1139^8
 ;;^UTILITY(U,$J,358.3,27042,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27042,1,3,0)
 ;;=3^Opioid Induced Sexual Dysfunction w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,27042,1,4,0)
 ;;=4^F11.181
 ;;^UTILITY(U,$J,358.3,27042,2)
 ;;=^5003123
 ;;^UTILITY(U,$J,358.3,27043,0)
 ;;=F11.281^^71^1139^9
 ;;^UTILITY(U,$J,358.3,27043,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27043,1,3,0)
 ;;=3^Opioid Induced Sexual Dysfunction w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,27043,1,4,0)
 ;;=4^F11.281
 ;;^UTILITY(U,$J,358.3,27043,2)
 ;;=^5003138
 ;;^UTILITY(U,$J,358.3,27044,0)
 ;;=F11.981^^71^1139^10
 ;;^UTILITY(U,$J,358.3,27044,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27044,1,3,0)
 ;;=3^Opioid Induced Sexual Dysfunction w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,27044,1,4,0)
 ;;=4^F11.981
 ;;^UTILITY(U,$J,358.3,27044,2)
 ;;=^5003152
 ;;^UTILITY(U,$J,358.3,27045,0)
 ;;=F11.282^^71^1139^12
 ;;^UTILITY(U,$J,358.3,27045,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27045,1,3,0)
 ;;=3^Opioid Induced Sleep Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,27045,1,4,0)
 ;;=4^F11.282
 ;;^UTILITY(U,$J,358.3,27045,2)
 ;;=^5003139
 ;;^UTILITY(U,$J,358.3,27046,0)
 ;;=F11.982^^71^1139^13
 ;;^UTILITY(U,$J,358.3,27046,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27046,1,3,0)
 ;;=3^Opioid Induced Sleep Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,27046,1,4,0)
 ;;=4^F11.982
 ;;^UTILITY(U,$J,358.3,27046,2)
 ;;=^5003153
 ;;^UTILITY(U,$J,358.3,27047,0)
 ;;=F11.121^^71^1139^14
 ;;^UTILITY(U,$J,358.3,27047,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27047,1,3,0)
 ;;=3^Opioid Intoxication Delirium w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,27047,1,4,0)
 ;;=4^F11.121
 ;;^UTILITY(U,$J,358.3,27047,2)
 ;;=^5003116
 ;;^UTILITY(U,$J,358.3,27048,0)
 ;;=F11.221^^71^1139^15
 ;;^UTILITY(U,$J,358.3,27048,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27048,1,3,0)
 ;;=3^Opioid Intoxication Delirium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,27048,1,4,0)
 ;;=4^F11.221
 ;;^UTILITY(U,$J,358.3,27048,2)
 ;;=^5003130
 ;;^UTILITY(U,$J,358.3,27049,0)
 ;;=F11.921^^71^1139^16
 ;;^UTILITY(U,$J,358.3,27049,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27049,1,3,0)
 ;;=3^Opioid Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,27049,1,4,0)
 ;;=4^F11.921
 ;;^UTILITY(U,$J,358.3,27049,2)
 ;;=^5003144
 ;;^UTILITY(U,$J,358.3,27050,0)
 ;;=F11.229^^71^1139^21
 ;;^UTILITY(U,$J,358.3,27050,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27050,1,3,0)
 ;;=3^Opioid Intoxication w/o Perceptual Disturbance w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,27050,1,4,0)
 ;;=4^F11.229
 ;;^UTILITY(U,$J,358.3,27050,2)
 ;;=^5003132
 ;;^UTILITY(U,$J,358.3,27051,0)
 ;;=F11.929^^71^1139^22
 ;;^UTILITY(U,$J,358.3,27051,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27051,1,3,0)
 ;;=3^Opioid Intoxication w/o Perceptual Disturbance w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,27051,1,4,0)
 ;;=4^F11.929
 ;;^UTILITY(U,$J,358.3,27051,2)
 ;;=^5003146
 ;;^UTILITY(U,$J,358.3,27052,0)
 ;;=F11.122^^71^1139^17
 ;;^UTILITY(U,$J,358.3,27052,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27052,1,3,0)
 ;;=3^Opioid Intoxication w/ Perceptual Disturbance w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,27052,1,4,0)
 ;;=4^F11.122
 ;;^UTILITY(U,$J,358.3,27052,2)
 ;;=^5003117
 ;;^UTILITY(U,$J,358.3,27053,0)
 ;;=F11.222^^71^1139^18
 ;;^UTILITY(U,$J,358.3,27053,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27053,1,3,0)
 ;;=3^Opioid Intoxication w/ Perceptual Disturbance w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,27053,1,4,0)
 ;;=4^F11.222
 ;;^UTILITY(U,$J,358.3,27053,2)
 ;;=^5003131
 ;;^UTILITY(U,$J,358.3,27054,0)
 ;;=F11.922^^71^1139^19
 ;;^UTILITY(U,$J,358.3,27054,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27054,1,3,0)
 ;;=3^Opioid Intoxication w/ Perceptual Disturbance w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,27054,1,4,0)
 ;;=4^F11.922
 ;;^UTILITY(U,$J,358.3,27054,2)
 ;;=^5003145
 ;;^UTILITY(U,$J,358.3,27055,0)
 ;;=F11.99^^71^1139^23
 ;;^UTILITY(U,$J,358.3,27055,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27055,1,3,0)
 ;;=3^Opioid Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,27055,1,4,0)
 ;;=4^F11.99
 ;;^UTILITY(U,$J,358.3,27055,2)
 ;;=^5133352
 ;;^UTILITY(U,$J,358.3,27056,0)
 ;;=F11.20^^71^1139^26
 ;;^UTILITY(U,$J,358.3,27056,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27056,1,3,0)
 ;;=3^Opioid Use Disorder,Severe
 ;;^UTILITY(U,$J,358.3,27056,1,4,0)
 ;;=4^F11.20
 ;;^UTILITY(U,$J,358.3,27056,2)
 ;;=^5003127
 ;;^UTILITY(U,$J,358.3,27057,0)
 ;;=F11.23^^71^1139^28
 ;;^UTILITY(U,$J,358.3,27057,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27057,1,3,0)
 ;;=3^Opioid Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,27057,1,4,0)
 ;;=4^F11.23
 ;;^UTILITY(U,$J,358.3,27057,2)
 ;;=^5003133
 ;;^UTILITY(U,$J,358.3,27058,0)
 ;;=F13.180^^71^1140^1
 ;;^UTILITY(U,$J,358.3,27058,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27058,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Anxiety D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,27058,1,4,0)
 ;;=4^F13.180
 ;;^UTILITY(U,$J,358.3,27058,2)
 ;;=^5003197
 ;;^UTILITY(U,$J,358.3,27059,0)
 ;;=F13.280^^71^1140^2
 ;;^UTILITY(U,$J,358.3,27059,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27059,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Anxiety D/O w/ Mod-Sev Use D/O

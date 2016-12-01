IBDEI0LE ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,27059,1,4,0)
 ;;=4^F13.280
 ;;^UTILITY(U,$J,358.3,27059,2)
 ;;=^5003216
 ;;^UTILITY(U,$J,358.3,27060,0)
 ;;=F13.980^^71^1140^3
 ;;^UTILITY(U,$J,358.3,27060,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27060,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Anxiety D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,27060,1,4,0)
 ;;=4^F13.980
 ;;^UTILITY(U,$J,358.3,27060,2)
 ;;=^5003235
 ;;^UTILITY(U,$J,358.3,27061,0)
 ;;=F13.14^^71^1140^4
 ;;^UTILITY(U,$J,358.3,27061,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27061,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Bipolar & Rel D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,27061,1,4,0)
 ;;=4^F13.14
 ;;^UTILITY(U,$J,358.3,27061,2)
 ;;=^5003193
 ;;^UTILITY(U,$J,358.3,27062,0)
 ;;=F13.24^^71^1140^5
 ;;^UTILITY(U,$J,358.3,27062,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27062,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Bipolar & Rel D/O w/ Mod-Sev Use D/O 
 ;;^UTILITY(U,$J,358.3,27062,1,4,0)
 ;;=4^F13.24
 ;;^UTILITY(U,$J,358.3,27062,2)
 ;;=^5003210
 ;;^UTILITY(U,$J,358.3,27063,0)
 ;;=F13.94^^71^1140^6
 ;;^UTILITY(U,$J,358.3,27063,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27063,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Bipolar & Rel D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,27063,1,4,0)
 ;;=4^F13.94
 ;;^UTILITY(U,$J,358.3,27063,2)
 ;;=^5003229
 ;;^UTILITY(U,$J,358.3,27064,0)
 ;;=F13.921^^71^1140^7
 ;;^UTILITY(U,$J,358.3,27064,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27064,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Delirium
 ;;^UTILITY(U,$J,358.3,27064,1,4,0)
 ;;=4^F13.921
 ;;^UTILITY(U,$J,358.3,27064,2)
 ;;=^5003223
 ;;^UTILITY(U,$J,358.3,27065,0)
 ;;=F13.14^^71^1140^8
 ;;^UTILITY(U,$J,358.3,27065,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27065,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Depressive D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,27065,1,4,0)
 ;;=4^F13.14
 ;;^UTILITY(U,$J,358.3,27065,2)
 ;;=^5003193
 ;;^UTILITY(U,$J,358.3,27066,0)
 ;;=F13.24^^71^1140^9
 ;;^UTILITY(U,$J,358.3,27066,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27066,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Depressive D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,27066,1,4,0)
 ;;=4^F13.24
 ;;^UTILITY(U,$J,358.3,27066,2)
 ;;=^5003210
 ;;^UTILITY(U,$J,358.3,27067,0)
 ;;=F13.94^^71^1140^10
 ;;^UTILITY(U,$J,358.3,27067,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27067,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Depressive D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,27067,1,4,0)
 ;;=4^F13.94
 ;;^UTILITY(U,$J,358.3,27067,2)
 ;;=^5003229
 ;;^UTILITY(U,$J,358.3,27068,0)
 ;;=F13.27^^71^1140^11
 ;;^UTILITY(U,$J,358.3,27068,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27068,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Maj Neurocog D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,27068,1,4,0)
 ;;=4^F13.27
 ;;^UTILITY(U,$J,358.3,27068,2)
 ;;=^5003215
 ;;^UTILITY(U,$J,358.3,27069,0)
 ;;=F13.97^^71^1140^12
 ;;^UTILITY(U,$J,358.3,27069,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27069,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Maj Neurocog D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,27069,1,4,0)
 ;;=4^F13.97
 ;;^UTILITY(U,$J,358.3,27069,2)
 ;;=^5003234
 ;;^UTILITY(U,$J,358.3,27070,0)
 ;;=F13.288^^71^1140^13
 ;;^UTILITY(U,$J,358.3,27070,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27070,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Mild Neurocog D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,27070,1,4,0)
 ;;=4^F13.288
 ;;^UTILITY(U,$J,358.3,27070,2)
 ;;=^5003219
 ;;^UTILITY(U,$J,358.3,27071,0)
 ;;=F13.988^^71^1140^14
 ;;^UTILITY(U,$J,358.3,27071,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27071,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Mild Neurocog D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,27071,1,4,0)
 ;;=4^F13.988
 ;;^UTILITY(U,$J,358.3,27071,2)
 ;;=^5003238
 ;;^UTILITY(U,$J,358.3,27072,0)
 ;;=F13.159^^71^1140^15
 ;;^UTILITY(U,$J,358.3,27072,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27072,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Psychotic D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,27072,1,4,0)
 ;;=4^F13.159
 ;;^UTILITY(U,$J,358.3,27072,2)
 ;;=^5003196
 ;;^UTILITY(U,$J,358.3,27073,0)
 ;;=F13.259^^71^1140^16
 ;;^UTILITY(U,$J,358.3,27073,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27073,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Psychotic D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,27073,1,4,0)
 ;;=4^F13.259
 ;;^UTILITY(U,$J,358.3,27073,2)
 ;;=^5003213
 ;;^UTILITY(U,$J,358.3,27074,0)
 ;;=F13.959^^71^1140^17
 ;;^UTILITY(U,$J,358.3,27074,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27074,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Psychotic D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,27074,1,4,0)
 ;;=4^F13.959
 ;;^UTILITY(U,$J,358.3,27074,2)
 ;;=^5003232
 ;;^UTILITY(U,$J,358.3,27075,0)
 ;;=F13.181^^71^1140^18
 ;;^UTILITY(U,$J,358.3,27075,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27075,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Sexual Dysfunction w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,27075,1,4,0)
 ;;=4^F13.181
 ;;^UTILITY(U,$J,358.3,27075,2)
 ;;=^5003198
 ;;^UTILITY(U,$J,358.3,27076,0)
 ;;=F13.281^^71^1140^19
 ;;^UTILITY(U,$J,358.3,27076,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27076,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Sexual Dysfunction w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,27076,1,4,0)
 ;;=4^F13.281
 ;;^UTILITY(U,$J,358.3,27076,2)
 ;;=^5003217
 ;;^UTILITY(U,$J,358.3,27077,0)
 ;;=F13.981^^71^1140^20
 ;;^UTILITY(U,$J,358.3,27077,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27077,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Sexual Dysfunction w/o Use D/O
 ;;^UTILITY(U,$J,358.3,27077,1,4,0)
 ;;=4^F13.981
 ;;^UTILITY(U,$J,358.3,27077,2)
 ;;=^5003236
 ;;^UTILITY(U,$J,358.3,27078,0)
 ;;=F13.182^^71^1140^21
 ;;^UTILITY(U,$J,358.3,27078,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27078,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Sleep D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,27078,1,4,0)
 ;;=4^F13.182
 ;;^UTILITY(U,$J,358.3,27078,2)
 ;;=^5003199
 ;;^UTILITY(U,$J,358.3,27079,0)
 ;;=F13.282^^71^1140^22
 ;;^UTILITY(U,$J,358.3,27079,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27079,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Sleep D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,27079,1,4,0)
 ;;=4^F13.282
 ;;^UTILITY(U,$J,358.3,27079,2)
 ;;=^5003218
 ;;^UTILITY(U,$J,358.3,27080,0)
 ;;=F13.982^^71^1140^23
 ;;^UTILITY(U,$J,358.3,27080,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27080,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Sleep D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,27080,1,4,0)
 ;;=4^F13.982
 ;;^UTILITY(U,$J,358.3,27080,2)
 ;;=^5003237
 ;;^UTILITY(U,$J,358.3,27081,0)
 ;;=F13.129^^71^1140^24
 ;;^UTILITY(U,$J,358.3,27081,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27081,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Intoxication w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,27081,1,4,0)
 ;;=4^F13.129
 ;;^UTILITY(U,$J,358.3,27081,2)
 ;;=^5003192
 ;;^UTILITY(U,$J,358.3,27082,0)
 ;;=F13.229^^71^1140^25
 ;;^UTILITY(U,$J,358.3,27082,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27082,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Intoxication w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,27082,1,4,0)
 ;;=4^F13.229
 ;;^UTILITY(U,$J,358.3,27082,2)
 ;;=^5003205
 ;;^UTILITY(U,$J,358.3,27083,0)
 ;;=F13.929^^71^1140^26
 ;;^UTILITY(U,$J,358.3,27083,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27083,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Intoxication w/o Use D/O
 ;;^UTILITY(U,$J,358.3,27083,1,4,0)
 ;;=4^F13.929
 ;;^UTILITY(U,$J,358.3,27083,2)
 ;;=^5003224
 ;;^UTILITY(U,$J,358.3,27084,0)
 ;;=F13.121^^71^1140^27
 ;;^UTILITY(U,$J,358.3,27084,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27084,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Intoxication Delirium w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,27084,1,4,0)
 ;;=4^F13.121
 ;;^UTILITY(U,$J,358.3,27084,2)
 ;;=^5003191
 ;;^UTILITY(U,$J,358.3,27085,0)
 ;;=F13.221^^71^1140^28
 ;;^UTILITY(U,$J,358.3,27085,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27085,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Intoxication Delirium w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,27085,1,4,0)
 ;;=4^F13.221
 ;;^UTILITY(U,$J,358.3,27085,2)
 ;;=^5003204
 ;;^UTILITY(U,$J,358.3,27086,0)
 ;;=F13.921^^71^1140^29
 ;;^UTILITY(U,$J,358.3,27086,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27086,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Intoxication Delirium w/o Use D/O
 ;;^UTILITY(U,$J,358.3,27086,1,4,0)
 ;;=4^F13.921
 ;;^UTILITY(U,$J,358.3,27086,2)
 ;;=^5003223
 ;;^UTILITY(U,$J,358.3,27087,0)
 ;;=F13.10^^71^1140^31
 ;;^UTILITY(U,$J,358.3,27087,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27087,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Use D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,27087,1,4,0)
 ;;=4^F13.10
 ;;^UTILITY(U,$J,358.3,27087,2)
 ;;=^5003189
 ;;^UTILITY(U,$J,358.3,27088,0)
 ;;=F13.20^^71^1140^32
 ;;^UTILITY(U,$J,358.3,27088,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27088,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Use D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,27088,1,4,0)
 ;;=4^F13.20
 ;;^UTILITY(U,$J,358.3,27088,2)
 ;;=^5003202
 ;;^UTILITY(U,$J,358.3,27089,0)
 ;;=F13.20^^71^1140^33
 ;;^UTILITY(U,$J,358.3,27089,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27089,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Use D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,27089,1,4,0)
 ;;=4^F13.20
 ;;^UTILITY(U,$J,358.3,27089,2)
 ;;=^5003202
 ;;^UTILITY(U,$J,358.3,27090,0)
 ;;=F13.232^^71^1140^34
 ;;^UTILITY(U,$J,358.3,27090,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27090,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Withdrawal w/ Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,27090,1,4,0)
 ;;=4^F13.232
 ;;^UTILITY(U,$J,358.3,27090,2)
 ;;=^5003208
 ;;^UTILITY(U,$J,358.3,27091,0)
 ;;=F13.239^^71^1140^35
 ;;^UTILITY(U,$J,358.3,27091,1,0)
 ;;=^358.31IA^4^2

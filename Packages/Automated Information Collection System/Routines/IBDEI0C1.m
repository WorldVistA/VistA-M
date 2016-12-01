IBDEI0C1 ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15260,2)
 ;;=^5133352
 ;;^UTILITY(U,$J,358.3,15261,0)
 ;;=F11.20^^45^680^26
 ;;^UTILITY(U,$J,358.3,15261,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15261,1,3,0)
 ;;=3^Opioid Use Disorder,Severe
 ;;^UTILITY(U,$J,358.3,15261,1,4,0)
 ;;=4^F11.20
 ;;^UTILITY(U,$J,358.3,15261,2)
 ;;=^5003127
 ;;^UTILITY(U,$J,358.3,15262,0)
 ;;=F11.23^^45^680^28
 ;;^UTILITY(U,$J,358.3,15262,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15262,1,3,0)
 ;;=3^Opioid Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,15262,1,4,0)
 ;;=4^F11.23
 ;;^UTILITY(U,$J,358.3,15262,2)
 ;;=^5003133
 ;;^UTILITY(U,$J,358.3,15263,0)
 ;;=F13.180^^45^681^1
 ;;^UTILITY(U,$J,358.3,15263,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15263,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Anxiety D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,15263,1,4,0)
 ;;=4^F13.180
 ;;^UTILITY(U,$J,358.3,15263,2)
 ;;=^5003197
 ;;^UTILITY(U,$J,358.3,15264,0)
 ;;=F13.280^^45^681^2
 ;;^UTILITY(U,$J,358.3,15264,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15264,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Anxiety D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,15264,1,4,0)
 ;;=4^F13.280
 ;;^UTILITY(U,$J,358.3,15264,2)
 ;;=^5003216
 ;;^UTILITY(U,$J,358.3,15265,0)
 ;;=F13.980^^45^681^3
 ;;^UTILITY(U,$J,358.3,15265,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15265,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Anxiety D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,15265,1,4,0)
 ;;=4^F13.980
 ;;^UTILITY(U,$J,358.3,15265,2)
 ;;=^5003235
 ;;^UTILITY(U,$J,358.3,15266,0)
 ;;=F13.14^^45^681^4
 ;;^UTILITY(U,$J,358.3,15266,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15266,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Bipolar & Rel D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,15266,1,4,0)
 ;;=4^F13.14
 ;;^UTILITY(U,$J,358.3,15266,2)
 ;;=^5003193
 ;;^UTILITY(U,$J,358.3,15267,0)
 ;;=F13.24^^45^681^5
 ;;^UTILITY(U,$J,358.3,15267,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15267,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Bipolar & Rel D/O w/ Mod-Sev Use D/O 
 ;;^UTILITY(U,$J,358.3,15267,1,4,0)
 ;;=4^F13.24
 ;;^UTILITY(U,$J,358.3,15267,2)
 ;;=^5003210
 ;;^UTILITY(U,$J,358.3,15268,0)
 ;;=F13.94^^45^681^6
 ;;^UTILITY(U,$J,358.3,15268,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15268,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Bipolar & Rel D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,15268,1,4,0)
 ;;=4^F13.94
 ;;^UTILITY(U,$J,358.3,15268,2)
 ;;=^5003229
 ;;^UTILITY(U,$J,358.3,15269,0)
 ;;=F13.921^^45^681^7
 ;;^UTILITY(U,$J,358.3,15269,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15269,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Delirium
 ;;^UTILITY(U,$J,358.3,15269,1,4,0)
 ;;=4^F13.921
 ;;^UTILITY(U,$J,358.3,15269,2)
 ;;=^5003223
 ;;^UTILITY(U,$J,358.3,15270,0)
 ;;=F13.14^^45^681^8
 ;;^UTILITY(U,$J,358.3,15270,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15270,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Depressive D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,15270,1,4,0)
 ;;=4^F13.14
 ;;^UTILITY(U,$J,358.3,15270,2)
 ;;=^5003193
 ;;^UTILITY(U,$J,358.3,15271,0)
 ;;=F13.24^^45^681^9
 ;;^UTILITY(U,$J,358.3,15271,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15271,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Depressive D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,15271,1,4,0)
 ;;=4^F13.24
 ;;^UTILITY(U,$J,358.3,15271,2)
 ;;=^5003210
 ;;^UTILITY(U,$J,358.3,15272,0)
 ;;=F13.94^^45^681^10
 ;;^UTILITY(U,$J,358.3,15272,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15272,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Depressive D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,15272,1,4,0)
 ;;=4^F13.94
 ;;^UTILITY(U,$J,358.3,15272,2)
 ;;=^5003229
 ;;^UTILITY(U,$J,358.3,15273,0)
 ;;=F13.27^^45^681^11
 ;;^UTILITY(U,$J,358.3,15273,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15273,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Maj Neurocog D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,15273,1,4,0)
 ;;=4^F13.27
 ;;^UTILITY(U,$J,358.3,15273,2)
 ;;=^5003215
 ;;^UTILITY(U,$J,358.3,15274,0)
 ;;=F13.97^^45^681^12
 ;;^UTILITY(U,$J,358.3,15274,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15274,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Maj Neurocog D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,15274,1,4,0)
 ;;=4^F13.97
 ;;^UTILITY(U,$J,358.3,15274,2)
 ;;=^5003234
 ;;^UTILITY(U,$J,358.3,15275,0)
 ;;=F13.288^^45^681^13
 ;;^UTILITY(U,$J,358.3,15275,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15275,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Mild Neurocog D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,15275,1,4,0)
 ;;=4^F13.288
 ;;^UTILITY(U,$J,358.3,15275,2)
 ;;=^5003219
 ;;^UTILITY(U,$J,358.3,15276,0)
 ;;=F13.988^^45^681^14
 ;;^UTILITY(U,$J,358.3,15276,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15276,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Mild Neurocog D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,15276,1,4,0)
 ;;=4^F13.988
 ;;^UTILITY(U,$J,358.3,15276,2)
 ;;=^5003238
 ;;^UTILITY(U,$J,358.3,15277,0)
 ;;=F13.159^^45^681^15
 ;;^UTILITY(U,$J,358.3,15277,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15277,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Psychotic D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,15277,1,4,0)
 ;;=4^F13.159
 ;;^UTILITY(U,$J,358.3,15277,2)
 ;;=^5003196
 ;;^UTILITY(U,$J,358.3,15278,0)
 ;;=F13.259^^45^681^16
 ;;^UTILITY(U,$J,358.3,15278,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15278,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Psychotic D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,15278,1,4,0)
 ;;=4^F13.259
 ;;^UTILITY(U,$J,358.3,15278,2)
 ;;=^5003213
 ;;^UTILITY(U,$J,358.3,15279,0)
 ;;=F13.959^^45^681^17
 ;;^UTILITY(U,$J,358.3,15279,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15279,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Psychotic D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,15279,1,4,0)
 ;;=4^F13.959
 ;;^UTILITY(U,$J,358.3,15279,2)
 ;;=^5003232
 ;;^UTILITY(U,$J,358.3,15280,0)
 ;;=F13.181^^45^681^18
 ;;^UTILITY(U,$J,358.3,15280,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15280,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Sexual Dysfunction w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,15280,1,4,0)
 ;;=4^F13.181
 ;;^UTILITY(U,$J,358.3,15280,2)
 ;;=^5003198
 ;;^UTILITY(U,$J,358.3,15281,0)
 ;;=F13.281^^45^681^19
 ;;^UTILITY(U,$J,358.3,15281,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15281,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Sexual Dysfunction w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,15281,1,4,0)
 ;;=4^F13.281
 ;;^UTILITY(U,$J,358.3,15281,2)
 ;;=^5003217
 ;;^UTILITY(U,$J,358.3,15282,0)
 ;;=F13.981^^45^681^20
 ;;^UTILITY(U,$J,358.3,15282,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15282,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Sexual Dysfunction w/o Use D/O
 ;;^UTILITY(U,$J,358.3,15282,1,4,0)
 ;;=4^F13.981
 ;;^UTILITY(U,$J,358.3,15282,2)
 ;;=^5003236
 ;;^UTILITY(U,$J,358.3,15283,0)
 ;;=F13.182^^45^681^21
 ;;^UTILITY(U,$J,358.3,15283,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15283,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Sleep D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,15283,1,4,0)
 ;;=4^F13.182
 ;;^UTILITY(U,$J,358.3,15283,2)
 ;;=^5003199
 ;;^UTILITY(U,$J,358.3,15284,0)
 ;;=F13.282^^45^681^22
 ;;^UTILITY(U,$J,358.3,15284,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15284,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Sleep D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,15284,1,4,0)
 ;;=4^F13.282
 ;;^UTILITY(U,$J,358.3,15284,2)
 ;;=^5003218
 ;;^UTILITY(U,$J,358.3,15285,0)
 ;;=F13.982^^45^681^23
 ;;^UTILITY(U,$J,358.3,15285,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15285,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Sleep D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,15285,1,4,0)
 ;;=4^F13.982
 ;;^UTILITY(U,$J,358.3,15285,2)
 ;;=^5003237
 ;;^UTILITY(U,$J,358.3,15286,0)
 ;;=F13.129^^45^681^24
 ;;^UTILITY(U,$J,358.3,15286,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15286,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Intoxication w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,15286,1,4,0)
 ;;=4^F13.129
 ;;^UTILITY(U,$J,358.3,15286,2)
 ;;=^5003192
 ;;^UTILITY(U,$J,358.3,15287,0)
 ;;=F13.229^^45^681^25
 ;;^UTILITY(U,$J,358.3,15287,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15287,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Intoxication w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,15287,1,4,0)
 ;;=4^F13.229
 ;;^UTILITY(U,$J,358.3,15287,2)
 ;;=^5003205
 ;;^UTILITY(U,$J,358.3,15288,0)
 ;;=F13.929^^45^681^26
 ;;^UTILITY(U,$J,358.3,15288,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15288,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Intoxication w/o Use D/O
 ;;^UTILITY(U,$J,358.3,15288,1,4,0)
 ;;=4^F13.929
 ;;^UTILITY(U,$J,358.3,15288,2)
 ;;=^5003224
 ;;^UTILITY(U,$J,358.3,15289,0)
 ;;=F13.121^^45^681^27
 ;;^UTILITY(U,$J,358.3,15289,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15289,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Intoxication Delirium w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,15289,1,4,0)
 ;;=4^F13.121
 ;;^UTILITY(U,$J,358.3,15289,2)
 ;;=^5003191
 ;;^UTILITY(U,$J,358.3,15290,0)
 ;;=F13.221^^45^681^28
 ;;^UTILITY(U,$J,358.3,15290,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15290,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Intoxication Delirium w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,15290,1,4,0)
 ;;=4^F13.221
 ;;^UTILITY(U,$J,358.3,15290,2)
 ;;=^5003204
 ;;^UTILITY(U,$J,358.3,15291,0)
 ;;=F13.921^^45^681^29
 ;;^UTILITY(U,$J,358.3,15291,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15291,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Intoxication Delirium w/o Use D/O
 ;;^UTILITY(U,$J,358.3,15291,1,4,0)
 ;;=4^F13.921
 ;;^UTILITY(U,$J,358.3,15291,2)
 ;;=^5003223
 ;;^UTILITY(U,$J,358.3,15292,0)
 ;;=F13.10^^45^681^31
 ;;^UTILITY(U,$J,358.3,15292,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15292,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Use D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,15292,1,4,0)
 ;;=4^F13.10

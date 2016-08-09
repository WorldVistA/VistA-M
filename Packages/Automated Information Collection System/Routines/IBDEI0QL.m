IBDEI0QL ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,26730,0)
 ;;=F11.20^^100^1289^26
 ;;^UTILITY(U,$J,358.3,26730,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26730,1,3,0)
 ;;=3^Opioid Use Disorder,Severe
 ;;^UTILITY(U,$J,358.3,26730,1,4,0)
 ;;=4^F11.20
 ;;^UTILITY(U,$J,358.3,26730,2)
 ;;=^5003127
 ;;^UTILITY(U,$J,358.3,26731,0)
 ;;=F11.23^^100^1289^28
 ;;^UTILITY(U,$J,358.3,26731,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26731,1,3,0)
 ;;=3^Opioid Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,26731,1,4,0)
 ;;=4^F11.23
 ;;^UTILITY(U,$J,358.3,26731,2)
 ;;=^5003133
 ;;^UTILITY(U,$J,358.3,26732,0)
 ;;=F13.180^^100^1290^1
 ;;^UTILITY(U,$J,358.3,26732,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26732,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Anxiety D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,26732,1,4,0)
 ;;=4^F13.180
 ;;^UTILITY(U,$J,358.3,26732,2)
 ;;=^5003197
 ;;^UTILITY(U,$J,358.3,26733,0)
 ;;=F13.280^^100^1290^2
 ;;^UTILITY(U,$J,358.3,26733,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26733,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Anxiety D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,26733,1,4,0)
 ;;=4^F13.280
 ;;^UTILITY(U,$J,358.3,26733,2)
 ;;=^5003216
 ;;^UTILITY(U,$J,358.3,26734,0)
 ;;=F13.980^^100^1290^3
 ;;^UTILITY(U,$J,358.3,26734,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26734,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Anxiety D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,26734,1,4,0)
 ;;=4^F13.980
 ;;^UTILITY(U,$J,358.3,26734,2)
 ;;=^5003235
 ;;^UTILITY(U,$J,358.3,26735,0)
 ;;=F13.14^^100^1290^4
 ;;^UTILITY(U,$J,358.3,26735,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26735,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Bipolar & Rel D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,26735,1,4,0)
 ;;=4^F13.14
 ;;^UTILITY(U,$J,358.3,26735,2)
 ;;=^5003193
 ;;^UTILITY(U,$J,358.3,26736,0)
 ;;=F13.24^^100^1290^5
 ;;^UTILITY(U,$J,358.3,26736,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26736,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Bipolar & Rel D/O w/ Mod-Sev Use D/O 
 ;;^UTILITY(U,$J,358.3,26736,1,4,0)
 ;;=4^F13.24
 ;;^UTILITY(U,$J,358.3,26736,2)
 ;;=^5003210
 ;;^UTILITY(U,$J,358.3,26737,0)
 ;;=F13.94^^100^1290^6
 ;;^UTILITY(U,$J,358.3,26737,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26737,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Bipolar & Rel D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,26737,1,4,0)
 ;;=4^F13.94
 ;;^UTILITY(U,$J,358.3,26737,2)
 ;;=^5003229
 ;;^UTILITY(U,$J,358.3,26738,0)
 ;;=F13.921^^100^1290^7
 ;;^UTILITY(U,$J,358.3,26738,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26738,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Delirium
 ;;^UTILITY(U,$J,358.3,26738,1,4,0)
 ;;=4^F13.921
 ;;^UTILITY(U,$J,358.3,26738,2)
 ;;=^5003223
 ;;^UTILITY(U,$J,358.3,26739,0)
 ;;=F13.14^^100^1290^8
 ;;^UTILITY(U,$J,358.3,26739,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26739,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Depressive D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,26739,1,4,0)
 ;;=4^F13.14
 ;;^UTILITY(U,$J,358.3,26739,2)
 ;;=^5003193
 ;;^UTILITY(U,$J,358.3,26740,0)
 ;;=F13.24^^100^1290^9
 ;;^UTILITY(U,$J,358.3,26740,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26740,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Depressive D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,26740,1,4,0)
 ;;=4^F13.24
 ;;^UTILITY(U,$J,358.3,26740,2)
 ;;=^5003210
 ;;^UTILITY(U,$J,358.3,26741,0)
 ;;=F13.94^^100^1290^10
 ;;^UTILITY(U,$J,358.3,26741,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26741,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Depressive D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,26741,1,4,0)
 ;;=4^F13.94
 ;;^UTILITY(U,$J,358.3,26741,2)
 ;;=^5003229
 ;;^UTILITY(U,$J,358.3,26742,0)
 ;;=F13.27^^100^1290^11
 ;;^UTILITY(U,$J,358.3,26742,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26742,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Maj Neurocog D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,26742,1,4,0)
 ;;=4^F13.27
 ;;^UTILITY(U,$J,358.3,26742,2)
 ;;=^5003215
 ;;^UTILITY(U,$J,358.3,26743,0)
 ;;=F13.97^^100^1290^12
 ;;^UTILITY(U,$J,358.3,26743,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26743,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Maj Neurocog D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,26743,1,4,0)
 ;;=4^F13.97
 ;;^UTILITY(U,$J,358.3,26743,2)
 ;;=^5003234
 ;;^UTILITY(U,$J,358.3,26744,0)
 ;;=F13.288^^100^1290^13
 ;;^UTILITY(U,$J,358.3,26744,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26744,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Mild Neurocog D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,26744,1,4,0)
 ;;=4^F13.288
 ;;^UTILITY(U,$J,358.3,26744,2)
 ;;=^5003219
 ;;^UTILITY(U,$J,358.3,26745,0)
 ;;=F13.988^^100^1290^14
 ;;^UTILITY(U,$J,358.3,26745,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26745,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Mild Neurocog D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,26745,1,4,0)
 ;;=4^F13.988
 ;;^UTILITY(U,$J,358.3,26745,2)
 ;;=^5003238
 ;;^UTILITY(U,$J,358.3,26746,0)
 ;;=F13.159^^100^1290^15
 ;;^UTILITY(U,$J,358.3,26746,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26746,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Psychotic D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,26746,1,4,0)
 ;;=4^F13.159
 ;;^UTILITY(U,$J,358.3,26746,2)
 ;;=^5003196
 ;;^UTILITY(U,$J,358.3,26747,0)
 ;;=F13.259^^100^1290^16
 ;;^UTILITY(U,$J,358.3,26747,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26747,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Psychotic D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,26747,1,4,0)
 ;;=4^F13.259
 ;;^UTILITY(U,$J,358.3,26747,2)
 ;;=^5003213
 ;;^UTILITY(U,$J,358.3,26748,0)
 ;;=F13.959^^100^1290^17
 ;;^UTILITY(U,$J,358.3,26748,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26748,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Psychotic D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,26748,1,4,0)
 ;;=4^F13.959
 ;;^UTILITY(U,$J,358.3,26748,2)
 ;;=^5003232
 ;;^UTILITY(U,$J,358.3,26749,0)
 ;;=F13.181^^100^1290^18
 ;;^UTILITY(U,$J,358.3,26749,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26749,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Sexual Dysfunction w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,26749,1,4,0)
 ;;=4^F13.181
 ;;^UTILITY(U,$J,358.3,26749,2)
 ;;=^5003198
 ;;^UTILITY(U,$J,358.3,26750,0)
 ;;=F13.281^^100^1290^19
 ;;^UTILITY(U,$J,358.3,26750,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26750,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Sexual Dysfunction w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,26750,1,4,0)
 ;;=4^F13.281
 ;;^UTILITY(U,$J,358.3,26750,2)
 ;;=^5003217
 ;;^UTILITY(U,$J,358.3,26751,0)
 ;;=F13.981^^100^1290^20
 ;;^UTILITY(U,$J,358.3,26751,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26751,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Sexual Dysfunction w/o Use D/O
 ;;^UTILITY(U,$J,358.3,26751,1,4,0)
 ;;=4^F13.981
 ;;^UTILITY(U,$J,358.3,26751,2)
 ;;=^5003236
 ;;^UTILITY(U,$J,358.3,26752,0)
 ;;=F13.182^^100^1290^21
 ;;^UTILITY(U,$J,358.3,26752,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26752,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Sleep D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,26752,1,4,0)
 ;;=4^F13.182
 ;;^UTILITY(U,$J,358.3,26752,2)
 ;;=^5003199
 ;;^UTILITY(U,$J,358.3,26753,0)
 ;;=F13.282^^100^1290^22
 ;;^UTILITY(U,$J,358.3,26753,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26753,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Sleep D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,26753,1,4,0)
 ;;=4^F13.282
 ;;^UTILITY(U,$J,358.3,26753,2)
 ;;=^5003218
 ;;^UTILITY(U,$J,358.3,26754,0)
 ;;=F13.982^^100^1290^23
 ;;^UTILITY(U,$J,358.3,26754,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26754,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Sleep D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,26754,1,4,0)
 ;;=4^F13.982
 ;;^UTILITY(U,$J,358.3,26754,2)
 ;;=^5003237

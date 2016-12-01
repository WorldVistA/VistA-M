IBDEI013 ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,844,2)
 ;;=^5003314
 ;;^UTILITY(U,$J,358.3,845,0)
 ;;=F15.121^^3^64^26
 ;;^UTILITY(U,$J,358.3,845,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,845,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Intox Delirium  w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,845,1,4,0)
 ;;=4^F15.121
 ;;^UTILITY(U,$J,358.3,845,2)
 ;;=^5003284
 ;;^UTILITY(U,$J,358.3,846,0)
 ;;=F15.221^^3^64^27
 ;;^UTILITY(U,$J,358.3,846,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,846,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Intox Delirium  w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,846,1,4,0)
 ;;=4^F15.221
 ;;^UTILITY(U,$J,358.3,846,2)
 ;;=^5003298
 ;;^UTILITY(U,$J,358.3,847,0)
 ;;=F15.921^^3^64^28
 ;;^UTILITY(U,$J,358.3,847,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,847,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Intox Delirium w/o Use D/O
 ;;^UTILITY(U,$J,358.3,847,1,4,0)
 ;;=4^F15.921
 ;;^UTILITY(U,$J,358.3,847,2)
 ;;=^5003312
 ;;^UTILITY(U,$J,358.3,848,0)
 ;;=F15.23^^3^64^36
 ;;^UTILITY(U,$J,358.3,848,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,848,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Withdrawal
 ;;^UTILITY(U,$J,358.3,848,1,4,0)
 ;;=4^F15.23
 ;;^UTILITY(U,$J,358.3,848,2)
 ;;=^5003301
 ;;^UTILITY(U,$J,358.3,849,0)
 ;;=F15.10^^3^64^1
 ;;^UTILITY(U,$J,358.3,849,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,849,1,3,0)
 ;;=3^Amphetamine Type Substance Use D/O, Mild
 ;;^UTILITY(U,$J,358.3,849,1,4,0)
 ;;=4^F15.10
 ;;^UTILITY(U,$J,358.3,849,2)
 ;;=^5003282
 ;;^UTILITY(U,$J,358.3,850,0)
 ;;=F15.20^^3^64^2
 ;;^UTILITY(U,$J,358.3,850,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,850,1,3,0)
 ;;=3^Amphetamine Type Substance Use D/O, Moderate
 ;;^UTILITY(U,$J,358.3,850,1,4,0)
 ;;=4^F15.20
 ;;^UTILITY(U,$J,358.3,850,2)
 ;;=^5003295
 ;;^UTILITY(U,$J,358.3,851,0)
 ;;=F15.20^^3^64^3
 ;;^UTILITY(U,$J,358.3,851,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,851,1,3,0)
 ;;=3^Amphetamine Type Substance Use D/O, Severe
 ;;^UTILITY(U,$J,358.3,851,1,4,0)
 ;;=4^F15.20
 ;;^UTILITY(U,$J,358.3,851,2)
 ;;=^5003295
 ;;^UTILITY(U,$J,358.3,852,0)
 ;;=F14.180^^3^64^37
 ;;^UTILITY(U,$J,358.3,852,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,852,1,3,0)
 ;;=3^Cocaine Induced Anxiety D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,852,1,4,0)
 ;;=4^F14.180
 ;;^UTILITY(U,$J,358.3,852,2)
 ;;=^5003248
 ;;^UTILITY(U,$J,358.3,853,0)
 ;;=F14.280^^3^64^38
 ;;^UTILITY(U,$J,358.3,853,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,853,1,3,0)
 ;;=3^Cocaine Induced Anxiety D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,853,1,4,0)
 ;;=4^F14.280
 ;;^UTILITY(U,$J,358.3,853,2)
 ;;=^5003264
 ;;^UTILITY(U,$J,358.3,854,0)
 ;;=F14.980^^3^64^39
 ;;^UTILITY(U,$J,358.3,854,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,854,1,3,0)
 ;;=3^Cocaine Induced Anxiety D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,854,1,4,0)
 ;;=4^F14.980
 ;;^UTILITY(U,$J,358.3,854,2)
 ;;=^5003278
 ;;^UTILITY(U,$J,358.3,855,0)
 ;;=F14.14^^3^64^40
 ;;^UTILITY(U,$J,358.3,855,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,855,1,3,0)
 ;;=3^Cocaine Induced Bipolar & Rel D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,855,1,4,0)
 ;;=4^F14.14
 ;;^UTILITY(U,$J,358.3,855,2)
 ;;=^5003244
 ;;^UTILITY(U,$J,358.3,856,0)
 ;;=F14.24^^3^64^41
 ;;^UTILITY(U,$J,358.3,856,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,856,1,3,0)
 ;;=3^Cocaine Induced Bipolar & Rel D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,856,1,4,0)
 ;;=4^F14.24
 ;;^UTILITY(U,$J,358.3,856,2)
 ;;=^5003260
 ;;^UTILITY(U,$J,358.3,857,0)
 ;;=F14.94^^3^64^42
 ;;^UTILITY(U,$J,358.3,857,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,857,1,3,0)
 ;;=3^Cocaine Induced Bipolar & Rel D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,857,1,4,0)
 ;;=4^F14.94
 ;;^UTILITY(U,$J,358.3,857,2)
 ;;=^5003274
 ;;^UTILITY(U,$J,358.3,858,0)
 ;;=F14.14^^3^64^43
 ;;^UTILITY(U,$J,358.3,858,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,858,1,3,0)
 ;;=3^Cocaine Induced Depressive D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,858,1,4,0)
 ;;=4^F14.14
 ;;^UTILITY(U,$J,358.3,858,2)
 ;;=^5003244
 ;;^UTILITY(U,$J,358.3,859,0)
 ;;=F14.24^^3^64^44
 ;;^UTILITY(U,$J,358.3,859,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,859,1,3,0)
 ;;=3^Cocaine Induced Depressive D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,859,1,4,0)
 ;;=4^F14.24
 ;;^UTILITY(U,$J,358.3,859,2)
 ;;=^5003260
 ;;^UTILITY(U,$J,358.3,860,0)
 ;;=F14.94^^3^64^45
 ;;^UTILITY(U,$J,358.3,860,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,860,1,3,0)
 ;;=3^Cocaine Induced Depressive D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,860,1,4,0)
 ;;=4^F14.94
 ;;^UTILITY(U,$J,358.3,860,2)
 ;;=^5003274
 ;;^UTILITY(U,$J,358.3,861,0)
 ;;=F14.188^^3^64^46
 ;;^UTILITY(U,$J,358.3,861,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,861,1,3,0)
 ;;=3^Cocaine Induced Obess-Compul & Rel D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,861,1,4,0)
 ;;=4^F14.188
 ;;^UTILITY(U,$J,358.3,861,2)
 ;;=^5003251
 ;;^UTILITY(U,$J,358.3,862,0)
 ;;=F14.288^^3^64^47
 ;;^UTILITY(U,$J,358.3,862,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,862,1,3,0)
 ;;=3^Cocaine Induced Obess-Compul & Rel D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,862,1,4,0)
 ;;=4^F14.288
 ;;^UTILITY(U,$J,358.3,862,2)
 ;;=^5003267
 ;;^UTILITY(U,$J,358.3,863,0)
 ;;=F14.988^^3^64^48
 ;;^UTILITY(U,$J,358.3,863,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,863,1,3,0)
 ;;=3^Cocaine Induced Obess-Compul & Rel D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,863,1,4,0)
 ;;=4^F14.988
 ;;^UTILITY(U,$J,358.3,863,2)
 ;;=^5003281
 ;;^UTILITY(U,$J,358.3,864,0)
 ;;=F14.159^^3^64^49
 ;;^UTILITY(U,$J,358.3,864,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,864,1,3,0)
 ;;=3^Cocaine Induced Psychotic D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,864,1,4,0)
 ;;=4^F14.159
 ;;^UTILITY(U,$J,358.3,864,2)
 ;;=^5003247
 ;;^UTILITY(U,$J,358.3,865,0)
 ;;=F14.259^^3^64^50
 ;;^UTILITY(U,$J,358.3,865,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,865,1,3,0)
 ;;=3^Cocaine Induced Psychotic D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,865,1,4,0)
 ;;=4^F14.259
 ;;^UTILITY(U,$J,358.3,865,2)
 ;;=^5003263
 ;;^UTILITY(U,$J,358.3,866,0)
 ;;=F14.959^^3^64^51
 ;;^UTILITY(U,$J,358.3,866,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,866,1,3,0)
 ;;=3^Cocaine Induced Psychotic D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,866,1,4,0)
 ;;=4^F14.959
 ;;^UTILITY(U,$J,358.3,866,2)
 ;;=^5003277
 ;;^UTILITY(U,$J,358.3,867,0)
 ;;=F14.181^^3^64^52
 ;;^UTILITY(U,$J,358.3,867,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,867,1,3,0)
 ;;=3^Cocaine Induced Sexual Dysfunction w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,867,1,4,0)
 ;;=4^F14.181
 ;;^UTILITY(U,$J,358.3,867,2)
 ;;=^5003249
 ;;^UTILITY(U,$J,358.3,868,0)
 ;;=F14.281^^3^64^53
 ;;^UTILITY(U,$J,358.3,868,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,868,1,3,0)
 ;;=3^Cocaine Induced Sexual Dysfunction w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,868,1,4,0)
 ;;=4^F14.281
 ;;^UTILITY(U,$J,358.3,868,2)
 ;;=^5003265
 ;;^UTILITY(U,$J,358.3,869,0)
 ;;=F14.981^^3^64^54
 ;;^UTILITY(U,$J,358.3,869,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,869,1,3,0)
 ;;=3^Cocaine Induced Sexual Dysfunction w/o Use D/O
 ;;^UTILITY(U,$J,358.3,869,1,4,0)
 ;;=4^F14.981
 ;;^UTILITY(U,$J,358.3,869,2)
 ;;=^5003279
 ;;^UTILITY(U,$J,358.3,870,0)
 ;;=F14.182^^3^64^55
 ;;^UTILITY(U,$J,358.3,870,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,870,1,3,0)
 ;;=3^Cocaine Induced Sleep D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,870,1,4,0)
 ;;=4^F14.182
 ;;^UTILITY(U,$J,358.3,870,2)
 ;;=^5003250
 ;;^UTILITY(U,$J,358.3,871,0)
 ;;=F14.282^^3^64^56
 ;;^UTILITY(U,$J,358.3,871,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,871,1,3,0)
 ;;=3^Cocaine Induced Sleep D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,871,1,4,0)
 ;;=4^F14.282
 ;;^UTILITY(U,$J,358.3,871,2)
 ;;=^5003266
 ;;^UTILITY(U,$J,358.3,872,0)
 ;;=F14.982^^3^64^57
 ;;^UTILITY(U,$J,358.3,872,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,872,1,3,0)
 ;;=3^Cocaine Induced Sleep D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,872,1,4,0)
 ;;=4^F14.982
 ;;^UTILITY(U,$J,358.3,872,2)
 ;;=^5003280
 ;;^UTILITY(U,$J,358.3,873,0)
 ;;=F14.122^^3^64^61
 ;;^UTILITY(U,$J,358.3,873,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,873,1,3,0)
 ;;=3^Cocaine Intoxication w/ Percept Disturb w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,873,1,4,0)
 ;;=4^F14.122
 ;;^UTILITY(U,$J,358.3,873,2)
 ;;=^5003242
 ;;^UTILITY(U,$J,358.3,874,0)
 ;;=F14.222^^3^64^62
 ;;^UTILITY(U,$J,358.3,874,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,874,1,3,0)
 ;;=3^Cocaine Intoxication w/ Percept Disturb w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,874,1,4,0)
 ;;=4^F14.222
 ;;^UTILITY(U,$J,358.3,874,2)
 ;;=^5003257
 ;;^UTILITY(U,$J,358.3,875,0)
 ;;=F14.922^^3^64^63
 ;;^UTILITY(U,$J,358.3,875,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,875,1,3,0)
 ;;=3^Cocaine Intoxication w/ Percept Disturb w/o Use D/O
 ;;^UTILITY(U,$J,358.3,875,1,4,0)
 ;;=4^F14.922
 ;;^UTILITY(U,$J,358.3,875,2)
 ;;=^5003272
 ;;^UTILITY(U,$J,358.3,876,0)
 ;;=F14.129^^3^64^64
 ;;^UTILITY(U,$J,358.3,876,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,876,1,3,0)
 ;;=3^Cocaine Intoxication w/o  Percept Disturb w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,876,1,4,0)
 ;;=4^F14.129
 ;;^UTILITY(U,$J,358.3,876,2)
 ;;=^5003243
 ;;^UTILITY(U,$J,358.3,877,0)
 ;;=F14.229^^3^64^65
 ;;^UTILITY(U,$J,358.3,877,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,877,1,3,0)
 ;;=3^Cocaine Intoxication w/o  Percept Disturb w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,877,1,4,0)
 ;;=4^F14.229
 ;;^UTILITY(U,$J,358.3,877,2)
 ;;=^5003258
 ;;^UTILITY(U,$J,358.3,878,0)
 ;;=F14.929^^3^64^66
 ;;^UTILITY(U,$J,358.3,878,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,878,1,3,0)
 ;;=3^Cocaine Intoxication w/o Percept Disturb w/o Use D/O
 ;;^UTILITY(U,$J,358.3,878,1,4,0)
 ;;=4^F14.929
 ;;^UTILITY(U,$J,358.3,878,2)
 ;;=^5003273
 ;;^UTILITY(U,$J,358.3,879,0)
 ;;=F14.121^^3^64^58
 ;;^UTILITY(U,$J,358.3,879,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,879,1,3,0)
 ;;=3^Cocaine Intoxication Delirium  w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,879,1,4,0)
 ;;=4^F14.121

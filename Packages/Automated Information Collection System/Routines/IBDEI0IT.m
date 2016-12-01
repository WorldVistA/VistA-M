IBDEI0IT ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23852,1,4,0)
 ;;=4^F15.980
 ;;^UTILITY(U,$J,358.3,23852,2)
 ;;=^5003320
 ;;^UTILITY(U,$J,358.3,23853,0)
 ;;=F15.182^^61^933^4
 ;;^UTILITY(U,$J,358.3,23853,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23853,1,3,0)
 ;;=3^Caffeine Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,23853,1,4,0)
 ;;=4^F15.182
 ;;^UTILITY(U,$J,358.3,23853,2)
 ;;=^5003293
 ;;^UTILITY(U,$J,358.3,23854,0)
 ;;=F15.282^^61^933^5
 ;;^UTILITY(U,$J,358.3,23854,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23854,1,3,0)
 ;;=3^Caffeine Induced Sleep Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,23854,1,4,0)
 ;;=4^F15.282
 ;;^UTILITY(U,$J,358.3,23854,2)
 ;;=^5003308
 ;;^UTILITY(U,$J,358.3,23855,0)
 ;;=F15.982^^61^933^6
 ;;^UTILITY(U,$J,358.3,23855,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23855,1,3,0)
 ;;=3^Caffeine Induced Sleep Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,23855,1,4,0)
 ;;=4^F15.982
 ;;^UTILITY(U,$J,358.3,23855,2)
 ;;=^5003322
 ;;^UTILITY(U,$J,358.3,23856,0)
 ;;=F15.99^^61^933^9
 ;;^UTILITY(U,$J,358.3,23856,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23856,1,3,0)
 ;;=3^Caffeinie Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,23856,1,4,0)
 ;;=4^F15.99
 ;;^UTILITY(U,$J,358.3,23856,2)
 ;;=^5133358
 ;;^UTILITY(U,$J,358.3,23857,0)
 ;;=R45.851^^61^934^1
 ;;^UTILITY(U,$J,358.3,23857,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23857,1,3,0)
 ;;=3^Suicidal Ideations
 ;;^UTILITY(U,$J,358.3,23857,1,4,0)
 ;;=4^R45.851
 ;;^UTILITY(U,$J,358.3,23857,2)
 ;;=^5019474
 ;;^UTILITY(U,$J,358.3,23858,0)
 ;;=F19.14^^61^935^1
 ;;^UTILITY(U,$J,358.3,23858,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23858,1,3,0)
 ;;=3^Other/Unknown Substance Induced Depressive D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,23858,1,4,0)
 ;;=4^F19.14
 ;;^UTILITY(U,$J,358.3,23858,2)
 ;;=^5003421
 ;;^UTILITY(U,$J,358.3,23859,0)
 ;;=F19.24^^61^935^2
 ;;^UTILITY(U,$J,358.3,23859,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23859,1,3,0)
 ;;=3^Other/Unknown Substance Induced Depressive D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,23859,1,4,0)
 ;;=4^F19.24
 ;;^UTILITY(U,$J,358.3,23859,2)
 ;;=^5003441
 ;;^UTILITY(U,$J,358.3,23860,0)
 ;;=F19.94^^61^935^3
 ;;^UTILITY(U,$J,358.3,23860,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23860,1,3,0)
 ;;=3^Other/Unknown Substance Induced Depressive D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,23860,1,4,0)
 ;;=4^F19.94
 ;;^UTILITY(U,$J,358.3,23860,2)
 ;;=^5003460
 ;;^UTILITY(U,$J,358.3,23861,0)
 ;;=F19.17^^61^935^4
 ;;^UTILITY(U,$J,358.3,23861,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23861,1,3,0)
 ;;=3^Other/Unknown Substance Induced Maj Neurocog D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,23861,1,4,0)
 ;;=4^F19.17
 ;;^UTILITY(U,$J,358.3,23861,2)
 ;;=^5003426
 ;;^UTILITY(U,$J,358.3,23862,0)
 ;;=F19.27^^61^935^5
 ;;^UTILITY(U,$J,358.3,23862,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23862,1,3,0)
 ;;=3^Other/Unknown Substance Induced Maj Neurocog D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,23862,1,4,0)
 ;;=4^F19.27
 ;;^UTILITY(U,$J,358.3,23862,2)
 ;;=^5003446
 ;;^UTILITY(U,$J,358.3,23863,0)
 ;;=F19.97^^61^935^6
 ;;^UTILITY(U,$J,358.3,23863,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23863,1,3,0)
 ;;=3^Other/Unknown Substance Induced Maj Neurocog D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,23863,1,4,0)
 ;;=4^F19.97
 ;;^UTILITY(U,$J,358.3,23863,2)
 ;;=^5003465
 ;;^UTILITY(U,$J,358.3,23864,0)
 ;;=F19.188^^61^935^7
 ;;^UTILITY(U,$J,358.3,23864,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23864,1,3,0)
 ;;=3^Other/Unknown Substance Induced Mild Neurocog D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,23864,1,4,0)
 ;;=4^F19.188
 ;;^UTILITY(U,$J,358.3,23864,2)
 ;;=^5133361
 ;;^UTILITY(U,$J,358.3,23865,0)
 ;;=F19.288^^61^935^8
 ;;^UTILITY(U,$J,358.3,23865,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23865,1,3,0)
 ;;=3^Other/Unknown Substance Induced Mild Neurocog D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,23865,1,4,0)
 ;;=4^F19.288
 ;;^UTILITY(U,$J,358.3,23865,2)
 ;;=^5133362
 ;;^UTILITY(U,$J,358.3,23866,0)
 ;;=F19.988^^61^935^9
 ;;^UTILITY(U,$J,358.3,23866,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23866,1,3,0)
 ;;=3^Other/Unknown Substance Induced Mild Neurocog D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,23866,1,4,0)
 ;;=4^F19.988
 ;;^UTILITY(U,$J,358.3,23866,2)
 ;;=^5133363
 ;;^UTILITY(U,$J,358.3,23867,0)
 ;;=F19.188^^61^935^10
 ;;^UTILITY(U,$J,358.3,23867,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23867,1,3,0)
 ;;=3^Other/Unknown Substance Induced Obsess-Compul & Rel D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,23867,1,4,0)
 ;;=4^F19.188
 ;;^UTILITY(U,$J,358.3,23867,2)
 ;;=^5133361
 ;;^UTILITY(U,$J,358.3,23868,0)
 ;;=F19.288^^61^935^11
 ;;^UTILITY(U,$J,358.3,23868,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23868,1,3,0)
 ;;=3^Other/Unknown Substance Induced Obsess-Compul & Rel D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,23868,1,4,0)
 ;;=4^F19.288
 ;;^UTILITY(U,$J,358.3,23868,2)
 ;;=^5133362
 ;;^UTILITY(U,$J,358.3,23869,0)
 ;;=F19.988^^61^935^12
 ;;^UTILITY(U,$J,358.3,23869,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23869,1,3,0)
 ;;=3^Other/Unknown Substance Induced Obsess-Compul & Rel D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,23869,1,4,0)
 ;;=4^F19.988
 ;;^UTILITY(U,$J,358.3,23869,2)
 ;;=^5133363
 ;;^UTILITY(U,$J,358.3,23870,0)
 ;;=F19.159^^61^935^13
 ;;^UTILITY(U,$J,358.3,23870,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23870,1,3,0)
 ;;=3^Other/Unknown Substance Induced Psychotic D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,23870,1,4,0)
 ;;=4^F19.159
 ;;^UTILITY(U,$J,358.3,23870,2)
 ;;=^5003424
 ;;^UTILITY(U,$J,358.3,23871,0)
 ;;=F19.259^^61^935^14
 ;;^UTILITY(U,$J,358.3,23871,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23871,1,3,0)
 ;;=3^Other/Unknown Substance Induced Psychotic D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,23871,1,4,0)
 ;;=4^F19.259
 ;;^UTILITY(U,$J,358.3,23871,2)
 ;;=^5003444
 ;;^UTILITY(U,$J,358.3,23872,0)
 ;;=F19.959^^61^935^15
 ;;^UTILITY(U,$J,358.3,23872,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23872,1,3,0)
 ;;=3^Other/Unknown Substance Induced Psychotic D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,23872,1,4,0)
 ;;=4^F19.959
 ;;^UTILITY(U,$J,358.3,23872,2)
 ;;=^5003463
 ;;^UTILITY(U,$J,358.3,23873,0)
 ;;=F19.181^^61^935^16
 ;;^UTILITY(U,$J,358.3,23873,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23873,1,3,0)
 ;;=3^Other/Unknown Substance Induced Sexual Dysfunction w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,23873,1,4,0)
 ;;=4^F19.181
 ;;^UTILITY(U,$J,358.3,23873,2)
 ;;=^5003428
 ;;^UTILITY(U,$J,358.3,23874,0)
 ;;=F19.281^^61^935^17
 ;;^UTILITY(U,$J,358.3,23874,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23874,1,3,0)
 ;;=3^Other/Unknown Substance Induced Sexual Dysfunction w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,23874,1,4,0)
 ;;=4^F19.281
 ;;^UTILITY(U,$J,358.3,23874,2)
 ;;=^5003448
 ;;^UTILITY(U,$J,358.3,23875,0)
 ;;=F19.981^^61^935^18
 ;;^UTILITY(U,$J,358.3,23875,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23875,1,3,0)
 ;;=3^Other/Unknown Substance Induced Sexual Dysfunction w/ o Use D/O
 ;;^UTILITY(U,$J,358.3,23875,1,4,0)
 ;;=4^F19.981
 ;;^UTILITY(U,$J,358.3,23875,2)
 ;;=^5003467
 ;;^UTILITY(U,$J,358.3,23876,0)
 ;;=F19.182^^61^935^19
 ;;^UTILITY(U,$J,358.3,23876,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23876,1,3,0)
 ;;=3^Other/Unknown Substance Induced Sleep D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,23876,1,4,0)
 ;;=4^F19.182
 ;;^UTILITY(U,$J,358.3,23876,2)
 ;;=^5003429
 ;;^UTILITY(U,$J,358.3,23877,0)
 ;;=F19.282^^61^935^20
 ;;^UTILITY(U,$J,358.3,23877,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23877,1,3,0)
 ;;=3^Other/Unknown Substance Induced Sleep D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,23877,1,4,0)
 ;;=4^F19.282
 ;;^UTILITY(U,$J,358.3,23877,2)
 ;;=^5003449
 ;;^UTILITY(U,$J,358.3,23878,0)
 ;;=F19.982^^61^935^21
 ;;^UTILITY(U,$J,358.3,23878,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23878,1,3,0)
 ;;=3^Other/Unknown Substance Induced Sleep D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,23878,1,4,0)
 ;;=4^F19.982
 ;;^UTILITY(U,$J,358.3,23878,2)
 ;;=^5003468
 ;;^UTILITY(U,$J,358.3,23879,0)
 ;;=F19.129^^61^935^25
 ;;^UTILITY(U,$J,358.3,23879,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23879,1,3,0)
 ;;=3^Other/Unknown Substance Intoxication w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,23879,1,4,0)
 ;;=4^F19.129
 ;;^UTILITY(U,$J,358.3,23879,2)
 ;;=^5003420
 ;;^UTILITY(U,$J,358.3,23880,0)
 ;;=F19.229^^61^935^26
 ;;^UTILITY(U,$J,358.3,23880,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23880,1,3,0)
 ;;=3^Other/Unknown Substance Intoxication w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,23880,1,4,0)
 ;;=4^F19.229
 ;;^UTILITY(U,$J,358.3,23880,2)
 ;;=^5003436
 ;;^UTILITY(U,$J,358.3,23881,0)
 ;;=F19.929^^61^935^27
 ;;^UTILITY(U,$J,358.3,23881,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23881,1,3,0)
 ;;=3^Other/Unknown Substance Intoxication w/o Use D/O
 ;;^UTILITY(U,$J,358.3,23881,1,4,0)
 ;;=4^F19.929
 ;;^UTILITY(U,$J,358.3,23881,2)
 ;;=^5003455
 ;;^UTILITY(U,$J,358.3,23882,0)
 ;;=F19.121^^61^935^22
 ;;^UTILITY(U,$J,358.3,23882,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23882,1,3,0)
 ;;=3^Other/Unknown Substance Intoxication Delirium w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,23882,1,4,0)
 ;;=4^F19.121
 ;;^UTILITY(U,$J,358.3,23882,2)
 ;;=^5003418
 ;;^UTILITY(U,$J,358.3,23883,0)
 ;;=F19.221^^61^935^23
 ;;^UTILITY(U,$J,358.3,23883,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23883,1,3,0)
 ;;=3^Other/Unknown Substance Intoxication Delirium w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,23883,1,4,0)
 ;;=4^F19.221
 ;;^UTILITY(U,$J,358.3,23883,2)
 ;;=^5003434
 ;;^UTILITY(U,$J,358.3,23884,0)
 ;;=F19.921^^61^935^24
 ;;^UTILITY(U,$J,358.3,23884,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23884,1,3,0)
 ;;=3^Other/Unknown Substance Intoxication Delirium w/o Use D/O
 ;;^UTILITY(U,$J,358.3,23884,1,4,0)
 ;;=4^F19.921
 ;;^UTILITY(U,$J,358.3,23884,2)
 ;;=^5003453

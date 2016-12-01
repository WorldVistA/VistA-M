IBDEI0IU ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23885,0)
 ;;=F19.10^^61^935^29
 ;;^UTILITY(U,$J,358.3,23885,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23885,1,3,0)
 ;;=3^Other/Unknown Substance Use D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,23885,1,4,0)
 ;;=4^F19.10
 ;;^UTILITY(U,$J,358.3,23885,2)
 ;;=^5003416
 ;;^UTILITY(U,$J,358.3,23886,0)
 ;;=F19.20^^61^935^30
 ;;^UTILITY(U,$J,358.3,23886,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23886,1,3,0)
 ;;=3^Other/Unknown Substance Use D/O w/ Moderate Use D/O
 ;;^UTILITY(U,$J,358.3,23886,1,4,0)
 ;;=4^F19.20
 ;;^UTILITY(U,$J,358.3,23886,2)
 ;;=^5003431
 ;;^UTILITY(U,$J,358.3,23887,0)
 ;;=F19.20^^61^935^31
 ;;^UTILITY(U,$J,358.3,23887,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23887,1,3,0)
 ;;=3^Other/Unknown Substance Use D/O w/ Severe Use D/O
 ;;^UTILITY(U,$J,358.3,23887,1,4,0)
 ;;=4^F19.20
 ;;^UTILITY(U,$J,358.3,23887,2)
 ;;=^5003431
 ;;^UTILITY(U,$J,358.3,23888,0)
 ;;=F19.239^^61^935^32
 ;;^UTILITY(U,$J,358.3,23888,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23888,1,3,0)
 ;;=3^Other/Unknown Substance Withdrawal
 ;;^UTILITY(U,$J,358.3,23888,1,4,0)
 ;;=4^F19.239
 ;;^UTILITY(U,$J,358.3,23888,2)
 ;;=^5003440
 ;;^UTILITY(U,$J,358.3,23889,0)
 ;;=F19.231^^61^935^33
 ;;^UTILITY(U,$J,358.3,23889,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23889,1,3,0)
 ;;=3^Other/Unknown Substance Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,23889,1,4,0)
 ;;=4^F19.231
 ;;^UTILITY(U,$J,358.3,23889,2)
 ;;=^5003438
 ;;^UTILITY(U,$J,358.3,23890,0)
 ;;=F19.99^^61^935^28
 ;;^UTILITY(U,$J,358.3,23890,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23890,1,3,0)
 ;;=3^Other/Unknown Substance Related D/O,Unspec
 ;;^UTILITY(U,$J,358.3,23890,1,4,0)
 ;;=4^F19.99
 ;;^UTILITY(U,$J,358.3,23890,2)
 ;;=^5133364
 ;;^UTILITY(U,$J,358.3,23891,0)
 ;;=F15.10^^61^936^72
 ;;^UTILITY(U,$J,358.3,23891,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23891,1,3,0)
 ;;=3^Other or Unspecified Stimulant Use D/O, Mild
 ;;^UTILITY(U,$J,358.3,23891,1,4,0)
 ;;=4^F15.10
 ;;^UTILITY(U,$J,358.3,23891,2)
 ;;=^5003282
 ;;^UTILITY(U,$J,358.3,23892,0)
 ;;=F15.20^^61^936^73
 ;;^UTILITY(U,$J,358.3,23892,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23892,1,3,0)
 ;;=3^Other or Unspecified Stimulant Use D/O, Moderate
 ;;^UTILITY(U,$J,358.3,23892,1,4,0)
 ;;=4^F15.20
 ;;^UTILITY(U,$J,358.3,23892,2)
 ;;=^5003295
 ;;^UTILITY(U,$J,358.3,23893,0)
 ;;=F15.20^^61^936^74
 ;;^UTILITY(U,$J,358.3,23893,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23893,1,3,0)
 ;;=3^Other or Unspecified Stimulant Use D/O, Severe
 ;;^UTILITY(U,$J,358.3,23893,1,4,0)
 ;;=4^F15.20
 ;;^UTILITY(U,$J,358.3,23893,2)
 ;;=^5003295
 ;;^UTILITY(U,$J,358.3,23894,0)
 ;;=F15.99^^61^936^35
 ;;^UTILITY(U,$J,358.3,23894,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23894,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Related D/O,Unspec
 ;;^UTILITY(U,$J,358.3,23894,1,4,0)
 ;;=4^F15.99
 ;;^UTILITY(U,$J,358.3,23894,2)
 ;;=^5133358
 ;;^UTILITY(U,$J,358.3,23895,0)
 ;;=F14.99^^61^936^67
 ;;^UTILITY(U,$J,358.3,23895,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23895,1,3,0)
 ;;=3^Cocaine Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,23895,1,4,0)
 ;;=4^F14.99
 ;;^UTILITY(U,$J,358.3,23895,2)
 ;;=^5133354
 ;;^UTILITY(U,$J,358.3,23896,0)
 ;;=F14.99^^61^936^75
 ;;^UTILITY(U,$J,358.3,23896,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23896,1,3,0)
 ;;=3^Stimulant Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,23896,1,4,0)
 ;;=4^F14.99
 ;;^UTILITY(U,$J,358.3,23896,2)
 ;;=^5133354
 ;;^UTILITY(U,$J,358.3,23897,0)
 ;;=F15.180^^61^936^4
 ;;^UTILITY(U,$J,358.3,23897,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23897,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Anxiety D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,23897,1,4,0)
 ;;=4^F15.180
 ;;^UTILITY(U,$J,358.3,23897,2)
 ;;=^5003291
 ;;^UTILITY(U,$J,358.3,23898,0)
 ;;=F15.280^^61^936^5
 ;;^UTILITY(U,$J,358.3,23898,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23898,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Anxiety D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,23898,1,4,0)
 ;;=4^F15.280
 ;;^UTILITY(U,$J,358.3,23898,2)
 ;;=^5003306
 ;;^UTILITY(U,$J,358.3,23899,0)
 ;;=F15.980^^61^936^6
 ;;^UTILITY(U,$J,358.3,23899,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23899,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Anxiety D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,23899,1,4,0)
 ;;=4^F15.980
 ;;^UTILITY(U,$J,358.3,23899,2)
 ;;=^5003320
 ;;^UTILITY(U,$J,358.3,23900,0)
 ;;=F15.14^^61^936^7
 ;;^UTILITY(U,$J,358.3,23900,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23900,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Bipolar & Rel D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,23900,1,4,0)
 ;;=4^F15.14
 ;;^UTILITY(U,$J,358.3,23900,2)
 ;;=^5003287
 ;;^UTILITY(U,$J,358.3,23901,0)
 ;;=F15.24^^61^936^8
 ;;^UTILITY(U,$J,358.3,23901,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23901,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Bipolar & Rel D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,23901,1,4,0)
 ;;=4^F15.24
 ;;^UTILITY(U,$J,358.3,23901,2)
 ;;=^5003302
 ;;^UTILITY(U,$J,358.3,23902,0)
 ;;=F15.94^^61^936^9
 ;;^UTILITY(U,$J,358.3,23902,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23902,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Bipolar & Rel D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,23902,1,4,0)
 ;;=4^F15.94
 ;;^UTILITY(U,$J,358.3,23902,2)
 ;;=^5003316
 ;;^UTILITY(U,$J,358.3,23903,0)
 ;;=F15.921^^61^936^10
 ;;^UTILITY(U,$J,358.3,23903,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23903,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Delirium
 ;;^UTILITY(U,$J,358.3,23903,1,4,0)
 ;;=4^F15.921
 ;;^UTILITY(U,$J,358.3,23903,2)
 ;;=^5003312
 ;;^UTILITY(U,$J,358.3,23904,0)
 ;;=F15.14^^61^936^11
 ;;^UTILITY(U,$J,358.3,23904,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23904,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Depressive D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,23904,1,4,0)
 ;;=4^F15.14
 ;;^UTILITY(U,$J,358.3,23904,2)
 ;;=^5003287
 ;;^UTILITY(U,$J,358.3,23905,0)
 ;;=F15.24^^61^936^12
 ;;^UTILITY(U,$J,358.3,23905,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23905,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Depressive D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,23905,1,4,0)
 ;;=4^F15.24
 ;;^UTILITY(U,$J,358.3,23905,2)
 ;;=^5003302
 ;;^UTILITY(U,$J,358.3,23906,0)
 ;;=F15.94^^61^936^13
 ;;^UTILITY(U,$J,358.3,23906,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23906,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Depressive D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,23906,1,4,0)
 ;;=4^F15.94
 ;;^UTILITY(U,$J,358.3,23906,2)
 ;;=^5003316
 ;;^UTILITY(U,$J,358.3,23907,0)
 ;;=F15.188^^61^936^14
 ;;^UTILITY(U,$J,358.3,23907,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23907,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Obess-Compul & Rel D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,23907,1,4,0)
 ;;=4^F15.188
 ;;^UTILITY(U,$J,358.3,23907,2)
 ;;=^5133355
 ;;^UTILITY(U,$J,358.3,23908,0)
 ;;=F15.288^^61^936^15
 ;;^UTILITY(U,$J,358.3,23908,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23908,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Obess-Compul & Rel D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,23908,1,4,0)
 ;;=4^F15.288
 ;;^UTILITY(U,$J,358.3,23908,2)
 ;;=^5133356
 ;;^UTILITY(U,$J,358.3,23909,0)
 ;;=F15.988^^61^936^16
 ;;^UTILITY(U,$J,358.3,23909,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23909,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Obess-Compul & Rel D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,23909,1,4,0)
 ;;=4^F15.988
 ;;^UTILITY(U,$J,358.3,23909,2)
 ;;=^5133357
 ;;^UTILITY(U,$J,358.3,23910,0)
 ;;=F15.159^^61^936^17
 ;;^UTILITY(U,$J,358.3,23910,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23910,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Psychotic D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,23910,1,4,0)
 ;;=4^F15.159
 ;;^UTILITY(U,$J,358.3,23910,2)
 ;;=^5003290
 ;;^UTILITY(U,$J,358.3,23911,0)
 ;;=F15.259^^61^936^18
 ;;^UTILITY(U,$J,358.3,23911,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23911,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Psychotic D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,23911,1,4,0)
 ;;=4^F15.259
 ;;^UTILITY(U,$J,358.3,23911,2)
 ;;=^5003305
 ;;^UTILITY(U,$J,358.3,23912,0)
 ;;=F15.959^^61^936^19
 ;;^UTILITY(U,$J,358.3,23912,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23912,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Psychotic D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,23912,1,4,0)
 ;;=4^F15.959
 ;;^UTILITY(U,$J,358.3,23912,2)
 ;;=^5003319
 ;;^UTILITY(U,$J,358.3,23913,0)
 ;;=F15.181^^61^936^20
 ;;^UTILITY(U,$J,358.3,23913,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23913,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Sexual Dysfunction w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,23913,1,4,0)
 ;;=4^F15.181
 ;;^UTILITY(U,$J,358.3,23913,2)
 ;;=^5003292
 ;;^UTILITY(U,$J,358.3,23914,0)
 ;;=F15.281^^61^936^21
 ;;^UTILITY(U,$J,358.3,23914,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23914,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Sexual Dysfunction w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,23914,1,4,0)
 ;;=4^F15.281
 ;;^UTILITY(U,$J,358.3,23914,2)
 ;;=^5003307
 ;;^UTILITY(U,$J,358.3,23915,0)
 ;;=F15.981^^61^936^22
 ;;^UTILITY(U,$J,358.3,23915,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23915,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Sexual Dysfunction w/o Use D/O
 ;;^UTILITY(U,$J,358.3,23915,1,4,0)
 ;;=4^F15.981
 ;;^UTILITY(U,$J,358.3,23915,2)
 ;;=^5003321
 ;;^UTILITY(U,$J,358.3,23916,0)
 ;;=F15.182^^61^936^23
 ;;^UTILITY(U,$J,358.3,23916,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23916,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Sleep D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,23916,1,4,0)
 ;;=4^F15.182
 ;;^UTILITY(U,$J,358.3,23916,2)
 ;;=^5003293
 ;;^UTILITY(U,$J,358.3,23917,0)
 ;;=F15.282^^61^936^24
 ;;^UTILITY(U,$J,358.3,23917,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23917,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Sleep D/O w/ Mod-Sev Use D/O

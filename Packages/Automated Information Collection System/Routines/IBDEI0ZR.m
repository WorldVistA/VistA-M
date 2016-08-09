IBDEI0ZR ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,35975,1,3,0)
 ;;=3^Other/Unknown Substance Use D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,35975,1,4,0)
 ;;=4^F19.10
 ;;^UTILITY(U,$J,358.3,35975,2)
 ;;=^5003416
 ;;^UTILITY(U,$J,358.3,35976,0)
 ;;=F19.20^^130^1736^30
 ;;^UTILITY(U,$J,358.3,35976,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35976,1,3,0)
 ;;=3^Other/Unknown Substance Use D/O w/ Moderate Use D/O
 ;;^UTILITY(U,$J,358.3,35976,1,4,0)
 ;;=4^F19.20
 ;;^UTILITY(U,$J,358.3,35976,2)
 ;;=^5003431
 ;;^UTILITY(U,$J,358.3,35977,0)
 ;;=F19.20^^130^1736^31
 ;;^UTILITY(U,$J,358.3,35977,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35977,1,3,0)
 ;;=3^Other/Unknown Substance Use D/O w/ Severe Use D/O
 ;;^UTILITY(U,$J,358.3,35977,1,4,0)
 ;;=4^F19.20
 ;;^UTILITY(U,$J,358.3,35977,2)
 ;;=^5003431
 ;;^UTILITY(U,$J,358.3,35978,0)
 ;;=F19.239^^130^1736^32
 ;;^UTILITY(U,$J,358.3,35978,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35978,1,3,0)
 ;;=3^Other/Unknown Substance Withdrawal
 ;;^UTILITY(U,$J,358.3,35978,1,4,0)
 ;;=4^F19.239
 ;;^UTILITY(U,$J,358.3,35978,2)
 ;;=^5003440
 ;;^UTILITY(U,$J,358.3,35979,0)
 ;;=F19.231^^130^1736^33
 ;;^UTILITY(U,$J,358.3,35979,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35979,1,3,0)
 ;;=3^Other/Unknown Substance Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,35979,1,4,0)
 ;;=4^F19.231
 ;;^UTILITY(U,$J,358.3,35979,2)
 ;;=^5003438
 ;;^UTILITY(U,$J,358.3,35980,0)
 ;;=F19.99^^130^1736^28
 ;;^UTILITY(U,$J,358.3,35980,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35980,1,3,0)
 ;;=3^Other/Unknown Substance Related D/O,Unspec
 ;;^UTILITY(U,$J,358.3,35980,1,4,0)
 ;;=4^F19.99
 ;;^UTILITY(U,$J,358.3,35980,2)
 ;;=^5133364
 ;;^UTILITY(U,$J,358.3,35981,0)
 ;;=F15.10^^130^1737^72
 ;;^UTILITY(U,$J,358.3,35981,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35981,1,3,0)
 ;;=3^Other or Unspecified Stimulant Use D/O, Mild
 ;;^UTILITY(U,$J,358.3,35981,1,4,0)
 ;;=4^F15.10
 ;;^UTILITY(U,$J,358.3,35981,2)
 ;;=^5003282
 ;;^UTILITY(U,$J,358.3,35982,0)
 ;;=F15.20^^130^1737^73
 ;;^UTILITY(U,$J,358.3,35982,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35982,1,3,0)
 ;;=3^Other or Unspecified Stimulant Use D/O, Moderate
 ;;^UTILITY(U,$J,358.3,35982,1,4,0)
 ;;=4^F15.20
 ;;^UTILITY(U,$J,358.3,35982,2)
 ;;=^5003295
 ;;^UTILITY(U,$J,358.3,35983,0)
 ;;=F15.20^^130^1737^74
 ;;^UTILITY(U,$J,358.3,35983,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35983,1,3,0)
 ;;=3^Other or Unspecified Stimulant Use D/O, Severe
 ;;^UTILITY(U,$J,358.3,35983,1,4,0)
 ;;=4^F15.20
 ;;^UTILITY(U,$J,358.3,35983,2)
 ;;=^5003295
 ;;^UTILITY(U,$J,358.3,35984,0)
 ;;=F15.99^^130^1737^35
 ;;^UTILITY(U,$J,358.3,35984,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35984,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Related D/O,Unspec
 ;;^UTILITY(U,$J,358.3,35984,1,4,0)
 ;;=4^F15.99
 ;;^UTILITY(U,$J,358.3,35984,2)
 ;;=^5133358
 ;;^UTILITY(U,$J,358.3,35985,0)
 ;;=F14.99^^130^1737^67
 ;;^UTILITY(U,$J,358.3,35985,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35985,1,3,0)
 ;;=3^Cocaine Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,35985,1,4,0)
 ;;=4^F14.99
 ;;^UTILITY(U,$J,358.3,35985,2)
 ;;=^5133354
 ;;^UTILITY(U,$J,358.3,35986,0)
 ;;=F14.99^^130^1737^75
 ;;^UTILITY(U,$J,358.3,35986,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35986,1,3,0)
 ;;=3^Stimulant Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,35986,1,4,0)
 ;;=4^F14.99
 ;;^UTILITY(U,$J,358.3,35986,2)
 ;;=^5133354
 ;;^UTILITY(U,$J,358.3,35987,0)
 ;;=F15.180^^130^1737^4
 ;;^UTILITY(U,$J,358.3,35987,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35987,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Anxiety D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,35987,1,4,0)
 ;;=4^F15.180
 ;;^UTILITY(U,$J,358.3,35987,2)
 ;;=^5003291
 ;;^UTILITY(U,$J,358.3,35988,0)
 ;;=F15.280^^130^1737^5
 ;;^UTILITY(U,$J,358.3,35988,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35988,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Anxiety D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,35988,1,4,0)
 ;;=4^F15.280
 ;;^UTILITY(U,$J,358.3,35988,2)
 ;;=^5003306
 ;;^UTILITY(U,$J,358.3,35989,0)
 ;;=F15.980^^130^1737^6
 ;;^UTILITY(U,$J,358.3,35989,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35989,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Anxiety D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,35989,1,4,0)
 ;;=4^F15.980
 ;;^UTILITY(U,$J,358.3,35989,2)
 ;;=^5003320
 ;;^UTILITY(U,$J,358.3,35990,0)
 ;;=F15.14^^130^1737^7
 ;;^UTILITY(U,$J,358.3,35990,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35990,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Bipolar & Rel D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,35990,1,4,0)
 ;;=4^F15.14
 ;;^UTILITY(U,$J,358.3,35990,2)
 ;;=^5003287
 ;;^UTILITY(U,$J,358.3,35991,0)
 ;;=F15.24^^130^1737^8
 ;;^UTILITY(U,$J,358.3,35991,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35991,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Bipolar & Rel D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,35991,1,4,0)
 ;;=4^F15.24
 ;;^UTILITY(U,$J,358.3,35991,2)
 ;;=^5003302
 ;;^UTILITY(U,$J,358.3,35992,0)
 ;;=F15.94^^130^1737^9
 ;;^UTILITY(U,$J,358.3,35992,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35992,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Bipolar & Rel D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,35992,1,4,0)
 ;;=4^F15.94
 ;;^UTILITY(U,$J,358.3,35992,2)
 ;;=^5003316
 ;;^UTILITY(U,$J,358.3,35993,0)
 ;;=F15.921^^130^1737^10
 ;;^UTILITY(U,$J,358.3,35993,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35993,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Delirium
 ;;^UTILITY(U,$J,358.3,35993,1,4,0)
 ;;=4^F15.921
 ;;^UTILITY(U,$J,358.3,35993,2)
 ;;=^5003312
 ;;^UTILITY(U,$J,358.3,35994,0)
 ;;=F15.14^^130^1737^11
 ;;^UTILITY(U,$J,358.3,35994,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35994,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Depressive D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,35994,1,4,0)
 ;;=4^F15.14
 ;;^UTILITY(U,$J,358.3,35994,2)
 ;;=^5003287
 ;;^UTILITY(U,$J,358.3,35995,0)
 ;;=F15.24^^130^1737^12
 ;;^UTILITY(U,$J,358.3,35995,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35995,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Depressive D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,35995,1,4,0)
 ;;=4^F15.24
 ;;^UTILITY(U,$J,358.3,35995,2)
 ;;=^5003302
 ;;^UTILITY(U,$J,358.3,35996,0)
 ;;=F15.94^^130^1737^13
 ;;^UTILITY(U,$J,358.3,35996,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35996,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Depressive D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,35996,1,4,0)
 ;;=4^F15.94
 ;;^UTILITY(U,$J,358.3,35996,2)
 ;;=^5003316
 ;;^UTILITY(U,$J,358.3,35997,0)
 ;;=F15.188^^130^1737^14
 ;;^UTILITY(U,$J,358.3,35997,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35997,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Obess-Compul & Rel D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,35997,1,4,0)
 ;;=4^F15.188
 ;;^UTILITY(U,$J,358.3,35997,2)
 ;;=^5133355
 ;;^UTILITY(U,$J,358.3,35998,0)
 ;;=F15.288^^130^1737^15
 ;;^UTILITY(U,$J,358.3,35998,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35998,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Obess-Compul & Rel D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,35998,1,4,0)
 ;;=4^F15.288
 ;;^UTILITY(U,$J,358.3,35998,2)
 ;;=^5133356
 ;;^UTILITY(U,$J,358.3,35999,0)
 ;;=F15.988^^130^1737^16
 ;;^UTILITY(U,$J,358.3,35999,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35999,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Obess-Compul & Rel D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,35999,1,4,0)
 ;;=4^F15.988
 ;;^UTILITY(U,$J,358.3,35999,2)
 ;;=^5133357
 ;;^UTILITY(U,$J,358.3,36000,0)
 ;;=F15.159^^130^1737^17
 ;;^UTILITY(U,$J,358.3,36000,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36000,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Psychotic D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,36000,1,4,0)
 ;;=4^F15.159
 ;;^UTILITY(U,$J,358.3,36000,2)
 ;;=^5003290

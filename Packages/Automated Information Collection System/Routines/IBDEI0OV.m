IBDEI0OV ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31520,0)
 ;;=F19.20^^91^1374^30
 ;;^UTILITY(U,$J,358.3,31520,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31520,1,3,0)
 ;;=3^Other/Unknown Substance Use D/O w/ Moderate Use D/O
 ;;^UTILITY(U,$J,358.3,31520,1,4,0)
 ;;=4^F19.20
 ;;^UTILITY(U,$J,358.3,31520,2)
 ;;=^5003431
 ;;^UTILITY(U,$J,358.3,31521,0)
 ;;=F19.20^^91^1374^31
 ;;^UTILITY(U,$J,358.3,31521,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31521,1,3,0)
 ;;=3^Other/Unknown Substance Use D/O w/ Severe Use D/O
 ;;^UTILITY(U,$J,358.3,31521,1,4,0)
 ;;=4^F19.20
 ;;^UTILITY(U,$J,358.3,31521,2)
 ;;=^5003431
 ;;^UTILITY(U,$J,358.3,31522,0)
 ;;=F19.239^^91^1374^32
 ;;^UTILITY(U,$J,358.3,31522,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31522,1,3,0)
 ;;=3^Other/Unknown Substance Withdrawal
 ;;^UTILITY(U,$J,358.3,31522,1,4,0)
 ;;=4^F19.239
 ;;^UTILITY(U,$J,358.3,31522,2)
 ;;=^5003440
 ;;^UTILITY(U,$J,358.3,31523,0)
 ;;=F19.231^^91^1374^33
 ;;^UTILITY(U,$J,358.3,31523,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31523,1,3,0)
 ;;=3^Other/Unknown Substance Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,31523,1,4,0)
 ;;=4^F19.231
 ;;^UTILITY(U,$J,358.3,31523,2)
 ;;=^5003438
 ;;^UTILITY(U,$J,358.3,31524,0)
 ;;=F19.99^^91^1374^28
 ;;^UTILITY(U,$J,358.3,31524,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31524,1,3,0)
 ;;=3^Other/Unknown Substance Related D/O,Unspec
 ;;^UTILITY(U,$J,358.3,31524,1,4,0)
 ;;=4^F19.99
 ;;^UTILITY(U,$J,358.3,31524,2)
 ;;=^5133364
 ;;^UTILITY(U,$J,358.3,31525,0)
 ;;=F15.10^^91^1375^72
 ;;^UTILITY(U,$J,358.3,31525,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31525,1,3,0)
 ;;=3^Other or Unspecified Stimulant Use D/O, Mild
 ;;^UTILITY(U,$J,358.3,31525,1,4,0)
 ;;=4^F15.10
 ;;^UTILITY(U,$J,358.3,31525,2)
 ;;=^5003282
 ;;^UTILITY(U,$J,358.3,31526,0)
 ;;=F15.20^^91^1375^73
 ;;^UTILITY(U,$J,358.3,31526,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31526,1,3,0)
 ;;=3^Other or Unspecified Stimulant Use D/O, Moderate
 ;;^UTILITY(U,$J,358.3,31526,1,4,0)
 ;;=4^F15.20
 ;;^UTILITY(U,$J,358.3,31526,2)
 ;;=^5003295
 ;;^UTILITY(U,$J,358.3,31527,0)
 ;;=F15.20^^91^1375^74
 ;;^UTILITY(U,$J,358.3,31527,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31527,1,3,0)
 ;;=3^Other or Unspecified Stimulant Use D/O, Severe
 ;;^UTILITY(U,$J,358.3,31527,1,4,0)
 ;;=4^F15.20
 ;;^UTILITY(U,$J,358.3,31527,2)
 ;;=^5003295
 ;;^UTILITY(U,$J,358.3,31528,0)
 ;;=F15.99^^91^1375^35
 ;;^UTILITY(U,$J,358.3,31528,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31528,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Related D/O,Unspec
 ;;^UTILITY(U,$J,358.3,31528,1,4,0)
 ;;=4^F15.99
 ;;^UTILITY(U,$J,358.3,31528,2)
 ;;=^5133358
 ;;^UTILITY(U,$J,358.3,31529,0)
 ;;=F14.99^^91^1375^67
 ;;^UTILITY(U,$J,358.3,31529,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31529,1,3,0)
 ;;=3^Cocaine Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,31529,1,4,0)
 ;;=4^F14.99
 ;;^UTILITY(U,$J,358.3,31529,2)
 ;;=^5133354
 ;;^UTILITY(U,$J,358.3,31530,0)
 ;;=F14.99^^91^1375^75
 ;;^UTILITY(U,$J,358.3,31530,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31530,1,3,0)
 ;;=3^Stimulant Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,31530,1,4,0)
 ;;=4^F14.99
 ;;^UTILITY(U,$J,358.3,31530,2)
 ;;=^5133354
 ;;^UTILITY(U,$J,358.3,31531,0)
 ;;=F15.180^^91^1375^4
 ;;^UTILITY(U,$J,358.3,31531,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31531,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Anxiety D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,31531,1,4,0)
 ;;=4^F15.180
 ;;^UTILITY(U,$J,358.3,31531,2)
 ;;=^5003291
 ;;^UTILITY(U,$J,358.3,31532,0)
 ;;=F15.280^^91^1375^5
 ;;^UTILITY(U,$J,358.3,31532,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31532,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Anxiety D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,31532,1,4,0)
 ;;=4^F15.280
 ;;^UTILITY(U,$J,358.3,31532,2)
 ;;=^5003306
 ;;^UTILITY(U,$J,358.3,31533,0)
 ;;=F15.980^^91^1375^6
 ;;^UTILITY(U,$J,358.3,31533,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31533,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Anxiety D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,31533,1,4,0)
 ;;=4^F15.980
 ;;^UTILITY(U,$J,358.3,31533,2)
 ;;=^5003320
 ;;^UTILITY(U,$J,358.3,31534,0)
 ;;=F15.14^^91^1375^7
 ;;^UTILITY(U,$J,358.3,31534,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31534,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Bipolar & Rel D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,31534,1,4,0)
 ;;=4^F15.14
 ;;^UTILITY(U,$J,358.3,31534,2)
 ;;=^5003287
 ;;^UTILITY(U,$J,358.3,31535,0)
 ;;=F15.24^^91^1375^8
 ;;^UTILITY(U,$J,358.3,31535,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31535,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Bipolar & Rel D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,31535,1,4,0)
 ;;=4^F15.24
 ;;^UTILITY(U,$J,358.3,31535,2)
 ;;=^5003302
 ;;^UTILITY(U,$J,358.3,31536,0)
 ;;=F15.94^^91^1375^9
 ;;^UTILITY(U,$J,358.3,31536,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31536,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Bipolar & Rel D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,31536,1,4,0)
 ;;=4^F15.94
 ;;^UTILITY(U,$J,358.3,31536,2)
 ;;=^5003316
 ;;^UTILITY(U,$J,358.3,31537,0)
 ;;=F15.921^^91^1375^10
 ;;^UTILITY(U,$J,358.3,31537,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31537,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Delirium
 ;;^UTILITY(U,$J,358.3,31537,1,4,0)
 ;;=4^F15.921
 ;;^UTILITY(U,$J,358.3,31537,2)
 ;;=^5003312
 ;;^UTILITY(U,$J,358.3,31538,0)
 ;;=F15.14^^91^1375^11
 ;;^UTILITY(U,$J,358.3,31538,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31538,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Depressive D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,31538,1,4,0)
 ;;=4^F15.14
 ;;^UTILITY(U,$J,358.3,31538,2)
 ;;=^5003287
 ;;^UTILITY(U,$J,358.3,31539,0)
 ;;=F15.24^^91^1375^12
 ;;^UTILITY(U,$J,358.3,31539,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31539,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Depressive D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,31539,1,4,0)
 ;;=4^F15.24
 ;;^UTILITY(U,$J,358.3,31539,2)
 ;;=^5003302
 ;;^UTILITY(U,$J,358.3,31540,0)
 ;;=F15.94^^91^1375^13
 ;;^UTILITY(U,$J,358.3,31540,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31540,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Depressive D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,31540,1,4,0)
 ;;=4^F15.94
 ;;^UTILITY(U,$J,358.3,31540,2)
 ;;=^5003316
 ;;^UTILITY(U,$J,358.3,31541,0)
 ;;=F15.188^^91^1375^14
 ;;^UTILITY(U,$J,358.3,31541,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31541,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Obess-Compul & Rel D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,31541,1,4,0)
 ;;=4^F15.188
 ;;^UTILITY(U,$J,358.3,31541,2)
 ;;=^5133355
 ;;^UTILITY(U,$J,358.3,31542,0)
 ;;=F15.288^^91^1375^15
 ;;^UTILITY(U,$J,358.3,31542,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31542,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Obess-Compul & Rel D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,31542,1,4,0)
 ;;=4^F15.288
 ;;^UTILITY(U,$J,358.3,31542,2)
 ;;=^5133356
 ;;^UTILITY(U,$J,358.3,31543,0)
 ;;=F15.988^^91^1375^16
 ;;^UTILITY(U,$J,358.3,31543,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31543,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Obess-Compul & Rel D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,31543,1,4,0)
 ;;=4^F15.988
 ;;^UTILITY(U,$J,358.3,31543,2)
 ;;=^5133357
 ;;^UTILITY(U,$J,358.3,31544,0)
 ;;=F15.159^^91^1375^17
 ;;^UTILITY(U,$J,358.3,31544,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31544,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Psychotic D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,31544,1,4,0)
 ;;=4^F15.159
 ;;^UTILITY(U,$J,358.3,31544,2)
 ;;=^5003290
 ;;^UTILITY(U,$J,358.3,31545,0)
 ;;=F15.259^^91^1375^18
 ;;^UTILITY(U,$J,358.3,31545,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31545,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Psychotic D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,31545,1,4,0)
 ;;=4^F15.259
 ;;^UTILITY(U,$J,358.3,31545,2)
 ;;=^5003305
 ;;^UTILITY(U,$J,358.3,31546,0)
 ;;=F15.959^^91^1375^19
 ;;^UTILITY(U,$J,358.3,31546,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31546,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Psychotic D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,31546,1,4,0)
 ;;=4^F15.959
 ;;^UTILITY(U,$J,358.3,31546,2)
 ;;=^5003319
 ;;^UTILITY(U,$J,358.3,31547,0)
 ;;=F15.181^^91^1375^20
 ;;^UTILITY(U,$J,358.3,31547,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31547,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Sexual Dysfunction w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,31547,1,4,0)
 ;;=4^F15.181
 ;;^UTILITY(U,$J,358.3,31547,2)
 ;;=^5003292
 ;;^UTILITY(U,$J,358.3,31548,0)
 ;;=F15.281^^91^1375^21
 ;;^UTILITY(U,$J,358.3,31548,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31548,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Sexual Dysfunction w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,31548,1,4,0)
 ;;=4^F15.281
 ;;^UTILITY(U,$J,358.3,31548,2)
 ;;=^5003307
 ;;^UTILITY(U,$J,358.3,31549,0)
 ;;=F15.981^^91^1375^22
 ;;^UTILITY(U,$J,358.3,31549,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31549,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Sexual Dysfunction w/o Use D/O
 ;;^UTILITY(U,$J,358.3,31549,1,4,0)
 ;;=4^F15.981
 ;;^UTILITY(U,$J,358.3,31549,2)
 ;;=^5003321
 ;;^UTILITY(U,$J,358.3,31550,0)
 ;;=F15.182^^91^1375^23
 ;;^UTILITY(U,$J,358.3,31550,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31550,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Sleep D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,31550,1,4,0)
 ;;=4^F15.182
 ;;^UTILITY(U,$J,358.3,31550,2)
 ;;=^5003293
 ;;^UTILITY(U,$J,358.3,31551,0)
 ;;=F15.282^^91^1375^24
 ;;^UTILITY(U,$J,358.3,31551,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31551,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Sleep D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,31551,1,4,0)
 ;;=4^F15.282
 ;;^UTILITY(U,$J,358.3,31551,2)
 ;;=^5003308
 ;;^UTILITY(U,$J,358.3,31552,0)
 ;;=F15.982^^91^1375^25
 ;;^UTILITY(U,$J,358.3,31552,1,0)
 ;;=^358.31IA^4^2

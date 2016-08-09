IBDEI0DL ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,13576,0)
 ;;=F19.121^^58^712^22
 ;;^UTILITY(U,$J,358.3,13576,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13576,1,3,0)
 ;;=3^Other/Unknown Substance Intoxication Delirium w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,13576,1,4,0)
 ;;=4^F19.121
 ;;^UTILITY(U,$J,358.3,13576,2)
 ;;=^5003418
 ;;^UTILITY(U,$J,358.3,13577,0)
 ;;=F19.221^^58^712^23
 ;;^UTILITY(U,$J,358.3,13577,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13577,1,3,0)
 ;;=3^Other/Unknown Substance Intoxication Delirium w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,13577,1,4,0)
 ;;=4^F19.221
 ;;^UTILITY(U,$J,358.3,13577,2)
 ;;=^5003434
 ;;^UTILITY(U,$J,358.3,13578,0)
 ;;=F19.921^^58^712^24
 ;;^UTILITY(U,$J,358.3,13578,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13578,1,3,0)
 ;;=3^Other/Unknown Substance Intoxication Delirium w/o Use D/O
 ;;^UTILITY(U,$J,358.3,13578,1,4,0)
 ;;=4^F19.921
 ;;^UTILITY(U,$J,358.3,13578,2)
 ;;=^5003453
 ;;^UTILITY(U,$J,358.3,13579,0)
 ;;=F19.10^^58^712^29
 ;;^UTILITY(U,$J,358.3,13579,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13579,1,3,0)
 ;;=3^Other/Unknown Substance Use D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,13579,1,4,0)
 ;;=4^F19.10
 ;;^UTILITY(U,$J,358.3,13579,2)
 ;;=^5003416
 ;;^UTILITY(U,$J,358.3,13580,0)
 ;;=F19.20^^58^712^30
 ;;^UTILITY(U,$J,358.3,13580,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13580,1,3,0)
 ;;=3^Other/Unknown Substance Use D/O w/ Moderate Use D/O
 ;;^UTILITY(U,$J,358.3,13580,1,4,0)
 ;;=4^F19.20
 ;;^UTILITY(U,$J,358.3,13580,2)
 ;;=^5003431
 ;;^UTILITY(U,$J,358.3,13581,0)
 ;;=F19.20^^58^712^31
 ;;^UTILITY(U,$J,358.3,13581,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13581,1,3,0)
 ;;=3^Other/Unknown Substance Use D/O w/ Severe Use D/O
 ;;^UTILITY(U,$J,358.3,13581,1,4,0)
 ;;=4^F19.20
 ;;^UTILITY(U,$J,358.3,13581,2)
 ;;=^5003431
 ;;^UTILITY(U,$J,358.3,13582,0)
 ;;=F19.239^^58^712^32
 ;;^UTILITY(U,$J,358.3,13582,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13582,1,3,0)
 ;;=3^Other/Unknown Substance Withdrawal
 ;;^UTILITY(U,$J,358.3,13582,1,4,0)
 ;;=4^F19.239
 ;;^UTILITY(U,$J,358.3,13582,2)
 ;;=^5003440
 ;;^UTILITY(U,$J,358.3,13583,0)
 ;;=F19.231^^58^712^33
 ;;^UTILITY(U,$J,358.3,13583,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13583,1,3,0)
 ;;=3^Other/Unknown Substance Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,13583,1,4,0)
 ;;=4^F19.231
 ;;^UTILITY(U,$J,358.3,13583,2)
 ;;=^5003438
 ;;^UTILITY(U,$J,358.3,13584,0)
 ;;=F19.99^^58^712^28
 ;;^UTILITY(U,$J,358.3,13584,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13584,1,3,0)
 ;;=3^Other/Unknown Substance Related D/O,Unspec
 ;;^UTILITY(U,$J,358.3,13584,1,4,0)
 ;;=4^F19.99
 ;;^UTILITY(U,$J,358.3,13584,2)
 ;;=^5133364
 ;;^UTILITY(U,$J,358.3,13585,0)
 ;;=F15.10^^58^713^72
 ;;^UTILITY(U,$J,358.3,13585,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13585,1,3,0)
 ;;=3^Other or Unspecified Stimulant Use D/O, Mild
 ;;^UTILITY(U,$J,358.3,13585,1,4,0)
 ;;=4^F15.10
 ;;^UTILITY(U,$J,358.3,13585,2)
 ;;=^5003282
 ;;^UTILITY(U,$J,358.3,13586,0)
 ;;=F15.20^^58^713^73
 ;;^UTILITY(U,$J,358.3,13586,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13586,1,3,0)
 ;;=3^Other or Unspecified Stimulant Use D/O, Moderate
 ;;^UTILITY(U,$J,358.3,13586,1,4,0)
 ;;=4^F15.20
 ;;^UTILITY(U,$J,358.3,13586,2)
 ;;=^5003295
 ;;^UTILITY(U,$J,358.3,13587,0)
 ;;=F15.20^^58^713^74
 ;;^UTILITY(U,$J,358.3,13587,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13587,1,3,0)
 ;;=3^Other or Unspecified Stimulant Use D/O, Severe
 ;;^UTILITY(U,$J,358.3,13587,1,4,0)
 ;;=4^F15.20
 ;;^UTILITY(U,$J,358.3,13587,2)
 ;;=^5003295
 ;;^UTILITY(U,$J,358.3,13588,0)
 ;;=F15.99^^58^713^35
 ;;^UTILITY(U,$J,358.3,13588,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13588,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Related D/O,Unspec
 ;;^UTILITY(U,$J,358.3,13588,1,4,0)
 ;;=4^F15.99
 ;;^UTILITY(U,$J,358.3,13588,2)
 ;;=^5133358
 ;;^UTILITY(U,$J,358.3,13589,0)
 ;;=F14.99^^58^713^67
 ;;^UTILITY(U,$J,358.3,13589,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13589,1,3,0)
 ;;=3^Cocaine Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,13589,1,4,0)
 ;;=4^F14.99
 ;;^UTILITY(U,$J,358.3,13589,2)
 ;;=^5133354
 ;;^UTILITY(U,$J,358.3,13590,0)
 ;;=F14.99^^58^713^75
 ;;^UTILITY(U,$J,358.3,13590,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13590,1,3,0)
 ;;=3^Stimulant Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,13590,1,4,0)
 ;;=4^F14.99
 ;;^UTILITY(U,$J,358.3,13590,2)
 ;;=^5133354
 ;;^UTILITY(U,$J,358.3,13591,0)
 ;;=F15.180^^58^713^4
 ;;^UTILITY(U,$J,358.3,13591,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13591,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Anxiety D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,13591,1,4,0)
 ;;=4^F15.180
 ;;^UTILITY(U,$J,358.3,13591,2)
 ;;=^5003291
 ;;^UTILITY(U,$J,358.3,13592,0)
 ;;=F15.280^^58^713^5
 ;;^UTILITY(U,$J,358.3,13592,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13592,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Anxiety D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,13592,1,4,0)
 ;;=4^F15.280
 ;;^UTILITY(U,$J,358.3,13592,2)
 ;;=^5003306
 ;;^UTILITY(U,$J,358.3,13593,0)
 ;;=F15.980^^58^713^6
 ;;^UTILITY(U,$J,358.3,13593,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13593,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Anxiety D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,13593,1,4,0)
 ;;=4^F15.980
 ;;^UTILITY(U,$J,358.3,13593,2)
 ;;=^5003320
 ;;^UTILITY(U,$J,358.3,13594,0)
 ;;=F15.14^^58^713^7
 ;;^UTILITY(U,$J,358.3,13594,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13594,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Bipolar & Rel D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,13594,1,4,0)
 ;;=4^F15.14
 ;;^UTILITY(U,$J,358.3,13594,2)
 ;;=^5003287
 ;;^UTILITY(U,$J,358.3,13595,0)
 ;;=F15.24^^58^713^8
 ;;^UTILITY(U,$J,358.3,13595,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13595,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Bipolar & Rel D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,13595,1,4,0)
 ;;=4^F15.24
 ;;^UTILITY(U,$J,358.3,13595,2)
 ;;=^5003302
 ;;^UTILITY(U,$J,358.3,13596,0)
 ;;=F15.94^^58^713^9
 ;;^UTILITY(U,$J,358.3,13596,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13596,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Bipolar & Rel D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,13596,1,4,0)
 ;;=4^F15.94
 ;;^UTILITY(U,$J,358.3,13596,2)
 ;;=^5003316
 ;;^UTILITY(U,$J,358.3,13597,0)
 ;;=F15.921^^58^713^10
 ;;^UTILITY(U,$J,358.3,13597,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13597,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Delirium
 ;;^UTILITY(U,$J,358.3,13597,1,4,0)
 ;;=4^F15.921
 ;;^UTILITY(U,$J,358.3,13597,2)
 ;;=^5003312
 ;;^UTILITY(U,$J,358.3,13598,0)
 ;;=F15.14^^58^713^11
 ;;^UTILITY(U,$J,358.3,13598,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13598,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Depressive D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,13598,1,4,0)
 ;;=4^F15.14
 ;;^UTILITY(U,$J,358.3,13598,2)
 ;;=^5003287
 ;;^UTILITY(U,$J,358.3,13599,0)
 ;;=F15.24^^58^713^12
 ;;^UTILITY(U,$J,358.3,13599,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13599,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Depressive D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,13599,1,4,0)
 ;;=4^F15.24
 ;;^UTILITY(U,$J,358.3,13599,2)
 ;;=^5003302
 ;;^UTILITY(U,$J,358.3,13600,0)
 ;;=F15.94^^58^713^13
 ;;^UTILITY(U,$J,358.3,13600,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13600,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Depressive D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,13600,1,4,0)
 ;;=4^F15.94
 ;;^UTILITY(U,$J,358.3,13600,2)
 ;;=^5003316
 ;;^UTILITY(U,$J,358.3,13601,0)
 ;;=F15.188^^58^713^14
 ;;^UTILITY(U,$J,358.3,13601,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13601,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Obess-Compul & Rel D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,13601,1,4,0)
 ;;=4^F15.188
 ;;^UTILITY(U,$J,358.3,13601,2)
 ;;=^5133355

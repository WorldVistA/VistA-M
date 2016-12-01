IBDEI012 ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,811,1,4,0)
 ;;=4^F15.10
 ;;^UTILITY(U,$J,358.3,811,2)
 ;;=^5003282
 ;;^UTILITY(U,$J,358.3,812,0)
 ;;=F15.20^^3^64^73
 ;;^UTILITY(U,$J,358.3,812,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,812,1,3,0)
 ;;=3^Other or Unspecified Stimulant Use D/O, Moderate
 ;;^UTILITY(U,$J,358.3,812,1,4,0)
 ;;=4^F15.20
 ;;^UTILITY(U,$J,358.3,812,2)
 ;;=^5003295
 ;;^UTILITY(U,$J,358.3,813,0)
 ;;=F15.20^^3^64^74
 ;;^UTILITY(U,$J,358.3,813,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,813,1,3,0)
 ;;=3^Other or Unspecified Stimulant Use D/O, Severe
 ;;^UTILITY(U,$J,358.3,813,1,4,0)
 ;;=4^F15.20
 ;;^UTILITY(U,$J,358.3,813,2)
 ;;=^5003295
 ;;^UTILITY(U,$J,358.3,814,0)
 ;;=F15.99^^3^64^35
 ;;^UTILITY(U,$J,358.3,814,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,814,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Related D/O,Unspec
 ;;^UTILITY(U,$J,358.3,814,1,4,0)
 ;;=4^F15.99
 ;;^UTILITY(U,$J,358.3,814,2)
 ;;=^5133358
 ;;^UTILITY(U,$J,358.3,815,0)
 ;;=F14.99^^3^64^67
 ;;^UTILITY(U,$J,358.3,815,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,815,1,3,0)
 ;;=3^Cocaine Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,815,1,4,0)
 ;;=4^F14.99
 ;;^UTILITY(U,$J,358.3,815,2)
 ;;=^5133354
 ;;^UTILITY(U,$J,358.3,816,0)
 ;;=F14.99^^3^64^75
 ;;^UTILITY(U,$J,358.3,816,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,816,1,3,0)
 ;;=3^Stimulant Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,816,1,4,0)
 ;;=4^F14.99
 ;;^UTILITY(U,$J,358.3,816,2)
 ;;=^5133354
 ;;^UTILITY(U,$J,358.3,817,0)
 ;;=F15.180^^3^64^4
 ;;^UTILITY(U,$J,358.3,817,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,817,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Anxiety D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,817,1,4,0)
 ;;=4^F15.180
 ;;^UTILITY(U,$J,358.3,817,2)
 ;;=^5003291
 ;;^UTILITY(U,$J,358.3,818,0)
 ;;=F15.280^^3^64^5
 ;;^UTILITY(U,$J,358.3,818,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,818,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Anxiety D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,818,1,4,0)
 ;;=4^F15.280
 ;;^UTILITY(U,$J,358.3,818,2)
 ;;=^5003306
 ;;^UTILITY(U,$J,358.3,819,0)
 ;;=F15.980^^3^64^6
 ;;^UTILITY(U,$J,358.3,819,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,819,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Anxiety D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,819,1,4,0)
 ;;=4^F15.980
 ;;^UTILITY(U,$J,358.3,819,2)
 ;;=^5003320
 ;;^UTILITY(U,$J,358.3,820,0)
 ;;=F15.14^^3^64^7
 ;;^UTILITY(U,$J,358.3,820,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,820,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Bipolar & Rel D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,820,1,4,0)
 ;;=4^F15.14
 ;;^UTILITY(U,$J,358.3,820,2)
 ;;=^5003287
 ;;^UTILITY(U,$J,358.3,821,0)
 ;;=F15.24^^3^64^8
 ;;^UTILITY(U,$J,358.3,821,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,821,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Bipolar & Rel D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,821,1,4,0)
 ;;=4^F15.24
 ;;^UTILITY(U,$J,358.3,821,2)
 ;;=^5003302
 ;;^UTILITY(U,$J,358.3,822,0)
 ;;=F15.94^^3^64^9
 ;;^UTILITY(U,$J,358.3,822,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,822,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Bipolar & Rel D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,822,1,4,0)
 ;;=4^F15.94
 ;;^UTILITY(U,$J,358.3,822,2)
 ;;=^5003316
 ;;^UTILITY(U,$J,358.3,823,0)
 ;;=F15.921^^3^64^10
 ;;^UTILITY(U,$J,358.3,823,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,823,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Delirium
 ;;^UTILITY(U,$J,358.3,823,1,4,0)
 ;;=4^F15.921
 ;;^UTILITY(U,$J,358.3,823,2)
 ;;=^5003312
 ;;^UTILITY(U,$J,358.3,824,0)
 ;;=F15.14^^3^64^11
 ;;^UTILITY(U,$J,358.3,824,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,824,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Depressive D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,824,1,4,0)
 ;;=4^F15.14
 ;;^UTILITY(U,$J,358.3,824,2)
 ;;=^5003287
 ;;^UTILITY(U,$J,358.3,825,0)
 ;;=F15.24^^3^64^12
 ;;^UTILITY(U,$J,358.3,825,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,825,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Depressive D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,825,1,4,0)
 ;;=4^F15.24
 ;;^UTILITY(U,$J,358.3,825,2)
 ;;=^5003302
 ;;^UTILITY(U,$J,358.3,826,0)
 ;;=F15.94^^3^64^13
 ;;^UTILITY(U,$J,358.3,826,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,826,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Depressive D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,826,1,4,0)
 ;;=4^F15.94
 ;;^UTILITY(U,$J,358.3,826,2)
 ;;=^5003316
 ;;^UTILITY(U,$J,358.3,827,0)
 ;;=F15.188^^3^64^14
 ;;^UTILITY(U,$J,358.3,827,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,827,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Obess-Compul & Rel D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,827,1,4,0)
 ;;=4^F15.188
 ;;^UTILITY(U,$J,358.3,827,2)
 ;;=^5133355
 ;;^UTILITY(U,$J,358.3,828,0)
 ;;=F15.288^^3^64^15
 ;;^UTILITY(U,$J,358.3,828,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,828,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Obess-Compul & Rel D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,828,1,4,0)
 ;;=4^F15.288
 ;;^UTILITY(U,$J,358.3,828,2)
 ;;=^5133356
 ;;^UTILITY(U,$J,358.3,829,0)
 ;;=F15.988^^3^64^16
 ;;^UTILITY(U,$J,358.3,829,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,829,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Obess-Compul & Rel D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,829,1,4,0)
 ;;=4^F15.988
 ;;^UTILITY(U,$J,358.3,829,2)
 ;;=^5133357
 ;;^UTILITY(U,$J,358.3,830,0)
 ;;=F15.159^^3^64^17
 ;;^UTILITY(U,$J,358.3,830,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,830,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Psychotic D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,830,1,4,0)
 ;;=4^F15.159
 ;;^UTILITY(U,$J,358.3,830,2)
 ;;=^5003290
 ;;^UTILITY(U,$J,358.3,831,0)
 ;;=F15.259^^3^64^18
 ;;^UTILITY(U,$J,358.3,831,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,831,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Psychotic D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,831,1,4,0)
 ;;=4^F15.259
 ;;^UTILITY(U,$J,358.3,831,2)
 ;;=^5003305
 ;;^UTILITY(U,$J,358.3,832,0)
 ;;=F15.959^^3^64^19
 ;;^UTILITY(U,$J,358.3,832,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,832,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Psychotic D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,832,1,4,0)
 ;;=4^F15.959
 ;;^UTILITY(U,$J,358.3,832,2)
 ;;=^5003319
 ;;^UTILITY(U,$J,358.3,833,0)
 ;;=F15.181^^3^64^20
 ;;^UTILITY(U,$J,358.3,833,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,833,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Sexual Dysfunction w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,833,1,4,0)
 ;;=4^F15.181
 ;;^UTILITY(U,$J,358.3,833,2)
 ;;=^5003292
 ;;^UTILITY(U,$J,358.3,834,0)
 ;;=F15.281^^3^64^21
 ;;^UTILITY(U,$J,358.3,834,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,834,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Sexual Dysfunction w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,834,1,4,0)
 ;;=4^F15.281
 ;;^UTILITY(U,$J,358.3,834,2)
 ;;=^5003307
 ;;^UTILITY(U,$J,358.3,835,0)
 ;;=F15.981^^3^64^22
 ;;^UTILITY(U,$J,358.3,835,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,835,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Sexual Dysfunction w/o Use D/O
 ;;^UTILITY(U,$J,358.3,835,1,4,0)
 ;;=4^F15.981
 ;;^UTILITY(U,$J,358.3,835,2)
 ;;=^5003321
 ;;^UTILITY(U,$J,358.3,836,0)
 ;;=F15.182^^3^64^23
 ;;^UTILITY(U,$J,358.3,836,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,836,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Sleep D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,836,1,4,0)
 ;;=4^F15.182
 ;;^UTILITY(U,$J,358.3,836,2)
 ;;=^5003293
 ;;^UTILITY(U,$J,358.3,837,0)
 ;;=F15.282^^3^64^24
 ;;^UTILITY(U,$J,358.3,837,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,837,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Sleep D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,837,1,4,0)
 ;;=4^F15.282
 ;;^UTILITY(U,$J,358.3,837,2)
 ;;=^5003308
 ;;^UTILITY(U,$J,358.3,838,0)
 ;;=F15.982^^3^64^25
 ;;^UTILITY(U,$J,358.3,838,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,838,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Sleep D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,838,1,4,0)
 ;;=4^F15.982
 ;;^UTILITY(U,$J,358.3,838,2)
 ;;=^5003322
 ;;^UTILITY(U,$J,358.3,839,0)
 ;;=F15.122^^3^64^29
 ;;^UTILITY(U,$J,358.3,839,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,839,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Intoxication w/ Percept Disturb w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,839,1,4,0)
 ;;=4^F15.122
 ;;^UTILITY(U,$J,358.3,839,2)
 ;;=^5003285
 ;;^UTILITY(U,$J,358.3,840,0)
 ;;=F15.222^^3^64^30
 ;;^UTILITY(U,$J,358.3,840,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,840,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Intoxication w/ Percept Disturb w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,840,1,4,0)
 ;;=4^F15.222
 ;;^UTILITY(U,$J,358.3,840,2)
 ;;=^5003299
 ;;^UTILITY(U,$J,358.3,841,0)
 ;;=F15.922^^3^64^31
 ;;^UTILITY(U,$J,358.3,841,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,841,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Intoxication w/ Percept Disturb w/o Use D/O
 ;;^UTILITY(U,$J,358.3,841,1,4,0)
 ;;=4^F15.922
 ;;^UTILITY(U,$J,358.3,841,2)
 ;;=^5003313
 ;;^UTILITY(U,$J,358.3,842,0)
 ;;=F15.129^^3^64^32
 ;;^UTILITY(U,$J,358.3,842,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,842,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Intoxication w/o  Percept Disturb w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,842,1,4,0)
 ;;=4^F15.129
 ;;^UTILITY(U,$J,358.3,842,2)
 ;;=^5003286
 ;;^UTILITY(U,$J,358.3,843,0)
 ;;=F15.229^^3^64^33
 ;;^UTILITY(U,$J,358.3,843,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,843,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Intoxication w/o  Percept Disturb w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,843,1,4,0)
 ;;=4^F15.229
 ;;^UTILITY(U,$J,358.3,843,2)
 ;;=^5003300
 ;;^UTILITY(U,$J,358.3,844,0)
 ;;=F15.929^^3^64^34
 ;;^UTILITY(U,$J,358.3,844,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,844,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Intoxication w/o Percept Disturb w/o Use D/O
 ;;^UTILITY(U,$J,358.3,844,1,4,0)
 ;;=4^F15.929

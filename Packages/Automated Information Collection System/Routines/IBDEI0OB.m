IBDEI0OB ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24504,1,4,0)
 ;;=4^F15.24
 ;;^UTILITY(U,$J,358.3,24504,2)
 ;;=^5003302
 ;;^UTILITY(U,$J,358.3,24505,0)
 ;;=F15.94^^92^1142^9
 ;;^UTILITY(U,$J,358.3,24505,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24505,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Bipolar & Rel D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,24505,1,4,0)
 ;;=4^F15.94
 ;;^UTILITY(U,$J,358.3,24505,2)
 ;;=^5003316
 ;;^UTILITY(U,$J,358.3,24506,0)
 ;;=F15.921^^92^1142^10
 ;;^UTILITY(U,$J,358.3,24506,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24506,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Delirium
 ;;^UTILITY(U,$J,358.3,24506,1,4,0)
 ;;=4^F15.921
 ;;^UTILITY(U,$J,358.3,24506,2)
 ;;=^5003312
 ;;^UTILITY(U,$J,358.3,24507,0)
 ;;=F15.14^^92^1142^11
 ;;^UTILITY(U,$J,358.3,24507,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24507,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Depressive D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,24507,1,4,0)
 ;;=4^F15.14
 ;;^UTILITY(U,$J,358.3,24507,2)
 ;;=^5003287
 ;;^UTILITY(U,$J,358.3,24508,0)
 ;;=F15.24^^92^1142^12
 ;;^UTILITY(U,$J,358.3,24508,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24508,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Depressive D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,24508,1,4,0)
 ;;=4^F15.24
 ;;^UTILITY(U,$J,358.3,24508,2)
 ;;=^5003302
 ;;^UTILITY(U,$J,358.3,24509,0)
 ;;=F15.94^^92^1142^13
 ;;^UTILITY(U,$J,358.3,24509,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24509,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Depressive D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,24509,1,4,0)
 ;;=4^F15.94
 ;;^UTILITY(U,$J,358.3,24509,2)
 ;;=^5003316
 ;;^UTILITY(U,$J,358.3,24510,0)
 ;;=F15.188^^92^1142^14
 ;;^UTILITY(U,$J,358.3,24510,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24510,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Obess-Compul & Rel D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,24510,1,4,0)
 ;;=4^F15.188
 ;;^UTILITY(U,$J,358.3,24510,2)
 ;;=^5133355
 ;;^UTILITY(U,$J,358.3,24511,0)
 ;;=F15.288^^92^1142^15
 ;;^UTILITY(U,$J,358.3,24511,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24511,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Obess-Compul & Rel D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,24511,1,4,0)
 ;;=4^F15.288
 ;;^UTILITY(U,$J,358.3,24511,2)
 ;;=^5133356
 ;;^UTILITY(U,$J,358.3,24512,0)
 ;;=F15.988^^92^1142^16
 ;;^UTILITY(U,$J,358.3,24512,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24512,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Obess-Compul & Rel D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,24512,1,4,0)
 ;;=4^F15.988
 ;;^UTILITY(U,$J,358.3,24512,2)
 ;;=^5133357
 ;;^UTILITY(U,$J,358.3,24513,0)
 ;;=F15.159^^92^1142^17
 ;;^UTILITY(U,$J,358.3,24513,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24513,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Psychotic D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,24513,1,4,0)
 ;;=4^F15.159
 ;;^UTILITY(U,$J,358.3,24513,2)
 ;;=^5003290
 ;;^UTILITY(U,$J,358.3,24514,0)
 ;;=F15.259^^92^1142^18
 ;;^UTILITY(U,$J,358.3,24514,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24514,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Psychotic D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,24514,1,4,0)
 ;;=4^F15.259
 ;;^UTILITY(U,$J,358.3,24514,2)
 ;;=^5003305
 ;;^UTILITY(U,$J,358.3,24515,0)
 ;;=F15.959^^92^1142^19
 ;;^UTILITY(U,$J,358.3,24515,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24515,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Psychotic D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,24515,1,4,0)
 ;;=4^F15.959
 ;;^UTILITY(U,$J,358.3,24515,2)
 ;;=^5003319
 ;;^UTILITY(U,$J,358.3,24516,0)
 ;;=F15.181^^92^1142^20
 ;;^UTILITY(U,$J,358.3,24516,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24516,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Sexual Dysfunction w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,24516,1,4,0)
 ;;=4^F15.181
 ;;^UTILITY(U,$J,358.3,24516,2)
 ;;=^5003292
 ;;^UTILITY(U,$J,358.3,24517,0)
 ;;=F15.281^^92^1142^21
 ;;^UTILITY(U,$J,358.3,24517,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24517,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Sexual Dysfunction w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,24517,1,4,0)
 ;;=4^F15.281
 ;;^UTILITY(U,$J,358.3,24517,2)
 ;;=^5003307
 ;;^UTILITY(U,$J,358.3,24518,0)
 ;;=F15.981^^92^1142^22
 ;;^UTILITY(U,$J,358.3,24518,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24518,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Sexual Dysfunction w/o Use D/O
 ;;^UTILITY(U,$J,358.3,24518,1,4,0)
 ;;=4^F15.981
 ;;^UTILITY(U,$J,358.3,24518,2)
 ;;=^5003321
 ;;^UTILITY(U,$J,358.3,24519,0)
 ;;=F15.182^^92^1142^23
 ;;^UTILITY(U,$J,358.3,24519,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24519,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Sleep D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,24519,1,4,0)
 ;;=4^F15.182
 ;;^UTILITY(U,$J,358.3,24519,2)
 ;;=^5003293
 ;;^UTILITY(U,$J,358.3,24520,0)
 ;;=F15.282^^92^1142^24
 ;;^UTILITY(U,$J,358.3,24520,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24520,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Sleep D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,24520,1,4,0)
 ;;=4^F15.282
 ;;^UTILITY(U,$J,358.3,24520,2)
 ;;=^5003308
 ;;^UTILITY(U,$J,358.3,24521,0)
 ;;=F15.982^^92^1142^25
 ;;^UTILITY(U,$J,358.3,24521,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24521,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Sleep D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,24521,1,4,0)
 ;;=4^F15.982
 ;;^UTILITY(U,$J,358.3,24521,2)
 ;;=^5003322
 ;;^UTILITY(U,$J,358.3,24522,0)
 ;;=F15.122^^92^1142^29
 ;;^UTILITY(U,$J,358.3,24522,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24522,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Intoxication w/ Percept Disturb w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,24522,1,4,0)
 ;;=4^F15.122
 ;;^UTILITY(U,$J,358.3,24522,2)
 ;;=^5003285
 ;;^UTILITY(U,$J,358.3,24523,0)
 ;;=F15.222^^92^1142^30
 ;;^UTILITY(U,$J,358.3,24523,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24523,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Intoxication w/ Percept Disturb w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,24523,1,4,0)
 ;;=4^F15.222
 ;;^UTILITY(U,$J,358.3,24523,2)
 ;;=^5003299
 ;;^UTILITY(U,$J,358.3,24524,0)
 ;;=F15.922^^92^1142^31
 ;;^UTILITY(U,$J,358.3,24524,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24524,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Intoxication w/ Percept Disturb w/o Use D/O
 ;;^UTILITY(U,$J,358.3,24524,1,4,0)
 ;;=4^F15.922
 ;;^UTILITY(U,$J,358.3,24524,2)
 ;;=^5003313
 ;;^UTILITY(U,$J,358.3,24525,0)
 ;;=F15.129^^92^1142^32
 ;;^UTILITY(U,$J,358.3,24525,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24525,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Intoxication w/o  Percept Disturb w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,24525,1,4,0)
 ;;=4^F15.129
 ;;^UTILITY(U,$J,358.3,24525,2)
 ;;=^5003286
 ;;^UTILITY(U,$J,358.3,24526,0)
 ;;=F15.229^^92^1142^33
 ;;^UTILITY(U,$J,358.3,24526,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24526,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Intoxication w/o  Percept Disturb w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,24526,1,4,0)
 ;;=4^F15.229
 ;;^UTILITY(U,$J,358.3,24526,2)
 ;;=^5003300
 ;;^UTILITY(U,$J,358.3,24527,0)
 ;;=F15.929^^92^1142^34
 ;;^UTILITY(U,$J,358.3,24527,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24527,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Intoxication w/o Percept Disturb w/o Use D/O
 ;;^UTILITY(U,$J,358.3,24527,1,4,0)
 ;;=4^F15.929
 ;;^UTILITY(U,$J,358.3,24527,2)
 ;;=^5003314
 ;;^UTILITY(U,$J,358.3,24528,0)
 ;;=F15.121^^92^1142^26
 ;;^UTILITY(U,$J,358.3,24528,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24528,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Intox Delirium  w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,24528,1,4,0)
 ;;=4^F15.121
 ;;^UTILITY(U,$J,358.3,24528,2)
 ;;=^5003284
 ;;^UTILITY(U,$J,358.3,24529,0)
 ;;=F15.221^^92^1142^27
 ;;^UTILITY(U,$J,358.3,24529,1,0)
 ;;=^358.31IA^4^2

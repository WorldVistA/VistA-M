IBDEI10X ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,37131,1,4,0)
 ;;=4^F15.20
 ;;^UTILITY(U,$J,358.3,37131,2)
 ;;=^5003295
 ;;^UTILITY(U,$J,358.3,37132,0)
 ;;=F15.20^^135^1838^74
 ;;^UTILITY(U,$J,358.3,37132,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37132,1,3,0)
 ;;=3^Other or Unspecified Stimulant Use D/O, Severe
 ;;^UTILITY(U,$J,358.3,37132,1,4,0)
 ;;=4^F15.20
 ;;^UTILITY(U,$J,358.3,37132,2)
 ;;=^5003295
 ;;^UTILITY(U,$J,358.3,37133,0)
 ;;=F15.99^^135^1838^35
 ;;^UTILITY(U,$J,358.3,37133,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37133,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Related D/O,Unspec
 ;;^UTILITY(U,$J,358.3,37133,1,4,0)
 ;;=4^F15.99
 ;;^UTILITY(U,$J,358.3,37133,2)
 ;;=^5133358
 ;;^UTILITY(U,$J,358.3,37134,0)
 ;;=F14.99^^135^1838^67
 ;;^UTILITY(U,$J,358.3,37134,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37134,1,3,0)
 ;;=3^Cocaine Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,37134,1,4,0)
 ;;=4^F14.99
 ;;^UTILITY(U,$J,358.3,37134,2)
 ;;=^5133354
 ;;^UTILITY(U,$J,358.3,37135,0)
 ;;=F14.99^^135^1838^75
 ;;^UTILITY(U,$J,358.3,37135,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37135,1,3,0)
 ;;=3^Stimulant Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,37135,1,4,0)
 ;;=4^F14.99
 ;;^UTILITY(U,$J,358.3,37135,2)
 ;;=^5133354
 ;;^UTILITY(U,$J,358.3,37136,0)
 ;;=F15.180^^135^1838^4
 ;;^UTILITY(U,$J,358.3,37136,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37136,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Anxiety D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,37136,1,4,0)
 ;;=4^F15.180
 ;;^UTILITY(U,$J,358.3,37136,2)
 ;;=^5003291
 ;;^UTILITY(U,$J,358.3,37137,0)
 ;;=F15.280^^135^1838^5
 ;;^UTILITY(U,$J,358.3,37137,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37137,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Anxiety D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,37137,1,4,0)
 ;;=4^F15.280
 ;;^UTILITY(U,$J,358.3,37137,2)
 ;;=^5003306
 ;;^UTILITY(U,$J,358.3,37138,0)
 ;;=F15.980^^135^1838^6
 ;;^UTILITY(U,$J,358.3,37138,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37138,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Anxiety D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,37138,1,4,0)
 ;;=4^F15.980
 ;;^UTILITY(U,$J,358.3,37138,2)
 ;;=^5003320
 ;;^UTILITY(U,$J,358.3,37139,0)
 ;;=F15.14^^135^1838^7
 ;;^UTILITY(U,$J,358.3,37139,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37139,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Bipolar & Rel D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,37139,1,4,0)
 ;;=4^F15.14
 ;;^UTILITY(U,$J,358.3,37139,2)
 ;;=^5003287
 ;;^UTILITY(U,$J,358.3,37140,0)
 ;;=F15.24^^135^1838^8
 ;;^UTILITY(U,$J,358.3,37140,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37140,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Bipolar & Rel D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,37140,1,4,0)
 ;;=4^F15.24
 ;;^UTILITY(U,$J,358.3,37140,2)
 ;;=^5003302
 ;;^UTILITY(U,$J,358.3,37141,0)
 ;;=F15.94^^135^1838^9
 ;;^UTILITY(U,$J,358.3,37141,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37141,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Bipolar & Rel D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,37141,1,4,0)
 ;;=4^F15.94
 ;;^UTILITY(U,$J,358.3,37141,2)
 ;;=^5003316
 ;;^UTILITY(U,$J,358.3,37142,0)
 ;;=F15.921^^135^1838^10
 ;;^UTILITY(U,$J,358.3,37142,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37142,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Delirium
 ;;^UTILITY(U,$J,358.3,37142,1,4,0)
 ;;=4^F15.921
 ;;^UTILITY(U,$J,358.3,37142,2)
 ;;=^5003312
 ;;^UTILITY(U,$J,358.3,37143,0)
 ;;=F15.14^^135^1838^11
 ;;^UTILITY(U,$J,358.3,37143,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37143,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Depressive D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,37143,1,4,0)
 ;;=4^F15.14
 ;;^UTILITY(U,$J,358.3,37143,2)
 ;;=^5003287
 ;;^UTILITY(U,$J,358.3,37144,0)
 ;;=F15.24^^135^1838^12
 ;;^UTILITY(U,$J,358.3,37144,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37144,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Depressive D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,37144,1,4,0)
 ;;=4^F15.24
 ;;^UTILITY(U,$J,358.3,37144,2)
 ;;=^5003302
 ;;^UTILITY(U,$J,358.3,37145,0)
 ;;=F15.94^^135^1838^13
 ;;^UTILITY(U,$J,358.3,37145,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37145,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Depressive D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,37145,1,4,0)
 ;;=4^F15.94
 ;;^UTILITY(U,$J,358.3,37145,2)
 ;;=^5003316
 ;;^UTILITY(U,$J,358.3,37146,0)
 ;;=F15.188^^135^1838^14
 ;;^UTILITY(U,$J,358.3,37146,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37146,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Obess-Compul & Rel D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,37146,1,4,0)
 ;;=4^F15.188
 ;;^UTILITY(U,$J,358.3,37146,2)
 ;;=^5133355
 ;;^UTILITY(U,$J,358.3,37147,0)
 ;;=F15.288^^135^1838^15
 ;;^UTILITY(U,$J,358.3,37147,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37147,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Obess-Compul & Rel D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,37147,1,4,0)
 ;;=4^F15.288
 ;;^UTILITY(U,$J,358.3,37147,2)
 ;;=^5133356
 ;;^UTILITY(U,$J,358.3,37148,0)
 ;;=F15.988^^135^1838^16
 ;;^UTILITY(U,$J,358.3,37148,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37148,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Obess-Compul & Rel D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,37148,1,4,0)
 ;;=4^F15.988
 ;;^UTILITY(U,$J,358.3,37148,2)
 ;;=^5133357
 ;;^UTILITY(U,$J,358.3,37149,0)
 ;;=F15.159^^135^1838^17
 ;;^UTILITY(U,$J,358.3,37149,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37149,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Psychotic D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,37149,1,4,0)
 ;;=4^F15.159
 ;;^UTILITY(U,$J,358.3,37149,2)
 ;;=^5003290
 ;;^UTILITY(U,$J,358.3,37150,0)
 ;;=F15.259^^135^1838^18
 ;;^UTILITY(U,$J,358.3,37150,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37150,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Psychotic D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,37150,1,4,0)
 ;;=4^F15.259
 ;;^UTILITY(U,$J,358.3,37150,2)
 ;;=^5003305
 ;;^UTILITY(U,$J,358.3,37151,0)
 ;;=F15.959^^135^1838^19
 ;;^UTILITY(U,$J,358.3,37151,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37151,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Psychotic D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,37151,1,4,0)
 ;;=4^F15.959
 ;;^UTILITY(U,$J,358.3,37151,2)
 ;;=^5003319
 ;;^UTILITY(U,$J,358.3,37152,0)
 ;;=F15.181^^135^1838^20
 ;;^UTILITY(U,$J,358.3,37152,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37152,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Sexual Dysfunction w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,37152,1,4,0)
 ;;=4^F15.181
 ;;^UTILITY(U,$J,358.3,37152,2)
 ;;=^5003292
 ;;^UTILITY(U,$J,358.3,37153,0)
 ;;=F15.281^^135^1838^21
 ;;^UTILITY(U,$J,358.3,37153,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37153,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Sexual Dysfunction w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,37153,1,4,0)
 ;;=4^F15.281
 ;;^UTILITY(U,$J,358.3,37153,2)
 ;;=^5003307
 ;;^UTILITY(U,$J,358.3,37154,0)
 ;;=F15.981^^135^1838^22
 ;;^UTILITY(U,$J,358.3,37154,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37154,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Sexual Dysfunction w/o Use D/O
 ;;^UTILITY(U,$J,358.3,37154,1,4,0)
 ;;=4^F15.981
 ;;^UTILITY(U,$J,358.3,37154,2)
 ;;=^5003321
 ;;^UTILITY(U,$J,358.3,37155,0)
 ;;=F15.182^^135^1838^23
 ;;^UTILITY(U,$J,358.3,37155,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37155,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Sleep D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,37155,1,4,0)
 ;;=4^F15.182
 ;;^UTILITY(U,$J,358.3,37155,2)
 ;;=^5003293
 ;;^UTILITY(U,$J,358.3,37156,0)
 ;;=F15.282^^135^1838^24
 ;;^UTILITY(U,$J,358.3,37156,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37156,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Sleep D/O w/ Mod-Sev Use D/O
